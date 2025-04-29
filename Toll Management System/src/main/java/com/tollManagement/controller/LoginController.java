package com.tollManagement.controller;

import java.io.IOException;
import java.util.logging.Level;
import java.util.logging.Logger;

import com.tollManagement.model.UserModel;
import com.tollManagement.service.LoginService;
import com.tollManagement.util.CookieUtil;
import com.tollManagement.util.SessionUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * LoginController handles login requests for the Toll Management System.
 * It delegates authentication logic to the LoginService and handles session and cookie setup.
 * 
 * Author: Samir Yadav
 * LMU ID: 23048505
 */
@WebServlet(asyncSupported = true, urlPatterns = { "/login" })
public class LoginController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final Logger logger = Logger.getLogger(LoginController.class.getName());

    private final LoginService loginService;

    public LoginController() {
        this.loginService = new LoginService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/pages/common/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        if (username == null || password == null || username.trim().isEmpty() || password.trim().isEmpty()) {
            handleLoginFailure(request, response, "Username and password are required.");
            return;
        }

        try {
            UserModel userModel = new UserModel(username, password);
            boolean loginStatus = loginService.loginUser(userModel);

            if (loginStatus) {
                String role = loginService.getUserRole(username);
                SessionUtil.setAttribute(request, "username", username);
                SessionUtil.setAttribute(request, "role", role);

                // Cookie setup
                CookieUtil.addCookie(response, "userRole", role, 5 * 30);

                // Redirection logic
                String redirectPath = switch (role.toLowerCase()) {
                    case "admin" -> "/admin/dashboard";
                    case "commercial" -> "/customer/dashboard";
                    default -> "/customer/dashboard";
                };

                response.sendRedirect(request.getContextPath() + redirectPath);
            } else {
                handleLoginFailure(request, response, "Invalid username or password.");
            }

        } catch (Exception e) {
            logger.log(Level.SEVERE, "Login failed for user: " + username, e);
            handleLoginFailure(request, response, "An internal error occurred. Please try again.");
        }
    }

    private void handleLoginFailure(HttpServletRequest request, HttpServletResponse response, String errorMessage)
            throws ServletException, IOException {
        request.setAttribute("error", errorMessage);
        request.getRequestDispatcher("/WEB-INF/pages/common/login.jsp").forward(request, response);
    }
}

package com.tollManagement.controller;

import java.io.IOException;  

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.HashMap;
import java.util.Map;

import com.tollManagement.model.UserModel;
import com.tollManagement.service.LoginService;
import com.tollManagement.util.CookieUtil;
import com.tollManagement.util.SessionUtil;
import com.tollManagement.config.DbConfig;

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
                String account_type = loginService.getUserRole(username);
                
                // Fetch complete user data
                try (Connection conn = DbConfig.getDbConnection()) {
                    String query = "SELECT * FROM User WHERE username = ?";
                    try (PreparedStatement stmt = conn.prepareStatement(query)) {
                        stmt.setString(1, username);
                        ResultSet rs = stmt.executeQuery();
                        if (rs.next()) {
                            UserModel user = new UserModel();
                            user.setUsername(rs.getString("username"));
                            user.setPassword(rs.getString("password"));
                            user.setAccountType(rs.getString("account_type"));
                            user.setFirstName(rs.getString("first_name"));
                            user.setLastName(rs.getString("last_name"));
                            user.setEmail(rs.getString("email"));
                            user.setPhone(rs.getString("phone"));
                            user.setProvince(rs.getString("province"));
                            user.setPostalCode(rs.getString("postal_code"));
                            user.setCitizenshipNumber(rs.getString("citizenship_number"));
                            
                            SessionUtil.setAttribute(request, "user", user);
                        }
                    }

                    // Fetch vehicle data separately
                    String vehicleQuery = "SELECT * FROM vehicle WHERE username = ?";
                    try (PreparedStatement stmt = conn.prepareStatement(vehicleQuery)) {
                        stmt.setString(1, username);
                        ResultSet rs = stmt.executeQuery();
                        if (rs.next()) {
                            Map<String, Object> vehicleDetails = new HashMap<>();
                            vehicleDetails.put("vehicleType", rs.getString("vehicle_type"));
                            vehicleDetails.put("vehicleNumber", rs.getString("vehicle_number"));
                            vehicleDetails.put("totalTollPaid", rs.getDouble("total_toll_paid"));
                            vehicleDetails.put("lastTollDate", rs.getTimestamp("last_toll_date"));
                            vehicleDetails.put("monthlyPassExpiry", rs.getDate("monthly_pass_expiry"));
                            
                            SessionUtil.setAttribute(request, "vehicle", vehicleDetails);
                        }
                    }
                } catch (SQLException | ClassNotFoundException e) {
                    logger.log(Level.SEVERE, "Error fetching user data", e);
                }
                
                SessionUtil.setAttribute(request, "username", username);
                SessionUtil.setAttribute(request, "account_type", account_type);

                // Cookie setup
                CookieUtil.addCookie(response, "account_type", account_type, 5 * 30);

                // Redirection logic
                String redirectPath = switch (account_type.toLowerCase()) {
                    case "admin" -> "/AdminDashboard";
                    case "commercial" -> "/CustomerDashboard";
                    default -> "/CustomerDashboard";
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

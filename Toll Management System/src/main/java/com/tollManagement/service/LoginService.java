package com.tollManagement.service;

import jakarta.servlet.ServletException; 
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

import com.tollManagement.config.DbConfig;
import com.tollManagement.controller.LoginController;
import com.tollManagement.model.UserModel;
import com.tollManagement.util.PasswordUtil;

/**
 * Servlet implementation class LoginService
 */
@WebServlet(asyncSupported = true, urlPatterns = { "/LoginService" })
public class LoginService extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final Logger logger = Logger.getLogger(LoginController.class.getName());

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Redirect GET requests to login page (prevent direct access)
        response.sendRedirect(request.getContextPath() + "/login.jsp");
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        
        // Basic input validation
        if (username == null || username.trim().isEmpty() || 
            password == null || password.trim().isEmpty()) {
            request.setAttribute("error", "Username and password are required");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
            return;
        }

        try {
            // Authenticate user
            UserModel authenticatedUser = authenticateUser(username, password);
            
            if (authenticatedUser != null) {
                // Create session
                HttpSession session = request.getSession();
                session.setAttribute("user", authenticatedUser);
                
                // Redirect based on user type
                redirectBasedOnUserType(authenticatedUser.getAccountType(), request, response);
            } else {
                // Authentication failed
                request.setAttribute("error", "Invalid username or password");
                request.getRequestDispatcher("/login.jsp").forward(request, response);
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            request.setAttribute("error", "Database error occurred. Please try again later.");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
        }
    }

    private UserModel authenticateUser(String username, String password) 
            throws SQLException, ClassNotFoundException {
        String query = "SELECT username, password, account_type, first_name, last_name, email, phone, province, postal_code, citizenship_number FROM User WHERE username = ?";
        
        try (Connection conn = DbConfig.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            
            stmt.setString(1, username);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                String dbUsername = rs.getString("username");
                String dbPassword = rs.getString("password");
                String account_type = rs.getString("account_type");
                String firstName = rs.getString("first_name");
                String lastName = rs.getString("last_name");
                String email = rs.getString("email");
                String phone = rs.getString("phone");
                String province = rs.getString("province");
                String postalCode = rs.getString("postal_code");
                String citizenshipNumber = rs.getString("citizenship_number");
                
                // Verify password
                if (PasswordUtil.verifyPassword(password, dbPassword)) {
                    // Create and return UserModel object
                    UserModel user = new UserModel(dbUsername, dbPassword, account_type, 
                                                 firstName, lastName, email, phone, 
                                                 province, postalCode, citizenshipNumber);
                    return user;
                }
            }
            return null;
        }
    }

    private void redirectBasedOnUserType(String role, HttpServletRequest request, 
            HttpServletResponse response) throws IOException {
        String redirectPath = request.getContextPath();
        
        switch (role.toLowerCase()) {
            case "admin":
                redirectPath += "/AdminDashboard";
                break;
            case "commercial":
                redirectPath += "/CustomerDashboard";
                break;
            default: // customer
                redirectPath += "/CustomerDashboard";
        }
        response.sendRedirect(redirectPath);
    }

    public boolean loginUser(UserModel userModel) {
        String query = "SELECT password, account_type FROM User WHERE username = ?";
        
        try (Connection conn = DbConfig.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
             
            stmt.setString(1, userModel.getUsername());
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                String dbPassword = rs.getString("password");
                // Verify raw input against hashed DB password
                return PasswordUtil.verifyPassword(userModel.getPassword(), dbPassword);
            }
        } catch (SQLException | ClassNotFoundException e) {
            logger.log(Level.SEVERE, "Database error during login", e);
        }
        return false;
    }

    public String getUserRole(String username) {
        String query = "SELECT account_type FROM User WHERE username = ?";

        try (Connection conn = DbConfig.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setString(1, username);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return rs.getString("account_type");
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }

        return null;
    }
}

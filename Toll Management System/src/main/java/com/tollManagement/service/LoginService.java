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

import com.tollManagement.config.DbConfig;
import com.tollManagement.model.UserModel;
import com.tollManagement.util.PasswordUtil;

/**
 * Servlet implementation class LoginService
 */
@WebServlet(asyncSupported = true, urlPatterns = { "/LoginService" })
public class LoginService extends HttpServlet {
    private static final long serialVersionUID = 1L;

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
        String query = "SELECT username, password, role, first_name, last_name, email, phone, province, postal_code, vehicle_type, vehicle_number FROM users WHERE username = ?";
        
        try (Connection conn = DbConfig.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            
            stmt.setString(1, username);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                String dbUsername = rs.getString("username");
                String dbPassword = rs.getString("password");
                String role = rs.getString("role");
                String firstName = rs.getString("first_name");
                String lastName = rs.getString("last_name");
                String email = rs.getString("email");
                String phone = rs.getString("phone");
                String province = rs.getString("province");
                String postalCode = rs.getString("postal_code");
                String vehicleType = rs.getString("vehicle_type");
                String vehicleNumber = rs.getString("vehicle_number");
                String citizenshipNumber = rs.getString("citizenship_number");

                
                // Verify password (assuming PasswordUtil handles hashing/encryption)
                if (PasswordUtil.verifyPassword(password, dbPassword)) {
                    // Create and return UserModel object
                    UserModel user = new UserModel(dbUsername, dbPassword, role, firstName, lastName, email, phone, province, postalCode, vehicleType, vehicleNumber,citizenshipNumber);
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
                redirectPath += "/admin/dashboard.jsp";
                break;
            case "commercial":
                redirectPath += "/commercial/dashboard.jsp";
                break;
            default: // customer
                redirectPath += "/customer/dashboard.jsp";
        }
        response.sendRedirect(redirectPath);
    }

    public boolean loginUser(UserModel userModel) {
        String query = "SELECT password FROM users WHERE username = ?";

        try (Connection conn = DbConfig.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
             
            stmt.setString(1, userModel.getUsername());
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                String dbPassword = rs.getString("password");
                return PasswordUtil.verifyPassword(userModel.getPasswordHash(), dbPassword);
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return false;
    }

    public String getUserRole(String username) {
        String query = "SELECT role FROM users WHERE username = ?";

        try (Connection conn = DbConfig.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setString(1, username);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return rs.getString("role");
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }

        return null;
    }
}

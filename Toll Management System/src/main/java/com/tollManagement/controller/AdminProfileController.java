package com.tollManagement.controller;

import jakarta.servlet.ServletException; 

import com.tollManagement.config.DbConfig;
import com.tollManagement.model.UserModel;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
/**
 * Servlet implementation class AdminProfileController
 * @author Samir yadav
 * @lmuId 23048505
 */
@WebServlet(asyncSupported = true, urlPatterns = { "/AdminProfileController" })
public class AdminProfileController extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
       
        UserModel user = (UserModel) request.getSession().getAttribute("user");
        if (user == null) {
            response.sendRedirect("login");
            return;
        }
        
        request.setAttribute("user", user);
        request.getRequestDispatcher("/WEB-INF/pages/adminPages/profile.jsp").forward(request, response);
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        UserModel user = (UserModel) request.getSession().getAttribute("user");
        
        try (Connection conn = DbConfig.getDbConnection()) {  // Get connection from your config
            
            if ("updateProfile".equals(action)) {
                // Update profile fields from request
                user.setFirstName(request.getParameter("firstName"));
                user.setLastName(request.getParameter("lastName"));
                user.setEmail(request.getParameter("email"));
                user.setPhone(request.getParameter("phone"));
                
                // Direct database update
                String sql = "UPDATE User SET first_name=?, last_name=?, email=?, phone=? WHERE citizenship_number=?";
                try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                    stmt.setString(1, user.getFirstName());
                    stmt.setString(2, user.getLastName());
                    stmt.setString(3, user.getEmail());
                    stmt.setString(4, user.getPhone());
                    stmt.setString(5, user.getCitizenshipNumber());
                    
                    int rowsUpdated = stmt.executeUpdate();
                    if (rowsUpdated > 0) {
                        request.setAttribute("success", "Profile updated successfully");
                    } else {
                        request.setAttribute("error", "Failed to update profile");
                    }
                }
            }
            else if ("changePassword".equals(action)) {
                // Password change logic with direct DB access
                String currentPassword = request.getParameter("currentPassword");
                String newPassword = request.getParameter("newPassword");
                
                // Verify current password (use hashed passwords in real implementation)
                String checkSql = "SELECT password FROM User WHERE id=?";
                try (PreparedStatement checkStmt = conn.prepareStatement(checkSql)) {
                    checkStmt.setString(1, user.getCitizenshipNumber());
                    ResultSet rs = checkStmt.executeQuery();
                    if (rs.next()) {
                        String dbPassword = rs.getString("password");
                        if (!dbPassword.equals(currentPassword)) {  // In reality, use hashing
                            request.setAttribute("error", "Current password is incorrect");
                        } else {
                            // Update password
                            String updateSql = "UPDATE User SET password=? WHERE id=?";
                            try (PreparedStatement updateStmt = conn.prepareStatement(updateSql)) {
                                updateStmt.setString(1, newPassword);  // Hash this in production!
                                updateStmt.setString(2, user.getCitizenshipNumber());
                                updateStmt.executeUpdate();
                                request.setAttribute("success", "Password changed successfully");
                            }
                        }
                    }
                }
            }
            
        }catch (ClassNotFoundException e) {
            e.printStackTrace(); // Log the error
            request.setAttribute("error", "Database driver not found. Contact support.");
            request.getRequestDispatcher("/WEB-INF/pages/adminPages/profile.jsp").forward(request, response);
        }
        catch (SQLException e) {
            request.setAttribute("error", "Database error occurred");
            e.printStackTrace(); 
        }
        
        request.setAttribute("user", user);
        request.getRequestDispatcher("/WEB-INF/pages/adminPages/profile.jsp").forward(request, response);
    }
}

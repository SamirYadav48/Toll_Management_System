package com.tollManagement.controller;

import jakarta.servlet.ServletException;
import com.tollManagement.model.UserModel;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

import org.apache.catalina.User;





/**
 * Servlet implementation class AdminProfileController
 */
@WebServlet(asyncSupported = true, urlPatterns = { "/AdminProfileController" })
public class AdminProfileController extends HttpServlet {
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Get current user from session (example)
        User user = (User) request.getSession().getAttribute("user");
        if (user == null) {
            response.sendRedirect("login");
            return;
        }
        
        request.setAttribute("user", user);
        request.getRequestDispatcher("/WEB-INF/views/profile.jsp").forward(request, response);
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        User user = (User) request.getSession().getAttribute("user");
        
        if ("updateProfile".equals(action)) {
            // Process profile update
            user.setName(request.getParameter("name"));
            user.setEmail(request.getParameter("email"));
            user.setPhone(request.getParameter("phone"));
            user.setPosition(request.getParameter("position"));
            
            // Save to database (pseudo-code)
            // userDao.update(user);
            
            request.setAttribute("success", "Profile updated successfully");
            
        } else if ("changePassword".equals(action)) {
            // Process password change
            String currentPassword = request.getParameter("currentPassword");
            String newPassword = request.getParameter("newPassword");
            
            if (!user.getPassword().equals(currentPassword)) {
                request.setAttribute("error", "Current password is incorrect");
            } else {
                user.setPassword(newPassword);
                // userDao.updatePassword(user);
                request.setAttribute("success", "Password changed successfully");
            }
        }
        
        request.setAttribute("user", user);
        request.getRequestDispatcher("/WEB-INF/views/profile.jsp").forward(request, response);
    }
}

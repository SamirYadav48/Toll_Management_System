package com.tollManagement.controller;

import com.tollManagement.model.TollBoothModel;
import com.tollManagement.config.DbConfig;
import java.sql.*;
import java.util.ArrayList;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Servlet implementation class TollBoothsController
 * @author Samir yadav
 * @lmuId 23048505
 */
@WebServlet(asyncSupported = true, urlPatterns = { "/TollBoothsController" })
public class TollBoothsController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get status filter parameter
        String statusFilter = request.getParameter("status");
        
        // List to hold toll booth data
        ArrayList<TollBoothModel> tollBooths = new ArrayList<>();

        // Establish database connection and fetch data
        try (Connection conn = DbConfig.getDbConnection()) {
            String query = "SELECT boothId, location, status, created_at, updated_at FROM toll_booths";
            
            // Add WHERE clause if status filter is specified
            if (statusFilter != null && !statusFilter.isEmpty()) {
                query += " WHERE status = ?";
            }
            try (PreparedStatement stmt = conn.prepareStatement(query)) {
                // Set status parameter if filtering
                if (statusFilter != null && !statusFilter.isEmpty()) {
                    stmt.setString(1, statusFilter);
                }
                
                try (ResultSet rs = stmt.executeQuery()) {
                    while (rs.next()) {
                        TollBoothModel tollBooth = new TollBoothModel();
                        tollBooth.setBoothId(rs.getString("boothId"));
                        tollBooth.setLocation(rs.getString("location"));
                        tollBooth.setStatus(rs.getString("status"));
                        tollBooth.setCreatedAt(rs.getTimestamp("created_at"));
                        tollBooth.setUpdatedAt(rs.getTimestamp("updated_at"));

                        tollBooths.add(tollBooth);
                    }
                }
            }
        }
        catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            request.setAttribute("error", "Error fetching toll booths: " + e.getMessage());
        }

        request.setAttribute("tollBooths", tollBooths);
        request.getRequestDispatcher("/WEB-INF/pages/adminPages/tollbooths.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        
        if ("deleteBooth".equals(action)) {
            String boothId = request.getParameter("boothId");
            
            try (Connection conn = DbConfig.getDbConnection()) {
                String deleteQuery = "DELETE FROM toll_booths WHERE boothId = ?";
                try (PreparedStatement pstmt = conn.prepareStatement(deleteQuery)) {
                    pstmt.setString(1, boothId);
                    
                    int rowsAffected = pstmt.executeUpdate();
                    
                    if (rowsAffected > 0) {
                        request.setAttribute("success", "Toll booth deleted successfully!");
                    } else {
                        request.setAttribute("error", "Failed to delete toll booth");
                    }
                }
            } catch (SQLException | ClassNotFoundException e) {
                e.printStackTrace();
                request.setAttribute("error", "Error deleting toll booth: " + e.getMessage());
            }
        } else if ("addBooth".equals(action)) {
            String boothId = request.getParameter("boothId");
            String location = request.getParameter("location");
            String status = request.getParameter("status");

            try (Connection conn = DbConfig.getDbConnection()) {
                String insertQuery = "INSERT INTO toll_booths (boothId, location, status) VALUES (?, ?, ?)";
                try (PreparedStatement pstmt = conn.prepareStatement(insertQuery)) {
                    pstmt.setString(1, boothId);
                    pstmt.setString(2, location);
                    pstmt.setString(3, status);
                    
                    int rowsAffected = pstmt.executeUpdate();
                    
                    if (rowsAffected > 0) {
                        request.setAttribute("success", "Toll booth added successfully!");
                    } else {
                        request.setAttribute("error", "Failed to add toll booth");
                    }
                }
            } catch (SQLException | ClassNotFoundException e) {
                e.printStackTrace();
                request.setAttribute("error", "Error adding toll booth: " + e.getMessage());
            }
        }
        
        // Redirect to GET to show updated list
        doGet(request, response);
    }
}
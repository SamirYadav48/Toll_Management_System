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

@WebServlet(asyncSupported = true, urlPatterns = { "/TollBoothsController" })
public class TollBoothsController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // List to hold toll booth data
        ArrayList<TollBoothModel> tollBooths = new ArrayList<>();

        // Establish database connection and fetch data
        try (Connection conn = DbConfig.getDbConnection()) {
            String query = "SELECT boothId, location, status, created_at, updated_at FROM toll_booths";
            try (PreparedStatement stmt = conn.prepareStatement(query);
                 ResultSet rs = stmt.executeQuery()) {

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
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            request.setAttribute("error", "Error fetching toll booths: " + e.getMessage());
        }

        request.setAttribute("tollBooths", tollBooths);
        request.getRequestDispatcher("/WEB-INF/pages/adminPages/tollbooths.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        
        if ("addBooth".equals(action)) {
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
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
 */
@WebServlet(asyncSupported = true, urlPatterns = { "/TollBoothsController" })
public class TollBoothsController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public TollBoothsController() {
        super();
    }

    /**
     * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // List to hold toll booth data
        ArrayList<TollBoothModel> tollBooths = new ArrayList<>();

        // Establish database connection and fetch data
        try (Connection conn = DbConfig.getDbConnection()) {
            String query = "SELECT boothId, location, status, created_at, updated_at FROM toll_booths";
            try (PreparedStatement stmt = conn.prepareStatement(query);
                 ResultSet rs = stmt.executeQuery()) {

                // Iterate through the result set and populate the list of TollBoothModel
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

        // Set the list of toll booths as a request attribute and forward to the JSP
        request.setAttribute("tollBooths", tollBooths);
        request.getRequestDispatcher("/WEB-INF/pages/adminPages/tollbooths.jsp").forward(request, response);
    }

    /**
     * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}

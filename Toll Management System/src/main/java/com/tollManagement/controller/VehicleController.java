package com.tollManagement.controller;

import com.tollManagement.model.VehicleModel; 
import com.tollManagement.model.UserModel;
import com.tollManagement.service.VehicleService;


import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;

import java.util.List;

@WebServlet(asyncSupported = true, urlPatterns = { "/VehicleController", "/VehicleController/*" })
public class VehicleController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final VehicleService vehicleService;

    
    public VehicleController() {
        super();
        this.vehicleService = new VehicleService();
       
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        String username = (String) session.getAttribute("username");
        
        if (username == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        String pathInfo = request.getPathInfo();
        
        try {
            if (pathInfo == null || pathInfo.equals("/")) {
                // List all vehicles
                List<VehicleModel> vehicles = vehicleService.getUserVehicles(username);
                request.setAttribute("vehicles", vehicles);
                request.getRequestDispatcher("/WEB-INF/pages/customerPages/vehicles.jsp").forward(request, response);
            } else if (pathInfo.equals("/add")) {
                // Show add vehicle form
                request.getRequestDispatcher("/WEB-INF/pages/customerPages/addVehicle.jsp").forward(request, response);
            } else if (pathInfo.startsWith("/edit/")) {
                // Show edit vehicle form
                String vehicleNumber = pathInfo.substring(6);
                VehicleModel vehicle = vehicleService.getVehicleByNumber(vehicleNumber);
                
                if (vehicle != null && vehicle.getUsername().equals(username)) {
                    request.setAttribute("vehicle", vehicle);
                    request.getRequestDispatcher("/WEB-INF/pages/customerPages/editVehicle.jsp").forward(request, response);
                } else {
                    response.sendError(HttpServletResponse.SC_NOT_FOUND);
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            request.setAttribute("error", "Error accessing vehicle data: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/pages/customerPages/vehicles.jsp").forward(request, response);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        String username = (String) session.getAttribute("username");
        UserModel user = (UserModel) session.getAttribute("user");
        
        if (username == null || user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        String action = request.getParameter("action");
        
        try {
            if ("add".equals(action)) {
                // Add new vehicle
                VehicleModel vehicle = new VehicleModel(
                    request.getParameter("vehicleType"),
                    request.getParameter("vehicleNumber"),
                    username,
                    user.getCitizenshipNumber()
                );
                
                if (vehicleService.addVehicle(vehicle)) {
                    response.sendRedirect(request.getContextPath() + "/VehicleController");
                } else {
                    request.setAttribute("error", "Failed to add vehicle");
                    request.getRequestDispatcher("/WEB-INF/pages/customerPages/addVehicle.jsp").forward(request, response);
                }
            } else if ("update".equals(action)) {
                // Update existing vehicle
                VehicleModel vehicle = vehicleService.getVehicleByNumber(request.getParameter("originalVehicleNumber"));
                
                if (vehicle != null && vehicle.getUsername().equals(username)) {
                    vehicle.setVehicleType(request.getParameter("vehicleType"));
                    vehicle.setVehicleNumber(request.getParameter("vehicleNumber"));
                    
                    String monthlyPassExpiry = request.getParameter("monthlyPassExpiry");
                    if (monthlyPassExpiry != null && !monthlyPassExpiry.isEmpty()) {
                        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                        vehicle.setMonthlyPassExpiry(sdf.parse(monthlyPassExpiry));
                    }
                    
                    if (vehicleService.updateVehicle(vehicle)) {
                        response.sendRedirect(request.getContextPath() + "/VehicleController");
                    } else {
                        request.setAttribute("error", "Failed to update vehicle");
                        request.setAttribute("vehicle", vehicle);
                        request.getRequestDispatcher("/WEB-INF/pages/customerPages/editVehicle.jsp").forward(request, response);
                    }
                } else {
                    response.sendError(HttpServletResponse.SC_NOT_FOUND);
                }
            } else if ("deactivate".equals(action)) {
                // Deactivate vehicle
                VehicleModel vehicle = vehicleService.getVehicleByNumber(request.getParameter("vehicleNumber"));
                
                if (vehicle != null && vehicle.getUsername().equals(username)) {
                    if (vehicleService.deactivateVehicle(vehicle.getVehicleId())) {
                        response.setContentType("application/json");
                        response.getWriter().write("{\"success\": true}");
                    } else {
                        response.setContentType("application/json");
                        response.getWriter().write("{\"success\": false, \"error\": \"Failed to deactivate vehicle\"}");
                    }
                } else {
                    response.sendError(HttpServletResponse.SC_NOT_FOUND);
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            request.setAttribute("error", "Database error: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/pages/customerPages/vehicles.jsp").forward(request, response);
        } catch (ParseException e) {
            e.printStackTrace();
            request.setAttribute("error", "Invalid date format");
            request.getRequestDispatcher("/WEB-INF/pages/customerPages/editVehicle.jsp").forward(request, response);
        }
    }
} 
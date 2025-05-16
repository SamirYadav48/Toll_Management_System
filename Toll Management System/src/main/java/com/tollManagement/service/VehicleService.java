package com.tollManagement.service;

import com.tollManagement.config.DbConfig;
import com.tollManagement.model.VehicleModel;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class VehicleService {
    
    public List<VehicleModel> getUserVehicles(String username) throws SQLException, ClassNotFoundException {
        List<VehicleModel> vehicles = new ArrayList<>();
        String query = """
                SELECT * FROM vehicle 
                WHERE username = ? 
                AND is_active = TRUE 
                ORDER BY created_at DESC
                """;
                
        try (Connection conn = DbConfig.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            
            stmt.setString(1, username);
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                vehicles.add(mapResultSetToVehicle(rs));
            }
        }
        return vehicles;
    }
    
    public VehicleModel getVehicleByNumber(String vehicleNumber) throws SQLException, ClassNotFoundException {
        String query = "SELECT * FROM vehicle WHERE vehicle_number = ? AND is_active = TRUE";
        
        try (Connection conn = DbConfig.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            
            stmt.setString(1, vehicleNumber);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                return mapResultSetToVehicle(rs);
            }
        }
        return null;
    }
    
    public boolean addVehicle(VehicleModel vehicle) throws SQLException, ClassNotFoundException {
        String query = """
                INSERT INTO vehicle (vehicle_type, vehicle_number, username, citizenship_number, is_active) 
                VALUES (?, ?, ?, ?, TRUE)
                """;
                
        try (Connection conn = DbConfig.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            
            stmt.setString(1, vehicle.getVehicleType());
            stmt.setString(2, vehicle.getVehicleNumber());
            stmt.setString(3, vehicle.getUsername());
            stmt.setString(4, vehicle.getCitizenshipNumber());
            
            return stmt.executeUpdate() > 0;
        }
    }
    
    public boolean updateVehicle(VehicleModel vehicle) throws SQLException, ClassNotFoundException {
        String query = """
                UPDATE vehicle 
                SET vehicle_type = ?, 
                    vehicle_number = ?, 
                    username = ?, 
                    citizenship_number = ?, 
                    is_active = ?,
                    monthly_pass_expiry = ?
                WHERE vehicle_id = ?
                """;
                
        try (Connection conn = DbConfig.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            
            stmt.setString(1, vehicle.getVehicleType());
            stmt.setString(2, vehicle.getVehicleNumber());
            stmt.setString(3, vehicle.getUsername());
            stmt.setString(4, vehicle.getCitizenshipNumber());
            stmt.setBoolean(5, vehicle.isActive());
            stmt.setDate(6, vehicle.getMonthlyPassExpiry() != null ? new java.sql.Date(vehicle.getMonthlyPassExpiry().getTime()) : null);
            stmt.setInt(7, vehicle.getVehicleId());
            
            return stmt.executeUpdate() > 0;
        }
    }
    
    public boolean deactivateVehicle(int vehicleId) throws SQLException, ClassNotFoundException {
        String query = "UPDATE vehicle SET is_active = FALSE WHERE vehicle_id = ?";
        
        try (Connection conn = DbConfig.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            
            stmt.setInt(1, vehicleId);
            return stmt.executeUpdate() > 0;
        }
    }
    
    public boolean updateMonthlyPass(int vehicleId, Date expiryDate) throws SQLException, ClassNotFoundException {
        String query = "UPDATE vehicle SET monthly_pass_expiry = ? WHERE vehicle_id = ?";
        
        try (Connection conn = DbConfig.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            
            stmt.setDate(1, new java.sql.Date(expiryDate.getTime()));
            stmt.setInt(2, vehicleId);
            return stmt.executeUpdate() > 0;
        }
    }
    
    public boolean updateTollUsage(String vehicleNumber, double amount) throws SQLException, ClassNotFoundException {
        String query = """
                UPDATE vehicle 
                SET last_toll_date = CURRENT_TIMESTAMP,
                    total_toll_paid = total_toll_paid + ?
                WHERE vehicle_number = ?
                """;
                
        try (Connection conn = DbConfig.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            
            stmt.setDouble(1, amount);
            stmt.setString(2, vehicleNumber);
            return stmt.executeUpdate() > 0;
        }
    }
    
    private VehicleModel mapResultSetToVehicle(ResultSet rs) throws SQLException {
        return new VehicleModel(
            rs.getInt("vehicle_id"),
            rs.getString("vehicle_type"),
            rs.getString("vehicle_number"),
            rs.getString("username"),
            rs.getString("citizenship_number"),
            rs.getTimestamp("created_at"),
            rs.getTimestamp("updated_at"),
            rs.getBoolean("is_active"),
            rs.getTimestamp("last_toll_date"),
            rs.getDouble("total_toll_paid"),
            rs.getDate("monthly_pass_expiry")
        );
    }
} 
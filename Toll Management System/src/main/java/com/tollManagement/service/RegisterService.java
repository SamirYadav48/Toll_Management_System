package com.tollManagement.service;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import com.tollManagement.config.DbConfig;
import com.tollManagement.model.UserModel;
import com.tollManagement.model.VehicleModel;

public class RegisterService {

    // Method to register user and their vehicle
    public boolean registerUser(UserModel userModel, VehicleModel vehicleModel) {
        Connection dbConn = null;
        try {
            dbConn = DbConfig.getDbConnection();
            dbConn.setAutoCommit(false); // Start transaction

            // SQL query to insert user data
            String userInsertQuery = """
                INSERT INTO User (username, password, first_name, last_name, 
                                email, phone, province, postal_code, account_type, 
                                citizenship_number) 
                VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
                """;

            try (PreparedStatement userStmt = dbConn.prepareStatement(userInsertQuery)) {
                // Set values for user registration
                userStmt.setString(1, userModel.getUsername());
                userStmt.setString(2, userModel.getPassword());
                userStmt.setString(3, userModel.getFirstName());
                userStmt.setString(4, userModel.getLastName());
                userStmt.setString(5, userModel.getEmail());
                userStmt.setString(6, userModel.getPhone());
                userStmt.setString(7, userModel.getProvince());
                userStmt.setString(8, userModel.getPostalCode());
                userStmt.setString(9, userModel.getAccountType());
                userStmt.setString(10, userModel.getCitizenshipNumber());

                // Execute user insertion
                int userRowsAffected = userStmt.executeUpdate();

                // If user inserted successfully, insert vehicle data
                if (userRowsAffected > 0) {
                    String vehicleInsertQuery = """
                        INSERT INTO vehicle (vehicle_type, vehicle_number, username, 
                                          citizenship_number, total_toll_paid, is_active) 
                        VALUES (?, ?, ?, ?, ?, ?)
                        """;

                    try (PreparedStatement vehicleStmt = dbConn.prepareStatement(vehicleInsertQuery)) {
                        // Set values for vehicle registration
                        vehicleStmt.setString(1, vehicleModel.getVehicleType());
                        vehicleStmt.setString(2, vehicleModel.getVehicleNumber());
                        vehicleStmt.setString(3, userModel.getUsername());
                        vehicleStmt.setString(4, userModel.getCitizenshipNumber());
                        vehicleStmt.setDouble(5, 0.0); // Initial toll paid amount
                        vehicleStmt.setBoolean(6, true); // Set is_active to true

                        // Execute vehicle insertion
                        int vehicleRowsAffected = vehicleStmt.executeUpdate();
                        
                        if (vehicleRowsAffected > 0) {
                            dbConn.commit(); // Commit transaction
                            return true;
                        }
                    }
                }
                dbConn.rollback();
            }
        } catch (SQLException | ClassNotFoundException e) {
            try {
                if (dbConn != null) {
                    dbConn.rollback();
                }
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
            e.printStackTrace();
        } finally {
            try {
                if (dbConn != null) {
                    dbConn.setAutoCommit(true);
                    dbConn.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return false;
    }
}

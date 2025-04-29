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
        try (Connection dbConn = DbConfig.getDbConnection()) {
            // SQL query to insert user data (including citizenship number)
            String userInsertQuery = "INSERT INTO users (username, password, first_name, last_name, email, phone, province, postal_code, account_type, vehicle_type, vehicle_number, citizenship_number) "
                                    + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

            try (PreparedStatement userStmt = dbConn.prepareStatement(userInsertQuery)) {
                // Set values for user registration
                userStmt.setString(1, userModel.getUsername());
                userStmt.setString(2, userModel.getPasswordHash());
                userStmt.setString(3, userModel.getFirstName());
                userStmt.setString(4, userModel.getLastName());
                userStmt.setString(5, userModel.getEmail());
                userStmt.setString(6, userModel.getPhone());
                userStmt.setString(7, userModel.getProvince());
                userStmt.setString(8, userModel.getPostalCode());
                userStmt.setString(9, userModel.getAccountType());
                userStmt.setString(10, userModel.getVehicleType());
                userStmt.setString(11, userModel.getVehicleNumber());
                userStmt.setString(12, userModel.getCitizenshipNumber());  

                // Execute user insertion
                int userRowsAffected = userStmt.executeUpdate();

                // If user inserted successfully, insert vehicle data
                if (userRowsAffected > 0) {
                    String vehicleInsertQuery = "INSERT INTO vehicles (vehicle_type, vehicle_number, citizenship_number) VALUES (?, ?, ?)";

                    try (PreparedStatement vehicleStmt = dbConn.prepareStatement(vehicleInsertQuery)) {
                       
                        int citizenship_number = 1;  

                        // Set values for vehicle registration
                        vehicleStmt.setString(1, vehicleModel.getVehicleType());
                        vehicleStmt.setString(2, vehicleModel.getVehicleNumber());
                        vehicleStmt.setInt(3, citizenship_number);  // Associate vehicle with user

                        // Execute vehicle insertion
                        int vehicleRowsAffected = vehicleStmt.executeUpdate();
                        return vehicleRowsAffected > 0;
                    }
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            System.err.println("Error during registration: " + e.getMessage());
            e.printStackTrace();
            return false;
        }

        return false;
    }
}

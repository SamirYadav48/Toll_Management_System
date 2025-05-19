package com.tollManagement.service;

import com.tollManagement.config.DbConfig;
import com.tollManagement.model.UserModel;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class CustomerService {
    private Connection connection;

    public CustomerService() {
        try {
            connection = DbConfig.getDbConnection();
            System.out.println("Database connection established successfully");
        } catch (SQLException | ClassNotFoundException e) {
            System.err.println("Failed to establish database connection: " + e.getMessage());
            e.printStackTrace();
        }
    }

    public List<UserModel> getAllCustomers() {
        List<UserModel> customers = new ArrayList<>();
        String query = "SELECT * FROM User WHERE account_type IN ('commercial', 'personal') ORDER BY username";
        System.out.println("Executing query: " + query);
        System.out.println("Database connection status: " + (connection != null ? "Connected" : "Not Connected"));
        try (PreparedStatement pstmt = connection.prepareStatement(query);
             ResultSet rs = pstmt.executeQuery()) {
            while (rs.next()) {
                UserModel customer = new UserModel();
                customer.setUsername(rs.getString("username"));
                customer.setAccountType(rs.getString("account_type"));
                customer.setFirstName(rs.getString("first_name"));
                customer.setLastName(rs.getString("last_name"));
                customer.setEmail(rs.getString("email"));
                customer.setPhone(rs.getString("phone"));
                customer.setCitizenshipNumber(rs.getString("citizenship_number"));
                customers.add(customer);
                System.out.println("Found customer: " + customer.getUsername() + ", type: " + customer.getAccountType());
            }
        } catch (SQLException e) {
            System.err.println("Error retrieving customers: " + e.getMessage());
            e.printStackTrace();
        }
        System.out.println("Total customers found: " + customers.size());
        return customers;
    }

    public UserModel getUserByUsername(String username) {
        UserModel user = null;
        String query = "SELECT * FROM User WHERE username = ? AND account_type IN ('commercial', 'personal')";
        
        try (PreparedStatement pstmt = connection.prepareStatement(query)) {
            pstmt.setString(1, username);
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                user = new UserModel();
                user.setUsername(rs.getString("username"));
                user.setPassword(rs.getString("password"));
                user.setAccountType(rs.getString("account_type"));
                user.setFirstName(rs.getString("first_name"));
                user.setLastName(rs.getString("last_name"));
                user.setEmail(rs.getString("email"));
                user.setPhone(rs.getString("phone"));
                user.setProvince(rs.getString("province"));
                user.setPostalCode(rs.getString("postal_code"));
                user.setCitizenshipNumber(rs.getString("citizenship_number"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return user;
    }

    public void saveUser(UserModel user) {
        String query = "INSERT INTO User (username, password, account_type, first_name, last_name, email, phone, province, postal_code, citizenship_number) " +
                    "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?) " +
                    "ON DUPLICATE KEY UPDATE " +
                    "password = VALUES(password), " +
                    "account_type = VALUES(account_type), " +
                    "first_name = VALUES(first_name), " +
                    "last_name = VALUES(last_name), " +
                    "email = VALUES(email), " +
                    "phone = VALUES(phone), " +
                    "province = VALUES(province), " +
                    "postal_code = VALUES(postal_code), " +
                    "citizenship_number = VALUES(citizenship_number)";
        
        try (PreparedStatement pstmt = connection.prepareStatement(query)) {
            
            pstmt.setString(1, user.getUsername());
            pstmt.setString(2, user.getPassword());
            pstmt.setString(3, user.getAccountType());
            pstmt.setString(4, user.getFirstName());
            pstmt.setString(5, user.getLastName());
            pstmt.setString(6, user.getEmail());
            pstmt.setString(7, user.getPhone());
            pstmt.setString(8, user.getProvince());
            pstmt.setString(9, user.getPostalCode());
            pstmt.setString(10, user.getCitizenshipNumber());
            
            pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void deleteUser(String username) {
        String query = "DELETE FROM User WHERE username = ? AND account_type IN ('commercial', 'personal')";
        
        try (PreparedStatement pstmt = connection.prepareStatement(query)) {
            
            pstmt.setString(1, username);
            pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}

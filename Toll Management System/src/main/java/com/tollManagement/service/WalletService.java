package com.tollManagement.service;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import com.tollManagement.config.DbConfig;

public class WalletService {
    
    public double getWalletBalance(String username) {
        String query = "SELECT balance FROM user_wallet WHERE username = ?";
        
        try (Connection conn = DbConfig.getDbConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            
            pstmt.setString(1, username);
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                double balance = rs.getDouble("balance");
                System.out.println("Current balance for user " + username + ": " + balance);
                return balance;
            } else {
                System.out.println("No wallet found for user " + username);
            }
            
        } catch (SQLException | ClassNotFoundException e) {
            System.out.println("Error getting wallet balance: " + e.getMessage());
            e.printStackTrace();
        }
        
        return 0.0;
    }
    
    public boolean processRecharge(String username, double amount, String paymentMethod) {
        System.out.println("Starting recharge process for user: " + username + ", amount: " + amount + ", payment method: " + paymentMethod);
        
        // Convert payment method to match enum values
        String formattedPaymentMethod;
        switch(paymentMethod.toLowerCase()) {
            case "esewa":
            case "khalti":
            case "connectips":
                formattedPaymentMethod = "Online";
                break;
            case "card":
                formattedPaymentMethod = "Card";
                break;
            default:
                formattedPaymentMethod = "Online";
        }
        
        System.out.println("Formatted payment method: " + formattedPaymentMethod);
        
        // Using exact table and column names from the database
        String checkQuery = "SELECT balance FROM user_wallet WHERE username = ?";
        String insertWalletQuery = "INSERT INTO user_wallet (username, balance) VALUES (?, ?)";
        String updateQuery = "UPDATE user_wallet SET balance = ? WHERE username = ?";
        String insertTransactionQuery = "INSERT INTO transactions (vehicleNo, boothId, amount, paymentMode, status) VALUES (?, ?, ?, ?, 'Completed')";
        
        try (Connection conn = DbConfig.getDbConnection()) {
            System.out.println("Database connection established");
            conn.setAutoCommit(false);
            
            try {
                // Check if user has a wallet and get current balance
                double currentBalance = 0.0;
                boolean hasWallet = false;
                try (PreparedStatement pstmt = conn.prepareStatement(checkQuery)) {
                    pstmt.setString(1, username);
                    ResultSet rs = pstmt.executeQuery();
                    if (rs.next()) {
                        hasWallet = true;
                        currentBalance = rs.getDouble("balance");
                        System.out.println("Current balance before recharge: " + currentBalance);
                    }
                }
                System.out.println("User has wallet: " + hasWallet);
                
                // Create wallet if it doesn't exist
                if (!hasWallet) {
                    try (PreparedStatement pstmt = conn.prepareStatement(insertWalletQuery)) {
                        pstmt.setString(1, username);
                        pstmt.setDouble(2, amount); // Set initial balance to recharge amount
                        int rows = pstmt.executeUpdate();
                        System.out.println("Created new wallet with initial balance " + amount + ", rows affected: " + rows);
                    }
                } else {
                    // Update wallet balance
                    double newBalance = currentBalance + amount;
                    try (PreparedStatement pstmt = conn.prepareStatement(updateQuery)) {
                        pstmt.setDouble(1, newBalance);
                        pstmt.setString(2, username);
                        int rows = pstmt.executeUpdate();
                        System.out.println("Updated wallet balance from " + currentBalance + " to " + newBalance + ", rows affected: " + rows);
                        if (rows == 0) {
                            throw new SQLException("Failed to update wallet balance");
                        }
                    }
                }
                
                // Record transaction
                try (PreparedStatement pstmt = conn.prepareStatement(insertTransactionQuery)) {
                    pstmt.setString(1, "WALLET_RECHARGE");
                    pstmt.setString(2, "WALLET");
                    pstmt.setDouble(3, amount);
                    pstmt.setString(4, formattedPaymentMethod);
                    int rows = pstmt.executeUpdate();
                    System.out.println("Recorded transaction, rows affected: " + rows);
                    if (rows == 0) {
                        throw new SQLException("Failed to record transaction");
                    }
                }
                
                conn.commit();
                System.out.println("Recharge completed successfully");
                return true;
                
            } catch (SQLException e) {
                conn.rollback();
                System.out.println("Error during recharge: " + e.getMessage());
                e.printStackTrace();
                return false;
            }
            
        } catch (SQLException | ClassNotFoundException e) {
            System.out.println("Error connecting to database: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
} 
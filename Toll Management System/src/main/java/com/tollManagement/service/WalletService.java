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
                System.out.println("No wallet found for user " + username + ". Creating new wallet.");
                createWallet(username, 0.0);
                return 0.0;
            }
            
        } catch (SQLException | ClassNotFoundException e) {
            System.err.println("Error getting wallet balance: " + e.getMessage());
            e.printStackTrace();
            return 0.0;
        }
    }
    
    private boolean createWallet(String username, double initialBalance) {
        String query = "INSERT INTO user_wallet (username, balance) VALUES (?, ?)";
        
        try (Connection conn = DbConfig.getDbConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            
            pstmt.setString(1, username);
            pstmt.setDouble(2, initialBalance);
            
            int rows = pstmt.executeUpdate();
            System.out.println("Created new wallet for user " + username + ". Rows affected: " + rows);
            return rows > 0;
            
        } catch (SQLException | ClassNotFoundException e) {
            System.err.println("Error creating wallet: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
    
    public boolean processRecharge(String username, double rechargeAmount, String paymentMethod, double originalAmount, double serviceFee) {
        System.out.println("Processing recharge - Username: " + username + ", Amount: " + rechargeAmount + ", Method: " + paymentMethod);
        System.out.println("Original Amount: " + originalAmount + ", Service Fee: " + serviceFee);
        
        Connection conn = null;
        try {
            conn = DbConfig.getDbConnection();
            conn.setAutoCommit(false);
            
            // 1. Record transaction with total amount
            String transactionQuery = "INSERT INTO transactions (vehicleNo, boothId, amount, paymentMode, status, transactionDate) VALUES (?, NULL, ?, ?, 'Completed', NOW())";
            try (PreparedStatement pstmt = conn.prepareStatement(transactionQuery)) {
                pstmt.setString(1, "WALLET_RECHARGE");
                pstmt.setDouble(2, rechargeAmount + serviceFee); // Store total amount (original + service fee)
                pstmt.setString(3, paymentMethod);
                int rows = pstmt.executeUpdate();
                if (rows == 0) throw new SQLException("Failed to record transaction");
                System.out.println("Recorded transaction successfully - Total amount: " + (rechargeAmount + serviceFee));
            }
            
            // 2. Update wallet balance after transaction is recorded
            String updateQuery = "UPDATE user_wallet SET balance = balance + ? WHERE username = ?";
            try (PreparedStatement pstmt = conn.prepareStatement(updateQuery)) {
                pstmt.setDouble(1, originalAmount); // Only add the original amount to wallet
                pstmt.setString(2, username);
                int rows = pstmt.executeUpdate();
                if (rows == 0) throw new SQLException("Failed to update wallet balance");
                System.out.println("Updated wallet balance with: " + originalAmount);
            }
            
            conn.commit();
            System.out.println("Recharge completed successfully");
            return true;
            
        } catch (Exception e) {
            System.err.println("Error during recharge: " + e.getMessage());
            e.printStackTrace();
            if (conn != null) {
                try {
                    conn.rollback();
                    System.out.println("Transaction rolled back");
                } catch (SQLException ex) {
                    System.err.println("Error rolling back transaction: " + ex.getMessage());
                }
            }
            return false;
        } finally {
            if (conn != null) {
                try {
                    conn.setAutoCommit(true);
                    conn.close();
                } catch (SQLException e) {
                    System.err.println("Error closing connection: " + e.getMessage());
                }
            }
        }
    }
} 
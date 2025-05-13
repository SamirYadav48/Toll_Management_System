package com.tollManagement.service;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import com.tollManagement.model.TransactionModel;
import com.tollManagement.config.DbConfig;

public class PaymentHistoryService {
    private Connection connection;

    public PaymentHistoryService() {
        try {
            connection = DbConfig.getDbConnection();
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
    }

    public List<TransactionModel> getPaymentHistory(String username, int days) {
        List<TransactionModel> history = new ArrayList<>();
        String query = "SELECT t.*, b.name as booth_name " +
                      "FROM transactions t " +
                      "JOIN booths b ON t.booth_id = b.id " +
                      "JOIN vehicles v ON t.vehicle_no = v.license_plate " +
                      "JOIN users u ON v.user_id = u.id " +
                      "WHERE u.username = ? " +
                      (days > 0 ? "AND t.transaction_date >= DATE_SUB(CURDATE(), INTERVAL ? DAY) " : "") +
                      "ORDER BY t.transaction_date DESC";

        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setString(1, username);
            if (days > 0) {
                stmt.setInt(2, days);
            }
            
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                TransactionModel transaction = new TransactionModel();
                transaction.setTransactionId(rs.getInt("transaction_id"));
                transaction.setTransactionDate(rs.getTimestamp("transaction_date"));
                transaction.setBoothId(rs.getString("booth_name"));
                transaction.setVehicleNo(rs.getString("vehicle_no"));
                transaction.setAmount(rs.getDouble("amount"));
                transaction.setPaymentMode(rs.getString("payment_mode"));
                history.add(transaction);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return history;
    }

    public TransactionStats getPaymentStats(String username, int days) {
        TransactionStats stats = new TransactionStats();
        String query = "SELECT " +
                      "COUNT(*) as total_transactions, " +
                      "SUM(amount) as total_amount, " +
                      "AVG(amount) as avg_amount " +
                      "FROM transactions t " +
                      "JOIN vehicles v ON t.vehicle_no = v.license_plate " +
                      "JOIN users u ON v.user_id = u.id " +
                      "WHERE u.username = ? " +
                      (days > 0 ? "AND t.transaction_date >= DATE_SUB(CURDATE(), INTERVAL ? DAY) " : "");

        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setString(1, username);
            if (days > 0) {
                stmt.setInt(2, days);
            }
            
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                stats.setTotalTransactions(rs.getInt("total_transactions"));
                stats.setTotalAmount(rs.getDouble("total_amount"));
                stats.setAverageAmount(rs.getDouble("avg_amount"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return stats;
    }

    public byte[] getReceipt(int transactionId) {
        String query = "SELECT receipt_data FROM transactions WHERE transaction_id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, transactionId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getBytes("receipt_data");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
}

class TransactionStats {
    private int totalTransactions;
    private double totalAmount;
    private double averageAmount;

    public int getTotalTransactions() {
        return totalTransactions;
    }

    public void setTotalTransactions(int totalTransactions) {
        this.totalTransactions = totalTransactions;
    }

    public double getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(double totalAmount) {
        this.totalAmount = totalAmount;
    }

    public double getAverageAmount() {
        return averageAmount;
    }

    public void setAverageAmount(double averageAmount) {
        this.averageAmount = averageAmount;
    }
} 
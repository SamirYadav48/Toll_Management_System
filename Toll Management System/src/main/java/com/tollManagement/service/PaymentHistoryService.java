package com.tollManagement.service;

import java.sql.Connection; 
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import com.tollManagement.model.TransactionModel;
import com.tollManagement.model.TransactionStatsModel;
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
        
        // Check if user exists in wallet
        String walletCheckQuery = "SELECT username FROM user_wallet WHERE username = ?";
        try (PreparedStatement walletCheck = connection.prepareStatement(walletCheckQuery)) {
            walletCheck.setString(1, username);
            ResultSet walletRs = walletCheck.executeQuery();
            if (!walletRs.next()) {
                System.out.println("User not found in wallet: " + username);
                return history; // Return empty list if user doesn't exist
            }
            System.out.println("User found in wallet: " + username);
        } catch (SQLException e) {
            System.err.println("Error checking user in wallet: " + e.getMessage());
            e.printStackTrace();
            return history;
        }

        // Check all transactions
        String allTransactionsQuery = "SELECT * FROM transactions";
        try (PreparedStatement allTx = connection.prepareStatement(allTransactionsQuery)) {
            ResultSet allTxRs = allTx.executeQuery();
            System.out.println("Total transactions in database: " + allTxRs.getRow());
            while (allTxRs.next()) {
                System.out.println("Transaction: " + allTxRs.getInt("transactionId") + 
                    ", vehicleNo: " + allTxRs.getString("vehicleNo") + 
                    ", amount: " + allTxRs.getDouble("amount") + 
                    ", date: " + allTxRs.getTimestamp("transactionDate"));
            }
        } catch (SQLException e) {
            System.err.println("Error checking all transactions: " + e.getMessage());
            e.printStackTrace();
        }

        String query = "SELECT transactionId, vehicleNo, boothId, transactionDate, amount, paymentMode " +
                      "FROM transactions WHERE (vehicleNo = (SELECT username FROM user_wallet WHERE username = ?) OR vehicleNo = 'WALLET_RECHARGE') " +
                      (days > 0 ? "AND transactionDate >= DATE_SUB(CURDATE(), INTERVAL ? DAY) " : "") +
                      "ORDER BY transactionDate DESC";
        System.out.println("Query: " + query);
        System.out.println("Parameters: username=" + username + ", days=" + days);

        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setString(1, username);
            if (days > 0) {
                stmt.setInt(2, days);
            }
            
            ResultSet rs = stmt.executeQuery();
            int rowCount = 0;
            while (rs.next()) {
                rowCount++;
                System.out.println("Processing row: " + rs.getInt("transactionId") + " - " + rs.getString("vehicleNo"));
                TransactionModel transaction = new TransactionModel();
                transaction.setTransactionId(rs.getInt("transactionId"));
                transaction.setTransactionDate(rs.getTimestamp("transactionDate"));
                transaction.setBoothId(rs.getString("boothId"));
                transaction.setVehicleNo(rs.getString("vehicleNo"));
                transaction.setAmount(rs.getDouble("amount"));
                transaction.setPaymentMode(rs.getString("paymentMode"));
                history.add(transaction);
            }
            System.out.println("Total rows processed: " + rowCount);
            System.out.println("History size: " + history.size());
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return history;
    }

    public TransactionStatsModel getPaymentStats(String username, int days) {
        TransactionStatsModel stats = new TransactionStatsModel();
        System.out.println("Calculating stats for user: " + username + ", days: " + days);
        
        // First get total transactions using the same logic as getPaymentHistory
        String totalQuery = "SELECT COUNT(*) as total_transactions FROM transactions t " +
                           "WHERE (t.vehicleNo = (SELECT username FROM user_wallet WHERE username = ?) OR t.vehicleNo = 'WALLET_RECHARGE')";
        System.out.println("Total transactions query: " + totalQuery);
        try (PreparedStatement totalStmt = connection.prepareStatement(totalQuery)) {
            totalStmt.setString(1, username);
            System.out.println("Executing total transactions query with username: " + username);
            ResultSet totalRs = totalStmt.executeQuery();
            if (totalRs.next()) {
                int total = totalRs.getInt("total_transactions");
                stats.setTotalTransactions(total);
                System.out.println("Found total transactions: " + total);
            } else {
                System.out.println("No rows returned from total transactions query");
            }
        } catch (SQLException e) {
            System.err.println("Error getting total transactions: " + e.getMessage());
            e.printStackTrace();
        }

        // Then get stats for selected period
        String statsQuery = "SELECT " +
                      "COUNT(*) as period_transactions, " +
                      "SUM(amount) as total_amount, " +
                      "AVG(amount) as avg_amount " +
                      "FROM transactions t " +
                      "JOIN user_wallet w ON t.vehicleNo = w.username " +
                      "WHERE w.username = ? " +
                      (days > 0 ? "AND t.transactionDate >= DATE_SUB(CURDATE(), INTERVAL ? DAY) " : "");

        try (PreparedStatement statsStmt = connection.prepareStatement(statsQuery)) {
            statsStmt.setString(1, username);
            if (days > 0) {
                statsStmt.setInt(2, days);
            }
            
            ResultSet statsRs = statsStmt.executeQuery();
            if (statsRs.next()) {
                stats.setTotalAmount(statsRs.getDouble("total_amount"));
                stats.setAverageAmount(statsRs.getDouble("avg_amount"));
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
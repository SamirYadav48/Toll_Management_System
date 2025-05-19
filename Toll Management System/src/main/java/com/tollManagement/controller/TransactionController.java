package com.tollManagement.controller;

import com.tollManagement.model.TransactionModel;
import com.tollManagement.config.DbConfig;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;


/**
 * Servlet implementation class ToransactionsController
 * @author Samir yadav
 * @lmuId 23048505
 */
@WebServlet(asyncSupported = true, urlPatterns = { "/TransactionController" })
public class TransactionController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public TransactionController() {
        super();
    }

    // Method to get a connection to the database using DbConfig
    private Connection getConnection() throws SQLException, ClassNotFoundException {
        return DbConfig.getDbConnection(); // Using your DbConfig class
    }

    // Method to add a new transaction to the database
    private boolean addTransaction(TransactionModel transaction) {
        String sql = "INSERT INTO transactions (vehicleNo, boothId, amount, paymentMode) VALUES (?, ?, ?, ?)";
        
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, transaction.getVehicleNo());
            ps.setString(2, transaction.getBoothId());
            ps.setDouble(3, transaction.getAmount());
            ps.setString(4, transaction.getPaymentMode());
            
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Method to fetch all transactions from the database
    private List<TransactionModel> getAllTransactions() {
        List<TransactionModel> transactions = new ArrayList<>();
        String sql = "SELECT * FROM transactions"; // Adjust this query based on your database table
        
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                TransactionModel transaction = new TransactionModel(
                    rs.getInt("transactionId"),
                    rs.getString("vehicleNo"),
                    rs.getString("boothId"),
                    rs.getTimestamp("transactionDate"),
                    rs.getDouble("amount"),
                    rs.getString("paymentMode")
                );
                transactions.add(transaction);
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return transactions;
    }

    // doGet method for retrieving all transactions
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Fetch all transactions from the database
        List<TransactionModel> transactionList = getAllTransactions();
        
        // Add the transaction list to the request
        request.setAttribute("transactionList", transactionList);

        // Forward to the JSP page
        request.getRequestDispatcher("/WEB-INF/pages/adminPages/transaction.jsp").forward(request, response);
    }

    // doPost method for adding a new transaction
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve form parameters (assuming these fields are in the form)
        String vehicleNo = request.getParameter("vehicleNo");
        String boothId = request.getParameter("boothId");
        double amount = Double.parseDouble(request.getParameter("amount"));
        String paymentMode = request.getParameter("paymentMode");

        // Create a new transaction model
        TransactionModel transaction = new TransactionModel(vehicleNo, boothId, amount, paymentMode);

        // Insert the transaction into the database
        boolean success = addTransaction(transaction);

        // Redirect or display an error message
        if (success) {
            response.sendRedirect("TransactionController"); // Redirect back to the transaction page to see the added transaction
        } else {
            request.setAttribute("errorMessage", "Transaction could not be added.");
            request.getRequestDispatcher("/WEB-INF/pages/adminPages/transaction.jsp").forward(request, response);
        }
    }
}

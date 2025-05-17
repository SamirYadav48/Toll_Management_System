 package com.tollManagement.controller;

import com.tollManagement.config.DbConfig; 
import com.tollManagement.model.UserModel;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.google.gson.Gson;

/**
 * Servlet implementation class CustomerDashboard
 */
@WebServlet(asyncSupported = true, urlPatterns = { "/CustomerDashboard" })
public class CustomerDashboardController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private final Gson gson = new Gson();
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CustomerDashboardController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		String username = (String) session.getAttribute("username");
		UserModel user = (UserModel) session.getAttribute("user");
		
		if (username == null || user == null) {
			response.sendRedirect(request.getContextPath() + "/login");
			return;
		}

		try (Connection conn = DbConfig.getDbConnection()) {
			// Set user data
			request.setAttribute("user", user);

			// Get user's account balance
			double balance = getAccountBalance(conn, username);
			request.setAttribute("accountBalance", balance);

			// Get user's registered vehicles count
			int vehicleCount = getVehicleCount(conn, username);
			request.setAttribute("vehicleCount", vehicleCount);

			// Get recent toll passes count for current month
			int recentPasses = getRecentPassesCount(conn, username);
			request.setAttribute("recentPasses", recentPasses);

			// Get recent transactions
			List<Map<String, Object>> recentTransactions = getRecentTransactions(conn, username);
			request.setAttribute("recentTransactions", recentTransactions);

			// Get spending chart data
			Map<String, Object> spendingData = getSpendingData(conn, username);
			request.setAttribute("spendingLabels", gson.toJson(spendingData.get("labels")));
			request.setAttribute("spendingData", gson.toJson(spendingData.get("data")));

			// Get usage chart data
			Map<String, Object> usageData = getUsageData(conn, username);
			System.out.println("Usage Data:");
			System.out.println("Labels: " + usageData.get("labels"));
			System.out.println("Usage Counts: " + usageData.get("usageCounts"));
			System.out.println("Amounts: " + usageData.get("amounts"));
			request.setAttribute("usageLabels", gson.toJson(usageData.get("labels")));
			request.setAttribute("usageData", gson.toJson(usageData));

			// Forward to the dashboard JSP
			request.getRequestDispatcher("/WEB-INF/pages/customerPages/customerDashboard.jsp").forward(request, response);

		} catch (SQLException | ClassNotFoundException e) {
			e.printStackTrace();
			request.setAttribute("error", "Error loading dashboard data: " + e.getMessage());
			request.getRequestDispatcher("/WEB-INF/pages/customerPages/customerDashboard.jsp").forward(request, response);
		}
	}

	private double getAccountBalance(Connection conn, String username) throws SQLException {
		String query = "SELECT balance FROM user_wallet WHERE username = ?";
		try (PreparedStatement stmt = conn.prepareStatement(query)) {
			stmt.setString(1, username);
			ResultSet rs = stmt.executeQuery();
			if (rs.next()) {
				return rs.getDouble("balance");
			}
		}
		return 0.0;
	}

	private int getVehicleCount(Connection conn, String username) throws SQLException {
		String query = """
				SELECT COUNT(*) as count 
				FROM vehicle 
				WHERE username = ? 
				AND is_active = TRUE
				""";
		try (PreparedStatement stmt = conn.prepareStatement(query)) {
			stmt.setString(1, username);
			ResultSet rs = stmt.executeQuery();
			if (rs.next()) {
				return rs.getInt("count");
			}
		}
		return 0;
	}

	private int getRecentPassesCount(Connection conn, String username) throws SQLException {
		String query = "SELECT COUNT(*) as count FROM transactions t " +
					  "JOIN vehicle v ON t.vehicleNo = v.vehicle_number " +
					  "WHERE v.username = ? AND MONTH(t.transactionDate) = MONTH(CURRENT_DATE()) " +
					  "AND YEAR(t.transactionDate) = YEAR(CURRENT_DATE())";
		try (PreparedStatement stmt = conn.prepareStatement(query)) {
			stmt.setString(1, username);
			ResultSet rs = stmt.executeQuery();
			if (rs.next()) {
				return rs.getInt("count");
			}
		}
		return 0;
	}

	private List<Map<String, Object>> getRecentTransactions(Connection conn, String username) throws SQLException {
		List<Map<String, Object>> transactions = new ArrayList<>();
		String query = """
				SELECT 
					t.transactionDate,
					tb.location as tollLocation,
					v.vehicle_number,
					v.vehicle_type,
					t.amount,
					t.paymentMode,
					CASE 
						WHEN t.paymentMode = 'RFID' THEN 'SUCCESS'
						WHEN t.paymentMode = 'CASH' THEN 'COMPLETED'
						ELSE t.paymentMode
					END as status
				FROM transactions t
				JOIN vehicle v ON t.vehicleNo = v.vehicle_number
				JOIN toll_booths tb ON t.boothId = tb.boothId
				WHERE v.username = ? 
				AND v.is_active = TRUE
				ORDER BY t.transactionDate DESC 
				LIMIT 5
				""";
		
		try (PreparedStatement stmt = conn.prepareStatement(query)) {
			stmt.setString(1, username);
			ResultSet rs = stmt.executeQuery();
			while (rs.next()) {
				Map<String, Object> transaction = new HashMap<>();
				transaction.put("date", rs.getTimestamp("transactionDate"));
				transaction.put("location", rs.getString("tollLocation"));
				transaction.put("vehicle", rs.getString("vehicle_number"));
				transaction.put("vehicleType", rs.getString("vehicle_type"));
				transaction.put("amount", rs.getDouble("amount"));
				transaction.put("status", rs.getString("status"));
				transactions.add(transaction);
			}
		}
		return transactions;
	}

	private Map<String, Object> getSpendingData(Connection conn, String username) throws SQLException {
		Map<String, Object> chartData = new HashMap<>();
		List<String> labels = new ArrayList<>();
		List<Double> data = new ArrayList<>();
		        String query = """
            SELECT DATE_FORMAT(transactionDate, '%b %d') as date,
                   SUM(amount) as total_amount
            FROM transactions t
            WHERE (t.vehicleNo = (SELECT username FROM user_wallet WHERE username = ?) OR t.vehicleNo = 'WALLET_RECHARGE')
            AND transactionDate >= DATE_SUB(CURRENT_DATE, INTERVAL 7 DAY)
            GROUP BY DATE(transactionDate)
            ORDER BY transactionDate
        """;

		try (PreparedStatement stmt = conn.prepareStatement(query)) {
			stmt.setString(1, username);
			ResultSet rs = stmt.executeQuery();
			while (rs.next()) {
				labels.add(rs.getString("date"));
				data.add(rs.getDouble("total_amount"));
			}
		}

		chartData.put("labels", labels);
		chartData.put("data", data);
		return chartData;
	}

	private Map<String, Object> getUsageData(Connection conn, String username) throws SQLException {
        Map<String, Object> chartData = new HashMap<>();
        List<String> labels = new ArrayList<>();
        List<Double> usageCounts = new ArrayList<>();
        List<Double> amounts = new ArrayList<>();

        String query = """
                SELECT 
                    v.vehicle_type,
                    v.vehicle_number,
                    COUNT(t.transactionId) as usage_count,
                    COALESCE(SUM(t.amount), 0) as total_amount
                FROM vehicle v
                LEFT JOIN transactions t ON v.vehicle_number = t.vehicleNo
                WHERE v.username = ?
                AND v.is_active = TRUE
                GROUP BY v.vehicle_type, v.vehicle_number
                ORDER BY usage_count DESC, total_amount DESC
                """;

        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, username);
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                String vehicleType = rs.getString("vehicle_type");
                String vehicleNumber = rs.getString("vehicle_number");
                int usageCount = rs.getInt("usage_count");
                double totalAmount = rs.getDouble("total_amount");
                
                // Format label to include both vehicle type and number
                String label = vehicleType + " (" + vehicleNumber + ")";
                labels.add(label);
                
                // Store data in separate lists for each dataset
                usageCounts.add((double) usageCount);
                amounts.add(totalAmount);
            }
        }

        chartData.put("labels", labels);
        chartData.put("usageCounts", usageCounts);
        chartData.put("amounts", amounts);
        return chartData;
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}

package com.tollManagement.controller;

import com.tollManagement.config.DbConfig;
import com.tollManagement.model.TollRateModel;
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

/**
 * Servlet implementation class CustomerDashboard
 */
@WebServlet(asyncSupported = true, urlPatterns = { "/CustomerDashboard" })
public class CustomerDashboardController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
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

			// Get toll rates
			List<TollRateModel> tollRates = getTollRates(conn);
			request.setAttribute("tollRates", tollRates);

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
		String query = "SELECT COUNT(*) as count FROM vehicles WHERE username = ?";
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
					  "JOIN vehicles v ON t.vehicleNo = v.vehicle_number " +
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
		String query = "SELECT t.transactionDate, tb.location as tollLocation, t.vehicleNo, t.amount, t.paymentMode " +
					  "FROM transactions t " +
					  "JOIN vehicles v ON t.vehicleNo = v.vehicle_number " +
					  "JOIN toll_booths tb ON t.boothId = tb.boothId " +
					  "WHERE v.username = ? " +
					  "ORDER BY t.transactionDate DESC LIMIT 5";
		
		try (PreparedStatement stmt = conn.prepareStatement(query)) {
			stmt.setString(1, username);
			ResultSet rs = stmt.executeQuery();
			while (rs.next()) {
				Map<String, Object> transaction = new HashMap<>();
				transaction.put("date", rs.getTimestamp("transactionDate"));
				transaction.put("location", rs.getString("tollLocation"));
				transaction.put("vehicle", rs.getString("vehicleNo"));
				transaction.put("amount", rs.getDouble("amount"));
				transaction.put("status", rs.getString("paymentMode"));
				transactions.add(transaction);
			}
		}
		return transactions;
	}

	private List<TollRateModel> getTollRates(Connection conn) throws SQLException {
		List<TollRateModel> tollRates = new ArrayList<>();
		String query = "SELECT * FROM toll_rates WHERE is_active = true ORDER BY vehicle_type";
		
		try (PreparedStatement stmt = conn.prepareStatement(query);
			 ResultSet rs = stmt.executeQuery()) {
			
			while (rs.next()) {
				TollRateModel rate = new TollRateModel(
					rs.getInt("rate_id"),
					rs.getString("vehicle_type"),
					rs.getDouble("single_pass_rate"),
					rs.getDouble("monthly_pass_rate"),
					rs.getString("description"),
					rs.getBoolean("is_active")
				);
				tollRates.add(rate);
			}
		}
		return tollRates;
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}

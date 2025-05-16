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
import java.util.*;
import com.google.gson.Gson;

/**
 * Servlet implementation class AdminDashboard
 */
@WebServlet(asyncSupported = true, urlPatterns = { "/AdminDashboard" })
public class AdminDashboardController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private final Gson gson = new Gson();
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AdminDashboardController() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		UserModel user = (UserModel) session.getAttribute("user");
		
		if (user == null || !"admin".equalsIgnoreCase(user.getAccountType())) {
			response.sendRedirect(request.getContextPath() + "/login");
			return;
		}

		String period = request.getParameter("period");
		if (period != null && request.getHeader("X-Requested-With") != null) {
			// AJAX request for chart data
			try {
				Map<String, Object> chartData = getChartData(period);
				response.setContentType("application/json");
				response.getWriter().write(gson.toJson(chartData));
				return;
			} catch (Exception e) {
				response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
				return;
			}
		}

		try {
			// Get dashboard statistics
			Map<String, Object> stats = getDashboardStats();
			request.setAttribute("stats", stats);

			// Get recent transactions
			List<Map<String, Object>> recentTransactions = getRecentTransactions();
			request.setAttribute("recentTransactions", recentTransactions);

			// Get initial chart data
			Map<String, Object> chartData = getChartData("day");
			request.setAttribute("revenueLabels", gson.toJson(chartData.get("revenueLabels")));
			request.setAttribute("revenueData", gson.toJson(chartData.get("revenueData")));
			request.setAttribute("trafficLabels", gson.toJson(chartData.get("trafficLabels")));
			request.setAttribute("trafficData", gson.toJson(chartData.get("trafficData")));

			request.getRequestDispatcher("/WEB-INF/pages/adminPages/adminDashboard.jsp").forward(request, response);
		} catch (Exception e) {
			e.printStackTrace();
			response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error loading dashboard data");
		}
	}

	private Map<String, Object> getDashboardStats() throws SQLException, ClassNotFoundException {
		Map<String, Object> stats = new HashMap<>();
		
		try (Connection conn = DbConfig.getDbConnection()) {
			// Get today's revenue and compare with yesterday
			String revenueSql = """
				SELECT 
					COALESCE(SUM(CASE WHEN DATE(transactionDate) = CURRENT_DATE THEN amount END), 0) as today_revenue,
					COALESCE(SUM(CASE WHEN DATE(transactionDate) = DATE_SUB(CURRENT_DATE, INTERVAL 1 DAY) THEN amount END), 0) as yesterday_revenue
				FROM transactions
				WHERE DATE(transactionDate) >= DATE_SUB(CURRENT_DATE, INTERVAL 1 DAY)
			""";
			
			// Get vehicle count for today and yesterday
			String vehicleSql = """
				SELECT 
					COUNT(CASE WHEN DATE(transactionDate) = CURRENT_DATE THEN 1 END) as today_vehicles,
					COUNT(CASE WHEN DATE(transactionDate) = DATE_SUB(CURRENT_DATE, INTERVAL 1 DAY) THEN 1 END) as yesterday_vehicles
				FROM transactions
				WHERE DATE(transactionDate) >= DATE_SUB(CURRENT_DATE, INTERVAL 1 DAY)
			""";
			
			// Get booth statistics
			String boothSql = """
				SELECT 
					COUNT(*) as total_booths,
					COUNT(CASE WHEN status = 'active' THEN 1 END) as active_booths,
					COUNT(CASE WHEN status = 'inactive' THEN 1 END) as inactive_booths
				FROM toll_booths
			""";
			
			// Get new customers count
			String customerSql = """
				SELECT 
					COUNT(*) as total_customers
				FROM User 
				WHERE account_type = 'customer'
			""";
			
			try (PreparedStatement revenueStmt = conn.prepareStatement(revenueSql);
				 PreparedStatement vehicleStmt = conn.prepareStatement(vehicleSql);
				 PreparedStatement boothStmt = conn.prepareStatement(boothSql);
				 PreparedStatement customerStmt = conn.prepareStatement(customerSql)) {
				
				// Get revenue stats
				ResultSet revenueRs = revenueStmt.executeQuery();
				if (revenueRs.next()) {
					double todayRevenue = revenueRs.getDouble("today_revenue");
					double yesterdayRevenue = revenueRs.getDouble("yesterday_revenue");
					stats.put("todayRevenue", todayRevenue);
					stats.put("revenueChange", calculatePercentageChange(yesterdayRevenue, todayRevenue));
				}
				
				// Get vehicle stats
				ResultSet vehicleRs = vehicleStmt.executeQuery();
				if (vehicleRs.next()) {
					int todayVehicles = vehicleRs.getInt("today_vehicles");
					int yesterdayVehicles = vehicleRs.getInt("yesterday_vehicles");
					stats.put("todayVehicles", todayVehicles);
					stats.put("vehicleChange", calculatePercentageChange(yesterdayVehicles, todayVehicles));
				}
				
				// Get booth stats
				ResultSet boothRs = boothStmt.executeQuery();
				if (boothRs.next()) {
					int totalBooths = boothRs.getInt("total_booths");
					int activeBooths = boothRs.getInt("active_booths");
					int inactiveBooths = boothRs.getInt("inactive_booths");
					stats.put("totalBooths", totalBooths);
					stats.put("activeBooths", activeBooths);
					stats.put("inactiveBooths", inactiveBooths);
				}
				
				// Get customer stats
				ResultSet customerRs = customerStmt.executeQuery();
				if (customerRs.next()) {
					int totalCustomers = customerRs.getInt("total_customers");
					stats.put("todayCustomers", totalCustomers);
					stats.put("customerChange", 0.0); // No change calculation since we don't have date info
				}
			}
		}
		return stats;
	}

	private List<Map<String, Object>> getRecentTransactions() throws SQLException, ClassNotFoundException {
		List<Map<String, Object>> transactions = new ArrayList<>();
		String sql = """
			SELECT 
				t.transactionId,
				t.boothId,
				t.vehicleNo,
				t.amount,
				t.transactionDate,
				t.paymentMode as status
			FROM transactions t
			ORDER BY t.transactionDate DESC
			LIMIT 10
		""";
		
		try (Connection conn = DbConfig.getDbConnection();
			 PreparedStatement stmt = conn.prepareStatement(sql)) {
			
			ResultSet rs = stmt.executeQuery();
			while (rs.next()) {
				Map<String, Object> tx = new HashMap<>();
				tx.put("transactionId", rs.getString("transactionId"));
				tx.put("boothId", rs.getString("boothId"));
				tx.put("vehicleNo", rs.getString("vehicleNo"));
				tx.put("amount", rs.getDouble("amount"));
				tx.put("date", rs.getTimestamp("transactionDate"));
				tx.put("status", rs.getString("status"));
				transactions.add(tx);
			}
		}
		return transactions;
	}

	private Map<String, Object> getChartData(String period) throws SQLException, ClassNotFoundException {
		Map<String, Object> chartData = new HashMap<>();
		String timeFormat;
		String groupBy;
		String dateRange;
		
		switch (period.toLowerCase()) {
			case "week":
				timeFormat = "%Y-%m-%d";
				groupBy = "DATE(transactionDate)";
				dateRange = "DATE_SUB(CURRENT_DATE, INTERVAL 7 DAY)";
				break;
			case "month":
				timeFormat = "%Y-%m-%d";
				groupBy = "DATE(transactionDate)";
				dateRange = "DATE_SUB(CURRENT_DATE, INTERVAL 30 DAY)";
				break;
			default: // day
				timeFormat = "%H:00";
				groupBy = "HOUR(transactionDate)";
				dateRange = "CURRENT_DATE";
				break;
		}
		
		String sql = String.format("""
			SELECT 
				DATE_FORMAT(transactionDate, '%s') as label,
				SUM(amount) as revenue,
				COUNT(*) as traffic
			FROM transactions
			WHERE DATE(transactionDate) >= %s
			GROUP BY %s
			ORDER BY transactionDate
		""", timeFormat, dateRange, groupBy);
		
		List<String> labels = new ArrayList<>();
		List<Double> revenueData = new ArrayList<>();
		List<Integer> trafficData = new ArrayList<>();
		
		try (Connection conn = DbConfig.getDbConnection();
			 PreparedStatement stmt = conn.prepareStatement(sql)) {
			
			ResultSet rs = stmt.executeQuery();
			while (rs.next()) {
				labels.add(rs.getString("label"));
				revenueData.add(rs.getDouble("revenue"));
				trafficData.add(rs.getInt("traffic"));
			}
		}
		
		chartData.put("revenueLabels", labels);
		chartData.put("revenueData", revenueData);
		chartData.put("trafficLabels", labels);
		chartData.put("trafficData", trafficData);
		
		return chartData;
	}

	private double calculatePercentageChange(double oldValue, double newValue) {
		if (oldValue == 0) return newValue > 0 ? 100 : 0;
		return ((newValue - oldValue) / oldValue) * 100;
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}

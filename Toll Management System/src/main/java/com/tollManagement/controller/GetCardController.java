package com.tollManagement.controller;

import com.tollManagement.config.DbConfig;
import com.tollManagement.model.RFIDCardModel;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Servlet implementation class GetCardController
 * @author Samir yadav
 * @lmuId 23048505
 */
@WebServlet(asyncSupported = true, urlPatterns = { "/GetCardController" })
public class GetCardController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GetCardController() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            HttpSession session = request.getSession();
            String username = (String) session.getAttribute("username");
            
            System.out.println("GetCardController: Username = " + username);
            
            if (username == null) {
                System.out.println("GetCardController: No username found in session, redirecting to login");
                response.sendRedirect(request.getContextPath() + "/login");
                return;
            }

            try (Connection conn = DbConfig.getDbConnection()) {
                System.out.println("GetCardController: Database connection established");
                
                // Get user's card details
                String query = """
                    SELECT card_id, card_number, status 
                    FROM rfid_cards 
                    WHERE username = ? 
                    AND status IN ('ACTIVE', 'PENDING')
                    ORDER BY card_id DESC
                    LIMIT 1
                    """;
                
                try (PreparedStatement stmt = conn.prepareStatement(query)) {
                    stmt.setString(1, username);
                    System.out.println("GetCardController: Executing query to get card details");
                    ResultSet rs = stmt.executeQuery();
                    
                    if (rs.next()) {
                        int cardId = rs.getInt("card_id");
                        String cardNumber = rs.getString("card_number");
                        String status = rs.getString("status");
                        
                        System.out.println("GetCardController: Found card - ID: " + cardId + ", Number: " + cardNumber + ", Status: " + status);
                        
                        if (status.equals("ACTIVE")) {
                            request.setAttribute("activeCard", new RFIDCardModel(
                                cardId, cardNumber, username, "", "", status, 0.0, null, null, true
                            ));
                        } else if (status.equals("PENDING")) {
                            request.setAttribute("pendingCard", new RFIDCardModel(
                                cardId, cardNumber, username, "", "", status, 0.0, null, null, false
                            ));
                        }
                    } else {
                        System.out.println("GetCardController: No cards found for user");
                    }
                } catch (SQLException e) {
                    System.out.println("GetCardController: Error executing card query: " + e.getMessage());
                    throw e;
                }

                // Fetch user's registered vehicles
                List<Map<String, String>> vehicles = getRegisteredVehicles(conn, username);
                System.out.println("GetCardController: Found " + vehicles.size() + " vehicles");
                request.setAttribute("vehicles", vehicles);

                // Get card types
                List<Map<String, String>> cardTypes = getCardTypes();
                System.out.println("GetCardController: Found " + cardTypes.size() + " card types");
                request.setAttribute("cardTypes", cardTypes);

                request.getRequestDispatcher("/WEB-INF/pages/customerPages/getCard.jsp").forward(request, response);
                System.out.println("GetCardController: Forwarding to JSP");
            } catch (SQLException | ClassNotFoundException e) {
                System.out.println("GetCardController: Database error: " + e.getMessage());
                e.printStackTrace();
                request.setAttribute("error", "Error loading page: " + e.getMessage());
                request.getRequestDispatcher("/WEB-INF/pages/customerPages/getCard.jsp").forward(request, response);
            }
        } catch (Exception e) {
            System.out.println("GetCardController: Unexpected error: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("error", "An unexpected error occurred. Please try again later.");
            request.getRequestDispatcher("/WEB-INF/pages/customerPages/getCard.jsp").forward(request, response);
        }
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		String username = (String) session.getAttribute("username");
		
		if (username == null) {
			response.sendRedirect(request.getContextPath() + "/login");
			return;
		}

		try (Connection conn = DbConfig.getDbConnection()) {
			// Get form data
			String vehicleNumber = request.getParameter("vehicle");
			String cardType = request.getParameter("cardType");
			String deliveryMethod = request.getParameter("delivery");

			if (vehicleNumber == null || vehicleNumber.isEmpty()) {
                request.setAttribute("error", "Please select a vehicle.");
                request.getRequestDispatcher("/WEB-INF/pages/customerPages/getCard.jsp").forward(request, response);
                return;
            }

            if (cardType == null || cardType.isEmpty()) {
                request.setAttribute("error", "Please select a card type.");
                request.getRequestDispatcher("/WEB-INF/pages/customerPages/getCard.jsp").forward(request, response);
                return;
            }

            if (deliveryMethod == null || deliveryMethod.isEmpty()) {
                request.setAttribute("error", "Please select a delivery method.");
                request.getRequestDispatcher("/WEB-INF/pages/customerPages/getCard.jsp").forward(request, response);
                return;
            }

			if (checkForActiveCard(conn, username)) {
				request.setAttribute("error", "You already have an active RFID card. Please cancel your existing card first.");
				request.getRequestDispatcher("/WEB-INF/pages/customerPages/getCard.jsp").forward(request, response);
				return;
			}

			// Get the vehicle ID from the database using the vehicle number
			String getVehicleIdQuery = """
                SELECT vehicle_id 
                FROM vehicle 
                WHERE vehicle_number = ? 
                """;
            
            int vehicleId = 0;
            try (PreparedStatement stmt = conn.prepareStatement(getVehicleIdQuery)) {
                stmt.setString(1, vehicleNumber);
                ResultSet rs = stmt.executeQuery();
                if (rs.next()) {
                    vehicleId = rs.getInt("vehicle_id");
                }
            }

            if (vehicleId == 0) {
                request.setAttribute("error", "Invalid vehicle selected. Please try again.");
                request.getRequestDispatcher("/WEB-INF/pages/customerPages/getCard.jsp").forward(request, response);
                return;
            }

            // Generate unique card number
            String cardNumber = generateUniqueCardNumber(conn);

            // Insert new card record with PENDING status
            String query = """
            INSERT INTO rfid_cards (card_number, username, vehicle_id, card_type, delivery_method, status, created_at)
            VALUES (?, ?, ?, ?, ?, 'PENDING', NOW())
            """;
            
            try (PreparedStatement stmt = conn.prepareStatement(query)) {
                stmt.setString(1, cardNumber);
                stmt.setString(2, username);
                stmt.setInt(3, vehicleId);
                stmt.setString(4, cardType);
                stmt.setString(5, deliveryMethod);
                stmt.executeUpdate();
            }

            // Keep form state
            request.setAttribute("vehicles", getRegisteredVehicles(conn, username));
            request.setAttribute("cardTypes", getCardTypes());
            request.setAttribute("selectedVehicle", vehicleNumber);
            request.setAttribute("selectedCardType", cardType);
            request.setAttribute("selectedDelivery", deliveryMethod);

			request.setAttribute("success", "RFID card request submitted successfully! Your card number is: " + cardNumber);
			request.setAttribute("cardNumber", cardNumber);
			request.getRequestDispatcher("/WEB-INF/pages/customerPages/getCard.jsp").forward(request, response);

		} catch (SQLException | ClassNotFoundException e) {
			e.printStackTrace();
			request.setAttribute("error", "An error occurred while processing your request. Please try again later.");
			request.getRequestDispatcher("/WEB-INF/pages/customerPages/getCard.jsp").forward(request, response);
		}
	}

	private List<Map<String, String>> getRegisteredVehicles(Connection conn, String username) throws SQLException {
        List<Map<String, String>> vehicles = new ArrayList<>();
        String query = """
                SELECT vehicle_number, vehicle_type 
                FROM vehicle 
                WHERE username = ? 
                """;
        
        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, username);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Map<String, String> vehicle = new HashMap<>();
                vehicle.put("number", rs.getString("vehicle_number"));
                vehicle.put("type", rs.getString("vehicle_type"));
                vehicles.add(vehicle);
            }
        }
        return vehicles;
    }

	private boolean checkForActiveCard(Connection conn, String username) throws SQLException {
        String query = """
                SELECT card_number, status 
                FROM rfid_cards 
                WHERE username = ? 
                AND status IN ('ACTIVE', 'PENDING')
                """;
        
        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, username);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                String status = rs.getString("status");
                if (status.equals("PENDING")) {
                    return true;
                } else {
                    return true;
                }
            }
            return false;
        }
    }


    private String generateUniqueCardNumber(Connection conn) throws SQLException {
        String query = "SELECT MAX(card_number) as max_number FROM rfid_cards";
        String baseNumber = "TP"; // TollPay prefix
        int nextNumber = 100000; // Start from 100000
        
        try (PreparedStatement stmt = conn.prepareStatement(query);
            ResultSet rs = stmt.executeQuery()) {
            if (rs.next()) {
                String maxNumber = rs.getString("max_number");
                if (maxNumber != null && maxNumber.startsWith("TP")) {
                    String numberPart = maxNumber.substring(2);
                    try {
                        nextNumber = Integer.parseInt(numberPart) + 1;
                    } catch (NumberFormatException e) {
                        // Use default if parsing fails
                    }
                }
            }
        }
        
        return baseNumber + String.format("%06d", nextNumber);
    }

	private List<Map<String, String>> getCardTypes() {
		List<Map<String, String>> cardTypes = new ArrayList<>();
		
		// Standard Card
		Map<String, String> standard = new HashMap<>();
		standard.put("id", "standard");
		standard.put("name", "Standard Card");
		standard.put("price", "200");
		standard.put("description", "Basic RFID card with standard features");
		cardTypes.add(standard);
		
		// Premium Card
		Map<String, String> premium = new HashMap<>();
		premium.put("id", "premium");
		premium.put("name", "Premium Card");
		premium.put("price", "500");
		premium.put("description", "Enhanced RFID card with additional benefits");
		cardTypes.add(premium);
		
		return cardTypes;
	}
}

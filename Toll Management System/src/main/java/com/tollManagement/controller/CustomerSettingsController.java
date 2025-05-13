package com.tollManagement.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import com.tollManagement.model.UserModel;
import com.tollManagement.service.UserSettingsService;

/**
 * Servlet implementation class CustomerSettingsController
 */
@WebServlet(asyncSupported = true, urlPatterns = { "/CustomerSettingsController" })
public class CustomerSettingsController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private UserSettingsService settingsService;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CustomerSettingsController() {
        super();
        this.settingsService = new UserSettingsService();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		UserModel user = (UserModel) session.getAttribute("user");
		
		if (user == null) {
			response.sendRedirect(request.getContextPath() + "/login");
			return;
		}
		
		// Get user details
		UserModel userDetails = settingsService.getUserDetails(user.getUsername());
		
		// Set attributes for JSP
		request.setAttribute("user", userDetails);
		
		// Check for success/error messages
		String success = request.getParameter("success");
		String error = request.getParameter("error");
		
		if (success != null) {
			request.setAttribute("successMessage", "Settings updated successfully!");
		}
		if (error != null) {
			request.setAttribute("errorMessage", "Failed to update settings. Please try again.");
		}
		
		request.getRequestDispatcher("/WEB-INF/pages/customerPages/settings.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		UserModel user = (UserModel) session.getAttribute("user");
		
		if (user == null) {
			response.sendRedirect(request.getContextPath() + "/login");
			return;
		}
		
		String action = request.getParameter("action");
		boolean success = false;
		
		if (action != null) {
			switch (action) {
				case "updateProfile":
					success = updateProfile(request, user.getUsername());
					break;
				case "updatePassword":
					success = updatePassword(request, user.getUsername());
					break;
				case "updatePreferences":
					success = updatePreferences(request, user.getUsername());
					break;
				case "updateNotifications":
					success = updateNotifications(request, user.getUsername());
					break;
			}
		}
		
		if (success) {
			response.sendRedirect(request.getContextPath() + "/CustomerSettingsController?success=true");
		} else {
			response.sendRedirect(request.getContextPath() + "/CustomerSettingsController?error=true");
		}
	}
	
	private boolean updateProfile(HttpServletRequest request, String username) {
		String firstName = request.getParameter("firstName");
		String lastName = request.getParameter("lastName");
		String email = request.getParameter("email");
		String phone = request.getParameter("phone");
		String province = request.getParameter("province");
		String postalCode = request.getParameter("postalCode");
		
		return settingsService.updateUserProfile(username, firstName, lastName, email, phone, province, postalCode);
	}
	
	private boolean updatePassword(HttpServletRequest request, String username) {
		String currentPassword = request.getParameter("currentPassword");
		String newPassword = request.getParameter("newPassword");
		
		return settingsService.updatePassword(username, currentPassword, newPassword);
	}
	
	private boolean updatePreferences(HttpServletRequest request, String username) {
		String language = request.getParameter("language");
		String currency = request.getParameter("currency");
		String theme = request.getParameter("theme");
		String defaultPaymentMethod = request.getParameter("defaultPaymentMethod");
		
		return settingsService.updatePreferences(username, language, currency, theme, defaultPaymentMethod);
	}
	
	private boolean updateNotifications(HttpServletRequest request, String username) {
		boolean emailNotifications = "on".equals(request.getParameter("emailNotifications"));
		boolean smsNotifications = "on".equals(request.getParameter("smsNotifications"));
		boolean pushNotifications = "on".equals(request.getParameter("pushNotifications"));
		boolean lowBalanceAlerts = "on".equals(request.getParameter("lowBalanceAlerts"));
		boolean paymentReceipts = "on".equals(request.getParameter("paymentReceipts"));
		boolean promotionalOffers = "on".equals(request.getParameter("promotionalOffers"));
		
		return settingsService.updateNotifications(username, emailNotifications, smsNotifications, 
												pushNotifications, lowBalanceAlerts, paymentReceipts, 
												promotionalOffers);
	}
}

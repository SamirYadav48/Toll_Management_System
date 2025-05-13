package com.tollManagement.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import com.tollManagement.model.UserModel;
import com.tollManagement.service.WalletService;

/**
 * Servlet implementation class RechargeWalletController
 */
@WebServlet(asyncSupported = true, urlPatterns = { "/RechargeWalletController" })
public class RechargeWalletController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private WalletService walletService;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public RechargeWalletController() {
        super();
        this.walletService = new WalletService();
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
		
		// Get wallet balance
		double balance = walletService.getWalletBalance(user.getUsername());
		
		// Set attributes for JSP
		request.setAttribute("user", user);
		request.setAttribute("balance", balance);
		
		// Check for success/error messages
		String success = request.getParameter("success");
		String error = request.getParameter("error");
		
		if (success != null) {
			request.setAttribute("successMessage", "Wallet recharged successfully!");
		}
		if (error != null) {
			request.setAttribute("errorMessage", "Failed to recharge wallet. Please try again.");
		}
		
		request.getRequestDispatcher("/WEB-INF/pages/customerPages/rechargeWallet.jsp").forward(request, response);
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
		
		// Handle recharge request
		String amount = request.getParameter("amount");
		String paymentMethod = request.getParameter("paymentMethod");
		
		if (amount != null && paymentMethod != null) {
			try {
				double rechargeAmount = Double.parseDouble(amount);
				boolean success = walletService.processRecharge(user.getUsername(), rechargeAmount, paymentMethod);
				
				if (success) {
					response.sendRedirect(request.getContextPath() + "/RechargeWalletController?success=true");
				} else {
					response.sendRedirect(request.getContextPath() + "/RechargeWalletController?error=true");
				}
			} catch (NumberFormatException e) {
				response.sendRedirect(request.getContextPath() + "/RechargeWalletController?error=true");
			}
		} else {
			response.sendRedirect(request.getContextPath() + "/RechargeWalletController?error=true");
		}
	}

}

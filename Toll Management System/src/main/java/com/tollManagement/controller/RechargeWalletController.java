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
 * @author Samir yadav
 * @lmuId 23048505
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
			System.out.println("User not logged in, redirecting to login page");
			response.sendRedirect(request.getContextPath() + "/login");
			return;
		}
		
		try {
			// Get wallet balance
			double balance = walletService.getWalletBalance(user.getUsername());
			System.out.println("Retrieved balance for user " + user.getUsername() + ": " + balance);
			
			// Set attributes for JSP
			request.setAttribute("user", user);
			request.setAttribute("balance", balance);
			
			// Get selected amount from request parameters
			String amountParam = request.getParameter("amount");
			if (amountParam != null) {
				try {
					double selectedAmount = Double.parseDouble(amountParam);
					request.setAttribute("selectedAmount", selectedAmount);
				} catch (NumberFormatException e) {
					System.err.println("Invalid amount format: " + amountParam);
				}
			}
			
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
			
		} catch (Exception e) {
			System.err.println("Error in doGet: " + e.getMessage());
			e.printStackTrace();
			response.sendRedirect(request.getContextPath() + "/error");
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        UserModel user = (UserModel) session.getAttribute("user");
        
        if (user == null) {
            System.out.println("User not logged in, redirecting to login page");
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        // Handle recharge request
        String amount = request.getParameter("amount");
        String paymentMethod = request.getParameter("paymentMethod");
        
        System.out.println("Received recharge request - Amount: " + amount + ", Payment Method: " + paymentMethod);
        
        if (amount != null && paymentMethod != null) {
            try {
                double rechargeAmount = Double.parseDouble(amount);
                
                if (rechargeAmount <= 0) {
                    System.out.println("Invalid amount: " + rechargeAmount);
                    response.sendRedirect(request.getContextPath() + "/RechargeWalletController?error=Invalid amount");
                    return;
                }
                
                // Calculate service fee (2%)
                double serviceFee = rechargeAmount * 0.02;
                double userAmount = rechargeAmount - serviceFee; // Amount that goes to user's wallet
                
                System.out.println("Processing recharge for user: " + user.getUsername());
                System.out.println("Recharge Amount: " + rechargeAmount + ", Service Fee: " + serviceFee + ", User Amount: " + userAmount);
                
                // Save to database - pass the total amount for transaction and user amount for wallet
                boolean success = walletService.processRecharge(user.getUsername(), rechargeAmount + serviceFee, paymentMethod, rechargeAmount, serviceFee);
                
                if (success) {
                    System.out.println("Recharge successful");
                    response.sendRedirect(request.getContextPath() + "/RechargeWalletController?success=true");
                } else {
                    System.out.println("Recharge failed");
                    response.sendRedirect(request.getContextPath() + "/RechargeWalletController?error=Transaction failed");
                }
            } catch (NumberFormatException e) {
                System.err.println("Invalid amount format: " + amount);
                response.sendRedirect(request.getContextPath() + "/RechargeWalletController?error=Invalid amount format");
            } catch (Exception e) {
                System.err.println("Unexpected error during recharge: " + e.getMessage());
                e.printStackTrace();
                response.sendRedirect(request.getContextPath() + "/RechargeWalletController?error=System error occurred");
            }
        } else {
            System.out.println("Missing parameters - Amount: " + amount + ", Payment Method: " + paymentMethod);
            response.sendRedirect(request.getContextPath() + "/RechargeWalletController?error=Missing required parameters");
        }
    }

}

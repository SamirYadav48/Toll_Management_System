package com.tollManagement.controller;
 
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;
import com.tollManagement.model.TransactionModel;
import com.tollManagement.model.UserModel;
import com.tollManagement.service.PaymentHistoryService;


/**
 * Servlet implementation class PaymentHistoryController
 */
@WebServlet(asyncSupported = true, urlPatterns = { "/PaymentHistoryController" })
public class PaymentHistoryController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private PaymentHistoryService paymentHistoryService;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public PaymentHistoryController() {
        super();
        paymentHistoryService = new PaymentHistoryService();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		UserModel user = (UserModel) session.getAttribute("user");
		
		if (user == null) {
			response.sendRedirect(request.getContextPath() + "/login.jsp");
			return;
		}

		// Get time period filter
		int days = 30; // Default to last 30 days
		String daysParam = request.getParameter("days");
		if (daysParam != null && !daysParam.isEmpty()) {
			try {
				days = Integer.parseInt(daysParam);
			} catch (NumberFormatException e) {
				// Keep default value if parsing fails
			}
		}

		// Get payment history and stats
		List<TransactionModel> paymentHistory = paymentHistoryService.getPaymentHistory(user.getUsername(), days);
//		TransactionStats stats = paymentHistoryService.getPaymentStats(user.getUsername(), days);

		// Set attributes for JSP
		request.setAttribute("paymentHistory", paymentHistory);
//		request.setAttribute("stats", stats);
		request.setAttribute("selectedDays", days);

		// Forward to JSP
		request.getRequestDispatcher("/WEB-INF/pages/customerPages/paymentHistory.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String action = request.getParameter("action");
		
		if ("downloadReceipt".equals(action)) {
			String transactionIdStr = request.getParameter("transactionId");
			if (transactionIdStr != null && !transactionIdStr.isEmpty()) {
				try {
					int transactionId = Integer.parseInt(transactionIdStr);
					byte[] receiptData = paymentHistoryService.getReceipt(transactionId);
					if (receiptData != null) {
						response.setContentType("application/pdf");
						response.setHeader("Content-Disposition", "attachment; filename=receipt_" + transactionId + ".pdf");
						response.getOutputStream().write(receiptData);
						return;
					}
				} catch (NumberFormatException e) {
					// Invalid transaction ID format
				}
			}
		}
		
		// If no action or action failed, redirect back to payment history
		response.sendRedirect(request.getContextPath() + "/PaymentHistoryController");
	}

}

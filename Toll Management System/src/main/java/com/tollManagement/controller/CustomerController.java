package com.tollManagement.controller;

import com.tollManagement.model.UserModel;
import com.tollManagement.service.CustomerService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

/**
 * Servlet implementation class CustomerController
 * @author Samir yadav
 * @lmuId 23048505
 */
@WebServlet(asyncSupported = true, urlPatterns = { "/CustomerController" })
public class CustomerController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
    private CustomerService customerService;
    
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CustomerController() {
        super();
        customerService = new CustomerService();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println("CustomerController: Starting doGet");
        
        try {
            String action = request.getParameter("action");
            String username = request.getParameter("username");
            
            if (action != null && action.equals("delete") && username != null) {
                System.out.println("CustomerController: Deleting user: " + username);
                customerService.deleteUser(username);
                response.sendRedirect("CustomerController");
                return;
            }
            
            List<UserModel> users = customerService.getAllCustomers();
            System.out.println("CustomerController: Retrieved " + (users != null ? users.size() : "null") + " users");
            request.setAttribute("users", users);
            
            System.out.println("CustomerController: Forwarding to customer.jsp");
            request.getRequestDispatcher("/WEB-INF/pages/adminPages/customer.jsp").forward(request, response);
        } catch (Exception e) {
            System.err.println("CustomerController: Error processing request: " + e.getMessage());
            e.printStackTrace();
            throw e;
        }
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
}

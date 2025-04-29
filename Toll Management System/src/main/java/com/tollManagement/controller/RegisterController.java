package com.tollManagement.controller;

import java.io.IOException;
//import com.tollManagement.util.ValidationUtil;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import com.tollManagement.config.DbConfig;
//import com.tollManagement.util.ValidationUtil;
import org.mindrot.jbcrypt.BCrypt;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(asyncSupported = true, urlPatterns = { "/register" })
public class RegisterController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/pages/common/register.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    	System.out.println("Post called");
        String firstName = request.getParameter("first_name").trim();
        String lastName = request.getParameter("last_name").trim();
        String username = request.getParameter("username").trim();
        String email = request.getParameter("email").trim();
        String phone = request.getParameter("phone").trim();
        String citizenshipNumber = request.getParameter("citizenship_number").trim();
        String accountType = request.getParameter("account_type").trim();
        String vehicleType = request.getParameter("vehicle_type").trim();
        String vehicleNumber = request.getParameter("vehicle_number").trim();
        String province = request.getParameter("province").trim();
        String postalCode = request.getParameter("postal_code").trim();
        String password = request.getParameter("password").trim();
        String confirmPassword = request.getParameter("confirm_password").trim();

//        // Basic Validations
//        if (ValidationUtil.isNullOrEmpty(firstName) || !ValidationUtil.isValidFirstName(firstName)) {
//            request.setAttribute("errorMessage", "Invalid first name.");
//            request.getRequestDispatcher("/WEB-INF/pages/common/register.jsp").forward(request, response);
//            return;
//        }
//
//        if (ValidationUtil.isNullOrEmpty(lastName) || !ValidationUtil.isValidLastName(lastName)) {
//            request.setAttribute("errorMessage", "Invalid last name.");
//            request.getRequestDispatcher("/WEB-INF/pages/common/register.jsp").forward(request, response);
//            return;
//        }
//
//        if (ValidationUtil.isNullOrEmpty(username) || username.length() <= 6 || !username.matches("[a-zA-Z0-9]+")) {
//            request.setAttribute("errorMessage", "Invalid username.");
//            request.getRequestDispatcher("/WEB-INF/pages/common/register.jsp").forward(request, response);
//            return;
//        }
//
//        if (!ValidationUtil.isValidEmail(email)) {
//            request.setAttribute("errorMessage", "Invalid email format.");
//            request.getRequestDispatcher("/WEB-INF/pages/common/register.jsp").forward(request, response);
//            return;
//        }
//
//        if (!ValidationUtil.isValidPhoneNumber(phone)) {
//            request.setAttribute("errorMessage", "Invalid phone number format.");
//            request.getRequestDispatcher("/WEB-INF/pages/common/register.jsp").forward(request, response);
//            return;
//        }
//
//        if (!ValidationUtil.isValidCitizenshipNumber(citizenshipNumber)) {
//            request.setAttribute("errorMessage", "Invalid citizenship number.");
//            request.getRequestDispatcher("/WEB-INF/pages/common/register.jsp").forward(request, response);
//            return;
//        }
//
//        if (ValidationUtil.isNullOrEmpty(accountType) ||
//            ValidationUtil.isNullOrEmpty(vehicleType) ||
//            ValidationUtil.isNullOrEmpty(vehicleNumber) ||
//            ValidationUtil.isNullOrEmpty(province) ||
//            ValidationUtil.isNullOrEmpty(postalCode)) {
//            request.setAttribute("errorMessage", "All fields are required.");
//            request.getRequestDispatcher("/WEB-INF/pages/common/register.jsp").forward(request, response);
//            return;
//        }
//
//        if (!ValidationUtil.isValidPassword(password)) {
//            request.setAttribute("errorMessage", "Password does not meet complexity requirements.");
//            request.getRequestDispatcher("/WEB-INF/pages/common/register.jsp").forward(request, response);
//            return;
//        }
//
//        if (!password.equals(confirmPassword)) {
//            request.setAttribute("errorMessage", "Passwords do not match.");
//            request.getRequestDispatcher("/WEB-INF/pages/common/register.jsp").forward(request, response);
//            return;
//        }
//        
//        System.out.println("Validation Passed");

        // Insert into database
        try (Connection conn = DbConfig.getDbConnection()) {
            String query = "INSERT INTO user (first_name, last_name, phone, password, username, citizenship_number, account_type, email, province, postal_code, vehicle_type, vehicle_number) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

            String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt());

            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setString(1, firstName);
            stmt.setString(2, lastName);
            stmt.setString(3, phone);
            stmt.setString(4, hashedPassword);
            stmt.setString(5, username);
            stmt.setString(6, citizenshipNumber);
            stmt.setString(7, accountType);
            stmt.setString(8, email);
            stmt.setString(9, province);
            stmt.setString(10, postalCode);
            stmt.setString(11, vehicleType);
            stmt.setString(12, vehicleNumber);
            

            int result = stmt.executeUpdate();
            System.out.println("data insertion Passed");
            if (result > 0) {
                request.setAttribute("successMessage", "Registration successful!");
                request.getRequestDispatcher("/WEB-INF/pages/common/login.jsp").forward(request, response);
            } else {
                request.setAttribute("errorMessage", "Failed to register user.");
                request.getRequestDispatcher("/WEB-INF/pages/common/register.jsp").forward(request, response);
                System.out.println("Error1");
            }

        } catch (ClassNotFoundException e) {
        	System.out.println("Error2");
            e.printStackTrace();
            request.setAttribute("errorMessage", "JDBC Driver not found: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/pages/common/register.jsp").forward(request, response);
        } catch (SQLException e) {
        	System.out.println("Error3");
            e.printStackTrace();
            String errorMessage = e.getMessage();

            if (errorMessage.contains("Duplicate entry") && errorMessage.contains("username")) {
                request.setAttribute("errorMessage", "Username already exists.");
            } else if (errorMessage.contains("Duplicate entry") && errorMessage.contains("email")) {
                request.setAttribute("errorMessage", "Email already exists.");
            } else if (errorMessage.contains("Duplicate entry") && errorMessage.contains("phone")) {
                request.setAttribute("errorMessage", "Phone number already exists.");
            } else {
                request.setAttribute("errorMessage", "Database error: " + errorMessage);
            }

            request.getRequestDispatcher("/WEB-INF/pages/common/register.jsp").forward(request, response);
        }
    }
}

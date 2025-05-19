package com.tollManagement.controller;

import java.io.IOException;

import com.tollManagement.util.ValidationUtil;
import com.tollManagement.model.UserModel;
import com.tollManagement.model.VehicleModel;
import com.tollManagement.service.RegisterService;
import org.mindrot.jbcrypt.BCrypt;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class RegisterController
 * @author Samir yadav
 * @lmuId 23048505
 */
@WebServlet(asyncSupported = true, urlPatterns = { "/register" })
public class RegisterController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/pages/common/register.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Get form data
        String firstName = request.getParameter("first_name");
        String lastName = request.getParameter("last_name");
        String phone = request.getParameter("phone");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirm_password");
        String username = request.getParameter("username");
        String citizenshipNumber = request.getParameter("citizenship_number");
        String accountType = request.getParameter("account_type");
        String email = request.getParameter("email");
        String province = request.getParameter("province");
        String postalCode = request.getParameter("postal_code");
        String vehicleType = request.getParameter("vehicle_type");
        String vehicleNumber = request.getParameter("vehicle_number");

        // Validate all fields
        boolean isValid = true;
        if (!ValidationUtil.isValidFirstName(firstName)) {
            request.setAttribute("firstNameError", "Invalid first name");
            isValid = false;
        }
        if (!ValidationUtil.isValidLastName(lastName)) {
            request.setAttribute("lastNameError", "Invalid last name");
            isValid = false;
        }
        if (!ValidationUtil.isValidEmail(email)) {
            request.setAttribute("emailError", "Invalid email address");
            isValid = false;
        }
        if (!ValidationUtil.isValidPhoneNumber(phone)) {
            request.setAttribute("phoneError", "Invalid phone number");
            isValid = false;
        }
        if (!ValidationUtil.isValidUsername(username)) {
            request.setAttribute("usernameError", "Invalid username");
            isValid = false;
        }
        if (!ValidationUtil.isValidPassword(password)) {
            request.setAttribute("passwordError", "Invalid password format");
            isValid = false;
        }
        if (!ValidationUtil.doPasswordsMatch(password, confirmPassword)) {
            request.setAttribute("confirmPasswordError", "Passwords don't match");
            isValid = false;
        }
        if (!ValidationUtil.isValidCitizenshipNumber(citizenshipNumber)) {
            request.setAttribute("citizenshipError", "Invalid citizenship number");
            isValid = false;
        }
        if (!ValidationUtil.isValidAccountType(accountType)) {
            request.setAttribute("accountTypeError", "Invalid account type");
            isValid = false;
        }
        if (!ValidationUtil.isValidVehicleNumber(vehicleNumber)) {
            request.setAttribute("vehicleNumberError", "Invalid vehicle number format");
            isValid = false;
        }

        if (!isValid) {
            // If validation fails, return to form with error messages
            request.setAttribute("userModel", new UserModel(username, password, accountType, firstName, lastName, 
                                                          email, phone, province, postalCode, citizenshipNumber));
            request.getRequestDispatcher("/WEB-INF/pages/common/register.jsp").forward(request, response);
            return;
        }

        // Create UserModel with validated data
        UserModel userModel = new UserModel(
            username,
            BCrypt.hashpw(password, BCrypt.gensalt()),
            accountType,
            firstName,
            lastName,
            email,
            phone,
            province,
            postalCode,
            citizenshipNumber
        );

        // Create VehicleModel
        VehicleModel vehicleModel = new VehicleModel(vehicleType, vehicleNumber, username, citizenshipNumber);

        // Register user and vehicle
        RegisterService registerService = new RegisterService();
        boolean registrationSuccess = registerService.registerUser(userModel, vehicleModel);

        if (registrationSuccess) {
            // Set success message and stay on registration page
            request.setAttribute("success", "Registration successful! Redirecting to login page...");
            request.setAttribute("redirect", true);  // Add a flag for JavaScript to handle redirect
            request.getRequestDispatcher("/WEB-INF/pages/common/register.jsp").forward(request, response);
        } else {
            // Set error message and return to registration form
            request.setAttribute("error", "Registration failed. Please try again.");
            request.setAttribute("userModel", userModel); // Preserve form data
            request.getRequestDispatcher("/WEB-INF/pages/common/register.jsp").forward(request, response);
        }
    }
}

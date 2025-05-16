<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Registration Form</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/common/register.css" />

</head>
<body 
    style="background-image: url('${pageContext.request.contextPath}/resources/register-background.jpg'); 
           background-size: cover; 
           background-position: center; 
           display: flex; 
           justify-content: center; 
           align-items: center; 
           
  backdrop-filter: blur(1px);
           min-height: 100vh;">
<div class="container">
        <div class="header">
            <h1>TollPass Management System</h1>
            <p>Create your account for seamless toll payments</p>
        </div>
        
        <!-- Add general message sections -->
        <% if (request.getAttribute("success") != null) { %>
            <div class="success-message">
                <%= request.getAttribute("success") %>
            </div>
        <% } %>
        
        <% if (request.getAttribute("error") != null) { %>
            <div class="error-message general-error">
                <%= request.getAttribute("error") %>
            </div>
        <% } %>
        
        <div class="form-container">
            <form action="${pageContext.request.contextPath}/register" method="post">
            
                <div class="form-row">
                    <div class="form-group">
                        <label for="first-name">First Name</label>
                        <input type="text" 
                               name="first_name" 
                               id="first-name" 
                               required 
                               pattern="^[a-zA-Z]{2,30}$"
                               title="First name should be 2-30 letters"
                               onchange="validateField(this)">
                        <small class="form-text error-message"></small>
                    </div>
                    <div class="form-group">
                        <label for="last-name">Last Name</label>
                        <input type="text" 
                               name="last_name" 
                               id="last-name" 
                               required 
                               pattern="^[a-zA-Z]{2,30}$"
                               title="Last name should be 2-30 letters"
                               onchange="validateField(this)">
                        <small class="form-text error-message"></small>
                    </div>
                </div>
                
            
                
                <div class="form-row">
                    <div class="form-group">
                        <label for="email">Email</label>
                        <input type="email" 
                               name="email" 
                               id="email" 
                               required 
                               pattern="[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,}$"
                               title="Please enter a valid email address"
                               onchange="validateField(this)">
                        <small class="form-text error-message"></small>
                    </div>
                    <div class="form-group">
                        <label for="phone">Phone Number</label>
                        <div class="phone-input">
                            <span class="phone-prefix">+977-</span>
                            <input type="tel" 
                                   id="phone" 
                                   name="phone" 
                                   class="phone-field" 
                                   required 
                                   pattern="^[9][0-9]{9}$"
                                   title="Please enter a valid 10-digit mobile number starting with 9"
                                   onchange="validateField(this)">
                        </div>
                        <small class="form-text error-message"></small>
                    </div>
                </div>
                
                <div class="form-row">
                    <div class="form-group">
                        <label for="password">Password</label>
                        <input type="password" 
                               name="password" 
                               id="password" 
                               required
                               pattern="^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$"
                               title="Password must be at least 8 characters long and include both letters and numbers"
                               onchange="validateField(this)">
                        <small class="form-text error-message"></small>
                    </div>
                    <div class="form-group">
                        <label for="confirm-password">Confirm Password</label>
                        <input type="password" 
                               name="confirm_password" 
                               id="confirm-password" 
                               required
                               onchange="validatePasswordMatch()">
                        <small class="form-text error-message"></small>
                    </div>
                </div>
                <div class="form-row">
    				<div class="form-group username-group">
        				<label for="username">Username</label>
       					 <input type="text" 
               				name="username" 
               				id="username" 
               				required 
               				pattern="^[a-zA-Z0-9_]{4,20}$"
               				title="Username should be 4-20 characters long and can contain letters, numbers, and underscores"
               				onchange="validateField(this)">
        				<div class="username-availability"></div>
        				 <!-- NEW: Add a div for server-side validation errors -->
        				<div class="error-message" style="color: red;">
            				${usernameError != null ? usernameError : ""}
        				</div>
    				</div>
				</div>
				
				<div class="form-row">
    				<div class="form-group">
        				<label for="citizenship-number">Citizenship Number</label>
        				<input type="text" 
               				name="citizenship_number" 
               				id="citizenship-number" 
               				required 
               				pattern="^[0-9]{10}$"
               				title="Please enter a valid 10-digit citizenship number"
               				onchange="validateField(this)">
        				 
    				</div>
				</div>
				
				
                
                <h3>Account Type</h3>
            <div class="account-type">
                <div class="account-option">
                    <input type="radio" name="account_type" id="customer" value="customer" checked>
                    <label for="customer" class="label2">Personal</label>
                    <p>For individual vehicle owners</p>
                </div>
                <div class="account-option">
                    <input type="radio" name="account_type" id="commercial" value="commercial">
                    <label for="commercial" class="label2">Commercial</label>
                    <p>For fleet operators and businesses</p>
                </div>
                <div class="account-option">
                    <input type="radio" name="account_type" id="admin" value="admin">
                    <label for="admin" class="label2">Admin</label>
                    <p>For system administrators</p>
                     
                </div>
            </div>
                
                <div class="vehicle-info">
                    <h3>Primary Vehicle Information</h3>
                    <div class="form-row">
                        <div class="form-group">
                            <label for="vehicle-type">Vehicle Type</label>
                            <select name="vehicle_type" id="vehicle-type" required>
                                <option value="">Select vehicle type</option>
                                <option value="car">Car/Jeep/Van</option>
                                <option value="lcv">Light Commercial Vehicle</option>
                                <option value="truck">Truck/Bus</option>
                                <option value="multi-axle">Multi-Axle Vehicle</option>
                                <option value="motorcycle">Motorcycle</option>
                            </select>
                             
                        </div>
                        <div class="form-group">
                            <label for="vehicle-number">Vehicle Registration Number</label>
                            <input type="text" 
                                   name="vehicle_number" 
                                   id="vehicle-number" 
                                   required 
                                   placeholder="e.g. BA0998"
                                   pattern="^[A-Z]{2}[0-9]{4}$"
                                   title="Please enter a valid vehicle number format: BA0998"
                                   style="text-transform: uppercase;">
                            <small class="form-text">Format: Province Code (2 letters) + Numbers (4 digits)</small>
                        </div>
                    </div>
                </div>
                
                
                
                <div class="form-row">
                    <div class="form-group">
                        <label for="state" class="label1">Province</label>
                        <select name="province" id="state" required>
                            <option value="">Select province</option>
                            <option value="1">Biratnagar</option>
                            <option value="2">Madhesh</option>
                            <option value="3">Bagmati</option>
                            <option value="4">Gandaki</option>
                            <option value="5">Lumbini</option>
                            <option value="6">Karnali</option>
                            <option value="7">Sudurpashchim</option>
                        </select>
                         
                    </div>
                    <div class="form-group">
                        <label for="pincode" class="label1">Postal Code</label>
                        <input type="text" name="postal_code" id="pincode" required>
                         
                    </div>
                </div>
                
                
                <div class="terms">
                        <input type="checkbox" name="agreeTerms" id="agree-terms" required>
                        <label for="agree-terms">I agree to the <a 
                            href="#">Terms of Service</a> and <a href="#">Privacy 
                            Policy</a> of TollPass</label>
                </div>
                
                <button type="submit" class="submit-btn">Create Account</button>
                
                <div class="login-link">
                    Already have an account? <a href="${pageContext.request.contextPath}/login">login</a>
                </div>
            </form>
        </div>
    </div>


    <script src="${pageContext.request.contextPath}/js/validation.js"></script>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>PathPay - Settings</title>
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/customerPagesCss/settings.css"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
</head>
<body>
    <div class="dashboard-container">
        <header class="dashboard-header">
            <div class="header-left">
                <img src="${pageContext.request.contextPath}/resources/logo.png" alt="PathPay Logo" class="logo">
                <h1>PathPay</h1>
            </div>
            <div class="header-right">
                <div class="user-info">
                    <a href="${pageContext.request.contextPath}/CustomerSettingsController" class="user-name-link">
                        <span class="user-name">${user.firstName} ${user.lastName}</span>
                    </a>
                    <div class="user-avatar">
                        <i class="fas fa-user-circle"></i>
                    </div>
                </div>
                <a href="${pageContext.request.contextPath}/login" class="logout-btn">
                    <i class="fas fa-sign-out-alt"></i>
                </a>
            </div>
        </header>

        <aside class="sidebar">
            <nav class="sidebar-nav">
                <ul>
                    <li>
                        <a href="${pageContext.request.contextPath}/CustomerDashboard">
                            <i class="fas fa-tachometer-alt"></i>
                            <span>Dashboard</span>
                        </a>
                    </li>
                    <li>
                        <a href="${pageContext.request.contextPath}/PaymentHistoryController">
                            <i class="fas fa-money-bill-wave"></i>
                            <span>Payment History</span>
                        </a>
                    </li>
                    <li>
                        <a href="${pageContext.request.contextPath}/TollLocationsController">
                            <i class="fas fa-map-marked-alt"></i>
                            <span>Toll Locations</span>
                        </a>
                    </li>
                    <li>
                        <a href="${pageContext.request.contextPath}/GetCardController">
                            <i class="fas fa-credit-card"></i>
                            <span>Get RFID Card</span>
                        </a>
                    </li>
                    <li>
                        <a href="${pageContext.request.contextPath}/RechargeWalletController">
                            <i class="fas fa-wallet"></i>
                            <span>Recharge Wallet</span>
                        </a>
                    </li>
                    <li class="active">
                        <a href="${pageContext.request.contextPath}/CustomerSettingsController">
                            <i class="fas fa-cog"></i>
                            <span>Settings</span>
                        </a>
                    </li>
                    <li>
                        <a href="${pageContext.request.contextPath}/HelpController">
                            <i class="fas fa-question-circle"></i>
                            <span>Help</span>
                        </a>
                    </li>
                </ul>
            </nav>
        </aside>

       <!-- Main Content Area -->
    <main class="main-content">      
      <!-- Settings Content -->
        <div class="settings-content">
            <!-- Settings Tabs -->
            <div class="settings-tabs">
            	<button class="tab-btn active" data-tab="profile">Profile</button>
                <button class="tab-btn" data-tab="general">General</button>
                <button class="tab-btn" data-tab="payment">Payment</button>
                <button class="tab-btn" data-tab="notifications">Notifications</button>
                <button class="tab-btn" data-tab="security">Security</button>
            </div>

            <!-- Tab Contents -->
            <div class="tab-contents">
            
            <!-- Profile Settings -->
				<div class="tab-content active" id="profile-tab">
    				<form class="settings-form">
       				 <div class="form-section">
           			 	<h3><i class="fas fa-user-circle"></i> Profile Information</h3>
            				<div class="form-group">
                				<label for="profile-name">Full Name</label>
                			<input type="text" id="profile-name" value="${user.firstName} ${user.lastName}" required>
            			</div>
            		<div class="form-group">
               		 	<label for="profile-email">Email Address</label>
               		 	<input type="email" id="profile-email" value="${user.email}" required>
            		</div>
            		<div class="form-group">
               		 	<label for="profile-phone">Phone Number</label>
               		 	<input type="tel" id="profile-phone" value="${user.phone}" required>
            		</div>
           
        			</div>

        			<div class="form-section">
           		 	<h3><i class="fas fa-key"></i> Change Password</h3>
            		<div class="form-group">
               		<label for="current-password">Current Password</label>
                		<input type="password" id="current-password" placeholder="Enter current password">
            		</div>
           		 <div class="form-group">
                		<label for="new-password">New Password</label>
                		<input type="password" id="new-password" placeholder="Enter new password">
            		</div>
            		<div class="form-group">
                		<label for="confirm-password">Confirm New Password</label>
                		<input type="password" id="confirm-password" placeholder="Confirm new password">
            		</div>
        		</div>

        		<div class="form-actions">
            			<button type="button" class="btn btn-secondary">Cancel</button>
            		<button type="submit" class="btn btn-primary">Update Profile</button>
        		</div>
    			</form>
			</div>
            
            
                <!-- General Settings -->
                <div class="tab-content" id="general-tab">
                    <form class="settings-form">
                        <div class="form-section">
                            <h3><i class="fas fa-building"></i> System Information</h3>
                            <div class="form-group">
                                <label for="system-name">System Name</label>
                                <input type="text" id="system-name" value="PathPay Toll Management">
                            </div>
                            <div class="form-group">
                                <label for="admin-email">Admin Email</label>
                                <input type="email" id="admin-email" value="admin@pathpay.com">
                            </div>
                            <div class="form-group">
                                <label for="timezone">Timezone</label>
                                <select id="timezone">
                                    <option value="UTC+05:45">Nepal (UTC+05:45)</option>
                                    <option value="UTC+05:30">India (UTC+05:30)</option>
                                    <option value="UTC+00:00">UTC</option>
                                </select>
                            </div>
                        </div>

                        <div class="form-section">
                            <h3><i class="fas fa-language"></i> Language & Region</h3>
                            <div class="form-group">
                                <label for="language">System Language</label>
                                <select id="language">
                                    <option value="en">English</option>
                                    <option value="ne">Nepali</option>
                                    <option value="hi">Hindi</option>
                                </select>
                            </div>
                            <div class="form-group">
                                <label for="currency">Default Currency</label>
                                <select id="currency">
                                    <option value="NPR">Nepalese Rupee (NPR)</option>
                                    <option value="INR">Indian Rupee (INR)</option>
                                    <option value="USD">US Dollar (USD)</option>
                                </select>
                            </div>
                            <div class="form-group">
                                <label for="date-format">Date Format</label>
                                <select id="date-format">
                                    <option value="YYYY-MM-DD">2023-12-31</option>
                                    <option value="DD/MM/YYYY">31/12/2023</option>
                                    <option value="MM/DD/YYYY">12/31/2023</option>
                                </select>
                            </div>
                        </div>

                        <div class="form-actions">
                            <button type="button" class="btn btn-secondary">Cancel</button>
                            <button type="submit" class="btn btn-primary">Save Changes</button>
                        </div>
                    </form>
                </div>

                <!-- Payment Settings -->
                <div class="tab-content" id="payment-tab">
                    <form class="settings-form">
                        <div class="form-section">
                            <h3><i class="fas fa-money-bill-wave"></i> Toll Rates</h3>
                            <div class="form-group">
                                <label for="car-rate">Car Rate (per pass)</label>
                                <div class="input-group">
                                    <span class="input-prefix">NPR</span>
                                    <input type="number" id="car-rate" value="25">
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="truck-rate">Truck Rate (per pass)</label>
                                <div class="input-group">
                                    <span class="input-prefix">NPR</span>
                                    <input type="number" id="truck-rate" value="25">
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="bus-rate">Bus Rate (per pass)</label>
                                <div class="input-group">
                                    <span class="input-prefix">NPR</span>
                                    <input type="number" id="bus-rate" value="20">
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="motorcycle-rate">Motorcycle Rate (per pass)</label>
                                <div class="input-group">
                                    <span class="input-prefix">NPR</span>
                                    <input type="number" id="motorcycle-rate" value="15">
                                </div>
                            </div>
                        </div>

                        <div class="form-section">
                            <h3><i class="fas fa-credit-card"></i> Payment Methods</h3>
                            
                            <div class="form-group checkbox-group">
                                <label>
                                    <input type="checkbox" checked> Mobile Wallet (eSewa, Khalti)
                                </label>
                            </div>
                            <div class="form-group checkbox-group">
                                <label>
                                    <input type="checkbox"> Credit/Debit Cards
                                </label>
                            </div>
                            <div class="form-group checkbox-group">
                                <label>
                                    <input type="checkbox" checked> Cash Payment
                                </label>
                            </div>
                        </div>

                        <div class="form-actions">
                            <button type="button" class="btn btn-secondary">Cancel</button>
                            <button type="submit" class="btn btn-primary">Save Changes</button>
                        </div>
                    </form>
                </div>

                <!-- Notification Settings -->
                <div class="tab-content" id="notifications-tab">
                    <form class="settings-form">
                        <div class="form-section">
                            <h3><i class="fas fa-bell"></i> Notification Preferences</h3>
                            <div class="form-group checkbox-group">
                                <label>
                                    <input type="checkbox" checked> Email Notifications
                                </label>
                            </div>
                            <div class="form-group checkbox-group">
                                <label>
                                    <input type="checkbox" checked> SMS Alerts
                                </label>
                            </div>
                            <div class="form-group checkbox-group">
                                <label>
                                    <input type="checkbox"> Push Notifications
                                </label>
                            </div>
                        </div>

                        <div class="form-section">
                            <h3><i class="fas fa-envelope"></i> Email Settings</h3>
                            <div class="form-group">
                                <label for="smtp-host">SMTP Host</label>
                                <input type="text" id="smtp-host" value="smtp.pathpay.com">
                            </div>
                            <div class="form-group">
                                <label for="smtp-port">SMTP Port</label>
                                <input type="number" id="smtp-port" value="587">
                            </div>
                            <div class="form-group">
                                <label for="smtp-username">SMTP Username</label>
                                <input type="text" id="smtp-username" value="notifications@pathpay.com">
                            </div>
                            <div class="form-group">
                                <label for="smtp-password">SMTP Password</label>
                                <input type="password" id="smtp-password" placeholder="Enter password">
                            </div>
                            <div class="form-group checkbox-group">
                                <label>
                                    <input type="checkbox" checked> Use SSL/TLS
                                </label>
                            </div>
                        </div>

                        <div class="form-actions">
                            <button type="button" class="btn btn-secondary">Cancel</button>
                            <button type="submit" class="btn btn-primary">Save Changes</button>
                        </div>
                    </form>
                </div>

                <!-- Security Settings -->
                <div class="tab-content" id="security-tab">
                    <form class="settings-form">
                        <div class="form-section">
                            <h3><i class="fas fa-shield-alt"></i> Authentication</h3>
                            <div class="form-group checkbox-group">
                                <label>
                                    <input type="checkbox"> Enable Two-Factor Authentication
                                </label>
                            </div>
                            <div class="form-group">
                                <label for="session-timeout">Session Timeout</label>
                                <select id="session-timeout">
                                    <option value="15">15 minutes</option>
                                    <option value="30" selected>30 minutes</option>
                                    <option value="60">1 hour</option>
                                    <option value="120">2 hours</option>
                                    <option value="0">Never timeout</option>
                                </select>
                            </div>
                            <div class="form-group checkbox-group">
                                <label>
                                    <input type="checkbox" checked> Require password change every 90 days
                                </label>
                            </div>
                        </div>

                        <div class="form-section">
                            <h3><i class="fas fa-lock"></i> Password Policy</h3>
                            <div class="form-group">
                                <label for="min-password-length">Minimum Password Length</label>
                                <input type="number" id="min-password-length" value="8" min="6" max="32">
                            </div>
                            <div class="form-group checkbox-group">
                                <label>
                                    <input type="checkbox" checked> Require uppercase letters
                                </label>
                            </div>
                            <div class="form-group checkbox-group">
                                <label>
                                    <input type="checkbox" checked> Require numbers
                                </label>
                            </div>
                            <div class="form-group checkbox-group">
                                <label>
                                    <input type="checkbox"> Require special characters
                                </label>
                            </div>
                        </div>

                        <div class="form-actions">
                            <button type="button" class="btn btn-secondary">Cancel</button>
                            <button type="submit" class="btn btn-primary">Save Changes</button>
                        </div>
                    </form>
                </div>
            </div>
            
        </div>
        
    </main>
    </div>
<script>
    // Tab switching functionality
    document.querySelectorAll('.tab-btn').forEach(btn => {
        btn.addEventListener('click', () => {
            // Remove active class from all buttons and contents
            document.querySelectorAll('.tab-btn').forEach(b => b.classList.remove('active'));
            document.querySelectorAll('.tab-content').forEach(c => c.classList.remove('active'));
            
            // Add active class to clicked button
            btn.classList.add('active');
            
            // Show corresponding content
            const tabId = btn.getAttribute('data-tab') + '-tab';
            document.getElementById(tabId).classList.add('active');
        });
    });

    // Menu toggle functionality
    document.querySelector('.menu-toggle').addEventListener('click', () => {
        document.querySelector('.sidebar').classList.toggle('collapsed');
        document.querySelector('.main-content').classList.toggle('expanded');
    });

    // Form submission handling (example for one form)
    document.querySelectorAll('.settings-form').forEach(form => {
        form.addEventListener('submit', function(e) {
            e.preventDefault();
            // Here you would typically make an AJAX call to save the settings
            alert('Settings saved successfully!');
            // In a real application, you would use fetch() or XMLHttpRequest
            // to send the data to your backend
        });
    });

    // Input prefix handling for payment settings
    document.querySelectorAll('.input-prefix').forEach(prefix => {
        prefix.addEventListener('click', () => {
            prefix.nextElementSibling.focus();
        });
    });
</script>
    
</body>
</html>
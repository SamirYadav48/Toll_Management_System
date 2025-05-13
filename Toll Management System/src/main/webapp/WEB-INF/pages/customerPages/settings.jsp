<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Toll Management System - Settings</title>
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/customerPagesCss/settings.css"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
</head>
<body>
    <div class="dashboard-container">
        <header class="dashboard-header">
            <div class="header-left">
                <img src="${pageContext.request.contextPath}/resources/logo.png" alt="Nepal Toll System Logo" class="logo">
                <h1>Toll Management System</h1>
            </div>
            <div class="header-right">
                <div class="user-info">
                    <a href="${pageContext.request.contextPath}/CustomerSettingsController" class="user-name-link">
                        <span class="user-name">${user.firstName} ${user.lastName}</span>
                    </a>
                    <img src="${pageContext.request.contextPath}/resources/user-avatar.jpg" alt="User Avatar" class="user-avatar">
                </div>
            </div>
        </header>

        <aside class="sidebar">
            <nav class="sidebar-nav">
                <ul>
                    <li><a href="${pageContext.request.contextPath}/CustomerDashboard"><i class="fas fa-tachometer-alt"></i> Dashboard</a></li>
                    <li><a href="${pageContext.request.contextPath}/PaymentHistoryController"><i class="fas fa-money-bill-wave"></i> Payment History</a></li>
                    <li><a href="${pageContext.request.contextPath}/TollLocationsController"><i class="fas fa-map-marked-alt"></i> Toll Locations</a></li>
                    <li><a href="${pageContext.request.contextPath}/GetCardController"><i class="fas fa-credit-card"></i> Get RFID Card</a></li>
                    <li><a href="${pageContext.request.contextPath}/RechargeWalletController"><i class="fas fa-wallet"></i> Recharge Wallet</a></li>                    
                    <li class="active"><a href="${pageContext.request.contextPath}/CustomerSettingsController"><i class="fas fa-cog"></i> Settings</a></li>
                    <li><a href="${pageContext.request.contextPath}/HelpController"><i class="fas fa-question-circle"></i> Help</a></li>
                </ul>
            </nav>
        </aside>

        <main class="main-content">
            <div class="content-header">
                <h2>Account Settings</h2>
                <div class="date-display">
                    <i class="fas fa-calendar-alt"></i>
                    <span id="current-date"></span>
                </div>
            </div>

            <div class="settings-container">
                <div class="settings-tabs">
                    <button class="tab-btn active" data-tab="profile">Profile</button>
                    <button class="tab-btn" data-tab="security">Security</button>
                    <button class="tab-btn" data-tab="preferences">Preferences</button>
                    <button class="tab-btn" data-tab="notifications">Notifications</button>
                </div>

                <div class="settings-content">
                    <!-- Profile Tab -->
                    <div id="profile" class="tab-content active">
                        <form class="settings-form" action="CustomerSettingsController" method="post">
                            <input type="hidden" name="action" value="updateProfile">
                            <div class="form-group profile-picture">
                                <label>Profile Picture</label>
                                <div class="profile-pic-container">
                                    <img src="${pageContext.request.contextPath}/resources/user-avatar.jpg" alt="Profile Picture" class="profile-pic">
                                </div>
                            </div>

                            <div class="form-group">
                                <label for="firstName">First Name</label>
                                <input type="text" id="firstName" name="firstName" value="${user.firstName}" required>
                            </div>

                            <div class="form-group">
                                <label for="lastName">Last Name</label>
                                <input type="text" id="lastName" name="lastName" value="${user.lastName}" required>
                            </div>

                            <div class="form-group">
                                <label for="email">Email Address</label>
                                <input type="email" id="email" name="email" value="${user.email}" required>
                            </div>

                            <div class="form-group">
                                <label for="phone">Phone Number</label>
                                <input type="tel" id="phone" name="phone" value="${user.phone}">
                            </div>

                            <div class="form-group">
                                <label for="province">Province</label>
                                <input type="text" id="province" name="province" value="${user.province}">
                            </div>

                            <div class="form-group">
                                <label for="postalCode">Postal Code</label>
                                <input type="text" id="postalCode" name="postalCode" value="${user.postalCode}">
                            </div>

                            <div class="form-actions">
                                <button type="button" class="cancel-btn">Cancel</button>
                                <button type="submit" class="save-btn">Save Changes</button>
                            </div>
                        </form>
                    </div>

                    <!-- Security Tab -->
                    <div id="security" class="tab-content">
                        <form class="settings-form" action="CustomerSettingsController" method="post">
                            <input type="hidden" name="action" value="updatePassword">
                            <div class="form-group">
                                <label for="currentPassword">Current Password</label>
                                <input type="password" id="currentPassword" name="currentPassword" required>
                            </div>

                            <div class="form-group">
                                <label for="newPassword">New Password</label>
                                <input type="password" id="newPassword" name="newPassword" required>
                            </div>

                            <div class="form-group">
                                <label for="confirmPassword">Confirm New Password</label>
                                <input type="password" id="confirmPassword" name="confirmPassword" required>
                            </div>

                            <div class="security-tips">
                                <h4><i class="fas fa-shield-alt"></i> Security Tips</h4>
                                <ul>
                                    <li>Use a unique password for this account</li>
                                    <li>Include numbers, symbols, and both uppercase and lowercase letters</li>
                                    <li>Avoid using personal information</li>
                                    <li>Change your password regularly</li>
                                </ul>
                            </div>

                            <div class="form-actions">
                                <button type="button" class="cancel-btn">Cancel</button>
                                <button type="submit" class="save-btn">Update Password</button>
                            </div>
                        </form>
                    </div>

                    <!-- Preferences Tab -->
                    <div id="preferences" class="tab-content">
                        <form class="settings-form" action="CustomerSettingsController" method="post">
                            <input type="hidden" name="action" value="updatePreferences">
                            <div class="form-group">
                                <label for="language">Language</label>
                                <select id="language" name="language">
                                    <option value="en" ${user.language == 'en' ? 'selected' : ''}>English</option>
                                    <option value="ne" ${user.language == 'ne' ? 'selected' : ''}>Nepali</option>
                                </select>
                            </div>

                            <div class="form-group">
                                <label for="currency">Currency</label>
                                <select id="currency" name="currency">
                                    <option value="NPR" ${user.currency == 'NPR' ? 'selected' : ''}>Nepalese Rupee (NPR)</option>
                                    <option value="USD" ${user.currency == 'USD' ? 'selected' : ''}>US Dollar (USD)</option>
                                </select>
                            </div>

                            <div class="form-group">
                                <label for="theme">Theme</label>
                                <select id="theme" name="theme">
                                    <option value="light" ${user.theme == 'light' ? 'selected' : ''}>Light</option>
                                    <option value="dark" ${user.theme == 'dark' ? 'selected' : ''}>Dark</option>
                                </select>
                            </div>

                            <div class="form-group">
                                <label for="defaultPaymentMethod">Default Payment Method</label>
                                <select id="defaultPaymentMethod" name="defaultPaymentMethod">
                                    <option value="wallet" ${user.defaultPaymentMethod == 'wallet' ? 'selected' : ''}>Wallet Balance</option>
                                    <option value="card" ${user.defaultPaymentMethod == 'card' ? 'selected' : ''}>Credit/Debit Card</option>
                                    <option value="mobile" ${user.defaultPaymentMethod == 'mobile' ? 'selected' : ''}>Mobile Banking</option>
                                    <option value="ips" ${user.defaultPaymentMethod == 'ips' ? 'selected' : ''}>Connect IPS</option>
                                </select>
                            </div>

                            <div class="form-actions">
                                <button type="button" class="cancel-btn">Cancel</button>
                                <button type="submit" class="save-btn">Save Preferences</button>
                            </div>
                        </form>
                    </div>

                    <!-- Notifications Tab -->
                    <div id="notifications" class="tab-content">
                        <form class="settings-form" action="CustomerSettingsController" method="post">
                            <input type="hidden" name="action" value="updateNotifications">
                            <div class="form-group toggle-group">
                                <label>Email Notifications</label>
                                <label class="switch">
                                    <input type="checkbox" name="emailNotifications" ${user.emailNotifications ? 'checked' : ''}>
                                    <span class="slider round"></span>
                                </label>
                            </div>

                            <div class="form-group toggle-group">
                                <label>SMS Notifications</label>
                                <label class="switch">
                                    <input type="checkbox" name="smsNotifications" ${user.smsNotifications ? 'checked' : ''}>
                                    <span class="slider round"></span>
                                </label>
                            </div>

                            <div class="form-group toggle-group">
                                <label>Push Notifications</label>
                                <label class="switch">
                                    <input type="checkbox" name="pushNotifications" ${user.pushNotifications ? 'checked' : ''}>
                                    <span class="slider round"></span>
                                </label>
                            </div>

                            <div class="notification-types">
                                <h4>Notification Types</h4>
                                
                                <div class="form-group checkbox-group">
                                    <label>
                                        <input type="checkbox" name="lowBalanceAlerts" ${user.lowBalanceAlerts ? 'checked' : ''}>
                                        <span>Low balance alerts</span>
                                    </label>
                                </div>

                                <div class="form-group checkbox-group">
                                    <label>
                                        <input type="checkbox" name="paymentReceipts" ${user.paymentReceipts ? 'checked' : ''}>
                                        <span>Toll payment receipts</span>
                                    </label>
                                </div>

                                <div class="form-group checkbox-group">
                                    <label>
                                        <input type="checkbox" name="promotionalOffers" ${user.promotionalOffers ? 'checked' : ''}>
                                        <span>Promotional offers</span>
                                    </label>
                                </div>
                            </div>

                            <div class="form-actions">
                                <button type="button" class="cancel-btn">Cancel</button>
                                <button type="submit" class="save-btn">Save Notification Settings</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </main>

        <footer class="dashboard-footer">
            <p>&copy; 2025 Nepal Toll Management System. All rights reserved.</p>
            <div class="footer-links">
                <a href="#">Privacy Policy</a>
                <a href="#">Terms of Service</a>
                <a href="#">Contact Us</a>
            </div>
        </footer>
    </div>

    <script src="${pageContext.request.contextPath}/css/settings.js"></script>
    
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
                    <span class="user-name">Bina Karki</span>
                    </a>
                    <img src="user-avatar.jpg" alt="User Avatar" class="user-avatar">
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
                    <span id="current-date">April 15, 2025</span>
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
                        <form class="settings-form">
                            <div class="form-group profile-picture">
                                <label>Profile Picture</label>
                                <div class="profile-pic-container">
                                    <img src="user-avatar.jpg" alt="Profile Picture" class="profile-pic">
                                  
                                </div>
                            </div>

                            <div class="form-group">
                                <label for="fullname">Full Name</label>
                                <input type="text" id="fullname" value="John Doe">
                            </div>

                            <div class="form-group">
                                <label for="email">Email Address</label>
                                <input type="email" id="email" value="john.doe@example.com">
                            </div>

                            <div class="form-group">
                                <label for="phone">Phone Number</label>
                                <input type="tel" id="phone" value="+977 9841XXXXXX">
                            </div>

                            <div class="form-group">
                                <label for="address">Address</label>
                                <textarea id="address">Kathmandu, Nepal</textarea>
                            </div>

                            <div class="form-group">
                                <label for="license">Driver's License Number</label>
                                <input type="text" id="license" value="NP1234567890">
                            </div>

                            <div class="form-actions">
                                <button type="button" class="cancel-btn">Cancel</button>
                                <button type="submit" class="save-btn">Save Changes</button>
                            </div>
                        </form>
                    </div>

                    <!-- Security Tab -->
                    <div id="security" class="tab-content">
                        <form class="settings-form">
                            <div class="form-group">
                                <label for="current-password">Current Password</label>
                                <input type="password" id="current-password">
                            </div>

                            <div class="form-group">
                                <label for="new-password">New Password</label>
                                <input type="password" id="new-password">
                                <div class="password-strength">
                                    <span class="strength-bar weak"></span>
                                    <span class="strength-bar medium"></span>
                                    <span class="strength-bar strong"></span>
                                    <span class="strength-text">Password strength</span>
                                </div>
                            </div>

                            <div class="form-group">
                                <label for="confirm-password">Confirm New Password</label>
                                <input type="password" id="confirm-password">
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
                        <form class="settings-form">
                            <div class="form-group">
                                <label>Language</label>
                                <select>
                                    <option selected>English</option>
                                    <option>Nepali</option>
                                </select>
                            </div>

                            <div class="form-group">
                                <label>Currency</label>
                                <select>
                                    <option selected>Nepalese Rupee (NPR)</option>
                                    <option>US Dollar (USD)</option>
                                </select>
                            </div>

                            <div class="form-group">
                                <label>Theme</label>
                                <div class="theme-options">
                                    <label class="theme-option">
                                        <input type="radio" name="theme" checked>
                                        <span class="theme-light">Light</span>
                                    </label>
                                    <label class="theme-option">
                                        <input type="radio" name="theme">
                                        <span class="theme-dark">Dark</span>
                                    </label>
                                </div>
                            </div>

                            <div class="form-group">
                                <label>Default Toll Payment Method</label>
                                <select>
                                    <option selected>Wallet Balance</option>
                                    <option>Credit/Debit Card</option>
                                    <option>Mobile Banking</option>
                                    <option>Connect IPS</option>
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
                        <form class="settings-form">
                            <div class="form-group toggle-group">
                                <label>Email Notifications</label>
                                <label class="switch">
                                    <input type="checkbox" checked>
                                    <span class="slider round"></span>
                                </label>
                            </div>

                            <div class="form-group toggle-group">
                                <label>SMS Notifications</label>
                                <label class="switch">
                                    <input type="checkbox">
                                    <span class="slider round"></span>
                                </label>
                            </div>

                            <div class="form-group toggle-group">
                                <label>Push Notifications</label>
                                <label class="switch">
                                    <input type="checkbox" checked>
                                    <span class="slider round"></span>
                                </label>
                            </div>

                            <div class="notification-types">
                                <h4>Notification Types</h4>
                                
                                <div class="form-group checkbox-group">
                                    <label>
                                        <input type="checkbox" checked>
                                        <span>Low balance alerts</span>
                                    </label>
                                </div>

                                <div class="form-group checkbox-group">
                                    <label>
                                        <input type="checkbox" checked>
                                        <span>Toll payment receipts</span>
                                    </label>
                                </div>

                                <div class="form-group checkbox-group">
                                    <label>
                                        <input type="checkbox">
                                        <span>Promotional offers</span>
                                    </label>
                                </div>

                                <div class="form-group checkbox-group">
                                    <label>
                                        <input type="checkbox" checked>
                                        <span>System updates</span>
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
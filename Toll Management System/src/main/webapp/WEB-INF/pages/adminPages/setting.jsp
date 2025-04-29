<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Settings - PathPay</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
  <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/adminPagesCss/setting.css"/>
</head>
<body>
    <!-- Sidebar Navigation -->
    <aside class="sidebar">
        <div class="sidebar-header">
            <img src="${pageContext.request.contextPath}/resources/logo.png" alt="PathPay Logo" class="logo">
            <h2>PathPay</h2>
        </div>
        <nav class="sidebar-nav">
            <ul>
                <li>
                    <a href="${pageContext.request.contextPath}/AdminDashboard">
                        <i class="fas fa-tachometer-alt"></i>
                        <span>Dashboard</span>
                    </a>
                </li>
                <li>
                    <a href="${pageContext.request.contextPath}/TollBoothsController">
                        <i class="fas fa-road"></i>
                        <span>Toll Booths</span>
                    </a>
                </li>
                <li>
                    <a href="${pageContext.request.contextPath}/TransactionController">
                        <i class="fas fa-exchange-alt"></i>
                        <span>Transactions</span>
                    </a>
                </li>
                <li>
                    <a href="${pageContext.request.contextPath}/CustomerController">
                        <i class="fas fa-users"></i>
                        <span>Customers</span>
                    </a>
                </li>
                <li class="active">
                    <a href="${pageContext.request.contextPath}/SettingController">
                        <i class="fas fa-cog"></i>
                        <span>Settings</span>
                    </a>
                </li>
            </ul>
        </nav>
    </aside>

    <!-- Main Content Area -->
    <main class="main-content">
        <!-- Top Header Bar -->
        <header class="main-header">
            <div class="header-left">
                <button class="menu-toggle">
                    <i class="fas fa-bars"></i>
                </button>
                <h1>System Settings</h1>
            </div>
            <div class="header-right">
                <div class="user-profile">
                    <img src="admin-avatar.jpg" alt="Admin Avatar">
                    <span>Admin</span>
                    <i class="fas fa-chevron-down"></i>
                </div>
                <a href="${pageContext.request.contextPath}/login" class="logout-btn">
                    <i class="fas fa-sign-out-alt"></i>
                </a>
            </div>
        </header>

        <!-- Settings Content -->
        <div class="settings-content">
            <!-- Settings Tabs -->
            <div class="settings-tabs">
                <button class="tab-btn active" data-tab="general">General</button>
                <button class="tab-btn" data-tab="payment">Payment</button>
                <button class="tab-btn" data-tab="notifications">Notifications</button>
                <button class="tab-btn" data-tab="security">Security</button>
                <button class="tab-btn" data-tab="system">System</button>
            </div>

            <!-- Tab Contents -->
            <div class="tab-contents">
                <!-- General Settings -->
                <div class="tab-content active" id="general-tab">
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
                                    <input type="number" id="car-rate" value="100">
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="truck-rate">Truck Rate (per pass)</label>
                                <div class="input-group">
                                    <span class="input-prefix">NPR</span>
                                    <input type="number" id="truck-rate" value="250">
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="bus-rate">Bus Rate (per pass)</label>
                                <div class="input-group">
                                    <span class="input-prefix">NPR</span>
                                    <input type="number" id="bus-rate" value="200">
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="motorcycle-rate">Motorcycle Rate (per pass)</label>
                                <div class="input-group">
                                    <span class="input-prefix">NPR</span>
                                    <input type="number" id="motorcycle-rate" value="50">
                                </div>
                            </div>
                        </div>

                        <div class="form-section">
                            <h3><i class="fas fa-credit-card"></i> Payment Methods</h3>
                            <div class="form-group checkbox-group">
                                <label>
                                    <input type="checkbox" checked> RFID Automatic Payment
                                </label>
                            </div>
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

                <!-- System Settings -->
                <div class="tab-content" id="system-tab">
                    <form class="settings-form">
                        <div class="form-section">
                            <h3><i class="fas fa-server"></i> System Maintenance</h3>
                            <div class="form-group">
                                <label for="backup-frequency">Auto Backup Frequency</label>
                                <select id="backup-frequency">
                                    <option value="daily">Daily</option>
                                    <option value="weekly" selected>Weekly</option>
                                    <option value="monthly">Monthly</option>
                                </select>
                            </div>
                            <div class="form-group">
                                <label for="backup-location">Backup Location</label>
                                <input type="text" id="backup-location" value="/var/backups/pathpay">
                            </div>
                            <div class="form-group checkbox-group">
                                <label>
                                    <input type="checkbox" checked> Enable System Logs
                                </label>
                            </div>
                            <div class="form-group">
                                <label for="log-retention">Log Retention Period</label>
                                <select id="log-retention">
                                    <option value="7">7 days</option>
                                    <option value="30" selected>30 days</option>
                                    <option value="90">90 days</option>
                                    <option value="365">1 year</option>
                                </select>
                            </div>
                        </div>

                        <div class="form-section">
                            <h3><i class="fas fa-plug"></i> System Updates</h3>
                            <div class="update-status">
                                <div class="update-info">
                                    <i class="fas fa-check-circle"></i>
                                    <div>
                                        <h4>Current Version</h4>
                                        <p>PathPay v2.3.1</p>
                                    </div>
                                </div>
                                <button type="button" class="btn btn-primary">
                                    <i class="fas fa-sync-alt"></i> Check for Updates
                                </button>
                            </div>
                            <div class="form-group checkbox-group">
                                <label>
                                    <input type="checkbox" checked> Enable Automatic Updates
                                </label>
                            </div>
                            <div class="form-group">
                                <label for="update-time">Preferred Update Time</label>
                                <select id="update-time">
                                    <option value="00:00-02:00">12:00 AM - 2:00 AM</option>
                                    <option value="02:00-04:00">2:00 AM - 4:00 AM</option>
                                    <option value="04:00-06:00" selected>4:00 AM - 6:00 AM</option>
                                </select>
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
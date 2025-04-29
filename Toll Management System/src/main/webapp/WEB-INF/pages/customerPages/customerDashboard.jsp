<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Toll Management System - Customer Dashboard</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/customerPagesCss/customerDashboard.css"/>
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
                    <li class="active"><a href="${pageContext.request.contextPath}/CustomerDashboard"><i class="fas fa-tachometer-alt"></i> Dashboard</a></li>
                    <li><a href="${pageContext.request.contextPath}/PaymentHistoryController"><i class="fas fa-money-bill-wave"></i> Payment History</a></li>
                    <li><a href="${pageContext.request.contextPath}/TollLocationsController"><i class="fas fa-map-marked-alt"></i> Toll Locations</a></li>
                    <li><a href="${pageContext.request.contextPath}/GetCardController"><i class="fas fa-credit-card"></i> Get RFID Card</a></li>
                    <li><a href="${pageContext.request.contextPath}/RechargeWalletController"><i class="fas fa-wallet"></i> Recharge Wallet</a></li>                    
                    <li><a href="${pageContext.request.contextPath}/CustomerSettingsController"><i class="fas fa-cog"></i> Settings</a></li>
                    <li><a href="${pageContext.request.contextPath}/HelpController"><i class="fas fa-question-circle"></i> Help</a></li>
                </ul>
            </nav>
        </aside>

        <main class="main-content">
            <div class="content-header">
                <h2>Dashboard Overview</h2>
                <div class="date-display">
                    <i class="fas fa-calendar-alt"></i>
                    <span id="current-date">April 15, 2025</span>
                </div>
            </div>

            <div class="stats-cards">
                <div class="stat-card balance-card">
                    <div class="card-icon">
                        <i class="fas fa-wallet"></i>
                    </div>
                    <div class="card-content">
                        <h3>Account Balance</h3>
                        <p class="amount">NPR 1,250.00</p>
                        <a href="#" class="top-up-btn">Top Up Now</a>
                    </div>
                </div>

                <div class="stat-card vehicle-card">
                    <div class="card-icon">
                        <i class="fas fa-car"></i>
                    </div>
                    <div class="card-content">
                        <h3>Registered Vehicles</h3>
                        <p class="count">2 Vehicles</p>
                        <a href="#" class="manage-btn">Manage Vehicles</a>
                    </div>
                </div>

                <div class="stat-card toll-card">
                    <div class="card-icon">
                        <i class="fas fa-road"></i>
                    </div>
                    <div class="card-content">
                        <h3>Recent Toll Passes</h3>
                        <p class="count">5 Passes (This Month)</p>
                        <a href="#" class="view-all-btn">View All</a>
                    </div>
                </div>
            </div>

            <div class="recent-activity">
                <div class="section-header">
                    <h3>Recent Toll Transactions</h3>
                    <a href="#" class="view-all">View All</a>
                </div>
                <table class="activity-table">
                    <thead>
                        <tr>
                            <th>Date & Time</th>
                            <th>Toll Location</th>
                            <th>Vehicle</th>
                            <th>Amount (NPR)</th>
                            <th>Status</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>Apr 14, 2025 09:15 AM</td>
                            <td>Nagdhunga Toll Plaza</td>
                            <td>Ba 1 Cha 1234</td>
                            <td>550.00</td>
                            <td><span class="status paid">Paid</span></td>
                        </tr>
                        <tr>
                            <td>Apr 12, 2025 03:45 PM</td>
                            <td>Thankot Toll Plaza</td>
                            <td>Ba 1 Cha 1234</td>
                            <td>550.00</td>
                            <td><span class="status paid">Paid</span></td>
                        </tr>
                        <tr>
                            <td>Apr 10, 2025 11:20 AM</td>
                            <td>Kalanki Toll Plaza</td>
                            <td>Ba 5 Pa 5678</td>
                            <td>350.00</td>
                            <td><span class="status pending">Pending</span></td>
                        </tr>
                        <tr>
                            <td>Apr 8, 2025 07:30 AM</td>
                            <td>Pharping Toll Plaza</td>
                            <td>Ba 1 Cha 1234</td>
                            <td>550.00</td>
                            <td><span class="status paid">Paid</span></td>
                        </tr>
                        <tr>
                            <td>Apr 5, 2025 05:15 PM</td>
                            <td>Koteshwor Toll Plaza</td>
                            <td>Ba 5 Pa 5678</td>
                            <td>350.00</td>
                            <td><span class="status paid">Paid</span></td>
                        </tr>
                    </tbody>
                </table>
            </div>

            <div class="toll-info">
                <div class="toll-map">
                    <h3>Major Toll Plazas in Nepal</h3>
                    <div class="map-placeholder">
                        <img src="nepal-toll-map.jpg" alt="Nepal Toll Plaza Map">
                    </div>
                </div>
                <div class="toll-rates">
                    <h3>Toll Rates (NPR)</h3>
                    <table class="rates-table">
                        <thead>
                            <tr>
                                <th>Vehicle Type</th>
                                <th>Single Pass</th>
                                <th>Monthly Pass</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>Car/Jeep/Van</td>
                                <td>550</td>
                                <td>5,500</td>
                            </tr>
                            <tr>
                                <td>Motorcycle</td>
                                <td>100</td>
                                <td>1,000</td>
                            </tr>
                            <tr>
                                <td>Mini Bus</td>
                                <td>700</td>
                                <td>7,000</td>
                            </tr>
                            <tr>
                                <td>Bus/Truck</td>
                                <td>1,100</td>
                                <td>11,000</td>
                            </tr>
                            <tr>
                                <td>Heavy Truck</td>
                                <td>1,650</td>
                                <td>16,500</td>
                            </tr>
                        </tbody>
                    </table>
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
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Toll Management System - Payment History</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/customerPagesCss/paymentHistory.css">
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
                    <li class="active"><a href="${pageContext.request.contextPath}/PaymentHistoryController"><i class="fas fa-money-bill-wave"></i> Payment History</a></li>
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
                <h2>Payment History</h2>
                <div class="date-filter">
                    <i class="fas fa-calendar-alt"></i>
                    <select id="time-period">
                        <option value="7">Last 7 Days</option>
                        <option value="30" selected>Last 30 Days</option>
                        <option value="90">Last 3 Months</option>
                        <option value="365">Last Year</option>
                        <option value="0">All Time</option>
                    </select>
                </div>
            </div>

            <div class="payment-history">
                <div class="stats-summary">
                    <div class="stat-box">
                        <div class="stat-value">NPR 8,250.00</div>
                        <div class="stat-label">Total Spent</div>
                    </div>
                    <div class="stat-box">
                        <div class="stat-value">24</div>
                        <div class="stat-label">Total Transactions</div>
                    </div>
                    <div class="stat-box">
                        <div class="stat-value">NPR 550.00</div>
                        <div class="stat-label">Average per Trip</div>
                    </div>
                </div>

                <div class="transactions-table">
                    <table>
                        <thead>
                            <tr>
                                <th>Date</th>
                                <th>Transaction ID</th>
                                <th>Toll Plaza</th>
                                <th>Vehicle</th>
                                <th>Payment Method</th>
                                <th>Amount (NPR)</th>
                                <th>Status</th>
                                <th>Receipt</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>Apr 14, 2025</td>
                                <td>#TXN20251404</td>
                                <td>Nagdhunga</td>
                                <td>Ba 1 Cha 1234</td>
                                <td>Wallet</td>
                                <td>550.00</td>
                                <td><span class="status success">Success</span></td>
                                <td><button class="receipt-btn"><i class="fas fa-download"></i></button></td>
                            </tr>
                            <!-- More rows would go here -->
                        </tbody>
                    </table>
                </div>

                <div class="pagination">
                    <button class="page-btn" disabled><i class="fas fa-chevron-left"></i></button>
                    <button class="page-btn active">1</button>
                    <button class="page-btn">2</button>
                    <button class="page-btn">3</button>
                    <button class="page-btn"><i class="fas fa-chevron-right"></i></button>
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

    <script>
    document.addEventListener('DOMContentLoaded', function() {
        // Time period filter
        const timePeriodSelect = document.getElementById('time-period');
        timePeriodSelect.addEventListener('change', function() {
            // In a real app, this would fetch filtered data
            console.log('Filtering for last ' + this.value + ' days');
        });

        // Receipt download buttons
        document.querySelectorAll('.receipt-btn').forEach(btn => {
            btn.addEventListener('click', function() {
                // In a real app, this would download the receipt
                alert('Downloading receipt...');
            });
        });

        // Pagination buttons
        document.querySelectorAll('.page-btn:not(:disabled)').forEach(btn => {
            btn.addEventListener('click', function() {
                if (!this.classList.contains('active')) {
                    document.querySelector('.page-btn.active').classList.remove('active');
                    this.classList.add('active');
                    // In a real app, this would load the page
                }
            });
        });
    });
    </script>
</body>
</html>
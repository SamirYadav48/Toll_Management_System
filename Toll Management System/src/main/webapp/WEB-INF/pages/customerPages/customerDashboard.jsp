<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
                    <span class="user-name">${user.firstName} ${user.lastName}</span>
                    </a>
                    <img src="${pageContext.request.contextPath}/resources/user-avatar.jpg" alt="User Avatar" class="user-avatar">
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
                    <span id="current-date"></span>
                </div>
            </div>

            <div class="stats-cards">
                <div class="stat-card balance-card">
                    <div class="card-icon">
                        <i class="fas fa-wallet"></i>
                    </div>
                    <div class="card-content">
                        <h3>Account Balance</h3>
                        <p class="amount">NPR ${accountBalance}</p>
                        <a href="${pageContext.request.contextPath}/RechargeWalletController" class="top-up-btn">Top Up Now</a>
                    </div>
                </div>

                <div class="stat-card vehicle-card">
                    <div class="card-icon">
                        <i class="fas fa-car"></i>
                    </div>
                    <div class="card-content">
                        <h3>Registered Vehicles</h3>
                        <p class="count">${vehicleCount} Vehicles</p>
                        <a href="${pageContext.request.contextPath}/VehicleController" class="manage-btn">Manage Vehicles</a>
                    </div>
                </div>

                <div class="stat-card toll-card">
                    <div class="card-icon">
                        <i class="fas fa-road"></i>
                    </div>
                    <div class="card-content">
                        <h3>Recent Toll Passes</h3>
                        <p class="count">${recentPasses} Passes (This Month)</p>
                        <a href="${pageContext.request.contextPath}/PaymentHistoryController" class="view-all-btn">View All</a>
                    </div>
                </div>
            </div>

            <div class="recent-activity">
                <div class="section-header">
                    <h3>Recent Toll Transactions</h3>
                    <a href="${pageContext.request.contextPath}/PaymentHistoryController" class="view-all">View All</a>
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
                        <c:forEach items="${recentTransactions}" var="transaction">
                            <tr>
                                <td><fmt:formatDate value="${transaction.date}" pattern="MMM dd, yyyy hh:mm a"/></td>
                                <td>${transaction.location}</td>
                                <td>${transaction.vehicle}</td>
                                <td>${transaction.amount}</td>
                                <td><span class="status ${transaction.status.toLowerCase()}">${transaction.status}</span></td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty recentTransactions}">
                            <tr>
                                <td colspan="5" class="no-transactions">No recent transactions found</td>
                            </tr>
                        </c:if>
                    </tbody>
                </table>
            </div>

            <div class="toll-info">
                <div class="stat-card toll-locations-card">
                    <div class="card-icon">
                        <i class="fas fa-map-marked-alt"></i>
                    </div>
                    <div class="card-content">
                        <h3>Toll Locations</h3>
                        <p class="count">View All Toll Plazas</p>
                        <button onclick="window.location.href='${pageContext.request.contextPath}/TollLocationsController'" class="view-locations-btn">
                            <i class="fas fa-map-marked-alt"></i> View Locations
                        </button>
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
                            <c:forEach items="${tollRates}" var="rate">
                                <tr>
                                    <td>${rate.vehicleType}</td>
                                    <td>${rate.singlePassRate}</td>
                                    <td>${rate.monthlyPassRate}</td>
                                </tr>
                            </c:forEach>
                            <c:if test="${empty tollRates}">
                                <tr>
                                    <td colspan="3" class="no-rates">No toll rates available</td>
                                </tr>
                            </c:if>
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

    <!-- Add Leaflet CSS and JS -->
    <link rel="stylesheet" href="https://unpkg.com/leaflet@1.9.4/dist/leaflet.css" integrity="sha256-p4NxAoJBhIIN+hmNHrzRCf9tD/miZyoHS5obTRR9BMY=" crossorigin=""/>
    <script src="https://unpkg.com/leaflet@1.9.4/dist/leaflet.js" integrity="sha256-20nQCchB9co0qIjJZRGuk2/Z9VM+kNiyxNV1lvTlZBo=" crossorigin=""></script>
    
    <!-- Add custom map script -->
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            // Set current date
            const options = { year: 'numeric', month: 'long', day: 'numeric' };
            const currentDate = new Date().toLocaleDateString('en-US', options);
            document.getElementById('current-date').textContent = currentDate;

            try {
                // Check if map container exists
                const mapContainer = document.getElementById('map');
                if (!mapContainer) {
                    console.error('Map container not found!');
                    return;
                }

                // Initialize the map
                const map = L.map('map').setView([27.7172, 85.3240], 10); // Centered on Kathmandu

                // Add OpenStreetMap tiles
                L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
                    maxZoom: 19,
                    attribution: '© OpenStreetMap contributors'
                }).addTo(map);

                // Add toll plaza markers
                const tollPlazas = [
                    {
                        name: "Nagdhunga Toll Plaza",
                        location: [27.6828, 85.1833],
                        status: "Active",
                        traffic: "Medium"
                    },
                    {
                        name: "Thankot Toll Plaza",
                        location: [27.6833, 85.2000],
                        status: "Active",
                        traffic: "High"
                    },
                    {
                        name: "Kalanki Toll Plaza",
                        location: [27.7000, 85.2833],
                        status: "Active",
                        traffic: "High"
                    },
                    {
                        name: "Pharping Toll Plaza",
                        location: [27.6167, 85.2833],
                        status: "Active",
                        traffic: "Low"
                    },
                    {
                        name: "Koteshwor Toll Plaza",
                        location: [27.6833, 85.3333],
                        status: "Active",
                        traffic: "Medium"
                    }
                ];

                // Add markers for each toll plaza
                tollPlazas.forEach(plaza => {
                    const marker = L.marker(plaza.location).addTo(map);
                    
                    // Create popup content
                    const popupContent = `
                        <div class="toll-popup">
                            <h4>${plaza.name}</h4>
                            <p><strong>Status:</strong> ${plaza.status}</p>
                            <p><strong>Traffic:</strong> ${plaza.traffic}</p>
                            <a href="${pageContext.request.contextPath}/TollLocationsController?plaza=${plaza.name}" 
                               class="view-details">View Details</a>
                        </div>
                    `;
                    
                    marker.bindPopup(popupContent);
                });

                console.log('Map initialized successfully');
            } catch (error) {
                console.error('Error initializing map:', error);
            }
        });
    </script>
</body>
</html>
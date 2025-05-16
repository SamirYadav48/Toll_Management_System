<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>PathPay - Customer Dashboard</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/customerPagesCss/customerDashboard.css"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
    <div class="dashboard-container">
        <header class="dashboard-header">
            <div class="header-left">
                <img src="${pageContext.request.contextPath}/resources/logo.png" alt="PathPay Logo" class="logo">
                <h1>PathPay</h1>
            </div>
            <div class="header-right">
                <div class="search-box">
                    <input type="text" placeholder="Search transactions...">
                    <i class="fas fa-search"></i>
                </div>
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
                    <li class="active">
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
                    <li>
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
                        <p class="amount">रु <fmt:formatNumber value="${accountBalance}" pattern="#,##0.00"/></p>
                        <c:if test="${accountBalance < 500}">
                            <span class="warning-text">Low balance! Please recharge.</span>
                        </c:if>
                        <a href="${pageContext.request.contextPath}/RechargeWalletController" class="top-up-btn">
                            <i class="fas fa-plus-circle"></i> Top Up Now
                        </a>
                    </div>
                </div>

                <div class="stat-card vehicle-card">
                    <div class="card-icon">
                        <i class="fas fa-car"></i>
                    </div>
                    <div class="card-content">
                        <h3>Registered Vehicles</h3>
                        <p class="count">${vehicleCount} Vehicle<c:if test="${vehicleCount != 1}">s</c:if></p>
                        <div class="vehicle-summary">
                            <c:forEach items="${vehicleSummary}" var="type">
                                <span class="vehicle-type-tag">
                                    <i class="fas fa-${type.key eq 'Car' ? 'car' : type.key eq 'Truck' ? 'truck' : type.key eq 'Bus' ? 'bus' : 'motorcycle'}"></i>
                                    ${type.value}
                                </span>
                            </c:forEach>
                        </div>
                        <a href="${pageContext.request.contextPath}/VehicleController" class="manage-btn">
                            <i class="fas fa-cog"></i> Manage Vehicles
                        </a>
                    </div>
                </div>

                <div class="stat-card toll-card">
                    <div class="card-icon">
                        <i class="fas fa-road"></i>
                    </div>
                    <div class="card-content">
                        <h3>Monthly Passes</h3>
                        <p class="count">${recentPasses} Passes</p>
                        <span class="sub-text">This Month</span>
                        <a href="${pageContext.request.contextPath}/PaymentHistoryController" class="view-all-btn">
                            <i class="fas fa-external-link-alt"></i> View Details
                        </a>
                    </div>
                </div>
            </div>

            <!-- Charts Section -->
            <div class="charts-section">
                <div class="spending-chart">
                    <div class="section-header">
                        <h3>Spending Overview</h3>
                        <div class="time-filter">
                            <button class="active" data-period="week">Week</button>
                            <button data-period="month">Month</button>
                            <button data-period="year">Year</button>
                        </div>
                    </div>
                    <div class="chart-container">
                        <c:choose>
                            <c:when test="${empty spendingLabels || empty spendingData}">
                                <div class="no-data">
                                    <i class="fas fa-chart-line"></i>
                                    <p>No spending data available</p>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <canvas id="spendingChart"></canvas>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
                <div class="usage-chart">
                    <div class="section-header">
                        <h3>Toll Usage by Vehicle</h3>
                    </div>
                    <div class="chart-container">
                        <c:choose>
                            <c:when test="${empty usageLabels || empty usageData}">
                                <div class="no-data">
                                    <i class="fas fa-car"></i>
                                    <p>No usage data available</p>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <canvas id="usageChart"></canvas>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>

            <div class="recent-activity">
                <div class="section-header">
                    <h3>Recent Transactions</h3>
                    <a href="${pageContext.request.contextPath}/PaymentHistoryController" class="view-all">View All</a>
                </div>
                <div class="table-container">
                    <table class="activity-table">
                        <thead>
                            <tr>
                                <th>Date & Time</th>
                                <th>Toll Location</th>
                                <th>Vehicle</th>
                                <th>Amount</th>
                                <th>Status</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${recentTransactions}" var="transaction">
                                <tr>
                                    <td>
                                        <div class="transaction-date">
                                            <span class="date"><fmt:formatDate value="${transaction.date}" pattern="MMM dd, yyyy"/></span>
                                            <span class="time"><fmt:formatDate value="${transaction.date}" pattern="hh:mm a"/></span>
                                        </div>
                                    </td>
                                    <td>${transaction.location}</td>
                                    <td>
                                        <div class="vehicle-info">
                                            <i class="fas fa-${transaction.vehicleType eq 'Car' ? 'car' : transaction.vehicleType eq 'Truck' ? 'truck' : transaction.vehicleType eq 'Bus' ? 'bus' : 'motorcycle'}"></i>
                                            <div class="vehicle-details">
                                                <span class="vehicle-number">${transaction.vehicle}</span>
                                                <span class="vehicle-type">${transaction.vehicleType}</span>
                                            </div>
                                        </div>
                                    </td>
                                    <td>रु <fmt:formatNumber value="${transaction.amount}" pattern="#,##0.00"/></td>
                                    <td>
                                        <span class="status ${transaction.status.toLowerCase()}">
                                            <i class="fas fa-${transaction.status eq 'SUCCESS' ? 'check-circle' : transaction.status eq 'COMPLETED' ? 'check-circle' : 'exclamation-circle'}"></i>
                                            ${transaction.status}
                                        </span>
                                    </td>
                                </tr>
                            </c:forEach>
                            <c:if test="${empty recentTransactions}">
                                <tr>
                                    <td colspan="5" class="no-transactions">
                                        <div class="empty-state">
                                            <i class="fas fa-receipt"></i>
                                            <p>No recent transactions found</p>
                                        </div>
                                    </td>
                                </tr>
                            </c:if>
                        </tbody>
                    </table>
                </div>
            </div>
        </main>
    </div>

    <!-- Hidden inputs for chart data -->
    <input type="hidden" id="spendingLabels" value='${spendingLabels}'>
    <input type="hidden" id="spendingData" value='${spendingData}'>
    <input type="hidden" id="usageLabels" value='${usageLabels}'>
    <input type="hidden" id="usageData" value='${usageData}'>

    <style>
        .no-data {
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            height: 100%;
            color: #666;
            padding: 2rem;
        }
        
        .no-data i {
            font-size: 3rem;
            margin-bottom: 1rem;
            color: #ccc;
        }
        
        .no-data p {
            font-size: 1rem;
            text-align: center;
        }
    </style>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const options = { weekday: 'long', year: 'numeric', month: 'long', day: 'numeric' };
            const currentDate = new Date().toLocaleDateString('en-US', options);
            document.getElementById('current-date').textContent = currentDate;

            // Only initialize charts if data exists
            const spendingLabelsEl = document.getElementById('spendingLabels');
            const spendingDataEl = document.getElementById('spendingData');
            const usageLabelsEl = document.getElementById('usageLabels');
            const usageDataEl = document.getElementById('usageData');

            if (spendingLabelsEl && spendingDataEl) {
                const spendingLabels = JSON.parse(spendingLabelsEl.value || '[]');
                const spendingData = JSON.parse(spendingDataEl.value || '[]');
                
                if (spendingLabels.length > 0 && document.getElementById('spendingChart')) {
                    const spendingChart = new Chart(document.getElementById('spendingChart').getContext('2d'), {
                        type: 'line',
                        data: {
                            labels: spendingLabels,
                            datasets: [{
                                label: 'Spending (रु)',
                                data: spendingData,
                                borderColor: '#4CAF50',
                                tension: 0.3,
                                fill: true,
                                backgroundColor: 'rgba(76, 175, 80, 0.1)'
                            }]
                        },
                        options: {
                            responsive: true,
                            maintainAspectRatio: false,
                            scales: {
                                y: {
                                    beginAtZero: true
                                }
                            }
                        }
                    });
                }
            }

            if (usageLabelsEl && usageDataEl) {
                const usageLabels = JSON.parse(usageLabelsEl.value || '[]');
                const usageData = JSON.parse(usageDataEl.value || '[]');
                
                if (usageLabels.length > 0 && document.getElementById('usageChart')) {
                    const usageChart = new Chart(document.getElementById('usageChart').getContext('2d'), {
                        type: 'doughnut',
                        data: {
                            labels: usageLabels,
                            datasets: [{
                                data: usageData,
                                backgroundColor: [
                                    '#4CAF50',
                                    '#2196F3',
                                    '#FFC107',
                                    '#9C27B0',
                                    '#F44336'
                                ]
                            }]
                        },
                        options: {
                            responsive: true,
                            maintainAspectRatio: false
                        }
                    });
                }
            }
        });
    </script>
</body>
</html>
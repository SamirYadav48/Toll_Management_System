<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - PathPay</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/adminPagesCss/adminDashboard.css"/>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
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
                <li class="active">
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
                <li>
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
                <h1>Dashboard Overview</h1>
            </div>
            <div class="header-right">
                <div class="search-box">
                    <input type="text" placeholder="Search...">
                    <i class="fas fa-search"></i>
                </div>
                <div class="user-profile" id="userProfile">
                    <a href="${pageContext.request.contextPath}/SettingController"><i class="fas fa-user"></i>
                    <span class="user-name">${user.firstName} ${user.lastName}</span>
                    </a>
                </div>
                <a href="${pageContext.request.contextPath}/login" class="logout-btn"><i class="fas fa-sign-out-alt"></i></a>
            </div>
        </header>

        <!-- Dashboard Content -->
        <div class="dashboard-content">
            <!-- Summary Cards -->
            <div class="summary-cards">
                <div class="card">
                    <div class="card-icon bg-blue">
                        <i class="fas fa-money-bill-wave"></i>
                    </div>
                    <div class="card-info">
                        <h3>Today's Revenue</h3>
                        <p>रु<fmt:formatNumber value="${stats.todayRevenue}" pattern="#,##0.00"/></p>
                        <span class="${stats.revenueChange >= 0 ? 'positive' : 'negative'}">
                            <i class="fas fa-${stats.revenueChange >= 0 ? 'arrow-up' : 'arrow-down'}"></i>
                            <fmt:formatNumber value="${stats.revenueChange}" pattern="#,##0.0"/>% from yesterday
                        </span>
                    </div>
                </div>
                <div class="card">
                    <div class="card-icon bg-green">
                        <i class="fas fa-car"></i>
                    </div>
                    <div class="card-info">
                        <h3>Vehicles Today</h3>
                        <p><fmt:formatNumber value="${stats.todayVehicles}" pattern="#,##0"/></p>
                        <span class="${stats.vehicleChange >= 0 ? 'positive' : 'negative'}">
                            <i class="fas fa-${stats.vehicleChange >= 0 ? 'arrow-up' : 'arrow-down'}"></i>
                            <fmt:formatNumber value="${stats.vehicleChange}" pattern="#,##0.0"/>% from yesterday
                        </span>
                    </div>
                </div>
                <div class="card">
                    <div class="card-icon bg-orange">
                        <i class="fas fa-road"></i>
                    </div>
                    <div class="card-info">
                        <h3>Active Booths</h3>
                        <p>${stats.activeBooths}/${stats.totalBooths}</p>
                        <span class="${stats.inactiveBooths == 0 ? 'positive' : 'negative'}">
                            <i class="fas fa-${stats.inactiveBooths == 0 ? 'check-circle' : 'exclamation-circle'}"></i>
                            <c:choose>
                                <c:when test="${stats.inactiveBooths == 0}">All booths online</c:when>
                                <c:otherwise>${stats.inactiveBooths} booth(s) offline</c:otherwise>
                            </c:choose>
                        </span>
                    </div>
                </div>
                <div class="card">
                    <div class="card-icon bg-purple">
                        <i class="fas fa-users"></i>
                    </div>
                    <div class="card-info">
                        <h3>Total Customers</h3>
                        <p><fmt:formatNumber value="${stats.todayCustomers}" pattern="#,##0"/></p>
                        <span class="info">
                            <i class="fas fa-users"></i>
                            Registered Users
                        </span>
                    </div>
                </div>
            </div>

            <!-- Recent Transactions -->
            <div class="recent-transactions">
                <div class="section-header">
                    <h2>Recent Transactions</h2>
                    <a href="${pageContext.request.contextPath}/TransactionController" class="view-all">View All</a>
                </div>
                <div class="table-container">
                    <table>
                        <thead>
                            <tr>
                                <th>Transaction ID</th>
                                <th>Booth</th>
                                <th>Vehicle</th>
                                <th>Amount</th>
                                <th>Time</th>
                                <th>Status</th>
                            </tr>
                        </thead>
                        <tbody id="transactionsTableBody">
                            <c:forEach items="${recentTransactions}" var="tx">
                                <tr>
                                    <td>#TRX-${tx.transactionId}</td>
                                    <td>${tx.boothId}</td>
                                    <td>${tx.vehicleNo}</td>
                                    <td>रु <fmt:formatNumber value="${tx.amount}" pattern="#,##0.00"/></td>
                                    <td><fmt:formatDate value="${tx.date}" pattern="MMM dd, yyyy HH:mm"/></td>
                                    <td><span class="status ${tx.status.toLowerCase()}">${tx.status}</span></td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>

            <!-- Charts Section -->
            <div class="charts-section">
                <div class="revenue-chart">
                    <div class="section-header">
                        <h2>Revenue Overview</h2>
                        <div class="time-filter">
                            <button class="active" data-period="day">Today</button>
                            <button data-period="week">Week</button>
                            <button data-period="month">Month</button>
                        </div>
                    </div>
                    <div class="chart-container">
                        <canvas id="revenueChart"></canvas>
                    </div>
                </div>
                <div class="traffic-chart">
                    <div class="section-header">
                        <h2>Traffic Flow (Vehicles)</h2>
                    </div>
                    <div class="chart-container">
                        <canvas id="trafficChart"></canvas>
                    </div>
                </div>
            </div>
        </div>
    </main>

    <!-- Hidden inputs for chart data -->
    <input type="hidden" id="revenueLabels" value='${revenueLabels}'>
    <input type="hidden" id="revenueData" value='${revenueData}'>
    <input type="hidden" id="trafficLabels" value='${trafficLabels}'>
    <input type="hidden" id="trafficData" value='${trafficData}'>

    <script>
        // Parse the chart data from hidden inputs
        const revenueLabels = JSON.parse(document.getElementById('revenueLabels').value);
        const revenueData = JSON.parse(document.getElementById('revenueData').value);
        const trafficLabels = JSON.parse(document.getElementById('trafficLabels').value);
        const trafficData = JSON.parse(document.getElementById('trafficData').value);

        // Initialize Revenue Chart
        const revenueChart = new Chart(document.getElementById('revenueChart').getContext('2d'), {
            type: 'line',
            data: {
                labels: revenueLabels,
                datasets: [{
                    label: 'Revenue (रु)',
                    data: revenueData,
                    borderColor: '#4CAF50',
                    tension: 0.1,
                    fill: false
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                scales: {
                    y: {
                        beginAtZero: true,
                        ticks: {
                            callback: function(value) {
                                return 'रु ' + value.toLocaleString('en-IN', {
                                    maximumFractionDigits: 2,
                                    minimumFractionDigits: 2
                                });
                            }
                        }
                    }
                },
                plugins: {
                    tooltip: {
                        callbacks: {
                            label: function(context) {
                                return 'Revenue: रु ' + context.parsed.y.toLocaleString('en-IN', {
                                    maximumFractionDigits: 2,
                                    minimumFractionDigits: 2
                                });
                            }
                        }
                    }
                }
            }
        });

        // Initialize Traffic Chart
        const trafficChart = new Chart(document.getElementById('trafficChart').getContext('2d'), {
            type: 'bar',
            data: {
                labels: trafficLabels,
                datasets: [{
                    label: 'Number of Vehicles',
                    data: trafficData,
                    backgroundColor: '#2196F3'
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                scales: {
                    y: {
                        beginAtZero: true,
                        ticks: {
                            stepSize: 1,
                            callback: function(value) {
                                return value.toLocaleString('en-IN');
                            }
                        }
                    }
                },
                plugins: {
                    tooltip: {
                        callbacks: {
                            label: function(context) {
                                return 'Vehicles: ' + context.parsed.y.toLocaleString('en-IN');
                            }
                        }
                    }
                }
            }
        });

        // Time filter functionality with AJAX
        document.querySelectorAll('.time-filter button').forEach(button => {
            button.addEventListener('click', function() {
                const period = this.dataset.period;
                
                // Remove active class from all buttons
                document.querySelectorAll('.time-filter button').forEach(btn => 
                    btn.classList.remove('active')
                );
                
                // Add active class to clicked button
                this.classList.add('active');
                
                // Fetch new data based on period
                $.ajax({
                    url: '${pageContext.request.contextPath}/AdminDashboard',
                    method: 'GET',
                    data: { period: period },
                    headers: {
                        'X-Requested-With': 'XMLHttpRequest'
                    },
                    success: function(data) {
                        // Update revenue chart
                        revenueChart.data.labels = data.revenueLabels;
                        revenueChart.data.datasets[0].data = data.revenueData;
                        revenueChart.update();
                        
                        // Update traffic chart
                        trafficChart.data.labels = data.trafficLabels;
                        trafficChart.data.datasets[0].data = data.trafficData;
                        trafficChart.update();
                    },
                    error: function() {
                        alert('Error fetching chart data');
                    }
                });
            });
        });

        // Sidebar toggle functionality
        document.querySelector('.menu-toggle').addEventListener('click', function() {
            document.querySelector('.sidebar').classList.toggle('collapsed');
            document.querySelector('.main-content').classList.toggle('expanded');
        });

        // Auto-refresh dashboard data every 5 minutes
        setInterval(function() {
            location.reload();
        }, 5 * 60 * 1000);
    </script>
</body>
</html>
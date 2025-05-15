<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - PathPay</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/adminPagesCss/adminDashboard.css"/>
    <!-- Add Chart.js -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>
<body>
    <!-- Keep existing sidebar code -->
    
    <!-- Main Content Area -->
    <main class="main-content">
        <!-- Keep existing header code -->
        
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
                        <p>रु${stats.todayRevenue}</p>
                        <span class="${stats.revenueChange >= 0 ? 'positive' : 'negative'}">
                            ${String.format("%.1f", stats.revenueChange)}% from yesterday
                        </span>
                    </div>
                </div>
                <div class="card">
                    <div class="card-icon bg-green">
                        <i class="fas fa-car"></i>
                    </div>
                    <div class="card-info">
                        <h3>Vehicles Today</h3>
                        <p>${stats.todayVehicles}</p>
                        <span class="${stats.vehicleChange >= 0 ? 'positive' : 'negative'}">
                            ${String.format("%.1f", stats.vehicleChange)}% from yesterday
                        </span>
                    </div>
                </div>
                <!-- Keep other cards -->
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
                        <tbody>
                            <c:forEach items="${recentTransactions}" var="tx">
                                <tr>
                                    <td>#TRX-${tx.transactionId}</td>
                                    <td>${tx.boothId}</td>
                                    <td>${tx.vehicleNo}</td>
                                    <td>रु ${tx.amount}</td>
                                    <td>${tx.date}</td>
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

    <!-- Chart Initialization Scripts -->
    <script>
        // Revenue Chart
        const revenueCtx = document.getElementById('revenueChart').getContext('2d');
        const revenueChart = new Chart(revenueCtx, {
            type: 'line',
            data: {
                labels: ${revenueLabels},
                datasets: [{
                    label: 'Revenue (रु)',
                    data: ${revenueData},
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
                                return 'रु ' + value;
                            }
                        }
                    }
                }
            }
        });

        // Traffic Flow Chart
        const trafficCtx = document.getElementById('trafficChart').getContext('2d');
        const trafficChart = new Chart(trafficCtx, {
            type: 'bar',
            data: {
                labels: ${trafficLabels},
                datasets: [{
                    label: 'Number of Vehicles',
                    data: ${trafficData},
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
                            stepSize: 1
                        }
                    }
                }
            }
        });

        // Time filter functionality
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
                fetch(`${pageContext.request.contextPath}/AdminDashboard?period=${period}`)
                    .then(response => response.json())
                    .then(data => {
                        revenueChart.data.labels = data.revenueLabels;
                        revenueChart.data.datasets[0].data = data.revenueData;
                        revenueChart.update();
                        
                        trafficChart.data.labels = data.trafficLabels;
                        trafficChart.data.datasets[0].data = data.trafficData;
                        trafficChart.update();
                    });
            });
        });
    </script>
</body>
</html>
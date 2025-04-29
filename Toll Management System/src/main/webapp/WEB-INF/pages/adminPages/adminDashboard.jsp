<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - PathPay</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/adminPagesCss/adminDashboard.css"/>
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
  					<img src="admin-avatar.jpg" alt="Admin Avatar">
  					<span><a href="${pageContext.request.contextPath}/AdminProfileController"><i class="fas fa-user"></i>Admin</a></span>
 					 <i class="fas fa-chevron-down"></i>
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
                        <p>रु12,345</p>
                        <span class="positive">+12% from yesterday</span>
                    </div>
                </div>
                <div class="card">
                    <div class="card-icon bg-green">
                        <i class="fas fa-car"></i>
                    </div>
                    <div class="card-info">
                        <h3>Vehicles Today</h3>
                        <p>2,456</p>
                        <span class="positive">+5% from yesterday</span>
                    </div>
                </div>
                <div class="card">
                    <div class="card-icon bg-orange">
                        <i class="fas fa-road"></i>
                    </div>
                    <div class="card-info">
                        <h3>Active Booths</h3>
                        <p>24/32</p>
                        <span class="negative">-2 offline</span>
                    </div>
                </div>
                <div class="card">
                    <div class="card-icon bg-purple">
                        <i class="fas fa-user-plus"></i>
                    </div>
                    <div class="card-info">
                        <h3>New Customers</h3>
                        <p>143</p>
                        <span class="positive">+8% from yesterday</span>
                    </div>
                </div>
            </div>

            <!-- Recent Transactions -->
            <div class="recent-transactions">
                <div class="section-header">
                    <h2>Recent Transactions</h2>
                    <a href="#" class="view-all">View All</a>
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
                            <tr>
                                <td>#TRX-78945</td>
                                <td>Kalanki Booth</td>
                                <td>BA 1 PA 1234</td>
                                <td>रु 15.0</td>
                                <td>10:23 AM</td>
                                <td><span class="status completed">Completed</span></td>
                            </tr>
                            <tr>
                                <td>#TRX-78944</td>
                                <td>Koteshwor Booth</td>
                                <td>BA 2 PA 5678</td>
                                <td>रु 35.00</td>
                                <td>10:21 AM</td>
                                <td><span class="status completed">Completed</span></td>
                            </tr>
                            <tr>
                                <td>#TRX-78943</td>
                                <td>Gaushala Booth</td>
                                <td>BA 1 PA 9012</td>
                                <td>रु 17.0</td>
                                <td>10:18 AM</td>
                                <td><span class="status failed">Failed</span></td>
                            </tr>
                            <tr>
                                <td>#TRX-78942</td>
                                <td>Suryabinayak Booth</td>
                                <td>BA 3 PA 3456</td>
                                <td>रु 25.0</td>
                                <td>10:15 AM</td>
                                <td><span class="status pending">Pending</span></td>
                            </tr>
                            <tr>
                                <td>#TRX-78941</td>
                                <td>Thankot Booth</td>
                                <td>BA 2 PA 7890</td>
                                <td>रु 35.0</td>
                                <td>10:12 AM</td>
                                <td><span class="status completed">Completed</span></td>
                            </tr>
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
                            <button class="active">Today</button>
                            <button>Week</button>
                            <button>Month</button>
                        </div>
                    </div>
                    <div class="chart-container">
                        <div class="chart-placeholder">
                            <p>Revenue chart (रु) will appear here</p>
                        </div>
                    </div>
                </div>
                <div class="traffic-chart">
                    <div class="section-header">
                        <h2>Traffic Flow (Vehicles)</h2>
                    </div>
                    <div class="chart-container">
                        <div class="chart-placeholder">
                            <p>Traffic chart will appear here</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </main>
    <script type="text/javascript">
    document.getElementById('userProfile').addEventListener('click', function() {
    	  this.classList.toggle('active');
    	});

    	// Close dropdown when clicking outside
    	document.addEventListener('click', function(event) {
    	  const profile = document.getElementById('userProfile');
    	  if (!profile.contains(event.target)) {
    	    profile.classList.remove('active');
    	  }
    	});
    </script>
</body>
</html>

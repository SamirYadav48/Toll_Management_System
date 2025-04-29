<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Transactions - PathPay Admin</title>
  	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/adminPagesCss/transaction.css"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">
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
                <li class="active">
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

    <!-- Main Content -->
    <main class="main-content">
        <!-- Top Header Bar -->
        <header class="main-header">
            <div class="header-left">
                <button class="menu-toggle">
                    <i class="fas fa-bars"></i>
                </button>
                <h1>Transaction History</h1>
            </div>
            <div class="header-right">
                <div class="search-box">
                    <input type="text" placeholder="Search...">
                    <i class="fas fa-search"></i>
                </div>
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

        <!-- Filters -->
        <div class="filters">
            <select>
                <option>All Highways</option>
                <option>East-West Highway</option>
                <option>Prithvi Highway</option>
                <option>Araniko Highway</option>
            </select>
            <select>
                <option>Status: All</option>
                <option>Success</option>
                <option>Failed</option>
                <option>Pending</option>
            </select>
            <input type="date">
        </div>

        <!-- Transactions Table -->
        <div class="table-container">
            <table>
                <thead>
                    <tr>
                        <th>Transaction ID</th>
                        <th>Vehicle No.</th>
                        <th>Booth</th>
                        <th>Date</th>
                        <th>Status</th>
                        <th>Amount (NPR)</th>
                        <th>Payment Mode</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>TXN-1001</td>
                        <td>BA-2-PA-4567</td>
                        <td>East-West Hwy - Butwal</td>
                        <td>2025-04-14</td>
                        <td class="status success">Success</td>
                        <td>120.00</td>
                        <td>PathPay Card</td>
                    </tr>
                    <tr>
                        <td>TXN-1002</td>
                        <td>GA-1-KA-1123</td>
                        <td>Prithvi Hwy - Mugling</td>
                        <td>2025-04-13</td>
                        <td class="status failed">Failed</td>
                        <td>150.00</td>
                        <td>Cash</td>
                    </tr>
                    <tr>
                        <td>TXN-1003</td>
                        <td>LU-3-PA-8934</td>
                        <td>Araniko Hwy - Dhulikhel</td>
                        <td>2025-04-13</td>
                        <td class="status pending">Pending</td>
                        <td>100.00</td>
                        <td>eSewa</td>
                    </tr>
                    <tr>
                        <td>TXN-1004</td>
                        <td>KO-5-KA-9988</td>
                        <td>BP Hwy - Bardibas</td>
                        <td>2025-04-12</td>
                        <td class="status success">Success</td>
                        <td>90.00</td>
                        <td>PathPay Card</td>
                    </tr>
                    <tr>
                        <td>TXN-1005</td>
                        <td>NA-3-PA-2301</td>
                        <td>Mahendra Hwy - Hetauda</td>
                        <td>2025-04-12</td>
                        <td class="status failed">Failed</td>
                        <td>130.00</td>
                        <td>Cash</td>
                    </tr>
                    <tr>
                        <td>TXN-1006</td>
                        <td>RA-7-KA-4432</td>
                        <td>Pokhara - Lekhnath Booth</td>
                        <td>2025-04-11</td>
                        <td class="status success">Success</td>
                        <td>110.00</td>
                        <td>Khalti</td>
                    </tr>
                    <tr>
                        <td>TXN-1007</td>
                        <td>JA-2-HA-1287</td>
                        <td>Mechi Hwy - Bhadrapur</td>
                        <td>2025-04-11</td>
                        <td class="status pending">Pending</td>
                        <td>115.00</td>
                        <td>PathPay Card</td>
                    </tr>
                    <tr>
                        <td>TXN-1008</td>
                        <td>MA-1-KA-5656</td>
                        <td>Mid-Hill Hwy - Rukum</td>
                        <td>2025-04-10</td>
                        <td class="status success">Success</td>
                        <td>160.00</td>
                        <td>eSewa</td>
                    </tr>
                    <tr>
                        <td>TXN-1009</td>
                        <td>DA-4-PA-7788</td>
                        <td>Ring Road - Kathmandu</td>
                        <td>2025-04-10</td>
                        <td class="status failed">Failed</td>
                        <td>140.00</td>
                        <td>Cash</td>
                    </tr>
                    <tr>
                        <td>TXN-1010</td>
                        <td>SA-6-GA-9112</td>
                        <td>BP Hwy - Dhulikhel</td>
                        <td>2025-04-09</td>
                        <td class="status success">Success</td>
                        <td>105.00</td>
                        <td>PathPay Card</td>
                    </tr>
                </tbody>
            </table>
        </div>
    </main>
</body>
</html>

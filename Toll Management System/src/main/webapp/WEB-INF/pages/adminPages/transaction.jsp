<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
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
                <li><a href="${pageContext.request.contextPath}/AdminDashboard"><i class="fas fa-tachometer-alt"></i>Dashboard</a></li>
                <li><a href="${pageContext.request.contextPath}/TollBoothsController"><i class="fas fa-road"></i>Toll Booths</a></li>
                <li class="active"><a href="${pageContext.request.contextPath}/TransactionController"><i class="fas fa-exchange-alt"></i>Transactions</a></li>
                <li><a href="${pageContext.request.contextPath}/CustomerController"><i class="fas fa-users"></i>Customers</a></li>
                <li><a href="${pageContext.request.contextPath}/SettingController"><i class="fas fa-cog"></i>Settings</a></li>
            </ul>
        </nav>
    </aside>

    <!-- Main Content -->
    <main class="main-content">
        <!-- Header -->
        <header class="main-header">
            <div class="header-left">
                <button class="menu-toggle"><i class="fas fa-bars"></i></button>
                <h1>Transaction History</h1>
            </div>
            <div class="header-right">
                <div class="search-box">
                    <input type="text" placeholder="Search..."><i class="fas fa-search"></i>
                </div>
                <div class="user-profile">
                    <img src="admin-avatar.jpg" alt="Admin Avatar"><span>Admin</span><i class="fas fa-chevron-down"></i>
                </div>
                <a href="${pageContext.request.contextPath}/login" class="logout-btn"><i class="fas fa-sign-out-alt"></i></a>
            </div>
        </header>

        <!-- Filters -->
        <div class="filters">
            <select>
                <option>All Highways</option>
                <option>East-West Highway</option>
                <option>Prithvi Highway</option>
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
                        <th>Booth ID</th>
                        <th>Date</th>
                        <th>Amount (NPR)</th>
                        <th>Payment Mode</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="txn" items="${transactionList}">
                        <tr>
                            <td>TXN-${txn.transactionId}</td>
                            <td>${txn.vehicleNo}</td>
                            <td>${txn.boothId}</td>
                            <td>${txn.transactionDate}</td>
                            <td>${txn.amount}</td>
                            <td>${txn.paymentMode}</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </main>
</body>
</html>

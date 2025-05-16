<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>PathPay - Payment History</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/customerPagesCss/paymentHistory.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>
    <div class="dashboard-container">
        <header class="dashboard-header">
            <div class="header-left">
                <img src="${pageContext.request.contextPath}/resources/logo.png" alt="PathPay Logo" class="logo">
                <h1>PathPay</h1>
            </div>
            <div class="header-right">
                
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
                <div class="date-display">
                    <i class="fas fa-calendar-alt"></i>
                    <span id="current-date"></span>
                </div>
            </div>

            <div class="stats-cards">
                <div class="stat-card">
                    <div class="card-icon">
                        <i class="fas fa-money-bill-wave"></i>
                    </div>
                    <div class="card-content">
                        <h3>Total Spent</h3>
                        <p class="amount">रु <fmt:formatNumber value="${transactionStats.totalAmount}" pattern="#,##0.00"/></p>
                    </div>
                </div>

                <div class="stat-card">
                    <div class="card-icon">
                        <i class="fas fa-exchange-alt"></i>
                    </div>
                    <div class="card-content">
                        <h3>Total Transactions</h3>
                        <p class="count">${transactionStats.totalTransactions}</p>
                    </div>
                </div>

                <div class="stat-card">
                    <div class="card-icon">
                        <i class="fas fa-chart-line"></i>
                    </div>
                    <div class="card-content">
                        <h3>Average per Trip</h3>
                        <p class="amount">रु <fmt:formatNumber value="${transactionStats.averageAmount}" pattern="#,##0.00"/></p>
                    </div>
                </div>
            </div>

            <div class="recent-activity">
                <div class="section-header">
                    <h3>Transaction History</h3>
                </div>
                <div class="table-container">
                    <table class="activity-table">
                        <thead>
                            <tr>
                                <th>Date & Time</th>
                                <th>Transaction ID</th>
                                <th>Toll Plaza</th>
                                <th>Vehicle</th>
                                <th>Payment Method</th>
                                <th>Amount</th>
                                <th>Status</th>
                                <th>Receipt</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${transactions}" var="tx">
                                <tr>
                                    <td>
                                        <div class="transaction-date">
                                            <span class="date"><fmt:formatDate value="${tx.date}" pattern="MMM dd, yyyy"/></span>
                                            <span class="time"><fmt:formatDate value="${tx.date}" pattern="hh:mm a"/></span>
                                        </div>
                                    </td>
                                    <td>${tx.transactionId}</td>
                                    <td>${tx.tollPlaza}</td>
                                    <td>
                                        <div class="vehicle-info">
                                            <i class="fas fa-${tx.vehicleType eq 'Car' ? 'car' : 
                                                      tx.vehicleType eq 'Truck' ? 'truck' : 
                                                      tx.vehicleType eq 'Bus' ? 'bus' : 'motorcycle'}"></i>
                                            <div class="vehicle-details">
                                                <span class="vehicle-number">${tx.vehicleNumber}</span>
                                                <span class="vehicle-type">${tx.vehicleType}</span>
                                            </div>
                                        </div>
                                    </td>
                                    <td>
                                        <i class="fas fa-${tx.paymentMethod eq 'RFID' ? 'credit-card' : 
                                                  tx.paymentMethod eq 'CASH' ? 'money-bill-wave' : 'wallet'}"></i>
                                        ${tx.paymentMethod}
                                    </td>
                                    <td>रु <fmt:formatNumber value="${tx.amount}" pattern="#,##0.00"/></td>
                                    <td>
                                        <span class="status ${tx.status.toLowerCase()}">
                                            <i class="fas fa-${tx.status eq 'SUCCESS' ? 'check-circle' : 
                                                      tx.status eq 'PENDING' ? 'clock' : 'exclamation-circle'}"></i>
                                            ${tx.status}
                                        </span>
                                    </td>
                                    <td>
                                        <a href="${pageContext.request.contextPath}/PaymentHistoryController/download?transactionId=${tx.transactionId}" class="receipt-btn">
                                            <i class="fas fa-download"></i>
                                        </a>
                                    </td>
                                </tr>
                            </c:forEach>
                            <c:if test="${empty transactions}">
                                <tr>
                                    <td colspan="8" class="no-transactions">
                                        <div class="empty-state">
                                            <i class="fas fa-receipt"></i>
                                            <p>No transactions found</p>
                                        </div>
                                    </td>
                                </tr>
                            </c:if>
                        </tbody>
                    </table>
                </div>

                <div class="pagination">
                    <c:if test="${currentPage > 1}">
                        <a href="?page=${currentPage - 1}" class="page-btn"><i class="fas fa-chevron-left"></i></a>
                    </c:if>
                    
                    <c:forEach begin="1" end="${totalPages}" var="page">
                        <a href="?page=${page}" class="page-btn ${page == currentPage ? 'active' : ''}">${page}</a>
                    </c:forEach>
                    
                    <c:if test="${currentPage < totalPages}">
                        <a href="?page=${currentPage + 1}" class="page-btn"><i class="fas fa-chevron-right"></i></a>
                    </c:if>
                </div>
            </div>
        </main>
    </div>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const options = { weekday: 'long', year: 'numeric', month: 'long', day: 'numeric' };
            const currentDate = new Date().toLocaleDateString('en-US', options);
            document.getElementById('current-date').textContent = currentDate;
        });
    </script>
</body>
</html>
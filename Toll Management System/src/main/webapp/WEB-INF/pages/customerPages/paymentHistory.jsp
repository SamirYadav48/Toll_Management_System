<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
                        <span class="user-name">${user.firstName} ${user.lastName}</span>
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
            </div>

            <div class="payment-history">
                <div class="stats-summary">
                    <div class="stat-box">
                        <div class="stat-value">NPR ${transactionStats.totalAmount}</div>
                        <div class="stat-label">Total Spent</div>
                    </div>
                    <div class="stat-box">
                        <div class="stat-value">${transactionStats.totalTransactions}</div>
                        <div class="stat-label">Total Transactions</div>
                    </div>
                    <div class="stat-box">
                        <div class="stat-value">NPR ${transactionStats.averageAmount}</div>
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
                            <c:forEach items="${transactions}" var="tx">
                                <tr>
                                    <td><fmt:formatDate value="${tx.date}" pattern="MMM dd, yyyy"/></td>
                                    <td>${tx.transactionId}</td>
                                    <td>${tx.tollPlaza}</td>
                                    <td>${tx.vehicleNumber}</td>
                                    <td>${tx.paymentMethod}</td>
                                    <td>${tx.amount}</td>
                                    <td><span class="status ${tx.status.toLowerCase()}">${tx.status}</span></td>
                                    <td>
                                        <a href="${pageContext.request.contextPath}/PaymentHistoryController/download?transactionId=${tx.transactionId}" class="receipt-btn">
                                            <i class="fas fa-download"></i>
                                        </a>
                                    </td>
                                </tr>
                            </c:forEach>
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
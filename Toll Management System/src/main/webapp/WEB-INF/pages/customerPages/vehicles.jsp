<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>PathPay - My Vehicles</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/customerPagesCss/vehicles.css"/>
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
                <h2>My Vehicles</h2>
                <a href="${pageContext.request.contextPath}/VehicleController/add" class="add-vehicle-btn">
                    <i class="fas fa-plus"></i> Add New Vehicle
                </a>
            </div>

            <c:if test="${not empty error}">
                <div class="alert alert-danger">
                    ${error}
                </div>
            </c:if>

            <div class="vehicles-grid">
                <c:forEach items="${vehicles}" var="vehicle">
                    <div class="vehicle-card">
                        <div class="vehicle-icon">
                            <i class="fas fa-${vehicle.vehicleType eq 'Car' ? 'car' : vehicle.vehicleType eq 'Truck' ? 'truck' : vehicle.vehicleType eq 'Bus' ? 'bus' : 'motorcycle'}"></i>
                        </div>
                        <div class="vehicle-details">
                            <h3>${vehicle.vehicleType}</h3>
                            <p class="vehicle-number">${vehicle.vehicleNumber}</p>
                            <div class="vehicle-stats">
                                <div class="stat">
                                    <span class="label">Total Toll Paid:</span>
                                    <span class="value">रु <fmt:formatNumber value="${vehicle.totalTollPaid}" pattern="#,##0.00"/></span>
                                </div>
                                <div class="stat">
                                    <span class="label">Last Used:</span>
                                    <span class="value">
                                        <c:choose>
                                            <c:when test="${not empty vehicle.lastTollDate}">
                                                <fmt:formatDate value="${vehicle.lastTollDate}" pattern="MMM dd, yyyy"/>
                                            </c:when>
                                            <c:otherwise>Never</c:otherwise>
                                        </c:choose>
                                    </span>
                                </div>
                                <div class="stat">
                                    <span class="label">Monthly Pass:</span>
                                    <span class="value ${not empty vehicle.monthlyPassExpiry ? (vehicle.monthlyPassExpiry.time > System.currentTimeMillis() ? 'active' : 'expired') : ''}">
                                        <c:choose>
                                            <c:when test="${not empty vehicle.monthlyPassExpiry}">
                                                <c:choose>
                                                    <c:when test="${vehicle.monthlyPassExpiry.time > System.currentTimeMillis()}">
                                                        Active until <fmt:formatDate value="${vehicle.monthlyPassExpiry}" pattern="MMM dd, yyyy"/>
                                                    </c:when>
                                                    <c:otherwise>
                                                        Expired on <fmt:formatDate value="${vehicle.monthlyPassExpiry}" pattern="MMM dd, yyyy"/>
                                                    </c:otherwise>
                                                </c:choose>
                                            </c:when>
                                            <c:otherwise>Not Active</c:otherwise>
                                        </c:choose>
                                    </span>
                                </div>
                            </div>
                            <div class="vehicle-actions">
                                <a href="${pageContext.request.contextPath}/VehicleController/edit/${vehicle.vehicleNumber}" class="btn edit-btn">
                                    <i class="fas fa-edit"></i> Edit
                                </a>
                                <button class="btn delete-btn" onclick="deactivateVehicle('${vehicle.vehicleNumber}')">
                                    <i class="fas fa-trash"></i> Remove
                                </button>
                            </div>
                        </div>
                    </div>
                </c:forEach>

                <c:if test="${empty vehicles}">
                    <div class="no-vehicles">
                        <i class="fas fa-car"></i>
                        <p>You haven't registered any vehicles yet.</p>
                        <a href="${pageContext.request.contextPath}/VehicleController/add" class="btn add-btn">
                            Add Your First Vehicle
                        </a>
                    </div>
                </c:if>
            </div>
        </main>
    </div>

    <script>
        function deactivateVehicle(vehicleNumber) {
            if (confirm('Are you sure you want to remove this vehicle?')) {
                fetch('${pageContext.request.contextPath}/VehicleController', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/x-www-form-urlencoded',
                    },
                    body: 'action=deactivate&vehicleNumber=' + encodeURIComponent(vehicleNumber)
                })
                .then(response => response.json())
                .then(data => {
                    if (data.success) {
                        window.location.reload();
                    } else {
                        alert(data.error || 'Failed to remove vehicle');
                    }
                })
                .catch(error => {
                    console.error('Error:', error);
                    alert('An error occurred while removing the vehicle');
                });
            }
        }
    </script>
</body>
</html> 
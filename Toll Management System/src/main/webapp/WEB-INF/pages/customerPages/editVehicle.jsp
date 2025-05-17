<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>PathPay - Edit Vehicle</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/customerPagesCss/vehicles.css"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>
    <div class="dashboard-container">
        <!-- Include the header -->
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
                <h2>Edit Vehicle</h2>
                <a href="${pageContext.request.contextPath}/VehicleController" class="back-btn">
                    <i class="fas fa-arrow-left"></i> Back to Vehicles
                </a>
            </div>

            <c:if test="${not empty error}">
                <div class="alert alert-danger">
                    ${error}
                </div>
            </c:if>

            <div class="form-container">
                <form action="${pageContext.request.contextPath}/VehicleController" method="post" class="vehicle-form">
                    <input type="hidden" name="action" value="update">
                    <input type="hidden" name="originalVehicleNumber" value="${vehicle.vehicleNumber}">
                    
                    <div class="form-group">
                        <label for="vehicleType">Vehicle Type</label>
                        <select name="vehicleType" id="vehicleType" required>
                            <option value="">Select vehicle type</option>
                            <option value="Car" ${vehicle.vehicleType eq 'Car' ? 'selected' : ''}>Car/Jeep/Van</option>
                            <option value="Bus" ${vehicle.vehicleType eq 'Bus' ? 'selected' : ''}>Bus</option>
                            <option value="Truck" ${vehicle.vehicleType eq 'Truck' ? 'selected' : ''}>Truck</option>
                            <option value="Motorcycle" ${vehicle.vehicleType eq 'Motorcycle' ? 'selected' : ''}>Motorcycle</option>
                        </select>
                    </div>

                    <div class="form-group">
                        <label for="vehicleNumber">Vehicle Number</label>
                        <input type="text" name="vehicleNumber" id="vehicleNumber" required 
                               value="${vehicle.vehicleNumber}"
                               placeholder="Enter vehicle registration number"
                               pattern="^[A-Za-z0-9]+$"
                               title="Vehicle number should only contain letters and numbers">
                        <small class="form-text">Example: BA1PA2345</small>
                    </div>

                    <div class="form-group">
                        <label for="monthlyPassExpiry">Monthly Pass Expiry</label>
                        <input type="date" name="monthlyPassExpiry" id="monthlyPassExpiry"
                               value="<fmt:formatDate value="${vehicle.monthlyPassExpiry}" pattern="yyyy-MM-dd"/>"
                               min="${now}">
                        <small class="form-text">Leave empty if no monthly pass</small>
                    </div>

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
                    </div>

                    <div class="form-actions">
                        <button type="submit" class="btn submit-btn">
                            <i class="fas fa-save"></i> Save Changes
                        </button>
                        <a href="${pageContext.request.contextPath}/VehicleController" class="btn cancel-btn">
                            <i class="fas fa-times"></i> Cancel
                        </a>
                    </div>
                </form>
            </div>
        </main>
    </div>

    

    <script>
        // Set minimum date for monthly pass to today
        document.getElementById('monthlyPassExpiry').min = new Date().toISOString().split('T')[0];
    </script>
</body>
</html> 
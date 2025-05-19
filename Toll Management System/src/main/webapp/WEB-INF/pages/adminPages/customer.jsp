<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Customer Management - PathPay Admin</title>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet" />
  <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/adminPagesCss/customer.css"/>


</head>
<body>
  <!-- Sidebar -->
  <aside class="sidebar">
    <div class="sidebar-header">
      <img src="${pageContext.request.contextPath}/resources/logo.png" alt="PathPay Logo" class="logo"/>
      <h2>PathPay</h2>
    </div>
    <nav class="sidebar-nav">
      <ul>
        <li>
            <a href="${pageContext.request.contextPath}/AdminDashboard">
            <i class="fas fa-tachometer-alt"></i>
            <span>Dashboard</span></a>
        </li>
        <li>
            <a href="${pageContext.request.contextPath}/TollBoothsController">
                <i class="fas fa-road"></i>
                <span>Toll Booths</span></a>
            </li>
        <li>
            <a href="${pageContext.request.contextPath}/TransactionController">
                <i class="fas fa-exchange-alt"></i>
                <span>Transactions</span></a>
            </li>
        <li class="active">
            <a href="${pageContext.request.contextPath}/CustomerController">
                <i class="fas fa-users"></i>
                <span>Customers</span></a>
            </li>
        <li><a href="${pageContext.request.contextPath}/SettingController">
            <i class="fas fa-cog"></i>
            <span>Settings</span></a>
        </li>
      </ul>
    </nav>
  </aside>

  <!-- Main Content -->
  <main class="main-content">
    <header class="main-header">
      <div class="header-left">
        <button class="menu-toggle"><i class="fas fa-bars"></i></button>
        <h1>Customer Management</h1>
      </div>
      <div class="header-right">
        <div class="user-profile" id="userProfile">
  					<a href="${pageContext.request.contextPath}/SettingController"><i class="fas fa-user"></i>
  					<span class="user-name">${user.firstName} ${user.lastName}</span>
  					</a>
				</div>
              <a href="${pageContext.request.contextPath}/login" class="logout-btn"><i class="fas fa-sign-out-alt"></i></a>
        
      </div>
    </header>

    <div class="dashboard-content">

      <!-- Customers Table -->
      <div class="table-container">
        
        <table class="customers-table">
            <thead>
                <tr>
                  <th>Username</th>
                  <th>Name</th>
                  <th>Email</th>
                  <th>Phone</th>
                  <th>Account Type</th>
                  <th>Citizenship No.</th>
                  <th>Actions</th>
                </tr>
              </thead>
          <tbody id="customersTableBody">
            <c:if test="${empty users}">
              <tr>
                <td colspan="8" class="text-center">No customers found</td>
              </tr>
            </c:if>
            <c:forEach var="user" items="${users}">
              <tr>
                <td>${user.username}</td>
                <td>${user.firstName} ${user.lastName}</td>
                <td>${user.email}</td>
                <td>${user.phone}</td>
                <td>${user.accountType}</td>
                <td>${user.citizenshipNumber}</td>
                <td>
                  <button class="delete-btn" onclick="deleteUser('${user.username}')">
                    <i class="fas fa-trash"></i> Delete
                  </button>
                </td>
              </tr>
            </c:forEach>
          </tbody>
        </table>
      </div>

      
    </div>
  </main>

  <script>
    function deleteUser(username) {
      if (confirm('Are you sure you want to delete this user? This action cannot be undone.')) {
        window.location.href = '${pageContext.request.contextPath}/CustomerController?action=delete&username=' + username;
      }
    }
  </script>
</body>
</html>

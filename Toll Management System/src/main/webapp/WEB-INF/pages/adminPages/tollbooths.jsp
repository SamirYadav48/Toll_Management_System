<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Toll Booths - PathPay Admin</title>
  <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/adminPagesCss/tollbooths.css"/>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"/>
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet"/>
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
        <li><a href="${pageContext.request.contextPath}/AdminDashboard">
            <i class="fas fa-tachometer-alt"></i>
            <span>Dashboard</span></a></li>
        <li class="active"><a href="${pageContext.request.contextPath}/TollBoothsController">
            <i class="fas fa-road"></i>
            <span>Toll Booths</span></a></li>
        <li><a href="${pageContext.request.contextPath}/TransactionController">
            <i class="fas fa-exchange-alt"></i>
            <span>Transactions</span></a></li>
        <li><a href="${pageContext.request.contextPath}/CustomerController">
            <i class="fas fa-users"></i>
            <span>Customers</span></a></li>
        <li><a href="${pageContext.request.contextPath}/SettingController">
            <i class="fas fa-cog"></i>
            <span>Settings</span></a></li>
      </ul>
    </nav>
  </aside>

  <!-- Main Content -->
  <main class="main-content">
    <header class="main-header">
      <div class="header-left">
        <button class="menu-toggle"><i class="fas fa-bars"></i></button>
        <h1>Toll Booth Management</h1>
      </div>
      <div class="header-right">
        <div class="user-profile" id="userProfile">
        <div class="status-filter">
                    <select id="statusFilter" onchange="filterByStatus(this.value)">
                        <option value="">All Statuses</option>
                        <option value="active">Active</option>
                        <option value="inactive">Inactive</option>
                        <option value="maintenance">Maintenance</option>
                    </select>
                </div>
  					<a href="${pageContext.request.contextPath}/SettingController"><i class="fas fa-user"></i>
  					<span class="user-name">${user.firstName} ${user.lastName}</span>
  					</a>
				</div>
        
                <a href="${pageContext.request.contextPath}/login" class="logout-btn"><i class="fas fa-sign-out-alt"></i></a>
        
      </div>
    </header>

    <div class="dashboard-content">
      <div class="table-container">
        <table class="booths-table">
          <thead>
            <tr>
              <th>Booth ID</th>
              <th>Location</th>
              <th>Status</th>
              <th>Last Activity</th>
              <th>Transactions (Today)</th>
              <th>Revenue (Today)</th>
              <th>Actions</th>
            </tr>
          </thead>
          <tbody>
            <!-- Loop through the list of toll booths dynamically -->
            <c:forEach var="booth" items="${tollBooths}">
                <tr>
                  <td>${booth.boothId}</td>
                  <td>${booth.location}</td>
                  <td><span class="status ${booth.status}">${booth.status}</span></td>
                  <td>${booth.lastActivity != null ? booth.lastActivity : 'N/A'}</td>
                  <td>${booth.transactionsToday}</td>
                  <td>${booth.revenueToday}</td>
                  <td>
                    <button class="btn-icon danger" onclick="deleteBooth('${booth.boothId}')">
                      <i class="fas fa-trash"></i>
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
    // Function to filter toll booths by status
    function filterByStatus(status) {
        // Update the URL with the status parameter
        const url = new URL(window.location.href);
        if (status) {
            url.searchParams.set('status', status);
        } else {
            url.searchParams.delete('status');
        }
        
        // Navigate to the updated URL
        window.location.href = url.toString();
    }

    function deleteBooth(boothId) {
      if (confirm('Are you sure you want to delete this toll booth? This action cannot be undone.')) {
        // Send the delete request
        fetch('${pageContext.request.contextPath}/TollBoothsController', {
          method: 'POST',
          headers: {
            'Content-Type': 'application/x-www-form-urlencoded',
          },
          body: 'action=deleteBooth&boothId=' + encodeURIComponent(boothId)
        })
        .then(response => response.text())
        .then(data => {
          // Refresh the page to show updated list
          window.location.reload();
        })
        .catch(error => {
          console.error('Error:', error);
          alert('Failed to delete toll booth. Please try again.');
        });
      }
    }
  </script>
</body>
</html>

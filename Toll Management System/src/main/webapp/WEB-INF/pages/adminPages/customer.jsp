<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
        <div class="search-box">
          <input type="text" placeholder="Search customers..." id="searchInput"/>
          <i class="fas fa-search"></i>
        </div>
        <div class="user-profile">
          <img src="admin-avatar.jpg" alt="Admin Avatar"/>
          <span><a href="${pageContext.request.contextPath}/AdminProfileController"><i class="fas fa-user"></i>Admin</a></span>
          <i class="fas fa-chevron-down"></i>
        </div>
        
      </div>
    </header>

    <div class="dashboard-content">
      <div class="action-bar">
        
        <div class="actions">
          
          <div class="filters">
            <select id="statusFilter">
              <option value="all">All Status</option>
              <option value="active">Active</option>
              <option value="inactive">Inactive</option>
              <option value="suspended">Suspended</option>
            </select>
            <select id="sortBy">
              <option value="newest">Newest First</option>
              <option value="oldest">Oldest First</option>
              <option value="name-asc">Name (A-Z)</option>
              <option value="name-desc">Name (Z-A)</option>
            </select>
          </div>
        </div>
      </div>

      <!-- Customers Table -->
      <div class="table-container">
        
        
        <table class="customers-table">
            <thead>
                <tr>
                  <th>Customer ID</th>
                  <th>Name</th>
                  <th>Email</th>
                  <th>Phone</th>
                  <th>Vehicles</th>
                  <th>Balance</th>
                  <th>Status</th>
                  <th>Joined</th>
                  <th>Actions</th>
                </tr>
              </thead>
          <tbody id="customersTableBody">
            <!-- Example static row -->
            <tr>
              <td>CUST-NP-001</td>
              <td>Suman Thapa</td>
              <td>suman.thapa@pathpay.com</td>
              <td>+977-9801234567</td>
              <td>Ba 2 Kha 1123</td>
              <td>रु 1,500.00</td>
              <td><span class="status active">Active</span></td>
              <td>2023-11-12</td>
              <td>
                <button class="btn-icon"><i class="fas fa-eye"></i></button>
                <button class="btn-icon"><i class="fas fa-edit"></i></button>
                <button class="btn-icon danger"><i class="fas fa-trash-alt"></i></button>
              </td>
            </tr>
            <!-- Dynamic rows loaded via JS -->
          </tbody>
        </table>
      </div>

      <!-- Pagination -->
      <div class="pagination">
        <button class="btn-pagination" id="prevPage" disabled><i class="fas fa-chevron-left"></i></button>
        <div class="page-numbers" id="pageNumbers"></div>
        <button class="btn-pagination" id="nextPage"><i class="fas fa-chevron-right"></i></button>
      </div>
    </div>
  </main>

  <!-- Customer Detail Modal -->
  <div class="modal" id="customerDetailModal">
    <div class="modal-content">
      <div class="modal-header">
        <h3>Customer Details</h3>
        <button class="close-modal">&times;</button>
      </div>
      <div class="modal-body">
        <div class="customer-profile">
          <div class="profile-header">
            <div class="avatar">
              <img src="customer-avatar.jpg" alt="Customer Avatar" id="detailAvatar"/>
              <span class="status" id="detailStatus">Active</span>
            </div>
            <h2 id="detailName">Aayush Karki</h2>
            <p class="customer-id" id="detailId">CUST-NP-005</p>
          </div>

          <div class="detail-section">
            <h4>Account Information</h4>
            <div class="detail-row">
              <span class="detail-label">Email:</span>
              <span class="detail-value" id="detailEmail">aayush.karki@example.com</span>
            </div>
            <div class="detail-row">
              <span class="detail-label">Phone:</span>
              <span class="detail-value" id="detailPhone">+977-9812345678</span>
            </div>
            <div class="detail-row">
              <span class="detail-label">Account Balance:</span>
              <span class="detail-value" id="detailBalance">रु 875.00</span>
            </div>
            <div class="detail-row">
              <span class="detail-label">Account Status:</span>
              <span class="detail-value" id="detailStatusText">Active</span>
            </div>
            <div class="detail-row">
              <span class="detail-label">Joined Date:</span>
              <span class="detail-value" id="detailJoined">2024-05-21</span>
            </div>
          </div>

          <div class="detail-section">
            <h4>Registered Vehicles</h4>
            <div class="vehicles-list" id="vehiclesList">
              <!-- Example vehicle -->
              <div class="vehicle-item">Ba 3 Cha 5678 - Hyundai i20</div>
            </div>
          </div>

          <div class="modal-actions">
            <button class="btn btn-secondary close-modal">Close</button>
            <button class="btn btn-danger" id="suspendBtn">Suspend Account</button>
          </div>
        </div>
      </div>
    </div>
  </div>

  <!-- Delete Confirmation Modal -->
  <div class="modal" id="deleteModal">
    <div class="modal-content small">
      <div class="modal-header">
        <h3>Confirm Deletion</h3>
        <button class="close-modal">&times;</button>
      </div>
      <div class="modal-body">
        <p>Are you sure you want to delete this customer account? This action cannot be undone.</p>
        <div class="modal-actions">
          <button class="btn btn-secondary close-modal">Cancel</button>
          <button class="btn btn-danger" id="confirmDelete">Delete Permanently</button>
        </div>
      </div>
    </div>
  </div>

  <script src="/chapter 1/customer.js"></script>
</body>
</html>

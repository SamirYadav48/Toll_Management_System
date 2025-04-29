<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
        <div class="search-box">
          <input type="text" placeholder="Search..." />
          <i class="fas fa-search"></i>
        </div>
        <div class="user-profile">
          <img src="admin-avatar.jpg" alt="Admin Avatar"/>
          <span>Admin</span>
          <i class="fas fa-chevron-down"></i>
        </div>
        
          <a href="${pageContext.request.contextPath}/login"><i class="fas fa-sign-out-alt"></i></a>
        
      </div>
    </header>

    <div class="dashboard-content">
      <div class="action-bar">
        <button class="btn btn-primary"><i class="fas fa-plus"></i> Add Toll Booth</button>
        <div class="filters">
          <select>
            <option>All Statuses</option>
            <option>Active</option>
            <option>Inactive</option>
            <option>Maintenance</option>
          </select>
          <select>
            <option>All Locations</option>
            <option>East-West Highway</option>
            <option>Prithvi Highway</option>
            <option>Kathmandu Ring Road</option>
            <option>BP Highway</option>
            <option>Muglin-Pokhara Road</option>
          </select>
        </div>
      </div>

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
            <tr>
              <td>BTH-NP-001</td>
              <td>East-West Hwy - Bardibas</td>
              <td><span class="status active">Active</span></td>
              <td>5 minutes ago</td>
              <td>420</td>
              <td>Rs. 12,600</td>
              <td>
                <button class="btn-icon"><i class="fas fa-edit"></i></button>
                <button class="btn-icon"><i class="fas fa-cog"></i></button>
                <button class="btn-icon danger"><i class="fas fa-power-off"></i></button>
              </td>
            </tr>
            <tr>
              <td>BTH-NP-002</td>
              <td>Prithvi Hwy - Naubise</td>
              <td><span class="status maintenance">Maintenance</span></td>
              <td>1 hour ago</td>
              <td>220</td>
              <td>Rs. 6,600</td>
              <td>
                <button class="btn-icon"><i class="fas fa-edit"></i></button>
                <button class="btn-icon"><i class="fas fa-cog"></i></button>
                <button class="btn-icon success"><i class="fas fa-power-off"></i></button>
              </td>
            </tr>
            <tr>
              <td>BTH-NP-003</td>
              <td>BP Highway - Khurkot</td>
              <td><span class="status inactive">Inactive</span></td>
              <td>2 days ago</td>
              <td>0</td>
              <td>Rs. 0</td>
              <td>
                <button class="btn-icon"><i class="fas fa-edit"></i></button>
                <button class="btn-icon"><i class="fas fa-cog"></i></button>
                <button class="btn-icon success"><i class="fas fa-power-off"></i></button>
              </td>
            </tr>
            <tr>
              <td>BTH-NP-004</td>
              <td>Kathmandu Ring Road - Kalanki</td>
              <td><span class="status active">Active</span></td>
              <td>10 minutes ago</td>
              <td>380</td>
              <td>Rs. 11,400</td>
              <td>
                <button class="btn-icon"><i class="fas fa-edit"></i></button>
                <button class="btn-icon"><i class="fas fa-cog"></i></button>
                <button class="btn-icon danger"><i class="fas fa-power-off"></i></button>
              </td>
            </tr>
          </tbody>
        </table>
      </div>

      <div class="pagination">
        <button class="btn-pagination" disabled><i class="fas fa-chevron-left"></i></button>
        <button class="btn-pagination active">1</button>
        <button class="btn-pagination">2</button>
        <button class="btn-pagination">3</button>
        <button class="btn-pagination"><i class="fas fa-chevron-right"></i></button>
      </div>
    </div>
  </main>

  <!-- Modal -->
  <div class="modal" id="addBoothModal">
    <div class="modal-content">
      <div class="modal-header">
        <h3>Add New Toll Booth</h3>
        <button class="close-modal">&times;</button>
      </div>
      <div class="modal-body">
        <form>
          <div class="form-group">
            <label for="boothId">Booth ID</label>
            <input type="text" id="boothId" placeholder="e.g., BTH-NP-005"/>
          </div>
          <div class="form-group">
            <label for="location">Location</label>
            <select id="location">
              <option value="">Select Location</option>
              <option>East-West Hwy - Bardibas</option>
              <option>Prithvi Hwy - Naubise</option>
              <option>BP Highway - Khurkot</option>
              <option>Kathmandu Ring Road - Kalanki</option>
              <option>Muglin-Pokhara Road</option>
            </select>
          </div>
          <div class="form-group">
            <label for="boothType">Booth Type</label>
            <select id="boothType">
              <option value="standard">Standard</option>
              <option value="express">Express</option>
              <option value="commercial">Commercial</option>
            </select>
          </div>
          <div class="form-group">
            <label for="initialStatus">Initial Status</label>
            <select id="initialStatus">
              <option value="active">Active</option>
              <option value="inactive">Inactive</option>
              <option value="maintenance">Maintenance</option>
            </select>
          </div>
          <div class="form-actions">
            <button type="button" class="btn btn-secondary close-modal">Cancel</button>
            <button type="submit" class="btn btn-primary">Add Booth</button>
          </div>
        </form>
      </div>
    </div>
  </div>

  <script src="/chapter 1/tollbooth.js"></script>
</body>
</html>

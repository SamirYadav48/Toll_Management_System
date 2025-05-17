<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Toll Management System - Toll Locations</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/customerPagesCss/tollLocations.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link rel="stylesheet" href="https://unpkg.com/leaflet@1.7.1/dist/leaflet.css" />
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
                    <li>
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
                    <li class="active">
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
                <h2>Toll Plaza Locations</h2>
                <div class="map-controls">
                    <div class="search-box">
                        <i class="fas fa-search"></i>
                        <input type="text" id="searchInput" placeholder="Search toll plazas...">
                    </div>
                    <div class="filter-box">
                        <select id="provinceFilter">
                            <option value="">All Provinces</option>
                            <option value="Koshi">Province 1 (Koshi)</option>
                            <option value="Madhesh">Province 2 (Madhesh)</option>
                            <option value="Bagmati">Province 3 (Bagmati)</option>
                            <option value="Gandaki">Province 4 (Gandaki)</option>
                            <option value="Lumbini">Province 5 (Lumbini)</option>
                            <option value="Karnali">Province 6 (Karnali)</option>
                            <option value="Sudurpashchim">Province 7 (Sudurpashchim)</option>
                        </select>
                    </div>
                    <button class="refresh-btn" onclick="refreshData()">
                        <i class="fas fa-sync-alt"></i> Refresh
                    </button>
                </div>
            </div>

            <div class="toll-locations-container">
                <div class="map-container" id="toll-map"></div>
                
                <div class="toll-list">
                    <div class="list-header">
                        <h3>All Toll Plazas</h3>
                        <div class="sort-options">
                            <span>Sort by:</span>
                            <select id="sortSelect">
                                <option value="name">Alphabetical</option>
                                <option value="status">Status</option>
                                <option value="province">Province</option>
                            </select>
                        </div>
                    </div>
                    
                    <div class="toll-items">
                        <c:forEach items="${tollBooths}" var="booth">
                            <div class="toll-item" data-province="${booth.province}" data-status="${booth.status}">
                                <div class="toll-name">${booth.location}</div>
                                <div class="toll-id">${booth.boothId}</div>
                                <div class="toll-status">
                                    <span class="status-badge ${booth.status.toLowerCase()}">${booth.status}</span>
                                </div>
                                <div class="toll-details">
                                    <span class="province">${booth.province}</span>
                                    <span class="last-updated">Updated: ${booth.updatedAt}</span>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
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

    <script src="https://unpkg.com/leaflet@1.7.1/dist/leaflet.js"></script>
    <script>
    document.addEventListener('DOMContentLoaded', function() {
        // Initialize map
        const map = L.map('toll-map').setView([27.7172, 85.3240], 7); // Centered on Nepal
        
        // Add tile layer (OpenStreetMap)
        L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
            attribution: '&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors'
        }).addTo(map);

        // Get toll locations from JSP
        const tollBooths = [
            <c:forEach items="${tollBooths}" var="booth" varStatus="status">
                {
                    id: "${booth.boothId}",
                    name: "${booth.location}",
                    status: "${booth.status}",
                    province: "${booth.province}",
                    coords: [${booth.latitude}, ${booth.longitude}]
                }${!status.last ? ',' : ''}
            </c:forEach>
        ];

        // Add markers to map
        const markers = {};
        tollBooths.forEach(booth => {
            const marker = L.marker(booth.coords).addTo(map)
                .bindPopup(`
                    <b>${booth.name}</b><br>
                    ID: ${booth.id}<br>
                    Status: ${booth.status}<br>
                    Province: ${booth.province}
                `);
            markers[booth.id] = marker;
        });

        // Search functionality
        const searchInput = document.getElementById('searchInput');
        searchInput.addEventListener('input', function() {
            const searchTerm = this.value.toLowerCase();
            filterTollItems();
        });

        // Province filter
        const provinceFilter = document.getElementById('provinceFilter');
        provinceFilter.addEventListener('change', filterTollItems);

        // Sort functionality
        const sortSelect = document.getElementById('sortSelect');
        sortSelect.addEventListener('change', function() {
            const sortBy = this.value;
            const tollItems = Array.from(document.querySelectorAll('.toll-item'));
            
            tollItems.sort((a, b) => {
                switch(sortBy) {
                    case 'name':
                        return a.querySelector('.toll-name').textContent.localeCompare(b.querySelector('.toll-name').textContent);
                    case 'status':
                        return a.dataset.status.localeCompare(b.dataset.status);
                    case 'province':
                        return a.dataset.province.localeCompare(b.dataset.province);
                    default:
                        return 0;
                }
            });

            const container = document.querySelector('.toll-items');
            tollItems.forEach(item => container.appendChild(item));
        });

        function filterTollItems() {
            const searchTerm = searchInput.value.toLowerCase();
            const selectedProvince = provinceFilter.value;
            
            document.querySelectorAll('.toll-item').forEach(item => {
                const name = item.querySelector('.toll-name').textContent.toLowerCase();
                const province = item.dataset.province;
                
                const matchesSearch = name.includes(searchTerm);
                const matchesProvince = !selectedProvince || province === selectedProvince;
                
                item.style.display = matchesSearch && matchesProvince ? 'block' : 'none';
            });
        }

        // List item click events
        document.querySelectorAll('.toll-item').forEach(item => {
            item.addEventListener('click', function() {
                const boothId = this.querySelector('.toll-id').textContent;
                const booth = tollBooths.find(b => b.id === boothId);
                if (booth) {
                    map.setView(booth.coords, 12);
                    document.querySelectorAll('.toll-item').forEach(i => i.classList.remove('active'));
                    this.classList.add('active');
                }
            });
        });
    });

    function refreshData() {
        window.location.reload();
    }
    </script>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>PathPay - Toll Locations</title>
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
                <div class="map-container">
                    <div id="toll-map" style="height: 700px; width: 100%;"></div>
                </div>
                
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
    </div>
<footer class="dashboard-footer">
            <p>&copy; 2025 Nepal Toll Management System. All rights reserved.</p>
            <div class="footer-links">
                <a href="#">Privacy Policy</a>
                <a href="#">Terms of Service</a>
                <a href="#">Contact Us</a>
            </div>
        </footer>
    <script src="https://unpkg.com/leaflet@1.7.1/dist/leaflet.js"></script>
    <script>
    document.addEventListener('DOMContentLoaded', function() {
         // Initialize map
         const map = L.map('toll-map', {
             center: [27.7103, 85.3222], // Center on Kathmandu
             zoom: 8,
             layers: [
                 L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
                     attribution: '&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors'
                 })
             ]
         });
         
         // Configure map
         map.attributionControl.setPrefix(''); // Remove Leaflet prefix from attribution
         map.setView([27.7103, 85.3222], 8); // Centered on Kathmandu
         
         // Add zoom controls
         L.control.zoom({ position: 'topright' }).addTo(map);

        // Get toll locations from JSP
        const tollBooths = [
            <c:forEach items="${tollBooths}" var="booth" varStatus="status">
                {
                    id: "${booth.boothId}",
                    name: "${booth.location}",
                    status: "${booth.status}",
                    province: "${booth.province}",
                    latitude: ${booth.latitude},
                    longitude: ${booth.longitude}
                }${!status.last ? ',' : ''}
            </c:forEach>
        ];

        // Add markers to map
        const markers = {};
        
        // First set up the map bounds to include all toll booths
        const bounds = L.latLngBounds([]);
        
        tollBooths.forEach(booth => {
            // Validate coordinates
            if (!booth.latitude || !booth.longitude) {
                console.warn('Missing coordinates for booth:', booth);
                return;
            }
            
            // Create coordinates array
            const coords = [Number(booth.latitude), Number(booth.longitude)];
            
            console.log('Creating marker for booth:', booth);
            console.log('Coordinates:', coords);
            
            // Create marker with booth ID
            const marker = L.marker(coords).addTo(map);
            marker.bindPopup(`
                <b>${booth.name}</b><br>
                ID: ${booth.id}<br>
                Status: ${booth.status}<br>
                Province: ${booth.province}
            `);
            
            // Store marker with booth ID
            markers[booth.id] = marker;
            
            // Add to bounds
            bounds.extend(coords);
            
            // Add booth ID to marker options
            marker.options.boothId = booth.id;
        });
        
        // Fit map to include all markers
        if (bounds.isValid()) {
            map.fitBounds(bounds, { padding: [50, 50] });
        } else {
            // If no valid coordinates, use default Nepal center
            map.setView([27.7103, 85.3222], 8);
        }

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

        // Add click handlers after map initialization
         const tollItems = document.querySelectorAll('.toll-item');
         tollItems.forEach(item => {
             item.addEventListener('click', function() {
                 const boothId = this.querySelector('.toll-id').textContent;
                 const booth = tollBooths.find(b => b.id === boothId);
                 if (booth) {
                     console.log('Clicking on booth:', booth);
                     console.log('Coordinates:', booth.latitude, booth.longitude);
                     
                     const coords = [Number(booth.latitude), Number(booth.longitude)];
                     console.log('Parsed coordinates:', coords);
                     
                     // Validate coordinates
                     if (!coords[0] || !coords[1] || isNaN(coords[0]) || isNaN(coords[1])) {
                         console.error('Invalid coordinates for booth:', booth);
                         return;
                     }
                     
                     // Smoothly pan to the location
                     map.flyTo(coords, 12, {
                         duration: 1.5,
                         animate: true
                     });
                    
                    // Open the popup if it exists
                    const marker = markers[boothId];
                    if (marker) {
                        marker.openPopup();
                    }
                    
                    // Update active state
                    document.querySelectorAll('.toll-item').forEach(i => i.classList.remove('active'));
                    this.classList.add('active');
                }
            });
        });

        // Add marker click handlers
        Object.values(markers).forEach(marker => {
            marker.on('click', function(e) {
                const boothId = e.target.options.boothId;
                const booth = tollBooths.find(b => b.id === boothId);
                if (booth) {
                    // Update the active state in the list
                    document.querySelectorAll('.toll-item').forEach(item => {
                        if (item.querySelector('.toll-id').textContent === boothId) {
                            item.classList.add('active');
                        } else {
                            item.classList.remove('active');
                        }
                    });
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
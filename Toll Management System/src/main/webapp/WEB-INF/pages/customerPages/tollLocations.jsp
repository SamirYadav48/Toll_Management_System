<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
                <img src="${pageContext.request.contextPath}/resources/logo.png" alt="Nepal Toll System Logo" class="logo">
                <h1>Toll Management System</h1>
            </div>
            <div class="header-right">
                <div class="user-info">
                    <a href="${pageContext.request.contextPath}/CustomerSettingsController" class="user-name-link">
                        <span class="user-name">Bina Karki</span>
                    </a>
                    <img src="user-avatar.jpg" alt="User Avatar" class="user-avatar">
                </div>
            </div>
        </header>

        <aside class="sidebar">
            <nav class="sidebar-nav">
                <ul>
                    <li><a href="${pageContext.request.contextPath}/CustomerDashboard"><i class="fas fa-tachometer-alt"></i> Dashboard</a></li>
                    <li><a href="${pageContext.request.contextPath}/PaymentHistoryController"><i class="fas fa-money-bill-wave"></i> Payment History</a></li>
                    <li class="active"><a href="${pageContext.request.contextPath}/TollLocationsController"><i class="fas fa-map-marked-alt"></i> Toll Locations</a></li>
                    <li><a href="${pageContext.request.contextPath}/GetCardController"><i class="fas fa-credit-card"></i> Get RFID Card</a></li>
                    <li><a href="${pageContext.request.contextPath}/RechargeWalletController"><i class="fas fa-wallet"></i> Recharge Wallet</a></li>                    
                    <li><a href="${pageContext.request.contextPath}/CustomerSettingsController"><i class="fas fa-cog"></i> Settings</a></li>
                    <li><a href="${pageContext.request.contextPath}/HelpController"><i class="fas fa-question-circle"></i> Help</a></li>
                </ul>
            </nav>
        </aside>

        <main class="main-content">
            <div class="content-header">
                <h2>Toll Plaza Locations</h2>
                <div class="map-controls">
                    <div class="search-box">
                        <i class="fas fa-search"></i>
                        <input type="text" placeholder="Search toll plazas...">
                    </div>
                    <button class="refresh-btn">
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
                            <select>
                                <option>Distance</option>
                                <option selected>Alphabetical</option>
                                <option>Traffic Level</option>
                            </select>
                        </div>
                    </div>
                    
                    <div class="toll-items">
                        <div class="toll-item active">
                            <div class="toll-name">Nagdhunga Toll Plaza</div>
                            <div class="toll-distance">12 km away</div>
                            <div class="toll-rates">Car: NPR 550 | Bike: NPR 100</div>
                            <div class="toll-traffic">
                                <span class="traffic-level medium">Medium Traffic</span>
                            </div>
                        </div>
                        <!-- More toll items would go here -->
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
        const map = L.map('toll-map').setView([27.7172, 85.3240], 12); // Centered on Kathmandu
        
        // Add tile layer (OpenStreetMap)
        L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
            attribution: '&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors'
        }).addTo(map);

        // Sample toll plaza markers (in a real app, these would come from an API)
        const tollPlazas = [
            {
                name: "Nagdhunga Toll Plaza",
                coords: [27.6942, 85.2295],
                rates: "Car: NPR 550 | Bike: NPR 100",
                traffic: "medium"
            },
            // More plazas would be added here
        ];

        // Add markers to map
        tollPlazas.forEach(plaza => {
            const marker = L.marker(plaza.coords).addTo(map)
                .bindPopup(`<b>${plaza.name}</b><br>${plaza.rates}`);
            
            // Click event for markers
            marker.on('click', function() {
                // Highlight corresponding list item
                document.querySelectorAll('.toll-item').forEach(item => {
                    item.classList.remove('active');
                    if (item.querySelector('.toll-name').textContent === plaza.name) {
                        item.classList.add('active');
                        item.scrollIntoView({ behavior: 'smooth', block: 'nearest' });
                    }
                });
            });
        });

        // List item click events
        document.querySelectorAll('.toll-item').forEach(item => {
            item.addEventListener('click', function() {
                const plazaName = this.querySelector('.toll-name').textContent;
                const plaza = tollPlazas.find(p => p.name === plazaName);
                if (plaza) {
                    map.setView(plaza.coords, 15);
                    document.querySelectorAll('.toll-item').forEach(i => i.classList.remove('active'));
                    this.classList.add('active');
                }
            });
        });

        // Search functionality
        const searchInput = document.querySelector('.search-box input');
        searchInput.addEventListener('input', function() {
            const searchTerm = this.value.toLowerCase();
            document.querySelectorAll('.toll-item').forEach(item => {
                const name = item.querySelector('.toll-name').textContent.toLowerCase();
                item.style.display = name.includes(searchTerm) ? 'block' : 'none';
            });
        });

        // Refresh button
        document.querySelector('.refresh-btn').addEventListener('click', function() {
            // In a real app, this would refresh the data
            alert('Refreshing toll plaza data...');
        });
    });
    </script>
</body>
</html>
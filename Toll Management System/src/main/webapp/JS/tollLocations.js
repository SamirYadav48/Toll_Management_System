document.addEventListener('DOMContentLoaded', function() {
    const statusFilter = document.getElementById('statusFilter');
    const tollCards = document.querySelectorAll('.toll-location-card');

    // Filter toll locations based on status
    statusFilter.addEventListener('change', function() {
        const selectedStatus = this.value.toLowerCase();
        
        tollCards.forEach(card => {
            if (selectedStatus === 'all') {
                card.style.display = 'block';
            } else {
                const cardStatus = card.classList.contains(selectedStatus);
                card.style.display = cardStatus ? 'block' : 'none';
            }
        });
    });
}); 
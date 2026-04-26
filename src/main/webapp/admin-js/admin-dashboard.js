// ===================================
// FLATFINDER ADMIN UI JAVASCRIPT
// ===================================

function getContextPath() {
    const body = document.body;
    if (body && body.dataset && typeof body.dataset.contextPath === 'string') {
        return body.dataset.contextPath;
    }

    const parts = window.location.pathname.split('/').filter(Boolean);
    if (parts.length > 0 && parts[0] !== 'admin') {
        return '/' + parts[0];
    }
    return '';
}

function adminUrl(path) {
    return getContextPath() + path;
}

function toggleSidebar() {
    const sidebar = document.querySelector('.admin-sidebar');
    if (sidebar) {
        sidebar.classList.toggle('open');
    }
}

document.addEventListener('click', function(event) {
    const sidebar = document.querySelector('.admin-sidebar');
    const toggle = document.querySelector('.menu-toggle');

    if (!sidebar || !toggle || window.innerWidth > 1024) {
        return;
    }

    const clickedInsideSidebar = sidebar.contains(event.target);
    const clickedToggle = toggle.contains(event.target);

    if (!clickedInsideSidebar && !clickedToggle) {
        sidebar.classList.remove('open');
    }
});

document.addEventListener('DOMContentLoaded', function() {
    document.querySelectorAll('.menu-item').forEach(function(item) {
        item.addEventListener('click', function() {
            if (window.innerWidth <= 1024) {
                const sidebar = document.querySelector('.admin-sidebar');
                if (sidebar) {
                    sidebar.classList.remove('open');
                }
            }
        });
    });
});

function filterTable(inputId, tableId) {
    const input = document.getElementById(inputId);
    const table = document.getElementById(tableId);

    if (!input || !table || !table.tBodies.length) {
        return;
    }

    const filter = input.value.toLowerCase().trim();
    const rows = table.tBodies[0].rows;
    let visibleCount = 0;

    Array.from(rows).forEach(function(row) {
        if (row.classList.contains('empty-row')) {
            return;
        }

        const matches = row.textContent.toLowerCase().includes(filter);
        row.style.display = matches ? '' : 'none';
        if (matches) {
            visibleCount++;
        }
    });

    const emptyRows = table.querySelectorAll('.empty-row');
    emptyRows.forEach(function(emptyRow) {
        emptyRow.style.display = visibleCount === 0 ? '' : 'none';
    });
}

function deleteUser(userId, userName) {
    if (confirm('Delete user "' + userName + '"? This action cannot be undone.')) {
        window.location.href = adminUrl('/admin/delete-user/' + userId);
    }
}

function deleteProperty(propertyId, propertyTitle) {
    if (confirm('Delete property "' + propertyTitle + '"? This action cannot be undone.')) {
        window.location.href = adminUrl('/admin/delete-property/' + propertyId);
    }
}

function deleteInquiry(inquiryId) {
    if (confirm('Delete this inquiry? This action cannot be undone.')) {
        window.location.href = adminUrl('/admin/delete-inquiry/' + inquiryId);
    }
}
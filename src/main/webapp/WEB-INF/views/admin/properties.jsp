<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Properties - FlatFinder Admin</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/admin-css/admin-dashboard.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body data-context-path="<%= request.getContextPath() %>">
<%
    com.flatfinder.model.User adminUser = (com.flatfinder.model.User) session.getAttribute("user");
    java.util.List<com.flatfinder.model.Property> properties = (java.util.List<com.flatfinder.model.Property>) request.getAttribute("properties");
%>
<div class="admin-shell">
    <aside class="admin-sidebar">
        <div class="admin-brand"><i class="fas fa-shield-alt"></i><div><h2>FlatFinder Admin</h2><p>Control Center</p></div></div>
        <nav class="sidebar-nav">
            <a href="<%= request.getContextPath() %>/admin/dashboard" class="menu-item"><i class="fas fa-gauge"></i> Dashboard</a>
            <a href="<%= request.getContextPath() %>/admin/users" class="menu-item"><i class="fas fa-users"></i> Manage Users</a>
            <a href="<%= request.getContextPath() %>/admin/properties" class="menu-item active"><i class="fas fa-building"></i> Properties</a>
            <a href="<%= request.getContextPath() %>/admin/pending-properties" class="menu-item"><i class="fas fa-clock"></i> Pending Approval</a>
            <a href="<%= request.getContextPath() %>/admin/add-property" class="menu-item"><i class="fas fa-plus"></i> Add Property</a>
            <a href="<%= request.getContextPath() %>/admin/inquiries" class="menu-item"><i class="fas fa-envelope"></i> Inquiries</a>
        </nav>
        <div class="sidebar-footer"><a href="<%= request.getContextPath() %>/auth/logout" class="logout-btn"><i class="fas fa-sign-out-alt"></i> Logout</a></div>
    </aside>

    <main class="admin-main">
        <header class="admin-topbar">
            <div class="topbar-left">
                <button class="menu-toggle" onclick="toggleSidebar()"><i class="fas fa-bars"></i></button>
                <div class="page-title">
                    <h1>Manage Properties</h1>
                    <p>Review listings, approval status, and moderation actions</p>
                </div>
            </div>
            <div class="admin-user">
                <span><%= adminUser != null ? adminUser.getName() : "Admin" %></span>
                <div class="user-avatar"><%= adminUser != null ? adminUser.getName().substring(0, 1).toUpperCase() : "A" %></div>
            </div>
        </header>

        <section class="admin-page">
            <div class="page-toolbar">
                <div class="search-wrap">
                    <i class="fas fa-search"></i>
                    <input type="text" id="propertySearch" class="search-input" placeholder="Search by title, location, owner, status" onkeyup="filterTable('propertySearch', 'propertiesTable')">
                </div>
            </div>

            <div class="table-panel">
                <div class="table-scroll">
                    <table class="admin-table" id="propertiesTable">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Property</th>
                                <th>Price</th>
                                <th>Owner</th>
                                <th>Availability</th>
                                <th>Approval</th>
                                <th>Media</th>
                                <th>Created</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                        <%
                            if (properties != null && !properties.isEmpty()) {
                                for (com.flatfinder.model.Property property : properties) {
                                    String approvalStatus = property.getApprovalStatus() != null ? property.getApprovalStatus() : "PENDING";
                                    String approvalClass = "status-pending";
                                    if ("APPROVED".equals(approvalStatus)) {
                                        approvalClass = "status-approved";
                                    } else if ("REJECTED".equals(approvalStatus)) {
                                        approvalClass = "status-rejected";
                                    }
                        %>
                            <tr>
                                <td>#<%= property.getId() %></td>
                                <td>
                                    <div class="cell-title"><%= property.getTitle() %></div>
                                    <div class="cell-sub"><%= property.getLocation() %><%= property.getCity() != null && !property.getCity().isBlank() ? ", " + property.getCity() : "" %></div>
                                </td>
                                <td>
                                    <div class="cell-title">₹<%= String.format("%,.0f", property.getPrice()) %></div>
                                    <div class="cell-sub">Per month</div>
                                </td>
                                <td>
                                    <div class="cell-title">Owner #<%= property.getOwnerId() %></div>
                                    <div class="cell-sub">Beds: <%= property.getBedrooms() != null ? property.getBedrooms() : "-" %> | Baths: <%= property.getBathrooms() != null ? property.getBathrooms() : "-" %></div>
                                </td>
                                <td>
                                    <% if (property.isAvailable()) { %>
                                        <span class="badge status-available">Available</span>
                                    <% } else { %>
                                        <span class="badge status-unavailable">Unavailable</span>
                                    <% } %>
                                </td>
                                <td>
                                    <span class="badge <%= approvalClass %>"><%= approvalStatus %></span>
                                    <div class="cell-sub">
                                        By: <%= property.getApprovedBy() != null ? property.getApprovedBy() : "-" %>
                                        <br>
                                        At: <%= property.getApprovedAt() != null ? property.getApprovedAt().toString().replace('T', ' ').substring(0, 19) : "-" %>
                                    </div>
                                </td>
                                <td>
                                    <div id="image-thumb-<%= property.getId() %>" class="thumb-link" title="View property" onclick="window.location.href='<%= request.getContextPath() %>/property/details/<%= property.getId() %>'">
                                        <i class="fas fa-image"></i>
                                    </div>
                                </td>
                                <td><%= property.getCreatedAt() != null ? property.getCreatedAt().toString().substring(0, 10) : "-" %></td>
                                <td>
                                    <div class="action-cell">
                                        <% if ("PENDING".equals(approvalStatus)) { %>
                                            <a href="<%= request.getContextPath() %>/admin/approve-property/<%= property.getId() %>" onclick="return confirm('Approve this property?');" class="btn-action btn-success"><i class="fas fa-check"></i> Approve</a>
                                            <a href="<%= request.getContextPath() %>/admin/reject-property/<%= property.getId() %>" onclick="return confirm('Reject this property?');" class="btn-action btn-neutral"><i class="fas fa-ban"></i> Reject</a>
                                        <% } %>
                                        <a href="<%= request.getContextPath() %>/admin/edit-property/<%= property.getId() %>" class="btn-action btn-primary"><i class="fas fa-pen"></i> Edit</a>
                                        <a href="#" onclick="deleteProperty(<%= property.getId() %>, '<%= property.getTitle().replace("'", "\\'") %>')" class="btn-action btn-danger"><i class="fas fa-trash"></i> Delete</a>
                                    </div>
                                </td>
                            </tr>
                        <%
                                }
                            }
                        %>
                        <tr class="empty-row" <%= (properties != null && !properties.isEmpty()) ? "style='display:none;'" : "" %>>
                            <td colspan="9">
                                <div class="empty-state">
                                    <i class="fas fa-building"></i>
                                    <p>No properties found.</p>
                                </div>
                            </td>
                        </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </section>
    </main>
</div>

<script src="<%= request.getContextPath() %>/admin-js/admin-dashboard.js"></script>
<script>
    document.addEventListener('DOMContentLoaded', function() {
        const imageThumbs = document.querySelectorAll('[id^="image-thumb-"]');
        imageThumbs.forEach(function(thumb) {
            const propertyId = thumb.id.replace('image-thumb-', '');
            loadPropertyThumbnail(propertyId, thumb);
        });
    });

    function loadPropertyThumbnail(propertyId, container) {
        fetch('<%= request.getContextPath() %>/image/primary/' + propertyId)
            .then(function(response) {
                if (response.ok) {
                    return response.blob();
                }
                throw new Error('No image');
            })
            .then(function(blob) {
                const url = URL.createObjectURL(blob);
                container.innerHTML = '<img src="' + url + '" alt="Property Image">';
            })
            .catch(function() {
                // Keep icon placeholder if image is unavailable.
            });
    }
</script>
</body>
</html>

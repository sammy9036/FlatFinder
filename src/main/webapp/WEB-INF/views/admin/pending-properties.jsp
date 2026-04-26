<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Pending Properties - FlatFinder Admin</title>
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
            <a href="<%= request.getContextPath() %>/admin/properties" class="menu-item"><i class="fas fa-building"></i> Properties</a>
            <a href="<%= request.getContextPath() %>/admin/pending-properties" class="menu-item active"><i class="fas fa-clock"></i> Pending Approval</a>
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
                    <h1>Pending Property Approvals</h1>
                    <p>Review and take action on newly submitted properties</p>
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
                    <input type="text" id="pendingSearch" class="search-input" placeholder="Search by title, owner, location" onkeyup="filterTable('pendingSearch', 'pendingPropertiesTable')">
                </div>
            </div>

            <div class="table-panel">
                <div class="table-scroll">
                    <table class="admin-table" id="pendingPropertiesTable">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Property</th>
                                <th>Owner</th>
                                <th>Price</th>
                                <th>Specs</th>
                                <th>Description</th>
                                <th>Status</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                        <%
                            if (properties != null && !properties.isEmpty()) {
                                for (com.flatfinder.model.Property property : properties) {
                                    String desc = property.getDescription();
                                    if (desc != null && desc.length() > 80) {
                                        desc = desc.substring(0, 80) + "...";
                                    }
                        %>
                            <tr>
                                <td>#<%= property.getId() %></td>
                                <td>
                                    <div class="cell-title"><%= property.getTitle() %></div>
                                    <div class="cell-sub"><%= property.getLocation() %></div>
                                </td>
                                <td>Owner #<%= property.getOwnerId() %></td>
                                <td>₹<%= String.format("%,.0f", property.getPrice()) %></td>
                                <td><%= property.getBedrooms() != null ? property.getBedrooms() : "-" %> BR | <%= property.getBathrooms() != null ? property.getBathrooms() : "-" %> BA | <%= property.getArea() != null ? property.getArea() : "-" %> sqft</td>
                                <td><div class="message-clamp"><%= desc != null ? desc : "N/A" %></div></td>
                                <td><span class="badge status-pending">Pending</span></td>
                                <td>
                                    <div class="action-cell">
                                        <a href="<%= request.getContextPath() %>/admin/approve-property/<%= property.getId() %>" class="btn-action btn-success" onclick="return confirm('Approve this property?');"><i class="fas fa-check"></i> Approve</a>
                                        <a href="<%= request.getContextPath() %>/admin/reject-property/<%= property.getId() %>" class="btn-action btn-danger" onclick="return confirm('Reject this property?');"><i class="fas fa-ban"></i> Reject</a>
                                    </div>
                                </td>
                            </tr>
                        <%
                                }
                            }
                        %>
                        <tr class="empty-row" <%= (properties != null && !properties.isEmpty()) ? "style='display:none;'" : "" %>>
                            <td colspan="8">
                                <div class="empty-state">
                                    <i class="fas fa-check-circle"></i>
                                    <p>No pending properties. All submissions are reviewed.</p>
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
</body>
</html>
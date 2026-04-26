<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - FlatFinder</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/admin-css/admin-dashboard.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body data-context-path="<%= request.getContextPath() %>">
<%
    com.flatfinder.model.User adminUser = (com.flatfinder.model.User) session.getAttribute("user");
    Object totalUsers = request.getAttribute("totalUsers");
    Object totalOwners = request.getAttribute("totalOwners");
    Object totalSeekers = request.getAttribute("totalSeekers");
    Object totalProperties = request.getAttribute("totalProperties");
    Object totalInquiries = request.getAttribute("totalInquiries");
    Object pendingProperties = request.getAttribute("pendingProperties");
%>
<div class="admin-shell">
    <aside class="admin-sidebar">
        <div class="admin-brand">
            <i class="fas fa-shield-alt"></i>
            <div>
                <h2>FlatFinder Admin</h2>
                <p>Control Center</p>
            </div>
        </div>

        <nav class="sidebar-nav">
            <a href="<%= request.getContextPath() %>/admin/dashboard" class="menu-item active"><i class="fas fa-gauge"></i> Dashboard</a>
            <a href="<%= request.getContextPath() %>/admin/users" class="menu-item"><i class="fas fa-users"></i> Manage Users</a>
            <a href="<%= request.getContextPath() %>/admin/properties" class="menu-item"><i class="fas fa-building"></i> Properties</a>
            <a href="<%= request.getContextPath() %>/admin/pending-properties" class="menu-item"><i class="fas fa-clock"></i> Pending Approval</a>
            <a href="<%= request.getContextPath() %>/admin/add-property" class="menu-item"><i class="fas fa-plus"></i> Add Property</a>
            <a href="<%= request.getContextPath() %>/admin/inquiries" class="menu-item"><i class="fas fa-envelope"></i> Inquiries</a>
        </nav>

        <div class="sidebar-footer">
            <a href="<%= request.getContextPath() %>/auth/logout" class="logout-btn"><i class="fas fa-sign-out-alt"></i> Logout</a>
        </div>
    </aside>

    <main class="admin-main">
        <header class="admin-topbar">
            <div class="topbar-left">
                <button class="menu-toggle" onclick="toggleSidebar()"><i class="fas fa-bars"></i></button>
                <div class="page-title">
                    <h1>Dashboard</h1>
                    <p>Monitor users, listings and inquiries in one place</p>
                </div>
            </div>
            <div class="admin-user">
                <span><%= adminUser != null ? adminUser.getName() : "Admin" %></span>
                <div class="user-avatar"><%= adminUser != null ? adminUser.getName().substring(0, 1).toUpperCase() : "A" %></div>
            </div>
        </header>

        <section class="admin-page">
            <div class="stats-grid">
                <div class="stat-card"><div class="stat-icon primary"><i class="fas fa-users"></i></div><div class="stat-info"><h4><%= totalUsers != null ? totalUsers : 0 %></h4><p>Total Users</p></div></div>
                <div class="stat-card"><div class="stat-icon success"><i class="fas fa-user-tie"></i></div><div class="stat-info"><h4><%= totalOwners != null ? totalOwners : 0 %></h4><p>Owners</p></div></div>
                <div class="stat-card"><div class="stat-icon accent"><i class="fas fa-user-check"></i></div><div class="stat-info"><h4><%= totalSeekers != null ? totalSeekers : 0 %></h4><p>Seekers</p></div></div>
                <div class="stat-card"><div class="stat-icon dark"><i class="fas fa-house"></i></div><div class="stat-info"><h4><%= totalProperties != null ? totalProperties : 0 %></h4><p>Properties</p></div></div>
                <div class="stat-card"><div class="stat-icon warning"><i class="fas fa-hourglass-half"></i></div><div class="stat-info"><h4><%= pendingProperties != null ? pendingProperties : 0 %></h4><p>Pending</p></div></div>
                <div class="stat-card"><div class="stat-icon danger"><i class="fas fa-envelope-open-text"></i></div><div class="stat-info"><h4><%= totalInquiries != null ? totalInquiries : 0 %></h4><p>Inquiries</p></div></div>
            </div>

            <div class="panel">
                <div class="panel-header">
                    <h3>Quick Actions</h3>
                    <p>Jump directly to your most common admin tasks</p>
                </div>
                <div class="panel-body">
                    <div class="action-grid">
                        <a class="action-tile" href="<%= request.getContextPath() %>/admin/users">Users <i class="fas fa-arrow-right"></i></a>
                        <a class="action-tile" href="<%= request.getContextPath() %>/admin/properties">All Properties <i class="fas fa-arrow-right"></i></a>
                        <a class="action-tile" href="<%= request.getContextPath() %>/admin/pending-properties">Pending Review <i class="fas fa-arrow-right"></i></a>
                        <a class="action-tile" href="<%= request.getContextPath() %>/admin/inquiries">All Inquiries <i class="fas fa-arrow-right"></i></a>
                    </div>
                </div>
            </div>
        </section>
    </main>
</div>

<script src="<%= request.getContextPath() %>/admin-js/admin-dashboard.js"></script>
</body>
</html>

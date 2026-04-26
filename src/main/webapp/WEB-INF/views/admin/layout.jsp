<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Panel - FlatFinder</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/admin-css/admin-dashboard.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body data-context-path="<%= request.getContextPath() %>">
<%
    com.flatfinder.model.User user = (com.flatfinder.model.User) session.getAttribute("user");
    String uri = request.getRequestURI();
%>
<div class="admin-shell">
    <aside class="admin-sidebar">
        <div class="admin-brand"><i class="fas fa-shield-alt"></i><div><h2>FlatFinder Admin</h2><p>Control Center</p></div></div>
        <nav class="sidebar-nav">
            <a href="<%= request.getContextPath() %>/admin/dashboard" class="menu-item <%= uri.endsWith("/admin/dashboard") ? "active" : "" %>"><i class="fas fa-gauge"></i> Dashboard</a>
            <a href="<%= request.getContextPath() %>/admin/users" class="menu-item <%= uri.endsWith("/admin/users") ? "active" : "" %>"><i class="fas fa-users"></i> Manage Users</a>
            <a href="<%= request.getContextPath() %>/admin/properties" class="menu-item <%= uri.endsWith("/admin/properties") ? "active" : "" %>"><i class="fas fa-building"></i> Properties</a>
            <a href="<%= request.getContextPath() %>/admin/pending-properties" class="menu-item <%= uri.endsWith("/admin/pending-properties") ? "active" : "" %>"><i class="fas fa-clock"></i> Pending Approval</a>
            <a href="<%= request.getContextPath() %>/admin/add-property" class="menu-item <%= uri.endsWith("/admin/add-property") ? "active" : "" %>"><i class="fas fa-plus"></i> Add Property</a>
            <a href="<%= request.getContextPath() %>/admin/inquiries" class="menu-item <%= uri.endsWith("/admin/inquiries") ? "active" : "" %>"><i class="fas fa-envelope"></i> Inquiries</a>
        </nav>
        <div class="sidebar-footer"><a href="<%= request.getContextPath() %>/auth/logout" class="logout-btn"><i class="fas fa-sign-out-alt"></i> Logout</a></div>
    </aside>

    <main class="admin-main">
        <header class="admin-topbar">
            <div class="topbar-left">
                <button class="menu-toggle" onclick="toggleSidebar()"><i class="fas fa-bars"></i></button>
                <div class="page-title">
                    <h1>Admin Panel</h1>
                    <p>FlatFinder platform management</p>
                </div>
            </div>
            <div class="admin-user">
                <span><%= user != null ? user.getName() : "Admin" %></span>
                <div class="user-avatar"><%= user != null ? user.getName().substring(0, 1).toUpperCase() : "A" %></div>
            </div>
        </header>

        <section class="admin-page">
            <jsp:include page="<%= (String) request.getAttribute("page") %>"/>
        </section>
    </main>
</div>

<script src="<%= request.getContextPath() %>/admin-js/admin-dashboard.js"></script>
</body>
</html>

<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Users - FlatFinder Admin</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/admin-css/admin-dashboard.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body data-context-path="<%= request.getContextPath() %>">
<%
    com.flatfinder.model.User adminUser = (com.flatfinder.model.User) session.getAttribute("user");
    java.util.List<com.flatfinder.model.User> users = (java.util.List<com.flatfinder.model.User>) request.getAttribute("users");
%>
<div class="admin-shell">
    <aside class="admin-sidebar">
        <div class="admin-brand"><i class="fas fa-shield-alt"></i><div><h2>FlatFinder Admin</h2><p>Control Center</p></div></div>
        <nav class="sidebar-nav">
            <a href="<%= request.getContextPath() %>/admin/dashboard" class="menu-item"><i class="fas fa-gauge"></i> Dashboard</a>
            <a href="<%= request.getContextPath() %>/admin/users" class="menu-item active"><i class="fas fa-users"></i> Manage Users</a>
            <a href="<%= request.getContextPath() %>/admin/properties" class="menu-item"><i class="fas fa-building"></i> Properties</a>
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
                    <h1>Manage Users</h1>
                    <p>View roles, verification, and remove invalid accounts</p>
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
                    <input type="text" id="userSearch" class="search-input" placeholder="Search by name, email, role, or phone" onkeyup="filterTable('userSearch', 'usersTable')">
                </div>
            </div>

            <div class="table-panel">
                <div class="table-scroll">
                    <table class="admin-table" id="usersTable">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>User</th>
                                <th>Role</th>
                                <th>Phone</th>
                                <th>Verification</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                        <%
                            if (users != null && !users.isEmpty()) {
                                for (com.flatfinder.model.User user : users) {
                                    String roleClass = "role-seeker";
                                    if ("ADMIN".equals(user.getRole().toString())) {
                                        roleClass = "role-admin";
                                    } else if ("OWNER".equals(user.getRole().toString())) {
                                        roleClass = "role-owner";
                                    }
                        %>
                            <tr>
                                <td>#<%= user.getId() %></td>
                                <td>
                                    <div class="cell-title"><%= user.getName() %></div>
                                    <div class="cell-sub"><%= user.getEmail() %></div>
                                </td>
                                <td><span class="badge <%= roleClass %>"><%= user.getRole() %></span></td>
                                <td><%= user.getPhoneNumber() != null ? user.getPhoneNumber() : "-" %></td>
                                <td>
                                    <% if (user.isVerified()) { %>
                                        <span class="badge status-verified"><i class="fas fa-check-circle"></i>&nbsp;Verified</span>
                                    <% } else { %>
                                        <span class="badge status-not-verified"><i class="fas fa-times-circle"></i>&nbsp;Not Verified</span>
                                    <% } %>
                                </td>
                                <td>
                                    <div class="action-cell">
                                        <a href="#" onclick="deleteUser(<%= user.getId() %>, '<%= user.getName().replace("'", "\\'") %>')" class="btn-action btn-danger">
                                            <i class="fas fa-trash"></i> Delete
                                        </a>
                                    </div>
                                </td>
                            </tr>
                        <%
                                }
                            }
                        %>
                        <tr class="empty-row" <%= (users != null && !users.isEmpty()) ? "style='display:none;'" : "" %>>
                            <td colspan="6">
                                <div class="empty-state">
                                    <i class="fas fa-inbox"></i>
                                    <p>No users found.</p>
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
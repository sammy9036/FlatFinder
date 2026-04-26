<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Inquiries - FlatFinder Admin</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/admin-css/admin-dashboard.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body data-context-path="<%= request.getContextPath() %>">
<%
    com.flatfinder.model.User adminUser = (com.flatfinder.model.User) session.getAttribute("user");
    java.util.List<com.flatfinder.model.Inquiry> inquiries = (java.util.List<com.flatfinder.model.Inquiry>) request.getAttribute("inquiries");
%>
<div class="admin-shell">
    <aside class="admin-sidebar">
        <div class="admin-brand"><i class="fas fa-shield-alt"></i><div><h2>FlatFinder Admin</h2><p>Control Center</p></div></div>
        <nav class="sidebar-nav">
            <a href="<%= request.getContextPath() %>/admin/dashboard" class="menu-item"><i class="fas fa-gauge"></i> Dashboard</a>
            <a href="<%= request.getContextPath() %>/admin/users" class="menu-item"><i class="fas fa-users"></i> Manage Users</a>
            <a href="<%= request.getContextPath() %>/admin/properties" class="menu-item"><i class="fas fa-building"></i> Properties</a>
            <a href="<%= request.getContextPath() %>/admin/pending-properties" class="menu-item"><i class="fas fa-clock"></i> Pending Approval</a>
            <a href="<%= request.getContextPath() %>/admin/add-property" class="menu-item"><i class="fas fa-plus"></i> Add Property</a>
            <a href="<%= request.getContextPath() %>/admin/inquiries" class="menu-item active"><i class="fas fa-envelope"></i> Inquiries</a>
        </nav>
        <div class="sidebar-footer"><a href="<%= request.getContextPath() %>/auth/logout" class="logout-btn"><i class="fas fa-sign-out-alt"></i> Logout</a></div>
    </aside>

    <main class="admin-main">
        <header class="admin-topbar">
            <div class="topbar-left">
                <button class="menu-toggle" onclick="toggleSidebar()"><i class="fas fa-bars"></i></button>
                <div class="page-title">
                    <h1>Manage Inquiries</h1>
                    <p>Track seeker communication across all properties</p>
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
                    <input type="text" id="inquirySearch" class="search-input" placeholder="Search by seeker, email, phone, message" onkeyup="filterTable('inquirySearch', 'inquiriesTable')">
                </div>
            </div>

            <div class="table-panel">
                <div class="table-scroll">
                    <table class="admin-table" id="inquiriesTable">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Seeker</th>
                                <th>Property</th>
                                <th>Message</th>
                                <th>Status</th>
                                <th>Date</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                        <%
                            if (inquiries != null && !inquiries.isEmpty()) {
                                for (com.flatfinder.model.Inquiry inquiry : inquiries) {
                                    String status = inquiry.getStatus() != null ? inquiry.getStatus() : "PENDING";
                                    String statusClass = "status-pending";
                                    if ("RESOLVED".equals(status)) {
                                        statusClass = "status-resolved";
                                    } else if ("CONTACTED".equals(status)) {
                                        statusClass = "status-contacted";
                                    }
                        %>
                            <tr>
                                <td>#<%= inquiry.getId() %></td>
                                <td>
                                    <div class="cell-title"><%= inquiry.getSeekerName() != null ? inquiry.getSeekerName() : "N/A" %></div>
                                    <div class="cell-sub"><%= inquiry.getSeekerEmail() != null ? inquiry.getSeekerEmail() : "N/A" %> | <%= inquiry.getSeekerPhone() != null ? inquiry.getSeekerPhone() : "N/A" %></div>
                                </td>
                                <td>Property #<%= inquiry.getPropertyId() %></td>
                                <td>
                                    <div class="message-clamp" title="<%= inquiry.getMessage() != null ? inquiry.getMessage() : "" %>">
                                        <%= inquiry.getMessage() != null ? inquiry.getMessage() : "N/A" %>
                                    </div>
                                </td>
                                <td><span class="badge <%= statusClass %>"><%= status %></span></td>
                                <td><%= inquiry.getCreatedAt() != null ? inquiry.getCreatedAt().toString().replace('T', ' ').substring(0, 16) : "N/A" %></td>
                                <td>
                                    <div class="action-cell">
                                        <a href="#" onclick="deleteInquiry(<%= inquiry.getId() %>)" class="btn-action btn-danger"><i class="fas fa-trash"></i> Delete</a>
                                    </div>
                                </td>
                            </tr>
                        <%
                                }
                            }
                        %>
                        <tr class="empty-row" <%= (inquiries != null && !inquiries.isEmpty()) ? "style='display:none;'" : "" %>>
                            <td colspan="7">
                                <div class="empty-state">
                                    <i class="fas fa-envelope-open"></i>
                                    <p>No inquiries found.</p>
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
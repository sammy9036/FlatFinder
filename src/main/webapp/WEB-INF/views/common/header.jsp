<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%
    // Get user from session
    Object userObj = session.getAttribute("user");
    Object userRoleObj = session.getAttribute("userRole");
    String userName = "";
    String userRole = "";
    
    if (userObj != null && userRoleObj != null) {
        // User is logged in
        com.flatfinder.model.User user = (com.flatfinder.model.User) userObj;
        userName = user.getName();
        userRole = (String) userRoleObj;
    }
%>
    <!-- Modern Navigation Bar -->
    <nav class="navbar">
        <div class="container">
            <div class="navbar-brand">
                <a href="<%= request.getContextPath() %>/">
                    <i class="fas fa-home"></i>
                    <h1>FlatFinder</h1>
                </a>
            </div>
            <ul class="navbar-menu">
                <li><a href="<%= request.getContextPath() %>/">Home</a></li>
                <li><a href="<%= request.getContextPath() %>/property/all">Browse Properties</a></li>
                <li><a href="<%= request.getContextPath() %>/about">About</a></li>
                <li><a href="<%= request.getContextPath() %>/contact">Contact</a></li>
                
                <%
                    if (userObj == null) {
                %>
                    <li><a href="<%= request.getContextPath() %>/auth/login" class="btn btn-primary btn-sm">Login</a></li>
                    <li><a href="<%= request.getContextPath() %>/auth/register" class="btn btn-secondary btn-sm">Register</a></li>
                <%
                    } else {
                %>
                    <li>
                        <a href="#"><i class="fas fa-user-circle"></i> <%= userName %></a>
                        <ul class="dropdown">
                            <%
                                if ("OWNER".equals(userRole)) {
                            %>
                                <li><a href="<%= request.getContextPath() %>/owner/dashboard"><i class="fas fa-tachometer-alt"></i> Dashboard</a></li>
                                <li><a href="<%= request.getContextPath() %>/owner/add-property"><i class="fas fa-plus"></i> Add Property</a></li>
                                <li><a href="<%= request.getContextPath() %>/inquiry/received-inquiries"><i class="fas fa-envelope"></i> Inquiries</a></li>
                            <%
                                } else if ("SEEKER".equals(userRole)) {
                            %>
                                <li><a href="<%= request.getContextPath() %>/seeker/home"><i class="fas fa-home"></i> Home</a></li>
                                <li><a href="<%= request.getContextPath() %>/seeker/my-inquiries"><i class="fas fa-list"></i> My Inquiries</a></li>
                            <%
                                } else if ("ADMIN".equals(userRole)) {
                            %>
                                <li><a href="<%= request.getContextPath() %>/admin/dashboard"><i class="fas fa-tachometer-alt"></i> Dashboard</a></li>
                                <li><a href="<%= request.getContextPath() %>/admin/users"><i class="fas fa-users"></i> Manage Users</a></li>
                                <li><a href="<%= request.getContextPath() %>/admin/properties"><i class="fas fa-home"></i> All Properties</a></li>
                                <li><a href="<%= request.getContextPath() %>/admin/pending-properties"><i class="fas fa-clock"></i> Pending Approval</a></li>
                                <li><a href="<%= request.getContextPath() %>/admin/add-property"><i class="fas fa-plus"></i> Add Property</a></li>
                            <%
                                }
                            %>
                            <li><a href="<%= request.getContextPath() %>/auth/logout"><i class="fas fa-sign-out-alt"></i> Logout</a></li>
                        </ul>
                    </li>
                <%
                    }
                %>
            </ul>
        </div>
    </nav>

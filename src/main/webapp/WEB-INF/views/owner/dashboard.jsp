<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Owner Dashboard - FlatFinder</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        .owner-dashboard {
            padding: 2rem 0 3rem;
        }

        .owner-hero {
            background: linear-gradient(135deg, var(--primary-color), var(--primary-dark));
            color: #fff;
            border-radius: 16px;
            padding: 1.75rem;
            box-shadow: var(--shadow-md);
            margin-bottom: 1.5rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 1rem;
            flex-wrap: wrap;
        }

        .owner-hero h1 {
            margin: 0 0 0.35rem;
            font-size: 1.8rem;
        }

        .owner-hero p {
            margin: 0;
            opacity: 0.92;
        }

        .owner-stats {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
            gap: 1rem;
            margin-bottom: 1.5rem;
        }

        .owner-stat-card {
            background: var(--bg-white);
            border-radius: 14px;
            box-shadow: var(--shadow-sm);
            padding: 1.1rem 1.2rem;
            display: flex;
            align-items: center;
            gap: 0.9rem;
            border-left: 4px solid var(--primary-color);
        }

        .owner-stat-card .icon {
            width: 46px;
            height: 46px;
            border-radius: 12px;
            background: rgba(76, 175, 80, 0.14);
            color: var(--primary-color);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.15rem;
        }

        .owner-stat-card h3 {
            margin: 0;
            font-size: 1.45rem;
            line-height: 1.1;
        }

        .owner-stat-card p {
            margin: 0;
            color: var(--text-light);
            font-size: 0.86rem;
        }

        .owner-layout {
            display: grid;
            grid-template-columns: minmax(0, 1.5fr) minmax(0, 1fr);
            gap: 1.2rem;
        }

        .panel {
            background: var(--bg-white);
            border-radius: 14px;
            box-shadow: var(--shadow-sm);
            padding: 1.2rem;
        }

        .panel-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 0.8rem;
            margin-bottom: 1rem;
            flex-wrap: wrap;
        }

        .panel-header h2 {
            margin: 0;
            font-size: 1.2rem;
        }

        .owner-table-wrap {
            overflow-x: auto;
            border-radius: 12px;
            border: 1px solid var(--border-color);
        }

        .owner-table {
            width: 100%;
            border-collapse: collapse;
            min-width: 760px;
        }

        .owner-table th,
        .owner-table td {
            padding: 0.85rem 0.9rem;
            border-bottom: 1px solid var(--border-color);
            font-size: 13px;
            text-align: left;
        }

        .owner-table th {
            background: var(--bg-light);
            color: var(--text-dark);
            font-weight: 600;
        }

        .status-chip {
            display: inline-flex;
            align-items: center;
            gap: 0.35rem;
            border-radius: 999px;
            padding: 0.3rem 0.7rem;
            font-size: 12px;
            font-weight: 600;
        }

        .status-chip.available {
            background: rgba(39, 174, 96, 0.12);
            color: var(--success-color);
        }

        .status-chip.unavailable {
            background: rgba(231, 76, 60, 0.12);
            color: var(--danger-color);
        }

        .action-row {
            display: flex;
            gap: 0.45rem;
            flex-wrap: wrap;
        }

        .owner-quick {
            display: grid;
            gap: 0.9rem;
        }

        .quick-card {
            border: 1px solid var(--border-color);
            border-radius: 12px;
            padding: 1rem;
            background: var(--bg-light);
        }

        .quick-card h3 {
            margin: 0 0 0.35rem;
            font-size: 1rem;
        }

        .quick-card p {
            margin: 0 0 0.75rem;
            color: var(--text-light);
            font-size: 13px;
        }

        @media (max-width: 1024px) {
            .owner-layout {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
    <jsp:include page="/WEB-INF/views/common/header.jsp"/>

    <div class="container owner-dashboard">
        <%
            Object propertyCount = request.getAttribute("propertyCount");
            Object inquiryCount = request.getAttribute("inquiryCount");
            int propCount = (propertyCount != null) ? ((Number) propertyCount).intValue() : 0;
            int inqCount = (inquiryCount != null) ? ((Number) inquiryCount).intValue() : 0;
            List<?> properties = (List<?>) request.getAttribute("properties");
        %>

        <section class="owner-hero">
            <div>
                <h1><i class="fas fa-chart-line"></i> Owner Dashboard</h1>
                <p>Track listings, manage availability, and respond quickly to incoming inquiries.</p>
            </div>
            <a href="<%= request.getContextPath() %>/owner/add-property" class="btn btn-primary">
                <i class="fas fa-plus"></i> Add New Property
            </a>
        </section>

        <section class="owner-stats">
            <div class="owner-stat-card">
                <div class="icon"><i class="fas fa-home"></i></div>
                <div>
                    <h3><%= propCount %></h3>
                    <p>Properties Listed</p>
                </div>
            </div>
            <div class="owner-stat-card">
                <div class="icon"><i class="fas fa-envelope"></i></div>
                <div>
                    <h3><%= inqCount %></h3>
                    <p>Inquiries Received</p>
                </div>
            </div>
            <div class="owner-stat-card">
                <div class="icon"><i class="fas fa-circle-check"></i></div>
                <div>
                    <h3>Active</h3>
                    <p>Owner Account Status</p>
                </div>
            </div>
        </section>

        <section class="owner-layout">
            <div class="panel">
                <div class="panel-header">
                    <h2><i class="fas fa-building"></i> My Properties</h2>
                </div>

                <% if (properties == null || properties.isEmpty()) { %>
                    <div class="no-data">
                        <i class="fas fa-inbox"></i>
                        <p>You haven't listed any properties yet. Add your first listing to start receiving inquiries.</p>
                    </div>
                <% } else { %>
                    <div class="owner-table-wrap">
                        <table class="owner-table">
                            <thead>
                                <tr>
                                    <th>Property</th>
                                    <th>Location</th>
                                    <th>Rent</th>
                                    <th>Status</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                            <%
                                for (int i = 0; i < properties.size(); i++) {
                                    Object prop = properties.get(i);
                                    Object title = null, location = null, price = null, available = null, id = null;
                                    try {
                                        title = prop.getClass().getMethod("getTitle").invoke(prop);
                                        location = prop.getClass().getMethod("getLocation").invoke(prop);
                                        price = prop.getClass().getMethod("getPrice").invoke(prop);
                                        available = prop.getClass().getMethod("isAvailable").invoke(prop);
                                        id = prop.getClass().getMethod("getId").invoke(prop);
                                    } catch (Exception e) {
                                        continue;
                                    }
                                    boolean isAvailable = (available != null) ? (Boolean) available : false;
                            %>
                                <tr>
                                    <td><strong><%= title %></strong></td>
                                    <td><i class="fas fa-location-dot"></i> <%= location %></td>
                                    <td><strong>₹<%= price %>/month</strong></td>
                                    <td>
                                        <span class="status-chip <%= isAvailable ? "available" : "unavailable" %>">
                                            <i class="fas <%= isAvailable ? "fa-check-circle" : "fa-times-circle" %>"></i>
                                            <%= isAvailable ? "Available" : "Unavailable" %>
                                        </span>
                                    </td>
                                    <td>
                                        <div class="action-row">
                                            <a href="<%= request.getContextPath() %>/owner/edit-property/<%= id %>" class="btn btn-sm btn-secondary">
                                                <i class="fas fa-pen"></i> Edit
                                            </a>
                                            <a href="<%= request.getContextPath() %>/owner/toggle-availability/<%= id %>" class="btn btn-sm btn-outline">
                                                <i class="fas <%= isAvailable ? "fa-eye-slash" : "fa-eye" %>"></i>
                                                <%= isAvailable ? "Hide" : "Show" %>
                                            </a>
                                            <a href="<%= request.getContextPath() %>/owner/delete-property/<%= id %>" class="btn btn-sm btn-danger" onclick="return confirm('Are you sure you want to delete this property?');">
                                                <i class="fas fa-trash"></i> Delete
                                            </a>
                                        </div>
                                    </td>
                                </tr>
                            <% } %>
                            </tbody>
                        </table>
                    </div>
                <% } %>
            </div>

            <div class="owner-quick">
                <div class="panel quick-card">
                    <h3><i class="fas fa-envelope-open-text"></i> Inquiry Inbox</h3>
                    <p>Review and respond to the latest messages from seekers.</p>
                    <a href="<%= request.getContextPath() %>/inquiry/received-inquiries" class="btn btn-primary btn-sm">Open Inquiries</a>
                </div>

                <div class="panel quick-card">
                    <h3><i class="fas fa-square-plus"></i> Add More Listings</h3>
                    <p>Publish additional properties to increase visibility and leads.</p>
                    <a href="<%= request.getContextPath() %>/owner/add-property" class="btn btn-secondary btn-sm">Add Property</a>
                </div>

                <div class="panel quick-card">
                    <h3><i class="fas fa-chart-pie"></i> Portfolio Snapshot</h3>
                    <p><strong><%= propCount %></strong> total listings and <strong><%= inqCount %></strong> inquiries received so far.</p>
                </div>
            </div>
        </section>
    </div>
    
    <jsp:include page="/WEB-INF/views/common/footer.jsp"/>
    <script src="<%= request.getContextPath() %>/js/script.js"></script>
</body>
</html>

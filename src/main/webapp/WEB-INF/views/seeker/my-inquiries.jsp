<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Inquiries - FlatFinder</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        .inquiry-dashboard {
            padding: 2rem 0 3rem;
        }

        .inquiry-hero {
            background: linear-gradient(135deg, var(--primary-color), var(--primary-dark));
            color: #fff;
            border-radius: 16px;
            padding: 1.7rem;
            box-shadow: var(--shadow-md);
            margin-bottom: 1.2rem;
            display: flex;
            justify-content: space-between;
            gap: 1rem;
            flex-wrap: wrap;
            align-items: center;
        }

        .inquiry-hero h1 {
            margin: 0 0 0.35rem;
            font-size: 1.75rem;
        }

        .inquiry-hero p {
            margin: 0;
            opacity: 0.92;
        }

        .summary-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(180px, 1fr));
            gap: 1rem;
            margin-bottom: 1.2rem;
        }

        .summary-card {
            background: var(--bg-white);
            border-radius: 12px;
            box-shadow: var(--shadow-sm);
            padding: 1rem;
            border-left: 4px solid var(--primary-color);
        }

        .summary-card p {
            margin: 0;
            color: var(--text-light);
            font-size: 12px;
        }

        .summary-card h3 {
            margin: 0.35rem 0 0;
            font-size: 1.35rem;
        }

        .inquiry-panel {
            background: var(--bg-white);
            border-radius: 14px;
            box-shadow: var(--shadow-sm);
            padding: 1.1rem;
        }

        .inquiry-table-wrap {
            overflow-x: auto;
            border: 1px solid var(--border-color);
            border-radius: 12px;
        }

        .inquiry-table {
            width: 100%;
            border-collapse: collapse;
            min-width: 740px;
        }

        .inquiry-table th,
        .inquiry-table td {
            padding: 0.85rem;
            border-bottom: 1px solid var(--border-color);
            text-align: left;
            font-size: 13px;
        }

        .inquiry-table th {
            background: var(--bg-light);
            font-weight: 600;
        }

        .status-pill {
            display: inline-flex;
            align-items: center;
            gap: 0.3rem;
            border-radius: 999px;
            padding: 0.28rem 0.7rem;
            font-size: 12px;
            font-weight: 600;
            text-transform: capitalize;
        }

        .status-pill.pending {
            background: rgba(243, 156, 18, 0.14);
            color: var(--warning-color);
        }

        .status-pill.contacted,
        .status-pill.resolved {
            background: rgba(39, 174, 96, 0.14);
            color: var(--success-color);
        }

        .status-pill.rejected {
            background: rgba(231, 76, 60, 0.14);
            color: var(--danger-color);
        }

        .status-pill.default {
            background: rgba(52, 152, 219, 0.14);
            color: var(--accent-color);
        }

        .message-cell {
            max-width: 320px;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }

        .payment-banner {
            border-radius: 12px;
            padding: 0.9rem 1rem;
            margin-bottom: 1rem;
            border: 1px solid transparent;
            font-size: 13px;
            display: flex;
            align-items: center;
            gap: 0.6rem;
        }

        .payment-banner.success {
            background: rgba(39, 174, 96, 0.12);
            border-color: rgba(39, 174, 96, 0.25);
            color: var(--success-color);
        }

        .payment-banner.info {
            background: rgba(52, 152, 219, 0.12);
            border-color: rgba(52, 152, 219, 0.25);
            color: var(--accent-color);
        }

        .payment-action {
            display: inline-flex;
            align-items: center;
            gap: 0.35rem;
            white-space: nowrap;
        }

        .action-note {
            color: var(--text-light);
            font-size: 12px;
            margin-top: 0.35rem;
        }
    </style>
</head>
<body>
    <jsp:include page="/WEB-INF/views/common/header.jsp"/>

    <div class="container inquiry-dashboard">
        <%
            String paymentStatus = request.getParameter("paymentStatus");
            String paymentMessage = request.getParameter("paymentMessage");
        %>

        <% if (paymentStatus != null && paymentMessage != null) { %>
            <div class="payment-banner <%= paymentStatus %>">
                <i class="fas <%= "success".equalsIgnoreCase(paymentStatus) ? "fa-circle-check" : "fa-circle-info" %>"></i>
                <span><%= paymentMessage %></span>
            </div>
        <% } %>

        <%
            List<?> inquiries = (List<?>) request.getAttribute("inquiries");
            int total = (inquiries != null) ? inquiries.size() : 0;
            int pending = 0;
            int approved = 0;
            int resolved = 0;
            int rejected = 0;
            if (inquiries != null) {
                for (Object iObj : inquiries) {
                    try {
                        Object stObj = iObj.getClass().getMethod("getStatus").invoke(iObj);
                        String st = (stObj != null) ? stObj.toString() : "";
                        if ("PENDING".equalsIgnoreCase(st)) {
                            pending++;
                        }
                        if ("CONTACTED".equalsIgnoreCase(st)) {
                            approved++;
                        }
                        if ("RESOLVED".equalsIgnoreCase(st)) {
                            resolved++;
                        }
                        if ("REJECTED".equalsIgnoreCase(st)) {
                            rejected++;
                        }
                    } catch (Exception e) {
                        // ignore malformed row
                    }
                }
            }
        %>

        <section class="inquiry-hero">
            <div>
                <h1><i class="fas fa-paper-plane"></i> My Inquiries</h1>
                <p>Track all inquiries you have sent to property owners in one place.</p>
            </div>
            <a href="<%= request.getContextPath() %>/property/all" class="btn btn-primary">
                <i class="fas fa-search"></i> Browse More Properties
            </a>
        </section>

        <section class="summary-grid">
            <div class="summary-card">
                <p>Total Inquiries</p>
                <h3><%= total %></h3>
            </div>
            <div class="summary-card">
                <p>Pending</p>
                <h3><%= pending %></h3>
            </div>
            <div class="summary-card">
                <p>Approved for Payment</p>
                <h3><%= approved %></h3>
            </div>
            <div class="summary-card">
                <p>Completed</p>
                <h3><%= resolved %></h3>
            </div>
        </section>

        <section class="inquiry-panel">
            <% if (inquiries == null || inquiries.isEmpty()) { %>
                <div class="no-data">
                    <i class="fas fa-inbox"></i>
                    <p>You haven't sent any inquiries yet.</p>
                </div>
            <% } else { %>
                <div class="inquiry-table-wrap">
                    <table class="inquiry-table">
                        <thead>
                            <tr>
                                <th>Property</th>
                                <th>Message</th>
                                <th>Status</th>
                                <th>Sent On</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                        <%
                            for (int i = 0; i < inquiries.size(); i++) {
                                Object inquiry = inquiries.get(i);
                                Object inquiryId = null, propId = null, message = null, status = null, createdAt = null;
                                try {
                                    inquiryId = inquiry.getClass().getMethod("getId").invoke(inquiry);
                                    propId = inquiry.getClass().getMethod("getPropertyId").invoke(inquiry);
                                    message = inquiry.getClass().getMethod("getMessage").invoke(inquiry);
                                    status = inquiry.getClass().getMethod("getStatus").invoke(inquiry);
                                    createdAt = inquiry.getClass().getMethod("getCreatedAt").invoke(inquiry);
                                } catch (Exception e) {
                                    continue;
                                }
                                String statusText = (status != null) ? status.toString() : "UNKNOWN";
                                String statusClass = "default";
                                if ("PENDING".equalsIgnoreCase(statusText)) {
                                    statusClass = "pending";
                                } else if ("CONTACTED".equalsIgnoreCase(statusText) || "RESOLVED".equalsIgnoreCase(statusText)) {
                                    statusClass = "resolved";
                                } else if ("REJECTED".equalsIgnoreCase(statusText)) {
                                    statusClass = "rejected";
                                }
                        %>
                            <tr>
                                <td><strong>#<%= propId %></strong></td>
                                <td class="message-cell"><%= message %></td>
                                <td>
                                    <span class="status-pill <%= statusClass %>">
                                        <i class="fas fa-circle"></i> <%= statusText %>
                                    </span>
                                </td>
                                <td><%= createdAt %></td>
                                <td>
                                    <%
                                        if ("CONTACTED".equalsIgnoreCase(statusText)) {
                                    %>
                                        <a href="<%= request.getContextPath() %>/inquiry/payment/<%= inquiryId %>" class="btn btn-sm btn-primary payment-action">
                                            <i class="fas fa-credit-card"></i> Pay Now
                                        </a>
                                        <div class="action-note">Owner approved this inquiry. Open the dummy test payment screen.</div>
                                    <%
                                        } else if ("RESOLVED".equalsIgnoreCase(statusText)) {
                                    %>
                                        <span class="action-note"><i class="fas fa-circle-check"></i> Payment completed</span>
                                    <%
                                        } else if ("REJECTED".equalsIgnoreCase(statusText)) {
                                    %>
                                        <span class="action-note"><i class="fas fa-ban"></i> Owner rejected this inquiry</span>
                                    <%
                                        } else {
                                    %>
                                        <span class="action-note"><i class="fas fa-hourglass-half"></i> Waiting for owner decision</span>
                                    <%
                                        }
                                    %>
                                </td>
                            </tr>
                        <% } %>
                        </tbody>
                    </table>
                </div>
            <% } %>
        </section>
    </div>
    
    <jsp:include page="/WEB-INF/views/common/footer.jsp"/>
</body>
</html>

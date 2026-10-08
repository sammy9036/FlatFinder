<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Received Inquiries - FlatFinder</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
</head>
<body>
    <jsp:include page="/WEB-INF/views/common/header.jsp"/>

    <section class="received-inquiries-page section-padding">
        <div class="container">
            <%
                List<?> inquiries = (List<?>) request.getAttribute("inquiries");
                int inquiryCount = (inquiries == null) ? 0 : inquiries.size();
            %>

            <div class="inquiry-page-header">
                <div>
                    <p class="inquiry-kicker">Owner Inbox</p>
                    <h1>Received Inquiries</h1>
                    <p class="text-muted">Mark an inquiry as <strong>Contacted</strong> to unlock the seeker’s dummy payment screen, or choose <strong>Rejected</strong> to stop the flow.</p>
                </div>
                <div class="inquiry-summary-card">
                    <i class="fas fa-envelope-open-text"></i>
                    <div>
                        <h3><%= inquiryCount %></h3>
                        <p>Total inquiries</p>
                    </div>
                </div>
            </div>

            <%
                if (inquiries == null || inquiries.isEmpty()) {
            %>
                <div class="inquiry-empty-state">
                    <i class="fas fa-inbox"></i>
                    <h3>No inquiries yet</h3>
                    <p>When seekers contact you, their messages will appear here.</p>
                    <a href="<%= request.getContextPath() %>/owner/dashboard" class="btn btn-primary">Back to Dashboard</a>
                </div>
            <%
                }
            %>

            <%
                if (inquiries != null && !inquiries.isEmpty()) {
            %>
                <div class="inquiry-table-wrapper">
                    <table class="inquiry-table">
                        <thead>
                            <tr>
                                <th>Inquirer</th>
                                <th>Contact</th>
                                <th>Message</th>
                                <th>Status</th>
                                <th>Received</th>
                                <th>Update</th>
                            </tr>
                        </thead>
                        <tbody>
                        <%
                            for (int i = 0; i < inquiries.size(); i++) {
                                Object inquiry = inquiries.get(i);
                                Object name = null, email = null, phone = null, message = null, status = null, createdAt = null, id = null;

                                try {
                                    name = inquiry.getClass().getMethod("getInquirerName").invoke(inquiry);
                                    email = inquiry.getClass().getMethod("getInquirerEmail").invoke(inquiry);
                                    phone = inquiry.getClass().getMethod("getInquirerPhone").invoke(inquiry);
                                    message = inquiry.getClass().getMethod("getMessage").invoke(inquiry);
                                    status = inquiry.getClass().getMethod("getStatus").invoke(inquiry);
                                    createdAt = inquiry.getClass().getMethod("getCreatedAt").invoke(inquiry);
                                    id = inquiry.getClass().getMethod("getId").invoke(inquiry);
                                } catch (Exception e) {
                                    continue;
                                }

                                String statusText = (status == null) ? "PENDING" : status.toString();
                                String badgeClass = "pending";
                                if ("CONTACTED".equals(statusText)) {
                                    badgeClass = "contacted";
                                } else if ("RESOLVED".equals(statusText)) {
                                    badgeClass = "resolved";
                                } else if ("REJECTED".equals(statusText)) {
                                    badgeClass = "rejected";
                                }
                        %>
                            <tr>
                                <td>
                                    <div class="inquirer-cell">
                                        <div class="inquirer-avatar"><i class="fas fa-user"></i></div>
                                        <span><%= name %></span>
                                    </div>
                                </td>
                                <td>
                                    <div class="contact-lines">
                                        <span><i class="fas fa-envelope"></i> <%= email %></span>
                                        <span><i class="fas fa-phone"></i> <%= phone %></span>
                                    </div>
                                </td>
                                <td>
                                    <p class="inquiry-message" title="<%= message %>"><%= message %></p>
                                </td>
                                <td>
                                    <span class="inquiry-status-badge <%= badgeClass %>"><%= statusText %></span>
                                </td>
                                <td>
                                    <span class="inquiry-date"><i class="far fa-calendar-alt"></i> <%= createdAt %></span>
                                </td>
                                <td>
                                    <form method="POST" action="<%= request.getContextPath() %>/inquiry/update-status/<%= id %>">
                                        <select name="status" onchange="this.form.submit();" class="inquiry-status-select">
                                            <option value="PENDING" <% if ("PENDING".equals(statusText)) { %>selected<% } %>>Pending review</option>
                                            <option value="CONTACTED" <% if ("CONTACTED".equals(statusText)) { %>selected<% } %>>Approved for payment</option>
                                            <option value="RESOLVED" <% if ("RESOLVED".equals(statusText)) { %>selected<% } %>>Payment completed</option>
                                            <option value="REJECTED" <% if ("REJECTED".equals(statusText)) { %>selected<% } %>>Rejected</option>
                                        </select>
                                    </form>
                                </td>
                            </tr>
                        <%
                            }
                        %>
                        </tbody>
                    </table>
                </div>
            <%
                }
            %>
        </div>
    </section>
    
    <jsp:include page="/WEB-INF/views/common/footer.jsp"/>
</body>
</html>

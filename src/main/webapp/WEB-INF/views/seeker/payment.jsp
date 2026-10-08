<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dummy Payment - FlatFinder</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        .dummy-payment-page {
            min-height: calc(100vh - 120px);
            padding: 2rem 0 3rem;
            display: flex;
            align-items: center;
        }

        .dummy-payment-overlay {
            width: 100%;
            display: flex;
            justify-content: center;
        }

        .dummy-payment-modal {
            width: min(1180px, 100%);
            display: grid;
            grid-template-columns: minmax(0, 1.18fr) minmax(300px, 0.82fr);
            gap: 1rem;
        }

        .dummy-panel,
        .dummy-summary-panel {
            background: rgba(255, 255, 255, 0.96);
            border: 1px solid rgba(255, 255, 255, 0.7);
            border-radius: 24px;
            box-shadow: 0 24px 70px rgba(0, 0, 0, 0.18);
            backdrop-filter: blur(16px);
            overflow: hidden;
        }

        .dummy-panel-header {
            padding: 1.2rem 1.25rem 1rem;
            background: linear-gradient(135deg, rgba(76, 175, 80, 0.12), rgba(52, 152, 219, 0.08));
            border-bottom: 1px solid var(--border-color);
        }

        .dummy-payment-badge {
            display: inline-flex;
            align-items: center;
            gap: 0.45rem;
            padding: 0.35rem 0.75rem;
            border-radius: 999px;
            background: rgba(76, 175, 80, 0.12);
            color: var(--primary-color);
            font-size: 12px;
            font-weight: 700;
            margin-bottom: 0.7rem;
        }

        .dummy-panel-header h1 {
            margin: 0 0 0.35rem;
            font-size: 1.65rem;
        }

        .dummy-panel-header p {
            margin: 0;
            color: var(--text-light);
            font-size: 13px;
            line-height: 1.5;
        }

        .dummy-tabs {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 0.45rem;
            padding: 1rem 1.25rem 0;
        }

        .dummy-tab-btn {
            border: 1px solid var(--border-color);
            background: var(--bg-white);
            border-radius: 14px;
            padding: 0.85rem 0.8rem;
            cursor: pointer;
            text-align: left;
            transition: var(--transition);
            display: flex;
            align-items: center;
            gap: 0.65rem;
        }

        .dummy-tab-btn i {
            color: var(--primary-color);
            font-size: 1rem;
        }

        .dummy-tab-btn strong {
            display: block;
            font-size: 13px;
        }

        .dummy-tab-btn span {
            display: block;
            color: var(--text-light);
            font-size: 11px;
            margin-top: 0.15rem;
        }

        .dummy-tab-btn.active {
            border-color: var(--primary-color);
            box-shadow: 0 8px 18px rgba(76, 175, 80, 0.15);
            transform: translateY(-1px);
        }

        .dummy-tab-panels {
            padding: 1rem 1.25rem 1.25rem;
        }

        .dummy-tab-panel {
            display: none;
            animation: fadeInUp 0.22s ease;
        }

        .dummy-tab-panel.active {
            display: block;
        }

        .dummy-grid {
            display: grid;
            gap: 0.7rem;
            margin: 1rem 0;
        }

        .dummy-row {
            display: flex;
            justify-content: space-between;
            gap: 1rem;
            padding: 0.75rem 0.9rem;
            border: 1px solid var(--border-color);
            border-radius: 12px;
            background: var(--bg-light);
        }

        .dummy-row span:first-child {
            color: var(--text-light);
            font-size: 13px;
        }

        .dummy-row span:last-child {
            font-weight: 600;
            text-align: right;
            color: var(--text-dark);
            font-size: 13px;
        }

        .method-copy {
            margin-top: 1rem;
            padding: 0.95rem 1rem;
            border-radius: 14px;
            background: rgba(52, 152, 219, 0.08);
            color: var(--accent-color);
            font-size: 13px;
            line-height: 1.6;
        }

        .payment-form-grid {
            display: grid;
            gap: 0.85rem;
            margin-top: 0.9rem;
        }

        .payment-input {
            width: 100%;
            border: 1px solid var(--border-color);
            border-radius: 12px;
            padding: 0.82rem 0.95rem;
            font-size: 14px;
            outline: none;
            transition: var(--transition);
            background: #fff;
        }

        .payment-input:focus {
            border-color: var(--primary-color);
            box-shadow: 0 0 0 4px rgba(76, 175, 80, 0.12);
        }

        .payment-form-grid .row-2 {
            display: grid;
            grid-template-columns: repeat(2, minmax(0, 1fr));
            gap: 0.75rem;
        }

        .dummy-actions {
            display: flex;
            gap: 0.75rem;
            flex-wrap: wrap;
            margin-top: 1rem;
        }

        .dummy-btn {
            border: none;
            border-radius: 12px;
            padding: 0.9rem 1.15rem;
            font-weight: 700;
            cursor: pointer;
            transition: var(--transition);
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
        }

        .dummy-btn-primary {
            background: var(--primary-color);
            color: #fff;
        }

        .dummy-btn-primary:hover {
            background: var(--primary-dark);
        }

        .dummy-btn-secondary {
            background: #eef2f4;
            color: #2c3e50;
        }

        .dummy-btn-secondary:hover {
            background: #e1e8ed;
        }

        .dummy-btn-danger {
            background: rgba(231, 76, 60, 0.12);
            color: var(--danger-color);
        }

        .dummy-btn-danger:hover {
            background: rgba(231, 76, 60, 0.18);
        }

        .dummy-disabled {
            margin-top: 0.9rem;
            padding: 0.95rem 1rem;
            border-radius: 12px;
            background: rgba(231, 76, 60, 0.1);
            color: var(--danger-color);
            font-size: 13px;
            line-height: 1.5;
        }

        .dummy-summary-panel {
            padding: 1.2rem;
        }

        .summary-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 1rem;
            margin-bottom: 0.95rem;
        }

        .summary-header h3 {
            margin: 0;
            font-size: 1.1rem;
        }

        .summary-header small {
            color: var(--text-light);
        }

        .summary-step {
            display: flex;
            gap: 0.75rem;
            padding: 0.85rem 0;
            border-bottom: 1px dashed var(--border-color);
        }

        .summary-step:last-child {
            border-bottom: none;
        }

        .step-dot {
            width: 32px;
            height: 32px;
            border-radius: 50%;
            background: rgba(76, 175, 80, 0.12);
            color: var(--primary-color);
            display: flex;
            align-items: center;
            justify-content: center;
            flex-shrink: 0;
        }

        .summary-step strong {
            display: block;
            font-size: 13px;
        }

        .summary-step span {
            display: block;
            color: var(--text-light);
            font-size: 12px;
            margin-top: 0.15rem;
            line-height: 1.5;
        }

        .summary-note {
            margin-top: 1rem;
            padding: 0.9rem 1rem;
            border-radius: 12px;
            background: rgba(52, 152, 219, 0.1);
            color: var(--accent-color);
            font-size: 13px;
            line-height: 1.5;
        }

        .status-line {
            margin-top: 0.75rem;
            font-size: 13px;
            color: var(--text-light);
        }

        .status-line strong {
            color: var(--text-dark);
        }

        .success-overlay,
        .failure-overlay {
            position: fixed;
            inset: 0;
            display: none;
            align-items: center;
            justify-content: center;
            background: rgba(14, 18, 22, 0.7);
            z-index: 9999;
            padding: 20px;
        }

        .success-card,
        .failure-card {
            width: min(420px, 100%);
            background: #fff;
            border-radius: 24px;
            box-shadow: 0 26px 70px rgba(0, 0, 0, 0.3);
            padding: 1.6rem 1.5rem 1.4rem;
            text-align: center;
        }

        .success-anim {
            width: 92px;
            height: 92px;
            margin: 0 auto 1rem;
            border-radius: 50%;
            background: rgba(76, 175, 80, 0.12);
            display: flex;
            align-items: center;
            justify-content: center;
            position: relative;
        }

        .success-anim::before,
        .success-anim::after {
            content: "";
            position: absolute;
            inset: -8px;
            border: 2px solid rgba(76, 175, 80, 0.2);
            border-radius: 50%;
            animation: pulseRing 1.5s infinite;
        }

        .success-anim::after {
            inset: -18px;
            animation-delay: 0.25s;
        }

        .success-anim i {
            font-size: 2.1rem;
            color: var(--primary-color);
            animation: popIn 0.45s ease;
        }

        .failure-icon {
            width: 92px;
            height: 92px;
            margin: 0 auto 1rem;
            border-radius: 50%;
            background: rgba(231, 76, 60, 0.12);
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .failure-icon i {
            font-size: 2rem;
            color: var(--danger-color);
        }

        .success-card h3,
        .failure-card h3 {
            margin: 0 0 0.35rem;
            font-size: 1.35rem;
        }

        .success-card p,
        .failure-card p {
            margin: 0;
            color: var(--text-light);
            line-height: 1.6;
        }

        .modal-shake {
            animation: shake 0.45s ease;
        }

        @keyframes fadeInUp {
            from { opacity: 0; transform: translateY(8px); }
            to { opacity: 1; transform: translateY(0); }
        }

        @keyframes pulseRing {
            0% { transform: scale(0.9); opacity: 0.8; }
            100% { transform: scale(1.12); opacity: 0; }
        }

        @keyframes popIn {
            from { transform: scale(0.4); opacity: 0; }
            to { transform: scale(1); opacity: 1; }
        }

        @keyframes shake {
            0%, 100% { transform: translateX(0); }
            20% { transform: translateX(-8px); }
            40% { transform: translateX(8px); }
            60% { transform: translateX(-6px); }
            80% { transform: translateX(6px); }
        }

        @media (max-width: 960px) {
            .dummy-payment-modal {
                grid-template-columns: 1fr;
            }
        }

        @media (max-width: 720px) {
            .dummy-tabs {
                grid-template-columns: 1fr;
            }

            .payment-form-grid .row-2 {
                grid-template-columns: 1fr;
            }

            .dummy-payment-page {
                align-items: flex-start;
            }
        }
    </style>
</head>
<body>
    <jsp:include page="/WEB-INF/views/common/header.jsp"/>

    <div class="container dummy-payment-page">
        <%
            Object property = request.getAttribute("property");
            Object owner = request.getAttribute("owner");
            Object inquiry = request.getAttribute("inquiry");
            Object paymentAmount = request.getAttribute("paymentAmount");
            Object paymentReference = request.getAttribute("paymentReference");
            Boolean paymentAllowed = (Boolean) request.getAttribute("paymentAllowed");

            String propertyTitle = "Property";
            String ownerName = "Owner";
            String ownerEmail = "N/A";
            String inquiryId = "N/A";
            String amountText = paymentAmount != null ? paymentAmount.toString() : "1000.00";
            String referenceText = paymentReference != null ? paymentReference.toString() : "DUMMY-REF";

            try {
                if (property != null) {
                    propertyTitle = String.valueOf(property.getClass().getMethod("getTitle").invoke(property));
                }
                if (owner != null) {
                    ownerName = String.valueOf(owner.getClass().getMethod("getName").invoke(owner));
                    ownerEmail = String.valueOf(owner.getClass().getMethod("getEmail").invoke(owner));
                }
                if (inquiry != null) {
                    inquiryId = String.valueOf(inquiry.getClass().getMethod("getId").invoke(inquiry));
                }
            } catch (Exception ignored) {
            }
        %>

        <div class="dummy-payment-overlay">
            <div class="dummy-payment-modal">
                <div class="dummy-panel">
                    <div class="dummy-panel-header">
                        <div class="dummy-payment-badge"><i class="fas fa-flask"></i> Test Mode Only</div>
                        <h1>Dummy Payment Interface</h1>
                        <p>This is a polished test checkout. It mimics a Razorpay-like payment UI, but no real gateway is used.</p>
                    </div>

                    <div class="dummy-tabs">
                        <button type="button" class="dummy-tab-btn active" data-tab="upi" onclick="switchTab(this, 'upi')">
                            <i class="fas fa-mobile-screen-button"></i>
                            <div><strong>UPI</strong><span>Scan / collect simulation</span></div>
                        </button>
                        <button type="button" class="dummy-tab-btn" data-tab="card" onclick="switchTab(this, 'card')">
                            <i class="fas fa-credit-card"></i>
                            <div><strong>Card</strong><span>Card test checkout</span></div>
                        </button>
                        <button type="button" class="dummy-tab-btn" data-tab="netbanking" onclick="switchTab(this, 'netbanking')">
                            <i class="fas fa-building-columns"></i>
                            <div><strong>Netbanking</strong><span>Bank transfer simulation</span></div>
                        </button>
                    </div>

                    <div class="dummy-tab-panels">
                        <div class="dummy-tab-panel active" id="tab-upi">
                            <div class="dummy-grid">
                                <div class="dummy-row"><span>Property</span><span><%= propertyTitle %></span></div>
                                <div class="dummy-row"><span>Owner</span><span><%= ownerName %></span></div>
                                <div class="dummy-row"><span>Inquiry ID</span><span>#<%= inquiryId %></span></div>
                                <div class="dummy-row"><span>Amount</span><span>₹<%= amountText %></span></div>
                                <div class="dummy-row"><span>Reference</span><span><%= referenceText %></span></div>
                            </div>
                            <div class="method-copy">
                                Select UPI to simulate a QR / intent payment. This is useful for demoing the final step before moving an inquiry to resolved.
                            </div>
                        </div>

                        <div class="dummy-tab-panel" id="tab-card">
                            <div class="payment-form-grid">
                                <div class="row-2">
                                    <input class="payment-input" type="text" placeholder="Cardholder name" value="<%= ownerName %>" readonly>
                                    <input class="payment-input" type="text" placeholder="Card number" value="4111 1111 1111 1111">
                                </div>
                                <div class="row-2">
                                    <input class="payment-input" type="text" placeholder="MM/YY" value="12/29">
                                    <input class="payment-input" type="password" placeholder="CVV" value="123">
                                </div>
                                <input class="payment-input" type="text" placeholder="Email" value="<%= ownerEmail %>" readonly>
                            </div>
                            <div class="method-copy">
                                Card tab is fully mocked. Use the confirm button below to show a successful payment animation.
                            </div>
                        </div>

                        <div class="dummy-tab-panel" id="tab-netbanking">
                            <div class="dummy-grid">
                                <div class="dummy-row"><span>Bank</span><span>HDFC / ICICI / SBI</span></div>
                                <div class="dummy-row"><span>Account holder</span><span><%= ownerName %></span></div>
                                <div class="dummy-row"><span>Amount</span><span>₹<%= amountText %></span></div>
                                <div class="dummy-row"><span>Status</span><span>Awaiting confirmation</span></div>
                            </div>
                            <div class="method-copy">
                                Netbanking is simulated here as well. Choose a bank, then confirm the test payment to continue.
                            </div>
                        </div>

                        <% if (paymentAllowed != null && paymentAllowed) { %>
                            <div class="dummy-note">
                                The owner has approved this inquiry, so you can now confirm this dummy test payment.
                            </div>
                            <div class="dummy-actions">
                                <button type="button" class="dummy-btn dummy-btn-primary" onclick="runSuccessFlow()">
                                    <i class="fas fa-circle-check"></i> Confirm Test Payment
                                </button>
                                <button type="button" class="dummy-btn dummy-btn-danger" onclick="runFailureFlow()">
                                    <i class="fas fa-triangle-exclamation"></i> Simulate Failure
                                </button>
                                <button type="button" class="dummy-btn dummy-btn-secondary" onclick="cancelDummyPayment()">
                                    <i class="fas fa-xmark"></i> Cancel
                                </button>
                            </div>
                            <div class="status-line">Current status: <strong>Ready for dummy payment</strong></div>
                        <% } else { %>
                            <div class="dummy-disabled">
                                Payment is currently locked. The owner must mark the inquiry as <strong>Contacted</strong> before you can confirm this test payment.
                            </div>
                            <div class="dummy-actions">
                                <a href="<%= request.getContextPath() %>/inquiry/my-inquiries" class="dummy-btn dummy-btn-primary">
                                    <i class="fas fa-list"></i> Go to My Inquiries
                                </a>
                                <a href="<%= request.getContextPath() %>/property/all" class="dummy-btn dummy-btn-secondary">
                                    <i class="fas fa-house"></i> Browse Properties
                                </a>
                            </div>
                        <% } %>
                    </div>
                </div>

                <div class="dummy-summary-panel">
                    <div class="summary-header">
                        <div>
                            <h3>Test flow</h3>
                            <small>How the dummy interface works</small>
                        </div>
                        <span class="dummy-payment-badge"><i class="fas fa-shield-heart"></i> Safe Demo</span>
                    </div>

                    <div class="summary-step">
                        <div class="step-dot"><i class="fas fa-paper-plane"></i></div>
                        <div><strong>1. Seeker sends inquiry</strong><span>Inquiry is created and visible to the owner.</span></div>
                    </div>
                    <div class="summary-step">
                        <div class="step-dot"><i class="fas fa-envelope-open-text"></i></div>
                        <div><strong>2. Owner marks Contacted</strong><span>This unlocks the dummy payment modal for the seeker.</span></div>
                    </div>
                    <div class="summary-step">
                        <div class="step-dot"><i class="fas fa-credit-card"></i></div>
                        <div><strong>3. Seeker confirms test payment</strong><span>Success animation plays before form submission.</span></div>
                    </div>
                    <div class="summary-step">
                        <div class="step-dot"><i class="fas fa-circle-check"></i></div>
                        <div><strong>4. Inquiry becomes resolved</strong><span>The workflow is completed in test mode only.</span></div>
                    </div>

                    <div class="summary-note">
                        This page is intentionally designed as a modal-style dummy checkout for testing, demos, and UX validation.
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="success-overlay" id="successOverlay">
        <div class="success-card">
            <div class="success-anim"><i class="fas fa-check"></i></div>
            <h3>Payment successful</h3>
            <p>Your dummy payment has been accepted. Redirecting the inquiry to the resolved state...</p>
        </div>
    </div>

    <div class="failure-overlay" id="failureOverlay">
        <div class="failure-card modal-shake">
            <div class="failure-icon"><i class="fas fa-triangle-exclamation"></i></div>
            <h3>Payment failed</h3>
            <p>This is only a simulated failure. No real payment was processed.</p>
            <div class="dummy-actions" style="justify-content:center;">
                <button type="button" class="dummy-btn dummy-btn-primary" onclick="closeFailureOverlay()">Try Again</button>
                <button type="button" class="dummy-btn dummy-btn-secondary" onclick="cancelDummyPayment()">Cancel</button>
            </div>
        </div>
    </div>

    <jsp:include page="/WEB-INF/views/common/footer.jsp"/>
    <script>
        function switchTab(button, tabName) {
            document.querySelectorAll('.dummy-tab-btn').forEach(function (btn) {
                btn.classList.remove('active');
            });
            document.querySelectorAll('.dummy-tab-panel').forEach(function (panel) {
                panel.classList.remove('active');
            });
            if (button) {
                button.classList.add('active');
            }
            var target = document.getElementById('tab-' + tabName);
            if (target) {
                target.classList.add('active');
            }
        }

        function cancelDummyPayment() {
            window.location.href = '<%= request.getContextPath() %>/inquiry/my-inquiries';
        }

        function runFailureFlow() {
            var overlay = document.getElementById('failureOverlay');
            if (overlay) {
                overlay.style.display = 'flex';
            }
        }

        function closeFailureOverlay() {
            var overlay = document.getElementById('failureOverlay');
            if (overlay) {
                overlay.style.display = 'none';
            }
        }

        function runSuccessFlow() {
            var allowed = <%= (paymentAllowed != null && paymentAllowed) ? "true" : "false" %>;
            if (!allowed) {
                runFailureFlow();
                return;
            }

            var overlay = document.getElementById('successOverlay');
            if (overlay) {
                overlay.style.display = 'flex';
            }

            setTimeout(function () {
                var form = document.createElement('form');
                form.method = 'POST';
                form.action = '<%= request.getContextPath() %>/inquiry/payment/confirm/<%= inquiryId %>';
                document.body.appendChild(form);
                form.submit();
            }, 1600);
        }
    </script>
</body>
</html>

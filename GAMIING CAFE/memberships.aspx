<%@ Page Title="VIP Memberships - CyberGrid Gaming Cafe" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="memberships.aspx.cs" Inherits="GAMIING_CAFE.MembershipsPage" %>

<asp:Content ID="MainContentMemberships" ContentPlaceHolderID="MainContent" runat="server">

    <section class="section" style="padding-top: 3rem;">
        <div class="section-title-wrap">
            <span class="section-tag"><i class="fa-solid fa-crown"></i> Unlock VIP Benefits</span>
            <h2 class="section-title">MEMBERSHIP TIERS</h2>
        </div>

        <div class="grid-4">
            <!-- Basic Tier -->
            <div class="glass-card" style="display: flex; flex-direction: column; justify-content: space-between;">
                <div>
                    <div style="font-size: 1.8rem; color: var(--text-dim); margin-bottom: 0.5rem;"><i class="fa-solid fa-user"></i></div>
                    <h3 style="font-size: 1.2rem;">Basic Tier</h3>
                    <div style="font-size: 1.8rem; font-weight: 800; margin: 0.75rem 0; color: var(--text-main);">FREE</div>
                    <ul style="list-style: none; font-size: 0.88rem; color: var(--text-muted); display: flex; flex-direction: column; gap: 8px; margin-bottom: 1.5rem;">
                        <li><i class="fa-solid fa-check" style="color: var(--accent-emerald); margin-right: 6px;"></i> Standard Station Booking</li>
                        <li><i class="fa-solid fa-check" style="color: var(--accent-emerald); margin-right: 6px;"></i> Pay-as-you-go Food</li>
                        <li style="color: var(--text-dim);"><i class="fa-solid fa-xmark" style="margin-right: 6px;"></i> No Priority Reservations</li>
                        <li style="color: var(--text-dim);"><i class="fa-solid fa-xmark" style="margin-right: 6px;"></i> 0% Hourly Discount</li>
                    </ul>
                </div>
                <button type="button" class="btn-outline" style="width: 100%; opacity: 0.6; cursor: default;" disabled>Current Default Plan</button>
            </div>

            <!-- Silver Gamer -->
            <div class="glass-card" style="display: flex; flex-direction: column; justify-content: space-between;">
                <div>
                    <div style="font-size: 1.8rem; color: #94a3b8; margin-bottom: 0.5rem;"><i class="fa-solid fa-shield"></i></div>
                    <h3 style="font-size: 1.2rem;">Silver Gamer</h3>
                    <div style="font-size: 1.8rem; font-weight: 800; margin: 0.75rem 0; color: var(--text-main);">&#8377;499<span style="font-size: 0.8rem; color: var(--text-muted); font-weight: 400;">/mo</span></div>
                    <ul style="list-style: none; font-size: 0.88rem; color: var(--text-muted); display: flex; flex-direction: column; gap: 8px; margin-bottom: 1.5rem;">
                        <li><i class="fa-solid fa-check" style="color: var(--accent-emerald); margin-right: 6px;"></i> 10% Off All Hourly Rates</li>
                        <li><i class="fa-solid fa-check" style="color: var(--accent-emerald); margin-right: 6px;"></i> 1 Free Extra Hour / Month</li>
                        <li><i class="fa-solid fa-check" style="color: var(--accent-emerald); margin-right: 6px;"></i> Priority Station Queue</li>
                        <li><i class="fa-solid fa-check" style="color: var(--accent-emerald); margin-right: 6px;"></i> Free Soft Drink with Food</li>
                    </ul>
                </div>
                <button type="button" class="btn-cyber" style="width: 100%; font-size: 0.88rem;" onclick="openPurchaseModal('Silver Gamer', 499, '10% Off All Hourly Rates + 1 Free Extra Hour')">
                    <i class="fa-solid fa-cart-shopping"></i> Choose Silver
                </button>
            </div>

            <!-- Gold VIP (Featured) -->
            <div class="glass-card" style="border: 2px solid var(--accent-primary); display: flex; flex-direction: column; justify-content: space-between; position: relative;">
                <div style="position: absolute; top: -12px; left: 50%; transform: translateX(-50%); background: var(--accent-primary); color: #fff; font-size: 0.72rem; font-weight: 700; padding: 2px 10px; border-radius: var(--radius-full); text-transform: uppercase;">
                    Most Popular
                </div>
                <div>
                    <div style="font-size: 1.8rem; color: var(--accent-amber); margin-bottom: 0.5rem;"><i class="fa-solid fa-crown"></i></div>
                    <h3 style="font-size: 1.2rem;">Gold VIP</h3>
                    <div style="font-size: 1.8rem; font-weight: 800; margin: 0.75rem 0; color: var(--accent-primary);">&#8377;999<span style="font-size: 0.8rem; color: var(--text-muted); font-weight: 400;">/mo</span></div>
                    <ul style="list-style: none; font-size: 0.88rem; color: var(--text-muted); display: flex; flex-direction: column; gap: 8px; margin-bottom: 1.5rem;">
                        <li><i class="fa-solid fa-check" style="color: var(--accent-emerald); margin-right: 6px;"></i> 20% Off All Hourly Rates</li>
                        <li><i class="fa-solid fa-check" style="color: var(--accent-emerald); margin-right: 6px;"></i> 2 Free Extra Hours / Month</li>
                        <li><i class="fa-solid fa-check" style="color: var(--accent-emerald); margin-right: 6px;"></i> VIP Lounge Access</li>
                        <li><i class="fa-solid fa-check" style="color: var(--accent-emerald); margin-right: 6px;"></i> Free Birthday Session</li>
                    </ul>
                </div>
                <button type="button" class="btn-cyber" style="width: 100%; font-size: 0.88rem;" onclick="openPurchaseModal('Gold VIP', 999, '20% Off All Hourly Rates + 2 Free Extra Hours')">
                    <i class="fa-solid fa-crown"></i> Choose Gold VIP
                </button>
            </div>

            <!-- Diamond Legend -->
            <div class="glass-card" style="display: flex; flex-direction: column; justify-content: space-between;">
                <div>
                    <div style="font-size: 1.8rem; color: var(--accent-cyan); margin-bottom: 0.5rem;"><i class="fa-solid fa-gem"></i></div>
                    <h3 style="font-size: 1.2rem;">Diamond Legend</h3>
                    <div style="font-size: 1.8rem; font-weight: 800; margin: 0.75rem 0; color: var(--text-main);">&#8377;1,999<span style="font-size: 0.8rem; color: var(--text-muted); font-weight: 400;">/mo</span></div>
                    <ul style="list-style: none; font-size: 0.88rem; color: var(--text-muted); display: flex; flex-direction: column; gap: 8px; margin-bottom: 1.5rem;">
                        <li><i class="fa-solid fa-check" style="color: var(--accent-emerald); margin-right: 6px;"></i> 35% Off All Hourly Rates</li>
                        <li><i class="fa-solid fa-check" style="color: var(--accent-emerald); margin-right: 6px;"></i> 5 Free Extra Hours / Month</li>
                        <li><i class="fa-solid fa-check" style="color: var(--accent-emerald); margin-right: 6px;"></i> Free Tournament Entry</li>
                        <li><i class="fa-solid fa-check" style="color: var(--accent-emerald); margin-right: 6px;"></i> Unlimited Snacks Discount</li>
                    </ul>
                </div>
                <button type="button" class="btn-outline" style="width: 100%; font-size: 0.88rem;" onclick="openPurchaseModal('Diamond Legend', 1999, '35% Off All Hourly Rates + 5 Free Extra Hours')">
                    <i class="fa-solid fa-gem"></i> Choose Diamond
                </button>
            </div>
        </div>
    </section>

    <!-- Membership Purchase & Payment Modal -->
    <div id="membershipModal" class="modal-backdrop">
        <div class="modal-content" style="max-width: 520px;">
            
            <div class="modal-header">
                <h3 style="display: flex; align-items: center; gap: 10px; margin: 0; font-size: 1.2rem;">
                    <i class="fa-solid fa-crown" style="color: var(--accent-amber);"></i> 
                    <span>VIP Membership Checkout</span>
                </h3>
                <button type="button" class="modal-close" onclick="closePurchaseModal()">&times;</button>
            </div>

            <div id="modal-checkout-body">
                <!-- Selected Plan Card -->
                <div style="background: rgba(255,255,255,0.03); border: 1px solid var(--border-light); border-radius: var(--radius-sm); padding: 1.2rem; margin-bottom: 1.5rem; display: flex; justify-content: space-between; align-items: center;">
                    <div>
                        <span id="modal-plan-badge" class="badge-status status-available">VIP TIER</span>
                        <h3 id="modal-plan-name" style="margin-top: 6px; color: #fff; font-size: 1.2rem;">Gold VIP</h3>
                        <p id="modal-plan-perk" style="color: var(--text-muted); font-size: 0.85rem; margin-top: 4px;">20% Off All Rates + 2 Free Extra Hours</p>
                    </div>
                    <div style="text-align: right;">
                        <div style="font-size: 0.75rem; color: var(--text-muted); text-transform: uppercase;">Amount Due</div>
                        <div id="modal-plan-price" style="font-size: 1.7rem; color: var(--accent-primary); font-weight: 800;">&#8377;999</div>
                        <div style="font-size: 0.75rem; color: var(--text-muted);">Per Month</div>
                    </div>
                </div>

                <!-- Buyer Details -->
                <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 1rem; margin-bottom: 1rem;">
                    <div class="form-group" style="margin-bottom: 0;">
                        <label class="form-label">Member Name</label>
                        <input type="text" id="mem-buyer-name" class="form-control" placeholder="Full Name" required>
                    </div>
                    <div class="form-group" style="margin-bottom: 0;">
                        <label class="form-label">Email Address</label>
                        <input type="email" id="mem-buyer-email" class="form-control" placeholder="Email" required>
                    </div>
                </div>

                <!-- Payment Method Selection -->
                <div class="form-group" style="margin-bottom: 1.2rem; margin-top: 1rem;">
                    <label class="form-label">Select Payment Method</label>
                    <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 10px; margin-top: 6px;">
                        <label style="background: rgba(255,255,255,0.03); border: 1px solid var(--border-light); border-radius: var(--radius-sm); padding: 10px; cursor: pointer; display: flex; align-items: center; gap: 8px;">
                            <input type="radio" name="payment_method" value="upi" checked onchange="togglePaymentTab('upi')">
                            <span style="font-size: 0.9rem;"><i class="fa-solid fa-qrcode" style="color: var(--accent-primary); margin-right: 4px;"></i> UPI / QR Code</span>
                        </label>
                        <label style="background: rgba(255,255,255,0.03); border: 1px solid var(--border-light); border-radius: var(--radius-sm); padding: 10px; cursor: pointer; display: flex; align-items: center; gap: 8px;">
                            <input type="radio" name="payment_method" value="card" onchange="togglePaymentTab('card')">
                            <span style="font-size: 0.9rem;"><i class="fa-solid fa-credit-card" style="color: var(--accent-indigo); margin-right: 4px;"></i> Card</span>
                        </label>
                    </div>
                </div>

                <!-- UPI Tab -->
                <div id="tab-upi" style="background: rgba(0,0,0,0.3); border: 1px dashed var(--border-light); border-radius: var(--radius-sm); padding: 1rem; text-align: center; margin-bottom: 1.5rem;">
                    <p style="font-size: 0.85rem; color: var(--text-muted); margin-bottom: 8px;">Scan with GPay, PhonePe, Paytm, or any UPI app</p>
                    <div style="background: #fff; padding: 10px; display: inline-block; border-radius: 8px;">
                        <img src="https://api.qrserver.com/v1/create-qr-code/?size=130x130&data=upi://pay?pa=cybergrid@upi&pn=CyberGridCafe" alt="UPI QR" style="display: block; width: 130px; height: 130px;">
                    </div>
                    <div style="font-size: 0.85rem; color: var(--text-main); margin-top: 8px;">
                        UPI ID: <strong style="color: var(--accent-primary);">cybergrid@upi</strong>
                    </div>
                </div>

                <!-- Card Tab -->
                <div id="tab-card" style="display: none; background: rgba(0,0,0,0.3); border: 1px dashed var(--border-light); border-radius: var(--radius-sm); padding: 1rem; margin-bottom: 1.5rem;">
                    <div class="form-group" style="margin-bottom: 8px;">
                        <input type="text" class="form-control" placeholder="Card Number (4532 •••• •••• ••••)" maxlength="19">
                    </div>
                    <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 10px;">
                        <input type="text" class="form-control" placeholder="MM/YY" maxlength="5">
                        <input type="password" class="form-control" placeholder="CVV" maxlength="3">
                    </div>
                </div>

                <!-- Confirm & Pay Button -->
                <button type="button" id="btnConfirmPay" class="btn-cyber" style="width: 100%; padding: 12px; font-size: 0.95rem;" onclick="processMembershipPayment()">
                    <i class="fa-solid fa-lock"></i> <span id="pay-btn-label">Confirm & Pay &#8377;999</span>
                </button>
            </div>

            <!-- Success Confirmation Screen -->
            <div id="modal-success-body" style="display: none; text-align: center; padding: 1.5rem 0;">
                <div style="color: var(--accent-emerald); font-size: 3rem; margin-bottom: 1rem;">
                    <i class="fa-solid fa-circle-check"></i>
                </div>
                <h2 style="font-size: 1.4rem;">Payment Successful!</h2>
                <p style="color: var(--text-muted); font-size: 0.9rem; margin-top: 6px;">Your VIP Membership has been activated immediately.</p>

                <div style="background: rgba(255,255,255,0.03); border: 1px solid var(--border-light); border-radius: var(--radius-sm); padding: 1.2rem; margin: 1.5rem 0; text-align: left;">
                    <div style="display: flex; justify-content: space-between; margin-bottom: 8px; font-size: 0.85rem;">
                        <span style="color: var(--text-muted);">Transaction Ref:</span>
                        <strong id="success-txnid" style="color: var(--accent-primary);">TXN-847291</strong>
                    </div>
                    <div style="display: flex; justify-content: space-between; margin-bottom: 8px; font-size: 0.85rem;">
                        <span style="color: var(--text-muted);">Activated Plan:</span>
                        <strong id="success-planname" style="color: var(--accent-amber);">Gold VIP Plan</strong>
                    </div>
                    <div style="display: flex; justify-content: space-between; font-size: 0.85rem;">
                        <span style="color: var(--text-muted);">Validity:</span>
                        <span style="color: #fff;">30 Days (Active)</span>
                    </div>
                </div>

                <div style="display: flex; gap: 10px; justify-content: center;">
                    <button type="button" class="btn-outline" onclick="closePurchaseModal(); window.print();"><i class="fa-solid fa-print"></i> Print Invoice</button>
                    <a href="customer-dashboard.aspx" class="btn-cyber"><i class="fa-solid fa-user"></i> Go to Dashboard</a>
                </div>
            </div>

        </div>
    </div>

</asp:Content>

<asp:Content ID="ScriptsMemberships" ContentPlaceHolderID="ScriptsExtra" runat="server">
    <script>
        let currentSelectedPlan = { name: 'Gold VIP', price: 999, perk: '' };

        function openPurchaseModal(planName, price, perk) {
            currentSelectedPlan = { name: planName, price: price, perk: perk };

            document.getElementById('modal-plan-name').textContent = planName;
            document.getElementById('modal-plan-price').innerHTML = `&#8377;${price}`;
            document.getElementById('modal-plan-perk').textContent = perk;
            document.getElementById('pay-btn-label').innerHTML = `Confirm & Pay &#8377;${price}`;

            // Auto-fill user if logged in
            const u = (typeof getLoggedInUser === 'function') ? getLoggedInUser() : null;
            if (u) {
                document.getElementById('mem-buyer-name').value = u.name || '';
                document.getElementById('mem-buyer-email').value = u.email || '';
            }

            // Reset modal states
            document.getElementById('modal-checkout-body').style.display = 'block';
            document.getElementById('modal-success-body').style.display = 'none';

            document.getElementById('membershipModal').classList.add('active');
        }

        function closePurchaseModal() {
            document.getElementById('membershipModal').classList.remove('active');
        }

        function togglePaymentTab(type) {
            if (type === 'upi') {
                document.getElementById('tab-upi').style.display = 'block';
                document.getElementById('tab-card').style.display = 'none';
            } else {
                document.getElementById('tab-upi').style.display = 'none';
                document.getElementById('tab-card').style.display = 'block';
            }
        }

        function processMembershipPayment() {
            const btn = document.getElementById('btnConfirmPay');
            btn.disabled = true;
            btn.innerHTML = `<i class="fa-solid fa-spinner fa-spin"></i> Verifying Payment...`;

            setTimeout(() => {
                btn.disabled = false;
                btn.innerHTML = `<i class="fa-solid fa-lock"></i> <span id="pay-btn-label">Confirm & Pay &#8377;${currentSelectedPlan.price}</span>`;

                // Update data in appData if available
                if (typeof getCafeData === 'function') {
                    let d = getCafeData();
                    if (d && d.currentUser) {
                        d.currentUser.membershipTier = currentSelectedPlan.name;
                        saveCafeData(d);
                    }
                }

                // Show success screen
                const randTxn = 'TXN-' + Math.floor(100000 + Math.random() * 900000);
                document.getElementById('success-txnid').textContent = randTxn;
                document.getElementById('success-planname').textContent = currentSelectedPlan.name;

                document.getElementById('modal-checkout-body').style.display = 'none';
                document.getElementById('modal-success-body').style.display = 'block';

                showToast(`Payment of &#8377;${currentSelectedPlan.price} confirmed! Membership activated.`, 'success');
            }, 1200);
        }
    </script>
</asp:Content>

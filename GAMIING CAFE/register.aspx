<%@ Page Title="Create Account - CyberGrid Gaming Cafe" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="register.aspx.cs" Inherits="GAMIING_CAFE.RegisterPage" %>

<asp:Content ID="MetaContentRegister" ContentPlaceHolderID="MetaContent" runat="server">
    <meta name="description" content="Create a new CyberGrid Gaming Cafe account to unlock instant station reservations and 100 bonus reward points." />
</asp:Content>

<asp:Content ID="MainContentRegister" ContentPlaceHolderID="MainContent" runat="server">

    <section class="section" style="padding-top: 3.5rem; min-height: 80vh; display: flex; align-items: center; justify-content: center;">
        <div class="glass-card" style="max-width: 540px; width: 100%; padding: 2.5rem;">

            <div style="text-align: center; margin-bottom: 2rem;">
                <div class="brand-icon-wrap" style="width: 50px; height: 50px; font-size: 1.5rem; margin: 0 auto 1rem auto; border-radius: 12px;">
                    <i class="fa-solid fa-user-plus"></i>
                </div>
                <h2 style="font-size: 1.6rem; letter-spacing: -0.5px;">Create an Account</h2>
                <p style="color: var(--text-muted); font-size: 0.88rem; margin-top: 6px;">Get 100 Welcome Reward Points & Instant Station Reservations</p>
            </div>

            <!-- Registration fields -->
            <div id="register-form">
                <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 1rem; margin-bottom: 0;">
                    <div class="form-group">
                        <label class="form-label">Full Name *</label>
                        <asp:TextBox ID="txtName" runat="server" CssClass="form-control" placeholder="John Doe" required="required"></asp:TextBox>
                    </div>

                    <div class="form-group">
                        <label class="form-label">Phone Number *</label>
                        <asp:TextBox ID="txtPhone" runat="server" CssClass="form-control" placeholder="+91 98765 00000" required="required"></asp:TextBox>
                    </div>
                </div>

                <div class="form-group">
                    <label class="form-label">Email Address *</label>
                    <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" TextMode="Email" placeholder="gamer@domain.com" required="required"></asp:TextBox>
                </div>

                <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 1rem; margin-bottom: 0;">
                    <div class="form-group">
                        <label class="form-label">Password *</label>
                        <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" TextMode="Password" placeholder="Create password" required="required"></asp:TextBox>
                    </div>

                    <div class="form-group">
                        <label class="form-label">Confirm Password *</label>
                        <asp:TextBox ID="txtConfirmPassword" runat="server" CssClass="form-control" TextMode="Password" placeholder="Confirm password" required="required"></asp:TextBox>
                    </div>
                </div>

                <div class="form-group">
                    <label class="form-label"><i class="fa-solid fa-crown text-yellow"></i> Initial Membership Tier</label>
                    <asp:DropDownList ID="ddlMembership" runat="server" CssClass="form-control">
                        <asp:ListItem Value="Basic Tier">Basic Tier (Free)</asp:ListItem>
                        <asp:ListItem Value="Silver Gamer">Silver Gamer (&#8377;499/mo - 10% Off)</asp:ListItem>
                        <asp:ListItem Value="Gold VIP" Selected="True">Gold VIP (&#8377;999/mo - 20% Off)</asp:ListItem>
                        <asp:ListItem Value="Diamond Legend">Diamond Legend (&#8377;1999/mo - 35% Off)</asp:ListItem>
                    </asp:DropDownList>
                </div>

                <div class="form-group">
                    <label class="form-label"><i class="fa-solid fa-shield-halved" style="color: var(--accent-primary);"></i> Account Role</label>
                    <asp:DropDownList ID="ddlRole" runat="server" CssClass="form-control">
                        <asp:ListItem Value="Customer" Selected="True">Customer</asp:ListItem>
                        <asp:ListItem Value="Staff">Staff Member</asp:ListItem>
                        <asp:ListItem Value="Admin">Administrator</asp:ListItem>
                    </asp:DropDownList>
                </div>

                <div style="display: flex; align-items: center; gap: 8px; margin-bottom: 1.5rem; margin-top: 0.5rem;">
                    <input type="checkbox" id="terms-agree" checked required>
                    <label for="terms-agree" style="font-size: 0.85rem; color: var(--text-muted); cursor: pointer;">I agree to CyberGrid Cafe terms & gaming rules</label>
                </div>

                <asp:Button ID="btnRegister" runat="server" CssClass="btn-cyber" style="width: 100%; height: 46px; font-size: 0.95rem;" Text="Create Account" OnClick="btnRegister_Click" />
            </div>

            <div style="text-align: center; margin-top: 1.75rem; font-size: 0.88rem; color: var(--text-muted); border-top: 1px solid var(--border-subtle); padding-top: 1.25rem;">
                Already have an account? <a href="login.aspx" style="color: var(--accent-primary); font-weight: 600;">Sign In</a>
            </div>

        </div>
    </section>

</asp:Content>

<asp:Content ID="ScriptsRegister" ContentPlaceHolderID="ScriptsExtra" runat="server">
    <script>
        function handleRegisterSubmit(e) {
            e.preventDefault();
            const name = document.getElementById('reg-name').value.trim();
            const phone = document.getElementById('reg-phone').value.trim();
            const email = document.getElementById('reg-email').value.trim();
            const pass = document.getElementById('reg-password').value.trim();
            const confirmPass = document.getElementById('reg-confirm-password').value.trim();
            const membership = document.getElementById('reg-membership').value;
            const role = document.getElementById('reg-role').value;

            if (pass !== confirmPass) {
                showToast('Passwords do not match!', 'warning');
                return;
            }

            const res = dbRegisterUser(name, email, phone, pass, role, membership);
            if (res.success) {
                showToast(`Account created for ${name}! Welcome to CyberGrid.`, 'success');
                setTimeout(() => {
                    if (role === 'staff') {
                        window.location.href = 'staff-dashboard.aspx';
                    } else if (role === 'admin') {
                        window.location.href = 'admin-dashboard.aspx';
                    } else {
                        window.location.href = 'customer-dashboard.aspx';
                    }
                }, 800);
            } else {
                showToast(res.message, 'warning');
            }
        }
    </script>
</asp:Content>

<%@ Page Title="Sign In - CyberGrid Gaming Cafe" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="login.aspx.cs" Inherits="GAMIING_CAFE.LoginPage" %>

<asp:Content ID="MetaContentLogin" ContentPlaceHolderID="MetaContent" runat="server">
    <meta name="description" content="Log in to your CyberGrid Gaming Cafe account to book stations, order food, and check reward points." />
</asp:Content>

<asp:Content ID="MainContentLogin" ContentPlaceHolderID="MainContent" runat="server">

    <section class="section" style="padding-top: 4rem; min-height: 75vh; display: flex; align-items: center; justify-content: center;">
        <div class="glass-card" style="max-width: 440px; width: 100%; padding: 2.5rem;">

            <div style="text-align: center; margin-bottom: 2rem;">
                <div class="brand-icon-wrap" style="width: 50px; height: 50px; font-size: 1.5rem; margin: 0 auto 1rem auto; border-radius: 12px;">
                    <i class="fa-solid fa-gamepad"></i>
                </div>
                <h2 style="font-size: 1.6rem; letter-spacing: -0.5px;">Welcome Back</h2>
                <p style="color: var(--text-muted); font-size: 0.88rem; margin-top: 6px;">Sign in to manage your gaming bookings & perks</p>
            </div>

            <!-- Login fields -->
            <div id="login-form">
                <div class="form-group">
                    <label class="form-label"><i class="fa-solid fa-envelope" style="color: var(--accent-primary); margin-right: 6px;"></i> Email Address</label>
                    <asp:TextBox ID="loginEmail" runat="server" ClientIDMode="Static" CssClass="form-control" TextMode="Email" placeholder="name@domain.com" required="required" autocomplete="off"></asp:TextBox>
                </div>

                <div class="form-group">
                    <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 7px;">
                        <label class="form-label" style="margin-bottom: 0;"><i class="fa-solid fa-lock" style="color: var(--accent-primary); margin-right: 6px;"></i> Password</label>
                        <a href="#" style="font-size: 0.8rem; color: var(--accent-primary);" onclick="showToast('Password reset link sent to registered email!', 'info')">Forgot?</a>
                    </div>
                    <asp:TextBox ID="loginPassword" runat="server" ClientIDMode="Static" CssClass="form-control" TextMode="Password" placeholder="Enter your password" required="required" autocomplete="new-password"></asp:TextBox>
                </div>

                <div style="display: flex; align-items: center; gap: 8px; margin-bottom: 1.5rem; margin-top: 0.5rem;">
                    <asp:CheckBox ID="chkRemember" runat="server" Checked="true" />
                    <label for="chkRemember" style="font-size: 0.85rem; color: var(--text-muted); cursor: pointer;">Remember session on this device</label>
                </div>

                <asp:Button ID="btnLogin" runat="server" CssClass="btn-cyber" style="width: 100%; height: 46px; font-size: 0.95rem;" Text="Sign In to Portal" OnClick="btnLogin_Click" />
            </div>

            <div style="text-align: center; margin-top: 1.75rem; font-size: 0.88rem; color: var(--text-muted); border-top: 1px solid var(--border-subtle); padding-top: 1.25rem;">
                Don't have a CyberGrid account? <a href="register.aspx" style="color: var(--accent-primary); font-weight: 600;">Create Account</a>
            </div>

        </div>
    </section>

</asp:Content>

<asp:Content ID="ScriptsLogin" ContentPlaceHolderID="ScriptsExtra" runat="server">
    <script>
        function fillDemoLogin(email, password) {
            document.getElementById('loginEmail').value = email;
            document.getElementById('loginPassword').value = password;
            showToast(`Filled demo credentials for ${email}`, 'info');
        }

        function handleLoginSubmit(e) {
            e.preventDefault();
            const email = document.getElementById('login-email').value.trim();
            const password = document.getElementById('login-password').value.trim();

            const res = dbLoginUser(email, password);
            if (res.success) {
                showToast(`Welcome back, ${res.user.name}!`, 'success');
                setTimeout(() => {
                    if (res.user.role === 'staff') {
                        window.location.href = 'staff-dashboard.aspx';
                    } else if (res.user.role === 'admin') {
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

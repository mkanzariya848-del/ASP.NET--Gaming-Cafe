<%@ Page Title="Customer Dashboard - CyberGrid" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="customer-dashboard.aspx.cs" Inherits="GAMIING_CAFE.CustomerDashboardPage" %>

<asp:Content ID="MainContentCustomerDashboard" ContentPlaceHolderID="MainContent" runat="server">

    <section class="section" style="padding-top: 3rem;">
        <div id="customer-dashboard-view">

            <!-- User Info Header Bar -->
            <div class="glass-card" style="margin-bottom: 2rem; display: flex; align-items: center; justify-content: space-between; flex-wrap: wrap; gap: 1.5rem;">
                <div style="display: flex; align-items: center; gap: 1.25rem;">
                    <img src="https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?auto=format&fit=crop&w=120&q=80" style="width: 64px; height: 64px; border-radius: 50%; border: 2px solid var(--accent-primary); object-fit: cover;" alt="Profile">
                    <div>
                        <h2 style="font-size: 1.4rem;"><asp:Label ID="lblUserName" runat="server" Text="User"></asp:Label></h2>
                        <p style="color: var(--text-muted); font-size: 0.88rem; margin-top: 3px;">
                            <asp:Label ID="lblUserEmail" runat="server" Text="user@domain.com"></asp:Label>
                            <span id="phoneSep" runat="server"> | </span>
                            <asp:Label ID="lblUserPhone" runat="server" Text=""></asp:Label>
                        </p>
                    </div>
                </div>

                <div style="display: flex; gap: 1.5rem; align-items: center;">
                    <div style="text-align: right;">
                        <div style="font-size: 0.78rem; color: var(--text-muted); text-transform: uppercase;">Membership Tier</div>
                        <span class="badge-status status-reserved" style="margin-top: 3px;"><i class="fa-solid fa-crown text-yellow"></i> GOLD VIP</span>
                    </div>
                    <div style="text-align: right; border-left: 1px solid var(--border-subtle); padding-left: 1.5rem;">
                        <div style="font-size: 0.78rem; color: var(--text-muted); text-transform: uppercase;">Reward Points</div>
                        <div style="font-size: 1.3rem; color: var(--accent-primary); font-weight: 800; margin-top: 2px;">1,250 pts</div>
                    </div>
                </div>
            </div>

            <!-- Live Active Session Widget -->
            <asp:HiddenField ID="hfBookingId" runat="server" Value="" />
            <asp:HiddenField ID="hfStationName" runat="server" Value="" />
            <asp:HiddenField ID="hfDurationHours" runat="server" Value="" />
            <asp:HiddenField ID="hfTotalAmount" runat="server" Value="" />
            <asp:HiddenField ID="hfBookingStatus" runat="server" Value="" />
            <div id="active-session-widget" style="margin-bottom: 2rem;">
                <!-- Real-time countdown timer rendered via JS -->
            </div>

            <!-- Booking History Table -->
            <div class="glass-card">
                <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 1.25rem;">
                    <h3 style="font-size: 1.2rem; display: flex; align-items: center; gap: 8px;">
                        <i class="fa-solid fa-clock-rotate-left" style="color: var(--accent-primary);"></i> Booking History & Invoices
                    </h3>
                    <a href="booking.aspx" class="btn-cyber" style="padding: 6px 14px; font-size: 0.85rem;">
                        <i class="fa-solid fa-plus"></i> New Booking
                    </a>
                </div>
                
                <div class="table-responsive">
                    <table class="modern-table">
                        <thead>
                            <tr>
                                <th style="width: 80px;">Booking ID</th>
                                <th>Station</th>
                                <th>Date & Time</th>
                                <th style="width: 75px; text-align: center;">Duration</th>
                                <th style="width: 85px; text-align: right;">Total Paid</th>
                                <th style="width: 100px; text-align: center;">Status</th>
                                <th style="width: 85px; text-align: center;">Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <asp:Repeater ID="rptCustomerBookings" runat="server">
                                <ItemTemplate>
                                    <tr>
                                        <td><span class="badge-id">#BK-<%# Eval("booking_id") %></span></td>
                                        <td><strong style="color: #f8fafc;"><i class="fa-solid fa-gamepad" style="color: var(--accent-primary); margin-right: 6px;"></i><%# Eval("station_name") %></strong></td>
                                        <td><span style="color: #94a3b8;"><i class="fa-regular fa-calendar" style="margin-right: 5px;"></i><%# Eval("booking_date") %> &bull; <%# Eval("time_slot") %></span></td>
                                        <td style="text-align: center;"><span style="font-weight: 600; color: #f8fafc;"><%# Eval("duration_hours") %> Hrs</span></td>
                                        <td style="text-align: right;"><strong style="color: #34d399; font-size: 0.95rem;">&#8377;<%# Eval("total_amount") %></strong></td>
                                        <td style="text-align: center;">
                                            <span class='status-pill <%# Eval("status").ToString().ToLower() == "available" ? "available" : (Eval("status").ToString().ToLower() == "completed" ? "completed" : "confirmed") %>'>
                                                <%# Eval("status") %>
                                            </span>
                                        </td>
                                        <td style="text-align: center;">
                                            <button type="button" class="btn-outline" style="font-size: 0.74rem; padding: 4px 8px; white-space: nowrap;" onclick="window.print()">
                                                <i class="fa-solid fa-print"></i> Receipt
                                            </button>
                                        </td>
                                    </tr>
                                </ItemTemplate>
                            </asp:Repeater>
                            <tr id="trNoBookings" runat="server" visible="false">
                                <td colspan="7" style="text-align: center; padding: 3rem 1rem; color: var(--text-muted);">
                                    <i class="fa-solid fa-calendar-xmark" style="font-size: 2rem; margin-bottom: 0.5rem; display: block; opacity: 0.5;"></i>
                                    No bookings found yet. <a href="booking.aspx" style="color: var(--accent-primary); font-weight: 600;">Book a Station now!</a>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>

        </div>
    </section>

</asp:Content>

<asp:Content ID="ScriptsCustomerDashboard" ContentPlaceHolderID="ScriptsExtra" runat="server">
    <script src="js/dashboard.js"></script>
    <script>
        function showExtendModal() {
            showToast('Requested +1 Hour Extension! Staff notified.', 'success');
        }
    </script>
</asp:Content>

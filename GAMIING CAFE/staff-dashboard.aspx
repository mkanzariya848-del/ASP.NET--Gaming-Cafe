<%@ Page Title="Staff Operations Center - CyberGrid" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="staff-dashboard.aspx.cs" Inherits="GAMIING_CAFE.StaffDashboardPage" %>

<asp:Content ID="MainContentStaffDashboard" ContentPlaceHolderID="MainContent" runat="server">

    <section class="section" style="padding-top: 3rem;">
        <div id="staff-dashboard-view">

            <!-- Top Action Bar -->
            <div class="glass-card" style="margin-bottom: 2rem; display: flex; justify-content: space-between; align-items: center; flex-wrap: wrap; gap: 1rem;">
                <div>
                    <h2 style="font-size: 1.4rem; display: flex; align-items: center; gap: 10px;">
                        <i class="fa-solid fa-user-gear" style="color: var(--accent-primary);"></i> Staff Operations Center
                    </h2>
                    <p style="color: var(--text-muted); font-size: 0.88rem; margin-top: 4px;">Live floor map control, station status & active customer bookings</p>
                </div>

                <div style="display: flex; gap: 10px;">
                    <a href="booking.aspx" class="btn-cyber" style="padding: 6px 14px; font-size: 0.85rem;"><i class="fa-solid fa-plus"></i> Manual Booking</a>
                    <a href="admin-dashboard.aspx" class="btn-outline" style="padding: 6px 14px; font-size: 0.85rem;"><i class="fa-solid fa-sliders"></i> Admin View</a>
                </div>
            </div>

            <!-- Live Floor Station Grid Map from tbl_station -->
            <div style="margin-bottom: 2.5rem;">
                <h3 style="margin-bottom: 1.25rem; font-size: 1.2rem; display: flex; align-items: center; gap: 8px;">
                    <i class="fa-solid fa-map-location-dot" style="color: var(--accent-primary);"></i> Station Floor Map & Status
                </h3>
                <div class="grid-4">
                    <asp:Repeater ID="rptStaffStations" runat="server" OnItemCommand="rptStaffStations_ItemCommand">
                        <ItemTemplate>
                            <div class="glass-card" style="text-align: center; padding: 1.25rem;">
                                <div style="font-size: 1.6rem; margin-bottom: 8px; color: var(--accent-primary);">
                                    <i class="fa-solid fa-desktop"></i>
                                </div>
                                <h4 style="font-size: 1.05rem;"><%# Eval("station_name") %></h4>
                                <div style="margin: 8px 0;">
                                    <span class='badge-status <%# Eval("status").ToString() == "Available" ? "status-available" : "status-occupied" %>'>
                                        <%# Eval("status") %>
                                    </span>
                                </div>
                                <p style="color: var(--text-main); font-weight: 700; font-size: 1.05rem;">&#8377;<%# Eval("rate_per_hour") %><span style="font-size: 0.8rem; font-weight: 400; color: var(--text-muted);">/hr</span></p>
                                <div style="margin-top: 10px;">
                                    <asp:Button ID="btnToggleStatus" runat="server" Text="Toggle Status" CommandName="cmd_toggle" CommandArgument='<%# Eval("station_id") + "|" + Eval("status") %>' CssClass="btn-outline" style="font-size: 0.78rem; padding: 5px 12px; width: 100%;" />
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                </div>
            </div>

            <!-- Active Bookings Queue from tbl_booking -->
            <div class="glass-card">
                <h3 style="margin-bottom: 1.25rem; font-size: 1.2rem; display: flex; align-items: center; gap: 8px;">
                    <i class="fa-solid fa-clock-rotate-left" style="color: var(--accent-primary);"></i> Active Customer Bookings Queue
                </h3>
                <div class="table-responsive">
                    <table class="modern-table">
                        <thead>
                            <tr>
                                <th style="width: 75px;">Booking #</th>
                                <th>Customer</th>
                                <th>Station</th>
                                <th style="width: 95px;">Booking Date</th>
                                <th style="width: 105px;">Time Slot</th>
                                <th style="width: 75px; text-align: center;">Duration</th>
                                <th style="width: 85px; text-align: right;">Total</th>
                                <th style="width: 100px; text-align: center;">Status</th>
                                <th style="width: 120px; text-align: center;">Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <asp:Repeater ID="rptStaffBookings" runat="server" OnItemCommand="rptStaffBookings_ItemCommand">
                                <ItemTemplate>
                                    <tr>
                                        <td><span class="badge-id">#BK-<%# Eval("booking_id") %></span></td>
                                        <td><strong style="color: #f8fafc;"><%# Eval("user_name") %></strong></td>
                                        <td><span style="color: #cbd5e1;"><i class="fa-solid fa-gamepad" style="color: var(--accent-primary); margin-right: 6px;"></i><%# Eval("station_name") %></span></td>
                                        <td><span style="color: #94a3b8;"><i class="fa-regular fa-calendar" style="margin-right: 5px;"></i><%# Eval("booking_date") %></span></td>
                                        <td><span style="color: #cbd5e1;"><i class="fa-regular fa-clock" style="margin-right: 5px; color: var(--accent-cyan);"></i><%# Eval("time_slot") %></span></td>
                                        <td style="text-align: center;"><span style="font-weight: 600; color: #f8fafc;"><%# Eval("duration_hours") %> Hrs</span></td>
                                        <td style="text-align: right;"><strong style="color: #34d399; font-size: 0.95rem;">&#8377;<%# Eval("total_amount") %></strong></td>
                                        <td style="text-align: center;">
                                            <span class='status-pill <%# Eval("status").ToString().ToLower() == "available" ? "available" : (Eval("status").ToString().ToLower() == "completed" ? "completed" : "confirmed") %>'>
                                                <%# Eval("status") %>
                                            </span>
                                        </td>
                                        <td style="text-align: center;">
                                            <asp:Button ID="btnCompleteBooking" runat="server" Text="Mark Completed" CommandName="cmd_complete" CommandArgument='<%# Eval("booking_id") %>' CssClass="btn-cyber" style="font-size: 0.74rem; padding: 4px 8px; white-space: nowrap;" />
                                        </td>
                                    </tr>
                                </ItemTemplate>
                            </asp:Repeater>
                        </tbody>
                    </table>
                </div>
            </div>

        </div>
    </section>

</asp:Content>

<asp:Content ID="ScriptsStaffDashboard" ContentPlaceHolderID="ScriptsExtra" runat="server">
    <script src="js/dashboard.js"></script>
</asp:Content>

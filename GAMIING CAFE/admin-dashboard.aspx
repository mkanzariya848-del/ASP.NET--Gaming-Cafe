<%@ Page Title="Admin Executive Dashboard - CyberGrid" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="admin-dashboard.aspx.cs" Inherits="GAMIING_CAFE.AdminDashboardPage" %>

<asp:Content ID="HeadExtraAdmin" ContentPlaceHolderID="HeadExtra" runat="server">
</asp:Content>

<asp:Content ID="MainContentAdmin" ContentPlaceHolderID="MainContent" runat="server">

    <section class="section" style="padding-top: 3rem;">
        <div id="admin-dashboard-view">

            <!-- Admin Header Bar -->
            <div class="glass-card" style="margin-bottom: 2rem; display: flex; justify-content: space-between; align-items: center; flex-wrap: wrap; gap: 1rem;">
                <div>
                    <h2 style="font-size: 1.4rem; display: flex; align-items: center; gap: 10px;">
                        <i class="fa-solid fa-sliders" style="color: var(--accent-primary);"></i> Executive Admin Dashboard
                    </h2>
                    <p style="color: var(--text-muted); font-size: 0.88rem; margin-top: 4px;">Live SQL database management, revenue statistics & active station monitoring</p>
                </div>

                <div style="display: flex; gap: 10px;">
                    <a href="report.aspx" class="btn-cyber" style="font-size: 0.85rem; padding: 6px 14px;"><i class="fa-solid fa-file-invoice"></i> Crystal Reports</a>
                    <button type="button" class="btn-outline" style="font-size: 0.85rem; padding: 6px 14px;" onclick="window.print()"><i class="fa-solid fa-print"></i> Print</button>
                    <a href="booking.aspx" class="btn-outline" style="font-size: 0.85rem; padding: 6px 14px;"><i class="fa-solid fa-plus"></i> New Booking</a>
                </div>
            </div>

            <!-- Real KPI Stat Cards from SQL Database -->
            <div class="grid-4" style="margin-bottom: 2.5rem;">
                <div class="glass-card" style="padding: 1.5rem;">
                    <div style="font-size: 0.78rem; color: var(--text-muted); text-transform: uppercase; letter-spacing: 0.5px;">Total Revenue</div>
                    <div style="font-size: 2rem; color: var(--text-main); font-weight: 800; margin-top: 4px;">
                        <asp:Label ID="lblTotalRevenue" runat="server" Text="&#8377;0"></asp:Label>
                    </div>
                    <div style="font-size: 0.78rem; color: var(--accent-emerald); margin-top: 6px;"><i class="fa-solid fa-circle-check"></i> Live from tbl_booking</div>
                </div>

                <div class="glass-card" style="padding: 1.5rem;">
                    <div style="font-size: 0.78rem; color: var(--text-muted); text-transform: uppercase; letter-spacing: 0.5px;">Total Bookings</div>
                    <div style="font-size: 2rem; color: var(--accent-primary); font-weight: 800; margin-top: 4px;">
                        <asp:Label ID="lblTotalBookings" runat="server" Text="0"></asp:Label>
                    </div>
                    <div style="font-size: 0.78rem; color: var(--text-muted); margin-top: 6px;"><i class="fa-solid fa-gamepad"></i> Confirmed Sessions</div>
                </div>

                <div class="glass-card" style="padding: 1.5rem;">
                    <div style="font-size: 0.78rem; color: var(--text-muted); text-transform: uppercase; letter-spacing: 0.5px;">Total Stations</div>
                    <div style="font-size: 2rem; color: var(--accent-purple); font-weight: 800; margin-top: 4px;">
                        <asp:Label ID="lblTotalStations" runat="server" Text="0"></asp:Label>
                    </div>
                    <div style="font-size: 0.78rem; color: var(--text-muted); margin-top: 6px;">
                        <asp:Label ID="lblActiveStations" runat="server" Text="0 Available"></asp:Label>
                    </div>
                </div>

                <div class="glass-card" style="padding: 1.5rem;">
                    <div style="font-size: 0.78rem; color: var(--text-muted); text-transform: uppercase; letter-spacing: 0.5px;">Registered Users</div>
                    <div style="font-size: 2rem; color: var(--accent-amber); font-weight: 800; margin-top: 4px;">
                        <asp:Label ID="lblTotalUsers" runat="server" Text="0"></asp:Label>
                    </div>
                    <div style="font-size: 0.78rem; color: var(--accent-emerald); margin-top: 6px;"><i class="fa-solid fa-users"></i> In tbl_user database</div>
                </div>
            </div>

            <!-- Add New Station Form -->
            <div class="glass-card" style="margin-bottom: 2.5rem;">
                <h3 style="margin-bottom: 1.25rem; font-size: 1.2rem; display: flex; align-items: center; gap: 8px;">
                    <i class="fa-solid fa-plus-circle" style="color: var(--accent-primary);"></i> Add New Gaming Station (tbl_station)
                </h3>
                <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); gap: 1rem;">
                    <div>
                        <label class="form-label">Station Name *</label>
                        <asp:TextBox ID="txtNewStationName" runat="server" CssClass="form-control" placeholder="e.g. Station Gamma (RTX 4070)"></asp:TextBox>
                    </div>
                    <div>
                        <label class="form-label">Category *</label>
                        <asp:DropDownList ID="drpNewStationCat" runat="server" CssClass="form-control"></asp:DropDownList>
                    </div>
                    <div>
                        <label class="form-label">Hourly Rate (&#8377;) *</label>
                        <asp:TextBox ID="txtNewStationRate" runat="server" CssClass="form-control" placeholder="e.g. 120"></asp:TextBox>
                    </div>
                    <div>
                        <label class="form-label">Status</label>
                        <asp:DropDownList ID="drpNewStationStatus" runat="server" CssClass="form-control">
                            <asp:ListItem Value="Available">Available</asp:ListItem>
                            <asp:ListItem Value="Occupied">Occupied</asp:ListItem>
                            <asp:ListItem Value="Maintenance">Maintenance</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                </div>
                <div style="margin-top: 1.25rem;">
                    <asp:Button ID="btnAddStation" runat="server" Text="Save Station to Database" CssClass="btn-cyber" OnClick="btnAddStation_Click" />
                </div>
            </div>

            <!-- Live Customer Bookings Table from tbl_booking -->
            <div class="glass-card" style="margin-bottom: 2.5rem;">
                <div class="table-card-header">
                    <h3 class="table-card-title">
                        <i class="fa-solid fa-clock-rotate-left" style="color: var(--accent-primary);"></i> Live Customer Bookings (tbl_booking)
                    </h3>
                </div>
                <div class="table-responsive">
                    <table class="modern-table">
                        <thead>
                            <tr>
                                <th style="width: 75px;">Booking #</th>
                                <th>Customer Name</th>
                                <th>Station</th>
                                <th style="width: 95px;">Booking Date</th>
                                <th style="width: 105px;">Time Slot</th>
                                <th style="width: 75px; text-align: center;">Duration</th>
                                <th style="width: 90px; text-align: right;">Total Amount</th>
                                <th style="width: 100px; text-align: center;">Status</th>
                                <th style="width: 80px; text-align: center;">Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <asp:Repeater ID="rptBookings" runat="server" OnItemCommand="rptBookings_ItemCommand">
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
                                            <span class='status-pill <%# Eval("status").ToString().ToLower() == "available" ? "available" : (Eval("status").ToString().ToLower() == "occupied" ? "occupied" : (Eval("status").ToString().ToLower() == "completed" ? "completed" : "confirmed")) %>'>
                                                <%# Eval("status") %>
                                            </span>
                                        </td>
                                        <td style="text-align: center;">
                                            <asp:LinkButton ID="lnkDelBooking" runat="server" CommandName="cmd_delete" CommandArgument='<%# Eval("booking_id") %>' CssClass="btn-table-delete" OnClientClick="return confirm('Delete this booking record?');"><i class="fa-solid fa-trash-can"></i> Delete</asp:LinkButton>
                                        </td>
                                    </tr>
                                </ItemTemplate>
                            </asp:Repeater>
                        </tbody>
                    </table>
                </div>
            </div>

            <!-- Gaming Stations & Rigs Table from tbl_station -->
            <div class="glass-card">
                <div class="table-card-header">
                    <h3 class="table-card-title">
                        <i class="fa-solid fa-boxes-stacked" style="color: var(--accent-primary);"></i> Gaming Stations & Rigs (tbl_station)
                    </h3>
                </div>
                <div class="table-responsive">
                    <table class="modern-table">
                        <thead>
                            <tr>
                                <th style="width: 75px;">Station #</th>
                                <th>Station Name</th>
                                <th>Category</th>
                                <th style="width: 95px; text-align: right;">Hourly Rate</th>
                                <th style="width: 100px; text-align: center;">Status</th>
                                <th style="width: 80px; text-align: center;">Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <asp:Repeater ID="rptStations" runat="server" OnItemCommand="rptStations_ItemCommand">
                                <ItemTemplate>
                                    <tr>
                                        <td><span class="badge-id">ST-0<%# Eval("station_id") %></span></td>
                                        <td><strong style="color: #f8fafc;"><i class="fa-solid fa-desktop" style="color: var(--accent-primary); margin-right: 6px;"></i><%# Eval("station_name") %></strong></td>
                                        <td><span style="color: #94a3b8;"><%# Eval("cat_name") %></span></td>
                                        <td style="text-align: right;"><strong style="color: #f8fafc; font-size: 0.95rem;">&#8377;<%# Eval("rate_per_hour") %></strong><span style="font-size: 0.78rem; color: #94a3b8;">/hr</span></td>
                                        <td style="text-align: center;">
                                            <span class='status-pill <%# Eval("status").ToString().ToLower() == "available" ? "available" : "occupied" %>'>
                                                <%# Eval("status") %>
                                            </span>
                                        </td>
                                        <td style="text-align: center;">
                                            <asp:LinkButton ID="lnkDelStation" runat="server" CommandName="cmd_del_station" CommandArgument='<%# Eval("station_id") %>' CssClass="btn-table-delete" OnClientClick="return confirm('Delete this station?');"><i class="fa-solid fa-trash-can"></i> Delete</asp:LinkButton>
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

<asp:Content ID="ScriptsAdmin" ContentPlaceHolderID="ScriptsExtra" runat="server">
</asp:Content>

<%@ Page Title="Reports - CyberGrid Gaming Cafe" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="report.aspx.cs" Inherits="GAMIING_CAFE.ReportPage" EnableViewState="false" %>
<%@ Register Assembly="CrystalDecisions.Web, Version=13.0.4000.0, Culture=neutral, PublicKeyToken=692fbea5521e1304" Namespace="CrystalDecisions.Web" TagPrefix="CR" %>

<asp:Content ID="MetaContentReport" ContentPlaceHolderID="MetaContent" runat="server">
    <meta name="description" content="CyberGrid Gaming Cafe SAP Crystal Reports Module" />
</asp:Content>

<asp:Content ID="MainContentReport" ContentPlaceHolderID="MainContent" runat="server">

    <section class="section" style="padding-top: 3rem; padding-bottom: 4rem;">
        
        <div class="section-title-wrap">
            <span class="section-tag"><i class="fa-solid fa-chart-pie"></i> SAP Reporting Module</span>
            <h2 class="section-title">7 CRYSTAL REPORTS</h2>
            <p style="color: var(--text-muted); max-width: 650px; margin: 0 auto; font-size: 0.95rem;">
                Dynamic database reporting, XML schema generation, and PDF export powered by SAP Crystal Reports for Visual Studio.
            </p>
        </div>

        <!-- Main Selector Bar (As per PDF guide) -->
        <div class="glass-card" style="margin-bottom: 2.5rem; padding: 2rem;">
            <div style="display: flex; flex-wrap: wrap; gap: 1.5rem; align-items: flex-end; justify-content: space-between;">
                
                <div style="flex: 1 1 340px;">
                    <label class="form-label" style="font-weight: 700; color: var(--text-main); margin-bottom: 8px; display: block;">
                        <i class="fa-solid fa-list-check" style="color: var(--neon-cyan);"></i> Select Crystal Report (7 Available):
                    </label>
                    <asp:DropDownList ID="drpReport" runat="server" CssClass="form-control" style="background-color: var(--bg-dark); color: var(--text-main); border: 1px solid var(--border-light); padding: 12px 14px; border-radius: var(--radius-sm); width: 100%; font-size: 0.95rem;">
                        <asp:ListItem Value="booking" Text="1. Station Bookings Report (booking.rpt)" Selected="True"></asp:ListItem>
                        <asp:ListItem Value="food" Text="2. Cafe Food & Beverages Report (food.rpt)"></asp:ListItem>
                        <asp:ListItem Value="station" Text="3. Gaming Stations Status & Hardware (station.rpt)"></asp:ListItem>
                        <asp:ListItem Value="user" Text="4. Registered Users & Members (user.rpt)"></asp:ListItem>
                        <asp:ListItem Value="games" Text="5. Games Library Catalog (games.rpt)"></asp:ListItem>
                        <asp:ListItem Value="tournament" Text="6. Esports Tournaments & Prizes (tournament.rpt)"></asp:ListItem>
                        <asp:ListItem Value="billing" Text="7. Daily Revenue & Billing Summary (billing.rpt)"></asp:ListItem>
                    </asp:DropDownList>
                </div>

                <div style="display: flex; flex-wrap: wrap; gap: 10px; align-items: center;">
                    <asp:Button ID="btn_xml" runat="server" Text="Create XML File" CssClass="btn-outline" OnClick="btn_xml_Click" ToolTip="Step 4: Generate data.xml schema dynamically" />
                    <asp:Button ID="btn_view" runat="server" Text="View Report" CssClass="btn-outline" OnClick="btn_view_Click" ToolTip="Step 5: View report inside CrystalReportViewer" />
                    <asp:Button ID="btn_export" runat="server" Text="Download PDF" CssClass="btn-cyber" OnClick="btn_export_Click" ToolTip="Step 5: Export to PortableDocFormat (PDF)" />
                    <asp:Button ID="btn_xml_all" runat="server" Text="Generate All 7 XMLs" CssClass="btn-outline" OnClick="btn_xml_all_Click" style="border-color: var(--neon-magenta); color: var(--neon-magenta);" ToolTip="Generate schemas for all 7 reports at once" />
                </div>

            </div>
        </div>

        <!-- 7 Quick Cards Grid -->
        <h3 style="font-size: 1.25rem; font-weight: 800; color: var(--text-main); margin-bottom: 1.25rem; display: flex; align-items: center; gap: 8px;">
            <i class="fa-solid fa-layer-group" style="color: var(--neon-cyan);"></i> Quick Report Actions (All 7 Modules)
        </h3>

        <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(280px, 1fr)); gap: 1.25rem; margin-bottom: 2.5rem;">
            
            <!-- Card 1: Bookings -->
            <div class="glass-card" style="padding: 1.25rem; border-left: 4px solid #00f0ff;">
                <div style="display: flex; align-items: center; gap: 10px; margin-bottom: 8px;">
                    <i class="fa-solid fa-gamepad" style="font-size: 1.5rem; color: #00f0ff;"></i>
                    <h4 style="font-size: 1.05rem; font-weight: 700; color: var(--text-main); margin: 0;">1. Station Bookings</h4>
                </div>
                <p style="font-size: 0.85rem; color: var(--text-muted); margin-bottom: 12px;">
                    Table: <code>tbl_booking</code> | File: <code>booking.rpt</code><br />
                    All station reservation records, slots, and amounts.
                </p>
                <div style="display: flex; gap: 8px;">
                    <asp:Button ID="btnQuickView1" runat="server" Text="View" CommandArgument="booking" OnClick="btnQuickAction_Click" CssClass="btn-outline" style="padding: 6px 12px; font-size: 0.8rem; flex: 1;" />
                    <asp:Button ID="btnQuickPdf1" runat="server" Text="PDF" CommandArgument="booking_pdf" OnClick="btnQuickAction_Click" CssClass="btn-cyber" style="padding: 6px 12px; font-size: 0.8rem; flex: 1;" />
                </div>
            </div>

            <!-- Card 2: Food Menu -->
            <div class="glass-card" style="padding: 1.25rem; border-left: 4px solid #ff007f;">
                <div style="display: flex; align-items: center; gap: 10px; margin-bottom: 8px;">
                    <i class="fa-solid fa-burger" style="font-size: 1.5rem; color: #ff007f;"></i>
                    <h4 style="font-size: 1.05rem; font-weight: 700; color: var(--text-main); margin: 0;">2. Cafe Food & Menu</h4>
                </div>
                <p style="font-size: 0.85rem; color: var(--text-muted); margin-bottom: 12px;">
                    Table: <code>tbl_food</code> | File: <code>food.rpt</code><br />
                    Food items, snacks, drinks, and catalog prices.
                </p>
                <div style="display: flex; gap: 8px;">
                    <asp:Button ID="btnQuickView2" runat="server" Text="View" CommandArgument="food" OnClick="btnQuickAction_Click" CssClass="btn-outline" style="padding: 6px 12px; font-size: 0.8rem; flex: 1;" />
                    <asp:Button ID="btnQuickPdf2" runat="server" Text="PDF" CommandArgument="food_pdf" OnClick="btnQuickAction_Click" CssClass="btn-cyber" style="padding: 6px 12px; font-size: 0.8rem; flex: 1;" />
                </div>
            </div>

            <!-- Card 3: Stations Status -->
            <div class="glass-card" style="padding: 1.25rem; border-left: 4px solid #39ff14;">
                <div style="display: flex; align-items: center; gap: 10px; margin-bottom: 8px;">
                    <i class="fa-solid fa-desktop" style="font-size: 1.5rem; color: #39ff14;"></i>
                    <h4 style="font-size: 1.05rem; font-weight: 700; color: var(--text-main); margin: 0;">3. Gaming Stations</h4>
                </div>
                <p style="font-size: 0.85rem; color: var(--text-muted); margin-bottom: 12px;">
                    Table: <code>tbl_station</code> | File: <code>station.rpt</code><br />
                    Live station availability, categories, and hourly rates.
                </p>
                <div style="display: flex; gap: 8px;">
                    <asp:Button ID="btnQuickView3" runat="server" Text="View" CommandArgument="station" OnClick="btnQuickAction_Click" CssClass="btn-outline" style="padding: 6px 12px; font-size: 0.8rem; flex: 1;" />
                    <asp:Button ID="btnQuickPdf3" runat="server" Text="PDF" CommandArgument="station_pdf" OnClick="btnQuickAction_Click" CssClass="btn-cyber" style="padding: 6px 12px; font-size: 0.8rem; flex: 1;" />
                </div>
            </div>

            <!-- Card 4: Registered Users -->
            <div class="glass-card" style="padding: 1.25rem; border-left: 4px solid #b026ff;">
                <div style="display: flex; align-items: center; gap: 10px; margin-bottom: 8px;">
                    <i class="fa-solid fa-users" style="font-size: 1.5rem; color: #b026ff;"></i>
                    <h4 style="font-size: 1.05rem; font-weight: 700; color: var(--text-main); margin: 0;">4. Users & Members</h4>
                </div>
                <p style="font-size: 0.85rem; color: var(--text-muted); margin-bottom: 12px;">
                    Table: <code>tbl_user</code> | File: <code>user.rpt</code><br />
                    Registered customer directory and role permissions.
                </p>
                <div style="display: flex; gap: 8px;">
                    <asp:Button ID="btnQuickView4" runat="server" Text="View" CommandArgument="user" OnClick="btnQuickAction_Click" CssClass="btn-outline" style="padding: 6px 12px; font-size: 0.8rem; flex: 1;" />
                    <asp:Button ID="btnQuickPdf4" runat="server" Text="PDF" CommandArgument="user_pdf" OnClick="btnQuickAction_Click" CssClass="btn-cyber" style="padding: 6px 12px; font-size: 0.8rem; flex: 1;" />
                </div>
            </div>

            <!-- Card 5: Games Catalog -->
            <div class="glass-card" style="padding: 1.25rem; border-left: 4px solid #ffaa00;">
                <div style="display: flex; align-items: center; gap: 10px; margin-bottom: 8px;">
                    <i class="fa-solid fa-dice" style="font-size: 1.5rem; color: #ffaa00;"></i>
                    <h4 style="font-size: 1.05rem; font-weight: 700; color: var(--text-main); margin: 0;">5. Games Library</h4>
                </div>
                <p style="font-size: 0.85rem; color: var(--text-muted); margin-bottom: 12px;">
                    Table: <code>tbl_games</code> | File: <code>games.rpt</code><br />
                    PC, PS5, Xbox installed games catalog and genres.
                </p>
                <div style="display: flex; gap: 8px;">
                    <asp:Button ID="btnQuickView5" runat="server" Text="View" CommandArgument="games" OnClick="btnQuickAction_Click" CssClass="btn-outline" style="padding: 6px 12px; font-size: 0.8rem; flex: 1;" />
                    <asp:Button ID="btnQuickPdf5" runat="server" Text="PDF" CommandArgument="games_pdf" OnClick="btnQuickAction_Click" CssClass="btn-cyber" style="padding: 6px 12px; font-size: 0.8rem; flex: 1;" />
                </div>
            </div>

            <!-- Card 6: Esports Tournaments -->
            <div class="glass-card" style="padding: 1.25rem; border-left: 4px solid #00f0ff;">
                <div style="display: flex; align-items: center; gap: 10px; margin-bottom: 8px;">
                    <i class="fa-solid fa-trophy" style="font-size: 1.5rem; color: #00f0ff;"></i>
                    <h4 style="font-size: 1.05rem; font-weight: 700; color: var(--text-main); margin: 0;">6. Tournaments</h4>
                </div>
                <p style="font-size: 0.85rem; color: var(--text-muted); margin-bottom: 12px;">
                    Table: <code>tbl_tournament</code> | File: <code>tournament.rpt</code><br />
                    Championship dates, entry fees, and prize pools.
                </p>
                <div style="display: flex; gap: 8px;">
                    <asp:Button ID="btnQuickView6" runat="server" Text="View" CommandArgument="tournament" OnClick="btnQuickAction_Click" CssClass="btn-outline" style="padding: 6px 12px; font-size: 0.8rem; flex: 1;" />
                    <asp:Button ID="btnQuickPdf6" runat="server" Text="PDF" CommandArgument="tournament_pdf" OnClick="btnQuickAction_Click" CssClass="btn-cyber" style="padding: 6px 12px; font-size: 0.8rem; flex: 1;" />
                </div>
            </div>

            <!-- Card 7: Billing & Revenue -->
            <div class="glass-card" style="padding: 1.25rem; border-left: 4px solid #39ff14;">
                <div style="display: flex; align-items: center; gap: 10px; margin-bottom: 8px;">
                    <i class="fa-solid fa-receipt" style="font-size: 1.5rem; color: #39ff14;"></i>
                    <h4 style="font-size: 1.05rem; font-weight: 700; color: var(--text-main); margin: 0;">7. Billing & Revenue</h4>
                </div>
                <p style="font-size: 0.85rem; color: var(--text-muted); margin-bottom: 12px;">
                    Query: <code>tbl_booking (Confirmed)</code> | File: <code>billing.rpt</code><br />
                    Confirmed station bookings, duration, and totals.
                </p>
                <div style="display: flex; gap: 8px;">
                    <asp:Button ID="btnQuickView7" runat="server" Text="View" CommandArgument="billing" OnClick="btnQuickAction_Click" CssClass="btn-outline" style="padding: 6px 12px; font-size: 0.8rem; flex: 1;" />
                    <asp:Button ID="btnQuickPdf7" runat="server" Text="PDF" CommandArgument="billing_pdf" OnClick="btnQuickAction_Click" CssClass="btn-cyber" style="padding: 6px 12px; font-size: 0.8rem; flex: 1;" />
                </div>
            </div>

        </div>

        <!-- Crystal Report Viewer Container -->
        <div class="glass-card" style="padding: 1.5rem; min-height: 500px; overflow-x: auto; background: #ffffff; color: #111827; border-radius: var(--radius-md); box-shadow: 0 10px 30px rgba(0,0,0,0.5);">
            <CR:CrystalReportViewer ID="CrystalReportViewer1" runat="server" AutoDataBind="true" ToolPanelView="None" Width="100%" Height="850px" BestFitPage="false" HasCrystalLogo="false" HasToggleGroupTreeButton="false" HasToggleParameterPanelButton="false" />
        </div>

    </section>

</asp:Content>

<asp:Content ID="ScriptsReport" ContentPlaceHolderID="ScriptsExtra" runat="server">
</asp:Content>

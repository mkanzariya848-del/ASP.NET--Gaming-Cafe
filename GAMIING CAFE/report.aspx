<%@ Page Title="Reports - CyberGrid Gaming Cafe" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="report.aspx.cs" Inherits="GAMIING_CAFE.ReportPage" %>
<%@ Register Assembly="CrystalDecisions.Web, Version=13.0.4000.0, Culture=neutral, PublicKeyToken=692fbea5521e1304" Namespace="CrystalDecisions.Web" TagPrefix="CR" %>

<asp:Content ID="MetaContentReport" ContentPlaceHolderID="MetaContent" runat="server">
    <meta name="description" content="CyberGrid Gaming Cafe Reports" />
</asp:Content>

<asp:Content ID="MainContentReport" ContentPlaceHolderID="MainContent" runat="server">

    <section class="section" style="padding-top: 3rem;">
        <div class="section-title-wrap">
            <span class="section-tag"><i class="fa-solid fa-file-invoice"></i> Reports</span>
            <h2 class="section-title">CRYSTAL REPORTS</h2>
        </div>

        <div class="glass-card" style="margin-bottom: 2rem; padding: 2rem;">
            <div style="display: flex; flex-wrap: wrap; gap: 1.5rem; align-items: flex-end; justify-content: space-between;">
                
                <div style="flex: 1 1 280px;">
                    <label class="form-label" style="font-weight: 700; color: var(--text-main); margin-bottom: 8px;">
                        Select Report:
                    </label>
                    <asp:DropDownList ID="drpReport" runat="server" CssClass="form-control" style="background-color: var(--bg-dark); color: var(--text-main); border: 1px solid var(--border-light); padding: 10px 14px; border-radius: var(--radius-sm); width: 100%;">
                        <asp:ListItem Value="food" Text="Food Products Report (product.rpt)"></asp:ListItem>
                        <asp:ListItem Value="booking" Text="Bookings Report (booking.rpt)"></asp:ListItem>
                    </asp:DropDownList>
                </div>

                <div style="display: flex; flex-wrap: wrap; gap: 10px; align-items: center;">
                    <asp:Button ID="btn_xml" runat="server" Text="Create XML File" CssClass="btn-outline" OnClick="btn_xml_Click" />
                    <asp:Button ID="btn_view" runat="server" Text="View Report" CssClass="btn-outline" OnClick="btn_view_Click" />
                    <asp:Button ID="btn_export" runat="server" Text="Download PDF" CssClass="btn-cyber" OnClick="btn_export_Click" />
                </div>

            </div>
        </div>

        <div class="glass-card" style="padding: 1.5rem; overflow-x: auto; background: #ffffff; color: #111827; border-radius: var(--radius-md);">
            <CR:CrystalReportViewer ID="CrystalReportViewer1" runat="server" AutoDataBind="true" ToolPanelView="None" Width="100%" HasCrystalLogo="false" HasToggleGroupTreeButton="false" HasToggleParameterPanelButton="false" />
        </div>

    </section>

</asp:Content>

<asp:Content ID="ScriptsReport" ContentPlaceHolderID="ScriptsExtra" runat="server">
</asp:Content>

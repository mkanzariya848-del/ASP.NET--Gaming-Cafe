<%@ Page Title="Book Gaming Station - CyberGrid Gaming Cafe" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="booking.aspx.cs" Inherits="GAMIING_CAFE.BookingPage" %>

<asp:Content ID="MetaContentBooking" ContentPlaceHolderID="MetaContent" runat="server">
    <meta name="description" content="Reserve high-end gaming PCs, PS5 consoles, or offline game tables with real-time slot selection and instant confirmation." />
</asp:Content>

<asp:Content ID="MainContentBooking" ContentPlaceHolderID="MainContent" runat="server">

    <section class="section" style="padding-top: 3rem;">
        <div class="section-title-wrap" style="margin-bottom: 2.5rem;">
            <span class="section-tag"><i class="fa-solid fa-calendar-check"></i> Instant Reservation</span>
            <h2 class="section-title">BOOK YOUR GAMING SESSION</h2>
        </div>

        <div style="max-width: 720px; margin: 0 auto;">
            <div class="glass-card" style="padding: 2.5rem;">
                <h3 style="margin-bottom: 1.5rem; font-size: 1.25rem; display: flex; align-items: center; gap: 10px;">
                    <i class="fa-solid fa-gamepad" style="color: var(--accent-primary);"></i> Station Reservation Details
                </h3>

                <div class="form-group" style="margin-bottom: 1.5rem;">
                    <label class="form-label">Customer Full Name *</label>
                    <asp:TextBox ID="txtCustomerName" runat="server" CssClass="form-control" placeholder="Enter your full name"></asp:TextBox>
                </div>

                <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 1.5rem; margin-bottom: 1.5rem;">
                    <div class="form-group">
                        <label class="form-label">Select Gaming Station / Rig *</label>
                        <asp:DropDownList ID="drpStation" runat="server" CssClass="form-control" AutoPostBack="true" OnSelectedIndexChanged="drpStation_SelectedIndexChanged">
                        </asp:DropDownList>
                    </div>

                    <div class="form-group">
                        <label class="form-label">Station Hourly Rate</label>
                        <div style="padding: 10px 14px; background: rgba(255,255,255,0.04); border: 1px solid var(--border-light); border-radius: var(--radius-sm); font-size: 1.05rem; color: var(--text-main); font-weight: 700; height: 45px; display: flex; align-items: center;">
                            &#8377;<asp:Label ID="lblRate" runat="server" Text="0"></asp:Label>&nbsp;<span style="font-size: 0.8rem; color: var(--text-muted); font-weight: 400;">/ hr</span>
                        </div>
                    </div>
                </div>

                <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 1.5rem; margin-bottom: 1.5rem;">
                    <div class="form-group">
                        <label class="form-label">Booking Date *</label>
                        <asp:TextBox ID="txtDate" runat="server" TextMode="Date" CssClass="form-control"></asp:TextBox>
                    </div>

                    <div class="form-group">
                        <label class="form-label">Select Time Slot *</label>
                        <asp:DropDownList ID="drpTimeSlot" runat="server" CssClass="form-control">
                            <asp:ListItem Value="10:00 AM - 12:00 PM">10:00 AM - 12:00 PM</asp:ListItem>
                            <asp:ListItem Value="12:00 PM - 02:00 PM">12:00 PM - 02:00 PM</asp:ListItem>
                            <asp:ListItem Value="02:00 PM - 04:00 PM">02:00 PM - 04:00 PM</asp:ListItem>
                            <asp:ListItem Value="04:00 PM - 06:00 PM">04:00 PM - 06:00 PM</asp:ListItem>
                            <asp:ListItem Value="06:00 PM - 08:00 PM">06:00 PM - 08:00 PM</asp:ListItem>
                            <asp:ListItem Value="08:00 PM - 10:00 PM">08:00 PM - 10:00 PM</asp:ListItem>
                            <asp:ListItem Value="10:00 PM - 12:00 AM">10:00 PM - 12:00 AM</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                </div>

                <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 1.5rem; margin-bottom: 1.5rem;">
                    <div class="form-group">
                        <label class="form-label">Session Duration *</label>
                        <asp:DropDownList ID="drpDuration" runat="server" CssClass="form-control" AutoPostBack="true" OnSelectedIndexChanged="drpDuration_SelectedIndexChanged">
                            <asp:ListItem Value="1">1 Hour</asp:ListItem>
                            <asp:ListItem Value="2" Selected="True">2 Hours</asp:ListItem>
                            <asp:ListItem Value="3">3 Hours</asp:ListItem>
                            <asp:ListItem Value="4">4 Hours</asp:ListItem>
                            <asp:ListItem Value="5">5 Hours</asp:ListItem>
                        </asp:DropDownList>
                    </div>

                    <div class="form-group">
                        <label class="form-label">Total Amount Payable</label>
                        <div style="padding: 10px 14px; background: rgba(59, 130, 246, 0.08); border: 1px solid rgba(59, 130, 246, 0.3); border-radius: var(--radius-sm); font-size: 1.25rem; color: var(--accent-primary); font-weight: 800; height: 45px; display: flex; align-items: center;">
                            &#8377;<asp:Label ID="lblTotalAmount" runat="server" Text="0"></asp:Label>
                        </div>
                    </div>
                </div>

                <div style="margin-top: 2rem;">
                    <asp:Button ID="btnConfirmBooking" runat="server" Text="Confirm Station Reservation" CssClass="btn-cyber" style="width: 100%; padding: 12px; font-size: 1rem;" OnClick="btnConfirmBooking_Click" />
                </div>
            </div>
        </div>
    </section>

</asp:Content>

<asp:Content ID="ScriptsBooking" ContentPlaceHolderID="ScriptsExtra" runat="server">
</asp:Content>

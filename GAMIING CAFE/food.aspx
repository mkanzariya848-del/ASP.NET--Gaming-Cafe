<%@ Page Title="Food & Cafe Menu - CyberGrid Gaming Cafe" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="food.aspx.cs" Inherits="GAMIING_CAFE.FoodPage" %>

<asp:Content ID="MainContentFood" ContentPlaceHolderID="MainContent" runat="server">

    <section class="section" style="padding-top: 3rem;">
        <div class="section-title-wrap">
            <span class="section-tag"><i class="fa-solid fa-utensils"></i> In-Seat Desk Delivery</span>
            <h2 class="section-title">GAMING CAFE MENU</h2>
        </div>

        <!-- Category Tabs -->
        <div style="display: flex; gap: 10px; overflow-x: auto; padding-bottom: 0.5rem; margin-bottom: 2rem;">
            <asp:Button ID="btnAll" runat="server" Text="All Items" CssClass="btn-cyber food-cat-btn" CommandArgument="All" OnClick="btnFilterCategory_Click" />
            <asp:Button ID="btnSnacks" runat="server" Text="Snacks" CssClass="btn-outline food-cat-btn" CommandArgument="Snacks" OnClick="btnFilterCategory_Click" />
            <asp:Button ID="btnBeverages" runat="server" Text="Beverages" CssClass="btn-outline food-cat-btn" CommandArgument="Beverages" OnClick="btnFilterCategory_Click" />
        </div>

        <!-- Food Menu Grid from tbl_food -->
        <div class="grid-4">
            <asp:Repeater ID="rptFood" runat="server" OnItemCommand="rptFood_ItemCommand">
                <ItemTemplate>
                    <div class="glass-card" style="display: flex; flex-direction: column; justify-content: space-between;">
                        <div>
                            <img src='<%# "assets/images/" + Eval("food_image") %>' style="width: 100%; height: 160px; object-fit: cover; border-radius: var(--radius-sm); border: 1px solid var(--border-subtle);" alt='<%# Eval("food_name") %>' onerror="this.src='assets/images/food_combo.png';" />
                            <div style="margin-top: 10px;">
                                <span class="badge-status status-available"><%# Eval("category") %></span>
                            </div>
                            <h4 style="margin-top: 8px; font-size: 1.05rem;"><%# Eval("food_name") %></h4>
                        </div>
                        <div style="display: flex; justify-content: space-between; align-items: center; margin-top: 1.25rem; border-top: 1px solid var(--border-subtle); padding-top: 0.75rem;">
                            <span style="font-size: 1.15rem; font-weight: 700; color: var(--text-main);">&#8377;<%# Eval("price") %></span>
                            <asp:Button ID="btnOrder" runat="server" Text="Order to Desk" CommandName="cmd_order" CommandArgument='<%# Eval("food_name") %>' CssClass="btn-cyber" style="font-size: 0.82rem; padding: 6px 14px;" />
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>
    </section>

</asp:Content>

<asp:Content ID="ScriptsFood" ContentPlaceHolderID="ScriptsExtra" runat="server">
</asp:Content>

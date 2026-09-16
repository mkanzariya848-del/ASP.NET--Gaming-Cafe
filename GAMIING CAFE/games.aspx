<%@ Page Title="Game Library - CyberGrid Gaming Cafe" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="games.aspx.cs" Inherits="GAMIING_CAFE.GamesPage" %>

<asp:Content ID="MainContentGames" ContentPlaceHolderID="MainContent" runat="server">

    <section class="section" style="padding-top: 3rem;">
        <div class="section-title-wrap">
            <span class="section-tag"><i class="fa-solid fa-gamepad"></i> Pre-Installed Library</span>
            <h2 class="section-title">EXPLORE GAME LIBRARY</h2>
        </div>

        <!-- Search Bar -->
        <div class="glass-card" style="margin-bottom: 2rem; padding: 1.25rem 1.5rem; display: flex; gap: 1rem; align-items: center; flex-wrap: wrap;">
            <div style="flex: 1; min-width: 260px;">
                <asp:TextBox ID="txtGameSearch" runat="server" CssClass="form-control" placeholder="Search by game title, category, or platform..."></asp:TextBox>
            </div>
            <asp:Button ID="btnGameSearch" runat="server" Text="Search Games" CssClass="btn-cyber" OnClick="btnGameSearch_Click" />
            <asp:Button ID="btnReset" runat="server" Text="Reset" CssClass="btn-outline" OnClick="btnReset_Click" />
        </div>

        <!-- Category Filter Tabs -->
        <div style="display: flex; gap: 10px; overflow-x: auto; padding-bottom: 0.5rem; margin-bottom: 2rem;">
            <asp:Button ID="btnAllGames" runat="server" Text="All Games" CssClass="btn-cyber game-cat-btn" CommandArgument="All" OnClick="btnPlatform_Click" />
            <asp:Button ID="btnPCGames" runat="server" Text="PC Titles" CssClass="btn-outline game-cat-btn" CommandArgument="PC" OnClick="btnPlatform_Click" />
            <asp:Button ID="btnPS5Games" runat="server" Text="PS5 / Console" CssClass="btn-outline game-cat-btn" CommandArgument="PS5" OnClick="btnPlatform_Click" />
            <asp:Button ID="btnVRGames" runat="server" Text="VR Games" CssClass="btn-outline game-cat-btn" CommandArgument="VR" OnClick="btnPlatform_Click" />
        </div>

        <!-- Games Grid from tbl_games -->
        <div class="grid-4">
            <asp:Repeater ID="rptGames" runat="server">
                <ItemTemplate>
                    <div class="glass-card" style="display: flex; flex-direction: column; justify-content: space-between;">
                        <div>
                            <img src='<%# "assets/images/" + Eval("game_image") %>' style="width: 100%; height: 160px; object-fit: cover; border-radius: var(--radius-sm); border: 1px solid var(--border-subtle);" alt='<%# Eval("game_name") %>' onerror="this.src='assets/images/pc_lounge.png';" />
                            <div style="margin-top: 10px; display: flex; align-items: center; justify-content: space-between;">
                                <span class="badge-status status-available"><%# Eval("platform") %></span>
                                <span style="font-size: 0.8rem; color: var(--text-muted);"><%# Eval("category") %></span>
                            </div>
                            <h4 style="margin: 10px 0 6px 0; font-size: 1.05rem;"><%# Eval("game_name") %></h4>
                        </div>
                        <div style="margin-top: 1.25rem; border-top: 1px solid var(--border-subtle); padding-top: 0.75rem;">
                            <a href="booking.aspx" class="btn-cyber" style="width: 100%; text-align: center; display: block; font-size: 0.85rem; padding: 7px 0;">Book Station to Play</a>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>
    </section>

</asp:Content>

<asp:Content ID="ScriptsGames" ContentPlaceHolderID="ScriptsExtra" runat="server">
</asp:Content>

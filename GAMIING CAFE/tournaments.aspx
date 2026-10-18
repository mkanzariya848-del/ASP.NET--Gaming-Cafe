<%@ Page Title="Esports Tournaments - CyberGrid Gaming Cafe" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="tournaments.aspx.cs" Inherits="GAMIING_CAFE.TournamentsPage" %>

<asp:Content ID="MainContentTournaments" ContentPlaceHolderID="MainContent" runat="server">

    <section class="section" style="padding-top: 3rem;">
        <div class="section-title-wrap">
            <span class="section-tag"><i class="fa-solid fa-trophy"></i> Esports Arenas & Leaderboards</span>
            <h2 class="section-title">UPCOMING TOURNAMENTS</h2>
        </div>

        <!-- Tournaments Grid from tbl_tournament -->
        <div class="grid-3" style="margin-bottom: 3.5rem;">
            <asp:Repeater ID="rptTournaments" runat="server" OnItemCommand="rptTournaments_ItemCommand">
                <ItemTemplate>
                    <div class="glass-card" style="display: flex; flex-direction: column; justify-content: space-between;">
                        <div>
                            <span class="badge-status status-available">REGISTRATION OPEN</span>
                            <h3 style="margin-top: 12px; font-size: 1.25rem;"><%# Eval("tour_name") %></h3>
                            <p style="color: var(--text-muted); font-size: 0.88rem; margin: 8px 0 16px 0;">Official Game: <strong style="color: var(--text-main);"><%# Eval("game_name") %></strong></p>
                            
                            <div style="background: rgba(255,255,255,0.03); border: 1px solid var(--border-light); border-radius: var(--radius-sm); padding: 12px; margin-bottom: 1rem;">
                                <div style="font-size: 0.75rem; color: var(--text-muted); text-transform: uppercase;">Prize Pool</div>
                                <div style="font-size: 1.6rem; font-weight: 800; color: var(--accent-primary);">&#8377;<%# Eval("prize_pool") %></div>
                            </div>
                            
                            <p style="font-size: 0.85rem; color: var(--text-muted); display: flex; align-items: center; justify-content: space-between;">
                                <span><i class="fa-solid fa-calendar-days" style="color: var(--accent-primary); margin-right: 5px;"></i> <%# Eval("tour_date") %></span>
                                <span>Entry: <strong style="color: var(--text-main);">&#8377;<%# Eval("entry_fee") %></strong></span>
                            </p>
                        </div>
                        
                        <div style="margin-top: 1.25rem; border-top: 1px solid var(--border-subtle); padding-top: 1rem;">
                            <asp:Button ID="btnRegisterTour" runat="server" Text="Register Solo / Team" CommandName="cmd_register" CommandArgument='<%# Eval("tour_name") %>' CssClass="btn-cyber" style="width: 100%; font-size: 0.88rem; padding: 8px 0;" />
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>

        <!-- Leaderboard Section -->
        <div class="glass-card">
            <div style="display: flex; align-items: center; gap: 10px; margin-bottom: 1.25rem;">
                <i class="fa-solid fa-trophy" style="color: var(--accent-amber); font-size: 1.4rem;"></i>
                <h3 style="font-size: 1.25rem; margin: 0;">Café Monthly Leaderboard</h3>
            </div>
            
            <div style="overflow-x: auto;">
                <table style="width: 100%; border-collapse: collapse;">
                    <thead>
                        <tr>
                            <th>Rank</th>
                            <th>Gamer Tag</th>
                            <th>Favorite Title</th>
                            <th>Gaming Hours</th>
                            <th>Reward Points</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td><span style="font-weight: 700; color: var(--accent-amber);">#1</span></td>
                            <td><strong style="color: #fff;">Alex Mercer</strong></td>
                            <td>Valorant</td>
                            <td>142 Hrs</td>
                            <td><span style="color: var(--accent-primary); font-weight: 600;">4,850 pts</span></td>
                        </tr>
                        <tr>
                            <td><span style="font-weight: 700; color: #94a3b8;">#2</span></td>
                            <td><strong style="color: #fff;">Viper_99</strong></td>
                            <td>Tekken 8</td>
                            <td>118 Hrs</td>
                            <td><span style="color: var(--accent-primary); font-weight: 600;">3,400 pts</span></td>
                        </tr>
                        <tr>
                            <td><span style="font-weight: 700; color: #cd7f32;">#3</span></td>
                            <td><strong style="color: #fff;">GhostRider</strong></td>
                            <td>Cyberpunk 2077</td>
                            <td>94 Hrs</td>
                            <td><span style="color: var(--accent-primary); font-weight: 600;">2,910 pts</span></td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </section>

</asp:Content>

<asp:Content ID="ScriptsTournaments" ContentPlaceHolderID="ScriptsExtra" runat="server">
</asp:Content>

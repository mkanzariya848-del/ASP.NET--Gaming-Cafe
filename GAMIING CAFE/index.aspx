<%@ Page Title="CyberGrid - Next-Gen Gaming Cafe & Esports Lounge" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="index.aspx.cs" Inherits="GAMIING_CAFE.IndexPage" %>

<asp:Content ID="MetaContentIndex" ContentPlaceHolderID="MetaContent" runat="server">
    <meta name="description" content="Book high-end gaming PCs, PS5 consoles, and offline game tables at CyberGrid Gaming Cafe. Real-time availability, food ordering, and premium memberships." />
</asp:Content>

<asp:Content ID="MainContentIndex" ContentPlaceHolderID="MainContent" runat="server">

    <!-- Hero Section -->
    <section class="hero-section">
        <div class="hero-overlay"></div>
        <div class="hero-content">
            <span class="section-tag"><i class="fa-solid fa-gamepad"></i> Next-Gen Esports Lounge</span>
            <h1 class="hero-title">NEXT-GEN <span class="brand-span">GAMING CAFE</span> EXPERIENCE</h1>
            <p class="hero-subtitle">
                Book RTX 5090 High-End Gaming PCs, PS5 Consoles, and Classic Offline Games. Order gourmet food directly to your desk with instant QR access.
            </p>
            <div style="display: flex; gap: 1rem; justify-content: center; flex-wrap: wrap;">
                <a href="booking.aspx" class="btn-cyber"><i class="fa-solid fa-calendar-check"></i> Book Station Now</a>
                <a href="games.aspx" class="btn-outline"><i class="fa-solid fa-headset"></i> Browse Games</a>
                <a href="food.aspx" class="btn-outline"><i class="fa-solid fa-utensils"></i> Cafe Menu</a>
                <a href="memberships.aspx" class="btn-outline"><i class="fa-solid fa-crown text-yellow"></i> VIP Perks</a>
            </div>
        </div>
    </section>

    <!-- Live Device Availability Bar -->
    <div class="live-counter-bar">
        <div class="counter-card">
            <div class="counter-icon"><i class="fa-solid fa-desktop"></i></div>
            <div>
                <div class="counter-num text-cyan"><asp:Label ID="lblPcAvail" runat="server" Text="0"></asp:Label></div>
                <div class="counter-label"><span style="width: 8px; height: 8px; border-radius: 50%; background: #10b981; display: inline-block; margin-right: 5px;"></span>Online PCs Available</div>
            </div>
        </div>

        <div class="counter-card">
            <div class="counter-icon" style="background: rgba(139, 92, 246, 0.12); border-color: rgba(139, 92, 246, 0.25); color: var(--accent-purple);"><i class="fa-solid fa-gamepad"></i></div>
            <div>
                <div class="counter-num text-purple"><asp:Label ID="lblConsoleAvail" runat="server" Text="0"></asp:Label></div>
                <div class="counter-label"><span style="width: 8px; height: 8px; border-radius: 50%; background: #10b981; display: inline-block; margin-right: 5px;"></span>Consoles Available</div>
            </div>
        </div>

        <div class="counter-card">
            <div class="counter-icon" style="background: rgba(245, 158, 11, 0.12); border-color: rgba(245, 158, 11, 0.25); color: var(--accent-amber);"><i class="fa-solid fa-chess"></i></div>
            <div>
                <div class="counter-num text-yellow"><asp:Label ID="lblOfflineAvail" runat="server" Text="0"></asp:Label></div>
                <div class="counter-label"><span style="width: 8px; height: 8px; border-radius: 50%; background: #10b981; display: inline-block; margin-right: 5px;"></span>Offline Tables Ready</div>
            </div>
        </div>
    </div>

    <!-- Gaming Categories Section -->
    <section class="section">
        <div class="section-title-wrap">
            <span class="section-tag">Choose Your Battleground</span>
            <h2 class="section-title">GAMING CATEGORIES</h2>
        </div>

        <div class="grid-3">
            <div class="glass-card">
                <div style="font-size: 2.2rem; color: var(--accent-primary); margin-bottom: 1rem;"><i class="fa-solid fa-desktop"></i></div>
                <h3 style="margin-bottom: 0.5rem;">Online Gaming PCs</h3>
                <p style="color: var(--text-muted); margin-bottom: 1.5rem; font-size: 0.92rem;">
                    Intel i9 14900K, RTX 5090 graphics, 360Hz ROG gaming displays, mechanical switches, and ultra-low latency fiber internet.
                </p>
                <div style="display: flex; justify-content: space-between; align-items: center; border-top: 1px solid var(--border-subtle); padding-top: 1rem;">
                    <span style="font-weight: 700; font-size: 1.1rem; color: var(--text-main);">From &#8377;100<span style="font-size: 0.8rem; color: var(--text-muted); font-weight: 400;">/hr</span></span>
                    <a href="booking.aspx" class="btn-cyber" style="padding: 6px 16px; font-size: 0.85rem;">Book PC</a>
                </div>
            </div>

            <div class="glass-card">
                <div style="font-size: 2.2rem; color: var(--accent-purple); margin-bottom: 1rem;"><i class="fa-solid fa-gamepad"></i></div>
                <h3 style="margin-bottom: 0.5rem;">Console Gaming Lounges</h3>
                <p style="color: var(--text-muted); margin-bottom: 1.5rem; font-size: 0.92rem;">
                    PlayStation 5, Xbox Series X, Nintendo Switch on 75" 4K 120Hz OLED TVs with plush leather recliners & surround sound.
                </p>
                <div style="display: flex; justify-content: space-between; align-items: center; border-top: 1px solid var(--border-subtle); padding-top: 1rem;">
                    <span style="font-weight: 700; font-size: 1.1rem; color: var(--text-main);">From &#8377;140<span style="font-size: 0.8rem; color: var(--text-muted); font-weight: 400;">/hr</span></span>
                    <a href="booking.aspx" class="btn-cyber" style="padding: 6px 16px; font-size: 0.85rem; background: var(--accent-purple);">Book Console</a>
                </div>
            </div>

            <div class="glass-card">
                <div style="font-size: 2.2rem; color: var(--accent-amber); margin-bottom: 1rem;"><i class="fa-solid fa-chess"></i></div>
                <h3 style="margin-bottom: 0.5rem;">Offline Board Games</h3>
                <p style="color: var(--text-muted); margin-bottom: 1.5rem; font-size: 0.92rem;">
                    Professional Carrom, Staunton Chess, Foosball, Table Tennis, UNO, Monopoly, and Jenga tables for group leisure.
                </p>
                <div style="display: flex; justify-content: space-between; align-items: center; border-top: 1px solid var(--border-subtle); padding-top: 1rem;">
                    <span style="font-weight: 700; font-size: 1.1rem; color: var(--text-main);">From &#8377;50<span style="font-size: 0.8rem; color: var(--text-muted); font-weight: 400;">/hr</span></span>
                    <a href="booking.aspx" class="btn-outline" style="padding: 6px 16px; font-size: 0.85rem;">Book Table</a>
                </div>
            </div>
        </div>
    </section>

    <!-- Featured PCs & Consoles Showcase -->
    <section class="section" style="background: rgba(17, 23, 38, 0.4); border-top: 1px solid var(--border-subtle); border-bottom: 1px solid var(--border-subtle);">
        <div class="section-title-wrap">
            <span class="section-tag">Rig Specifications & Pricing</span>
            <h2 class="section-title">FEATURED GAMING STATIONS</h2>
        </div>

        <div class="grid-3">
            <!-- High End PC -->
            <div class="glass-card">
                <img src="assets/images/pc_01.jpg" class="device-card-img" alt="High End PC" onerror="this.src='assets/images/pc_lounge.png';">
                <span class="badge-status status-available">VIP RGB ZONE A</span>
                <h3 style="margin-top: 10px; font-size: 1.15rem;">High-End Gaming PC</h3>
                <ul class="device-specs-list">
                    <li><i class="fa-solid fa-microchip" style="color: var(--accent-primary);"></i> Intel Core i9 14900K</li>
                    <li><i class="fa-solid fa-memory" style="color: var(--accent-purple);"></i> RTX 5090 + 64GB DDR5 RAM</li>
                    <li><i class="fa-solid fa-tv" style="color: var(--accent-cyan);"></i> 360Hz ROG Swift Monitor</li>
                </ul>
                <div style="display: flex; justify-content: space-between; align-items: center; margin-top: 1.25rem; border-top: 1px solid var(--border-subtle); padding-top: 1rem;">
                    <div class="device-price">&#8377;250<span style="font-size: 0.8rem; color: var(--text-muted); font-weight: 400;">/hr</span></div>
                    <a href="booking.aspx" class="btn-cyber" style="font-size: 0.85rem; padding: 6px 16px;">Reserve</a>
                </div>
            </div>

            <!-- Mid Level PC -->
            <div class="glass-card">
                <img src="assets/images/pc_03.jpg" class="device-card-img" alt="Mid Level PC" onerror="this.src='assets/images/pc_lounge.png';">
                <span class="badge-status status-available">MAIN ARENA ZONE B</span>
                <h3 style="margin-top: 10px; font-size: 1.15rem;">Mid-Level Gaming PC</h3>
                <ul class="device-specs-list">
                    <li><i class="fa-solid fa-microchip" style="color: var(--accent-primary);"></i> Intel Core i5 13600K</li>
                    <li><i class="fa-solid fa-memory" style="color: var(--accent-purple);"></i> RTX 4060 + 16GB DDR4 RAM</li>
                    <li><i class="fa-solid fa-tv" style="color: var(--accent-cyan);"></i> 165Hz Curved Monitor</li>
                </ul>
                <div style="display: flex; justify-content: space-between; align-items: center; margin-top: 1.25rem; border-top: 1px solid var(--border-subtle); padding-top: 1rem;">
                    <div class="device-price">&#8377;150<span style="font-size: 0.8rem; color: var(--text-muted); font-weight: 400;">/hr</span></div>
                    <a href="booking.aspx" class="btn-cyber" style="font-size: 0.85rem; padding: 6px 16px;">Reserve</a>
                </div>
            </div>

            <!-- Console Lounge PS5 -->
            <div class="glass-card">
                <img src="assets/images/ps5_01.jpg" class="device-card-img" alt="PS5 Lounge" onerror="this.src='assets/images/console_lounge.png';">
                <span class="badge-status status-available">CONSOLE LOUNGE 1</span>
                <h3 style="margin-top: 10px; font-size: 1.15rem;">PlayStation 5 Lounge</h3>
                <ul class="device-specs-list">
                    <li><i class="fa-solid fa-gamepad" style="color: var(--accent-purple);"></i> DualSense Wireless Controllers</li>
                    <li><i class="fa-solid fa-tv" style="color: var(--accent-cyan);"></i> 75" 4K 120Hz OLED TV</li>
                    <li><i class="fa-solid fa-couch" style="color: var(--accent-amber);"></i> Luxury Leather Recliners</li>
                </ul>
                <div style="display: flex; justify-content: space-between; align-items: center; margin-top: 1.25rem; border-top: 1px solid var(--border-subtle); padding-top: 1rem;">
                    <div class="device-price">&#8377;200<span style="font-size: 0.8rem; color: var(--text-muted); font-weight: 400;">/hr</span></div>
                    <a href="booking.aspx" class="btn-cyber" style="font-size: 0.85rem; padding: 6px 16px; background: var(--accent-purple);">Reserve</a>
                </div>
            </div>
        </div>
    </section>

    <!-- Gourmet Food & Beverage Highlight -->
    <section class="section">
        <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(320px, 1fr)); gap: 3rem; align-items: center;">
            <div>
                <span class="section-tag"><i class="fa-solid fa-utensils"></i> In-Seat Cafe Ordering</span>
                <h2 class="section-title" style="margin-bottom: 1.2rem;">GOURMET SNACKS & ENERGY BOOSTS</h2>
                <p style="color: var(--text-muted); margin-bottom: 1.75rem; font-size: 1rem; line-height: 1.7;">
                    Order hot pepperoni pizza, crispy peri-peri fries, gourmet burgers, cheese maggi, cold coffee, and chilled energy drinks directly to your gaming desk without pausing your match.
                </p>
                <div style="display: flex; gap: 1rem; flex-wrap: wrap;">
                    <a href="food.aspx" class="btn-cyber"><i class="fa-solid fa-utensils"></i> Explore Full Menu</a>
                    <a href="memberships.aspx" class="btn-outline"><i class="fa-solid fa-crown text-yellow"></i> Membership Discounts</a>
                </div>
            </div>
            <div>
                <img src="assets/images/food_pizza.jpg" style="width: 100%; border-radius: var(--radius-lg); border: 1px solid var(--border-light); box-shadow: var(--shadow-lg);" alt="Gaming Food Combo" onerror="this.src='assets/images/food_combo.png';">
            </div>
        </div>
    </section>

</asp:Content>

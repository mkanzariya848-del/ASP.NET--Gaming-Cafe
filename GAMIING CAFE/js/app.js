/* 
  Global Application Controller & UI Renderer
  CyberGrid Gaming Café - Clean Modern UI
*/

document.addEventListener('DOMContentLoaded', () => {
  initApp();
});

let appData = getCafeData();

function initApp() {
  renderNavbar();
  renderRoleBanner();
  setupEventListeners();
  updateLiveCounters();
}

function renderNavbar() {
  appData = getCafeData(); // reload fresh state
  const loggedInUser = getLoggedInUser();
  const currentRole = loggedInUser ? loggedInUser.role : (appData.currentUserRole || 'customer');
  
  const navHeaderHtml = `
    <nav class="navbar">
      <a href="index.aspx" class="navbar-brand">
        <div class="brand-icon-wrap"><i class="fa-solid fa-gamepad"></i></div>
        <span>CYBER<span class="brand-span">GRID</span></span>
      </a>

      <ul class="nav-links">
        <li><a href="index.aspx" class="nav-link ${isActivePage('index')}"><i class="fa-solid fa-house"></i> Home</a></li>
        <li><a href="booking.aspx" class="nav-link ${isActivePage('booking')}"><i class="fa-solid fa-calendar-check"></i> Book Station</a></li>
        <li><a href="games.aspx" class="nav-link ${isActivePage('games')}"><i class="fa-solid fa-headset"></i> Games</a></li>
        <li><a href="food.aspx" class="nav-link ${isActivePage('food')}"><i class="fa-solid fa-utensils"></i> Food & Cafe</a></li>
        <li><a href="memberships.aspx" class="nav-link ${isActivePage('memberships')}"><i class="fa-solid fa-crown"></i> Memberships</a></li>
        <li><a href="tournaments.aspx" class="nav-link ${isActivePage('tournaments')}"><i class="fa-solid fa-trophy"></i> Tournaments</a></li>
      </ul>

      <div class="nav-actions">
        <!-- Compact Role Switcher -->
        <div class="role-switcher" title="Quick Role Switcher">
          <button class="role-btn ${currentRole === 'customer' ? 'active' : ''}" onclick="switchRole('customer')">Customer</button>
          <button class="role-btn ${currentRole === 'staff' ? 'active' : ''}" onclick="switchRole('staff')">Staff</button>
          <button class="role-btn ${currentRole === 'admin' ? 'active' : ''}" onclick="switchRole('admin')">Admin</button>
        </div>

        ${loggedInUser ? `
          <a href="${getRoleDashboardUrl(currentRole)}" class="user-nav-badge">
            <div class="user-nav-avatar"><i class="fa-solid ${getDashboardIcon(currentRole)}"></i></div>
            <span>${escapeHtml(loggedInUser.name.split(' ')[0])}</span>
          </a>
          <a href="booking.aspx" class="btn-cyber" style="padding: 6px 14px; font-size: 0.85rem;">
            <i class="fa-solid fa-plus"></i> Book
          </a>
          <button class="btn-outline" style="padding: 5px 12px; font-size: 0.82rem;" onclick="handleLogout()" title="Log out">
            <i class="fa-solid fa-right-from-bracket"></i>
          </button>
        ` : `
          <a href="login.aspx" class="btn-outline" style="padding: 6px 14px; font-size: 0.85rem;">
            <i class="fa-solid fa-right-to-bracket"></i> Login
          </a>
          <a href="booking.aspx" class="btn-cyber" style="padding: 6px 14px; font-size: 0.85rem;">
            <i class="fa-solid fa-plus"></i> Book
          </a>
        `}
      </div>
    </nav>
  `;

  const navContainer = document.getElementById('navbar-container');
  if (navContainer) {
    navContainer.innerHTML = navHeaderHtml;
  }
}

function escapeHtml(str) {
  if (!str) return '';
  return String(str).replace(/[&<>"']/g, function(m) {
    return { '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;', "'": '&#39;' }[m];
  });
}

function isActivePage(pageName) {
  const currentPath = window.location.pathname.toLowerCase();
  if (pageName === 'index' && (currentPath === '/' || currentPath.endsWith('/') || currentPath.includes('index'))) {
    return 'active';
  }
  return currentPath.includes(pageName) ? 'active' : '';
}

function getRoleDashboardUrl(role) {
  if (role === 'staff') return 'staff-dashboard.aspx';
  if (role === 'admin') return 'admin-dashboard.aspx';
  return 'customer-dashboard.aspx';
}

function getDashboardIcon(role) {
  if (role === 'staff') return 'fa-user-gear';
  if (role === 'admin') return 'fa-sliders';
  return 'fa-user';
}

function handleLogout() {
  dbLogoutUser();
  window.location.href = 'logout.aspx';
}

function switchRole(newRole) {
  const data = getCafeData();
  data.currentUserRole = newRole;
  // find demo user matching role
  const matchUser = data.users.find(u => u.role === newRole);
  if (matchUser) {
    data.activeSession = { isLoggedIn: true, userEmail: matchUser.email };
    data.currentUser = matchUser;
  }
  saveCafeData(data);
  // Removed role switch toast popup
  renderNavbar();
  renderRoleBanner();
  
  if (window.location.pathname.includes('dashboard')) {
    window.location.href = getRoleDashboardUrl(newRole);
  }
}

function renderRoleBanner() {
  const data = getCafeData();
  const role = data.currentUserRole || 'customer';
  const banner = document.getElementById('role-indicator-banner');
  if (!banner) return;

  if (role === 'admin') {
    banner.style.display = 'block';
    banner.innerHTML = `<div class="role-banner-clean role-banner-admin">
      <i class="fa-solid fa-shield-halved"></i> <span>Logged in as <strong>ADMIN</strong> &mdash; Full system control active</span>
    </div>`;
  } else if (role === 'staff') {
    banner.style.display = 'block';
    banner.innerHTML = `<div class="role-banner-clean role-banner-staff">
      <i class="fa-solid fa-user-shield"></i> <span>Logged in as <strong>STAFF</strong> &mdash; Station operations & kitchen dispatch active</span>
    </div>`;
  } else {
    banner.style.display = 'none';
  }
}

function showToast(message, type = 'success') {
  // Completely disabled pop-up toast notifications as requested
  const existing = document.getElementById('toast-container');
  if (existing) existing.remove();
  return;
}

function updateLiveCounters() {
  const data = getCafeData();
  const devices = data.devices || [];
  const availPc = devices.filter(d => d.categoryId === 'cat-online' && d.status === 'Available').length;
  const availConsole = devices.filter(d => d.categoryId === 'cat-console' && d.status === 'Available').length;
  const availOffline = devices.filter(d => d.categoryId === 'cat-offline' && d.status === 'Available').length;

  const pcElem = document.getElementById('count-pc-avail');
  if (pcElem) pcElem.textContent = availPc;

  const consoleElem = document.getElementById('count-console-avail');
  if (consoleElem) consoleElem.textContent = availConsole;

  const offlineElem = document.getElementById('count-offline-avail');
  if (offlineElem) offlineElem.textContent = availOffline;
}

function setupEventListeners() {
  document.querySelectorAll('.modal-backdrop').forEach(modal => {
    modal.addEventListener('click', (e) => {
      if (e.target === modal) {
        modal.classList.remove('active');
      }
    });
  });
}

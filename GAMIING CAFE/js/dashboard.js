/* 
  Dashboards & Analytics Controller (Customer, Staff, Admin)
*/

document.addEventListener('DOMContentLoaded', () => {
  if (document.getElementById('customer-dashboard-view')) {
    initCustomerDashboard();
  }
  if (document.getElementById('staff-dashboard-view')) {
    initStaffDashboard();
  }
  if (document.getElementById('admin-dashboard-view')) {
    initAdminDashboard();
  }
});

// --- CUSTOMER DASHBOARD ---
function initCustomerDashboard() {
  renderActiveSessionTimer();
  renderCustomerBookings();
}

function renderActiveSessionTimer() {
  const container = document.getElementById('active-session-widget');
  if (!container) return;

  const hfBookingId = document.querySelector('[id$="hfBookingId"]');
  const hfStation = document.querySelector('[id$="hfStationName"]');
  const hfHours = document.querySelector('[id$="hfDurationHours"]');
  const hfTotal = document.querySelector('[id$="hfTotalAmount"]');
  const hfStatus = document.querySelector('[id$="hfBookingStatus"]');

  const bookingId = (hfBookingId && hfBookingId.value) ? hfBookingId.value : '1';
  const stationName = (hfStation && hfStation.value) ? hfStation.value : 'Station PC-01 (VIP Zone A)';
  const durationHours = (hfHours && hfHours.value && !isNaN(hfHours.value)) ? parseFloat(hfHours.value) : 1;
  const totalAmount = (hfTotal && hfTotal.value) ? hfTotal.value : '100';
  const status = (hfStatus && hfStatus.value) ? hfStatus.value : 'Confirmed';

  // If no booking found (duration 0)
  if (durationHours <= 0) {
    container.innerHTML = `
      <div class="glass-card" style="border-color: var(--border-subtle); padding: 1.75rem; text-align: center;">
        <i class="fa-solid fa-gamepad" style="font-size: 2.2rem; color: var(--accent-primary); margin-bottom: 0.75rem; display: block; opacity: 0.7;"></i>
        <h3 style="font-size: 1.25rem; margin-bottom: 6px;">No Live Session In-Progress</h3>
        <p style="color: var(--text-muted); font-size: 0.88rem; margin-bottom: 1.25rem;">You do not have any active station booking right now. Reserve a station to start your timer!</p>
        <a href="booking.aspx" class="btn-cyber" style="font-size: 0.85rem; padding: 7px 18px; display: inline-flex; align-items: center; gap: 6px;">
          <i class="fa-solid fa-plus"></i> Book a Station Now
        </a>
      </div>
    `;
    return;
  }

  // Persistent timer tracking key in localStorage
  const storageKey = 'live_timer_bk_' + bookingId;
  let timerStart = localStorage.getItem(storageKey);
  const now = Math.floor(Date.now() / 1000);

  if (!timerStart) {
    timerStart = now;
    localStorage.setItem(storageKey, timerStart);
  } else {
    timerStart = parseInt(timerStart, 10);
  }

  // Total seconds paid by user (e.g. 1 hr = 3600, 2 hrs = 7200)
  const extensionSeconds = parseInt(localStorage.getItem(storageKey + '_ext') || '0', 10);
  const totalSeconds = Math.max(Math.round(durationHours * 3600) + extensionSeconds, 60);

  let elapsed = now - timerStart;
  let secondsRemaining = totalSeconds - elapsed;
  if (secondsRemaining < 0) {
    secondsRemaining = 0;
  }

  function formatTime(secs) {
    const hrs = Math.floor(secs / 3600);
    const mins = Math.floor((secs % 3600) / 60);
    const s = secs % 60;
    if (hrs > 0) {
      return `${hrs.toString().padStart(2, '0')}:${mins.toString().padStart(2, '0')}:${s.toString().padStart(2, '0')}`;
    }
    return `${mins.toString().padStart(2, '0')}:${s.toString().padStart(2, '0')}`;
  }

  function escapeText(str) {
    if (!str) return '';
    return String(str).replace(/[&<>"']/g, m => ({ '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;', "'": '&#39;' })[m]);
  }

  const isExpired = secondsRemaining <= 0;
  const statusBadge = isExpired
    ? `<span class="badge-status status-occupied" style="background: rgba(239, 68, 68, 0.15); color: #f87171; border: 1px solid rgba(239, 68, 68, 0.3);"><i class="fa-solid fa-clock"></i> SESSION EXPIRED</span>`
    : `<span class="badge-status status-available" style="background: rgba(16, 185, 129, 0.15); color: #34d399; border: 1px solid rgba(16, 185, 129, 0.3);"><i class="fa-solid fa-play"></i> LIVE SESSION IN-PROGRESS</span>`;

  container.innerHTML = `
    <div class="glass-card" style="border-color: rgba(59, 130, 246, 0.35); box-shadow: 0 4px 20px rgba(59, 130, 246, 0.12);">
      <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 1.25rem; flex-wrap: wrap; gap: 12px;">
        <div>
          ${statusBadge}
          <h3 style="margin-top: 8px; font-size: 1.35rem; color: #f8fafc; display: flex; align-items: center; gap: 8px;">
            <i class="fa-solid fa-gamepad" style="color: var(--accent-primary);"></i> ${escapeText(stationName)}
          </h3>
          <p style="font-size: 0.82rem; color: var(--text-muted); margin-top: 2px;">
            Booking #${bookingId} &bull; Paid for <strong>${durationHours} ${durationHours === 1 ? 'Hour' : 'Hours'}</strong> &bull; Total Paid: <strong style="color: #34d399;">&#8377;${totalAmount}</strong>
          </p>
        </div>
        <button type="button" class="btn-cyber" style="font-size: 0.82rem; padding: 7px 14px;" onclick="extendLiveSession('${bookingId}')">
          <i class="fa-solid fa-clock-rotate-left"></i> Extend Session (+1 Hr)
        </button>
      </div>

      <div style="display: flex; align-items: center; justify-content: space-around; background: rgba(8, 12, 20, 0.85); padding: 1.5rem; border-radius: var(--radius-md); border: 1px solid rgba(255, 255, 255, 0.05); flex-wrap: wrap; gap: 1rem;">
        <div style="text-align: center;">
          <div style="font-size: 0.78rem; color: var(--text-muted); text-transform: uppercase; letter-spacing: 0.5px;">Time Remaining</div>
          <div id="countdown-timer-display" style="font-family: ui-monospace, SFMono-Regular, Menlo, Monaco, Consolas, monospace; font-size: 2.8rem; color: ${isExpired ? '#fb7185' : '#60a5fa'}; font-weight: 800; letter-spacing: 1px; margin-top: 4px;">
            ${formatTime(secondsRemaining)}
          </div>
        </div>
        <div style="height: 50px; width: 1px; background: rgba(255, 255, 255, 0.08);"></div>
        <div style="text-align: center;">
          <div style="font-size: 0.78rem; color: var(--text-muted); text-transform: uppercase; letter-spacing: 0.5px;">Paid Duration</div>
          <div style="font-family: var(--font-heading); font-size: 1.8rem; color: #f8fafc; font-weight: 700; margin-top: 4px;">${durationHours} Hrs</div>
        </div>
        <div style="height: 50px; width: 1px; background: rgba(255, 255, 255, 0.08);"></div>
        <div style="text-align: center;">
          <div style="font-size: 0.78rem; color: var(--text-muted); text-transform: uppercase; letter-spacing: 0.5px;">Total Amount Paid</div>
          <div style="font-family: var(--font-heading); font-size: 1.8rem; color: #34d399; font-weight: 700; margin-top: 4px;">&#8377;${totalAmount}</div>
        </div>
      </div>
    </div>
  `;

  if (window.activeSessionTimerInterval) {
    clearInterval(window.activeSessionTimerInterval);
  }

  if (!isExpired) {
    window.activeSessionTimerInterval = setInterval(() => {
      if (secondsRemaining > 0) {
        secondsRemaining--;
        const display = document.getElementById('countdown-timer-display');
        if (display) {
          display.textContent = formatTime(secondsRemaining);
          if (secondsRemaining < 300) {
            display.style.color = '#fb7185';
          }
        }
      } else {
        const display = document.getElementById('countdown-timer-display');
        if (display) {
          display.textContent = '00:00:00';
          display.style.color = '#fb7185';
        }
        clearInterval(window.activeSessionTimerInterval);
        renderActiveSessionTimer();
      }
    }, 1000);
  }
}

function extendLiveSession(bookingId) {
  const storageKey = 'live_timer_bk_' + bookingId;
  const currentExt = parseInt(localStorage.getItem(storageKey + '_ext') || '0', 10);
  localStorage.setItem(storageKey + '_ext', currentExt + 3600);
  alert('Session extended by +1 Hour successfully!');
  renderActiveSessionTimer();
}

function renderCustomerBookings() {
  const tbody = document.getElementById('customer-bookings-tbody');
  if (!tbody) return;

  const bookings = appData.bookings || [];
  tbody.innerHTML = bookings.map(bk => `
    <tr style="border-bottom: 1px solid rgba(255,255,255,0.05);">
      <td style="padding: 12px;"><strong class="text-cyan">${bk.id}</strong></td>
      <td style="padding: 12px;">${bk.deviceName}</td>
      <td style="padding: 12px;">${bk.startTime.replace('T', ' ')}</td>
      <td style="padding: 12px;">${bk.durationHours} Hours</td>
      <td style="padding: 12px;">&#8377;${bk.grandTotal || bk.gamingTotal}</td>
      <td style="padding: 12px;"><span class="badge-status status-available">${bk.status}</span></td>
      <td style="padding: 12px;">
        <button class="btn-outline" style="font-size: 0.75rem; padding: 4px 8px;" onclick="window.print()"><i class="fa-solid fa-print"></i> Receipt</button>
      </td>
    </tr>
  `).join('');
}

// --- STAFF DASHBOARD ---
function initStaffDashboard() {
  renderStaffStationGrid();
}

function renderStaffStationGrid() {
  const grid = document.getElementById('staff-station-map');
  if (!grid) return;

  const devices = appData.devices || [];
  grid.innerHTML = devices.map(dev => `
    <div class="glass-card" style="border-color: ${getStationBorderColor(dev.status)}; padding: 1.2rem;">
      <div style="display: flex; justify-content: space-between; align-items: flex-start; margin-bottom: 10px;">
        <div>
          <span class="badge-status status-${dev.status.toLowerCase()}">${dev.status}</span>
          <h4 style="margin-top: 6px;">${dev.number}</h4>
          <p style="font-size: 0.8rem; color: var(--text-muted);">${dev.typeName}</p>
        </div>
        <i class="fa-solid ${getDeviceCategoryIcon(dev.categoryId)}" style="font-size: 1.5rem; color: var(--neon-cyan);"></i>
      </div>

      <div style="font-size: 0.85rem; color: var(--text-dim); margin-bottom: 12px;">
        Zone: ${dev.zone} | &#8377;${dev.hourlyRate}/hr
      </div>

      <div style="display: flex; gap: 6px;">
        ${dev.status === 'Available' ? `
          <button class="btn-cyber" style="font-size: 0.75rem; padding: 4px 8px; flex: 1;" onclick="updateStationStatus('${dev.id}', 'Occupied')">Start Session</button>
        ` : `
          <button class="btn-outline" style="font-size: 0.75rem; padding: 4px 8px; flex: 1; border-color: var(--neon-red); color: var(--neon-red);" onclick="updateStationStatus('${dev.id}', 'Available')">End Session</button>
        `}
        <button class="btn-outline" style="font-size: 0.75rem; padding: 4px 8px;" onclick="updateStationStatus('${dev.id}', 'Maintenance')">Maint.</button>
      </div>
    </div>
  `).join('');
}

function getStationBorderColor(status) {
  if (status === 'Occupied') return 'var(--neon-red)';
  if (status === 'Reserved') return 'var(--neon-cyan)';
  if (status === 'Maintenance') return 'var(--neon-yellow)';
  return 'var(--neon-green)';
}

function getDeviceCategoryIcon(catId) {
  if (catId === 'cat-console') return 'fa-gamepad';
  if (catId === 'cat-offline') return 'fa-chess';
  return 'fa-desktop';
}

function updateStationStatus(deviceId, newStatus) {
  const dev = appData.devices.find(d => d.id === deviceId);
  if (dev) {
    dev.status = newStatus;
    saveCafeData(appData);
    showToast(`Updated ${dev.number} status to ${newStatus}!`, 'info');
    renderStaffStationGrid();
    updateLiveCounters();
  }
}

// --- ADMIN DASHBOARD ---
function initAdminDashboard() {
  renderAdminCharts();
}

function renderAdminCharts() {
  const ctxRevenue = document.getElementById('revenueChart');
  if (ctxRevenue && window.Chart) {
    new Chart(ctxRevenue, {
      type: 'line',
      data: {
        labels: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'],
        datasets: [{
          label: 'Revenue (&#8377;)',
          data: [12500, 14200, 11800, 18500, 24000, 32500, 29800],
          borderColor: '#00f3ff',
          backgroundColor: 'rgba(0, 243, 255, 0.1)',
          fill: true,
          tension: 0.4
        }]
      },
      options: {
        responsive: true,
        plugins: { legend: { labels: { color: '#fff' } } },
        scales: {
          x: { ticks: { color: '#8e9bb4' } },
          y: { ticks: { color: '#8e9bb4' } }
        }
      }
    });
  }

  const ctxCategory = document.getElementById('categorySplitChart');
  if (ctxCategory && window.Chart) {
    new Chart(ctxCategory, {
      type: 'doughnut',
      data: {
        labels: ['Online Gaming PCs', 'Consoles (PS5/Xbox)', 'Offline Games'],
        datasets: [{
          data: [55, 30, 15],
          backgroundColor: ['#00f3ff', '#9d4edd', '#ff007f']
        }]
      },
      options: {
        responsive: true,
        plugins: { legend: { labels: { color: '#fff' } } }
      }
    });
  }
}

function exportReportCSV() {
  let csvContent = "data:text/csv;charset=utf-8,Booking ID,Customer,Device,Category,Amount,Status\n";
  appData.bookings.forEach(b => {
    csvContent += `${b.id},${b.customerName},${b.deviceName},${b.category},${b.grandTotal || b.gamingTotal},${b.status}\n`;
  });
  const encodedUri = encodeURI(csvContent);
  const link = document.createElement("a");
  link.setAttribute("href", encodedUri);
  link.setAttribute("download", "CyberGrid_Revenue_Report.csv");
  document.body.appendChild(link);
  link.click();
  link.remove();
  showToast('Exported Revenue Report to CSV!', 'success');
}

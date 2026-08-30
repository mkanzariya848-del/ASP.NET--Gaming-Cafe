/* 
  Booking Flow & Invoice Engine
*/

const REAL_DEVICE_IMAGES = {
  'DEV-PC-01': 'assets/images/pc_01.jpg',
  'DEV-PC-02': 'assets/images/pc_02.jpg',
  'DEV-PC-03': 'assets/images/pc_03.jpg',
  'DEV-PC-04': 'assets/images/pc_04.jpg',
  'DEV-PC-05': 'assets/images/pc_05.jpg',
  'DEV-CON-01': 'assets/images/ps5_01.jpg?v=2',
  'DEV-CON-02': 'assets/images/ps5_02.jpg?v=2',
  'DEV-CON-03': 'assets/images/xbox_01.png?v=2',
  'DEV-CON-04': 'assets/images/switch_01.jpg?v=2',
  'DEV-OFF-01': 'assets/images/carrom_01.jpg?v=3',
  'DEV-OFF-02': 'assets/images/chess_01.jpg?v=3',
  'DEV-OFF-03': 'assets/images/foosball_01.jpg?v=3',
  'DEV-OFF-04': 'assets/images/tt_01.jpg?v=3',
  'DEV-OFF-05': 'assets/images/pool_01.jpg?v=3',
  'DEV-OFF-06': 'assets/images/airhockey_01.jpg?v=3',
  'DEV-OFF-07': 'assets/images/darts_01.jpg?v=3',
  'DEV-OFF-08': 'assets/images/boardgames_01.jpg?v=3'
};

const REAL_FOOD_IMAGES = {
  'FD-101': 'assets/images/food_pizza.jpg?v=2',
  'FD-102': 'assets/images/food_burger.jpg?v=2',
  'FD-103': 'assets/images/food_fries.jpg?v=2',
  'FD-104': 'assets/images/food_energy.jpg?v=2',
  'FD-105': 'assets/images/food_maggi.jpg?v=2',
  'FD-106': 'assets/images/food_coffee.jpg?v=2',
  'FD-107': 'assets/images/food_sandwich.jpg?v=2',
  'FD-108': 'assets/images/food_brownie.jpg?v=2'
};

let bookingState = {
  currentStep: 1,
  selectedCategory: 'cat-online',
  selectedDevice: null,
  stationSearchQuery: '',
  date: new Date().toISOString().split('T')[0],
  time: '15:00',
  duration: 2,
  selectedFood: [], // { id, name, price, qty }
  coupon: null,
  discountAmount: 0,
  paymentMethod: 'UPI'
};

document.addEventListener('DOMContentLoaded', () => {
  if (document.getElementById('booking-wizard-container')) {
    initBookingWizard();
  }
});

function initBookingWizard() {
  const urlParams = new URLSearchParams(window.location.search);
  if (urlParams.has('cat')) {
    bookingState.selectedCategory = urlParams.get('cat');
  }
  if (urlParams.has('game')) {
    bookingState.stationSearchQuery = urlParams.get('game');
    bookingState.currentStep = 2;
  }
  renderStep(bookingState.currentStep);
}

function nextStep() {
  if (bookingState.currentStep === 1 && !bookingState.selectedCategory) {
    showToast('Please select a gaming category to proceed!', 'warning');
    return;
  }
  if (bookingState.currentStep === 2 && !bookingState.selectedDevice) {
    showToast('Please choose a gaming station or device!', 'warning');
    return;
  }

  bookingState.currentStep++;
  renderStep(bookingState.currentStep);
}

function prevStep() {
  if (bookingState.currentStep > 1) {
    bookingState.currentStep--;
    renderStep(bookingState.currentStep);
  }
}

function renderStep(stepNum) {
  // Update step indicators
  for (let i = 1; i <= 6; i++) {
    const el = document.getElementById(`step-indicator-${i}`);
    if (el) {
      el.classList.remove('active', 'completed');
      if (i === stepNum) el.classList.add('active');
      if (i < stepNum) el.classList.add('completed');
    }
  }

  const contentContainer = document.getElementById('step-content-area');
  if (!contentContainer) return;

  if (stepNum === 1) {
    renderCategoryStep(contentContainer);
  } else if (stepNum === 2) {
    renderDeviceStep(contentContainer);
  } else if (stepNum === 3) {
    renderTimeDurationStep(contentContainer);
  } else if (stepNum === 4) {
    renderFoodAddonStep(contentContainer);
  } else if (stepNum === 5) {
    renderSummaryDiscountStep(contentContainer);
  } else if (stepNum === 6) {
    processBookingConfirmation(contentContainer);
  }
}

// Step 1: Category Selection
function renderCategoryStep(container) {
  const cats = appData.categories;
  container.innerHTML = `
    <h3 style="margin-bottom: 1.5rem;"><i class="fa-solid fa-layer-group text-cyan"></i> Step 1: Select Gaming Type</h3>
    <div class="grid-3">
      ${cats.map(cat => `
        <div class="glass-card ${bookingState.selectedCategory === cat.id ? 'border-cyan' : ''}" 
             style="cursor: pointer; ${bookingState.selectedCategory === cat.id ? 'border-color: var(--neon-cyan); box-shadow: var(--glow-cyan);' : ''}"
             onclick="selectCategory('${cat.id}')">
          <div style="font-size: 2.5rem; color: var(--neon-cyan); margin-bottom: 1rem;"><i class="fa-solid ${cat.icon}"></i></div>
          <h4>${cat.name}</h4>
          <p style="color: var(--text-muted); font-size: 0.85rem; margin-top: 6px;">${cat.badge}</p>
        </div>
      `).join('')}
    </div>
    <div style="display: flex; justify-content: flex-end; margin-top: 2.5rem;">
      <button class="btn-cyber" onclick="nextStep()">Continue to Select Station <i class="fa-solid fa-arrow-right"></i></button>
    </div>
  `;
}

function selectCategory(catId) {
  bookingState.selectedCategory = catId;
  bookingState.selectedDevice = null;
  renderStep(1);
}

// Step 2: Device / Station Selection (Strict Category Separation)
function renderDeviceStep(container) {
  const allDevices = appData.devices || [];
  const catId = bookingState.selectedCategory || 'cat-online';
  const query = (bookingState.stationSearchQuery || '').toLowerCase().trim();

  // Strictly show ONLY devices belonging to the selected category!
  let devices = allDevices.filter(d => d.categoryId === catId);

  if (query) {
    devices = devices.filter(d => {
      const matchName = d.number.toLowerCase().includes(query) || d.typeName.toLowerCase().includes(query);
      const matchSpecs = d.specs.toLowerCase().includes(query);
      const matchGames = (d.installedGames || []).some(g => g.toLowerCase().includes(query));
      return matchName || matchSpecs || matchGames;
    });
  }

  let catTitle = "PC Gaming Station";
  let catSub = "High-End PC Rigs & Online Multiplayer (5 Stations Available)";
  let catIcon = "fa-desktop";
  let searchPlaceholder = "🔍 Search PC Game (e.g. Valorant, CS2, GTA V, Cyberpunk)...";

  if (catId === 'cat-console') {
    catTitle = "Console Lounge Station";
    catSub = "PlayStation 5, Xbox Series X & Nintendo Switch (4 Stations Available)";
    catIcon = "fa-gamepad";
    searchPlaceholder = "🔍 Search Console Game (e.g. Spider-Man 2, God of War, Tekken 8)...";
  } else if (catId === 'cat-offline') {
    catTitle = "Offline Game Table";
    catSub = "Carrom, Chess, Pool, Foosball, Table Tennis & Darts (8 Stations Available)";
    catIcon = "fa-chess-board";
    searchPlaceholder = "🔍 Search Offline Game (e.g. Carrom, Chess, Snooker Pool, TT)...";
  }

  const pcCount = allDevices.filter(d => d.categoryId === 'cat-online').length;
  const conCount = allDevices.filter(d => d.categoryId === 'cat-console').length;
  const offCount = allDevices.filter(d => d.categoryId === 'cat-offline').length;

  container.innerHTML = `
    <div style="display: flex; justify-content: space-between; align-items: center; flex-wrap: wrap; gap: 1rem; margin-bottom: 1.5rem;">
      <div>
        <h3 style="margin: 0;"><i class="fa-solid ${catIcon} text-cyan"></i> Step 2: Choose ${catTitle}</h3>
        <p style="color: var(--text-muted); font-size: 0.85rem; margin-top: 4px;">${catSub}</p>
      </div>
      <div style="flex: 1; max-width: 400px; min-width: 250px;">
        <input type="text" id="station-game-search" class="form-control" placeholder="${searchPlaceholder}" value="${bookingState.stationSearchQuery || ''}" oninput="onStationSearchInput(this.value)">
      </div>
    </div>

    <!-- Category Tabs in Step 2: Strictly Switch Categories -->
    <div style="display: flex; gap: 10px; overflow-x: auto; padding-bottom: 0.8rem; margin-bottom: 1.5rem;">
      <button class="btn-${catId === 'cat-online' ? 'cyber' : 'outline'} station-tab-btn" onclick="switchBookingCategory('cat-online')">
        <i class="fa-solid fa-desktop"></i> Online Gaming / PC (${pcCount})
      </button>
      <button class="btn-${catId === 'cat-console' ? 'cyber' : 'outline'} station-tab-btn" onclick="switchBookingCategory('cat-console')">
        <i class="fa-solid fa-gamepad"></i> Console Gaming (${conCount})
      </button>
      <button class="btn-${catId === 'cat-offline' ? 'cyber' : 'outline'} station-tab-btn" onclick="switchBookingCategory('cat-offline')">
        <i class="fa-solid fa-chess-board"></i> Offline Games (${offCount})
      </button>
    </div>

    ${devices.length === 0 ? `
      <div style="text-align: center; padding: 3rem; color: var(--text-muted);">
        <i class="fa-solid fa-gamepad" style="font-size: 3rem; margin-bottom: 1rem; color: var(--neon-cyan);"></i>
        <h3>No Stations Found</h3>
        <p>No stations match "${query}". Try searching for another game.</p>
        <button class="btn-outline" style="margin-top: 1rem;" onclick="onStationSearchInput('');">Clear Search</button>
      </div>
    ` : `
      <div class="grid-3">
        ${devices.map(dev => {
          const games = dev.installedGames || [];
          const isSelected = bookingState.selectedDevice?.id === dev.id;
          return `
            <div class="glass-card" style="border-color: ${isSelected ? 'var(--neon-cyan)' : 'var(--glass-border)'}; ${isSelected ? 'box-shadow: var(--glow-cyan);' : ''} display: flex; flex-direction: column; justify-content: space-between;">
              <div>
                <img src="${REAL_DEVICE_IMAGES[dev.id] || dev.image}" class="device-card-img" alt="${dev.typeName}">
                <div style="display: flex; justify-content: space-between; align-items: flex-start; margin-top: 10px;">
                  <div>
                    <span class="badge-status status-${dev.status.toLowerCase()}">${dev.status}</span>
                    <h4 style="margin-top: 8px;">${dev.number}</h4>
                    <p style="color: var(--text-muted); font-size: 0.82rem;">${dev.typeName} (${dev.zone})</p>
                  </div>
                  <div class="device-price">&#8377;${dev.hourlyRate}<span style="font-size: 0.8rem; color: var(--text-muted);">/hr</span></div>
                </div>
                <p style="font-size: 0.82rem; color: var(--text-dim); margin-top: 8px;">${dev.specs}</p>

                <!-- Installed Games Badge Box for this Station -->
                <div style="margin-top: 10px; background: rgba(0,0,0,0.4); padding: 8px 10px; border-radius: var(--radius-sm); border: 1px solid rgba(0,243,255,0.15);">
                  <div style="font-size: 0.72rem; color: var(--neon-cyan); font-weight: 700; text-transform: uppercase; margin-bottom: 6px; display: flex; align-items: center; justify-content: space-between;">
                    <span><i class="fa-solid fa-gamepad"></i> Installed Games (${games.length}):</span>
                    <span style="font-size: 0.68rem; color: var(--neon-green);"><i class="fa-solid fa-check"></i> Ready</span>
                  </div>
                  <div style="display: flex; flex-wrap: wrap; gap: 4px;">
                    ${games.slice(0, 5).map(g => `
                      <span style="background: rgba(0,243,255,0.08); color: #e2e8f0; font-size: 0.72rem; padding: 2px 7px; border-radius: 4px; border: 1px solid rgba(0,243,255,0.22); font-weight: 500;">
                        ${g}
                      </span>
                    `).join('')}
                    ${games.length > 5 ? `<span style="font-size: 0.7rem; color: var(--text-muted); align-self: center; padding: 2px 4px;">+${games.length - 5} more</span>` : ''}
                  </div>
                </div>
              </div>

              <div style="margin-top: 1.2rem;">
                ${dev.status === 'Available' ? `
                  <button class="btn-cyber ${isSelected ? 'btn-cyber-pink' : ''}" 
                          style="width: 100%; font-size: 0.85rem;" 
                          onclick="selectDevice('${dev.id}')">
                    ${isSelected ? '<i class="fa-solid fa-circle-check"></i> Selected' : 'Select Station'}
                  </button>
                ` : `
                  <button class="btn-outline" style="width: 100%; opacity: 0.5; cursor: not-allowed;" disabled>Currently ${dev.status}</button>
                `}
              </div>
            </div>
          `;
        }).join('')}
      </div>
    `}

    <div style="display: flex; justify-content: space-between; margin-top: 2.5rem;">
      <button class="btn-outline" onclick="prevStep()"><i class="fa-solid fa-arrow-left"></i> Back</button>
      <button class="btn-cyber" onclick="nextStep()">Choose Time & Duration <i class="fa-solid fa-arrow-right"></i></button>
    </div>
  `;
}

function switchBookingCategory(catId) {
  bookingState.selectedCategory = catId;
  bookingState.selectedDevice = null;
  bookingState.stationSearchQuery = '';
  renderStep(2);
}

function onStationSearchInput(val) {
  bookingState.stationSearchQuery = val;
  const container = document.getElementById('step-content-area');
  if (container) renderDeviceStep(container);
}

function selectDevice(devId) {
  bookingState.selectedDevice = appData.devices.find(d => d.id === devId);
  renderStep(2);
  showToast(`Selected ${bookingState.selectedDevice.number}!`, 'info');
}

// Step 3: Date, Time & Duration
function renderTimeDurationStep(container) {
  const dev = bookingState.selectedDevice;
  container.innerHTML = `
    <h3 style="margin-bottom: 1.5rem;"><i class="fa-solid fa-clock text-cyan"></i> Step 3: Schedule Date & Duration</h3>
    <div class="grid-3" style="margin-bottom: 2rem;">
      <div class="glass-card">
        <div class="form-group">
          <label class="form-label">Booking Date</label>
          <input type="date" class="form-control" value="${bookingState.date}" onchange="bookingState.date = this.value">
        </div>
        <div class="form-group">
          <label class="form-label">Start Time</label>
          <input type="time" class="form-control" value="${bookingState.time}" onchange="bookingState.time = this.value">
        </div>
      </div>

      <div class="glass-card">
        <label class="form-label">Session Duration (Hours)</label>
        <div style="display: flex; gap: 10px; margin-top: 1rem;">
          ${[1, 2, 3, 4, 5, 8].map(hrs => `
            <button class="btn-outline ${bookingState.duration === hrs ? 'text-cyan border-cyan' : ''}" 
                    style="flex: 1; padding: 12px 0;" 
                    onclick="bookingState.duration = ${hrs}; renderStep(3);">
              ${hrs} Hr${hrs > 1 ? 's' : ''}
            </button>
          `).join('')}
        </div>
        <p style="font-size: 0.85rem; color: var(--text-muted); margin-top: 1rem;">
          Rate per hour: <strong class="text-cyan">&#8377;${dev ? dev.hourlyRate : 0}</strong>
        </p>
      </div>

      <div class="glass-card" style="background: rgba(0, 243, 255, 0.05); border-color: var(--neon-cyan);">
        <h4 style="color: var(--neon-cyan);">Gaming Charge Estimate</h4>
        <div style="font-size: 2.2rem; font-family: var(--font-heading); font-weight: 800; margin: 1rem 0;">
          &#8377;${(dev ? dev.hourlyRate : 0) * bookingState.duration}
        </div>
        <p style="font-size: 0.85rem; color: var(--text-muted);">
          Selected Station: <strong>${dev ? dev.number : 'N/A'}</strong><br>
          Total Time: <strong>${bookingState.duration} Hours</strong>
        </p>
      </div>
    </div>

    <div style="display: flex; justify-content: space-between;">
      <button class="btn-outline" onclick="prevStep()"><i class="fa-solid fa-arrow-left"></i> Back</button>
      <button class="btn-cyber" onclick="nextStep()">Add Cafe Food & Snacks <i class="fa-solid fa-arrow-right"></i></button>
    </div>
  `;
}

// Step 4: Food Addons
function renderFoodAddonStep(container) {
  const foods = appData.foodItems;
  container.innerHTML = `
    <h3 style="margin-bottom: 1.5rem;"><i class="fa-solid fa-burger text-cyan"></i> Step 4: Order Food & Beverages (Optional)</h3>
    <div class="grid-4" style="max-height: 400px; overflow-y: auto; padding-right: 10px;">
      ${foods.map(item => {
        const added = bookingState.selectedFood.find(f => f.id === item.id);
        return `
          <div class="glass-card" style="padding: 1rem;">
            <img src="${REAL_FOOD_IMAGES[item.id] || item.image}" style="width: 100%; height: 100px; object-fit: cover; border-radius: var(--radius-sm);" alt="${item.name}">
            <h5 style="margin-top: 8px; font-size: 0.95rem;">${item.name}</h5>
            <div style="display: flex; justify-content: space-between; align-items: center; margin-top: 8px;">
              <span class="text-cyan" style="font-family: var(--font-heading); font-weight: 700;">&#8377;${item.price}</span>
              ${added ? `
                <div style="display: flex; align-items: center; gap: 6px;">
                  <button class="btn-outline" style="padding: 2px 8px;" onclick="updateFoodQty('${item.id}', -1)">-</button>
                  <span>${added.qty}</span>
                  <button class="btn-outline" style="padding: 2px 8px;" onclick="updateFoodQty('${item.id}', 1)">+</button>
                </div>
              ` : `
                <button class="btn-outline" style="font-size: 0.75rem; padding: 4px 10px;" onclick="addFoodToBooking('${item.id}')">Add</button>
              `}
            </div>
          </div>
        `;
      }).join('')}
    </div>

    <div style="display: flex; justify-content: space-between; margin-top: 2rem;">
      <button class="btn-outline" onclick="prevStep()"><i class="fa-solid fa-arrow-left"></i> Back</button>
      <button class="btn-cyber" onclick="nextStep()">Proceed to Discount & Payment <i class="fa-solid fa-arrow-right"></i></button>
    </div>
  `;
}

function addFoodToBooking(foodId) {
  const item = appData.foodItems.find(f => f.id === foodId);
  if (item) {
    bookingState.selectedFood.push({ id: item.id, name: item.name, price: item.price, qty: 1 });
    renderStep(4);
    showToast(`Added ${item.name} to booking!`, 'info');
  }
}

function updateFoodQty(foodId, change) {
  const item = bookingState.selectedFood.find(f => f.id === foodId);
  if (item) {
    item.qty += change;
    if (item.qty <= 0) {
      bookingState.selectedFood = bookingState.selectedFood.filter(f => f.id !== foodId);
    }
    renderStep(4);
  }
}

// Step 5: Summary & Payment
function renderSummaryDiscountStep(container) {
  const dev = bookingState.selectedDevice;
  const gamingCharge = (dev ? dev.hourlyRate : 0) * bookingState.duration;
  const foodTotal = bookingState.selectedFood.reduce((sum, f) => sum + (f.price * f.qty), 0);
  
  // Membership discount
  const user = appData.currentUser;
  const memTier = appData.memberships.find(m => m.name.toLowerCase() === (user.membershipTier || 'basic').toLowerCase()) || appData.memberships[0];
  const memDiscount = Math.round(gamingCharge * (memTier.discount / 100));
  
  const subTotal = gamingCharge + foodTotal - memDiscount - bookingState.discountAmount;
  const gst = Math.round(subTotal * 0.18); // 18% GST
  const grandTotal = subTotal + gst;

  container.innerHTML = `
    <h3 style="margin-bottom: 1.5rem;"><i class="fa-solid fa-file-invoice-dollar text-cyan"></i> Step 5: Checkout & Discounts</h3>
    <div class="grid-3">
      <div class="glass-card" style="grid-column: span 2;">
        <h4>Booking Summary</h4>
        <table style="width: 100%; border-collapse: collapse; margin-top: 1rem; color: var(--text-muted); font-size: 0.95rem;">
          <tr style="border-bottom: 1px solid rgba(255,255,255,0.05);">
            <td style="padding: 8px 0;">Station:</td>
            <td style="text-align: right; color: #fff;"><strong>${dev ? dev.number : ''} (${dev ? dev.typeName : ''})</strong></td>
          </tr>
          <tr style="border-bottom: 1px solid rgba(255,255,255,0.05);">
            <td style="padding: 8px 0;">Duration:</td>
            <td style="text-align: right; color: #fff;">${bookingState.duration} Hours (&#8377;${dev ? dev.hourlyRate : 0}/hr) = &#8377;${gamingCharge}</td>
          </tr>
          ${bookingState.selectedFood.length > 0 ? `
            <tr style="border-bottom: 1px solid rgba(255,255,255,0.05);">
              <td style="padding: 8px 0;">Food & Snacks:</td>
              <td style="text-align: right; color: #fff;">&#8377;${foodTotal}</td>
            </tr>
          ` : ''}
          ${memDiscount > 0 ? `
            <tr style="border-bottom: 1px solid rgba(255,255,255,0.05);">
              <td style="padding: 8px 0;">${memTier.name} Discount (${memTier.discount}%):</td>
              <td style="text-align: right; color: var(--neon-green);">- &#8377;${memDiscount}</td>
            </tr>
          ` : ''}
          <tr style="border-bottom: 1px solid rgba(255,255,255,0.05);">
            <td style="padding: 8px 0;">GST (18%):</td>
            <td style="text-align: right; color: #fff;">&#8377;${gst}</td>
          </tr>
          <tr>
            <td style="padding: 12px 0; font-size: 1.2rem; color: #fff;"><strong>Grand Total:</strong></td>
            <td style="text-align: right; font-size: 1.4rem; color: var(--neon-cyan); font-family: var(--font-heading);"><strong>&#8377;${grandTotal}</strong></td>
          </tr>
        </table>

        <!-- Coupon Input -->
        <div style="display: flex; gap: 10px; margin-top: 1.5rem;">
          <input type="text" id="coupon-code-input" class="form-control" placeholder="Enter Coupon Code (e.g. GAMER20)" style="text-transform: uppercase;">
          <button class="btn-outline" onclick="applyCouponCode()">Apply Coupon</button>
        </div>
      </div>

      <div class="glass-card">
        <h4>Payment Method</h4>
        <div style="display: flex; flex-direction: column; gap: 10px; margin-top: 1rem;">
          ${['UPI', 'Credit/Debit Card', 'Wallet', 'Cash at Counter'].map(method => `
            <label style="display: flex; align-items: center; gap: 10px; padding: 10px; background: rgba(8,10,18,0.8); border: 1px solid var(--glass-border); border-radius: var(--radius-sm); cursor: pointer;">
              <input type="radio" name="pay-method" value="${method}" ${bookingState.paymentMethod === method ? 'checked' : ''} onchange="bookingState.paymentMethod = '${method}'">
              <span style="font-size: 0.95rem; font-weight: 600;">${method}</span>
            </label>
          `).join('')}
        </div>
      </div>
    </div>

    <div style="display: flex; justify-content: space-between; margin-top: 2.5rem;">
      <button class="btn-outline" onclick="prevStep()"><i class="fa-solid fa-arrow-left"></i> Back</button>
      <button class="btn-cyber btn-cyber-pink" onclick="nextStep()"><i class="fa-solid fa-lock"></i> Confirm & Pay &#8377;${grandTotal}</button>
    </div>
  `;
}

function applyCouponCode() {
  const code = document.getElementById('coupon-code-input').value.trim().toUpperCase();
  const found = appData.coupons.find(c => c.code === code);
  if (found) {
    bookingState.coupon = found;
    bookingState.discountAmount = found.discount;
    showToast(`Coupon ${code} applied successfully!`, 'success');
    renderStep(5);
  } else {
    showToast('Invalid Coupon Code!', 'warning');
  }
}

// Step 6: Confirmation Ticket & Invoice
function processBookingConfirmation(container) {
  const bookingId = 'BK-' + Math.floor(10000 + Math.random() * 90000);
  const qrCodeData = `CYBERGRID-${bookingId}-${bookingState.selectedDevice?.id}`;
  
  // Save booking to data store
  const newBooking = {
    id: bookingId,
    bookingCode: qrCodeData,
    customerName: appData.currentUser.name,
    deviceId: bookingState.selectedDevice?.id,
    deviceName: bookingState.selectedDevice?.number,
    category: bookingState.selectedCategory,
    startTime: `${bookingState.date}T${bookingState.time}`,
    durationHours: bookingState.duration,
    foodItems: bookingState.selectedFood,
    status: 'Confirmed',
    paymentStatus: 'Paid',
    paymentMethod: bookingState.paymentMethod
  };
  
  appData.bookings.push(newBooking);
  saveCafeData(appData);

  container.innerHTML = `
    <div class="invoice-box" style="text-align: center; max-width: 600px; margin: 0 auto;">
      <i class="fa-solid fa-circle-check" style="font-size: 3.5rem; color: var(--neon-green); margin-bottom: 1rem;"></i>
      <h2 style="color: var(--neon-green);">Booking Confirmed!</h2>
      <p style="color: var(--text-muted); margin-bottom: 1.5rem;">Your session pass and invoice have been generated.</p>

      <div style="background: #fff; padding: 15px; display: inline-block; border-radius: var(--radius-sm); margin-bottom: 1.5rem;" id="qrcode-canvas-area">
        <!-- QR Code rendered here -->
      </div>

      <p style="font-family: var(--font-sub); font-size: 1.1rem; color: var(--neon-cyan);">Pass Code: <strong>${bookingId}</strong></p>

      <div style="display: flex; gap: 1rem; justify-content: center; margin-top: 2rem;">
        <button class="btn-cyber" onclick="window.print()"><i class="fa-solid fa-print"></i> Print Invoice PDF</button>
        <a href="customer-dashboard.aspx" class="btn-outline"><i class="fa-solid fa-user"></i> Go to Dashboard</a>
      </div>
    </div>
  `;

  // Render QR Code using Google Chart API or QR fallback canvas
  setTimeout(() => {
    const qrDiv = document.getElementById('qrcode-canvas-area');
    if (qrDiv) {
      qrDiv.innerHTML = `<img src="https://api.qrserver.com/v1/create-qr-code/?size=160x160&data=${encodeURIComponent(qrCodeData)}" alt="QR Pass">`;
    }
  }, 100);
}

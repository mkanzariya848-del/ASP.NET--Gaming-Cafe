/*
  Gaming Café Data Store & LocalStorage Synchronization
  Includes Authentication & Database Persistence Engine
*/

const InitialCafeData = {
  // Pre-populated Users Database
  users: [
    {
      id: 'USR-1001',
      name: 'Alex Mercer',
      email: 'alex@cybergrid.com',
      phone: '+91 98765 43210',
      password: 'password123',
      role: 'customer',
      avatar: 'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?auto=format&fit=crop&w=120&q=80',
      membershipTier: 'Gold VIP',
      rewardPoints: 1250,
      createdAt: '2026-01-15'
    },
    {
      id: 'USR-1002',
      name: 'Sarah Connor (Staff Desk)',
      email: 'staff@cybergrid.com',
      phone: '+91 98765 11111',
      password: 'staff123',
      role: 'staff',
      avatar: 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?auto=format&fit=crop&w=120&q=80',
      membershipTier: 'Basic Tier',
      rewardPoints: 0,
      createdAt: '2026-01-01'
    },
    {
      id: 'USR-1003',
      name: 'System Admin (Master)',
      email: 'admin@cybergrid.com',
      phone: '+91 98765 99999',
      password: 'admin123',
      role: 'admin',
      avatar: 'https://images.unsplash.com/photo-1570295999919-56ceb5ecca61?auto=format&fit=crop&w=120&q=80',
      membershipTier: 'Diamond Legend',
      rewardPoints: 9999,
      createdAt: '2026-01-01'
    }
  ],

  activeSession: {
    isLoggedIn: true,
    userEmail: 'alex@cybergrid.com'
  },

  categories: [
    { id: 'cat-online', name: 'Online Gaming', icon: 'fa-desktop', badge: 'High Performance PCs' },
    { id: 'cat-console', name: 'Console Gaming', icon: 'fa-gamepad', badge: 'Next-Gen Consoles' },
    { id: 'cat-offline', name: 'Offline Games', icon: 'fa-chess-board', badge: 'Board & Table Games' }
  ],

  devices: [
    {
      id: 'DEV-PC-01',
      number: 'Station PC-01',
      categoryId: 'cat-online',
      typeName: 'High-End Gaming PC',
      specs: 'Intel Core i9 14900K | RTX 5090 | 64GB DDR5 | 360Hz ROG Monitor',
      hourlyRate: 250,
      status: 'Occupied',
      zone: 'VIP RGB Zone A',
      image: 'assets/images/pc_01.jpg',
      installedGames: ['Cyberpunk 2077', 'GTA V', 'Valorant', 'CS2', 'Call of Duty: MW III', 'God of War Ragnarok', 'Mortal Kombat 1', 'Minecraft', 'Red Dead Redemption 2', 'Apex Legends']
    },
    {
      id: 'DEV-PC-02',
      number: 'Station PC-02',
      categoryId: 'cat-online',
      typeName: 'High-End Gaming PC',
      specs: 'Intel Core i9 14900K | RTX 5090 | 64GB DDR5 | 360Hz ROG Monitor',
      hourlyRate: 250,
      status: 'Available',
      zone: 'VIP RGB Zone A',
      image: 'assets/images/pc_02.jpg',
      installedGames: ['Cyberpunk 2077', 'GTA V', 'Valorant', 'CS2', 'Call of Duty: MW III', 'God of War Ragnarok', 'Mortal Kombat 1', 'Minecraft', 'Red Dead Redemption 2', 'Apex Legends']
    },
    {
      id: 'DEV-PC-03',
      number: 'Station PC-03',
      categoryId: 'cat-online',
      typeName: 'Mid-Level Gaming PC',
      specs: 'Intel Core i5 13600K | RTX 4060 | 16GB DDR4 | 165Hz Curved Monitor',
      hourlyRate: 150,
      status: 'Available',
      zone: 'Main Arena Zone B',
      image: 'assets/images/pc_03.jpg',
      installedGames: ['Valorant', 'CS2', 'GTA V', 'Minecraft', 'Apex Legends', 'Forza Horizon 5']
    },
    {
      id: 'DEV-PC-04',
      number: 'Station PC-04',
      categoryId: 'cat-online',
      typeName: 'Mid-Level Gaming PC',
      specs: 'Intel Core i5 13600K | RTX 4060 | 16GB DDR4 | 165Hz Curved Monitor',
      hourlyRate: 150,
      status: 'Reserved',
      zone: 'Main Arena Zone B',
      image: 'assets/images/pc_04.jpg',
      installedGames: ['Valorant', 'CS2', 'GTA V', 'Minecraft', 'Apex Legends', 'Forza Horizon 5']
    },
    {
      id: 'DEV-PC-05',
      number: 'Station PC-05',
      categoryId: 'cat-online',
      typeName: 'Budget Gaming PC',
      specs: 'AMD Ryzen 5 5600X | GTX 1660 Super | 16GB RAM | 144Hz Monitor',
      hourlyRate: 100,
      status: 'Available',
      zone: 'Budget Zone C',
      image: 'assets/images/pc_05.jpg',
      installedGames: ['Valorant', 'CS2', 'Minecraft', 'GTA V']
    },
    {
      id: 'DEV-CON-01',
      number: 'Console Lounge PS5-01',
      categoryId: 'cat-console',
      typeName: 'PlayStation 5',
      specs: '4K 120Hz OLED 75" TV | DualSense Controllers | 3D Audio',
      hourlyRate: 200,
      status: 'Occupied',
      zone: 'Console Lounge 1',
      image: 'assets/images/ps5_01.jpg?v=2',
      installedGames: ["Marvel's Spider-Man 2", 'God of War Ragnarok', 'Tekken 8', 'EA Sports FC 24', 'Mortal Kombat 1', 'GTA V', 'Call of Duty: MW III']
    },
    {
      id: 'DEV-CON-02',
      number: 'Console Lounge PS5-02',
      categoryId: 'cat-console',
      typeName: 'PlayStation 5',
      specs: '4K 120Hz OLED 75" TV | DualSense Controllers | 3D Audio',
      hourlyRate: 200,
      status: 'Available',
      zone: 'Console Lounge 1',
      image: 'assets/images/ps5_02.jpg?v=2',
      installedGames: ["Marvel's Spider-Man 2", 'God of War Ragnarok', 'Tekken 8', 'EA Sports FC 24', 'Mortal Kombat 1', 'Red Dead Redemption 2', 'Apex Legends']
    },
    {
      id: 'DEV-CON-03',
      number: 'Console Lounge XBOX-01',
      categoryId: 'cat-console',
      typeName: 'Xbox Series X',
      specs: '4K OLED TV | Xbox Wireless Controllers | Game Pass Ultimate',
      hourlyRate: 180,
      status: 'Available',
      zone: 'Console Lounge 2',
      image: 'assets/images/xbox_01.png?v=2',
      installedGames: ['Forza Horizon 5', 'Call of Duty: MW III', 'Mortal Kombat 1', 'Minecraft', 'EA Sports FC 24']
    },
    {
      id: 'DEV-CON-04',
      number: 'Console Booth Switch-01',
      categoryId: 'cat-console',
      typeName: 'Nintendo Switch OLED',
      specs: 'Docked 4K TV Mode | 4 Joy-Cons | Mario Kart & Smash Ultimate',
      hourlyRate: 140,
      status: 'Available',
      zone: 'Party Booth',
      image: 'assets/images/switch_01.jpg?v=2',
      installedGames: ['Mario Kart 8 Deluxe', 'Super Smash Bros Ultimate', 'Minecraft', 'The Legend of Zelda']
    },
    {
      id: 'DEV-OFF-01',
      number: 'Table Carrom-01',
      categoryId: 'cat-offline',
      typeName: 'Carrom Board',
      specs: 'Professional Synco Champion Carrom Board | Smooth Powder & Coins',
      hourlyRate: 80,
      status: 'Available',
      zone: 'Board Game Corner',
      image: 'assets/images/carrom_01.jpg',
      installedGames: ['Synco Professional Carrom', 'Points & Board Match']
    },
    {
      id: 'DEV-OFF-02',
      number: 'Table Chess-01',
      categoryId: 'cat-offline',
      typeName: 'Tournament Chess',
      specs: 'Wooden Weighted Staunton Chess Pieces | Digital Clock Timer',
      hourlyRate: 60,
      status: 'Available',
      zone: 'Mind Games Lounge',
      image: 'assets/images/chess_01.jpg',
      installedGames: ['Tournament Classical Chess', 'Blitz Clock Match']
    },
    {
      id: 'DEV-OFF-03',
      number: 'Table Foosball-01',
      categoryId: 'cat-offline',
      typeName: 'Tornado Foosball',
      specs: 'Heavy Duty 4-Player Foosball Table | High Speed Balls',
      hourlyRate: 100,
      status: 'Occupied',
      zone: 'Active Sports Lounge',
      image: 'assets/images/foosball_01.jpg?v=3',
      installedGames: ['4-Player Foosball Cup', 'Fast Doubles Soccer']
    },
    {
      id: 'DEV-OFF-04',
      number: 'Table TT-01',
      categoryId: 'cat-offline',
      typeName: 'Table Tennis',
      specs: 'Stiga Professional TT Table | Butterfly Rackets & 3-Star Balls',
      hourlyRate: 120,
      status: 'Available',
      zone: 'Active Sports Lounge',
      image: 'assets/images/tt_01.jpg?v=3',
      installedGames: ['Stiga TT Singles / Doubles', 'Table Tennis Championship']
    },
    {
      id: 'DEV-OFF-05',
      number: 'Table Snooker Pool-01',
      categoryId: 'cat-offline',
      typeName: '8-Ball & Snooker Pool',
      specs: 'Full 9ft Slate English Pool Table | Aramith Belgian Balls & Ash Wood Cues',
      hourlyRate: 150,
      status: 'Available',
      zone: 'Cue Sports Arena',
      image: 'assets/images/pool_01.jpg?v=3',
      installedGames: ['8-Ball Pool', '9-Ball Classic', 'English Snooker']
    },
    {
      id: 'DEV-OFF-06',
      number: 'Table Air Hockey-01',
      categoryId: 'cat-offline',
      typeName: 'Arcade Air Hockey',
      specs: 'High-Power Blower System | Overhead Digital Scoreboard & Glow Puck',
      hourlyRate: 130,
      status: 'Available',
      zone: 'Arcade & Sports Bay',
      image: 'assets/images/airhockey_01.jpg?v=3',
      installedGames: ['Glow-Puck Air Hockey', 'Arcade Fast Battle']
    },
    {
      id: 'DEV-OFF-07',
      number: 'Target Darts-01',
      categoryId: 'cat-offline',
      typeName: 'Tournament Darts',
      specs: 'Winmau Blade 6 Dual-Core Bristle Board | Precision Steel-Tip Darts',
      hourlyRate: 70,
      status: 'Available',
      zone: 'Mind & Focus Lounge',
      image: 'assets/images/darts_01.jpg?v=3',
      installedGames: ['Winmau 501 / 301 Target Darts', 'Cricket Darts']
    },
    {
      id: 'DEV-OFF-08',
      number: 'Table Board Games-01',
      categoryId: 'cat-offline',
      typeName: 'Jenga & Deluxe Board Games',
      specs: 'Giant Hardwood Jenga, Catan, Ticket to Ride, Monopoly Deluxe & UNO Flip',
      hourlyRate: 80,
      status: 'Available',
      zone: 'Board Game Corner',
      image: 'assets/images/boardgames_01.jpg?v=3',
      installedGames: ['Giant Hardwood Jenga', 'Catan', 'Ticket to Ride', 'Monopoly Deluxe', 'UNO Flip']
    }
  ],

  foodItems: [
    { id: 'FD-101', category: 'Pizza', name: 'Loaded Pepperoni Pizza', price: 220, isAvailable: true, icon: 'fa-pizza-slice', image: 'assets/images/food_pizza.jpg?v=2' },
    { id: 'FD-102', category: 'Burger', name: 'Monster Crisp Chicken Burger', price: 140, isAvailable: true, icon: 'fa-hamburger', image: 'assets/images/food_burger.jpg?v=2' },
    { id: 'FD-103', category: 'Fries', name: 'Peri-Peri Loaded Fries', price: 90, isAvailable: true, icon: 'fa-box', image: 'assets/images/food_fries.jpg?v=2' },
    { id: 'FD-104', category: 'Energy Drinks', name: 'Cyber Red Bull Energy', price: 120, isAvailable: true, icon: 'fa-bolt', image: 'assets/images/food_energy.jpg?v=2' },
    { id: 'FD-105', category: 'Maggi', name: 'Cheese Butter Cheese Maggi', price: 60, isAvailable: true, icon: 'fa-bowl-food', image: 'assets/images/food_maggi.jpg?v=2' },
    { id: 'FD-106', category: 'Coffee', name: 'Cold Coffee with Ice Cream', price: 70, isAvailable: true, icon: 'fa-mug-hot', image: 'assets/images/food_coffee.jpg?v=2' },
    { id: 'FD-107', category: 'Sandwich', name: 'Grilled Paneer Club Sandwich', price: 100, isAvailable: true, icon: 'fa-bread-slice', image: 'assets/images/food_sandwich.jpg?v=2' },
    { id: 'FD-108', category: 'Ice Cream', name: 'Sizzling Brownie with Ice Cream', price: 80, isAvailable: true, icon: 'fa-ice-cream', image: 'assets/images/food_brownie.jpg?v=2' }
  ],

  memberships: [
    { id: 'mem-basic', name: 'Basic Tier', price: 0, discount: 0, extraHours: 0, priorityBooking: false, color: '#8e9bb4' },
    { id: 'mem-silver', name: 'Silver Gamer', price: 499, discount: 10, extraHours: 1, priorityBooking: true, color: '#c0c0c0' },
    { id: 'mem-gold', name: 'Gold VIP', price: 999, discount: 20, extraHours: 2, priorityBooking: true, color: '#ffcc00' },
    { id: 'mem-diamond', name: 'Diamond Legend', price: 1999, discount: 35, extraHours: 5, priorityBooking: true, color: '#00f3ff' }
  ],

  games: [
    { id: 'GM-01', title: 'Valorant', platform: 'PC', genre: 'Tactical Shooter', rating: '4.9/5', age: '16+', developer: 'Riot Games', image: 'assets/images/game_valorant.jpg?v=2' },
    { id: 'GM-02', title: 'Cyberpunk 2077', platform: 'PC / PS5', genre: 'Open World RPG', rating: '4.8/5', age: '18+', developer: 'CD Projekt Red', image: 'assets/images/game_cyberpunk.jpg?v=2' },
    { id: 'GM-03', title: 'EA Sports FC 24', platform: 'PS5 / Xbox', genre: 'Sports Simulation', rating: '4.7/5', age: '3+', developer: 'EA Sports', image: 'assets/images/game_fifa.jpg?v=2' },
    { id: 'GM-04', title: 'Tekken 8', platform: 'PS5 / Xbox', genre: 'Fighting', rating: '4.9/5', age: '12+', developer: 'Bandai Namco', image: 'assets/images/game_tekken.jpg?v=2' },
    { id: 'GM-05', title: 'Grand Theft Auto V', platform: 'PC / PS5', genre: 'Action / Open World', rating: '4.9/5', age: '18+', developer: 'Rockstar Games', image: 'assets/images/game_gta.jpg?v=2' },
    { id: 'GM-06', title: 'Forza Horizon 5', platform: 'PC / Xbox', genre: 'Racing Simulation', rating: '4.8/5', age: '3+', developer: 'Playground Games', image: 'assets/images/game_forza.jpg?v=2' },
    { id: 'GM-07', title: 'Call of Duty: MW III', platform: 'PC / PS5 / Xbox', genre: 'Tactical Shooter', rating: '4.8/5', age: '18+', developer: 'Activision', image: 'assets/images/game_cod.jpg?v=2' },
    { id: 'GM-08', title: "Marvel's Spider-Man 2", platform: 'PS5', genre: 'Action / Open World', rating: '4.9/5', age: '12+', developer: 'Insomniac Games', image: 'assets/images/game_spiderman.jpg?v=2' },
    { id: 'GM-09', title: 'Counter-Strike 2', platform: 'PC', genre: 'Tactical Shooter', rating: '4.8/5', age: '16+', developer: 'Valve', image: 'assets/images/game_cs2.jpg?v=2' },
    { id: 'GM-10', title: 'God of War Ragnarok', platform: 'PC / PS5', genre: 'Action / Mythology', rating: '4.9/5', age: '18+', developer: 'Santa Monica Studio', image: 'assets/images/game_gow.jpg?v=2' },
    { id: 'GM-11', title: 'Mortal Kombat 1', platform: 'PC / PS5 / Xbox', genre: 'Fighting', rating: '4.7/5', age: '18+', developer: 'NetherRealm Studios', image: 'assets/images/game_mk1.jpg?v=2' },
    { id: 'GM-12', title: 'Minecraft', platform: 'PC / Console', genre: 'Sandbox / Survival', rating: '4.9/5', age: '7+', developer: 'Mojang Studios', image: 'assets/images/game_minecraft.jpg?v=2' },
    { id: 'GM-13', title: 'Red Dead Redemption 2', platform: 'PC / PS5', genre: 'Action / Open World', rating: '5.0/5', age: '18+', developer: 'Rockstar Games', image: 'assets/images/game_rdr2.jpg?v=2' },
    { id: 'GM-14', title: 'Apex Legends', platform: 'PC / Console', genre: 'Battle Royale', rating: '4.7/5', age: '13+', developer: 'Respawn Entertainment', image: 'assets/images/game_apex.jpg?v=2' }
  ],

  coupons: [
    { code: 'GAMER20', discount: 20, type: 'percent', minSpend: 200 },
    { code: 'CYBER100', discount: 100, type: 'flat', minSpend: 500 },
    { code: 'FIRST50', discount: 50, type: 'percent', minSpend: 150 }
  ],

  bookings: [
    {
      id: 'BK-78901',
      bookingCode: 'GC-QR-78901',
      customerName: 'Alex Mercer',
      deviceId: 'DEV-PC-01',
      deviceName: 'Station PC-01',
      category: 'Online Gaming',
      startTime: '2026-07-30T15:00:00',
      endTime: '2026-07-30T17:00:00',
      durationHours: 2,
      hourlyRate: 250,
      gamingTotal: 500,
      foodTotal: 220,
      discount: 100,
      tax: 129.6,
      grandTotal: 749.6,
      status: 'In-Session',
      paymentStatus: 'Paid',
      paymentMethod: 'UPI'
    }
  ]
};

// Data Store Get/Set
function getCafeData() {
  const DATA_VERSION = 'v29_switch_image_update';
  const currentVer = localStorage.getItem('cybergrid_data_version');

  // Check if data needs refresh for real distinct images
  if (currentVer !== DATA_VERSION) {
    const existingStr = localStorage.getItem('cybergrid_cafe_data');
    let existingUser = null;
    let existingSession = null;
    if (existingStr) {
      try {
        const parsed = JSON.parse(existingStr);
        existingUser = parsed.currentUser;
        existingSession = parsed.activeSession;
      } catch (e) { }
    }

    let freshData = JSON.parse(JSON.stringify(InitialCafeData));
    if (existingUser) freshData.currentUser = existingUser;
    if (existingSession) freshData.activeSession = existingSession;

    localStorage.setItem('cybergrid_cafe_data', JSON.stringify(freshData));
    localStorage.setItem('cybergrid_data_version', DATA_VERSION);
    return freshData;
  }

  const dataStr = localStorage.getItem('cybergrid_cafe_data');
  if (!dataStr) {
    localStorage.setItem('cybergrid_cafe_data', JSON.stringify(InitialCafeData));
    localStorage.setItem('cybergrid_data_version', DATA_VERSION);
    return InitialCafeData;
  }
  const parsed = JSON.parse(dataStr);
  
  // Enforce latest images and installed games even in existing cached data
  if (parsed.foodItems) {
    parsed.foodItems.forEach(f => {
      const match = InitialCafeData.foodItems.find(x => x.id === f.id);
      if (match) f.image = match.image;
    });
  }
  if (parsed.devices) {
    parsed.devices.forEach(d => {
      const match = InitialCafeData.devices.find(x => x.id === d.id);
      if (match) {
        d.image = match.image;
        d.installedGames = match.installedGames;
      }
    });
  }
  if (parsed.games) {
    parsed.games.forEach(g => {
      const match = InitialCafeData.games.find(x => x.id === g.id);
      if (match) g.image = match.image;
    });
  }
  if (!parsed.games || parsed.games.length < InitialCafeData.games.length) {
    parsed.games = InitialCafeData.games;
  }

  // Ensure users array exists
  if (!parsed.users) {
    parsed.users = InitialCafeData.users;
    parsed.activeSession = InitialCafeData.activeSession;
    localStorage.setItem('cybergrid_cafe_data', JSON.stringify(parsed));
  }
  return parsed;
}

function saveCafeData(data) {
  localStorage.setItem('cybergrid_cafe_data', JSON.stringify(data));
}

// Database Auth Helper Functions
function dbRegisterUser(name, email, phone, password, role = 'customer', membershipTier = 'Basic Tier') {
  const data = getCafeData();
  const existing = data.users.find(u => u.email.toLowerCase() === email.toLowerCase());
  if (existing) {
    return { success: false, message: 'An account with this email address already exists!' };
  }

  const newUser = {
    id: 'USR-' + Math.floor(1000 + Math.random() * 9000),
    name: name,
    email: email,
    phone: phone,
    password: password,
    role: role,
    avatar: 'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?auto=format&fit=crop&w=120&q=80',
    membershipTier: membershipTier,
    rewardPoints: 100, // Welcome bonus
    createdAt: new Date().toISOString().split('T')[0]
  };

  data.users.push(newUser);
  data.activeSession = { isLoggedIn: true, userEmail: newUser.email };
  data.currentUserRole = newUser.role;
  data.currentUser = newUser;
  saveCafeData(data);
  return { success: true, user: newUser };
}

function dbLoginUser(email, password) {
  const data = getCafeData();
  const user = data.users.find(u => u.email.toLowerCase() === email.toLowerCase() && u.password === password);
  if (!user) {
    return { success: false, message: 'Invalid email address or password!' };
  }

  data.activeSession = { isLoggedIn: true, userEmail: user.email };
  data.currentUserRole = user.role;
  data.currentUser = user;
  saveCafeData(data);
  return { success: true, user: user };
}

function dbLogoutUser() {
  const data = getCafeData();
  data.activeSession = { isLoggedIn: false, userEmail: null };
  data.currentUserRole = 'customer';
  saveCafeData(data);
}

function getLoggedInUser() {
  const data = getCafeData();
  if (data.activeSession && data.activeSession.isLoggedIn && data.activeSession.userEmail) {
    return data.users.find(u => u.email.toLowerCase() === data.activeSession.userEmail.toLowerCase()) || data.currentUser;
  }
  return null;
}

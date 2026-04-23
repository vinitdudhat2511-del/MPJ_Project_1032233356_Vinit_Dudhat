<!-- Google Fonts -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&family=Poppins:wght@400;600;700;800&display=swap" rel="stylesheet">

<!-- Bootstrap CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet"
    integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">

<!-- Font Awesome -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.1/css/all.min.css"
    integrity="sha512-MV7K8+y+gLIBoVD59lQIYicR65iaqukzvf/nwasF0nqhPay5w/9lJmVM2hMDcnK1OnMGCdVK+iQrJ7lzPJQd1w=="
    crossorigin="anonymous" referrerpolicy="no-referrer" />

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
    integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
    crossorigin="anonymous"></script>

<style>
/* ============================================================
   CSS DESIGN SYSTEM — Doctor Patient Portal
   ============================================================ */

:root {
  --primary: #00c9b1;
  --primary-dark: #00a89a;
  --primary-glow: rgba(0, 201, 177, 0.3);
  --navy: #0a1628;
  --navy-mid: #0f2040;
  --navy-light: #162c52;
  --navy-card: rgba(15, 32, 64, 0.85);
  --text-white: #f0f4ff;
  --text-muted: #8ca0be;
  --border-glass: rgba(255,255,255,0.08);
  --shadow-card: 0 8px 32px rgba(0,0,0,0.4);
  --shadow-glow: 0 0 20px var(--primary-glow);
  --radius-card: 16px;
  --radius-btn: 10px;
  --transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
}

/* Base */
*, *::before, *::after { box-sizing: border-box; }

html { scroll-behavior: smooth; }

body {
  margin: 0; padding: 0;
  width: 100%; overflow-x: hidden;
  background-color: var(--navy);
  font-family: 'Inter', sans-serif;
  color: var(--text-white);
  min-height: 100vh;
}

h1, h2, h3, h4, h5, h6 {
  font-family: 'Poppins', sans-serif;
  font-weight: 700;
}

/* ============================================================
   UTILITY COLORS
   ============================================================ */
.text-primary-teal { color: var(--primary) !important; }
.text-muted-custom { color: var(--text-muted) !important; }
.bg-navy { background-color: var(--navy) !important; }
.bg-navy-mid { background-color: var(--navy-mid) !important; }

/* Legacy compat */
.my-bg-color { background: linear-gradient(135deg, #0a1628, #162c52) !important; }
.myP-color { color: var(--primary) !important; }

/* ============================================================
   GLASSMORPHISM CARD
   ============================================================ */
.glass-card {
  background: var(--navy-card);
  backdrop-filter: blur(20px);
  -webkit-backdrop-filter: blur(20px);
  border: 1px solid var(--border-glass);
  border-radius: var(--radius-card);
  box-shadow: var(--shadow-card);
  transition: var(--transition);
}
.glass-card:hover {
  transform: translateY(-4px);
  box-shadow: var(--shadow-card), var(--shadow-glow);
  border-color: rgba(0,201,177,0.2);
}

/* my-card override for legacy pages */
.my-card {
  background: var(--navy-card) !important;
  backdrop-filter: blur(20px);
  border: 1px solid var(--border-glass) !important;
  border-radius: var(--radius-card) !important;
  box-shadow: var(--shadow-card) !important;
  color: var(--text-white);
}
.card {
  background: var(--navy-card);
  border: 1px solid var(--border-glass);
  border-radius: var(--radius-card);
  color: var(--text-white);
}
.card-body, .card-header {
  color: var(--text-white);
}
.card-header {
  background: rgba(0,201,177,0.1) !important;
  border-bottom: 1px solid var(--border-glass);
}

/* ============================================================
   BUTTONS
   ============================================================ */
.btn-primary-teal {
  background: linear-gradient(135deg, var(--primary), var(--primary-dark));
  color: var(--navy);
  font-weight: 600;
  border: none;
  border-radius: var(--radius-btn);
  padding: 10px 24px;
  transition: var(--transition);
  position: relative;
  overflow: hidden;
}
.btn-primary-teal::after {
  content: '';
  position: absolute;
  top: 0; left: -100%;
  width: 100%; height: 100%;
  background: linear-gradient(90deg, transparent, rgba(255,255,255,0.2), transparent);
  transition: 0.5s;
}
.btn-primary-teal:hover::after { left: 100%; }
.btn-primary-teal:hover {
  transform: translateY(-2px);
  box-shadow: 0 8px 20px var(--primary-glow);
  color: var(--navy);
}

.btn-outline-teal {
  border: 1.5px solid var(--primary);
  color: var(--primary);
  border-radius: var(--radius-btn);
  padding: 8px 20px;
  font-weight: 500;
  transition: var(--transition);
  background: transparent;
}
.btn-outline-teal:hover {
  background: var(--primary);
  color: var(--navy);
  box-shadow: 0 4px 15px var(--primary-glow);
}

/* Override Bootstrap buttons on dark bg */
.btn-success { 
  background: linear-gradient(135deg, #00c9b1, #00a89a) !important;
  border: none !important;
  color: #0a1628 !important;
  font-weight: 600 !important;
}
.btn-danger {
  background: linear-gradient(135deg, #ff4757, #c0392b) !important;
  border: none !important;
  font-weight: 600 !important;
}
.btn-warning {
  background: linear-gradient(135deg, #ffd32a, #f0a500) !important;
  border: none !important;
  color: #0a1628 !important;
  font-weight: 600 !important;
}

/* ============================================================
   STATUS BADGES
   ============================================================ */
.badge-pending {
  background: rgba(255, 193, 7, 0.2);
  color: #ffd32a;
  border: 1px solid rgba(255,193,7,0.4);
  padding: 4px 12px;
  border-radius: 20px;
  font-size: 0.8rem;
  font-weight: 600;
  display: inline-block;
}
.badge-approved {
  background: rgba(0,201,177,0.15);
  color: #00c9b1;
  border: 1px solid rgba(0,201,177,0.4);
  padding: 4px 12px;
  border-radius: 20px;
  font-size: 0.8rem;
  font-weight: 600;
  display: inline-block;
}
.badge-rejected {
  background: rgba(255,71,87,0.15);
  color: #ff4757;
  border: 1px solid rgba(255,71,87,0.4);
  padding: 4px 12px;
  border-radius: 20px;
  font-size: 0.8rem;
  font-weight: 600;
  display: inline-block;
}
.badge-cancelled {
  background: rgba(140,160,190,0.15);
  color: #8ca0be;
  border: 1px solid rgba(140,160,190,0.3);
  padding: 4px 12px;
  border-radius: 20px;
  font-size: 0.8rem;
  font-weight: 600;
  display: inline-block;
}

/* ============================================================
   FORMS
   ============================================================ */
.form-control, .form-select {
  background: rgba(255,255,255,0.05) !important;
  border: 1px solid var(--border-glass) !important;
  color: var(--text-white) !important;
  border-radius: 10px !important;
  padding: 12px 16px !important;
  transition: var(--transition);
}
.form-control:focus, .form-select:focus {
  background: rgba(0,201,177,0.07) !important;
  border-color: var(--primary) !important;
  box-shadow: 0 0 0 3px var(--primary-glow) !important;
  color: var(--text-white) !important;
  outline: none;
}
.form-control::placeholder { color: var(--text-muted) !important; }
.form-label { color: var(--text-muted); font-size: 0.875rem; font-weight: 500; margin-bottom: 6px; }
.form-select option { background: var(--navy-mid); color: var(--text-white); }

/* ============================================================
   TABLES
   ============================================================ */
.table {
  color: var(--text-white) !important;
  border-color: var(--border-glass) !important;
}
.table thead th {
  background: rgba(0,201,177,0.12) !important;
  color: var(--primary) !important;
  font-weight: 600 !important;
  border-color: var(--border-glass) !important;
  padding: 14px 16px !important;
  font-size: 0.85rem !important;
  text-transform: uppercase;
  letter-spacing: 0.05em;
}
.table tbody tr {
  border-color: var(--border-glass) !important;
  transition: var(--transition);
}
.table tbody tr:hover {
  background: rgba(0,201,177,0.05) !important;
}
.table td, .table th { 
  color: var(--text-white) !important;
  vertical-align: middle !important;
  padding: 14px 16px !important;
  border-color: var(--border-glass) !important;
}
.table-striped>tbody>tr:nth-of-type(odd)>* {
  background-color: rgba(255,255,255,0.03) !important;
  color: var(--text-white) !important;
}
.table-success { --bs-table-bg: transparent !important; }

/* ============================================================
   ANIMATIONS
   ============================================================ */
@keyframes fadeInUp {
  from { opacity: 0; transform: translateY(30px); }
  to   { opacity: 1; transform: translateY(0); }
}
@keyframes fadeIn {
  from { opacity: 0; }
  to   { opacity: 1; }
}
@keyframes slideInLeft {
  from { opacity: 0; transform: translateX(-30px); }
  to   { opacity: 1; transform: translateX(0); }
}
@keyframes pulse-glow {
  0%, 100% { box-shadow: 0 0 10px var(--primary-glow); }
  50% { box-shadow: 0 0 30px var(--primary-glow), 0 0 60px rgba(0,201,177,0.15); }
}
@keyframes countUp { from { opacity: 0.3; } to { opacity: 1; } }

.animate-fade-up { animation: fadeInUp 0.6s ease forwards; }
.animate-fade-in { animation: fadeIn 0.5s ease forwards; }
.anim-delay-1 { animation-delay: 0.1s; }
.anim-delay-2 { animation-delay: 0.2s; }
.anim-delay-3 { animation-delay: 0.3s; }
.anim-delay-4 { animation-delay: 0.4s; }

/* ============================================================
   STAT CARDS
   ============================================================ */
.stat-card {
  background: var(--navy-card);
  border: 1px solid var(--border-glass);
  border-radius: var(--radius-card);
  padding: 28px 24px;
  text-align: center;
  transition: var(--transition);
  cursor: default;
  position: relative;
  overflow: hidden;
}
.stat-card::before {
  content: '';
  position: absolute;
  top: 0; left: 0; right: 0;
  height: 3px;
  background: linear-gradient(90deg, var(--primary), var(--primary-dark));
  border-radius: var(--radius-card) var(--radius-card) 0 0;
}
.stat-card:hover {
  transform: translateY(-6px);
  box-shadow: var(--shadow-card), var(--shadow-glow);
  border-color: rgba(0,201,177,0.3);
}
.stat-card .stat-icon {
  font-size: 2.5rem;
  color: var(--primary);
  margin-bottom: 12px;
  display: block;
}
.stat-card .stat-number {
  font-family: 'Poppins', sans-serif;
  font-size: 2.4rem;
  font-weight: 800;
  color: var(--text-white);
  line-height: 1;
}
.stat-card .stat-label {
  color: var(--text-muted);
  font-size: 0.875rem;
  font-weight: 500;
  margin-top: 4px;
  text-transform: uppercase;
  letter-spacing: 0.08em;
}

/* ============================================================
   SECTION HEADERS
   ============================================================ */
.section-header {
  text-align: center;
  margin-bottom: 48px;
}
.section-header h2 {
  font-size: 2rem;
  color: var(--text-white);
  margin-bottom: 8px;
}
.section-header p {
  color: var(--text-muted);
  font-size: 1.05rem;
}
.section-divider {
  width: 60px; height: 3px;
  background: linear-gradient(90deg, var(--primary), var(--primary-dark));
  border-radius: 3px;
  margin: 12px auto;
}

/* ============================================================
   ALERT / TOAST OVERRIDES
   ============================================================ */
.alert-success-custom {
  background: rgba(0,201,177,0.12);
  border: 1px solid rgba(0,201,177,0.3);
  color: var(--primary);
  border-radius: 10px;
  padding: 12px 16px;
}
.alert-danger-custom {
  background: rgba(255,71,87,0.12);
  border: 1px solid rgba(255,71,87,0.3);
  color: #ff4757;
  border-radius: 10px;
  padding: 12px 16px;
}

/* ============================================================
   NAVBAR (shared base — overridden in navbar.jsp)
   ============================================================ */
.navbar {
  background: rgba(10,22,40,0.85) !important;
  backdrop-filter: blur(20px) !important;
  -webkit-backdrop-filter: blur(20px) !important;
  border-bottom: 1px solid var(--border-glass) !important;
  padding: 14px 0 !important;
}
.navbar-brand {
  font-family: 'Poppins', sans-serif !important;
  font-weight: 700 !important;
  font-size: 1.2rem !important;
  color: var(--primary) !important;
}
.navbar-brand i { margin-right: 8px; }
.nav-link {
  color: var(--text-muted) !important;
  font-weight: 500 !important;
  padding: 8px 16px !important;
  border-radius: 8px !important;
  transition: var(--transition) !important;
  font-size: 0.9rem !important;
}
.nav-link:hover, .nav-link.active {
  color: var(--primary) !important;
  background: rgba(0,201,177,0.08) !important;
}
.navbar-toggler { border-color: var(--border-glass) !important; }
.navbar-toggler-icon { filter: invert(1); }
.dropdown-menu {
  background: var(--navy-mid) !important;
  border: 1px solid var(--border-glass) !important;
  border-radius: 12px !important;
}
.dropdown-item {
  color: var(--text-muted) !important;
  padding: 8px 16px !important;
  transition: var(--transition);
}
.dropdown-item:hover {
  background: rgba(0,201,177,0.1) !important;
  color: var(--primary) !important;
}
</style>

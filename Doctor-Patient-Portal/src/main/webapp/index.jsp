<%@page import="com.hms.entity.Doctor"%>
<%@page import="java.util.List"%>
<%@page import="com.hms.db.DBConnection"%>
<%@page import="com.hms.dao.DoctorDAO"%>
<%@page import="com.hms.dao.ReviewDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page isELIgnored="false"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>MediPortal | Advanced Healthcare System</title>
<meta name="description" content="Book appointments with top doctors online. MediPortal connects patients with qualified medical professionals for fast, reliable healthcare.">
<%@include file="component/allcss.jsp"%>
<style>
/* ── HERO ── */
.hero-section {
  min-height: 92vh;
  background: radial-gradient(ellipse at 60% 50%, rgba(0,201,177,0.12) 0%, transparent 60%),
              radial-gradient(ellipse at 10% 80%, rgba(22,44,82,0.8) 0%, transparent 50%),
              var(--navy);
  display: flex;
  align-items: center;
  position: relative;
  overflow: hidden;
  padding: 80px 0;
}
.hero-section::before {
  content: '';
  position: absolute;
  top: -50%; left: -50%;
  width: 200%; height: 200%;
  background: conic-gradient(from 180deg at 50% 50%, transparent 0deg, rgba(0,201,177,0.03) 60deg, transparent 120deg);
  animation: rotateBg 20s linear infinite;
  pointer-events: none;
}
@keyframes rotateBg {
  from { transform: rotate(0deg); }
  to   { transform: rotate(360deg); }
}
.hero-badge {
  display: inline-flex;
  align-items: center;
  gap: 8px;
  background: rgba(0,201,177,0.12);
  border: 1px solid rgba(0,201,177,0.3);
  border-radius: 30px;
  padding: 6px 16px;
  font-size: 0.8rem;
  color: var(--primary);
  font-weight: 600;
  margin-bottom: 24px;
  animation: fadeInUp 0.5s ease both;
}
.hero-badge span.dot {
  width: 6px; height: 6px;
  border-radius: 50%;
  background: var(--primary);
  animation: pulse 2s infinite;
}
@keyframes pulse { 0%,100% { opacity:1; } 50% { opacity:0.3; } }
.hero-title {
  font-size: clamp(2.4rem, 5vw, 3.8rem);
  font-family: 'Poppins', sans-serif;
  font-weight: 800;
  line-height: 1.15;
  color: var(--text-white);
  animation: fadeInUp 0.6s 0.1s ease both;
}
.hero-title .highlight {
  background: linear-gradient(135deg, #00c9b1, #4dd8cb);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  background-clip: text;
}
.hero-desc {
  color: var(--text-muted);
  font-size: 1.1rem;
  line-height: 1.8;
  max-width: 520px;
  animation: fadeInUp 0.6s 0.2s ease both;
}
.hero-cta {
  display: flex;
  gap: 16px;
  flex-wrap: wrap;
  animation: fadeInUp 0.6s 0.3s ease both;
}
.hero-visual {
  position: relative;
  animation: fadeInUp 0.8s 0.2s ease both;
}
.hero-visual-card {
  background: var(--navy-card);
  border: 1px solid var(--border-glass);
  border-radius: 20px;
  padding: 32px;
  backdrop-filter: blur(20px);
  text-align: center;
  animation: pulse-glow 4s ease-in-out infinite;
}
.hero-visual-card .big-icon {
  font-size: 5rem;
  color: var(--primary);
  margin-bottom: 16px;
  display: block;
}
.hero-stats-row {
  display: flex;
  gap: 20px;
  margin-top: 20px;
  justify-content: center;
}
.mini-stat {
  background: rgba(0,201,177,0.08);
  border: 1px solid rgba(0,201,177,0.2);
  border-radius: 12px;
  padding: 12px 18px;
  text-align: center;
}
.mini-stat .num {
  font-family: 'Poppins', sans-serif;
  font-size: 1.4rem;
  font-weight: 700;
  color: var(--primary);
  display: block;
}
.mini-stat .lbl {
  font-size: 0.75rem;
  color: var(--text-muted);
}

/* ── FEATURES ── */
.feature-icon-wrap {
  width: 64px; height: 64px;
  border-radius: 16px;
  background: rgba(0,201,177,0.1);
  border: 1px solid rgba(0,201,177,0.2);
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 1.6rem;
  color: var(--primary);
  margin-bottom: 16px;
  transition: var(--transition);
}
.glass-card:hover .feature-icon-wrap {
  background: rgba(0,201,177,0.2);
  box-shadow: 0 0 20px var(--primary-glow);
}

/* ── DOCTOR CARDS ── */
.doctor-card {
  background: var(--navy-card);
  border: 1px solid var(--border-glass);
  border-radius: 16px;
  padding: 24px;
  text-align: center;
  transition: var(--transition);
  height: 100%;
}
.doctor-card:hover {
  transform: translateY(-6px);
  border-color: rgba(0,201,177,0.3);
  box-shadow: 0 12px 40px rgba(0,0,0,0.4), 0 0 20px var(--primary-glow);
}
.doctor-avatar {
  width: 80px; height: 80px;
  border-radius: 50%;
  background: linear-gradient(135deg, var(--primary), var(--primary-dark));
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 1.8rem;
  font-weight: 700;
  color: var(--navy);
  font-family: 'Poppins', sans-serif;
  margin: 0 auto 16px;
  border: 3px solid rgba(0,201,177,0.3);
}
.specialist-pill {
  display: inline-block;
  background: rgba(0,201,177,0.1);
  border: 1px solid rgba(0,201,177,0.25);
  border-radius: 20px;
  padding: 3px 12px;
  font-size: 0.75rem;
  color: var(--primary);
  font-weight: 600;
  margin-bottom: 12px;
}
.doctor-search-wrap {
  position: relative;
  max-width: 460px;
  margin: 0 auto 40px;
}
.doctor-search-wrap input {
  padding-left: 44px !important;
}
.doctor-search-wrap .search-icon {
  position: absolute;
  left: 14px;
  top: 50%;
  transform: translateY(-50%);
  color: var(--text-muted);
  pointer-events: none;
}
</style>
</head>
<body>
<%@include file="component/navbar.jsp"%>

<!-- ============================================================ HERO ============================================================ -->
<section class="hero-section">
  <div class="container position-relative" style="z-index:2;">
    <div class="row align-items-center g-5">
      <div class="col-lg-6">
        <div class="hero-badge">
          <span class="dot"></span>
          Trusted Healthcare Platform
        </div>
        <h1 class="hero-title">
          Your Health,<br>Our <span class="highlight">Priority</span>
        </h1>
        <p class="hero-desc">
          Book appointments with qualified specialists in seconds. MediPortal connects you to expert doctors, real-time availability, and digital health management — all in one place.
        </p>
        <div class="hero-cta mt-4">
          <a href="user_appointment.jsp" class="btn btn-primary-teal btn-lg px-4 py-3" id="bookAppointmentBtn">
            <i class="fa fa-calendar-plus me-2"></i> Book Appointment
          </a>
          <a href="user_login.jsp" class="btn btn-outline-teal btn-lg px-4 py-3" id="heroLoginBtn">
            <i class="fas fa-sign-in-alt me-2"></i> Patient Portal
          </a>
        </div>
      </div>
      <div class="col-lg-6">
        <div class="hero-visual">
          <div class="hero-visual-card">
            <span class="big-icon"><i class="fa-solid fa-hospital"></i></span>
            <h4 style="color:var(--text-white); font-family:'Poppins',sans-serif; margin-bottom:8px;">Advanced Healthcare</h4>
            <p style="color:var(--text-muted); font-size:0.9rem; margin:0;">Connect with top specialists from the comfort of your home</p>
            <div class="hero-stats-row">
              <div class="mini-stat">
                <span class="num">500+</span>
                <span class="lbl">Doctors</span>
              </div>
              <div class="mini-stat">
                <span class="num">10K+</span>
                <span class="lbl">Patients</span>
              </div>
              <div class="mini-stat">
                <span class="num">24/7</span>
                <span class="lbl">Support</span>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</section>

<!-- ============================================================ FEATURES ============================================================ -->
<section style="padding: 80px 0; background: var(--navy);">
  <div class="container">
    <div class="section-header animate-fade-up">
      <h2>Why Choose <span style="color:var(--primary);">MediPortal</span>?</h2>
      <div class="section-divider"></div>
      <p>Everything you need for modern healthcare management</p>
    </div>
    <div class="row g-4">
      <div class="col-md-6 col-lg-3 animate-fade-up anim-delay-1">
        <div class="glass-card p-4 h-100">
          <div class="feature-icon-wrap"><i class="fa-solid fa-user-doctor"></i></div>
          <h5 style="color:var(--text-white); font-family:'Poppins',sans-serif; font-size:1.05rem;">Expert Doctors</h5>
          <p style="color:var(--text-muted); font-size:0.875rem; line-height:1.7; margin:0;">Access a network of verified specialists across all medical fields.</p>
        </div>
      </div>
      <div class="col-md-6 col-lg-3 animate-fade-up anim-delay-2">
        <div class="glass-card p-4 h-100">
          <div class="feature-icon-wrap"><i class="fa-solid fa-calendar-check"></i></div>
          <h5 style="color:var(--text-white); font-family:'Poppins',sans-serif; font-size:1.05rem;">Instant Booking</h5>
          <p style="color:var(--text-muted); font-size:0.875rem; line-height:1.7; margin:0;">Book, view, and manage your appointments in real-time, 24/7.</p>
        </div>
      </div>
      <div class="col-md-6 col-lg-3 animate-fade-up anim-delay-3">
        <div class="glass-card p-4 h-100">
          <div class="feature-icon-wrap"><i class="fa-solid fa-shield-heart"></i></div>
          <h5 style="color:var(--text-white); font-family:'Poppins',sans-serif; font-size:1.05rem;">Safe & Secure</h5>
          <p style="color:var(--text-muted); font-size:0.875rem; line-height:1.7; margin:0;">Your medical data and personal information is fully protected.</p>
        </div>
      </div>
      <div class="col-md-6 col-lg-3 animate-fade-up anim-delay-4">
        <div class="glass-card p-4 h-100">
          <div class="feature-icon-wrap"><i class="fa-solid fa-file-medical"></i></div>
          <h5 style="color:var(--text-white); font-family:'Poppins',sans-serif; font-size:1.05rem;">Digital Prescriptions</h5>
          <p style="color:var(--text-muted); font-size:0.875rem; line-height:1.7; margin:0;">Doctors submit digital prescriptions and treatment notes instantly.</p>
        </div>
      </div>
    </div>
  </div>
</section>

<!-- ============================================================ DOCTOR BROWSE ============================================================ -->
<section style="padding: 80px 0; background: linear-gradient(180deg, var(--navy) 0%, var(--navy-mid) 100%);">
  <div class="container">
    <div class="section-header animate-fade-up">
      <h2>Find Your <span style="color:var(--primary);">Doctor</span></h2>
      <div class="section-divider"></div>
      <p>Browse our qualified specialists and book your appointment today</p>
    </div>

    <!-- Search box -->
    <div class="doctor-search-wrap animate-fade-up">
      <span class="search-icon"><i class="fa-solid fa-magnifying-glass"></i></span>
      <input type="text" id="doctorSearch" class="form-control" placeholder="Search by name or specialization…" oninput="filterDoctors(this.value)">
    </div>

    <div class="row g-4" id="doctorGrid">
      <%
        DoctorDAO doctorDAO = new DoctorDAO(DBConnection.getConn());
        ReviewDAO reviewDAO = new ReviewDAO(DBConnection.getConn());
        List<Doctor> allDoctors = doctorDAO.getAllDoctor();
        if (allDoctors.isEmpty()) {
      %>
        <div class="col-12 text-center py-5">
          <i class="fa-solid fa-user-doctor" style="font-size:3rem; color:rgba(0,201,177,0.3);"></i>
          <p style="color:var(--text-muted); margin-top:16px;">No doctors registered yet. Admins can add doctors from the admin panel.</p>
        </div>
      <%
        } else {
          for (Doctor d : allDoctors) {
            String initials = "";
            String name = d.getFullName() != null ? d.getFullName() : "Dr";
            String[] parts = name.trim().split("\\s+");
            for (int i = 0; i < Math.min(2, parts.length); i++) {
              if (parts[i].length() > 0) initials += parts[i].charAt(0);
            }
            double avgRating = reviewDAO.getAverageRating(d.getId());
            int reviewCount = reviewDAO.getReviewCount(d.getId());
      %>
        <div class="col-sm-6 col-lg-4 col-xl-3 doctor-item animate-fade-up"
             data-name="<%= d.getFullName() != null ? d.getFullName().toLowerCase() : "" %>"
             data-specialist="<%= d.getSpecialist() != null ? d.getSpecialist().toLowerCase() : "" %>">
          <div class="doctor-card">
            <div class="doctor-avatar"><%= initials.toUpperCase() %></div>
            <div class="specialist-pill"><%= d.getSpecialist() != null ? d.getSpecialist() : "General" %></div>
            <h6 style="color:var(--text-white); font-family:'Poppins',sans-serif; font-weight:600; margin-bottom:4px;"><%= d.getFullName() %></h6>
            <p style="color:var(--text-muted); font-size:0.8rem; margin-bottom:4px;"><%= d.getQualification() != null ? d.getQualification() : "" %></p>
            <% if (reviewCount > 0) { %>
            <div style="margin-bottom:12px;display:flex;align-items:center;justify-content:center;gap:6px;">
              <span style="color:#ffd32a;font-size:0.85rem;"><% for (int s=1; s<=5; s++) { %><i class="fa-<%= s <= Math.round(avgRating) ? "solid" : "regular" %> fa-star"></i><% } %></span>
              <span style="color:var(--text-muted);font-size:0.75rem;"><%= avgRating %> (<%= reviewCount %>)</span>
            </div>
            <% } else { %>
            <p style="color:var(--text-muted);font-size:0.72rem;margin-bottom:12px;"><i class="fa-regular fa-star me-1"></i>No reviews yet</p>
            <% } %>
            <a href="user_appointment.jsp" class="btn btn-primary-teal w-100 py-2" style="font-size:0.85rem;">
              <i class="fa fa-calendar-plus me-1"></i> Book Appointment
            </a>
          </div>
        </div>
      <%
          }
        }
      %>
    </div>
    <div id="noDocResults" style="display:none; text-align:center; padding:40px 0;">
      <i class="fa-solid fa-magnifying-glass" style="font-size:2rem; color:rgba(0,201,177,0.3);"></i>
      <p style="color:var(--text-muted); margin-top:12px;">No doctors found matching your search.</p>
    </div>
  </div>
</section>

<!-- ============================================================ HOW IT WORKS ============================================================ -->
<section style="padding: 80px 0; background: var(--navy);">
  <div class="container">
    <div class="section-header animate-fade-up">
      <h2>How It <span style="color:var(--primary);">Works</span></h2>
      <div class="section-divider"></div>
      <p>Three simple steps to quality healthcare</p>
    </div>
    <div class="row g-4 justify-content-center">
      <div class="col-md-4 text-center animate-fade-up anim-delay-1">
        <div style="width:72px;height:72px;border-radius:50%;background:rgba(0,201,177,0.12);border:2px solid rgba(0,201,177,0.3);display:flex;align-items:center;justify-content:center;margin:0 auto 20px;font-size:1.6rem;color:var(--primary);">
          <i class="fa-solid fa-user-plus"></i>
        </div>
        <h5 style="color:var(--text-white);font-family:'Poppins',sans-serif;">1. Register</h5>
        <p style="color:var(--text-muted);font-size:0.9rem;">Create your free patient account in under a minute.</p>
      </div>
      <div class="col-md-4 text-center animate-fade-up anim-delay-2">
        <div style="width:72px;height:72px;border-radius:50%;background:rgba(0,201,177,0.12);border:2px solid rgba(0,201,177,0.3);display:flex;align-items:center;justify-content:center;margin:0 auto 20px;font-size:1.6rem;color:var(--primary);">
          <i class="fa-solid fa-calendar-plus"></i>
        </div>
        <h5 style="color:var(--text-white);font-family:'Poppins',sans-serif;">2. Book</h5>
        <p style="color:var(--text-muted);font-size:0.9rem;">Choose your doctor, pick a date, and submit your appointment.</p>
      </div>
      <div class="col-md-4 text-center animate-fade-up anim-delay-3">
        <div style="width:72px;height:72px;border-radius:50%;background:rgba(0,201,177,0.12);border:2px solid rgba(0,201,177,0.3);display:flex;align-items:center;justify-content:center;margin:0 auto 20px;font-size:1.6rem;color:var(--primary);">
          <i class="fa-solid fa-stethoscope"></i>
        </div>
        <h5 style="color:var(--text-white);font-family:'Poppins',sans-serif;">3. Get Care</h5>
        <p style="color:var(--text-muted);font-size:0.9rem;">Receive expert consultation and a digital prescription from your doctor.</p>
      </div>
    </div>
  </div>
</section>

<!-- footer -->
<%@include file="component/footer.jsp"%>

<script>
function filterDoctors(query) {
  const q = query.toLowerCase().trim();
  const items = document.querySelectorAll('.doctor-item');
  let visible = 0;
  items.forEach(item => {
    const name = item.dataset.name || '';
    const spec = item.dataset.specialist || '';
    if (q === '' || name.includes(q) || spec.includes(q)) {
      item.style.display = '';
      visible++;
    } else {
      item.style.display = 'none';
    }
  });
  document.getElementById('noDocResults').style.display = (visible === 0 && q !== '') ? 'block' : 'none';
}
</script>
</body>
</html>
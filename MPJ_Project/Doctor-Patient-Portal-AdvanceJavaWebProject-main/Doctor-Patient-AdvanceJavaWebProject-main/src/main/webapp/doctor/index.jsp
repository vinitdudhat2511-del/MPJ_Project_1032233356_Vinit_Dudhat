<%@page import="com.hms.entity.Doctor"%>
<%@page import="com.hms.db.DBConnection"%>
<%@page import="com.hms.dao.DoctorDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page isELIgnored="false"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Doctor Dashboard | MediPortal</title>
<%@include file="../component/allcss.jsp"%>
</head>
<body>
<%@include file="navbar.jsp"%>

<c:if test="${empty doctorObj}">
  <c:redirect url="../doctor_login.jsp"/>
</c:if>

<%
  DoctorDAO docDAO = new DoctorDAO(DBConnection.getConn());
  Doctor currentDoctor = (Doctor) session.getAttribute("doctorObj");
  int myAppointments = docDAO.countTotalAppointmentByDoctorId(currentDoctor.getId());
  int totalDoctors = docDAO.countTotalDoctor();
%>

<!-- Welcome Banner -->
<div style="background:linear-gradient(135deg,rgba(0,201,177,0.15) 0%,rgba(10,22,40,0) 70%),var(--navy-mid);padding:48px 0 40px;border-bottom:1px solid var(--border-glass);margin-bottom:48px;">
  <div class="container">
    <div style="display:flex;align-items:center;gap:20px;">
      <div style="width:72px;height:72px;border-radius:50%;background:linear-gradient(135deg,#00c9b1,#00a89a);display:flex;align-items:center;justify-content:center;font-size:1.8rem;font-weight:700;color:#0a1628;font-family:'Poppins',sans-serif;flex-shrink:0;">
        <%= currentDoctor.getFullName() != null && currentDoctor.getFullName().length() > 0 ? String.valueOf(currentDoctor.getFullName().charAt(0)).toUpperCase() : "D" %>
      </div>
      <div>
        <h1 style="font-family:'Poppins',sans-serif;color:var(--text-white);font-size:1.9rem;margin-bottom:4px;">
          Welcome, Dr. <%= currentDoctor.getFullName() %> 👋
        </h1>
        <p style="color:var(--text-muted);margin:0;">
          <span style="color:var(--primary);font-weight:500;"><%= currentDoctor.getSpecialist() %></span> &mdash; <%= currentDoctor.getQualification() %>
        </p>
      </div>
    </div>
  </div>
</div>

<div class="container pb-5">
  <div class="row g-4 mb-4">
    <div class="col-sm-6 col-lg-4 animate-fade-up anim-delay-1">
      <a href="patient.jsp" style="text-decoration:none;">
        <div class="stat-card">
          <span class="stat-icon"><i class="fa-solid fa-calendar-check"></i></span>
          <div class="stat-number"><%= myAppointments %></div>
          <div class="stat-label">My Appointments</div>
        </div>
      </a>
    </div>
    <div class="col-sm-6 col-lg-4 animate-fade-up anim-delay-2">
      <div class="stat-card">
        <span class="stat-icon"><i class="fa-solid fa-user-doctor"></i></span>
        <div class="stat-number"><%= totalDoctors %></div>
        <div class="stat-label">Total Doctors</div>
      </div>
    </div>
    <div class="col-sm-6 col-lg-4 animate-fade-up anim-delay-3">
      <div class="stat-card">
        <span class="stat-icon"><i class="fa-solid fa-stethoscope"></i></span>
        <div class="stat-number" style="font-size:1.2rem;"><%= currentDoctor.getSpecialist() %></div>
        <div class="stat-label">Specialization</div>
      </div>
    </div>
  </div>

  <div class="glass-card p-4 animate-fade-up">
    <h5 style="color:var(--text-white);font-family:'Poppins',sans-serif;margin-bottom:16px;"><i class="fa-solid fa-bolt me-2" style="color:var(--primary);"></i>Quick Actions</h5>
    <a href="patient.jsp" class="btn btn-primary-teal px-4 py-2 me-2">
      <i class="fa-solid fa-users me-2"></i> View Patient Appointments
    </a>
    <a href="edit_profile.jsp" class="btn btn-outline-teal px-4 py-2">
      <i class="fa-solid fa-pen me-2"></i> Edit My Profile
    </a>
  </div>
</div>
</body>
</html>
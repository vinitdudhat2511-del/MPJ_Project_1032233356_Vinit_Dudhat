<%@page import="com.hms.entity.Doctor"%>
<%@page import="com.hms.dao.DoctorDAO"%>
<%@page import="com.hms.entity.Appointment"%>
<%@page import="java.util.List"%>
<%@page import="com.hms.db.DBConnection"%>
<%@page import="com.hms.dao.AppointmentDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page isELIgnored="false"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Patient Appointments | Admin</title>
<%@include file="../component/allcss.jsp"%>
</head>
<body>
<%@include file="navbar.jsp"%>
<c:if test="${empty adminObj}"><c:redirect url="../admin_login.jsp"/></c:if>

<div style="background:linear-gradient(135deg,rgba(0,201,177,0.10) 0%,transparent 60%),var(--navy-mid);padding:48px 0 32px;border-bottom:1px solid var(--border-glass);margin-bottom:48px;">
  <div class="container">
    <h1 style="font-family:'Poppins',sans-serif;color:var(--text-white);font-size:2rem;margin-bottom:6px;">
      <i class="fa-solid fa-calendar-check me-2" style="color:var(--primary);"></i>Patient Appointments
    </h1>
    <p style="color:var(--text-muted);margin:0;">Review, approve or reject patient appointment requests</p>
  </div>
</div>

<div class="container pb-5">
  <c:if test="${not empty successMsg}">
    <div class="alert-success-custom mb-4"><i class="fa-solid fa-circle-check me-2"></i>${successMsg}</div>
    <c:remove var="successMsg" scope="session"/>
  </c:if>
  <c:if test="${not empty errorMsg}">
    <div class="alert-danger-custom mb-4"><i class="fa-solid fa-circle-exclamation me-2"></i>${errorMsg}</div>
    <c:remove var="errorMsg" scope="session"/>
  </c:if>

  <div class="glass-card p-0 overflow-hidden animate-fade-up">
    <div style="padding:20px 24px;border-bottom:1px solid var(--border-glass);">
      <h5 style="color:var(--text-white);margin:0;font-family:'Poppins',sans-serif;">All Appointments</h5>
    </div>
    <div class="table-responsive">
      <table class="table mb-0">
        <thead><tr><th>Patient</th><th>Gender/Age</th><th>Date & Time</th><th>Disease</th><th>Doctor</th><th>Phone</th><th>Status</th><th>Actions</th></tr></thead>
        <tbody>
          <%
            AppointmentDAO appDAO = new AppointmentDAO(DBConnection.getConn());
            DoctorDAO docDAO = new DoctorDAO(DBConnection.getConn());
            List<Appointment> list = appDAO.getAllAppointment();
            for (Appointment a : list) {
              Doctor doctor = docDAO.getDoctorById(a.getDoctorId());
              String status = a.getStatus();
              String bc = "badge-pending";
              if ("Approved".equalsIgnoreCase(status)) bc = "badge-approved";
              else if ("Rejected".equalsIgnoreCase(status)) bc = "badge-rejected";
              else if ("Cancelled".equalsIgnoreCase(status)) bc = "badge-cancelled";
          %>
          <tr>
            <td><strong style="color:var(--text-white);"><%=a.getFullName()%></strong></td>
            <td style="color:var(--text-muted);"><%=a.getGender()%>, <%=a.getAge()%>yrs</td>
            <td style="color:var(--text-muted);"><%=a.getAppointmentDate()%><% if(a.getTimeSlot()!=null && !a.getTimeSlot().isEmpty()){%><br><span style="color:var(--primary);font-size:0.8rem;"><i class="fa-solid fa-clock me-1"></i><%=a.getTimeSlot()%></span><%}%></td>
            <td style="color:var(--text-muted);"><%=a.getDiseases()%></td>
            <td style="color:var(--text-white);">Dr. <%=doctor != null ? doctor.getFullName() : "N/A"%></td>
            <td style="color:var(--text-muted);"><%=a.getPhone()%></td>
            <td><span class="<%=bc%>"><%=status%></span></td>
            <td>
              <% if ("Pending".equalsIgnoreCase(status)) { %>
                <div class="d-flex gap-2">
                  <a href="../adminUpdateAppointment?id=<%=a.getId()%>&status=Approved" class="btn btn-success btn-sm py-1 px-3" onclick="return confirm('Approve this appointment?')"><i class="fa-solid fa-check me-1"></i>Approve</a>
                  <a href="../adminUpdateAppointment?id=<%=a.getId()%>&status=Rejected" class="btn btn-danger btn-sm py-1 px-3" onclick="return confirm('Reject this appointment?')"><i class="fa-solid fa-xmark me-1"></i>Reject</a>
                </div>
              <% } else { %>
                <span style="color:var(--text-muted);font-size:0.82rem;">No action</span>
              <% } %>
            </td>
          </tr>
          <% } %>
        </tbody>
      </table>
    </div>
  </div>
</div>
</body>
</html>
<%@page import="com.hms.entity.Appointment"%>
<%@page import="java.util.List"%>
<%@page import="com.hms.entity.Doctor"%>
<%@page import="com.hms.dao.AppointmentDAO"%>
<%@page import="com.hms.db.DBConnection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page isELIgnored="false"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>My Patients | Doctor | MediPortal</title>
<%@include file="../component/allcss.jsp"%>
</head>
<body>
<%@include file="navbar.jsp"%>
<c:if test="${empty doctorObj}"><c:redirect url="../doctor_login.jsp"/></c:if>

<div style="background:linear-gradient(135deg,rgba(0,201,177,0.10) 0%,transparent 60%),var(--navy-mid);padding:48px 0 32px;border-bottom:1px solid var(--border-glass);margin-bottom:48px;">
  <div class="container">
    <h1 style="font-family:'Poppins',sans-serif;color:var(--text-white);font-size:2rem;margin-bottom:6px;">
      <i class="fa-solid fa-users me-2" style="color:var(--primary);"></i>Patient Appointments
    </h1>
    <p style="color:var(--text-muted);margin:0;">Manage and respond to your patient appointments</p>
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
      <h5 style="color:var(--text-white);margin:0;font-family:'Poppins',sans-serif;">Your Patient List</h5>
    </div>
    <div class="table-responsive">
      <table class="table mb-0">
        <thead><tr><th>Patient</th><th>Gender/Age</th><th>Date & Time</th><th>Email</th><th>Phone</th><th>Disease</th><th>Status</th><th>Action</th></tr></thead>
        <tbody>
          <%
            Doctor doctor = (Doctor) session.getAttribute("doctorObj");
            AppointmentDAO appDAO = new AppointmentDAO(DBConnection.getConn());
            List<Appointment> list = appDAO.getAllAppointmentByLoginDoctor(doctor.getId());
            if (list.isEmpty()) {
          %>
            <tr><td colspan="8" style="text-align:center;padding:40px;color:var(--text-muted);">
              <i class="fa-solid fa-calendar-xmark" style="font-size:2rem;display:block;margin-bottom:10px;color:rgba(0,201,177,0.4);"></i>No patient appointments yet.
            </td></tr>
          <% } else { for (Appointment appt : list) {
                String status = appt.getStatus();
                String bc = "badge-pending";
                if ("Approved".equalsIgnoreCase(status)) bc = "badge-approved";
                else if ("Rejected".equalsIgnoreCase(status)) bc = "badge-rejected";
                else if ("Cancelled".equalsIgnoreCase(status)) bc = "badge-cancelled";
          %>
            <tr>
              <td><strong style="color:var(--text-white);"><%=appt.getFullName()%></strong></td>
              <td style="color:var(--text-muted);"><%=appt.getGender()%>, <%=appt.getAge()%>yrs</td>
              <td style="color:var(--text-muted);"><%=appt.getAppointmentDate()%><% if(appt.getTimeSlot()!=null && !appt.getTimeSlot().isEmpty()){%><br><span style="color:var(--primary);font-size:0.8rem;"><i class="fa-solid fa-clock me-1"></i><%=appt.getTimeSlot()%></span><%}%></td>
              <td style="color:var(--text-muted);"><%=appt.getEmail()%></td>
              <td style="color:var(--text-muted);"><%=appt.getPhone()%></td>
              <td style="color:var(--text-muted);"><%=appt.getDiseases()%></td>
              <td><span class="<%=bc%>"><%=status%></span></td>
              <td>
                <% if ("Pending".equals(status) || "Approved".equalsIgnoreCase(status)) { %>
                  <a href="comment.jsp?id=<%=appt.getId()%>" class="btn btn-success btn-sm py-1 px-3"><i class="fa fa-comment me-1"></i>Prescribe</a>
                <% } else { %>
                  <span style="color:var(--text-muted);font-size:0.82rem;">No action</span>
                <% } %>
              </td>
            </tr>
          <% } } %>
        </tbody>
      </table>
    </div>
  </div>
</div>
</body>
</html>
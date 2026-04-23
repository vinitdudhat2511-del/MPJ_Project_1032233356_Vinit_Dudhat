<%@page import="com.hms.entity.Appointment"%>
<%@page import="com.hms.db.DBConnection"%>
<%@page import="com.hms.dao.AppointmentDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page isELIgnored="false"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Write Prescription | MediPortal</title>
<%@include file="../component/allcss.jsp"%>
</head>
<body>
<%@include file="navbar.jsp"%>

<c:if test="${empty doctorObj}">
  <c:redirect url="../doctor_login.jsp"/>
</c:if>

<div style="background:linear-gradient(135deg,rgba(0,201,177,0.10) 0%,transparent 60%),var(--navy-mid);padding:48px 0 32px;border-bottom:1px solid var(--border-glass);margin-bottom:48px;">
  <div class="container">
    <h1 style="font-family:'Poppins',sans-serif;color:var(--text-white);font-size:2rem;margin-bottom:6px;">
      <i class="fa-solid fa-file-medical me-2" style="color:var(--primary);"></i>Write Prescription
    </h1>
    <p style="color:var(--text-muted);margin:0;">Review patient details and leave your treatment notes</p>
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

  <%
    int id = Integer.parseInt(request.getParameter("id"));
    AppointmentDAO appDAO = new AppointmentDAO(DBConnection.getConn());
    Appointment appointment = appDAO.getAppointmentById(id);
  %>

  <div class="row justify-content-center">
    <div class="col-lg-7">
      <div class="glass-card p-4 p-md-5 animate-fade-up">

        <!-- Patient Info section -->
        <div style="background:rgba(0,201,177,0.06);border:1px solid rgba(0,201,177,0.15);border-radius:12px;padding:16px 20px;margin-bottom:28px;">
          <h6 style="color:var(--primary);font-family:'Poppins',sans-serif;margin-bottom:12px;"><i class="fa-solid fa-user-injured me-2"></i>Patient Details</h6>
          <div class="row g-2">
            <div class="col-6"><span style="color:var(--text-muted);font-size:0.8rem;">Name</span><br><strong style="color:var(--text-white);"><%=appointment.getFullName()%></strong></div>
            <div class="col-6"><span style="color:var(--text-muted);font-size:0.8rem;">Age</span><br><strong style="color:var(--text-white);"><%=appointment.getAge()%> years</strong></div>
            <div class="col-6"><span style="color:var(--text-muted);font-size:0.8rem;">Phone</span><br><strong style="color:var(--text-white);"><%=appointment.getPhone()%></strong></div>
            <div class="col-6"><span style="color:var(--text-muted);font-size:0.8rem;">Disease / Symptoms</span><br><strong style="color:var(--text-white);"><%=appointment.getDiseases()%></strong></div>
          </div>
        </div>

        <form class="row g-3" action="../updateStatus" method="post">
          <input type="hidden" name="id" value="<%=appointment.getId()%>">
          <input type="hidden" name="doctorId" value="<%=appointment.getDoctorId()%>">

          <div class="col-12">
            <label class="form-label">Prescription / Treatment Notes</label>
            <textarea name="comment" required class="form-control" rows="5"
              placeholder="Write your diagnosis, treatment plan, medications, and follow-up instructions…"></textarea>
          </div>
          <div class="col-12 mt-2">
            <button type="submit" class="btn btn-primary-teal w-100 py-3" id="submitPrescriptionBtn">
              <i class="fa-solid fa-paper-plane me-2"></i> Submit Prescription
            </button>
          </div>
          <div class="col-12 text-center">
            <a href="patient.jsp" style="color:var(--text-muted);font-size:0.875rem;text-decoration:none;">
              <i class="fa-solid fa-arrow-left me-1"></i> Back to patient list
            </a>
          </div>
        </form>
      </div>
    </div>
  </div>
</div>
</body>
</html>
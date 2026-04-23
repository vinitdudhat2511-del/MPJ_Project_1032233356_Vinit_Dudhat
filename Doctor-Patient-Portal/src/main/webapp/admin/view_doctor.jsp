<%@page import="com.hms.entity.Doctor"%>
<%@page import="com.hms.dao.DoctorDAO"%>
<%@page import="java.util.List"%>
<%@page import="com.hms.db.DBConnection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page isELIgnored="false"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Doctor List | Admin | MediPortal</title>
<%@include file="../component/allcss.jsp"%>
</head>
<body>
<%@include file="navbar.jsp"%>
<c:if test="${empty adminObj}"><c:redirect url="../admin_login.jsp"/></c:if>

<div style="background:linear-gradient(135deg,rgba(0,201,177,0.10) 0%,transparent 60%),var(--navy-mid);padding:48px 0 32px;border-bottom:1px solid var(--border-glass);margin-bottom:48px;">
  <div class="container">
    <h1 style="font-family:'Poppins',sans-serif;color:var(--text-white);font-size:2rem;margin-bottom:6px;">
      <i class="fa-solid fa-list me-2" style="color:var(--primary);"></i>All Doctors
    </h1>
    <p style="color:var(--text-muted);margin:0;">Manage your registered medical professionals</p>
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
    <div style="padding:20px 24px;border-bottom:1px solid var(--border-glass);display:flex;justify-content:space-between;align-items:center;">
      <h5 style="color:var(--text-white);margin:0;font-family:'Poppins',sans-serif;">Registered Doctors</h5>
      <a href="doctor.jsp" class="btn btn-primary-teal btn-sm px-3"><i class="fa-solid fa-plus me-1"></i>Add Doctor</a>
    </div>
    <div class="table-responsive">
      <table class="table mb-0">
        <thead><tr><th>Name</th><th>DOB</th><th>Qualification</th><th>Specialist</th><th>Email</th><th>Phone</th><th class="text-center">Actions</th></tr></thead>
        <tbody>
          <%
            DoctorDAO docDAO2 = new DoctorDAO(DBConnection.getConn());
            List<Doctor> listOfDoc = docDAO2.getAllDoctor();
            for (Doctor d : listOfDoc) {
          %>
          <tr>
            <td><strong style="color:var(--text-white);"><%=d.getFullName()%></strong></td>
            <td style="color:var(--text-muted);"><%=d.getDateOfBirth()%></td>
            <td style="color:var(--text-muted);"><%=d.getQualification()%></td>
            <td><span class="specialist-pill" style="display:inline-block;background:rgba(0,201,177,0.1);border:1px solid rgba(0,201,177,0.25);border-radius:20px;padding:3px 12px;font-size:0.75rem;color:#00c9b1;font-weight:600;"><%=d.getSpecialist()%></span></td>
            <td style="color:var(--text-muted);"><%=d.getEmail()%></td>
            <td style="color:var(--text-muted);"><%=d.getPhone()%></td>
            <td class="text-center">
              <a class="btn btn-sm btn-primary-teal px-3 me-1" href="edit_doctor.jsp?id=<%=d.getId()%>"><i class="fa-solid fa-pen me-1"></i>Edit</a>
              <a class="btn btn-sm btn-danger px-3" href="../deleteDoctor?id=<%=d.getId()%>" onclick="return confirm('Delete this doctor?')"><i class="fa-solid fa-trash me-1"></i>Delete</a>
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
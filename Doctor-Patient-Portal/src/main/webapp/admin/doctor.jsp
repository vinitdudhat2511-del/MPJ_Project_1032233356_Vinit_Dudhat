<%@page import="com.hms.entity.Specialist"%>
<%@page import="java.util.List"%>
<%@page import="com.hms.db.DBConnection"%>
<%@page import="com.hms.dao.SpecialistDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page isELIgnored="false"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Add Doctor | Admin | MediPortal</title>
<%@include file="../component/allcss.jsp"%>
</head>
<body>
<%@include file="navbar.jsp"%>
<c:if test="${empty adminObj}"><c:redirect url="../admin_login.jsp"/></c:if>

<div style="background:linear-gradient(135deg,rgba(0,201,177,0.10) 0%,transparent 60%),var(--navy-mid);padding:48px 0 32px;border-bottom:1px solid var(--border-glass);margin-bottom:48px;">
  <div class="container text-center">
    <h1 style="font-family:'Poppins',sans-serif;color:var(--text-white);font-size:2rem;margin-bottom:8px;">
      <i class="fa-solid fa-user-doctor me-2" style="color:var(--primary);"></i>Register New Doctor
    </h1>
    <p style="color:var(--text-muted);">Add a qualified doctor to the MediPortal network</p>
  </div>
</div>

<div class="container pb-5">
  <div class="row justify-content-center">
    <div class="col-lg-6">
      <div class="glass-card p-4 p-md-5 animate-fade-up">
        <c:if test="${not empty successMsg}">
          <div class="alert-success-custom mb-4"><i class="fa-solid fa-circle-check me-2"></i>${successMsg}</div>
          <c:remove var="successMsg" scope="session"/>
        </c:if>
        <c:if test="${not empty errorMsg}">
          <div class="alert-danger-custom mb-4"><i class="fa-solid fa-circle-exclamation me-2"></i>${errorMsg}</div>
          <c:remove var="errorMsg" scope="session"/>
        </c:if>

        <form class="row g-3" action="../addDoctor" method="post">
          <div class="col-md-6">
            <label class="form-label">Full Name</label>
            <input name="fullName" type="text" placeholder="Doctor's full name" class="form-control" required>
          </div>
          <div class="col-md-6">
            <label class="form-label">Date of Birth</label>
            <input name="dateOfBirth" type="date" class="form-control" required>
          </div>
          <div class="col-md-6">
            <label class="form-label">Qualification</label>
            <input name="qualification" type="text" placeholder="e.g. MBBS, MD" class="form-control" required>
          </div>
          <div class="col-md-6">
            <label class="form-label">Specialist</label>
            <select class="form-select" name="specialist" required>
              <option disabled selected>— Select Specialization —</option>
              <%
                SpecialistDAO spDAO = new SpecialistDAO(DBConnection.getConn());
                List<Specialist> spList = spDAO.getAllSpecialist();
                for (Specialist sp : spList) {
              %>
                <option><%= sp.getSpecialistName() %></option>
              <% } %>
            </select>
          </div>
          <div class="col-md-6">
            <label class="form-label">Email</label>
            <input name="email" type="email" placeholder="doctor@hospital.com" class="form-control" required>
          </div>
          <div class="col-md-6">
            <label class="form-label">Phone</label>
            <input name="phone" type="tel" placeholder="Mobile number" class="form-control" required>
          </div>
          <div class="col-12">
            <label class="form-label">Password</label>
            <input name="password" type="password" placeholder="Set login password" class="form-control" required>
          </div>
          <div class="col-12 mt-2">
            <button type="submit" class="btn btn-primary-teal w-100 py-3"><i class="fa-solid fa-user-plus me-2"></i>Register Doctor</button>
          </div>
        </form>
      </div>
    </div>
  </div>
</div>
</body>
</html>
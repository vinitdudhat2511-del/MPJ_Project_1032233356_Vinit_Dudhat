<%@page import="java.util.List"%>
<%@page import="com.hms.db.DBConnection"%>
<%@page import="com.hms.entity.Specialist"%>
<%@page import="com.hms.dao.SpecialistDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page isELIgnored="false"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Edit Profile | Doctor | MediPortal</title>
<%@include file="../component/allcss.jsp"%>
</head>
<body>
<%@include file="navbar.jsp"%>
<c:if test="${empty doctorObj}"><c:redirect url="../doctor_login.jsp"/></c:if>

<div style="background:linear-gradient(135deg,rgba(0,201,177,0.10) 0%,transparent 60%),var(--navy-mid);padding:48px 0 32px;border-bottom:1px solid var(--border-glass);margin-bottom:48px;">
  <div class="container text-center">
    <h1 style="font-family:'Poppins',sans-serif;color:var(--text-white);font-size:2rem;margin-bottom:8px;">
      <i class="fa-solid fa-user-pen me-2" style="color:var(--primary);"></i>My Profile Settings
    </h1>
    <p style="color:var(--text-muted);">Update your profile information and change your password</p>
  </div>
</div>

<div class="container pb-5">
  <div class="row g-4 justify-content-center">

    <!-- Change Password Card -->
    <div class="col-lg-4">
      <div class="glass-card p-4 animate-fade-up" style="height:100%;">
        <div style="width:56px;height:56px;border-radius:50%;background:rgba(0,201,177,0.12);border:2px solid rgba(0,201,177,0.3);display:flex;align-items:center;justify-content:center;font-size:1.4rem;color:var(--primary);margin:0 auto 20px;">
          <i class="fa-solid fa-key"></i>
        </div>
        <h5 style="text-align:center;color:var(--text-white);font-family:'Poppins',sans-serif;margin-bottom:20px;">Change Password</h5>

        <c:if test="${not empty successMsg}">
          <div class="alert-success-custom mb-3" style="font-size:0.85rem;"><i class="fa-solid fa-circle-check me-2"></i>${successMsg}</div>
          <c:remove var="successMsg" scope="session"/>
        </c:if>
        <c:if test="${not empty errorMsg}">
          <div class="alert-danger-custom mb-3" style="font-size:0.85rem;"><i class="fa-solid fa-circle-exclamation me-2"></i>${errorMsg}</div>
          <c:remove var="errorMsg" scope="session"/>
        </c:if>

        <form action="../doctorChangePassword" method="post">
          <div class="mb-3">
            <label class="form-label">New Password</label>
            <input name="newPassword" type="password" placeholder="Enter new password" class="form-control" required>
          </div>
          <div class="mb-3">
            <label class="form-label">Current Password</label>
            <input name="oldPassword" type="password" placeholder="Enter current password" class="form-control" required>
          </div>
          <input type="hidden" value="${doctorObj.id}" name="doctorId">
          <button type="submit" class="btn btn-primary-teal w-100 py-2"><i class="fa-solid fa-lock me-2"></i>Update Password</button>
        </form>
      </div>
    </div>

    <!-- Edit Profile Card -->
    <div class="col-lg-6">
      <div class="glass-card p-4 animate-fade-up" style="height:100%;">
        <div style="width:56px;height:56px;border-radius:50%;background:rgba(0,201,177,0.12);border:2px solid rgba(0,201,177,0.3);display:flex;align-items:center;justify-content:center;font-size:1.4rem;color:var(--primary);margin:0 auto 20px;">
          <i class="fa-solid fa-user-doctor"></i>
        </div>
        <h5 style="text-align:center;color:var(--text-white);font-family:'Poppins',sans-serif;margin-bottom:20px;">Edit Profile</h5>

        <c:if test="${not empty successMsgForD}">
          <div class="alert-success-custom mb-3" style="font-size:0.85rem;"><i class="fa-solid fa-circle-check me-2"></i>${successMsgForD}</div>
          <c:remove var="successMsgForD" scope="session"/>
        </c:if>
        <c:if test="${not empty errorMsgForD}">
          <div class="alert-danger-custom mb-3" style="font-size:0.85rem;"><i class="fa-solid fa-circle-exclamation me-2"></i>${errorMsgForD}</div>
          <c:remove var="errorMsgForD" scope="session"/>
        </c:if>

        <form class="row g-3" action="../doctorEditProfile" method="post">
          <div class="col-md-6">
            <label class="form-label">Full Name</label>
            <input name="fullName" type="text" class="form-control" value="${doctorObj.fullName}" required>
          </div>
          <div class="col-md-6">
            <label class="form-label">Date of Birth</label>
            <input name="dateOfBirth" type="date" class="form-control" value="${doctorObj.dateOfBirth}">
          </div>
          <div class="col-md-6">
            <label class="form-label">Qualification</label>
            <input name="qualification" type="text" class="form-control" value="${doctorObj.qualification}">
          </div>
          <div class="col-md-6">
            <label class="form-label">Specialist</label>
            <select class="form-select" name="specialist">
              <option>${doctorObj.specialist}</option>
              <%
                SpecialistDAO spDAO = new SpecialistDAO(DBConnection.getConn());
                List<Specialist> spList = spDAO.getAllSpecialist();
                for (Specialist sp : spList) {
              %>
                <option><%=sp.getSpecialistName()%></option>
              <% } %>
            </select>
          </div>
          <div class="col-md-6">
            <label class="form-label">Email</label>
            <input name="email" type="email" class="form-control" value="${doctorObj.email}" readonly>
          </div>
          <div class="col-md-6">
            <label class="form-label">Phone</label>
            <input name="phone" type="tel" class="form-control" value="${doctorObj.phone}">
          </div>
          <input type="hidden" value="${doctorObj.id}" name="doctorId">
          <div class="col-12 mt-2">
            <button type="submit" class="btn btn-primary-teal w-100 py-2"><i class="fa-solid fa-save me-2"></i>Update Profile</button>
          </div>
        </form>
      </div>
    </div>

  </div>
</div>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page isELIgnored="false"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Change Password | MediPortal</title>
<%@include file="component/allcss.jsp"%>
</head>
<body>
<%@include file="component/navbar.jsp"%>

<c:if test="${empty userObj}"><c:redirect url="/user_login.jsp"/></c:if>

<div style="min-height:80vh;display:flex;align-items:center;justify-content:center;padding:40px 16px;">
  <div style="width:100%;max-width:420px;" class="animate-fade-up">
    <div class="glass-card p-4 p-md-5">
      <div style="width:72px;height:72px;border-radius:50%;background:rgba(0,201,177,0.12);border:2px solid rgba(0,201,177,0.3);display:flex;align-items:center;justify-content:center;font-size:1.8rem;color:var(--primary);margin:0 auto 24px;">
        <i class="fa-solid fa-key"></i>
      </div>
      <h1 style="font-family:'Poppins',sans-serif;font-size:1.5rem;font-weight:700;color:var(--text-white);text-align:center;margin-bottom:4px;">Change Password</h1>
      <p style="color:var(--text-muted);text-align:center;font-size:0.9rem;margin-bottom:28px;">Update your account password</p>

      <c:if test="${not empty successMsg}">
        <div class="alert-success-custom mb-3"><i class="fa-solid fa-circle-check me-2"></i>${successMsg}</div>
        <c:remove var="successMsg" scope="session"/>
      </c:if>
      <c:if test="${not empty errorMsg}">
        <div class="alert-danger-custom mb-3"><i class="fa-solid fa-circle-exclamation me-2"></i>${errorMsg}</div>
        <c:remove var="errorMsg" scope="session"/>
      </c:if>

      <form action="userChangePassword" method="post">
        <div class="mb-4">
          <label class="form-label">New Password</label>
          <input name="newPassword" type="password" placeholder="Enter new password" class="form-control" required>
        </div>
        <div class="mb-4">
          <label class="form-label">Current Password</label>
          <input name="oldPassword" type="password" placeholder="Enter current password" class="form-control" required>
        </div>
        <input type="hidden" value="${userObj.id}" name="userId">
        <button type="submit" class="btn btn-primary-teal w-100 py-3"><i class="fa-solid fa-key me-2"></i>Change Password</button>
      </form>
    </div>
  </div>
</div>
</body>
</html>
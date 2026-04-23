<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page isELIgnored="false"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Patient Login | MediPortal</title>
<%@include file="component/allcss.jsp"%>
<style>
.auth-page{min-height:100vh;display:flex;align-items:center;justify-content:center;padding:40px 16px;}
.auth-card{width:100%;max-width:420px;background:var(--navy-card);border:1px solid var(--border-glass);border-radius:20px;padding:40px 36px;box-shadow:0 20px 60px rgba(0,0,0,0.5);animation:fadeInUp 0.5s ease;}
.auth-icon-wrap{width:72px;height:72px;border-radius:50%;background:rgba(0,201,177,0.12);border:2px solid rgba(0,201,177,0.3);display:flex;align-items:center;justify-content:center;font-size:1.8rem;color:var(--primary);margin:0 auto 24px;}
.auth-title{font-family:'Poppins',sans-serif;font-size:1.6rem;font-weight:700;color:var(--text-white);text-align:center;margin-bottom:4px;}
.auth-subtitle{color:var(--text-muted);text-align:center;font-size:0.9rem;margin-bottom:28px;}
</style>
</head>
<body>
<%@include file="component/navbar.jsp"%>
<div class="auth-page">
  <div class="auth-card">
    <div class="auth-icon-wrap"><i class="fa-solid fa-user-injured"></i></div>
    <h1 class="auth-title">Patient Login</h1>
    <p class="auth-subtitle">Welcome back! Sign in to manage your appointments</p>
    <c:if test="${not empty successMsg}">
      <div class="alert-success-custom mb-3"><i class="fa-solid fa-circle-check me-2"></i>${successMsg}</div>
      <c:remove var="successMsg" scope="session"/>
    </c:if>
    <c:if test="${not empty errorMsg}">
      <div class="alert-danger-custom mb-3"><i class="fa-solid fa-circle-exclamation me-2"></i>${errorMsg}</div>
      <c:remove var="errorMsg" scope="session"/>
    </c:if>
    <form action="userLogin" method="post">
      <div class="mb-4">
        <label class="form-label">Email Address</label>
        <input name="email" type="email" placeholder="your@email.com" class="form-control" id="patientEmail" required>
      </div>
      <div class="mb-4">
        <label class="form-label">Password</label>
        <input name="password" type="password" placeholder="Enter your password" class="form-control" id="patientPassword" required>
      </div>
      <button type="submit" class="btn btn-primary-teal w-100 py-3" id="patientLoginBtn">
        <i class="fas fa-sign-in-alt me-2"></i> Sign In
      </button>
    </form>
    <p style="text-align:center;margin-top:20px;font-size:0.875rem;color:var(--text-muted);">
      Don't have an account? <a href="signup.jsp" style="color:var(--primary);text-decoration:none;font-weight:600;">Create one</a>
    </p>
    <div style="text-align:center;margin-top:10px;">
      <a href="doctor_login.jsp" style="color:var(--text-muted);font-size:0.8rem;text-decoration:none;">
        <i class="fa-solid fa-user-doctor me-1"></i> Login as Doctor instead
      </a>
    </div>
  </div>
</div>
</body>
</html>
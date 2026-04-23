<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page isELIgnored="false"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Doctor Login | MediPortal</title>
<%@include file="component/allcss.jsp"%>
<style>
.auth-page{min-height:100vh;display:flex;align-items:center;justify-content:center;padding:40px 16px;background:radial-gradient(ellipse at 50% 40%,rgba(0,201,177,0.08) 0%,transparent 60%),var(--navy);}
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
    <div class="auth-icon-wrap"><i class="fa-solid fa-user-doctor"></i></div>
    <h1 class="auth-title">Doctor Login</h1>
    <p class="auth-subtitle">Sign in to view your patient appointments</p>
    <c:if test="${not empty successMsg}">
      <div class="alert-success-custom mb-3"><i class="fa-solid fa-circle-check me-2"></i>${successMsg}</div>
      <c:remove var="successMsg" scope="session"/>
    </c:if>
    <c:if test="${not empty errorMsg}">
      <div class="alert-danger-custom mb-3"><i class="fa-solid fa-circle-exclamation me-2"></i>${errorMsg}</div>
      <c:remove var="errorMsg" scope="session"/>
    </c:if>
    <form action="doctorLogin" method="post">
      <div class="mb-4">
        <label class="form-label">Email Address</label>
        <input name="email" type="email" placeholder="doctor@hospital.com" class="form-control" id="doctorEmail" required>
      </div>
      <div class="mb-4">
        <label class="form-label">Password</label>
        <input name="password" type="password" placeholder="Enter your password" class="form-control" id="doctorPassword" required>
      </div>
      <button type="submit" class="btn btn-primary-teal w-100 py-3" id="doctorLoginBtn">
        <i class="fas fa-sign-in-alt me-2"></i> Sign In
      </button>
    </form>
    <div style="text-align:center;margin-top:20px;">
      <a href="index.jsp" style="color:var(--text-muted);font-size:0.85rem;text-decoration:none;">
        <i class="fa-solid fa-arrow-left me-1"></i> Back to Home
      </a>
    </div>
  </div>
</div>
</body>
</html>
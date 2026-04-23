<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page isELIgnored="false"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Patient Register | MediPortal</title>
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
    <div class="auth-icon-wrap"><i class="fa-solid fa-user-plus"></i></div>
    <h1 class="auth-title">Create Account</h1>
    <p class="auth-subtitle">Join MediPortal and book your first appointment today</p>
    <c:if test="${not empty successMsg}">
      <div class="alert-success-custom mb-3"><i class="fa-solid fa-circle-check me-2"></i>${successMsg}</div>
      <c:remove var="successMsg" scope="session"/>
    </c:if>
    <c:if test="${not empty errorMsg}">
      <div class="alert-danger-custom mb-3"><i class="fa-solid fa-circle-exclamation me-2"></i>${errorMsg}</div>
      <c:remove var="errorMsg" scope="session"/>
    </c:if>
    <form action="user_register" method="post">
      <div class="mb-4">
        <label class="form-label">Full Name</label>
        <input name="fullName" type="text" placeholder="Your full name" class="form-control" id="signupName" required>
      </div>
      <div class="mb-4">
        <label class="form-label">Email Address</label>
        <input name="email" type="email" placeholder="your@email.com" class="form-control" id="signupEmail" required>
        <div class="form-text" style="color:var(--text-muted);font-size:0.78rem;margin-top:4px;">We'll never share your email with anyone.</div>
      </div>
      <div class="mb-4">
        <label class="form-label">Password</label>
        <input name="password" type="password" placeholder="Create a password" class="form-control" id="signupPassword" required>
      </div>
      <button type="submit" class="btn btn-primary-teal w-100 py-3" id="signupBtn">
        <i class="fa-solid fa-user-plus me-2"></i> Create Account
      </button>
    </form>
    <p style="text-align:center;margin-top:20px;font-size:0.875rem;color:var(--text-muted);">
      Already have an account? <a href="user_login.jsp" style="color:var(--primary);text-decoration:none;font-weight:600;">Sign in</a>
    </p>
  </div>
</div>
</body>
</html>
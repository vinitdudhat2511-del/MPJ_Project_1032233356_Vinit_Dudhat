<%@page import="com.hms.entity.Doctor"%>
<%@page import="java.util.List"%>
<%@page import="com.hms.db.DBConnection"%>
<%@page import="com.hms.dao.DoctorDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page isELIgnored="false"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Book Appointment | MediPortal</title>
<%@include file="component/allcss.jsp"%>
</head>
<body>
<%@include file="component/navbar.jsp"%>

<div style="background:linear-gradient(135deg,rgba(0,201,177,0.12) 0%,rgba(10,22,40,0) 60%),var(--navy-mid);padding:48px 0 32px;border-bottom:1px solid var(--border-glass);margin-bottom:48px;">
  <div class="container text-center">
    <h1 style="font-family:'Poppins',sans-serif;color:var(--text-white);font-size:2rem;margin-bottom:8px;">
      <i class="fa-solid fa-calendar-plus me-2" style="color:var(--primary);"></i>Book an Appointment
    </h1>
    <p style="color:var(--text-muted);">Fill in your details, choose a specialist doctor and pick a time slot</p>
  </div>
</div>

<div class="container pb-5">
  <div class="row justify-content-center">
    <div class="col-lg-7">
      <div class="glass-card p-4 p-md-5 animate-fade-up">
        <c:if test="${not empty successMsg}">
          <div class="alert-success-custom mb-4"><i class="fa-solid fa-circle-check me-2"></i>${successMsg}</div>
          <c:remove var="successMsg" scope="session"/>
        </c:if>
        <c:if test="${not empty errorMsg}">
          <div class="alert-danger-custom mb-4"><i class="fa-solid fa-circle-exclamation me-2"></i>${errorMsg}</div>
          <c:remove var="errorMsg" scope="session"/>
        </c:if>

        <form class="row g-3" action="addAppointment" method="post">
          <input type="hidden" name="userId" value="${userObj.id}">

          <div class="col-md-6">
            <label class="form-label">Full Name</label>
            <input required name="fullName" type="text" placeholder="Your full name" class="form-control">
          </div>
          <div class="col-md-6">
            <label class="form-label">Gender</label>
            <select class="form-select" name="gender" required>
              <option selected disabled>Select Gender</option>
              <option value="male">Male</option>
              <option value="female">Female</option>
              <option value="other">Other</option>
            </select>
          </div>
          <div class="col-md-6">
            <label class="form-label">Age</label>
            <input required name="age" type="number" min="1" max="120" placeholder="Your age" class="form-control">
          </div>
          <div class="col-md-6">
            <label class="form-label">Appointment Date</label>
            <input required name="appointmentDate" type="date" class="form-control">
          </div>
          <div class="col-md-6">
            <label class="form-label">Email</label>
            <input required name="email" type="email" placeholder="your@email.com" class="form-control">
          </div>
          <div class="col-md-6">
            <label class="form-label">Phone Number</label>
            <input required name="phone" type="tel" placeholder="Your mobile number" class="form-control">
          </div>
          <div class="col-md-6">
            <label class="form-label">Symptoms / Diseases</label>
            <input required name="diseases" type="text" placeholder="e.g. Fever, Headache" class="form-control">
          </div>
          <div class="col-md-6">
            <label class="form-label">Select Doctor</label>
            <select required class="form-select" name="doctorNameSelect">
              <option selected disabled>Choose a Doctor</option>
              <%
                DoctorDAO doctorDAO = new DoctorDAO(DBConnection.getConn());
                List<Doctor> listOfDoctor = doctorDAO.getAllDoctor();
                for(Doctor d : listOfDoctor) {
              %>
                <option value="<%= d.getId() %>"><%= d.getFullName() %> (<%= d.getSpecialist() %>)</option>
              <%
                }
              %>
            </select>
          </div>

          <!-- Time Slot Picker -->
          <div class="col-md-6">
            <label class="form-label"><i class="fa-solid fa-clock me-1" style="color:var(--primary);"></i> Time Slot</label>
            <select required class="form-select" name="timeSlot" id="timeSlotSelect">
              <option selected disabled>Choose a Time Slot</option>
              <option value="09:00 AM">09:00 AM</option>
              <option value="09:30 AM">09:30 AM</option>
              <option value="10:00 AM">10:00 AM</option>
              <option value="10:30 AM">10:30 AM</option>
              <option value="11:00 AM">11:00 AM</option>
              <option value="11:30 AM">11:30 AM</option>
              <option value="12:00 PM">12:00 PM</option>
              <option value="12:30 PM">12:30 PM</option>
              <option value="01:00 PM">01:00 PM</option>
              <option value="01:30 PM">01:30 PM</option>
              <option value="02:00 PM">02:00 PM</option>
              <option value="02:30 PM">02:30 PM</option>
              <option value="03:00 PM">03:00 PM</option>
              <option value="03:30 PM">03:30 PM</option>
              <option value="04:00 PM">04:00 PM</option>
              <option value="04:30 PM">04:30 PM</option>
            </select>
          </div>
          <div class="col-md-6">
            <label class="form-label">Full Address</label>
            <input name="address" required class="form-control" placeholder="Your home address">
          </div>

          <div class="col-12 mt-2">
            <c:if test="${empty userObj}">
              <a href="user_login.jsp" class="btn btn-primary-teal w-100 py-3">
                <i class="fas fa-sign-in-alt me-2"></i> Login to Submit Appointment
              </a>
              <p style="color:var(--text-muted);text-align:center;margin-top:12px;font-size:0.875rem;">You need to be logged in to book an appointment.</p>
            </c:if>
            <c:if test="${not empty userObj}">
              <button type="submit" class="btn btn-primary-teal w-100 py-3">
                <i class="fa-solid fa-calendar-check me-2"></i> Confirm Appointment
              </button>
            </c:if>
          </div>
        </form>
      </div>
    </div>
  </div>
</div>

<%@include file="component/footer.jsp"%>
</body>
</html>
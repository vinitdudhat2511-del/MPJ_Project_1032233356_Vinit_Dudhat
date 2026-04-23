<%@page import="com.hms.entity.Doctor"%>
<%@page import="com.hms.dao.DoctorDAO"%>
<%@page import="com.hms.dao.ReviewDAO"%>
<%@page import="com.hms.entity.User"%>
<%@page import="com.hms.entity.Appointment"%>
<%@page import="java.util.List"%>
<%@page import="com.hms.db.DBConnection"%>
<%@page import="com.hms.dao.AppointmentDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page isELIgnored="false"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>My Appointments | MediPortal</title>
<%@include file="component/allcss.jsp"%>
<style>
.star-rating{display:inline-flex;flex-direction:row-reverse;gap:2px;cursor:pointer;}
.star-rating input{display:none;}
.star-rating label{font-size:1.6rem;color:rgba(255,255,255,0.15);cursor:pointer;transition:color 0.15s;}
.star-rating input:checked ~ label,.star-rating label:hover,.star-rating label:hover ~ label{color:#ffd32a;}
.action-btns{display:flex;flex-wrap:wrap;gap:4px;align-items:center;}
.action-btns .btn{font-size:0.78rem;white-space:nowrap;}
</style>
</head>
<body>
<%@include file="component/navbar.jsp"%>

<c:if test="${empty userObj}">
  <c:redirect url="/user_login.jsp"/>
</c:if>

<div style="background:linear-gradient(135deg,rgba(0,201,177,0.10) 0%,transparent 60%),var(--navy-mid);padding:48px 0 32px;border-bottom:1px solid var(--border-glass);margin-bottom:48px;">
  <div class="container">
    <h1 style="font-family:'Poppins',sans-serif;color:var(--text-white);font-size:2rem;margin-bottom:6px;">
      <i class="fa fa-list-check me-2" style="color:var(--primary);"></i>My Appointments
    </h1>
    <p style="color:var(--text-muted);margin:0;">Welcome back, <strong style="color:var(--primary);">${userObj.fullName}</strong></p>
  </div>
</div>

<div class="container pb-5">
  <c:if test="${not empty successMsg}">
    <div class="alert-success-custom mb-4 animate-fade-up"><i class="fa-solid fa-circle-check me-2"></i>${successMsg}</div>
    <c:remove var="successMsg" scope="session"/>
  </c:if>
  <c:if test="${not empty errorMsg}">
    <div class="alert-danger-custom mb-4 animate-fade-up"><i class="fa-solid fa-circle-exclamation me-2"></i>${errorMsg}</div>
    <c:remove var="errorMsg" scope="session"/>
  </c:if>

  <%
    User user = (User) session.getAttribute("userObj");
    if (user != null) {
      DoctorDAO dDAO = new DoctorDAO(DBConnection.getConn());
      AppointmentDAO appDAO = new AppointmentDAO(DBConnection.getConn());
      ReviewDAO revDAO = new ReviewDAO(DBConnection.getConn());
      List<Appointment> list = appDAO.getAllAppointmentByLoginUser(user.getId());
      // We'll collect modal HTML here and render it OUTSIDE the table
      StringBuilder modalsHtml = new StringBuilder();
      if (list.isEmpty()) {
  %>
    <div class="glass-card p-5 text-center animate-fade-up">
      <i class="fa-solid fa-calendar-xmark" style="font-size:3rem;color:rgba(0,201,177,0.4);"></i>
      <h5 style="color:var(--text-white);margin-top:16px;">No Appointments Yet</h5>
      <p style="color:var(--text-muted);">You haven't booked any appointments. Start by finding a doctor!</p>
      <a href="user_appointment.jsp" class="btn btn-primary-teal px-4">Book an Appointment</a>
    </div>
  <% } else { %>
    <div class="glass-card p-0 overflow-hidden animate-fade-up">
      <div style="padding:20px 24px;border-bottom:1px solid var(--border-glass);">
        <h5 style="color:var(--text-white);margin:0;font-family:'Poppins',sans-serif;">Your Appointment History</h5>
      </div>
      <div class="table-responsive">
        <table class="table mb-0">
          <thead>
            <tr><th>Patient</th><th>Doctor</th><th>Disease</th><th>Date & Time</th><th>Phone</th><th>Status</th><th>Actions</th></tr>
          </thead>
          <tbody>
  <%
        for (Appointment appt : list) {
          Doctor doctor = dDAO.getDoctorById(appt.getDoctorId());
          String status = appt.getStatus();
          String badgeClass = "badge-pending";
          if ("Approved".equalsIgnoreCase(status)) badgeClass = "badge-approved";
          else if ("Rejected".equalsIgnoreCase(status)) badgeClass = "badge-rejected";
          else if ("Cancelled".equalsIgnoreCase(status)) badgeClass = "badge-cancelled";
          boolean reviewed = revDAO.hasUserReviewed(appt.getId());
          boolean canReschedule = "Pending".equals(status) || "Approved".equalsIgnoreCase(status);
          String doctorName = doctor != null ? doctor.getFullName() : "N/A";
  %>
            <tr>
              <td><strong style="color:var(--text-white);"><%=appt.getFullName()%></strong><br><small style="color:var(--text-muted);"><%=appt.getGender()%>, <%=appt.getAge()%>yrs</small></td>
              <td style="color:var(--text-white);">Dr. <%=doctorName%></td>
              <td style="color:var(--text-muted);"><%=appt.getDiseases()%></td>
              <td style="color:var(--text-muted);"><%=appt.getAppointmentDate()%><% if(appt.getTimeSlot()!=null && !appt.getTimeSlot().isEmpty()){%><br><span style="color:var(--primary);font-size:0.8rem;"><i class="fa-solid fa-clock me-1"></i><%=appt.getTimeSlot()%></span><%}%></td>
              <td style="color:var(--text-muted);"><%=appt.getPhone()%></td>
              <td><span class="<%=badgeClass%>"><%=status%></span></td>
              <td>
                <div class="action-btns">
                  <% if ("Pending".equals(status)) { %>
                    <a href="cancelAppointment?id=<%=appt.getId()%>&userId=<%=user.getId()%>"
                       class="btn btn-sm btn-danger py-1 px-2"
                       onclick="return confirm('Cancel this appointment?')">
                      <i class="fa-solid fa-xmark me-1"></i>Cancel
                    </a>
                  <% } %>
                  <% if (canReschedule) { %>
                    <button class="btn btn-sm py-1 px-2" style="background:rgba(108,92,231,0.2);border:1px solid rgba(108,92,231,0.5);color:#a29bfe;" data-bs-toggle="modal" data-bs-target="#rescheduleModal<%=appt.getId()%>">
                      <i class="fa-solid fa-calendar-pen me-1"></i>Reschedule
                    </button>
                  <% } %>
                  <% if (!"Pending".equals(status) && !"Cancelled".equals(status) && !reviewed) { %>
                    <button class="btn btn-sm btn-warning py-1 px-2" data-bs-toggle="modal" data-bs-target="#reviewModal<%=appt.getId()%>">
                      <i class="fa-solid fa-star me-1"></i>Rate
                    </button>
                  <% } else if (reviewed) { %>
                    <span style="color:#ffd32a;font-size:0.75rem;"><i class="fa-solid fa-star me-1"></i>Reviewed</span>
                  <% } %>
                  <a href="downloadReport?id=<%=appt.getId()%>" class="btn btn-sm py-1 px-2" style="background:rgba(0,201,177,0.15);border:1px solid rgba(0,201,177,0.4);color:#00c9b1;" title="Download PDF Report">
                    <i class="fa-solid fa-file-pdf me-1"></i>PDF
                  </a>
                </div>
              </td>
            </tr>
  <%
          // ====== Build Reschedule Modal HTML (rendered OUTSIDE table) ======
          if (canReschedule) {
            modalsHtml.append("<div class=\"modal fade\" id=\"rescheduleModal").append(appt.getId()).append("\" tabindex=\"-1\" aria-hidden=\"true\">")
              .append("<div class=\"modal-dialog modal-dialog-centered\">")
              .append("<div class=\"modal-content\" style=\"background:var(--navy-mid);border:1px solid var(--border-glass);border-radius:16px;\">")
              .append("<div class=\"modal-header\" style=\"border-bottom:1px solid var(--border-glass);\">")
              .append("<h5 class=\"modal-title\" style=\"color:#a29bfe;font-family:'Poppins',sans-serif;\"><i class=\"fa-solid fa-calendar-pen me-2\"></i>Reschedule Appointment</h5>")
              .append("<button type=\"button\" class=\"btn-close btn-close-white\" data-bs-dismiss=\"modal\"></button>")
              .append("</div>")
              .append("<div class=\"modal-body p-4\">")
              .append("<p style=\"color:var(--text-muted);font-size:0.85rem;margin-bottom:16px;\">Current: <strong style=\"color:var(--text-white);\">").append(appt.getAppointmentDate()).append("</strong>");
            if (appt.getTimeSlot() != null && !appt.getTimeSlot().isEmpty()) {
              modalsHtml.append(" at <strong style=\"color:var(--primary);\">").append(appt.getTimeSlot()).append("</strong>");
            }
            modalsHtml.append("</p>")
              .append("<form action=\"rescheduleAppointment\" method=\"post\">")
              .append("<input type=\"hidden\" name=\"appointmentId\" value=\"").append(appt.getId()).append("\">")
              .append("<div class=\"mb-3\"><label class=\"form-label\">New Date</label><input type=\"date\" name=\"newDate\" class=\"form-control\" required></div>")
              .append("<div class=\"mb-3\"><label class=\"form-label\"><i class=\"fa-solid fa-clock me-1\" style=\"color:var(--primary);\"></i> New Time Slot</label>")
              .append("<select name=\"newTimeSlot\" class=\"form-select\" required>")
              .append("<option selected disabled>Choose a Time Slot</option>")
              .append("<option value=\"09:00 AM\">09:00 AM</option><option value=\"09:30 AM\">09:30 AM</option>")
              .append("<option value=\"10:00 AM\">10:00 AM</option><option value=\"10:30 AM\">10:30 AM</option>")
              .append("<option value=\"11:00 AM\">11:00 AM</option><option value=\"11:30 AM\">11:30 AM</option>")
              .append("<option value=\"12:00 PM\">12:00 PM</option><option value=\"12:30 PM\">12:30 PM</option>")
              .append("<option value=\"01:00 PM\">01:00 PM</option><option value=\"01:30 PM\">01:30 PM</option>")
              .append("<option value=\"02:00 PM\">02:00 PM</option><option value=\"02:30 PM\">02:30 PM</option>")
              .append("<option value=\"03:00 PM\">03:00 PM</option><option value=\"03:30 PM\">03:30 PM</option>")
              .append("<option value=\"04:00 PM\">04:00 PM</option><option value=\"04:30 PM\">04:30 PM</option>")
              .append("</select></div>")
              .append("<button type=\"submit\" class=\"btn w-100 py-2\" style=\"background:rgba(108,92,231,0.3);border:1px solid rgba(108,92,231,0.5);color:#a29bfe;font-weight:600;\"><i class=\"fa-solid fa-calendar-check me-2\"></i>Confirm Reschedule</button>")
              .append("</form></div></div></div></div>");
          }

          // ====== Build Review Modal HTML (rendered OUTSIDE table) ======
          if (!"Pending".equals(status) && !"Cancelled".equals(status) && !reviewed) {
            modalsHtml.append("<div class=\"modal fade\" id=\"reviewModal").append(appt.getId()).append("\" tabindex=\"-1\" aria-hidden=\"true\">")
              .append("<div class=\"modal-dialog modal-dialog-centered\">")
              .append("<div class=\"modal-content\" style=\"background:var(--navy-mid);border:1px solid var(--border-glass);border-radius:16px;\">")
              .append("<div class=\"modal-header\" style=\"border-bottom:1px solid var(--border-glass);\">")
              .append("<h5 class=\"modal-title\" style=\"color:var(--primary);font-family:'Poppins',sans-serif;\"><i class=\"fa-solid fa-star me-2\"></i>Rate Dr. ").append(doctorName).append("</h5>")
              .append("<button type=\"button\" class=\"btn-close btn-close-white\" data-bs-dismiss=\"modal\"></button>")
              .append("</div>")
              .append("<div class=\"modal-body p-4\">")
              .append("<form action=\"addReview\" method=\"post\">")
              .append("<input type=\"hidden\" name=\"doctorId\" value=\"").append(appt.getDoctorId()).append("\">")
              .append("<input type=\"hidden\" name=\"appointmentId\" value=\"").append(appt.getId()).append("\">")
              .append("<div class=\"text-center mb-3\"><div class=\"star-rating\">")
              .append("<input type=\"radio\" id=\"star5_").append(appt.getId()).append("\" name=\"rating\" value=\"5\"><label for=\"star5_").append(appt.getId()).append("\">&#9733;</label>")
              .append("<input type=\"radio\" id=\"star4_").append(appt.getId()).append("\" name=\"rating\" value=\"4\"><label for=\"star4_").append(appt.getId()).append("\">&#9733;</label>")
              .append("<input type=\"radio\" id=\"star3_").append(appt.getId()).append("\" name=\"rating\" value=\"3\" checked><label for=\"star3_").append(appt.getId()).append("\">&#9733;</label>")
              .append("<input type=\"radio\" id=\"star2_").append(appt.getId()).append("\" name=\"rating\" value=\"2\"><label for=\"star2_").append(appt.getId()).append("\">&#9733;</label>")
              .append("<input type=\"radio\" id=\"star1_").append(appt.getId()).append("\" name=\"rating\" value=\"1\"><label for=\"star1_").append(appt.getId()).append("\">&#9733;</label>")
              .append("</div></div>")
              .append("<div class=\"mb-3\"><label class=\"form-label\">Your Review (optional)</label><textarea name=\"reviewText\" class=\"form-control\" rows=\"3\" placeholder=\"Share your experience...\"></textarea></div>")
              .append("<button type=\"submit\" class=\"btn btn-primary-teal w-100 py-2\"><i class=\"fa-solid fa-paper-plane me-2\"></i>Submit Review</button>")
              .append("</form></div></div></div></div>");
          }
        }
  %>
          </tbody>
        </table>
      </div>
    </div>

    <%-- ====== ALL MODALS RENDERED HERE — OUTSIDE THE TABLE ====== --%>
    <%= modalsHtml.toString() %>

  <% } } %>
  <div class="mt-4">
    <a href="user_appointment.jsp" class="btn btn-outline-teal px-4"><i class="fa fa-calendar-plus me-2"></i>Book New Appointment</a>
  </div>
</div>

<%@include file="component/footer.jsp"%>
</body>
</html>
<%@page import="com.hms.dao.AppointmentDAO"%>
<%@page import="com.hms.dao.DoctorDAO"%>
<%@page import="com.hms.db.DBConnection"%>
<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page isELIgnored="false"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin Dashboard | MediPortal</title>
<%@include file="../component/allcss.jsp"%>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>
<body>
<%@include file="navbar.jsp"%>
<c:if test="${empty adminObj}"><c:redirect url="../admin_login.jsp"/></c:if>

<%
  DoctorDAO docDAO = new DoctorDAO(DBConnection.getConn());
  AppointmentDAO appDAO = new AppointmentDAO(DBConnection.getConn());
  int totalDoctors = docDAO.countTotalDoctor();
  int totalUsers = docDAO.countTotalUser();
  int totalAppointments = docDAO.countTotalAppointment();
  int totalSpecialists = docDAO.countTotalSpecialist();

  int pendingCount = appDAO.countByStatus("Pending");
  int approvedCount = appDAO.countByStatus("Approved");
  int rejectedCount = appDAO.countByStatus("Rejected");
  int cancelledCount = appDAO.countByStatus("Cancelled");

  Map<String, Integer> specMap = docDAO.getDoctorsPerSpecialist();
  StringBuilder specLabels = new StringBuilder();
  StringBuilder specData = new StringBuilder();
  boolean first = true;
  for (Map.Entry<String, Integer> e : specMap.entrySet()) {
    if (!first) { specLabels.append(","); specData.append(","); }
    specLabels.append("\"").append(e.getKey()).append("\"");
    specData.append(e.getValue());
    first = false;
  }
%>

<div style="background:linear-gradient(135deg,rgba(0,201,177,0.12) 0%,transparent 60%),var(--navy-mid);padding:48px 0 32px;border-bottom:1px solid var(--border-glass);margin-bottom:48px;">
  <div class="container">
    <h1 style="font-family:'Poppins',sans-serif;color:var(--text-white);font-size:2rem;margin-bottom:6px;">
      <i class="fa-solid fa-chart-line me-2" style="color:var(--primary);"></i>Admin Dashboard
    </h1>
    <p style="color:var(--text-muted);margin:0;">Welcome back, <strong style="color:var(--primary);">Administrator</strong></p>
  </div>
</div>

<div class="container pb-5">
  <!-- Success/Error Msgs -->
  <c:if test="${not empty successMsg}">
    <div class="alert-success-custom mb-4 animate-fade-up"><i class="fa-solid fa-circle-check me-2"></i>${successMsg}</div>
    <c:remove var="successMsg" scope="session"/>
  </c:if>
  <c:if test="${not empty errorMsg}">
    <div class="alert-danger-custom mb-4 animate-fade-up"><i class="fa-solid fa-circle-exclamation me-2"></i>${errorMsg}</div>
    <c:remove var="errorMsg" scope="session"/>
  </c:if>

  <!-- Stat Cards -->
  <div class="row g-4 mb-5">
    <div class="col-md-3 col-6">
      <a href="view_doctor.jsp" style="text-decoration:none;">
        <div class="glass-card p-4 text-center animate-fade-up" style="cursor:pointer;transition:transform 0.2s,box-shadow 0.2s;" onmouseover="this.style.transform='translateY(-6px)';this.style.boxShadow='0 12px 40px rgba(0,201,177,0.2)';" onmouseout="this.style.transform='';this.style.boxShadow='';">
          <div style="width:52px;height:52px;border-radius:50%;background:rgba(0,201,177,0.12);border:2px solid rgba(0,201,177,0.3);display:flex;align-items:center;justify-content:center;margin:0 auto 12px;font-size:1.3rem;color:var(--primary);"><i class="fa-solid fa-user-doctor"></i></div>
          <div style="font-size:2rem;font-weight:700;color:var(--text-white);font-family:'Poppins',sans-serif;" class="counter"><%=totalDoctors%></div>
          <div style="color:var(--text-muted);font-size:0.85rem;">Doctors</div>
        </div>
      </a>
    </div>
    <div class="col-md-3 col-6">
      <div class="glass-card p-4 text-center animate-fade-up">
        <div style="width:52px;height:52px;border-radius:50%;background:rgba(108,92,231,0.12);border:2px solid rgba(108,92,231,0.3);display:flex;align-items:center;justify-content:center;margin:0 auto 12px;font-size:1.3rem;color:#6c5ce7;"><i class="fa-solid fa-users"></i></div>
        <div style="font-size:2rem;font-weight:700;color:var(--text-white);font-family:'Poppins',sans-serif;" class="counter"><%=totalUsers%></div>
        <div style="color:var(--text-muted);font-size:0.85rem;">Patients</div>
      </div>
    </div>
    <div class="col-md-3 col-6">
      <a href="patient.jsp" style="text-decoration:none;">
        <div class="glass-card p-4 text-center animate-fade-up" style="cursor:pointer;transition:transform 0.2s,box-shadow 0.2s;" onmouseover="this.style.transform='translateY(-6px)';this.style.boxShadow='0 12px 40px rgba(255,165,2,0.15)';" onmouseout="this.style.transform='';this.style.boxShadow='';">
          <div style="width:52px;height:52px;border-radius:50%;background:rgba(255,165,2,0.12);border:2px solid rgba(255,165,2,0.3);display:flex;align-items:center;justify-content:center;margin:0 auto 12px;font-size:1.3rem;color:#ffa502;"><i class="fa-solid fa-calendar-check"></i></div>
          <div style="font-size:2rem;font-weight:700;color:var(--text-white);font-family:'Poppins',sans-serif;" class="counter"><%=totalAppointments%></div>
          <div style="color:var(--text-muted);font-size:0.85rem;">Appointments</div>
        </div>
      </a>
    </div>
    <div class="col-md-3 col-6">
      <div class="glass-card p-4 text-center animate-fade-up">
        <div style="width:52px;height:52px;border-radius:50%;background:rgba(255,71,87,0.12);border:2px solid rgba(255,71,87,0.3);display:flex;align-items:center;justify-content:center;margin:0 auto 12px;font-size:1.3rem;color:#ff4757;"><i class="fa-solid fa-stethoscope"></i></div>
        <div style="font-size:2rem;font-weight:700;color:var(--text-white);font-family:'Poppins',sans-serif;" class="counter"><%=totalSpecialists%></div>
        <div style="color:var(--text-muted);font-size:0.85rem;">Specializations</div>
      </div>
    </div>
  </div>

  <!-- Charts Row -->
  <div class="row g-4 mb-5">
    <div class="col-md-5">
      <div class="glass-card p-4 animate-fade-up">
        <h5 style="color:var(--text-white);font-family:'Poppins',sans-serif;margin-bottom:20px;font-size:1rem;">
          <i class="fa-solid fa-chart-pie me-2" style="color:var(--primary);"></i>Appointments by Status
        </h5>
        <div style="position:relative;max-width:280px;margin:0 auto;">
          <canvas id="statusChart"></canvas>
        </div>
      </div>
    </div>
    <div class="col-md-7">
      <div class="glass-card p-4 animate-fade-up">
        <h5 style="color:var(--text-white);font-family:'Poppins',sans-serif;margin-bottom:20px;font-size:1rem;">
          <i class="fa-solid fa-chart-column me-2" style="color:var(--primary);"></i>Doctors per Specialization
        </h5>
        <canvas id="specChart" style="max-height:280px;"></canvas>
      </div>
    </div>
  </div>

  <!-- Quick Actions -->
  <div class="row g-4">
    <div class="col-md-4">
      <a href="doctor.jsp" style="text-decoration:none;">
        <div class="glass-card p-4 text-center animate-fade-up" style="cursor:pointer;transition:transform 0.2s;" onmouseover="this.style.transform='translateY(-4px)'" onmouseout="this.style.transform=''">
          <i class="fa-solid fa-user-plus" style="font-size:2rem;color:var(--primary);margin-bottom:12px;display:block;"></i>
          <h6 style="color:var(--text-white);font-family:'Poppins',sans-serif;">Add New Doctor</h6>
          <p style="color:var(--text-muted);font-size:0.82rem;margin:0;">Register a new medical professional</p>
        </div>
      </a>
    </div>
    <div class="col-md-4">
      <a href="patient.jsp" style="text-decoration:none;">
        <div class="glass-card p-4 text-center animate-fade-up" style="cursor:pointer;transition:transform 0.2s;" onmouseover="this.style.transform='translateY(-4px)'" onmouseout="this.style.transform=''">
          <i class="fa-solid fa-calendar-check" style="font-size:2rem;color:#ffa502;margin-bottom:12px;display:block;"></i>
          <h6 style="color:var(--text-white);font-family:'Poppins',sans-serif;">Manage Appointments</h6>
          <p style="color:var(--text-muted);font-size:0.82rem;margin:0;">Approve or reject pending requests</p>
        </div>
      </a>
    </div>
    <div class="col-md-4">
      <div class="glass-card p-4 text-center animate-fade-up" style="cursor:pointer;transition:transform 0.2s;" onclick="document.getElementById('addSpecialistModal').classList.add('show');document.getElementById('addSpecialistModal').style.display='block';" onmouseover="this.style.transform='translateY(-4px)'" onmouseout="this.style.transform=''">
        <i class="fa-solid fa-plus-circle" style="font-size:2rem;color:#ff4757;margin-bottom:12px;display:block;"></i>
        <h6 style="color:var(--text-white);font-family:'Poppins',sans-serif;">Add Specialist</h6>
        <p style="color:var(--text-muted);font-size:0.82rem;margin:0;">Create a new specialization category</p>
      </div>
    </div>
  </div>
</div>

<!-- Add Specialist Modal -->
<div class="modal fade" id="addSpecialistModal" tabindex="-1" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content" style="background:var(--navy-mid);border:1px solid var(--border-glass);border-radius:16px;">
      <div class="modal-header" style="border-bottom:1px solid var(--border-glass);">
        <h5 class="modal-title" style="color:var(--primary);font-family:'Poppins',sans-serif;">
          <i class="fa-solid fa-stethoscope me-2"></i>Add Specialist
        </h5>
        <button type="button" class="btn-close btn-close-white" onclick="document.getElementById('addSpecialistModal').classList.remove('show');document.getElementById('addSpecialistModal').style.display='none';"></button>
      </div>
      <div class="modal-body p-4">
        <form action="../addSpecialist" method="post">
          <div class="mb-3">
            <label class="form-label">Specialist Name</label>
            <input type="text" name="specialistName" class="form-control" placeholder="e.g. Cardiologist" required>
          </div>
          <button type="submit" class="btn btn-primary-teal w-100 py-2"><i class="fa-solid fa-plus me-2"></i>Add Specialist</button>
        </form>
      </div>
    </div>
  </div>
</div>

<script>
// Doughnut Chart - Appointments by Status
new Chart(document.getElementById('statusChart'), {
  type: 'doughnut',
  data: {
    labels: ['Pending', 'Approved', 'Rejected', 'Cancelled'],
    datasets: [{
      data: [<%=pendingCount%>, <%=approvedCount%>, <%=rejectedCount%>, <%=cancelledCount%>],
      backgroundColor: ['rgba(255,211,42,0.85)', 'rgba(0,201,177,0.85)', 'rgba(255,71,87,0.85)', 'rgba(140,160,190,0.5)'],
      borderColor: ['#ffd32a','#00c9b1','#ff4757','#8ca0be'],
      borderWidth: 2,
      hoverOffset: 8
    }]
  },
  options: {
    responsive: true,
    cutout: '65%',
    plugins: {
      legend: {
        position: 'bottom',
        labels: { color: '#c0d0e0', padding: 16, usePointStyle: true, pointStyleWidth: 10, font: { size: 12 } }
      }
    }
  }
});

// Bar Chart - Doctors per Specialization
new Chart(document.getElementById('specChart'), {
  type: 'bar',
  data: {
    labels: [<%=specLabels.toString()%>],
    datasets: [{
      label: 'Doctors',
      data: [<%=specData.toString()%>],
      backgroundColor: 'rgba(0,201,177,0.6)',
      borderColor: '#00c9b1',
      borderWidth: 1,
      borderRadius: 8,
      maxBarThickness: 48
    }]
  },
  options: {
    responsive: true,
    indexAxis: 'y',
    scales: {
      x: { beginAtZero: true, ticks: { color: '#8ca0be', stepSize: 1 }, grid: { color: 'rgba(255,255,255,0.04)' } },
      y: { ticks: { color: '#c0d0e0', font: { size: 12 } }, grid: { display: false } }
    },
    plugins: {
      legend: { display: false }
    }
  }
});
</script>

</body>
</html>
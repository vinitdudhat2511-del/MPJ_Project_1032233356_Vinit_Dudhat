<nav class="navbar navbar-expand-lg navbar-dark sticky-top">
  <div class="container">
    <a class="navbar-brand" href="index.jsp">
      <i class="fa-sharp fa-solid fa-hospital"></i> MediPortal <span style="font-size:0.7rem;color:var(--primary);font-weight:400;background:rgba(0,201,177,0.12);border:1px solid rgba(0,201,177,0.3);border-radius:8px;padding:2px 8px;margin-left:6px;">Admin</span>
    </a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#adminNav"
      aria-controls="adminNav" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="adminNav">
      <ul class="navbar-nav me-auto mb-2 mb-lg-0 gap-1">
        <li class="nav-item"><a class="nav-link" href="index.jsp"><i class="fa-solid fa-gauge-high me-1"></i>Dashboard</a></li>
        <li class="nav-item"><a class="nav-link" href="doctor.jsp"><i class="fa-solid fa-user-doctor me-1"></i>Add Doctor</a></li>
        <li class="nav-item"><a class="nav-link" href="view_doctor.jsp"><i class="fa-solid fa-list me-1"></i>Doctors</a></li>
        <li class="nav-item"><a class="nav-link" href="patient.jsp"><i class="fa-solid fa-calendar-check me-1"></i>Appointments</a></li>
      </ul>
      <div class="dropdown">
        <button class="btn btn-primary-teal dropdown-toggle d-flex align-items-center gap-2" type="button"
          id="adminDropdown" data-bs-toggle="dropdown" aria-expanded="false">
          <i class="fa-solid fa-shield-halved"></i> Admin
        </button>
        <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="adminDropdown">
          <li><a class="dropdown-item" href="../adminLogout"><i class="fas fa-sign-out-alt me-2"></i>Logout</a></li>
        </ul>
      </div>
    </div>
  </div>
</nav>
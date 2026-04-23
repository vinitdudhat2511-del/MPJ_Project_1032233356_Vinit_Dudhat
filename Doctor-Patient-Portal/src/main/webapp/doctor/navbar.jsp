<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page isELIgnored="false"%>

<nav class="navbar navbar-expand-lg navbar-dark sticky-top">
  <div class="container">
    <a class="navbar-brand" href="index.jsp">
      <i class="fa-sharp fa-solid fa-hospital"></i> MediPortal <span style="font-size:0.7rem;color:#00c9b1;font-weight:400;background:rgba(0,201,177,0.12);border:1px solid rgba(0,201,177,0.3);border-radius:8px;padding:2px 8px;margin-left:6px;">Doctor</span>
    </a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#doctorNav"
      aria-controls="doctorNav" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="doctorNav">
      <ul class="navbar-nav me-auto mb-2 mb-lg-0 gap-1">
        <li class="nav-item"><a class="nav-link" href="index.jsp"><i class="fa-solid fa-gauge me-1"></i>Dashboard</a></li>
        <li class="nav-item"><a class="nav-link" href="patient.jsp"><i class="fa-solid fa-calendar-check me-1"></i>My Patients</a></li>
      </ul>
      <div class="dropdown">
        <button class="btn btn-primary-teal dropdown-toggle d-flex align-items-center gap-2" type="button"
          id="doctorDropdown" data-bs-toggle="dropdown" aria-expanded="false">
          <i class="fa-solid fa-user-doctor"></i> Dr. ${doctorObj.fullName}
        </button>
        <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="doctorDropdown">
          <li><a class="dropdown-item" href="edit_profile.jsp"><i class="fa-solid fa-pen me-2"></i>Edit Profile</a></li>
          <li><hr class="dropdown-divider" style="border-color:rgba(255,255,255,0.08)"></li>
          <li><a class="dropdown-item" href="../doctorLogout"><i class="fas fa-sign-out-alt me-2"></i>Logout</a></li>
        </ul>
      </div>
    </div>
  </div>
</nav>
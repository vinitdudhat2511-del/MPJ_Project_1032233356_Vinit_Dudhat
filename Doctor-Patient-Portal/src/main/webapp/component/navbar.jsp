<!-- for jstl tag -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- end of jstl tag -->

<%@page isELIgnored="false"%>

<nav class="navbar navbar-expand-lg navbar-dark sticky-top" id="mainNavbar">
	<div class="container">
		<a class="navbar-brand" href="${pageContext.request.contextPath}/index.jsp">
			<i class="fa-sharp fa-solid fa-hospital"></i> MediPortal
		</a>
		<button class="navbar-toggler" type="button" data-bs-toggle="collapse"
			data-bs-target="#navbarSupportedContent"
			aria-controls="navbarSupportedContent" aria-expanded="false"
			aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>
		<div class="collapse navbar-collapse" id="navbarSupportedContent">
			<ul class="navbar-nav ms-auto mb-2 mb-lg-0 align-items-center gap-1">

				<c:if test="${empty userObj}">
					<li class="nav-item">
						<a class="nav-link" href="${pageContext.request.contextPath}/index.jsp">
							<i class="fa-solid fa-house"></i> Home
						</a>
					</li>
					<li class="nav-item">
						<a class="nav-link" href="${pageContext.request.contextPath}/user_appointment.jsp">
							<i class="fa fa-calendar-plus"></i> Book Appointment
						</a>
					</li>
					<li class="nav-item">
						<a class="btn btn-outline-teal ms-2 px-3" href="${pageContext.request.contextPath}/user_login.jsp" id="userLoginBtn">
							<i class="fas fa-sign-in-alt"></i> Patient Login
						</a>
					</li>
					<li class="nav-item">
						<a class="btn btn-outline-teal ms-1 px-3" href="${pageContext.request.contextPath}/doctor_login.jsp" id="doctorLoginBtn">
							<i class="fa-solid fa-user-doctor"></i> Doctor
						</a>
					</li>
					<li class="nav-item">
						<a class="btn btn-outline-teal ms-1 px-3" href="${pageContext.request.contextPath}/admin_login.jsp" id="adminLoginBtn">
							<i class="fa-solid fa-shield-halved"></i> Admin
						</a>
					</li>
				</c:if>

				<c:if test="${not empty userObj}">
					<li class="nav-item">
						<a class="nav-link" href="${pageContext.request.contextPath}/index.jsp">
							<i class="fa-solid fa-house"></i> Home
						</a>
					</li>
					<li class="nav-item">
						<a class="nav-link" href="${pageContext.request.contextPath}/user_appointment.jsp">
							<i class="fa fa-calendar-plus"></i> Book Appointment
						</a>
					</li>
					<li class="nav-item">
						<a class="nav-link" href="${pageContext.request.contextPath}/view_appointment.jsp">
							<i class="fa fa-list-check"></i> My Appointments
						</a>
					</li>
					<li class="nav-item dropdown ms-2">
						<button class="btn btn-primary-teal dropdown-toggle d-flex align-items-center gap-2" type="button"
							id="userDropdownBtn" data-bs-toggle="dropdown" aria-expanded="false">
							<i class="fa-solid fa-circle-user"></i> ${userObj.fullName}
						</button>
						<ul class="dropdown-menu dropdown-menu-end" aria-labelledby="userDropdownBtn">
							<li>
								<a class="dropdown-item" href="${pageContext.request.contextPath}/change_password.jsp">
									<i class="fa-solid fa-key me-2"></i> Change Password
								</a>
							</li>
							<li><hr class="dropdown-divider" style="border-color:rgba(255,255,255,0.1)"></li>
							<li>
								<a class="dropdown-item text-danger-custom" href="${pageContext.request.contextPath}/userLogout">
									<i class="fas fa-sign-out-alt me-2"></i> Logout
								</a>
							</li>
						</ul>
					</li>
				</c:if>

			</ul>
		</div>
	</div>
</nav>

<style>
.text-danger-custom { color: #ff4757 !important; }
.dropdown-divider { border-color: rgba(255,255,255,0.08) !important; }
</style>
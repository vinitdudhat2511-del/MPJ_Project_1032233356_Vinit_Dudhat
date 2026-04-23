package com.hms.user.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.hms.dao.AppointmentDAO;
import com.hms.db.DBConnection;
import com.hms.entity.Appointment;

@WebServlet("/addAppointment")
public class AppointmentServlet extends HttpServlet{

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
	int userId	= Integer.parseInt(req.getParameter("userId"));
	String fullName = req.getParameter("fullName");
	String gender = req.getParameter("gender");
	String age = req.getParameter("age");
	String appointmentDate = req.getParameter("appointmentDate");
	String email = req.getParameter("email");
	String phone = req.getParameter("phone");
	String diseases = req.getParameter("diseases");
	int doctorId = Integer.parseInt(req.getParameter("doctorNameSelect"));
	String address = req.getParameter("address");
	String timeSlot = req.getParameter("timeSlot");
	
	HttpSession session = req.getSession();
	
	AppointmentDAO appointmentDAO = new AppointmentDAO(DBConnection.getConn());
	
	// Check if the slot is already booked
	if (timeSlot != null && !timeSlot.isEmpty()) {
		boolean slotTaken = appointmentDAO.isSlotBooked(doctorId, appointmentDate, timeSlot);
		if (slotTaken) {
			session.setAttribute("errorMsg", "This time slot is already booked for the selected doctor on this date. Please choose another slot.");
			resp.sendRedirect("user_appointment.jsp");
			return;
		}
	}
	
	Appointment appointment = new Appointment(userId, fullName, gender, age, appointmentDate, email, phone, diseases, doctorId, address, "Pending");
	appointment.setTimeSlot(timeSlot);
	
	boolean f = appointmentDAO.addAppointment(appointment);
	
	if(f==true) {
		session.setAttribute("successMsg", "Appointment booked successfully!");
		resp.sendRedirect("user_appointment.jsp");
	}
	else {
		session.setAttribute("errorMsg", "Something went wrong on server!");
		resp.sendRedirect("user_appointment.jsp");
	}
		
	}

	
}

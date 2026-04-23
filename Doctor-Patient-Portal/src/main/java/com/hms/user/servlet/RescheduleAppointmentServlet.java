package com.hms.user.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.hms.dao.AppointmentDAO;
import com.hms.db.DBConnection;
import com.hms.entity.Appointment;
import com.hms.entity.User;

public class RescheduleAppointmentServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("userObj");

        if (user == null) {
            resp.sendRedirect("user_login.jsp");
            return;
        }

        try {
            int appointmentId = Integer.parseInt(req.getParameter("appointmentId"));
            String newDate = req.getParameter("newDate");
            String newTimeSlot = req.getParameter("newTimeSlot");

            AppointmentDAO appDAO = new AppointmentDAO(DBConnection.getConn());

            // Get the appointment and verify it belongs to this user
            Appointment appt = appDAO.getAppointmentById(appointmentId);
            if (appt == null || appt.getUserId() != user.getId()) {
                session.setAttribute("errorMsg", "Invalid appointment.");
                resp.sendRedirect("view_appointment.jsp");
                return;
            }

            // Only allow rescheduling Pending or Approved appointments
            String status = appt.getStatus();
            if (!"Pending".equals(status) && !"Approved".equalsIgnoreCase(status)) {
                session.setAttribute("errorMsg", "Only Pending or Approved appointments can be rescheduled.");
                resp.sendRedirect("view_appointment.jsp");
                return;
            }

            // Check if new slot is available (exclude current appointment from check)
            if (newTimeSlot != null && !newTimeSlot.isEmpty()) {
                boolean slotTaken = appDAO.isSlotBooked(appt.getDoctorId(), newDate, newTimeSlot, appointmentId);
                if (slotTaken) {
                    session.setAttribute("errorMsg", "That time slot is already booked. Please choose another.");
                    resp.sendRedirect("view_appointment.jsp");
                    return;
                }
            }

            // Perform the reschedule
            boolean success = appDAO.rescheduleAppointment(appointmentId, user.getId(), newDate, newTimeSlot);

            if (success) {
                session.setAttribute("successMsg", "Appointment rescheduled to " + newDate + " at " + newTimeSlot + "!");
            } else {
                session.setAttribute("errorMsg", "Failed to reschedule. Please try again.");
            }

        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("errorMsg", "An error occurred while rescheduling.");
        }

        resp.sendRedirect("view_appointment.jsp");
    }
}

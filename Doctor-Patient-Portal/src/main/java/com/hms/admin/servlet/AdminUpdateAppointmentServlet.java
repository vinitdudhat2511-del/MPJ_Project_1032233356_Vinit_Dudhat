package com.hms.admin.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.hms.dao.AppointmentDAO;
import com.hms.db.DBConnection;
import com.hms.entity.Appointment;
import com.hms.util.EmailUtil;

public class AdminUpdateAppointmentServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        if (session.getAttribute("adminObj") == null) {
            response.sendRedirect("admin_login.jsp");
            return;
        }

        try {
            int appointmentId = Integer.parseInt(request.getParameter("id"));
            String status = request.getParameter("status");

            if (!"Approved".equals(status) && !"Rejected".equals(status)) {
                session.setAttribute("errorMsg", "Invalid status value.");
                response.sendRedirect("admin/patient.jsp");
                return;
            }

            AppointmentDAO appDAO = new AppointmentDAO(DBConnection.getConn());
            boolean success = appDAO.updateAdminAppointmentStatus(appointmentId, status);

            if (success) {
                session.setAttribute("successMsg", "Appointment " + status + " successfully.");

                // Send email notification to patient
                Appointment appt = appDAO.getAppointmentById(appointmentId);
                if (appt != null && appt.getEmail() != null) {
                    String subject = "MediPortal — Appointment " + status;
                    String color = "Approved".equals(status) ? "#00c9b1" : "#ff4757";
                    String icon = "Approved".equals(status) ? "&#10004;" : "&#10008;";
                    String body = "<div style='font-family:Arial,sans-serif;max-width:500px;margin:0 auto;padding:24px;'>"
                        + "<h2 style='color:" + color + ";'>" + icon + " Appointment " + status + "</h2>"
                        + "<p>Dear <strong>" + appt.getFullName() + "</strong>,</p>"
                        + "<p>Your appointment on <strong>" + appt.getAppointmentDate()
                        + (appt.getTimeSlot() != null ? " at " + appt.getTimeSlot() : "")
                        + "</strong> has been <strong style='color:" + color + ";'>" + status + "</strong>.</p>"
                        + "<p style='color:#888;font-size:0.85rem;margin-top:24px;'>— MediPortal Healthcare System</p>"
                        + "</div>";
                    EmailUtil.sendEmail(appt.getEmail(), subject, body);
                }
            } else {
                session.setAttribute("errorMsg", "Failed to update appointment status.");
            }

        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("errorMsg", "An error occurred.");
        }

        response.sendRedirect("admin/patient.jsp");
    }
}

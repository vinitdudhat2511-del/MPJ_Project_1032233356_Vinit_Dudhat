package com.hms.user.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.hms.dao.AppointmentDAO;
import com.hms.db.DBConnection;
import com.hms.entity.User;

public class CancelAppointmentServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("userObj");

        if (user == null) {
            response.sendRedirect("user_login.jsp");
            return;
        }

        try {
            int appointmentId = Integer.parseInt(request.getParameter("id"));
            int userId = user.getId();

            AppointmentDAO appDAO = new AppointmentDAO(DBConnection.getConn());
            boolean success = appDAO.cancelAppointment(appointmentId, userId);

            if (success) {
                session.setAttribute("successMsg", "Appointment cancelled successfully.");
            } else {
                session.setAttribute("errorMsg", "Could not cancel appointment. It may already be processed.");
            }

        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("errorMsg", "An error occurred while cancelling the appointment.");
        }

        response.sendRedirect("view_appointment.jsp");
    }
}

package com.hms.user.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.hms.dao.ReviewDAO;
import com.hms.db.DBConnection;
import com.hms.entity.Review;
import com.hms.entity.User;

public class AddReviewServlet extends HttpServlet {

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
            int doctorId = Integer.parseInt(req.getParameter("doctorId"));
            int appointmentId = Integer.parseInt(req.getParameter("appointmentId"));
            int rating = Integer.parseInt(req.getParameter("rating"));
            String reviewText = req.getParameter("reviewText");

            if (rating < 1 || rating > 5) {
                session.setAttribute("errorMsg", "Rating must be between 1 and 5.");
                resp.sendRedirect("view_appointment.jsp");
                return;
            }

            ReviewDAO reviewDAO = new ReviewDAO(DBConnection.getConn());

            if (reviewDAO.hasUserReviewed(appointmentId)) {
                session.setAttribute("errorMsg", "You have already reviewed this appointment.");
                resp.sendRedirect("view_appointment.jsp");
                return;
            }

            Review review = new Review(doctorId, user.getId(), appointmentId, rating, reviewText);
            boolean success = reviewDAO.addReview(review);

            if (success) {
                session.setAttribute("successMsg", "Thank you for your review!");
            } else {
                session.setAttribute("errorMsg", "Failed to submit review. Please try again.");
            }

        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("errorMsg", "An error occurred while submitting your review.");
        }

        resp.sendRedirect("view_appointment.jsp");
    }
}

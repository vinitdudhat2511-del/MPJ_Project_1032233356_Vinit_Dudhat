package com.hms.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.hms.entity.Review;

public class ReviewDAO {

	private Connection conn;

	public ReviewDAO(Connection conn) {
		this.conn = conn;
	}

	// add a new review
	public boolean addReview(Review review) {
		boolean f = false;
		try {
			String sql = "insert into doctor_review(doctorId, userId, appointmentId, rating, reviewText) values(?,?,?,?,?)";
			PreparedStatement pstmt = this.conn.prepareStatement(sql);
			pstmt.setInt(1, review.getDoctorId());
			pstmt.setInt(2, review.getUserId());
			pstmt.setInt(3, review.getAppointmentId());
			pstmt.setInt(4, review.getRating());
			pstmt.setString(5, review.getReviewText());
			pstmt.executeUpdate();
			f = true;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return f;
	}

	// get all reviews for a doctor
	public List<Review> getReviewsByDoctorId(int doctorId) {
		List<Review> list = new ArrayList<Review>();
		try {
			String sql = "select * from doctor_review where doctorId=? order by createdAt desc";
			PreparedStatement pstmt = this.conn.prepareStatement(sql);
			pstmt.setInt(1, doctorId);
			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) {
				Review r = new Review();
				r.setId(rs.getInt("id"));
				r.setDoctorId(rs.getInt("doctorId"));
				r.setUserId(rs.getInt("userId"));
				r.setAppointmentId(rs.getInt("appointmentId"));
				r.setRating(rs.getInt("rating"));
				r.setReviewText(rs.getString("reviewText"));
				r.setCreatedAt(rs.getString("createdAt"));
				list.add(r);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	// get average rating for a doctor (returns 0.0 if no reviews)
	public double getAverageRating(int doctorId) {
		double avg = 0.0;
		try {
			String sql = "select AVG(rating) as avgRating from doctor_review where doctorId=?";
			PreparedStatement pstmt = this.conn.prepareStatement(sql);
			pstmt.setInt(1, doctorId);
			ResultSet rs = pstmt.executeQuery();
			if (rs.next()) {
				avg = rs.getDouble("avgRating");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return Math.round(avg * 10.0) / 10.0;
	}

	// count reviews for a doctor
	public int getReviewCount(int doctorId) {
		int count = 0;
		try {
			String sql = "select count(*) from doctor_review where doctorId=?";
			PreparedStatement pstmt = this.conn.prepareStatement(sql);
			pstmt.setInt(1, doctorId);
			ResultSet rs = pstmt.executeQuery();
			if (rs.next()) {
				count = rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return count;
	}

	// check if user already reviewed this appointment
	public boolean hasUserReviewed(int appointmentId) {
		boolean reviewed = false;
		try {
			String sql = "select count(*) from doctor_review where appointmentId=?";
			PreparedStatement pstmt = this.conn.prepareStatement(sql);
			pstmt.setInt(1, appointmentId);
			ResultSet rs = pstmt.executeQuery();
			if (rs.next() && rs.getInt(1) > 0) {
				reviewed = true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return reviewed;
	}
}

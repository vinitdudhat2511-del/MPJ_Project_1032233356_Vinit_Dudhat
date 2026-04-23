package com.hms.entity;

public class Review {

	private int id;
	private int doctorId;
	private int userId;
	private int appointmentId;
	private int rating;
	private String reviewText;
	private String createdAt;

	public Review() {
		super();
	}

	public Review(int doctorId, int userId, int appointmentId, int rating, String reviewText) {
		super();
		this.doctorId = doctorId;
		this.userId = userId;
		this.appointmentId = appointmentId;
		this.rating = rating;
		this.reviewText = reviewText;
	}

	public int getId() { return id; }
	public void setId(int id) { this.id = id; }

	public int getDoctorId() { return doctorId; }
	public void setDoctorId(int doctorId) { this.doctorId = doctorId; }

	public int getUserId() { return userId; }
	public void setUserId(int userId) { this.userId = userId; }

	public int getAppointmentId() { return appointmentId; }
	public void setAppointmentId(int appointmentId) { this.appointmentId = appointmentId; }

	public int getRating() { return rating; }
	public void setRating(int rating) { this.rating = rating; }

	public String getReviewText() { return reviewText; }
	public void setReviewText(String reviewText) { this.reviewText = reviewText; }

	public String getCreatedAt() { return createdAt; }
	public void setCreatedAt(String createdAt) { this.createdAt = createdAt; }
}

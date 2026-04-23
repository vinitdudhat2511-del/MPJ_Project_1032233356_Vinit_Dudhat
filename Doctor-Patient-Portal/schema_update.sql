-- ============================================================
-- MediPortal Enhancement SQL Script
-- Run this in your MySQL (hospital database)
-- ============================================================

-- Feature 1: Time Slot Booking
ALTER TABLE appointment ADD COLUMN timeSlot VARCHAR(20) DEFAULT NULL;

-- Feature 3: Doctor Ratings & Reviews
CREATE TABLE IF NOT EXISTS doctor_review (
    id INT AUTO_INCREMENT PRIMARY KEY,
    doctorId INT NOT NULL,
    userId INT NOT NULL,
    appointmentId INT NOT NULL,
    rating INT NOT NULL,
    reviewText VARCHAR(500),
    createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE(appointmentId)
);

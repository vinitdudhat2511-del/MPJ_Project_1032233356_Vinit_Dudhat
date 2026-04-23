package com.hms.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.hms.entity.Appointment;

public class AppointmentDAO {

	private Connection conn;

	public AppointmentDAO(Connection conn) {
		super();
		this.conn = conn;
	}

	// create appointment
	public boolean addAppointment(Appointment appointment) {
		boolean f = false;
		try {
			String sql = "insert into appointment(userId, fullName, gender, age, appointmentDate, email, phone, diseases, doctorId, address, status, timeSlot) values(?,?,?,?,?,?,?,?,?,?,?,?)";
			PreparedStatement pstmt = this.conn.prepareStatement(sql);
			pstmt.setInt(1, appointment.getUserId());
			pstmt.setString(2, appointment.getFullName());
			pstmt.setString(3, appointment.getGender());
			pstmt.setString(4, appointment.getAge());
			pstmt.setString(5, appointment.getAppointmentDate());
			pstmt.setString(6, appointment.getEmail());
			pstmt.setString(7, appointment.getPhone());
			pstmt.setString(8, appointment.getDiseases());
			pstmt.setInt(9, appointment.getDoctorId());
			pstmt.setString(10, appointment.getAddress());
			pstmt.setString(11, appointment.getStatus());
			pstmt.setString(12, appointment.getTimeSlot());
			pstmt.executeUpdate();
			f = true;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return f;
	}

	// helper to map a ResultSet row to Appointment
	private Appointment mapRow(ResultSet rs) throws Exception {
		Appointment a = new Appointment();
		a.setId(rs.getInt("id"));
		a.setUserId(rs.getInt("userId"));
		a.setFullName(rs.getString("fullName"));
		a.setGender(rs.getString("gender"));
		a.setAge(rs.getString("age"));
		a.setAppointmentDate(rs.getString("appointmentDate"));
		a.setEmail(rs.getString("email"));
		a.setPhone(rs.getString("phone"));
		a.setDiseases(rs.getString("diseases"));
		a.setDoctorId(rs.getInt("doctorId"));
		a.setAddress(rs.getString("address"));
		a.setStatus(rs.getString("status"));
		a.setTimeSlot(rs.getString("timeSlot"));
		return a;
	}

	// get appointments for logged-in user
	public List<Appointment> getAllAppointmentByLoginUser(int userId) {
		List<Appointment> appList = new ArrayList<Appointment>();
		try {
			String sql = "select * from appointment where userId=?";
			PreparedStatement pstmt = this.conn.prepareStatement(sql);
			pstmt.setInt(1, userId);
			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) {
				appList.add(mapRow(rs));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return appList;
	}

	// get appointments for specific doctor
	public List<Appointment> getAllAppointmentByLoginDoctor(int doctorId) {
		List<Appointment> appList = new ArrayList<Appointment>();
		try {
			String sql = "select * from appointment where doctorId=?";
			PreparedStatement pstmt = this.conn.prepareStatement(sql);
			pstmt.setInt(1, doctorId);
			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) {
				appList.add(mapRow(rs));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return appList;
	}

	// get appointment by ID
	public Appointment getAppointmentById(int id) {
		Appointment appointment = null;
		try {
			String sql = "select * from appointment where id=?";
			PreparedStatement pstmt = this.conn.prepareStatement(sql);
			pstmt.setInt(1, id);
			ResultSet rs = pstmt.executeQuery();
			if (rs.next()) {
				appointment = mapRow(rs);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return appointment;
	}

	// doctor update comment/prescription status
	public boolean updateDrAppointmentCommentStatus(int apptId, int docId, String comment) {
		boolean f = false;
		try {
			String sql = "update appointment set status=? where id=? and doctorId=?";
			PreparedStatement pstmt = this.conn.prepareStatement(sql);
			pstmt.setString(1, comment);
			pstmt.setInt(2, apptId);
			pstmt.setInt(3, docId);
			pstmt.executeUpdate();
			f = true;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return f;
	}

	// cancel appointment by patient (only if Pending)
	public boolean cancelAppointment(int appointmentId, int userId) {
		boolean f = false;
		try {
			String sql = "update appointment set status='Cancelled' where id=? and userId=? and status='Pending'";
			PreparedStatement pstmt = this.conn.prepareStatement(sql);
			pstmt.setInt(1, appointmentId);
			pstmt.setInt(2, userId);
			int rows = pstmt.executeUpdate();
			if (rows > 0) f = true;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return f;
	}

	// admin approve or reject
	public boolean updateAdminAppointmentStatus(int appointmentId, String status) {
		boolean f = false;
		try {
			String sql = "update appointment set status=? where id=?";
			PreparedStatement pstmt = this.conn.prepareStatement(sql);
			pstmt.setString(1, status);
			pstmt.setInt(2, appointmentId);
			pstmt.executeUpdate();
			f = true;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return f;
	}

	// get all appointments (admin)
	public List<Appointment> getAllAppointment() {
		List<Appointment> appList = new ArrayList<Appointment>();
		try {
			String sql = "select * from appointment order by id desc";
			PreparedStatement pstmt = this.conn.prepareStatement(sql);
			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) {
				appList.add(mapRow(rs));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return appList;
	}

	// check if a slot is already booked for a doctor on a date
	public boolean isSlotBooked(int doctorId, String date, String timeSlot) {
		return isSlotBooked(doctorId, date, timeSlot, -1);
	}

	// overloaded: exclude a specific appointment (for rescheduling)
	public boolean isSlotBooked(int doctorId, String date, String timeSlot, int excludeAppointmentId) {
		boolean booked = false;
		try {
			String sql = "select count(*) from appointment where doctorId=? and appointmentDate=? and timeSlot=? and status != 'Cancelled' and id != ?";
			PreparedStatement pstmt = this.conn.prepareStatement(sql);
			pstmt.setInt(1, doctorId);
			pstmt.setString(2, date);
			pstmt.setString(3, timeSlot);
			pstmt.setInt(4, excludeAppointmentId);
			ResultSet rs = pstmt.executeQuery();
			if (rs.next() && rs.getInt(1) > 0) {
				booked = true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return booked;
	}

	// count appointments by status (for charts)
	public int countByStatus(String status) {
		int count = 0;
		try {
			String sql = "select count(*) from appointment where status=?";
			PreparedStatement pstmt = this.conn.prepareStatement(sql);
			pstmt.setString(1, status);
			ResultSet rs = pstmt.executeQuery();
			if (rs.next()) {
				count = rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return count;
	}

	// reschedule appointment (update date and timeSlot)
	public boolean rescheduleAppointment(int appointmentId, int userId, String newDate, String newTimeSlot) {
		boolean f = false;
		try {
			String sql = "update appointment set appointmentDate=?, timeSlot=?, status='Pending' where id=? and userId=? and (status='Pending' or status='Approved')";
			PreparedStatement pstmt = this.conn.prepareStatement(sql);
			pstmt.setString(1, newDate);
			pstmt.setString(2, newTimeSlot);
			pstmt.setInt(3, appointmentId);
			pstmt.setInt(4, userId);
			int rows = pstmt.executeUpdate();
			if (rows > 0) f = true;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return f;
	}
}

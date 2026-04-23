package com.hms.user.servlet;

import java.io.IOException;
import java.io.OutputStream;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.hms.dao.AppointmentDAO;
import com.hms.dao.DoctorDAO;
import com.hms.db.DBConnection;
import com.hms.entity.Appointment;
import com.hms.entity.Doctor;
import com.hms.entity.User;

import com.itextpdf.text.BaseColor;
import com.itextpdf.text.Document;
import com.itextpdf.text.Element;
import com.itextpdf.text.Font;
import com.itextpdf.text.FontFactory;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.Phrase;
import com.itextpdf.text.Rectangle;
import com.itextpdf.text.pdf.PdfPCell;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfWriter;
import com.itextpdf.text.pdf.draw.LineSeparator;

public class PatientReportServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("userObj");

        if (user == null) {
            resp.sendRedirect("user_login.jsp");
            return;
        }

        try {
            int appointmentId = Integer.parseInt(req.getParameter("id"));

            AppointmentDAO appDAO = new AppointmentDAO(DBConnection.getConn());
            DoctorDAO docDAO = new DoctorDAO(DBConnection.getConn());

            Appointment appt = appDAO.getAppointmentById(appointmentId);

            if (appt == null || appt.getUserId() != user.getId()) {
                resp.sendError(403, "Access denied");
                return;
            }

            Doctor doctor = docDAO.getDoctorById(appt.getDoctorId());

            // Set response headers for PDF download
            resp.setContentType("application/pdf");
            resp.setHeader("Content-Disposition", "attachment; filename=MediPortal_Report_" + appointmentId + ".pdf");

            OutputStream out = resp.getOutputStream();
            Document document = new Document();
            PdfWriter.getInstance(document, out);
            document.open();

            // Colors
            BaseColor teal = new BaseColor(0, 201, 177);
            BaseColor darkBg = new BaseColor(10, 22, 40);
            BaseColor lightGray = new BaseColor(180, 190, 210);

            // Fonts
            Font titleFont = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 22, teal);
            Font headerFont = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 14, teal);
            Font labelFont = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 11, lightGray);
            Font valueFont = FontFactory.getFont(FontFactory.HELVETICA, 11, BaseColor.BLACK);
            Font smallFont = FontFactory.getFont(FontFactory.HELVETICA, 9, new BaseColor(130, 140, 160));
            Font statusFont = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 12);

            // ======== TITLE ========
            Paragraph title = new Paragraph("MediPortal", titleFont);
            title.setAlignment(Element.ALIGN_CENTER);
            document.add(title);

            Paragraph subtitle = new Paragraph("Patient Appointment Report", FontFactory.getFont(FontFactory.HELVETICA, 12, lightGray));
            subtitle.setAlignment(Element.ALIGN_CENTER);
            subtitle.setSpacingAfter(10);
            document.add(subtitle);

            document.add(new LineSeparator(1.5f, 100, teal, Element.ALIGN_CENTER, -2));
            document.add(new Paragraph(" "));

            // ======== PATIENT INFO TABLE ========
            Paragraph patientHeader = new Paragraph("Patient Information", headerFont);
            patientHeader.setSpacingBefore(10);
            patientHeader.setSpacingAfter(8);
            document.add(patientHeader);

            PdfPTable patientTable = new PdfPTable(2);
            patientTable.setWidthPercentage(100);
            patientTable.setWidths(new float[]{1, 2});

            addTableRow(patientTable, "Full Name", appt.getFullName(), labelFont, valueFont);
            addTableRow(patientTable, "Gender", appt.getGender(), labelFont, valueFont);
            addTableRow(patientTable, "Age", appt.getAge() + " years", labelFont, valueFont);
            addTableRow(patientTable, "Email", appt.getEmail(), labelFont, valueFont);
            addTableRow(patientTable, "Phone", appt.getPhone(), labelFont, valueFont);
            addTableRow(patientTable, "Address", appt.getAddress(), labelFont, valueFont);

            document.add(patientTable);
            document.add(new Paragraph(" "));

            // ======== APPOINTMENT INFO TABLE ========
            Paragraph apptHeader = new Paragraph("Appointment Details", headerFont);
            apptHeader.setSpacingBefore(10);
            apptHeader.setSpacingAfter(8);
            document.add(apptHeader);

            PdfPTable apptTable = new PdfPTable(2);
            apptTable.setWidthPercentage(100);
            apptTable.setWidths(new float[]{1, 2});

            addTableRow(apptTable, "Appointment ID", "#" + appt.getId(), labelFont, valueFont);
            addTableRow(apptTable, "Date", appt.getAppointmentDate(), labelFont, valueFont);
            addTableRow(apptTable, "Time Slot", appt.getTimeSlot() != null ? appt.getTimeSlot() : "Not specified", labelFont, valueFont);
            addTableRow(apptTable, "Doctor", "Dr. " + (doctor != null ? doctor.getFullName() : "N/A"), labelFont, valueFont);
            addTableRow(apptTable, "Specialization", doctor != null ? doctor.getSpecialist() : "N/A", labelFont, valueFont);
            addTableRow(apptTable, "Diseases/Symptoms", appt.getDiseases(), labelFont, valueFont);

            // Status row with color
            String status = appt.getStatus();
            BaseColor statusColor = new BaseColor(255, 211, 42); // Pending yellow
            if ("Approved".equalsIgnoreCase(status)) statusColor = teal;
            else if ("Rejected".equalsIgnoreCase(status)) statusColor = new BaseColor(255, 71, 87);
            else if ("Cancelled".equalsIgnoreCase(status)) statusColor = new BaseColor(140, 160, 190);
            statusFont.setColor(statusColor);
            
            PdfPCell statusLabel = new PdfPCell(new Phrase("Status", labelFont));
            statusLabel.setBorder(Rectangle.BOTTOM);
            statusLabel.setPadding(8);
            PdfPCell statusValue = new PdfPCell(new Phrase(status, statusFont));
            statusValue.setBorder(Rectangle.BOTTOM);
            statusValue.setPadding(8);
            apptTable.addCell(statusLabel);
            apptTable.addCell(statusValue);

            document.add(apptTable);
            document.add(new Paragraph(" "));

            // ======== PRESCRIPTION (if any) ========
            if (status != null && !"Pending".equals(status) && !"Cancelled".equals(status) && !"Approved".equals(status) && !"Rejected".equals(status)) {
                Paragraph rxHeader = new Paragraph("Doctor's Prescription / Notes", headerFont);
                rxHeader.setSpacingBefore(10);
                rxHeader.setSpacingAfter(8);
                document.add(rxHeader);

                Paragraph rxContent = new Paragraph(status, FontFactory.getFont(FontFactory.HELVETICA, 12, BaseColor.BLACK));
                rxContent.setSpacingAfter(10);
                document.add(rxContent);

                document.add(new Paragraph(" "));
            }

            // ======== FOOTER ========
            document.add(new LineSeparator(0.5f, 100, lightGray, Element.ALIGN_CENTER, -2));

            Paragraph footer = new Paragraph("Generated by MediPortal Healthcare System | This is a computer-generated document.", smallFont);
            footer.setAlignment(Element.ALIGN_CENTER);
            footer.setSpacingBefore(15);
            document.add(footer);

            Paragraph disclaimer = new Paragraph("For any queries, contact support@mediportal.com", smallFont);
            disclaimer.setAlignment(Element.ALIGN_CENTER);
            document.add(disclaimer);

            document.close();
            out.flush();
            out.close();

        } catch (Exception e) {
            e.printStackTrace();
            resp.sendError(500, "Error generating PDF report");
        }
    }

    private void addTableRow(PdfPTable table, String label, String value, Font labelFont, Font valueFont) {
        PdfPCell labelCell = new PdfPCell(new Phrase(label, labelFont));
        labelCell.setBorder(Rectangle.BOTTOM);
        labelCell.setPadding(8);
        labelCell.setBorderColor(new BaseColor(200, 210, 220));

        PdfPCell valueCell = new PdfPCell(new Phrase(value != null ? value : "—", valueFont));
        valueCell.setBorder(Rectangle.BOTTOM);
        valueCell.setPadding(8);
        valueCell.setBorderColor(new BaseColor(200, 210, 220));

        table.addCell(labelCell);
        table.addCell(valueCell);
    }
}

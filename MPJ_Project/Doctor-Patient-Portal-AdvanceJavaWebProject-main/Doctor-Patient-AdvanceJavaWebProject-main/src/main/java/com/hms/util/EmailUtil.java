package com.hms.util;

import java.util.Properties;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class EmailUtil {

    // ============================================================
    // CONFIGURE THESE WITH YOUR GMAIL CREDENTIALS
    // You need a Gmail App Password (enable 2FA first):
    // https://myaccount.google.com/apppasswords
    // ============================================================
    private static final String SENDER_EMAIL = "mediportal.notifications@gmail.com";
    private static final String SENDER_PASSWORD = "YOUR_APP_PASSWORD_HERE";

    public static boolean sendEmail(String toEmail, String subject, String body) {
        boolean sent = false;
        try {
            Properties props = new Properties();
            props.put("mail.smtp.host", "smtp.gmail.com");
            props.put("mail.smtp.port", "587");
            props.put("mail.smtp.auth", "true");
            props.put("mail.smtp.starttls.enable", "true");
            props.put("mail.smtp.ssl.protocols", "TLSv1.2");

            Session mailSession = Session.getInstance(props, new Authenticator() {
                @Override
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(SENDER_EMAIL, SENDER_PASSWORD);
                }
            });

            MimeMessage message = new MimeMessage(mailSession);
            message.setFrom(new InternetAddress(SENDER_EMAIL, "MediPortal"));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
            message.setSubject(subject);
            message.setContent(body, "text/html; charset=UTF-8");

            Transport.send(message);
            sent = true;
            System.out.println("Email sent successfully to: " + toEmail);

        } catch (Exception e) {
            System.out.println("Email sending failed (SMTP not configured): " + e.getMessage());
            // Don't block the flow if email fails — just log it
        }
        return sent;
    }
}

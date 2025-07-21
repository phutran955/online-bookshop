package utils;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Properties;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import model.OrderDTO;
import model.UserDTO;

public class EmailUtlils {

    private static final String FROM_EMAIL = "phu019168@gmail.com";
    private static final String PASSWORD = "knbvycelkmtcpfmc";

    public static String generateCheckoutConfirmationEmail(UserDTO user, OrderDTO order) {
        SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");

        StringBuilder html = new StringBuilder();
        html.append("<html><body style='font-family:Arial,sans-serif;'>");

        html.append("<h2 style='color:#2e6c80;'>Order Confirmation #" + order.getOrderId() + "</h2>");
        html.append("<p>Hello <strong>").append(user.getFullName()).append("</strong>,</p>");
        html.append("<p>Thank you for your order at our store!</p>");

        html.append("<h3>Order Details:</h3>");
        html.append("<table style='border-collapse:collapse;'>");
        html.append("<tr><td><strong>Order ID:</strong></td><td>#").append(order.getOrderId()).append("</td></tr>");
        html.append("<tr><td><strong>Order Date:</strong></td><td>").append(sdf.format(order.getDate())).append("</td></tr>");
        html.append("<tr><td><strong>Total Amount:</strong></td><td>").append(String.format("%,.0f", order.getTotalMoney())).append(" VND</td></tr>");
        html.append("<tr><td><strong>Status:</strong></td><td>").append(order.isStatus() ? "Processed" : "Unprocessed").append("</td></tr>");
        html.append("</table>");

        html.append("<h3>Customer Information:</h3>");
        html.append("<table style='border-collapse:collapse;'>");
        html.append("<tr><td><strong>Username:</strong></td><td>").append(user.getUserName()).append("</td></tr>");
        html.append("<tr><td><strong>Full Name:</strong></td><td>").append(user.getFullName()).append("</td></tr>");
        html.append("<tr><td><strong>Email:</strong></td><td>").append(user.getEmail()).append("</td></tr>");
        html.append("<tr><td><strong>Date of Birth:</strong></td><td>").append(sdf.format(user.getBirthDay())).append("</td></tr>");
        html.append("<tr><td><strong>Phone:</strong></td><td>").append(user.getPhone()).append("</td></tr>");
        html.append("<tr><td><strong>Address:</strong></td><td>").append(user.getAddress()).append("</td></tr>");
        html.append("</table>");

        html.append("<p style='margin-top:20px;'>Your order will be processed as soon as possible.</p>");
        html.append("<p style='color:gray;font-size:12px;'>Please do not reply to this email.</p>");
        html.append("</body></html>");

        return html.toString();
    }

    public static String generateOrderStatusUpdatedEmail(UserDTO user, OrderDTO order) {
        StringBuilder html = new StringBuilder();

        html.append("<html><body style='font-family:Arial,sans-serif;'>");
        html.append("<h2 style='color:#2e6c80;'>Order Status Updated</h2>");
        html.append("<p>Hello <strong>").append(user.getFullName()).append("</strong>,</p>");
        html.append("<p>Your order <strong>#").append(order.getOrderId()).append("</strong> has been <span style='color:green;'>processed successfully</span>.</p>");
        html.append("<p>Thank you for shopping with us!</p>");
        html.append("<p style='color:gray;font-size:12px;'>Please do not reply to this email.</p>");
        html.append("</body></html>");

        return html.toString();
    }

    // Hàm gửi email cơ bản, tái sử dụng
    public static boolean sendEmail(String to, String subject, String content) {
        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");

        Authenticator auth = new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(FROM_EMAIL, PASSWORD);
            }
        };

        try {
            Session session = Session.getInstance(props, auth);
            MimeMessage msg = new MimeMessage(session);

            msg.setFrom(new InternetAddress(FROM_EMAIL));
            msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to, false));
            msg.setSubject(subject, "UTF-8");
            msg.setSentDate(new Date());
            msg.setContent(content, "text/html; charset=UTF-8");

            Transport.send(msg);
            System.out.println("Email sent to " + to);
            return true;
        } catch (Exception e) {
            System.err.println("Error sending email to " + to);
            e.printStackTrace();
            return false;
        }
    }
}

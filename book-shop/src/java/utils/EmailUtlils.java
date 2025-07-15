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

        html.append("<h2 style='color:#2e6c80;'>Xác nhận đơn hàng #" + order.getOrderId() + "</h2>");
        html.append("<p>Xin chào <strong>").append(user.getFullName()).append("</strong>,</p>");
        html.append("<p>Cảm ơn bạn đã đặt hàng tại cửa hàng của chúng tôi!</p>");

        html.append("<h3>Thông tin đơn hàng:</h3>");
        html.append("<table style='border-collapse:collapse;'>");
        html.append("<tr><td><strong>Mã đơn hàng:</strong></td><td>#").append(order.getOrderId()).append("</td></tr>");
        html.append("<tr><td><strong>Ngày đặt:</strong></td><td>").append(sdf.format(order.getDate())).append("</td></tr>");
        html.append("<tr><td><strong>Tổng tiền:</strong></td><td>").append(String.format("%,.0f", order.getTotalMoney())).append(" VND</td></tr>");
        html.append("<tr><td><strong>Trạng thái:</strong></td><td>").append(order.isStatus() ? "Đã xử lý" : "Chưa xử lý").append("</td></tr>");
        html.append("</table>");

        html.append("<h3>Thông tin khách hàng:</h3>");
        html.append("<table style='border-collapse:collapse;'>");
        html.append("<tr><td><strong>Tên đăng nhập:</strong></td><td>").append(user.getUserName()).append("</td></tr>");
        html.append("<tr><td><strong>Họ tên:</strong></td><td>").append(user.getFullName()).append("</td></tr>");
        html.append("<tr><td><strong>Email:</strong></td><td>").append(user.getEmail()).append("</td></tr>");
        html.append("<tr><td><strong>Ngày sinh:</strong></td><td>").append(sdf.format(user.getBirthDay())).append("</td></tr>");
        html.append("<tr><td><strong>Điện thoại:</strong></td><td>").append(user.getPhone()).append("</td></tr>");
        html.append("<tr><td><strong>Địa chỉ:</strong></td><td>").append(user.getAddress()).append("</td></tr>");
        html.append("</table>");

        html.append("<p style='margin-top:20px;'>Đơn hàng của bạn sẽ được xử lý trong thời gian sớm nhất.</p>");
        html.append("<p style='color:gray;font-size:12px;'>Vui lòng không phản hồi email này.</p>");
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

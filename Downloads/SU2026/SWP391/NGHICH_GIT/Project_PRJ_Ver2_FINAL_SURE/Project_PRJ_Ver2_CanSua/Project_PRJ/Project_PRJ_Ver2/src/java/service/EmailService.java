package service;

import jakarta.servlet.http.HttpServletRequest;
import model.Order;
import model.User;

/**
 * Gửi email xác nhận đơn hàng.
 *
 * Hiện tại triển khai ở mức đơn giản:
 *  - Ghi log nội dung email vào console server.
 *  - Không phụ thuộc thư viện mail ngoài, nên project vẫn build bình thường.
 * Sau này nếu muốn gửi email thật, có thể mở rộng lớp này để tích hợp Jakarta Mail.
 */
public class EmailService {

    public void sendOrderConfirmation(HttpServletRequest request, User user, Order order) {
        if (user == null || order == null) return;
        String email = user.getEmail();
        if (email == null || email.isBlank()) return;

        String subject = "[TTGShop7] Xác nhận đơn hàng #" + order.getOrderId();
        String body = buildOrderBody(user, order);

        System.out.println("===== ORDER CONFIRMATION EMAIL (SIMULATION) =====");
        System.out.println("To      : " + email);
        System.out.println("Subject : " + subject);
        System.out.println("Content :");
        System.out.println(body);
        System.out.println("==================================================");
    }

    private String buildOrderBody(User user, Order order) {
        StringBuilder sb = new StringBuilder();
        sb.append("Xin chào ").append(user.getFullName() != null ? user.getFullName() : user.getUsername()).append(",\n\n");
        sb.append("Cảm ơn bạn đã đặt hàng tại TTGShop7.\n");
        sb.append("Mã đơn hàng: #").append(order.getOrderId()).append("\n");
        sb.append("Tổng tiền : ").append(order.getTotalAmount()).append(" VND\n");
        sb.append("Thanh toán: ").append(order.getPaymentMethod()).append("\n");
        sb.append("Trạng thái: ").append(order.getStatus()).append("\n\n");
        sb.append("Bạn có thể xem lại chi tiết đơn hàng tại trang \"Đơn hàng của tôi\".\n\n");
        sb.append("Trân trọng,\n");
        sb.append("TTGShop7 Team");
        return sb.toString();
    }
}


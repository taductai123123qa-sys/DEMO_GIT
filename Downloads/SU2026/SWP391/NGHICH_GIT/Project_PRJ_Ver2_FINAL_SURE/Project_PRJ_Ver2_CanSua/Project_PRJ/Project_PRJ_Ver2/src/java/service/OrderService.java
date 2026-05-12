/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package service;

import dal.OrderDAO;
import jakarta.servlet.http.HttpServletRequest;
import model.Cart;
import model.Order;
import model.User;
import utils.SessionUtil;

import java.sql.SQLException;
import java.util.List;

public class OrderService {

    private final OrderDAO orderDAO = new OrderDAO();
    private final EmailService emailService = new EmailService();

    public int checkout(HttpServletRequest request, Cart cart, String paymentMethod) throws SQLException {
        User user = SessionUtil.getUser(request);
        if (user == null) {
            throw new IllegalStateException("User not logged in");
        }
        if (cart == null || cart.isEmpty()) {
            throw new IllegalStateException("Cart is empty");
        }
        int orderId = orderDAO.createOrder(user.getUserId(), cart, paymentMethod);

        // Sau khi tạo đơn, gửi email xác nhận (mô phỏng bằng log)
        Order order = new Order();
        order.setOrderId(orderId);
        order.setUserId(user.getUserId());
        order.setTotalAmount(cart.getTotalAmount());
        order.setPaymentMethod(paymentMethod);
        // Nếu chọn thanh toán online giả lập thì đánh dấu đã thanh toán
        order.setStatus("ONLINE".equalsIgnoreCase(paymentMethod) ? "PAID" : "PENDING");
        emailService.sendOrderConfirmation(request, user, order);

        return orderId;
    }

    public List<Order> getOrderHistory(HttpServletRequest request) {
        User user = SessionUtil.getUser(request);
        if (user == null) {
            throw new IllegalStateException("User not logged in");
        }
        List<Order> orders = orderDAO.findByUser(user.getUserId());
        orderDAO.attachDetails(orders);
        return orders;
    }
}

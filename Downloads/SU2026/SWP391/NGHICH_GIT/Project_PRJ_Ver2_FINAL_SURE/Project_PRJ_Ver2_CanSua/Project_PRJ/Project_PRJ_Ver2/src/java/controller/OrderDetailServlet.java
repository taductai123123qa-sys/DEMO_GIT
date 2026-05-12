package controller;

import dal.OrderDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import model.Order;
import model.OrderDetail;
import utils.SessionUtil;

/**
 * Servlet hiển thị chi tiết một đơn hàng cụ thể
 */
@WebServlet(name = "OrderDetailServlet", urlPatterns = {"/order-detail"})
public class OrderDetailServlet extends HttpServlet {

    private final OrderDAO orderDAO = new OrderDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Lấy orderId từ parameter
        String orderIdParam = request.getParameter("id");
        if (orderIdParam == null || orderIdParam.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/OrderHistory");
            return;
        }

        try {
            int orderId = Integer.parseInt(orderIdParam);
            
            // Lấy thông tin đơn hàng
            Order order = orderDAO.getById(orderId);
            if (order == null) {
                response.sendRedirect(request.getContextPath() + "/OrderHistory");
                return;
            }

            // Kiểm tra quyền: chỉ user tạo đơn hàng mới được xem
            var user = SessionUtil.getUser(request);
            if (user == null || order.getUserId() != user.getUserId()) {
                response.sendRedirect(request.getContextPath() + "/OrderHistory");
                return;
            }

            // Lấy chi tiết đơn hàng
            List<OrderDetail> orderDetails = orderDAO.getOrderDetails(orderId);
            order.setDetails(orderDetails);

            // Set attributes cho JSP
            request.setAttribute("order", order);

            // Forward đến trang chi tiết
            request.getRequestDispatcher("/OrderDetail.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/OrderHistory");
        }
    }
}

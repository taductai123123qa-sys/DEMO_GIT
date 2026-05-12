/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import model.Cart;
import model.CartItem;
import model.Order;
import model.OrderDetail;
import utils.DBContext;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class OrderDAO {

    public int createOrder(int userId, Cart cart, String paymentMethod) throws SQLException {
        String insertOrderSql = "INSERT INTO Orders (userId, totalAmount, paymentMethod, status, createdAt) " +
                "VALUES (?, ?, ?, ?, GETDATE())";
        String insertDetailSql = "INSERT INTO OrderDetails (orderId, productId, quantity, unitPrice) " +
                "VALUES (?, ?, ?, ?)";
        String selectStockSql = "SELECT stock FROM Products WHERE productId = ?";
        String updateProductSql = "UPDATE Products SET stock = stock - ?, soldCount = soldCount + ? " +
                "WHERE productId = ?";

        Connection conn = null;
        PreparedStatement orderPs = null;
        PreparedStatement detailPs = null;
        PreparedStatement stockPs = null;
        PreparedStatement updateProductPs = null;

        try {
            conn = DBContext.getConnection();
            conn.setAutoCommit(false);

            // Kiểm tra tồn kho cho từng sản phẩm trong giỏ
            stockPs = conn.prepareStatement(selectStockSql);
            for (CartItem item : cart.getItems()) {
                stockPs.setInt(1, item.getProduct().getProductId());
                try (ResultSet rs = stockPs.executeQuery()) {
                    if (!rs.next()) {
                        conn.rollback();
                        throw new SQLException("Sản phẩm không tồn tại (ID=" + item.getProduct().getProductId() + ")");
                    }
                    int stock = rs.getInt("stock");
                    if (stock < item.getQuantity()) {
                        conn.rollback();
                        throw new SQLException("Sản phẩm \"" + item.getProduct().getName() + "\" không đủ tồn kho.");
                    }
                }
            }

            // Tạo đơn hàng
            orderPs = conn.prepareStatement(insertOrderSql, Statement.RETURN_GENERATED_KEYS);
            BigDecimal total = cart.getTotalAmount();

            orderPs.setInt(1, userId);
            orderPs.setBigDecimal(2, total);
            orderPs.setString(3, paymentMethod);
            orderPs.setString(4, "PENDING");
            orderPs.executeUpdate();

            int orderId;
            try (ResultSet rs = orderPs.getGeneratedKeys()) {
                if (!rs.next()) {
                    conn.rollback();
                    throw new SQLException("Cannot get generated order id");
                }
                orderId = rs.getInt(1);
            }

            // Lưu chi tiết đơn + cập nhật stock, soldCount
            detailPs = conn.prepareStatement(insertDetailSql);
            updateProductPs = conn.prepareStatement(updateProductSql);
            for (CartItem item : cart.getItems()) {
                int productId = item.getProduct().getProductId();
                int quantity = item.getQuantity();

                detailPs.setInt(1, orderId);
                detailPs.setInt(2, productId);
                detailPs.setInt(3, quantity);
                detailPs.setBigDecimal(4, item.getProduct().getPrice());
                detailPs.addBatch();

                updateProductPs.setInt(1, quantity);
                updateProductPs.setInt(2, quantity);
                updateProductPs.setInt(3, productId);
                updateProductPs.addBatch();
            }
            detailPs.executeBatch();
            updateProductPs.executeBatch();

            conn.commit();
            return orderId;
        } catch (SQLException e) {
            if (conn != null) {
                conn.rollback();
            }
            throw e;
        } finally {
            if (conn != null) {
                try {
                    conn.setAutoCommit(true);
                } catch (SQLException ignored) {
                }
            }
            DBContext.closeQuietly(conn, orderPs, null);
            DBContext.closeQuietly(null, detailPs, null);
            DBContext.closeQuietly(null, stockPs, null);
            DBContext.closeQuietly(null, updateProductPs, null);
        }
    }

    public List<Order> findByUser(int userId) {
        List<Order> list = new ArrayList<>();
        String sql = "SELECT orderId, userId, totalAmount, paymentMethod, status, createdAt " +
                "FROM Orders WHERE userId = ? ORDER BY createdAt DESC";

        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Order o = new Order();
                    o.setOrderId(rs.getInt("orderId"));
                    o.setUserId(rs.getInt("userId"));
                    o.setTotalAmount(rs.getBigDecimal("totalAmount"));
                    o.setPaymentMethod(rs.getString("paymentMethod"));
                    o.setStatus(rs.getString("status"));
                    o.setCreatedAt(rs.getTimestamp("createdAt"));
                    list.add(o);
                }
            }
        } catch (SQLException e) {
            System.err.println("OrderDAO.findByUser error: " + e.getMessage());
            e.printStackTrace();
        }

        return list;
    }

    public int countAll(String status) {
        StringBuilder sql = new StringBuilder("SELECT COUNT(*) FROM Orders WHERE 1=1");
        List<Object> params = new ArrayList<>();
        if (status != null && !status.isBlank() && !"all".equalsIgnoreCase(status)) {
            sql.append(" AND status = ?");
            params.add(status);
        }

        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql.toString())) {

            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        } catch (SQLException e) {
            System.err.println("OrderDAO.countAll error: " + e.getMessage());
            e.printStackTrace();
        }
        return 0;
    }

    public List<Order> findAll(String status, int page, int pageSize) {
        List<Order> list = new ArrayList<>();

        StringBuilder sql = new StringBuilder(
                "SELECT orderId, userId, totalAmount, paymentMethod, status, createdAt " +
                        "FROM Orders WHERE 1=1");
        List<Object> params = new ArrayList<>();

        if (status != null && !status.isBlank() && !"all".equalsIgnoreCase(status)) {
            sql.append(" AND status = ?");
            params.add(status);
        }

        sql.append(" ORDER BY createdAt DESC OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");

        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql.toString())) {

            int idx = 1;
            for (Object p : params) {
                ps.setObject(idx++, p);
            }
            ps.setInt(idx++, Math.max(0, (page - 1) * pageSize));
            ps.setInt(idx, pageSize);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Order o = new Order();
                    o.setOrderId(rs.getInt("orderId"));
                    o.setUserId(rs.getInt("userId"));
                    o.setTotalAmount(rs.getBigDecimal("totalAmount"));
                    o.setPaymentMethod(rs.getString("paymentMethod"));
                    o.setStatus(rs.getString("status"));
                    o.setCreatedAt(rs.getTimestamp("createdAt"));
                    list.add(o);
                }
            }
        } catch (SQLException e) {
            System.err.println("OrderDAO.findAll error: " + e.getMessage());
            e.printStackTrace();
        }

        return list;
    }

    public List<OrderDetail> findDetailsByOrder(int orderId) {
        List<OrderDetail> list = new ArrayList<>();
        String sql = "SELECT d.orderDetailId, d.orderId, d.productId, d.quantity, d.unitPrice, p.name AS productName " +
                "FROM OrderDetails d JOIN Products p ON d.productId = p.productId " +
                "WHERE d.orderId = ?";

        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, orderId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    OrderDetail d = new OrderDetail();
                    d.setOrderDetailId(rs.getInt("orderDetailId"));
                    d.setOrderId(rs.getInt("orderId"));
                    d.setProductId(rs.getInt("productId"));
                    d.setProductName(rs.getString("productName"));
                    d.setQuantity(rs.getInt("quantity"));
                    d.setUnitPrice(rs.getBigDecimal("unitPrice"));
                    list.add(d);
                }
            }
        } catch (SQLException e) {
            System.err.println("OrderDAO.findDetailsByOrder error: " + e.getMessage());
            e.printStackTrace();
        }

        return list;
    }

    public void attachDetails(List<Order> orders) {
        if (orders == null || orders.isEmpty()) {
            return;
        }
        for (Order o : orders) {
            o.setDetails(findDetailsByOrder(o.getOrderId()));
        }
    }

    public boolean updateStatus(int orderId, String status) {
        String sql = "UPDATE Orders SET status = ? WHERE orderId = ?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, status);
            ps.setInt(2, orderId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("OrderDAO.updateStatus error: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    public Order getById(int orderId) {
        String sql = "SELECT * FROM Orders WHERE orderId = ?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, orderId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Order order = new Order();
                    order.setOrderId(rs.getInt("orderId"));
                    order.setUserId(rs.getInt("userId"));
                    order.setTotalAmount(rs.getBigDecimal("totalAmount"));
                    order.setPaymentMethod(rs.getString("paymentMethod"));
                    order.setStatus(rs.getString("status"));
                    order.setCreatedAt(rs.getTimestamp("createdAt"));
                    return order;
                }
            }
        } catch (SQLException e) {
            System.err.println("OrderDAO.getById error: " + e.getMessage());
            e.printStackTrace();
            return null;
        }
        return null;
    }

    public List<OrderDetail> getOrderDetails(int orderId) {
        List<OrderDetail> details = new ArrayList<>();
        String sql = "SELECT od.*, p.productId, p.name as productName, p.description as productDesc, " +
                    "p.price as productPrice, p.stock as productStock, p.images as productImage " +
                    "FROM OrderDetails od " +
                    "LEFT JOIN Products p ON od.productId = p.productId " +
                    "WHERE od.orderId = ? " +
                    "ORDER BY od.orderDetailId";
        
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, orderId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    OrderDetail detail = new OrderDetail();
                    detail.setOrderDetailId(rs.getInt("orderDetailId"));
                    detail.setOrderId(rs.getInt("orderId"));
                    detail.setProductId(rs.getInt("productId"));
                    detail.setQuantity(rs.getInt("quantity"));
                    detail.setUnitPrice(rs.getBigDecimal("unitPrice"));
                    
                    // Set full product info for display
                    model.Product product = new model.Product();
                    product.setProductId(rs.getInt("productId"));
                    product.setName(rs.getString("productName"));
                    product.setDescription(rs.getString("productDesc"));
                    product.setPrice(rs.getBigDecimal("productPrice"));
                    product.setStock(rs.getInt("productStock"));
                    product.setImages(rs.getString("productImage"));
                    detail.setProduct(product);
                    
                    details.add(detail);
                }
            }
        } catch (SQLException e) {
            System.err.println("OrderDAO.getOrderDetails error: " + e.getMessage());
            e.printStackTrace();
        }
        return details;
    }
}

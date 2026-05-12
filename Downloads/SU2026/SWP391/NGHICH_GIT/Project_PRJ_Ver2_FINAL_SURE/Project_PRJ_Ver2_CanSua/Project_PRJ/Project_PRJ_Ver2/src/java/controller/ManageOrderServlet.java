/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.List;

import dal.OrderDAO;
import model.Order;
import model.OrderDetail;

/**
 * Quản lý đơn hàng (Admin):
 * - Xem danh sách + lọc theo trạng thái + phân trang
 * - Xem chi tiết
 * - Cập nhật trạng thái
 * - Export Excel
 */
@WebServlet(name="ManageOrderServlet", urlPatterns={"/manageorder"})
public class ManageOrderServlet extends HttpServlet {

    private static final int PAGE_SIZE = 12;
    private final OrderDAO orderDAO = new OrderDAO();

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /** 
     * Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        if ("export".equalsIgnoreCase(action)) {
            exportExcel(request, response);
            return;
        }

        String status = request.getParameter("status");
        if (status == null || status.isBlank()) status = "all";

        int page = 1;
        String pageStr = request.getParameter("page");
        if (pageStr != null) {
            try {
                page = Integer.parseInt(pageStr);
                if (page < 1) page = 1;
            } catch (NumberFormatException ignored) {
            }
        }

        int total = orderDAO.countAll(status);
        int totalPages = (int) Math.ceil((double) total / PAGE_SIZE);
        if (totalPages == 0) totalPages = 1;
        if (page > totalPages) page = totalPages;

        List<Order> orders = orderDAO.findAll(status, page, PAGE_SIZE);
        orderDAO.attachDetails(orders);

        request.setAttribute("orders", orders);
        request.setAttribute("curStatus", status);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("totalOrders", total);

        request.getRequestDispatcher("/admin/ManageOrder.jsp").forward(request, response);
    }

    /** 
     * Handles the HTTP <code>POST</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");
        if ("updateStatus".equals(action)) {
            String orderIdStr = request.getParameter("orderId");
            String newStatus = request.getParameter("newStatus");
            try {
                int orderId = Integer.parseInt(orderIdStr);
                if (newStatus == null || newStatus.isBlank()) {
                    request.setAttribute("error", "Trạng thái không hợp lệ.");
                } else {
                    boolean ok = orderDAO.updateStatus(orderId, newStatus);
                    request.setAttribute("message", ok ? "Cập nhật trạng thái thành công." : "Không thể cập nhật trạng thái.");
                }
            } catch (NumberFormatException e) {
                request.setAttribute("error", "OrderId không hợp lệ.");
            }
        }

        doGet(request, response);
    }

    private void exportExcel(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String status = request.getParameter("status");
        if (status == null || status.isBlank()) status = "all";

        // Export toàn bộ theo filter status (không phân trang)
        List<Order> orders = orderDAO.findAll(status, 1, Integer.MAX_VALUE / 4);
        orderDAO.attachDetails(orders);

        // Tạo Excel file với CSV format thay vì XLSX để tránh log4j dependency
        response.setContentType("text/csv");
        response.setHeader("Content-Disposition", "attachment; filename=\"orders_export.csv\"");

        try (PrintWriter writer = response.getWriter()) {
            // Header CSV
            writer.println("Order ID,User ID,Total Amount,Payment,Status,Created At,Items");
            
            // Data rows
            for (Order o : orders) {
                StringBuilder itemsSummary = new StringBuilder();
                if (o.getDetails() != null) {
                    for (OrderDetail detail : o.getDetails()) {
                        if (itemsSummary.length() > 0) itemsSummary.append("; ");
                        itemsSummary.append(detail.getQuantity()).append(" x ")
                                    .append(detail.getProductName() != null ? detail.getProductName() : "Unknown");
                    }
                }
                
                String row = String.format("%d,%d,%.2f,%s,%s,%s,\"%s\"",
                    o.getOrderId(),
                    o.getUserId(),
                    o.getTotalAmount() != null ? o.getTotalAmount().doubleValue() : 0,
                    escapeCSV(o.getPaymentMethod()),
                    escapeCSV(o.getStatus()),
                    o.getCreatedAt() != null ? o.getCreatedAt().toString() : "",
                    escapeCSV(itemsSummary.toString())
                );
                writer.println(row);
            }
            
            writer.flush();
        }
    }

    private String escapeCSV(String value) {
        if (value == null) return "";
        // Escape commas and quotes in CSV
        if (value.contains(",") || value.contains("\"")) {
            return value.replace("\"", "\"\"");
        }
        return value;
    }
}

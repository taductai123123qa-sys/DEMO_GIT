/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import utils.DBContext;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import model.DashboardMonthlyRevenue;
import model.DashboardStatusCount;

/**
 * Lấy số liệu thống kê cho trang Admin Dashboard.
 */
public class DashBoardDAO {

    public BigDecimal getTotalRevenue() {
        String sql = "SELECT SUM(totalAmount) FROM Orders";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            if (rs.next()) {
                BigDecimal value = rs.getBigDecimal(1);
                return value != null ? value : BigDecimal.ZERO;
            }
        } catch (SQLException e) {
            System.err.println("DashBoardDAO.getTotalRevenue error: " + e.getMessage());
            e.printStackTrace();
        }
        return BigDecimal.ZERO;
    }

    public int getTotalOrders() {
        String sql = "SELECT COUNT(*) FROM Orders";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            System.err.println("DashBoardDAO.getTotalOrders error: " + e.getMessage());
            e.printStackTrace();
        }
        return 0;
    }

    public int getTotalUsers() {
        String sql = "SELECT COUNT(*) FROM Users";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            System.err.println("DashBoardDAO.getTotalUsers error: " + e.getMessage());
            e.printStackTrace();
        }
        return 0;
    }

    public BigDecimal getTodayRevenue() {
        String sql = "SELECT SUM(totalAmount) FROM Orders " +
                "WHERE CAST(createdAt AS DATE) = CAST(GETDATE() AS DATE)";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            if (rs.next()) {
                BigDecimal value = rs.getBigDecimal(1);
                return value != null ? value : BigDecimal.ZERO;
            }
        } catch (SQLException e) {
            System.err.println("DashBoardDAO.getTodayRevenue error: " + e.getMessage());
            e.printStackTrace();
        }
        return BigDecimal.ZERO;
    }

    public List<DashboardStatusCount> getOrderStatusStats() {
        List<DashboardStatusCount> list = new ArrayList<>();
        String sql = "SELECT status, COUNT(*) AS total FROM Orders GROUP BY status";

        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                String status = rs.getString("status");
                int total = rs.getInt("total");
                list.add(new DashboardStatusCount(status, total));
            }
        } catch (SQLException e) {
            System.err.println("DashBoardDAO.getOrderStatusStats error: " + e.getMessage());
            e.printStackTrace();
        }
        return list;
    }

    public List<DashboardMonthlyRevenue> getMonthlyRevenue() {
        List<DashboardMonthlyRevenue> list = new ArrayList<>();
        
        // Lấy data thật từ database
        String sql = "SELECT MONTH(createdAt) AS month, SUM(totalAmount) AS revenue " +
                "FROM Orders WHERE YEAR(createdAt) = YEAR(GETDATE()) " +
                "GROUP BY MONTH(createdAt) ORDER BY month";

        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            // Tạo map để lưu revenue theo tháng
            java.util.Map<Integer, BigDecimal> monthRevenue = new java.util.HashMap<>();
            
            while (rs.next()) {
                int month = rs.getInt("month");
                BigDecimal revenue = rs.getBigDecimal("revenue");
                if (revenue == null) revenue = BigDecimal.ZERO;
                monthRevenue.put(month, revenue);
            }
            
            // Đảm bảo có đủ 12 tháng, tháng nào không có data thì = 0
            for (int i = 1; i <= 12; i++) {
                BigDecimal revenue = monthRevenue.getOrDefault(i, BigDecimal.ZERO);
                list.add(new DashboardMonthlyRevenue(i, revenue));
            }
            
        } catch (SQLException e) {
            System.err.println("DashBoardDAO.getMonthlyRevenue error: " + e.getMessage());
            e.printStackTrace();
            
            // Nếu có lỗi, vẫn trả về 12 tháng với 0
            for (int i = 1; i <= 12; i++) {
                list.add(new DashboardMonthlyRevenue(i, BigDecimal.ZERO));
            }
        }
        return list;
    }
}


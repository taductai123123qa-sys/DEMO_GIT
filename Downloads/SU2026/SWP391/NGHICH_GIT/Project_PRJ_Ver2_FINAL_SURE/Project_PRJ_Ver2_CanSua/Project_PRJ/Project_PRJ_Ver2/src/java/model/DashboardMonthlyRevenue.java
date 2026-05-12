package model;

import java.math.BigDecimal;

/**
 * Doanh thu theo tháng (dùng cho biểu đồ cột).
 */
public class DashboardMonthlyRevenue {

    private int month;
    private BigDecimal revenue;

    public DashboardMonthlyRevenue(int month, BigDecimal revenue) {
        this.month = month;
        this.revenue = revenue;
    }

    public int getMonth() {
        return month;
    }

    public void setMonth(int month) {
        this.month = month;
    }

    public BigDecimal getRevenue() {
        return revenue;
    }

    public void setRevenue(BigDecimal revenue) {
        this.revenue = revenue;
    }
}


package model;

/**
 * Số đơn hàng theo trạng thái (dùng cho biểu đồ tròn).
 */
public class DashboardStatusCount {

    private String status;
    private int total;

    public DashboardStatusCount(String status, int total) {
        this.status = status;
        this.total = total;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public int getTotal() {
        return total;
    }

    public void setTotal(int total) {
        this.total = total;
    }
}


<%-- 
Trang thống kê admin
--%>

<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Admin Dashboard - TTGShop</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/font-awesome.min.css">
        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
        <style>
            body{font-family:'Montserrat',sans-serif;background:#f5f5f8;}
            .wrapper{max-width:1200px;margin:24px auto;padding:0 16px;}
            .page-header{display:flex;justify-content:space-between;align-items:center;margin-bottom:20px;}
            .page-header h3{margin:0;font-weight:700;}
            .card-metric{background:#fff;border-radius:6px;padding:16px 18px;box-shadow:0 2px 8px rgba(0,0,0,.04);border:1px solid #e5e7eb;}
            .metric-label{font-size:11px;text-transform:uppercase;color:#9ca3af;font-weight:700;letter-spacing:.06em;}
            .metric-value{font-size:20px;font-weight:700;margin-top:4px;}
            .metric-sub{font-size:11px;color:#6b7280;margin-top:3px;}
            .metric-icon{font-size:22px;color:#D10024;}
            .grid-4{display:grid;grid-template-columns:repeat(4,1fr);gap:12px;margin-bottom:20px;}
            .grid-2{display:grid;grid-template-columns:2fr 1.5fr;gap:16px;}
            .card-chart{background:#fff;border-radius:6px;padding:16px 18px;border:1px solid #e5e7eb;box-shadow:0 2px 8px rgba(0,0,0,.04);}
            .card-title{font-size:13px;font-weight:700;margin-bottom:4px;}
            .card-desc{font-size:11px;color:#9ca3af;margin-bottom:10px;}
            .badge-status{display:inline-block;padding:3px 8px;border-radius:999px;font-size:11px;font-weight:600;margin-right:4px;}
            .badge-pending{background:#FEF3C7;color:#B45309;}
            .badge-success{background:#DCFCE7;color:#166534;}
            .badge-cancel{background:#FEE2E2;color:#B91C1C;}
            .table-sm td,.table-sm th{font-size:12px;}
            @media(max-width:900px){
                .grid-4{grid-template-columns:repeat(2,1fr);}
                .grid-2{grid-template-columns:1fr;}
            }
        </style>
    </head>
    <body>
        <div class="wrapper">
            <div class="page-header">
                <div>
                    <h3>Trang thống kê</h3>
                    <small class="text-muted">Tổng quan doanh thu và đơn hàng</small>
                </div>
                <div class="btn-group" role="group" aria-label="Admin navigation">
                    <a href="${pageContext.request.contextPath}/home" class="btn btn-outline-secondary btn-sm">
                        Về trang chủ
                    </a>
                    <a href="${pageContext.request.contextPath}/manageproduct" class="btn btn-outline-secondary btn-sm">
                        Quản lý sản phẩm
                    </a>
                    <a href="${pageContext.request.contextPath}/manageuser" class="btn btn-outline-secondary btn-sm">
                        Quản lý người dùng
                    </a>
                    <a href="${pageContext.request.contextPath}/manageorder" class="btn btn-outline-secondary btn-sm">
                        Quản lý đơn hàng
                    </a>
                </div>
            </div>

            <!-- Metrics -->
            <div class="grid-4">
                <div class="card-metric">
                    <div class="d-flex justify-content-between">
                        <div>
                            <div class="metric-label">Tổng doanh thu</div>
                            <div class="metric-value">
                                <fmt:formatNumber value="${totalRevenue}" type="number" groupingUsed="true"/>đ
                            </div>
                            <div class="metric-sub">Tính theo tất cả đơn hàng</div>
                        </div>
                        <div class="metric-icon">
                            <i class="fa fa-line-chart"></i>
                        </div>
                    </div>
                </div>
                <div class="card-metric">
                    <div class="d-flex justify-content-between">
                        <div>
                            <div class="metric-label">Doanh thu hôm nay</div>
                            <div class="metric-value">
                                <fmt:formatNumber value="${todayRevenue}" type="number" groupingUsed="true"/>đ
                            </div>
                            <div class="metric-sub">Chỉ tính đơn tạo trong ngày</div>
                        </div>
                        <div class="metric-icon">
                            <i class="fa fa-sun-o"></i>
                        </div>
                    </div>
                </div>
                <div class="card-metric">
                    <div class="d-flex justify-content-between">
                        <div>
                            <div class="metric-label">Tổng đơn hàng</div>
                            <div class="metric-value">${totalOrders}</div>
                            <div class="metric-sub">Bao gồm mọi trạng thái</div>
                        </div>
                        <div class="metric-icon">
                            <i class="fa fa-shopping-bag"></i>
                        </div>
                    </div>
                </div>
                <div class="card-metric">
                    <div class="d-flex justify-content-between">
                        <div>
                            <div class="metric-label">Tổng người dùng</div>
                            <div class="metric-value">${totalUsers}</div>
                            <div class="metric-sub">Tài khoản trong hệ thống</div>
                        </div>
                        <div class="metric-icon">
                            <i class="fa fa-users"></i>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Charts and status -->
            <div class="grid-2">
                <div class="card-chart">
                    <div class="card-title">Doanh thu theo tháng</div>
                    <div class="card-desc">Biểu đồ cột doanh thu các tháng trong năm</div>
                    <canvas id="revenueChart" height="140"></canvas>
                </div>
                <div class="card-chart">
                    <div class="card-title">Đơn hàng theo trạng thái</div>
                    <div class="card-desc">Biểu đồ tròn số đơn PENDING / PAID / CANCEL...</div>
                    <canvas id="statusChart" height="140"></canvas>
                    <table class="table table-sm mt-3">
                        <thead>
                            <tr>
                                <th>Trạng thái</th>
                                <th class="text-end">Số đơn</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="s" items="${statusStats}">
                                <tr>
                                    <td>
                                        <c:set var="st" value="${fn:toUpperCase(s.status)}" />
                                        <span class="badge-status
                                              ${st == 'PENDING' ? 'badge-pending' :
                                                (st == 'PAID' || st == 'COMPLETED' ? 'badge-success' : 'badge-cancel')}">
                                            ${s.status}
                                        </span>
                                    </td>
                                    <td class="text-end">${s.total}</td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <script src="${pageContext.request.contextPath}/js/bootstrap.bundle.min.js"></script>
        <script>
            // Dữ liệu doanh thu theo tháng từ JSP
            const monthlyLabels = [
                <c:forEach var="m" items="${monthlyRevenue}" varStatus="st">
                    '${m.month}'<c:if test="${!st.last}">,</c:if>
                </c:forEach>
            ];
            const monthlyData = [
                <c:forEach var="m" items="${monthlyRevenue}" varStatus="st">
                    ${m.revenue}<c:if test="${!st.last}">,</c:if>
                </c:forEach>
            ];

            const statusLabels = [
                <c:forEach var="s" items="${statusStats}" varStatus="st">
                    '${s.status}'<c:if test="${!st.last}">,</c:if>
                </c:forEach>
            ];
            const statusData = [
                <c:forEach var="s" items="${statusStats}" varStatus="st">
                    ${s.total}<c:if test="${!st.last}">,</c:if>
                </c:forEach>
            ];

            // Biểu đồ doanh thu theo tháng (bar đơn giản)
            const revenueCtx = document.getElementById('revenueChart').getContext('2d');
            new Chart(revenueCtx, {
                type: 'bar',
                data: {
                    labels: monthlyLabels,
                    datasets: [{
                        label: 'Doanh thu (VNĐ)',
                        data: monthlyData,
                        backgroundColor: 'rgba(209,0,36,0.7)'
                    }]
                },
                options: {
                    responsive: true,
                    plugins: {
                        legend: { display: false }
                    },
                    scales: {
                        y: {
                            beginAtZero: true
                        }
                    }
                }
            });

            // Biểu đồ trạng thái đơn hàng (doughnut đơn giản)
            const statusCtx = document.getElementById('statusChart').getContext('2d');
            new Chart(statusCtx, {
                type: 'doughnut',
                data: {
                    labels: statusLabels,
                    datasets: [{
                        data: statusData,
                        backgroundColor: [
                            '#F59E0B',
                            '#10B981',
                            '#EF4444',
                            '#3B82F6',
                            '#6B7280'
                        ]
                    }]
                },
                options: {
                    responsive: true,
                    plugins: {
                        legend: { position: 'bottom' }
                    }
                }
            });
        </script>
    </body>
</html>

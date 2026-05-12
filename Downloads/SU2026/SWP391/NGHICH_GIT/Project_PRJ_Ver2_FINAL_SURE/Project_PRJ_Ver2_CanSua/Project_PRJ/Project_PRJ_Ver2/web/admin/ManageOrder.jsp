<%-- 
    Document   : ManageOrder
    Created on : Feb 17, 2026, 9:20:06 PM
    Author     : Lecoo
--%>

<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Quản lý đơn hàng</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/font-awesome.min.css">
        <style>
            body{background:#f5f6fa;font-family:Arial,Helvetica,sans-serif;}
            .wrap{max-width:1200px;margin:26px auto;padding:0 16px;}
            .page-header{display:flex;justify-content:space-between;align-items:center;margin-bottom:14px;gap:10px;flex-wrap:wrap;}
            .page-title{margin:0;font-weight:700;}
            .toolbar{display:flex;gap:8px;flex-wrap:wrap;}
            .card{background:#fff;border:1px solid #e5e7eb;border-radius:8px;box-shadow:0 2px 10px rgba(0,0,0,.04);}
            .card-pad{padding:14px 16px;}
            .badge-status{display:inline-block;padding:4px 10px;border-radius:999px;font-size:11px;font-weight:700;}
            .st-pending{background:#FEF3C7;color:#B45309;}
            .st-paid{background:#DCFCE7;color:#166534;}
            .st-completed{background:#DCFCE7;color:#166534;}
            .st-cancel{background:#FEE2E2;color:#B91C1C;}
            .st-other{background:#E5E7EB;color:#374151;}
            table th,table td{font-size:12px;vertical-align:middle!important;}
            .detail-box{background:#f9fafb;border:1px solid #e5e7eb;border-radius:6px;padding:10px 12px;}
            .paging{display:flex;justify-content:center;gap:6px;margin-top:14px;flex-wrap:wrap;}
            .pg{padding:7px 12px;border:1px solid #e5e7eb;background:#fff;border-radius:6px;font-size:12px;font-weight:700;color:#111827;text-decoration:none;}
            .pg:hover,.pg.active{background:#D10024;color:#fff;border-color:#D10024;}
        </style>
    </head>
    <body>
        <div class="wrap">
            <div class="page-header">
                <div>
                    <h3 class="page-title">Quản lý đơn hàng</h3>
                    <small class="text-muted">Xem / cập nhật trạng thái / export Excel</small>
                </div>
                <div class="toolbar">
                    <a href="${pageContext.request.contextPath}/admindashboard" class="btn btn-outline-secondary btn-sm">
                        &laquo; Dashboard
                    </a>
                    <a class="btn btn-outline-success btn-sm"
                       href="${pageContext.request.contextPath}/manageorder?action=export&status=${curStatus}">
                        <i class="fa fa-file-excel-o"></i> Export Excel
                    </a>
                </div>
            </div>

            <c:if test="${not empty message}">
                <div class="alert alert-success">${message}</div>
            </c:if>
            <c:if test="${not empty error}">
                <div class="alert alert-danger">${error}</div>
            </c:if>

            <div class="card mb-3">
                <div class="card-pad d-flex align-items-center justify-content-between flex-wrap gap-2">
                    <form action="${pageContext.request.contextPath}/manageorder" method="get" class="d-flex align-items-center gap-2 flex-wrap">
                        <label class="fw-bold" style="font-size:12px;">Lọc trạng thái</label>
                        <select name="status" class="form-select form-select-sm" style="width:180px;">
                            <option value="all" ${curStatus == 'all' ? 'selected' : ''}>Tất cả</option>
                            <option value="PENDING" ${curStatus == 'PENDING' ? 'selected' : ''}>PENDING</option>
                            <option value="PAID" ${curStatus == 'PAID' ? 'selected' : ''}>PAID</option>
                            <option value="COMPLETED" ${curStatus == 'COMPLETED' ? 'selected' : ''}>COMPLETED</option>
                            <option value="CANCEL" ${curStatus == 'CANCEL' ? 'selected' : ''}>CANCEL</option>
                        </select>
                        <button class="btn btn-primary btn-sm" type="submit">
                            <i class="fa fa-filter"></i> Áp dụng
                        </button>
                    </form>

                    <div class="text-muted" style="font-size:12px;">
                        Tổng: <b>${totalOrders}</b> đơn
                    </div>
                </div>
            </div>

            <div class="card">
                <div class="table-responsive">
                    <table class="table table-sm table-hover align-middle mb-0">
                        <thead class="table-light">
                            <tr>
                                <th style="width:70px;">#</th>
                                <th style="width:80px;">User</th>
                                <th style="width:150px;">Tổng tiền</th>
                                <th style="width:120px;">Thanh toán</th>
                                <th style="width:120px;">Trạng thái</th>
                                <th style="width:170px;">Ngày tạo</th>
                                <th>Chi tiết</th>
                                <th style="width:240px;">Thao tác</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:choose>
                                <c:when test="${not empty orders}">
                                    <c:forEach var="o" items="${orders}">
                                        <tr>
                                            <td><b>${o.orderId}</b></td>
                                            <td>${o.userId}</td>
                                            <td>
                                                <fmt:formatNumber value="${o.totalAmount}" type="number" groupingUsed="true"/>đ
                                            </td>
                                            <td>${o.paymentMethod}</td>
                                            <td>
                                                <c:set var="st" value="${o.status}" />
                                                <span class="badge-status
                                                      ${st == 'PENDING' ? 'st-pending' :
                                                        (st == 'PAID' ? 'st-paid' :
                                                        (st == 'COMPLETED' ? 'st-completed' :
                                                        (st == 'CANCEL' ? 'st-cancel' : 'st-other')))}">
                                                    ${o.status}
                                                </span>
                                            </td>
                                            <td>
                                                <c:out value="${o.createdAt}" />
                                            </td>
                                            <td style="min-width:260px;">
                                                <div class="detail-box">
                                                    <c:if test="${empty o.details}">
                                                        <span class="text-muted">Không có chi tiết</span>
                                                    </c:if>
                                                    <c:forEach var="d" items="${o.details}">
                                                        <div class="d-flex justify-content-between gap-2">
                                                            <div style="max-width:220px;overflow:hidden;text-overflow:ellipsis;white-space:nowrap;">
                                                                <b>${d.quantity}x</b> ${d.productName}
                                                            </div>
                                                            <div class="text-muted">
                                                                <fmt:formatNumber value="${d.unitPrice}" type="number" groupingUsed="true"/>đ
                                                            </div>
                                                        </div>
                                                    </c:forEach>
                                                </div>
                                            </td>
                                            <td>
                                                <form action="${pageContext.request.contextPath}/manageorder" method="post" class="d-flex gap-2 align-items-center flex-wrap">
                                                    <input type="hidden" name="action" value="updateStatus">
                                                    <input type="hidden" name="orderId" value="${o.orderId}">
                                                    <select name="newStatus" class="form-select form-select-sm" style="width:140px;">
                                                        <option value="PENDING" ${o.status == 'PENDING' ? 'selected' : ''}>PENDING</option>
                                                        <option value="PAID" ${o.status == 'PAID' ? 'selected' : ''}>PAID</option>
                                                        <option value="COMPLETED" ${o.status == 'COMPLETED' ? 'selected' : ''}>COMPLETED</option>
                                                        <option value="CANCEL" ${o.status == 'CANCEL' ? 'selected' : ''}>CANCEL</option>
                                                    </select>
                                                    <button type="submit" class="btn btn-outline-primary btn-sm">
                                                        Cập nhật
                                                    </button>
                                                </form>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <tr>
                                        <td colspan="8" class="text-center text-muted p-4">
                                            Không có đơn hàng nào.
                                        </td>
                                    </tr>
                                </c:otherwise>
                            </c:choose>
                        </tbody>
                    </table>
                </div>
            </div>

            <c:if test="${totalPages > 1}">
                <div class="paging">
                    <c:if test="${currentPage > 1}">
                        <a class="pg" href="${pageContext.request.contextPath}/manageorder?status=${curStatus}&page=${currentPage-1}">
                            <i class="fa fa-chevron-left"></i>
                        </a>
                    </c:if>
                    <c:forEach begin="1" end="${totalPages}" var="i">
                        <a class="pg ${i == currentPage ? 'active' : ''}"
                           href="${pageContext.request.contextPath}/manageorder?status=${curStatus}&page=${i}">
                            ${i}
                        </a>
                    </c:forEach>
                    <c:if test="${currentPage < totalPages}">
                        <a class="pg" href="${pageContext.request.contextPath}/manageorder?status=${curStatus}&page=${currentPage+1}">
                            <i class="fa fa-chevron-right"></i>
                        </a>
                    </c:if>
                </div>
            </c:if>
        </div>

        <script src="${pageContext.request.contextPath}/js/bootstrap.bundle.min.js"></script>
    </body>
</html>

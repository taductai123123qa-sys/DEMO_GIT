<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Đơn hàng của tôi - TechNova</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css"/>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/font-awesome.min.css"/>
        <style>
            body {
                font-family: 'Inter', 'Segoe UI', sans-serif;
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                min-height: 100vh;
                padding: 20px 0;
            }
            
            .main-container {
                max-width: 1200px;
                margin: 0 auto;
                padding: 0 20px;
            }
            
            .page-header {
                background: rgba(255, 255, 255, 0.95);
                backdrop-filter: blur(10px);
                border-radius: 16px;
                padding: 24px 32px;
                margin-bottom: 24px;
                box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
                border: 1px solid rgba(255, 255, 255, 0.2);
                text-align: center;
            }
            
            .page-header h3 {
                margin: 0;
                font-weight: 700;
                font-size: 28px;
                background: linear-gradient(135deg, #667eea, #764ba2);
                -webkit-background-clip: text;
                -webkit-text-fill-color: transparent;
                background-clip: text;
            }
            
            .empty-state {
                background: rgba(255, 255, 255, 0.95);
                backdrop-filter: blur(10px);
                border-radius: 16px;
                padding: 60px 40px;
                text-align: center;
                box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
                border: 1px solid rgba(255, 255, 255, 0.2);
            }
            
            .empty-state i {
                font-size: 64px;
                color: #667eea;
                margin-bottom: 20px;
                opacity: 0.7;
            }
            
            .empty-state p {
                font-size: 18px;
                color: #6b7280;
                margin: 0;
            }
            
            .accordion {
                border-radius: 16px;
                overflow: hidden;
                box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
            }
            
            .accordion-item {
                background: rgba(255, 255, 255, 0.95);
                backdrop-filter: blur(10px);
                border: 1px solid rgba(255, 255, 255, 0.2);
                margin-bottom: 16px;
                border-radius: 16px;
                overflow: hidden;
                transition: all 0.3s ease;
            }
            
            .accordion-item:hover {
                transform: translateY(-2px);
                box-shadow: 0 12px 40px rgba(0, 0, 0, 0.15);
            }
            
            .accordion-header {
                margin: 0;
                background: linear-gradient(135deg, #f8fafc 0%, #f1f5f9 100%);
                border: none;
            }
            
            .accordion-button {
                width: 100%;
                padding: 20px 24px;
                text-align: left;
                font-size: 16px;
                font-weight: 600;
                color: #1f2937;
                background: transparent;
                border: none;
                display: flex;
                justify-content: space-between;
                align-items: center;
                transition: all 0.3s ease;
                position: relative;
            }
            
            .accordion-button:hover {
                background: linear-gradient(135deg, #f1f5f9 0%, #e5e7eb 100%);
                color: #667eea;
            }
            
            .accordion-button::after {
                content: '\f107';
                font-family: 'Font Awesome 6 Free';
                font-weight: 900;
                transition: transform 0.3s ease;
                color: #667eea;
            }
            
            .accordion-button:not(.collapsed)::after {
                transform: rotate(180deg);
            }
            
            .order-id {
                background: linear-gradient(135deg, #667eea, #764ba2);
                -webkit-background-clip: text;
                -webkit-text-fill-color: transparent;
                background-clip: text;
                font-weight: 700;
            }
            
            .order-amount {
                color: #059669;
                font-weight: 700;
                font-size: 18px;
            }
            
            .order-status {
                padding: 6px 12px;
                border-radius: 20px;
                font-size: 12px;
                font-weight: 600;
                text-transform: uppercase;
                letter-spacing: 0.5px;
            }
            
            .status-completed {
                background: linear-gradient(135deg, #dcfce7, #bbf7d0);
                color: #166534;
            }
            
            .status-pending {
                background: linear-gradient(135deg, #fef3c7, #fde68a);
                color: #92400e;
            }
            
            .status-cancel {
                background: linear-gradient(135deg, #fee2e2, #fecaca);
                color: #991b1b;
            }
            
            .accordion-collapse {
                border: none;
            }
            
            .accordion-body {
                padding: 24px;
                background: rgba(255, 255, 255, 0.8);
            }
            
            .order-info {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
                gap: 16px;
                margin-bottom: 20px;
                padding: 16px;
                background: linear-gradient(135deg, #f8fafc 0%, #f1f5f9 100%);
                border-radius: 12px;
                border: 1px solid #e5e7eb;
            }
            
            .info-item {
                display: flex;
                flex-direction: column;
            }
            
            .info-label {
                font-size: 12px;
                color: #6b7280;
                text-transform: uppercase;
                letter-spacing: 0.5px;
                font-weight: 600;
                margin-bottom: 4px;
            }
            
            .info-value {
                font-size: 16px;
                color: #1f2937;
                font-weight: 600;
            }
            
            .table-container {
                background: white;
                border-radius: 12px;
                overflow: hidden;
                box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
            }
            
            .table {
                margin: 0;
                font-size: 14px;
            }
            
            .table th {
                background: linear-gradient(135deg, #667eea, #764ba2);
                color: white;
                font-weight: 600;
                text-transform: uppercase;
                letter-spacing: 0.5px;
                font-size: 12px;
                padding: 16px 12px;
                border: none;
            }
            
            .table td {
                padding: 12px;
                vertical-align: middle;
                border-bottom: 1px solid #f1f5f9;
            }
            
            .table tbody tr:hover {
                background: #f8fafc;
            }
            
            .product-id {
                font-weight: 600;
                color: #667eea;
            }
            
            .quantity {
                font-weight: 700;
                color: #059669;
            }
            
            .unit-price {
                font-weight: 600;
                color: #dc2626;
            }
            
            @keyframes slideIn {
                from {
                    opacity: 0;
                    transform: translateY(20px);
                }
                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }
            
            .accordion-item {
                animation: slideIn 0.5s ease-out;
            }
            
            .accordion-item:nth-child(1) { animation-delay: 0.1s; }
            .accordion-item:nth-child(2) { animation-delay: 0.2s; }
            .accordion-item:nth-child(3) { animation-delay: 0.3s; }
            .accordion-item:nth-child(4) { animation-delay: 0.4s; }
            .accordion-item:nth-child(5) { animation-delay: 0.5s; }
            
            @media (max-width: 768px) {
                .main-container {
                    padding: 0 12px;
                }
                
                .page-header {
                    padding: 20px;
                }
                
                .page-header h3 {
                    font-size: 24px;
                }
                
                .accordion-button {
                    padding: 16px 20px;
                    font-size: 14px;
                }
                
                .order-info {
                    grid-template-columns: 1fr;
                    gap: 12px;
                }
                
                .table {
                    font-size: 12px;
                }
                
                .table th,
                .table td {
                    padding: 8px;
                }
            }
        </style>
    </head>
    <body>
        <div class="main-container">
            <div class="page-header">
                <h3>Đơn hàng của tôi</h3>
            </div>
            
            <c:choose>
                <c:when test="${empty orders}">
                    <div class="empty-state">
                        <i class="fa fa-shopping-cart"></i>
                        <p>Bạn chưa có đơn hàng nào.</p>
                        <p style="font-size: 14px; color: #9ca3af; margin-top: 8px;">
                            Hãy mua sắm ngay để trải nghiệm dịch vụ của chúng tôi!
                        </p>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="accordion" id="orderAccordion">
                        <c:forEach var="o" items="${orders}" varStatus="st">
                            <div class="accordion-item">
                                <h2 class="accordion-header" id="heading${st.index}">
                                    <button class="accordion-button collapsed" type="button"
                                            data-bs-toggle="collapse"
                                            data-bs-target="#collapse${st.index}">
                                        <div>
                                            <span>Đơn #<span class="order-id">${o.orderId}</span></span>
                                            <span class="order-amount">
                                                <fmt:formatNumber value="${o.totalAmount}" type="currency" currencySymbol="₫" groupingUsed="true"/>
                                            </span>
                                            <span class="order-status ${o.status == 'COMPLETED' ? 'status-completed' : (o.status == 'PENDING' ? 'status-pending' : 'status-cancel')}">
                                                ${o.status}
                                            </span>
                                            <a href="order-detail?id=${o.orderId}" 
                                               class="btn btn-sm btn-primary ms-3" 
                                               style="background: linear-gradient(135deg, #667eea, #764ba2); border: none; border-radius: 8px; padding: 6px 12px; font-size: 12px; text-decoration: none; color: white; transition: all 0.3s ease;"
                                               onmouseover="this.style.transform='translateY(-2px)'; this.style.boxShadow='0 4px 20px rgba(102, 126, 234, 0.3)'"
                                               onmouseout="this.style.transform='translateY(0)'; this.style.boxShadow='none'">
                                                <i class="fa fa-eye"></i> Chi tiết
                                            </a>
                                        </div>
                                        <i class="fa fa-chevron-down"></i>
                                    </button>
                                </h2>
                                <div id="collapse${st.index}" class="accordion-collapse collapse"
                                     data-bs-parent="#orderAccordion">
                                    <div class="accordion-body">
                                        <div class="order-info">
                                            <div class="info-item">
                                                <span class="info-label">Mã đơn hàng</span>
                                                <span class="info-value">#${o.orderId}</span>
                                            </div>
                                            <div class="info-item">
                                                <span class="info-label">Ngày tạo</span>
                                                <span class="info-value">
                                                    <fmt:formatDate value="${o.createdAt}" pattern="dd/MM/yyyy HH:mm"/>
                                                </span>
                                            </div>
                                            <div class="info-item">
                                                <span class="info-label">Tổng tiền</span>
                                                <span class="info-value">
                                                    <fmt:formatNumber value="${o.totalAmount}" type="currency" currencySymbol="₫" groupingUsed="true"/>
                                                </span>
                                            </div>
                                            <div class="info-item">
                                                <span class="info-label">Trạng thái</span>
                                                <span class="info-value">
                                                    <span class="order-status ${o.status == 'COMPLETED' ? 'status-completed' : (o.status == 'PENDING' ? 'status-pending' : 'status-cancel')}">
                                                        ${o.status}
                                                    </span>
                                                </span>
                                            </div>
                                        </div>
                                        
                                        <div class="table-container">
                                            <h5 style="margin: 0 0 16px 0; color: #1f2937; font-weight: 600;">Chi tiết đơn hàng</h5>
                                            <table class="table table-sm">
                                                <thead>
                                                    <tr>
                                                        <th>Mã sản phẩm</th>
                                                        <th>Số lượng</th>
                                                        <th>Đơn giá</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <c:forEach var="d" items="${o.details}">
                                                        <tr>
                                                            <td class="product-id">${d.productId}</td>
                                                            <td class="quantity">${d.quantity}</td>
                                                            <td class="unit-price">
                                                                <fmt:formatNumber value="${d.unitPrice}" type="currency" currencySymbol="₫" groupingUsed="true"/>
                                                            </td>
                                                        </tr>
                                                    </c:forEach>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
        
        <!-- Back to Home Button -->
        <div style="text-align: center; margin-top: 32px; padding: 20px;">
            <a href="home" 
               style="display: inline-flex; align-items: center; gap: 8px; padding: 12px 24px; background: linear-gradient(135deg, #667eea, #764ba2); color: white; text-decoration: none; border-radius: 8px; font-weight: 600; transition: all 0.3s ease;"
               onmouseover="this.style.transform='translateY(-2px)'; this.style.boxShadow='0 4px 20px rgba(102, 126, 234, 0.3)'"
               onmouseout="this.style.transform='translateY(0)'; this.style.boxShadow='none'">
                <i class="fa fa-home"></i>
                Về trang chủ
            </a>
        </div>
        
        <script src="${pageContext.request.contextPath}/js/bootstrap.bundle.min.js"></script>
    </body>
</html>


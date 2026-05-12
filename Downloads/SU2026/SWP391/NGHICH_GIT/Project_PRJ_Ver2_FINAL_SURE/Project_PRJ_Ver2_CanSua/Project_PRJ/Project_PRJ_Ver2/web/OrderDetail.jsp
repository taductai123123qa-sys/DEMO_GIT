<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Chi tiết đơn hàng #${order.orderId} - TechNova</title>
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
            }
            
            .page-header h2 {
                margin: 0;
                font-weight: 700;
                font-size: 28px;
                background: linear-gradient(135deg, #667eea, #764ba2);
                -webkit-background-clip: text;
                -webkit-text-fill-color: transparent;
                background-clip: text;
            }
            
            .breadcrumb {
                background: rgba(255, 255, 255, 0.9);
                backdrop-filter: blur(10px);
                border-radius: 12px;
                padding: 12px 20px;
                margin-bottom: 24px;
                display: flex;
                align-items: center;
                gap: 8px;
            }
            
            .breadcrumb a {
                color: #667eea;
                text-decoration: none;
                font-weight: 500;
                transition: color 0.3s ease;
            }
            
            .breadcrumb a:hover {
                color: #764ba2;
            }
            
            .breadcrumb .separator {
                color: #6b7280;
            }
            
            .order-card {
                background: rgba(255, 255, 255, 0.95);
                backdrop-filter: blur(10px);
                border-radius: 16px;
                padding: 32px;
                box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
                border: 1px solid rgba(255, 255, 255, 0.2);
                margin-bottom: 24px;
            }
            
            .order-info-grid {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
                gap: 24px;
                margin-bottom: 32px;
            }
            
            .info-card {
                background: linear-gradient(135deg, #f8fafc 0%, #f1f5f9 100%);
                border-radius: 12px;
                padding: 20px;
                border: 1px solid #e5e7eb;
            }
            
            .info-label {
                font-size: 12px;
                color: #6b7280;
                text-transform: uppercase;
                letter-spacing: 0.5px;
                font-weight: 600;
                margin-bottom: 8px;
                display: flex;
                align-items: center;
                gap: 8px;
            }
            
            .info-label i {
                color: #667eea;
                font-size: 16px;
            }
            
            .info-value {
                font-size: 18px;
                color: #1f2937;
                font-weight: 700;
            }
            
            .order-amount {
                color: #059669;
                font-size: 24px;
            }
            
            .order-status {
                padding: 8px 16px;
                border-radius: 20px;
                font-size: 14px;
                font-weight: 600;
                text-transform: uppercase;
                letter-spacing: 0.5px;
                display: inline-flex;
                align-items: center;
                gap: 8px;
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
            
            .status-icon {
                font-size: 12px;
            }
            
            .products-section {
                background: rgba(255, 255, 255, 0.95);
                backdrop-filter: blur(10px);
                border-radius: 16px;
                padding: 32px;
                box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
                border: 1px solid rgba(255, 255, 255, 0.2);
            }
            
            .section-title {
                font-size: 20px;
                font-weight: 700;
                color: #1f2937;
                margin-bottom: 24px;
                display: flex;
                align-items: center;
                gap: 12px;
            }
            
            .section-title i {
                color: #667eea;
            }
            
            .products-grid {
                display: grid;
                grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
                gap: 20px;
            }
            
            .product-card {
                background: white;
                border-radius: 12px;
                overflow: hidden;
                box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
                transition: all 0.3s ease;
                border: 1px solid #e5e7eb;
            }
            
            .product-card:hover {
                transform: translateY(-4px);
                box-shadow: 0 8px 30px rgba(0, 0, 0, 0.15);
            }
            
            .product-image {
                width: 100%;
                height: 200px;
                object-fit: cover;
                background: linear-gradient(135deg, #f3f4f6, #e5e7eb);
                display: flex;
                align-items: center;
                justify-content: center;
                color: #9ca3af;
                font-size: 14px;
            }
            
            .product-image i {
                font-size: 48px;
                opacity: 0.5;
            }
            
            .product-info {
                padding: 20px;
            }
            
            .product-name {
                font-size: 16px;
                font-weight: 600;
                color: #1f2937;
                margin-bottom: 8px;
                line-height: 1.4;
            }
            
            .product-details {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 12px;
                gap: 16px;
            }
            
            .product-quantity {
                display: flex;
                align-items: center;
                gap: 8px;
                font-size: 14px;
                color: #6b7280;
            }
            
            .quantity-value {
                font-weight: 700;
                font-size: 18px;
                color: #059669;
            }
            
            .product-price {
                text-align: right;
            }
            
            .price-label {
                font-size: 12px;
                color: #6b7280;
                text-transform: uppercase;
                letter-spacing: 0.5px;
                font-weight: 600;
                margin-bottom: 4px;
            }
            
            .price-value {
                font-size: 20px;
                font-weight: 700;
                color: #dc2626;
            }
            
            .total-section {
                background: linear-gradient(135deg, #667eea, #764ba2);
                color: white;
                border-radius: 12px;
                padding: 24px 32px;
                margin-top: 32px;
                display: flex;
                justify-content: space-between;
                align-items: center;
                box-shadow: 0 8px 32px rgba(102, 126, 234, 0.3);
            }
            
            .total-label {
                font-size: 16px;
                font-weight: 600;
            }
            
            .total-amount {
                font-size: 28px;
                font-weight: 800;
            }
            
            .back-button {
                background: linear-gradient(135deg, #f8fafc, #f1f5f9);
                color: #667eea;
                border: 2px solid #667eea;
                border-radius: 12px;
                padding: 12px 24px;
                font-size: 16px;
                font-weight: 600;
                text-decoration: none;
                display: inline-flex;
                align-items: center;
                gap: 8px;
                transition: all 0.3s ease;
            }
            
            .back-button:hover {
                background: linear-gradient(135deg, #667eea, #764ba2);
                color: white;
                transform: translateY(-2px);
                box-shadow: 0 4px 20px rgba(102, 126, 234, 0.3);
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
            
            .order-card,
            .products-section {
                animation: slideIn 0.6s ease-out;
            }
            
            .products-section {
                animation-delay: 0.2s;
            }
            
            @media (max-width: 768px) {
                .main-container {
                    padding: 0 12px;
                }
                
                .page-header {
                    padding: 20px;
                }
                
                .page-header h2 {
                    font-size: 24px;
                }
                
                .order-info-grid {
                    grid-template-columns: 1fr;
                    gap: 16px;
                }
                
                .products-grid {
                    grid-template-columns: 1fr;
                    gap: 16px;
                }
                
                .product-card {
                    margin-bottom: 16px;
                }
                
                .total-section {
                    flex-direction: column;
                    gap: 16px;
                    text-align: center;
                }
            }
        </style>
    </head>
    <body>
        <div class="main-container">
            <!-- Header -->
            <div class="page-header">
                <h2>Đơn hàng #${order.orderId}</h2>
            </div>
            
            <!-- Breadcrumb -->
            <div class="breadcrumb">
                <a href="orderhistory">
                    <i class="fa fa-arrow-left"></i>
                    Quay lại lịch sử đơn hàng
                </a>
                <span class="separator">/</span>
                <span>Chi tiết đơn hàng</span>
            </div>
            
            <!-- Order Information -->
            <div class="order-card">
                <div class="order-info-grid">
                    <div class="info-card">
                        <div class="info-label">
                            <i class="fa fa-hashtag"></i>
                            Mã đơn hàng
                        </div>
                        <div class="info-value">#${order.orderId}</div>
                    </div>
                    
                    <div class="info-card">
                        <div class="info-label">
                            <i class="fa fa-calendar"></i>
                            Ngày tạo
                        </div>
                        <div class="info-value">
                            <fmt:formatDate value="${order.createdAt}" pattern="dd/MM/yyyy HH:mm"/>
                        </div>
                    </div>
                    
                    <div class="info-card">
                        <div class="info-label">
                            <i class="fa fa-credit-card"></i>
                            Phương thức thanh toán
                        </div>
                        <div class="info-value">${order.paymentMethod}</div>
                    </div>
                    
                    <div class="info-card">
                        <div class="info-label">
                            <i class="fa fa-info-circle"></i>
                            Trạng thái
                        </div>
                        <div class="info-value">
                            <span class="order-status ${order.status == 'COMPLETED' ? 'status-completed' : (order.status == 'PENDING' ? 'status-pending' : 'status-cancel')}">
                                <i class="fa ${order.status == 'COMPLETED' ? 'fa-check-circle' : (order.status == 'PENDING' ? 'fa-clock' : 'fa-times-circle')} status-icon"></i>
                                ${order.status}
                            </span>
                        </div>
                    </div>
                </div>
                
                <div style="text-align: center; margin-top: 24px;">
                    <div class="info-label" style="justify-content: center;">
                        <i class="fa fa-money"></i>
                        Tổng tiền
                    </div>
                    <div class="info-value order-amount">
                        <fmt:formatNumber value="${order.totalAmount}" type="currency" currencySymbol="₫" groupingUsed="true"/>
                    </div>
                </div>
            </div>
            
            <!-- Products Section -->
            <div class="products-section">
                <div class="section-title">
                    <i class="fa fa-shopping-bag"></i>
                    Sản phẩm trong đơn hàng
                </div>
                
                <div class="products-grid">
                    <c:forEach var="detail" items="${order.details}">
                        <div class="product-card">
                            <div class="product-image">
                                <c:choose>
                                    <c:when test="${not empty detail.product.images}">
                                        <img src="${pageContext.request.contextPath}/${detail.product.images}" 
                                             alt="${detail.product.name}" 
                                             style="width: 100%; height: 100%; object-fit: cover;">
                                    </c:when>
                                    <c:otherwise>
                                        <i class="fa fa-image"></i>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                            
                            <div class="product-info">
                                <div class="product-name">${detail.product.name}</div>
                                
                                <div class="product-details">
                                    <div class="product-quantity">
                                        <span>Số lượng:</span>
                                        <span class="quantity-value">${detail.quantity}</span>
                                    </div>
                                    
                                    <div class="product-price">
                                        <div class="price-label">Đơn giá</div>
                                        <div class="price-value">
                                            <fmt:formatNumber value="${detail.unitPrice}" type="currency" currencySymbol="₫" groupingUsed="true"/>
                                        </div>
                                    </div>
                                </div>
                                
                                <div class="product-details">
                                    <div class="product-quantity">
                                        <span>Thành tiền:</span>
                                        <span class="quantity-value">
                                            <fmt:formatNumber value="${detail.unitPrice * detail.quantity}" type="currency" currencySymbol="₫" groupingUsed="true"/>
                                        </span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
                
                <!-- Total Section -->
                <div class="total-section">
                    <div class="total-label">Tổng cộng (${fn:length(order.details)} sản phẩm)</div>
                    <div class="total-amount">
                        <fmt:formatNumber value="${order.totalAmount}" type="currency" currencySymbol="₫" groupingUsed="true"/>
                    </div>
                </div>
            </div>
            
            <!-- Navigation Buttons -->
            <div style="text-align: center; margin-top: 32px; display: flex; gap: 16px; justify-content: center;">
                <a href="orderhistory" class="back-button">
                    <i class="fa fa-arrow-left"></i>
                    Quay lại lịch sử đơn hàng
                </a>
                
                <a href="home" class="back-button" 
                   style="background: linear-gradient(135deg, #059669, #047857);">
                    <i class="fa fa-home"></i>
                    Về trang chủ
                </a>
            </div>
        </div>
        
        <script src="${pageContext.request.contextPath}/js/bootstrap.bundle.min.js"></script>
    </body>
</html>

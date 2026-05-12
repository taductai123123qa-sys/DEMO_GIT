<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Thông Tin Tài Khoản - TechNova</title>
    
    <!-- CSS -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.5.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    
    <style>
        .profile-header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 40px 0;
            margin-bottom: 30px;
        }
        
        .profile-avatar {
            width: 120px;
            height: 120px;
            background: white;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 48px;
            color: #667eea;
            margin: 0 auto 20px;
            font-weight: bold;
        }
        
        .profile-info {
            text-align: center;
        }
        
        .profile-info h2 {
            margin: 0 0 10px 0;
            font-size: 28px;
        }
        
        .profile-info p {
            margin: 5px 0;
            opacity: 0.9;
        }
        
        .profile-card {
            background: white;
            border-radius: 10px;
            padding: 30px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
            margin-bottom: 20px;
        }
        
        .profile-card h3 {
            color: #333;
            margin-bottom: 20px;
            padding-bottom: 10px;
            border-bottom: 2px solid #667eea;
        }
        
        .info-row {
            display: flex;
            justify-content: space-between;
            padding: 12px 0;
            border-bottom: 1px solid #eee;
        }
        
        .info-row:last-child {
            border-bottom: none;
        }
        
        .info-label {
            font-weight: 600;
            color: #666;
        }
        
        .info-value {
            color: #333;
        }
        
        .btn-change-password {
            background: #667eea;
            color: white;
            border: none;
            padding: 12px 30px;
            border-radius: 25px;
            text-decoration: none;
            display: inline-block;
            margin-top: 20px;
            transition: all 0.3s;
        }
        
        .btn-change-password:hover {
            background: #5a6fd8;
            transform: translateY(-2px);
        }
        
        .role-badge {
            background: #28a745;
            color: white;
            padding: 4px 12px;
            border-radius: 15px;
            font-size: 12px;
            font-weight: 600;
        }
        
        .status-badge {
            background: #17a2b8;
            color: white;
            padding: 4px 12px;
            border-radius: 15px;
            font-size: 12px;
            font-weight: 600;
        }
    </style>
</head>
<body>
    
    <!-- Header -->
    <header>
        <!-- TOP HEADER -->
        <div id="top-header">
            <div class="container">
                <ul class="header-links pull-left">
                    <li><a href="#">FAQs</a></li>
                    <li><a href="#">Help</a></li>
                    <li><a href="#">Support</a></li>
                </ul>
                <ul class="header-links pull-right">
                    <li><a href="tel:0986568721"><i class="fa fa-phone"></i>0986.568.721</a></li>
                    <li><a href="mailto:info@electro.com"><i class="fa fa-envelope-o"></i>info@electro.com</a></li>
                    <li><a href="#"><i class="fa fa-map-marker"></i>Hà Nội, Việt Nam</a></li>
                    <div class="ml-auto">
                        <c:choose>
                            <c:when test="${not empty sessionScope.username}">
                                <c:if test="${sessionScope.role == 'ADMIN'}">
                                    <a href="admindashboard"><i class="fa fa-cog"></i> Admin</a>
                                </c:if>
                                <a href="${pageContext.request.contextPath}/profile"><i class="fa fa-user-o"></i> Xin chào, ${sessionScope.username}</a>
                                <a href="logout"><i class="fa fa-sign-out"></i> Đăng xuất</a>
                            </c:when>
                            <c:otherwise>
                                <a href="${pageContext.request.contextPath}/login"><i class="fa fa-sign-in"></i> Đăng nhập</a>
                                <a href="${pageContext.request.contextPath}/register"><i class="fa fa-user-plus"></i> Đăng ký</a>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </ul>
            </div>
        </div>
        
        <!-- /TOP HEADER -->
        
        <!-- MAIN HEADER -->
        <div id="header">
            <div class="container">
                <div class="row">
                    <div class="col-md-3">
                        <div class="header-logo">
                            <a class="logo" href="${pageContext.request.contextPath}/home" style="font-size: 24px; font-weight: bold; color: #667eea; text-decoration: none;">
                                TECHNOVA
                            </a>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="header-search">
                            <form>
                                <input class="input" placeholder="Tìm kiếm sản phẩm...">
                                <button class="search-btn">Tìm kiếm</button>
                            </form>
                        </div>
                    </div>
                    <div class="col-md-3 clearfix">
                        <div class="header-ctn">
                            <div>
                                <a href="#"><i class="fa fa-heart-o"></i></a>
                            </div>
                            <div>
                                <a href="${pageContext.request.contextPath}/cart"><i class="fa fa-shopping-cart"></i></a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- /MAIN HEADER -->
    </header>
    
    <!-- Profile Header -->
    <div class="profile-header">
        <div class="container">
            <div class="profile-avatar">
                ${user.fullName != null ? user.fullName.substring(0,1).toUpperCase() : user.username.substring(0,1).toUpperCase()}
            </div>
            <div class="profile-info">
                <h2>${user.fullName != null ? user.fullName : user.username}</h2>
                <p>@${user.username}</p>
                <p>${user.email}</p>
                <span class="role-badge">${user.role}</span>
                <span class="status-badge">${user.status != null ? user.status : 'ACTIVE'}</span>
            </div>
        </div>
    </div>
    
    <!-- Profile Content -->
    <div class="container">
        <div class="row">
            <div class="col-md-8 mx-auto">
                
                <!-- Thông tin cá nhân -->
                <div class="profile-card">
                    <h3>📋 Thông Tin Cá Nhân</h3>
                    <div class="info-row">
                        <span class="info-label">ID:</span>
                        <span class="info-value">#${user.userId}</span>
                    </div>
                    <div class="info-row">
                        <span class="info-label">Họ và tên:</span>
                        <span class="info-value">${user.fullName != null ? user.fullName : 'Chưa cập nhật'}</span>
                    </div>
                    <div class="info-row">
                        <span class="info-label">Tên đăng nhập:</span>
                        <span class="info-value">@${user.username}</span>
                    </div>
                    <div class="info-row">
                        <span class="info-label">Email:</span>
                        <span class="info-value">${user.email}</span>
                    </div>
                    <div class="info-row">
                        <span class="info-label">Vai trò:</span>
                        <span class="info-value">
                            <span class="role-badge">${user.role}</span>
                        </span>
                    </div>
                    <div class="info-row">
                        <span class="info-label">Trạng thái:</span>
                        <span class="info-value">
                            <span class="status-badge">${user.status != null ? user.status : 'ACTIVE'}</span>
                        </span>
                    </div>
                </div>
                
                <!-- Bảo mật -->
                <div class="profile-card">
                    <h3>🔒 Bảo Mật</h3>
                    <p style="color: #666; margin-bottom: 20px;">
                        Quản lý mật khẩu và cài đặt bảo mật tài khoản của bạn.
                    </p>
                    <a href="${pageContext.request.contextPath}/change-password" class="btn-change-password">
                        🔑 Đổi Mật Khẩu
                    </a>
                </div>
                
                <!-- Quay lại -->
                <div style="text-align: center; margin-top: 30px;">
                    <a href="${pageContext.request.contextPath}/home" style="color: #667eea; text-decoration: none;">
                        ← Quay lại trang chủ
                    </a>
                </div>
                
            </div>
        </div>
    </div>
    
    <!-- Footer -->
    <footer id="footer" class="section pb-45">
        <div class="container">
            <div class="row">
                <div class="col-md-3 col-sm-6">
                    <div class="footer">
                        <div class="footer-logo">
                            <a class="logo" href="${pageContext.request.contextPath}/home" style="font-size: 20px; font-weight: bold; color: white; text-decoration: none;">
                                TECHNOVA
                            </a>
                        </div>
                        <p>TechNova - Nền tảng thương mại điện tử hàng đầu</p>
                        <ul class="footer-social">
                            <li><a href="#"><i class="fa fa-facebook"></i></a></li>
                            <li><a href="#"><i class="fa fa-twitter"></i></a></li>
                            <li><a href="#"><i class="fa fa-instagram"></i></a></li>
                        </ul>
                    </div>
                </div>
                <div class="col-md-3 col-sm-6">
                    <div class="footer">
                        <h3 class="footer-title">Về Chúng Tôi</h3>
                        <ul class="footer-links">
                            <li><a href="#">Giới Thiệu</a></li>
                            <li><a href="#">Điều Khoản</a></li>
                            <li><a href="#">Chính Sách Bảo Mật</a></li>
                        </ul>
                    </div>
                </div>
                <div class="col-md-3 col-sm-6">
                    <div class="footer">
                        <h3 class="footer-title">Dịch Vụ Khách Hàng</h3>
                        <ul class="footer-links">
                            <li><a href="#">Liên Hệ</a></li>
                            <li><a href="#">Theo Dõi Đơn Hàng</a></li>
                            <li><a href="#">Trả Hàng & Hoàn Tiền</a></li>
                        </ul>
                    </div>
                </div>
                <div class="col-md-3 col-sm-6">
                    <div class="footer">
                        <h3 class="footer-title">Tài Khoản</h3>
                        <ul class="footer-links">
                            <li><a href="${pageContext.request.contextPath}/profile">Tài Khoản Của Tôi</a></li>
                            <li><a href="${pageContext.request.contextPath}/login">Đăng Nhập</a></li>
                            <li><a href="${pageContext.request.contextPath}/register">Đăng Ký</a></li>
                        </ul>
                    </div>
                </div>
            </div>
            <div id="copyright">
                <div class="container">
                    <div class="row">
                        <div class="col-md-12">
                            <p class="text-center">© 2024 TechNova. All Rights Reserved.</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </footer>
    
    <!-- JavaScript -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/main.js"></script>
    
</body>
</html>

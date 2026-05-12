<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Đổi Mật Khẩu - TechNova</title>
    
    <!-- CSS -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.5.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    
    <style>
        .change-password-header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 40px 0;
            margin-bottom: 30px;
        }
        
        .password-form {
            background: white;
            border-radius: 10px;
            padding: 40px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
            max-width: 500px;
            margin: 0 auto;
        }
        
        .form-group {
            margin-bottom: 25px;
        }
        
        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: 600;
            color: #333;
        }
        
        .form-group input {
            width: 100%;
            padding: 12px 15px;
            border: 2px solid #e1e5e9;
            border-radius: 8px;
            font-size: 16px;
            transition: border-color 0.3s;
        }
        
        .form-group input:focus {
            outline: none;
            border-color: #667eea;
        }
        
        .btn-submit {
            background: #667eea;
            color: white;
            border: none;
            padding: 15px 30px;
            border-radius: 8px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            width: 100%;
            transition: all 0.3s;
        }
        
        .btn-submit:hover {
            background: #5a6fd8;
            transform: translateY(-2px);
        }
        
        .alert {
            padding: 15px;
            border-radius: 8px;
            margin-bottom: 20px;
        }
        
        .alert-success {
            background: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }
        
        .alert-danger {
            background: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }
        
        .password-strength {
            margin-top: 10px;
            font-size: 14px;
        }
        
        .strength-weak { color: #dc3545; }
        .strength-medium { color: #ffc107; }
        .strength-strong { color: #28a745; }
        
        .back-link {
            text-align: center;
            margin-top: 30px;
        }
        
        .back-link a {
            color: #667eea;
            text-decoration: none;
            font-weight: 600;
        }
        
        .back-link a:hover {
            text-decoration: underline;
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
    
    <!-- Change Password Header -->
    <div class="change-password-header">
        <div class="container text-center">
            <h1>🔒 Đổi Mật Khẩu</h1>
            <p>Cập nhật mật khẩu để bảo vệ tài khoản của bạn</p>
        </div>
    </div>
    
    <!-- Change Password Form -->
    <div class="container">
        <div class="password-form">
            
            <!-- Messages -->
            <c:if test="${not empty sessionScope.successMessage}">
                <div class="alert alert-success">
                    ${sessionScope.successMessage}
                </div>
                <c:remove var="successMessage" scope="session"/>
            </c:if>
            
            <c:if test="${not empty sessionScope.errorMessage}">
                <div class="alert alert-danger">
                    ${sessionScope.errorMessage}
                </div>
                <c:remove var="errorMessage" scope="session"/>
            </c:if>
            
            <form action="${pageContext.request.contextPath}/change-password" method="post">
                
                <div class="form-group">
                    <label for="currentPassword">🔑 Mật khẩu hiện tại:</label>
                    <input type="password" id="currentPassword" name="currentPassword" required>
                </div>
                
                <div class="form-group">
                    <label for="newPassword">🔐 Mật khẩu mới:</label>
                    <input type="password" id="newPassword" name="newPassword" required 
                           minlength="6" onkeyup="checkPasswordStrength()">
                    <div id="passwordStrength" class="password-strength"></div>
                </div>
                
                <div class="form-group">
                    <label for="confirmPassword">✅ Xác nhận mật khẩu mới:</label>
                    <input type="password" id="confirmPassword" name="confirmPassword" required>
                </div>
                
                <button type="submit" class="btn-submit">
                    🚀 Đổi Mật Khẩu
                </button>
            </form>
            
            <div class="back-link">
                <a href="${pageContext.request.contextPath}/profile">← Quay lại thông tin tài khoản</a>
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
                            <p class="text-center"> 2024 TechNova. All Rights Reserved.</p>
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
    
    <script>
        function checkPasswordStrength() {
            const password = document.getElementById('newPassword').value;
            const strengthDiv = document.getElementById('passwordStrength');
            
            if (password.length === 0) {
                strengthDiv.innerHTML = '';
                return;
            }
            
            let strength = 0;
            if (password.length >= 6) strength++;
            if (password.length >= 10) strength++;
            if (/[a-z]/.test(password) && /[A-Z]/.test(password)) strength++;
            if (/[0-9]/.test(password)) strength++;
            if (/[^a-zA-Z0-9]/.test(password)) strength++;
            
            let strengthText = '';
            let strengthClass = '';
            
            if (strength <= 2) {
                strengthText = '💪 Yếu';
                strengthClass = 'strength-weak';
            } else if (strength <= 3) {
                strengthText = '👍 Trung bình';
                strengthClass = 'strength-medium';
            } else {
                strengthText = '🔥 Mạnh';
                strengthClass = 'strength-strong';
            }
            
            strengthDiv.innerHTML = '<span class="' + strengthClass + '">' + strengthText + '</span>';
        }
        
        // Validate form before submit
        document.querySelector('form').addEventListener('submit', function(e) {
            const newPassword = document.getElementById('newPassword').value;
            const confirmPassword = document.getElementById('confirmPassword').value;
            
            if (newPassword !== confirmPassword) {
                e.preventDefault();
                alert('Mật khẩu xác nhận không khớp!');
                return false;
            }
            
            if (newPassword.length < 6) {
                e.preventDefault();
                alert('Mật khẩu mới phải có ít nhất 6 ký tự!');
                return false;
            }
        });
    </script>
    
</body>
</html>

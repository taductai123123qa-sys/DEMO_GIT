<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>TechNova - Cửa Hàng Công Nghệ</title>
        <link href="https://fonts.googleapis.com/css?family=Montserrat:400,500,600,700" rel="stylesheet">
        <link rel="stylesheet" href="css/bootstrap.min.css"/>
        <link rel="stylesheet" href="css/font-awesome.min.css">
        <style>
            :root {
                --red:#D10024;
                --dark:#16213e;
                --border:#e0e0e0;
            }
            *{
                box-sizing:border-box;
                margin:0;
                padding:0;
            }
            body{
                font-family:'Montserrat',sans-serif;
                background:#efefef;
            }
            a{
                text-decoration:none;
                color:inherit;
            }
            .container{
                max-width:1380px;
                margin:0 auto;
                padding:0 15px;
            }

            #top-header{
                background:var(--dark);
                padding:7px 0;
            }
            .top-bar{
                display:flex;
                align-items:center;
                list-style:none;
                gap:18px;
            }
            .top-bar a{
                color:#bbb;
                font-size:11px;
            }
            .top-bar a:hover{
                color:#fff;
            }
            .top-bar i{
                margin-right:4px;
            }
            .ml-auto{
                margin-left:auto;
                display:flex;
                gap:14px;
            }
            .ml-auto a{
                color:#bbb;
                font-size:11px;
            }
            .ml-auto a:hover{
                color:#fff;
            }

            #header{
                background:#fff;
                padding:12px 0;
                border-bottom:3px solid var(--red);
                box-shadow:0 2px 8px rgba(0,0,0,.07);
            }
            .header-row{
                display:flex;
                align-items:center;
                gap:18px;
            }
            .logo img{
                height:48px;
                display:block;
            }
            .search-form{
                flex:1;
                display:flex;
            }
            .search-form input{
                flex:1;
                padding:10px 14px;
                border:2px solid var(--red);
                border-right:none;
                font-family:'Montserrat',sans-serif;
                font-size:13px;
                outline:none;
            }
            .search-form button{
                padding:10px 22px;
                background:var(--red);
                color:#fff;
                border:none;
                font-family:'Montserrat',sans-serif;
                font-size:13px;
                font-weight:700;
                cursor:pointer;
            }
            .search-form button:hover{
                background:#b0001d;
            }
            .hdr-actions{
                display:flex;
                gap:20px;
            }
            .hdr-actions a{
                color:var(--dark);
                font-size:11px;
                font-weight:600;
                display:flex;
                flex-direction:column;
                align-items:center;
                gap:3px;
                position:relative;
            }
            .hdr-actions a i{
                font-size:22px;
            }
            .hdr-actions a:hover{
                color:var(--red);
            }
            .hdr-badge{
                position:absolute;
                top:-4px;
                right:-8px;
                background:var(--red);
                color:#fff;
                border-radius:50%;
                width:16px;
                height:16px;
                font-size:9px;
                font-weight:700;
                display:flex;
                align-items:center;
                justify-content:center;
            }

            .promo-bar{
                background:#111827;
                padding:7px 0;
                display:flex;
                justify-content:center;
                gap:30px;
                flex-wrap:wrap;
                font-size:11px;
                font-weight:600;
                color:#ccc;
            }
            .promo-bar span{
                display:flex;
                align-items:center;
                gap:5px;
            }
            .promo-bar i{
                color:#FFD700;
                font-size:14px;
            }
            .deal-tag{
                background:var(--red);
                color:#fff;
                padding:3px 12px;
                border-radius:2px;
                font-size:11px;
                font-weight:700;
                animation:blink 1.3s infinite;
            }
            @keyframes blink{
                0%,100%{
                    opacity:1
                }
                50%{
                    opacity:.6
                }
            }

            #nav{
                background:var(--red);
            }
            .nav-ul{
                list-style:none;
                display:flex;
                margin:0;
            }
            .nav-ul li a{
                color:#fff;
                padding:11px 16px;
                display:block;
                font-size:12px;
                font-weight:700;
                transition:background .2s;
            }
            .nav-ul li a:hover,.nav-ul li.active a{
                background:rgba(0,0,0,.18);
            }

            .layout{
                display:flex;
                gap:12px;
                padding:14px 0 30px;
            }

            .sidebar{
                width:215px;
                flex-shrink:0;
            }
            .sb-card{
                background:#fff;
                border:1px solid var(--border);
                margin-bottom:10px;
                overflow:hidden;
            }
            .sb-head{
                background:var(--dark);
                color:#fff;
                padding:10px 13px;
                font-size:12px;
                font-weight:700;
                display:flex;
                align-items:center;
                gap:7px;
            }
            .cat-ul{
                list-style:none;
            }
            .cat-ul li a{
                display:flex;
                align-items:center;
                padding:9px 13px;
                font-size:12px;
                color:#333;
                border-bottom:1px solid #f0f0f0;
                transition:all .15s;
                gap:8px;
            }
            .cat-ul li a:hover,.cat-ul li a.active{
                background:#fff3f3;
                color:var(--red);
                padding-left:17px;
            }
            .cat-ul li a i{
                width:16px;
                text-align:center;
            }
            .cat-ul li a .arr{
                margin-left:auto;
                font-size:9px;
                color:#ccc;
            }

            .brand-pad{
                padding:10px;
            }
            .brand-grid{
                display:grid;
                grid-template-columns:1fr 1fr;
                gap:5px;
            }
            .b-btn{
                display:block;
                padding:6px 5px;
                border:1px solid var(--border);
                background:#fff;
                font-size:10px;
                font-weight:700;
                text-align:center;
                border-radius:2px;
                color:#444;
                transition:all .2s;
                cursor:pointer;
            }
            .b-btn:hover,.b-btn.active{
                background:var(--red);
                color:#fff;
                border-color:var(--red);
            }

            .price-pad{
                padding:10px 13px;
            }
            .p-opt{
                display:flex;
                align-items:center;
                gap:7px;
                padding:7px 0;
                font-size:12px;
                color:#444;
                border-bottom:1px solid #f5f5f5;
                cursor:pointer;
            }
            .p-opt:hover,.p-opt.active{
                color:var(--red);
                font-weight:600;
            }
            .p-opt input{
                accent-color:var(--red);
            }

            .main{
                flex:1;
                min-width:0;
            }
            .filter-bar{
                background:#fff;
                padding:9px 13px;
                margin-bottom:10px;
                display:flex;
                align-items:center;
                gap:7px;
                flex-wrap:wrap;
                border:1px solid var(--border);
            }
            .filter-bar label{
                font-size:11px;
                font-weight:700;
                color:#555;
            }
            .f-tag{
                padding:5px 12px;
                border:1px solid var(--border);
                background:#fff;
                font-size:11px;
                color:#444;
                border-radius:2px;
                transition:all .2s;
                font-weight:600;
            }
            .f-tag:hover,.f-tag.active{
                background:var(--red);
                color:#fff;
                border-color:var(--red);
            }

            .result-info{
                font-size:11px;
                color:#777;
                margin-bottom:10px;
            }
            .result-info strong{
                color:var(--red);
            }

            .prod-grid{
                display:grid;
                grid-template-columns:repeat(4,1fr);
                gap:10px;
            }
            .prod-card{
                background:#fff;
                border:1px solid var(--border);
                position:relative;
                overflow:hidden;
                display:flex;
                flex-direction:column;
                transition:box-shadow .2s,transform .2s;
            }
            .prod-card:hover{
                box-shadow:0 5px 20px rgba(0,0,0,.12);
                transform:translateY(-3px);
            }
            .prod-lbl{
                position:absolute;
                top:8px;
                left:8px;
                z-index:2;
                padding:3px 8px;
                font-size:9px;
                font-weight:700;
                border-radius:2px;
                color:#fff;
            }
            .lbl-hot{
                background:#ff5722;
            }
            .lbl-new{
                background:#43A047;
            }
            .prod-img{
                height:160px;
                display:flex;
                align-items:center;
                justify-content:center;
                padding:12px;
                background:#fafafa;
                overflow:hidden;
            }
            .prod-img img{
                max-height:140px;
                max-width:100%;
                object-fit:contain;
                transition:transform .35s;
            }
            .prod-card:hover .prod-img img{
                transform:scale(1.07);
            }
            .prod-body{
                padding:10px;
                flex:1;
                display:flex;
                flex-direction:column;
            }
            .prod-brand{
                font-size:9px;
                color:#aaa;
                text-transform:uppercase;
                font-weight:700;
                margin-bottom:4px;
            }
            .prod-name{
                font-size:12px;
                color:#333;
                font-weight:600;
                line-height:1.45;
                margin-bottom:6px;
                display:-webkit-box;
                -webkit-line-clamp:2;
                -webkit-box-orient:vertical;
                overflow:hidden;
                min-height:35px;
                flex:1;
            }
            .prod-name a:hover{
                color:var(--red);
            }
            .prod-price{
                color:var(--red);
                font-size:14px;
                font-weight:700;
                margin-bottom:3px;
            }
            .prod-sold{
                font-size:10px;
                color:#bbb;
                margin-bottom:8px;
            }
            .hot-lbl{
                display:inline-block;
                background:#ff5722;
                color:#fff;
                font-size:8px;
                font-weight:700;
                padding:1px 5px;
                border-radius:2px;
                margin-right:3px;
            }
            .btn-cart{
                width:100%;
                padding:8px;
                background:var(--red);
                color:#fff;
                border:none;
                cursor:pointer;
                font-size:11px;
                font-weight:700;
                font-family:'Montserrat',sans-serif;
                border-radius:2px;
                margin-top:auto;
                transition:background .2s;
            }
            .btn-cart:hover{
                background:#b0001d;
            }

            .empty{
                text-align:center;
                padding:70px 20px;
                background:#fff;
            }
            .empty i{
                font-size:55px;
                color:#ddd;
                margin-bottom:15px;
                display:block;
            }
            .empty h3{
                color:#aaa;
                font-size:16px;
            }
            .empty p{
                color:#ccc;
                font-size:12px;
                margin-top:8px;
            }

            .paging{
                display:flex;
                justify-content:center;
                gap:5px;
                margin-top:20px;
            }
            .pg{
                padding:8px 14px;
                border:1px solid var(--border);
                background:#fff;
                font-size:12px;
                font-weight:700;
                color:#333;
                border-radius:2px;
                transition:all .2s;
            }
            .pg:hover,.pg.active{
                background:var(--red);
                color:#fff;
                border-color:var(--red);
            }

            #footer{
                background:var(--dark);
                color:#999;
                margin-top:20px;
            }
            .footer-body{
                padding:35px 0 20px;
            }
            .ft-title{
                color:#fff;
                font-size:12px;
                font-weight:700;
                display:inline-block;
                border-bottom:2px solid var(--red);
                padding-bottom:7px;
                margin-bottom:13px;
            }
            .ft-links{
                list-style:none;
            }
            .ft-links li{
                margin-bottom:7px;
            }
            .ft-links a{
                color:#888;
                font-size:12px;
            }
            .ft-links a:hover{
                color:var(--red);
            }
            #footer-bottom{
                background:rgba(0,0,0,.25);
                padding:12px 0;
                text-align:center;
                font-size:11px;
                color:#555;
            }

            @media(max-width:900px){
                .layout{
                    flex-direction:column;
                }
                .sidebar{
                    width:100%;
                }
                .prod-grid{
                    grid-template-columns:repeat(2,1fr);
                }
            }
            @media(max-width:480px){
                .prod-grid{
                    grid-template-columns:1fr;
                }
            }
        </style>
    </head>
    <body>


        <!-- TOP HEADER -->
        <div id="top-header">
            <div class="container">
                <ul class="top-bar">
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

        <!-- MAIN HEADER -->
        <div id="header">
            <div class="container">
                <div class="header-row">
                    <div class="logo">
                        <a href="home"><img src="img/products/logo.png" alt="TectNova"></a>
                    </div>
                    <form class="search-form" action="home" method="GET">
                        <input type="hidden" name="category" value="${curCat}">
                        <input type="hidden" name="brand"    value="${curBrand}">
                        <input type="hidden" name="price"    value="${curPrice}">
                        <input type="hidden" name="sort"     value="${curSort}"> <!-- thêm nếu muốn giữ sort -->
                        <input type="text"   name="keyword"  placeholder="Tìm kiếm laptop, PC gaming, phụ kiện..." value="${curKw}">
                        <button type="submit"><i class="fa fa-search"></i> Tìm kiếm</button>
                    </form>
                    <div class="hdr-actions">                     
                        <a href="Cart.jsp">
                            <i class="fa fa-shopping-cart"></i>
                            <span>Giỏ hàng</span>
                            <div class="hdr-badge" id="cartBadge">${sessionScope.cartCount != null ? sessionScope.cartCount : 0}</div>
                        </a>
                    </div>
                </div>
            </div>
        </div>

        <!-- PROMO BAR -->
        <div class="promo-bar">
            <span><i class="fa fa-check-circle"></i> 100% Chính Hãng</span>
            <span><i class="fa fa-tag"></i> Giá Tốt Nhất</span>
            <span><i class="fa fa-truck"></i> Miễn Phí Vận Chuyển</span>
            <span><i class="fa fa-shield"></i> Bảo Hành Tại Nhà</span>
            <span><i class="fa fa-credit-card"></i> Thanh Toán Linh Hoạt</span>
            <span class="deal-tag">🔥 DEAL GIỜ VÀNG</span>
        </div>

        <!-- NAV -->
        <div id="nav">
            <div class="container">
                <ul class="nav-ul">
                    <li class="active"><a href="home"><i class="fa fa-home"></i> Trang Chủ</a></li>
                    <li><a href="home?category=1"><i class="fa fa-desktop"></i> PC Gaming</a></li>
                    <li><a href="home?category=2"><i class="fa fa-laptop"></i> Laptop</a></li>
                </ul>
            </div>
        </div>

        <!-- LAYOUT -->
        <div class="container">
            <div class="layout">

                <!-- SIDEBAR -->
                <div class="sidebar">

                    <!-- Danh mục -->
                    <div class="sb-card">
                        <div class="sb-head"><i class="fa fa-list"></i> DANH MỤC SẢN PHẨM</div>
                        <ul class="cat-ul">
                            <li>
                                <a href="home" class="${curCat == 'all' ? 'active' : ''}">
                                    <i class="fa fa-th-large" style="color:var(--red)"></i> Tất Cả Sản Phẩm
                                    <i class="fa fa-chevron-right arr"></i>
                                </a>
                            </li>
                            <li>
                                <a href="home?category=1" class="${curCat == '1' ? 'active' : ''}">
                                    <i class="fa fa-desktop" style="color:#2196F3"></i> PC Gaming, Đồ Họa
                                    <i class="fa fa-chevron-right arr"></i>
                                </a>
                            </li>
                            <li>
                                <a href="home?category=2" class="${curCat == '2' ? 'active' : ''}">
                                    <i class="fa fa-laptop" style="color:#43A047"></i> Laptop Các Loại
                                    <i class="fa fa-chevron-right arr"></i>
                                </a>
                            </li>
                            <li>
                                <a href="home?category=3" class="${curCat == '3' ? 'active' : ''}">
                                    <i class="fa fa-microchip" style="color:#FF9800"></i> Linh Kiện Máy Tính
                                    <i class="fa fa-chevron-right arr"></i>
                                </a>
                            </li>
                            <li>
                                <a href="home?category=4" class="${curCat == '4' ? 'active' : ''}">
                                    <i class="fa fa-gamepad" style="color:#9C27B0"></i> Gaming Gear
                                    <i class="fa fa-chevron-right arr"></i>
                                </a>
                            </li>
                            <li>
                                <a href="home?category=5" class="${curCat == '5' ? 'active' : ''}">
                                    <i class="fa fa-tv" style="color:#F44336"></i> Màn Hình Máy Tính
                                    <i class="fa fa-chevron-right arr"></i>
                                </a>
                            </li>
                            <li>
                                <a href="home?category=6" class="${curCat == '6' ? 'active' : ''}">
                                    <i class="fa fa-hdd-o" style="color:#607D8B"></i> Thiết Bị Lưu Trữ
                                    <i class="fa fa-chevron-right arr"></i>
                                </a>
                            </li>
                            <li>
                                <a href="home?category=7" class="${curCat == '7' ? 'active' : ''}">
                                    <i class="fa fa-keyboard-o" style="color:#00BCD4"></i> Bàn Phím, Chuột
                                    <i class="fa fa-chevron-right arr"></i>
                                </a>
                            </li>
                        </ul>
                    </div>

                    <!-- Lọc hãng -->
                    <div class="sb-card">
                        <div class="sb-head"><i class="fa fa-filter"></i> CHỌN THEO HÃNG</div>
                        <div class="brand-pad">
                            <div class="brand-grid">
                                <a href="home?category=${curCat}&brand=all&price=${curPrice}&sort=${curSort}&keyword=${curKw}" 
                                   class="b-btn ${curBrand == 'all' ? 'active' : ''}">Tất cả</a>
                                <a href="home?category=${curCat}&brand=1&price=${curPrice}&sort=${curSort}&keyword=${curKw}" 
                                   class="b-btn ${curBrand == '1' ? 'active' : ''}">OMEN</a>
                                <!-- Làm tương tự cho brand 2 → 10 -->
                            </div>
                        </div>
                    </div>

                    <!-- Lọc giá -->
                    <div class="sb-card">
                        <div class="sb-head"><i class="fa fa-money"></i> LỌC THEO GIÁ</div>
                        <div class="price-pad">
                            <a href="home?category=${curCat}&brand=${curBrand}&price=all&sort=${curSort}&keyword=${curKw}" 
                               class="p-opt ${curPrice == 'all' ? 'active' : ''}">
                                <input type="radio" ${curPrice == 'all' ? 'checked' : ''}> Tất cả mức giá
                            </a>
                            <a href="home?category=${curCat}&brand=${curBrand}&price=under10&sort=${curSort}&keyword=${curKw}" 
                               class="p-opt ${curPrice == 'under10' ? 'active' : ''}">
                                <input type="radio" ${curPrice == 'under10' ? 'checked' : ''}> Dưới 10 triệu
                            </a>
                            <!-- Tương tự cho 10to20, 20to30, 30to50, over50 -->
                        </div>
                    </div>

                </div>
                <!-- /SIDEBAR -->

                <!-- MAIN -->
                <div class="main">

                    <!-- Filter bar -->
                    <div class="filter-bar">
                        <label>Sắp xếp:</label>
                        <a href="home?category=${curCat}&brand=${curBrand}&price=${curPrice}&sort=newest&keyword=${curKw}" 
                           class="f-tag ${curSort == 'newest' ? 'active' : ''}">Mới nhất</a>
                        <a href="home?category=${curCat}&brand=${curBrand}&price=${curPrice}&sort=bestsell&keyword=${curKw}" 
                           class="f-tag ${curSort == 'bestsell' ? 'active' : ''}">Bán chạy</a>
                        <a href="home?category=${curCat}&brand=${curBrand}&price=${curPrice}&sort=price_asc&keyword=${curKw}" 
                           class="f-tag ${curSort == 'price_asc' ? 'active' : ''}">Giá tăng dần</a>
                        <a href="home?category=${curCat}&brand=${curBrand}&price=${curPrice}&sort=price_desc&keyword=${curKw}" 
                           class="f-tag ${curSort == 'price_desc' ? 'active' : ''}">Giá giảm dần</a>
                    </div>

                    <!-- Result info -->
                    <div class="result-info">
                        Tìm thấy <strong>${not empty totalProducts ? totalProducts : 0}</strong> sản phẩm
                        <c:if test="${not empty param.keyword}">— kết quả cho "<strong>${param.keyword}</strong>"</c:if>
                        </div>

                        <!-- Product grid -->
                    <c:choose>
                        <c:when test="${not empty products}">
                            <div class="prod-grid">
                                <c:forEach var="p" items="${products}">
                                    <div class="prod-card">
                                        <c:choose>
                                            <c:when test="${p.soldCount >= 5}">
                                                <div class="prod-lbl lbl-hot">🔥 Bán chạy</div>
                                            </c:when>
                                            <c:otherwise>
                                                <div class="prod-lbl lbl-new">Mới</div>
                                            </c:otherwise>
                                        </c:choose>

                                        <div class="prod-img">
                                            <c:choose>
                                                <c:when test="${not empty p.images}">
                                                    <img src="${pageContext.request.contextPath}/${p.images}"
                                                         alt="${p.name}"
                                                         onerror="this.src='${pageContext.request.contextPath}/img/product01.png'">
                                                </c:when>
                                                <c:otherwise>
                                                    <img src="${pageContext.request.contextPath}/img/product01.png"
                                                         alt="${p.name}">
                                                </c:otherwise>
                                            </c:choose>
                                        </div>

                                        <div class="prod-body">
                                            <div class="prod-brand">
                                                <c:if test="${p.soldCount >= 8}"><span class="hot-lbl">HOT</span></c:if>
                                                    TectNova Store
                                                </div>
                                                <div class="prod-name">
                                                    <a href="productdetail?id=${p.productId}">${p.name}</a>
                                            </div>
                                            <div class="prod-price">
                                                <fmt:formatNumber value="${p.price}" type="number" groupingUsed="true"/>đ
                                            </div>
                                            <div class="prod-sold">
                                                <i class="fa fa-shopping-bag" style="color:#FF9800"></i> Đã bán ${p.soldCount} chiếc
                                            </div>
                                            <button class="btn-cart" onclick="addToCart(${p.productId})">
                                                <i class="fa fa-shopping-cart"></i> Thêm vào giỏ hàng
                                            </button>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="empty">
                                <i class="fa fa-search"></i>
                                <h3>Không tìm thấy sản phẩm phù hợp</h3>
                                <p>Thử thay đổi bộ lọc hoặc từ khóa tìm kiếm khác</p>
                            </div>
                        </c:otherwise>
                    </c:choose>

                    <!-- PHÂN TRANG -->
                    <c:if test="${totalPages > 1}">
                        <div class="paging">
                            <c:if test="${currentPage > 1}">
                                <a class="pg" href="home?category=${curCat}&brand=${curBrand}&price=${curPrice}&sort=${curSort}&keyword=${curKw}&page=${currentPage-1}">
                                    <i class="fa fa-chevron-left"></i>
                                </a>
                            </c:if>
                            <c:forEach begin="1" end="${totalPages}" var="i">
                                <a class="pg ${i == currentPage ? 'active' : ''}" 
                                   href="home?category=${curCat}&brand=${curBrand}&price=${curPrice}&sort=${curSort}&keyword=${curKw}&page=${i}">
                                    ${i}
                                </a>
                            </c:forEach>
                            <c:if test="${currentPage < totalPages}">
                                <a class="pg" href="home?category=${curCat}&brand=${curBrand}&price=${curPrice}&sort=${curSort}&keyword=${curKw}&page=${currentPage+1}">
                                    <i class="fa fa-chevron-right"></i>
                                </a>
                            </c:if>
                        </div>
                    </c:if>
                </div>
                <!-- /MAIN -->

            </div>
        </div>

        <!-- FOOTER -->
        <footer id="footer">
            <div class="footer-body">
                <div class="container">
                    <div class="row">
                        <div class="col-md-3 col-sm-6">
                            <div class="ft-title">Về TechNova</div>
                            <ul class="ft-links">
                                <li><a href="#"><i class="fa fa-map-marker"></i> Hà Nội, Việt Nam</a></li>
                                <li><a href="#"><i class="fa fa-phone"></i> 0986.568.721</a></li>
                                <li><a href="#"><i class="fa fa-envelope-o"></i> info@nova.com</a></li>
                            </ul>
                        </div>
                        <div class="col-md-3 col-sm-6">
                            <div class="ft-title">Danh Mục</div>
                            <ul class="ft-links">
                                <li><a href="home?category=1">PC Gaming</a></li>
                                <li><a href="home?category=2">Laptop</a></li>
                                <li><a href="#">Linh Kiện</a></li>
                                <li><a href="#">Phụ Kiện Gaming</a></li>
                            </ul>
                        </div>
                        <div class="col-md-3 col-sm-6">
                            <div class="ft-title">Hỗ Trợ</div>
                            <ul class="ft-links">
                                <li><a href="#">Chính Sách Bảo Hành</a></li>
                                <li><a href="#">Hướng Dẫn Đặt Hàng</a></li>
                                <li><a href="#">Đổi Trả Hàng</a></li>
                                <li><a href="#">Liên Hệ</a></li>
                            </ul>
                        </div>
                        <div class="col-md-3 col-sm-6">
                            <div class="ft-title">Tài Khoản</div>
                            <ul class="ft-links">
                                <li><a href="${pageContext.request.contextPath}/login">Đăng Nhập</a></li>
                                <li><a href="${pageContext.request.contextPath}/register">Đăng Ký</a></li>
                                <li><a href="#">Đơn Hàng Của Tôi</a></li>
                                <li><a href="#">Wishlist</a></li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
            <div id="footer-bottom">
                Copyright &copy; <script>document.write(new Date().getFullYear())</script> TechNova Store. All rights reserved.
            </div>
        </footer>

        <script src="js/jquery.min.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <script>
            function addToCart(productId) {
                fetch('addtocart?productId=' + productId + '&ajax=1', {
                    method: 'GET',
                    headers: {
                        'X-Requested-With': 'XMLHttpRequest'
                    }
                }).then(function (res) {
                    return res.json();
                }).then(function (data) {
                    if (data && data.success) {
                        var badge = document.getElementById('cartBadge');
                        if (badge) {
                            badge.textContent = data.cartCount;
                        }
                    } else {
                        window.location.href = 'cart';
                    }
                }).catch(function () {
                    window.location.href = 'cart';
                });
            }
        </script>
    </body>
</html>
<%-- 
    Document   : Product
    Created on : Feb 16, 2026, 10:06:56 PM
    Author     : Lecoo
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->

        <title>Electro - HTML Ecommerce Template</title>

        <!-- Google font -->
        <link href="https://fonts.googleapis.com/css?family=Montserrat:400,500,700" rel="stylesheet">

        <!-- Bootstrap -->
        <link type="text/css" rel="stylesheet" href="css/bootstrap.min.css"/>

        <!-- Slick -->
        <link type="text/css" rel="stylesheet" href="css/slick.css"/>
        <link type="text/css" rel="stylesheet" href="css/slick-theme.css"/>

        <!-- nouislider -->
        <link type="text/css" rel="stylesheet" href="css/nouislider.min.css"/>

        <!-- Font Awesome Icon -->
        <link rel="stylesheet" href="css/font-awesome.min.css">

        <!-- Custom stlylesheet -->
        <link type="text/css" rel="stylesheet" href="css/style.css"/>
        <style>
            #cart-toast {
                position: fixed;
                bottom: 24px;
                right: 24px;
                background: #28a745;
                color: #fff;
                padding: 14px 24px;
                border-radius: 4px;
                box-shadow: 0 4px 12px rgba(0,0,0,0.2);
                z-index: 9999;
                font-weight: 600;
                display: none;
            }
            #cart-toast.show {
                display: block;
                animation: fadeIn 0.3s ease;
            }
            @keyframes fadeIn {
                from {
                    opacity: 0;
                    transform: translateY(10px);
                }
                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }
        </style>

        <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
        <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
        <!--[if lt IE 9]>
          <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
          <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
        <![endif]-->

    </head>
    <body>
        <!-- HEADER -->
        <header>
            <!-- MAIN HEADER -->
            <div id="header">
                <!-- container -->
                <div class="container">
                    <!-- row -->
                    <div class="row">
                        <!-- LOGO -->
                        <div class="col-md-3">
                            <div class="header-logo">
                                <a href="${pageContext.request.contextPath}/home" class="logo">
                                    <img src="${pageContext.request.contextPath}/img/logo.png" alt="">
                                </a>
                            </div>
                        </div>
                        <!-- /LOGO -->

                        <!-- SEARCH BAR -->
                        <div class="col-md-6">
                            <div class="header-search">
                                <form>		
                                    <input class="input" placeholder="Search here">
                                    <button class="search-btn">Search</button>
                                </form>
                            </div>
                        </div>
                        <!-- /SEARCH BAR -->

                        <!-- ACCOUNT -->
                        <div class="col-md-3 clearfix">
                            <div class="header-ctn">


                                <!-- Cart -->
                                <div class="dropdown">
                                    <a href="${pageContext.request.contextPath}/cart" class="dropdown-toggle" data-toggle="dropdown" aria-expanded="true">
                                        <i class="fa fa-shopping-cart"></i>
                                        <span>Your Cart</span>
                                        <div class="qty" id="header-cart-count">${sessionScope.cartCount != null ? sessionScope.cartCount : 0}</div>
                                    </a>
                                    <div class="cart-dropdown">
                                        <div class="cart-list">
                                            <c:choose>
                                                <c:when test="${not empty sessionScope.cart and not empty sessionScope.cart.items}">
                                                    <c:forEach var="cartItem" items="${sessionScope.cart.items}" begin="0" end="2">
                                                        <div class="product-widget">
                                                            <div class="product-img">
                                                                <c:choose>
                                                                    <c:when test="${not empty cartItem.product.images}">
                                                                        <img src="${pageContext.request.contextPath}/${cartItem.product.images}" alt="${cartItem.product.name}">
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <img src="${pageContext.request.contextPath}/img/product01.png" alt="">
                                                                    </c:otherwise>
                                                                </c:choose>
                                                            </div>
                                                            <div class="product-body">
                                                                <h3 class="product-name"><a href="${pageContext.request.contextPath}/productdetail?id=${cartItem.product.productId}">${cartItem.product.name}</a></h3>
                                                                <h4 class="product-price"><span class="qty">${cartItem.quantity}x</span> <fmt:formatNumber value="${cartItem.product.price}" type="number" groupingUsed="true"/>đ</h4>
                                                            </div>
                                                        </div>
                                                    </c:forEach>
                                                </c:when>
                                                <c:otherwise>
                                                    <div class="cart-empty" style="padding:12px;color:#999;font-size:13px;">Giỏ hàng trống</div>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                        <div class="cart-summary">
                                            <small><c:out value="${sessionScope.cartCount != null ? sessionScope.cartCount : 0}"/> sản phẩm</small>
                                        </div>
                                        <div class="cart-btns">
                                            <a href="${pageContext.request.contextPath}/cart">View Cart</a>
                                            <a href="${pageContext.request.contextPath}/checkout">Checkout  <i class="fa fa-arrow-circle-right"></i></a>
                                        </div>
                                    </div>
                                </div>
                                <!-- /Cart -->

                                <!-- Menu Toogle -->
                                <div class="menu-toggle">
                                    <a href="#">
                                        <i class="fa fa-bars"></i>
                                        <span>Menu</span>
                                    </a>
                                </div>
                                <!-- /Menu Toogle -->
                            </div>
                        </div>
                        <!-- /ACCOUNT -->
                    </div>
                    <!-- row -->
                </div>
                <!-- container -->
            </div>
            <!-- /MAIN HEADER -->
        </header>
        <div id="cart-toast"><i class="fa fa-check-circle"></i> Đã thêm vào giỏ hàng!</div>
        <!-- /HEADER -->

        <!-- NAVIGATION -->
        <nav id="navigation">
            <!-- container -->
            <div class="container">
                <!-- responsive-nav -->
                <div id="responsive-nav">
                    <!-- NAV -->
                    <ul class="main-nav nav navbar-nav">
                        <li class="active"><a href="${pageContext.request.contextPath}/home">Home</a></li>
                    </ul>
                    <!-- /NAV -->
                </div>
                <!-- /responsive-nav -->
            </div>
            <!-- /container -->
        </nav>
        <!-- /NAVIGATION -->

        <!-- BREADCRUMB -->
        <div id="breadcrumb" class="section">
            <!-- container -->
            <div class="container">
                <!-- row -->
                <div class="row">
                    <div class="col-md-12">
                        <ul class="breadcrumb-tree">
                            <li><a href="${pageContext.request.contextPath}/home">Home</a></li>
                            <li class="active">${product.name}</li>
                        </ul>
                    </div>
                </div>
                <!-- /row -->
            </div>
            <!-- /container -->
        </div>
        <!-- /BREADCRUMB -->

        <!-- SECTION -->
        <div class="section">
            <!-- container -->
            <div class="container">
                <!-- row -->
                <div class="row">
                    <!-- Product main img -->
                    <div class="col-md-5 col-md-push-2">
                        <div id="product-main-img">
                            <div class="product-preview">
                                <c:choose>
                                    <c:when test="${not empty product.images}">
                                        <img src="${pageContext.request.contextPath}/${product.images}" alt="${product.name}"
                                             onerror="this.src='${pageContext.request.contextPath}/img/product01.png'">
                                    </c:when>
                                    <c:otherwise>
                                        <img src="${pageContext.request.contextPath}/img/product01.png" alt="${product.name}">
                                    </c:otherwise>
                                </c:choose>
                            </div>
                            <c:if test="${not empty images}">
                                <c:forEach var="img" items="${images}">
                                    <div class="product-preview">
                                        <img src="${pageContext.request.contextPath}/${img.imageUrl}" alt="${product.name}">
                                    </div>
                                </c:forEach>
                            </c:if>
                        </div>
                    </div>
                    <!-- /Product main img -->

                    <!-- Product thumb imgs -->
                    <div class="col-md-2  col-md-pull-5">
                        <div id="product-imgs">
                            <div class="product-preview">
                                <c:choose>
                                    <c:when test="${not empty product.images}">
                                        <img src="${pageContext.request.contextPath}/${product.images}" alt="${product.name}">
                                    </c:when>
                                    <c:otherwise>
                                        <img src="${pageContext.request.contextPath}/img/product01.png" alt="${product.name}">
                                    </c:otherwise>
                                </c:choose>
                            </div>
                            <c:forEach var="img" items="${images}">
                                <div class="product-preview">
                                    <img src="${pageContext.request.contextPath}/${img.imageUrl}" alt="${product.name}">
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                    <!-- /Product thumb imgs -->

                    <!-- Product details -->
                    <div class="col-md-5">
                        <div class="product-details">
                            <h2 class="product-name">${product.name}</h2>
                            <div>
                                <div class="product-rating">
                                    <c:set var="avg" value="${averageRating}" />
                                    <c:forEach begin="1" end="5" var="i">
                                        <c:choose>
                                            <c:when test="${avg >= i}">
                                                <i class="fa fa-star"></i>
                                            </c:when>
                                            <c:when test="${avg >= i - 0.5}">
                                                <i class="fa fa-star-half-o"></i>
                                            </c:when>
                                            <c:otherwise>
                                                <i class="fa fa-star-o"></i>
                                            </c:otherwise>
                                        </c:choose>
                                    </c:forEach>
                                </div>
                                <a class="review-link" href="#tab3">
                                    <c:out value="${reviewCount != null ? reviewCount : 0}" /> Review(s) | Add your review
                                </a>
                            </div>
                            <div>
                                <h3 class="product-price">
                                    <fmt:formatNumber value="${product.price}" type="currency" currencySymbol="₫" groupingUsed="true"/>
                                </h3>
                                <span class="product-available">
                                    <c:choose>
                                        <c:when test="${product.stock > 0}">Còn hàng (${product.stock})</c:when>
                                        <c:otherwise>Hết hàng</c:otherwise>
                                    </c:choose>
                                </span>
                            </div>
                            <p>${product.description}</p>

                            <div class="product-options">
                                <label>
                                    Size
                                    <select class="input-select">
                                        <option value="0">X</option>
                                    </select>
                                </label>
                                <label>
                                    Color
                                    <select class="input-select">
                                        <option value="0">Red</option>
                                    </select>
                                </label>
                            </div>

                            <div class="add-to-cart">
                                <div class="qty-label">
                                    Qty
                                    <div class="input-number">
                                        <input type="number" id="detail-qty" value="1" min="1" max="${product.stock}">
                                        <span class="qty-up" onclick="changeDetailQty(1)">+</span>
                                        <span class="qty-down" onclick="changeDetailQty(-1)">-</span>
                                    </div>
                                </div>
                                <button class="add-to-cart-btn" onclick="addDetailToCart(${product.productId})">
                                    <i class="fa fa-shopping-cart"></i> Thêm vào giỏ
                                </button>
                            </div>

                            <ul class="product-btns">
                                <li><a href="#"><i class="fa fa-heart-o"></i> add to wishlist</a></li>
                                <li><a href="#"><i class="fa fa-exchange"></i> add to compare</a></li>
                            </ul>

                            <ul class="product-links">
                                <li>Category:</li>
                                <li><a href="#">${product.categoryId}</a></li>
                            </ul>

                            <ul class="product-links">
                                <li>Share:</li>
                                <li><a href="#"><i class="fa fa-facebook"></i></a></li>
                                <li><a href="#"><i class="fa fa-twitter"></i></a></li>
                                <li><a href="#"><i class="fa fa-google-plus"></i></a></li>
                                <li><a href="#"><i class="fa fa-envelope"></i></a></li>
                            </ul>

                        </div>
                    </div>
                    <!-- /Product details -->

                    <!-- Product tab -->
                    <div class="col-md-12">
                        <div id="product-tab">
                            <!-- product tab nav -->
                            <ul class="tab-nav">
                                <li class="active"><a data-toggle="tab" href="#tab1">Description</a></li>
                                <li><a data-toggle="tab" href="#tab2">Details</a></li>
                                <li><a data-toggle="tab" href="#tab3">
                                        Reviews (<c:out value="${reviewCount != null ? reviewCount : 0}" />)
                                    </a></li>
                            </ul>
                            <!-- /product tab nav -->

                            <!-- product tab content -->
                            <div class="tab-content">
                                <!-- tab1  -->
                                <div id="tab1" class="tab-pane fade in active">
                                    <div class="row">
                                        <div class="col-md-12">
                                            <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>
                                        </div>
                                    </div>
                                </div>
                                <!-- /tab1  -->

                                <!-- tab2  -->
                                <div id="tab2" class="tab-pane fade in">
                                    <div class="row">
                                        <div class="col-md-12">
                                            <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>
                                        </div>
                                    </div>
                                </div>
                                <!-- /tab2  -->

                                <!-- tab3  -->
                                <div id="tab3" class="tab-pane fade in">
                                    <div class="row">
                                        <!-- Rating -->
                                        <div class="col-md-3">
                                            <div id="rating">
                                                <div class="rating-avg">
                                                    <span><fmt:formatNumber value="${averageRating}" minFractionDigits="1" maxFractionDigits="1"/></span>
                                                    <div class="rating-stars">
                                                        <c:set var="avgTab" value="${averageRating}" />
                                                        <c:forEach begin="1" end="5" var="i">
                                                            <c:choose>
                                                                <c:when test="${avgTab >= i}">
                                                                    <i class="fa fa-star"></i>
                                                                </c:when>
                                                                <c:when test="${avgTab >= i - 0.5}">
                                                                    <i class="fa fa-star-half-o"></i>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <i class="fa fa-star-o"></i>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </c:forEach>
                                                    </div>
                                                </div>
                                                <p style="margin-top:10px;">
                                                    Dựa trên <strong><c:out value="${reviewCount != null ? reviewCount : 0}" /></strong> đánh giá
                                                </p>
                                                <ul class="rating" style="margin-top:10px;">
                                                    <c:set var="rc" value="${reviewCount != null ? reviewCount : 0}"/>
                                                    <li>
                                                        <div class="rating-stars">
                                                            <i class="fa fa-star"></i>
                                                            <i class="fa fa-star"></i>
                                                            <i class="fa fa-star"></i>
                                                            <i class="fa fa-star"></i>
                                                            <i class="fa fa-star"></i>
                                                        </div>
                                                        <div class="rating-progress">
                                                            <div style="width:<c:out value='${rc > 0 ? (ratingBreakdown.star5 * 100 / rc) : 0}'/>%;"></div>
                                                        </div>
                                                        <span class="sum">${ratingBreakdown.star5}</span>
                                                    </li>
                                                    <li>
                                                        <div class="rating-stars">
                                                            <i class="fa fa-star"></i>
                                                            <i class="fa fa-star"></i>
                                                            <i class="fa fa-star"></i>
                                                            <i class="fa fa-star"></i>
                                                            <i class="fa fa-star-o"></i>
                                                        </div>
                                                        <div class="rating-progress">
                                                            <div style="width:<c:out value='${rc > 0 ? (ratingBreakdown.star4 * 100 / rc) : 0}'/>%;"></div>
                                                        </div>
                                                        <span class="sum">${ratingBreakdown.star4}</span>
                                                    </li>
                                                    <li>
                                                        <div class="rating-stars">
                                                            <i class="fa fa-star"></i>
                                                            <i class="fa fa-star"></i>
                                                            <i class="fa fa-star"></i>
                                                            <i class="fa fa-star-o"></i>
                                                            <i class="fa fa-star-o"></i>
                                                        </div>
                                                        <div class="rating-progress">
                                                            <div style="width:<c:out value='${rc > 0 ? (ratingBreakdown.star3 * 100 / rc) : 0}'/>%;"></div>
                                                        </div>
                                                        <span class="sum">${ratingBreakdown.star3}</span>
                                                    </li>
                                                    <li>
                                                        <div class="rating-stars">
                                                            <i class="fa fa-star"></i>
                                                            <i class="fa fa-star"></i>
                                                            <i class="fa fa-star-o"></i>
                                                            <i class="fa fa-star-o"></i>
                                                            <i class="fa fa-star-o"></i>
                                                        </div>
                                                        <div class="rating-progress">
                                                            <div style="width:<c:out value='${rc > 0 ? (ratingBreakdown.star2 * 100 / rc) : 0}'/>%;"></div>
                                                        </div>
                                                        <span class="sum">${ratingBreakdown.star2}</span>
                                                    </li>
                                                    <li>
                                                        <div class="rating-stars">
                                                            <i class="fa fa-star"></i>
                                                            <i class="fa fa-star-o"></i>
                                                            <i class="fa fa-star-o"></i>
                                                            <i class="fa fa-star-o"></i>
                                                            <i class="fa fa-star-o"></i>
                                                        </div>
                                                        <div class="rating-progress">
                                                            <div style="width:<c:out value='${rc > 0 ? (ratingBreakdown.star1 * 100 / rc) : 0}'/>%;"></div>
                                                        </div>
                                                        <span class="sum">${ratingBreakdown.star1}</span>
                                                    </li>
                                                </ul>
                                            </div>
                                        </div>
                                        <!-- /Rating -->

                                        <!-- Reviews -->
                                        <div class="col-md-6">
                                            <div id="reviews">
                                                <c:if test="${not empty sessionScope.reviewMessage}">
                                                    <div class="alert alert-success">
                                                        ${sessionScope.reviewMessage}
                                                    </div>
                                                    <c:remove var="reviewMessage" scope="session"/>
                                                </c:if>
                                                <c:if test="${not empty sessionScope.reviewError}">
                                                    <div class="alert alert-danger">
                                                        ${sessionScope.reviewError}
                                                    </div>
                                                    <c:remove var="reviewError" scope="session"/>
                                                </c:if>

                                                <ul class="reviews">
                                                    <c:forEach var="r" items="${reviews}">
                                                        <li>
                                                            <div class="review-heading">
                                                                <h5 class="name">
                                                                    <c:choose>
                                                                        <c:when test="${r.userName.startsWith('@')}">
                                                                            <span style="color: #007bff; font-weight: 600;">${r.userName}</span>
                                                                        </c:when>
                                                                        <c:otherwise>
                                                                            ${r.userName}
                                                                        </c:otherwise>
                                                                    </c:choose>
                                                                </h5>
                                                                <p class="date">
                                                                    <fmt:formatDate value="${r.createdAt}" pattern="dd/MM/yyyy HH:mm"/>
                                                                </p>
                                                                <div class="review-rating">
                                                                    <c:forEach begin="1" end="5" var="i">
                                                                        <c:choose>
                                                                            <c:when test="${r.rating >= i}">
                                                                                <i class="fa fa-star"></i>
                                                                            </c:when>
                                                                            <c:otherwise>
                                                                                <i class="fa fa-star-o empty"></i>
                                                                            </c:otherwise>
                                                                        </c:choose>
                                                                    </c:forEach>
                                                                </div>
                                                            </div>
                                                            <div class="review-body">
                                                                <p>${r.comment}</p>
                                                            </div>
                                                        </li>
                                                    </c:forEach>

                                                    <c:if test="${empty reviews}">
                                                        <li>
                                                            <div class="review-body">
                                                                <p>Chưa có đánh giá nào cho sản phẩm này. Hãy là người đầu tiên!</p>
                                                            </div>
                                                        </li>
                                                    </c:if>
                                                </ul>
                                            </div>
                                        </div>
                                        <!-- /Reviews -->

                                        <!-- Review Form -->
                                        <div class="col-md-3">
                                            <div id="review-form">
                                                <c:choose>
                                                    <c:when test="${empty sessionScope.user}">
                                                        <p>Bạn cần <a href="${pageContext.request.contextPath}/login?redirect=productdetail%3Fid%3D${product.productId}">đăng nhập</a> để gửi đánh giá.</p>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <c:choose>
                                                            <c:when test="${canReview}">
                                                                <form class="review-form" action="${pageContext.request.contextPath}/review" method="post">
                                                                    <input type="hidden" name="productId" value="${product.productId}"/>
                                                                    <textarea class="input" name="comment" placeholder="Nhận xét của bạn" required></textarea>
                                                                    <div class="input-rating">
                                                                        <span>Your Rating: </span>
                                                                        <div class="stars">
                                                                            <input id="star5" name="rating" value="5" type="radio" checked><label for="star5"></label>
                                                                            <input id="star4" name="rating" value="4" type="radio"><label for="star4"></label>
                                                                            <input id="star3" name="rating" value="3" type="radio"><label for="star3"></label>
                                                                            <input id="star2" name="rating" value="2" type="radio"><label for="star2"></label>
                                                                            <input id="star1" name="rating" value="1" type="radio"><label for="star1"></label>
                                                                        </div>
                                                                    </div>
                                                                    <button class="primary-btn" type="submit">Gửi đánh giá</button>
                                                                </form>
                                                            </c:when>
                                                            <c:when test="${hasReviewed}">
                                                                <p>Bạn đã đánh giá sản phẩm này rồi.</p>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <p>Bạn chỉ có thể đánh giá khi đã mua sản phẩm này.</p>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                        </div>
                                        <!-- /Review Form -->
                                    </div>
                                </div>
                                <!-- /tab3  -->
                            </div>
                            <!-- /product tab content  -->
                        </div>
                    </div>
                    <!-- /product tab -->
                </div>
                <!-- /row -->
            </div>
            <!-- /container -->
        </div>
        <!-- /SECTION -->

        <!-- Section -->
        <div class="section">
            <!-- container -->
            <div class="container">
                <!-- row -->
                <div class="row">

                    <div class="col-md-12">
                        <div class="section-title text-center">
                            <h3 class="title">Related Products</h3>
                        </div>
                    </div>

                    <c:forEach var="rp" items="${relatedProducts}" varStatus="st">
                        <c:if test="${st.index == 2}"><div class="clearfix visible-sm visible-xs"></div></c:if>
                            <!-- product -->
                            <div class="col-md-3 col-xs-6">
                                <div class="product">
                                    <div class="product-img">
                                    <c:choose>
                                        <c:when test="${not empty rp.images}">
                                            <img src="${pageContext.request.contextPath}/${rp.images}" alt="${rp.name}"
                                                 onerror="this.src='${pageContext.request.contextPath}/img/product01.png'">
                                        </c:when>
                                        <c:otherwise>
                                            <img src="${pageContext.request.contextPath}/img/product01.png" alt="${rp.name}">
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                                <div class="product-body">
                                    <h3 class="product-name"><a href="${pageContext.request.contextPath}/productdetail?id=${rp.productId}">${rp.name}</a></h3>
                                    <h4 class="product-price"><fmt:formatNumber value="${rp.price}" type="number" groupingUsed="true"/>đ</h4>
                                    <div class="product-btns">
                                        <button class="add-to-wishlist"><i class="fa fa-heart-o"></i><span class="tooltipp">add to wishlist</span></button>
                                        <button class="add-to-compare"><i class="fa fa-exchange"></i><span class="tooltipp">add to compare</span></button>
                                        <button class="quick-view" type="button" onclick="window.location.href = '${pageContext.request.contextPath}/productdetail?id=${rp.productId}'"><i class="fa fa-eye"></i><span class="tooltipp">quick view</span></button>
                                    </div>
                                </div>
                                <div class="add-to-cart">
                                    <button class="add-to-cart-btn" onclick="window.location.href = '${pageContext.request.contextPath}/productdetail?id=${rp.productId}'"><i class="fa fa-shopping-cart"></i> Xem chi tiết</button>
                                </div>
                            </div>
                        </div>
                        <!-- /product -->
                    </c:forEach>

                </div>
                <!-- /row -->
            </div>
            <!-- /container -->
        </div>
        <!-- /Section -->

        <!-- NEWSLETTER -->
        <div id="newsletter" class="section">
            <!-- container -->
            <div class="container">
                <!-- row -->
                <div class="row">
                    <div class="col-md-12">
                        <div class="newsletter">
                            <p>Sign Up for the <strong>NEWSLETTER</strong></p>
                            <form>
                                <input class="input" type="email" placeholder="Enter Your Email">
                                <button class="newsletter-btn"><i class="fa fa-envelope"></i> Subscribe</button>
                            </form>
                            <ul class="newsletter-follow">
                                <li>
                                    <a href="#"><i class="fa fa-facebook"></i></a>
                                </li>
                                <li>
                                    <a href="#"><i class="fa fa-twitter"></i></a>
                                </li>
                                <li>
                                    <a href="#"><i class="fa fa-instagram"></i></a>
                                </li>
                                <li>
                                    <a href="#"><i class="fa fa-pinterest"></i></a>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
                <!-- /row -->
            </div>
            <!-- /container -->
        </div>
        <!-- /NEWSLETTER -->

        <!-- FOOTER -->
        <footer id="footer">
            <!-- top footer -->
            <div class="section">
                <!-- container -->
                <div class="container">
                    <!-- row -->
                    <div class="row">
                        <div class="col-md-3 col-xs-6">
                            <div class="footer">
                                <h3 class="footer-title">About Us</h3>
                                <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut.</p>
                                <ul class="footer-links">
                                    <li><a href="#"><i class="fa fa-map-marker"></i>1734 Stonecoal Road</a></li>
                                    <li><a href="#"><i class="fa fa-phone"></i>+021-95-51-84</a></li>
                                    <li><a href="#"><i class="fa fa-envelope-o"></i>email@email.com</a></li>
                                </ul>
                            </div>
                        </div>

                        <div class="col-md-3 col-xs-6">
                            <div class="footer">
                                <h3 class="footer-title">Categories</h3>
                                <ul class="footer-links">
                                    <li><a href="#">Hot deals</a></li>
                                    <li><a href="#">Laptops</a></li>
                                    <li><a href="#">Smartphones</a></li>
                                    <li><a href="#">Cameras</a></li>
                                    <li><a href="#">Accessories</a></li>
                                </ul>
                            </div>
                        </div>

                        <div class="clearfix visible-xs"></div>

                        <div class="col-md-3 col-xs-6">
                            <div class="footer">
                                <h3 class="footer-title">Information</h3>
                                <ul class="footer-links">
                                    <li><a href="#">About Us</a></li>
                                    <li><a href="#">Contact Us</a></li>
                                    <li><a href="#">Privacy Policy</a></li>
                                    <li><a href="#">Orders and Returns</a></li>
                                    <li><a href="#">Terms & Conditions</a></li>
                                </ul>
                            </div>
                        </div>

                        <div class="col-md-3 col-xs-6">
                            <div class="footer">
                                <h3 class="footer-title">Service</h3>
                                <ul class="footer-links">
                                    <li><a href="${pageContext.request.contextPath}/login?redirect=productdetail%3Fid%3D${product.productId}">My Account</a></li>
                                    <li><a href="${pageContext.request.contextPath}/cart">View Cart</a></li>
                                    <li><a href="#">Wishlist</a></li>
                                    <li><a href="#">Track My Order</a></li>
                                    <li><a href="#">Help</a></li>
                                </ul>
                            </div>
                        </div>
                    </div>
                    <!-- /row -->
                </div>
                <!-- /container -->
            </div>
            <!-- /top footer -->

            <!-- bottom footer -->
            <div id="bottom-footer" class="section">
                <div class="container">
                    <!-- row -->
                    <div class="row">
                        <div class="col-md-12 text-center">
                            <ul class="footer-payments">
                                <li><a href="#"><i class="fa fa-cc-visa"></i></a></li>
                                <li><a href="#"><i class="fa fa-credit-card"></i></a></li>
                                <li><a href="#"><i class="fa fa-cc-paypal"></i></a></li>
                                <li><a href="#"><i class="fa fa-cc-mastercard"></i></a></li>
                                <li><a href="#"><i class="fa fa-cc-discover"></i></a></li>
                                <li><a href="#"><i class="fa fa-cc-amex"></i></a></li>
                            </ul>
                            <span class="copyright">
                                <!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
                                Copyright &copy;<script>document.write(new Date().getFullYear());</script> All rights reserved | This template is made with <i class="fa fa-heart-o" aria-hidden="true"></i> by <a href="https://colorlib.com" target="_blank">Colorlib</a>
                                <!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
                            </span>
                        </div>
                    </div>
                    <!-- /row -->
                </div>
                <!-- /container -->
            </div>
            <!-- /bottom footer -->
        </footer>
        <!-- /FOOTER -->

        <!-- jQuery Plugins -->
        <script src="js/jquery.min.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <script src="js/slick.min.js"></script>
        <script src="js/nouislider.min.js"></script>
        <script src="js/jquery.zoom.min.js"></script>
        <script src="js/main.js"></script>
        <script>
                                    function changeDetailQty(delta) {
                                        var input = document.getElementById('detail-qty');
                                        if (!input)
                                            return;
                                        var current = parseInt(input.value || '1', 10);
                                        var min = parseInt(input.min || '1', 10);
                                        var max = parseInt(input.max || '99', 10);
                                        var next = current + delta;
                                        if (next < min)
                                            next = min;
                                        if (next > max)
                                            next = max;
                                        input.value = next;
                                    }
                                    function addDetailToCart(productId) {
                                        var qtyInput = document.getElementById('detail-qty');
                                        var qty = qtyInput ? parseInt(qtyInput.value || '1', 10) : 1;
                                        if (qty < 1)
                                            qty = 1;
                                        var ctx = '${pageContext.request.contextPath}';
                                        var url = ctx + '/addtocart?productId=' + productId + '&qty=' + qty + '&ajax=1';
                                        var xhr = new XMLHttpRequest();
                                        xhr.open('GET', url, true);
                                        xhr.setRequestHeader('X-Requested-With', 'XMLHttpRequest');
                                        xhr.onreadystatechange = function () {
                                            if (xhr.readyState === 4) {
                                                try {
                                                    var data = JSON.parse(xhr.responseText || '{}');
                                                    if (data.success) {
                                                        var toast = document.getElementById('cart-toast');
                                                        if (toast) {
                                                            toast.classList.add('show');
                                                            setTimeout(function () {
                                                                toast.classList.remove('show');
                                                            }, 2500);
                                                        }
                                                        var countEl = document.getElementById('header-cart-count');
                                                        if (countEl && data.cartCount != null)
                                                            countEl.textContent = data.cartCount;
                                                    } else {
                                                        alert('Không thể thêm vào giỏ. Vui lòng đăng nhập.');
                                                    }
                                                } catch (e) {
                                                    alert('Đã thêm vào giỏ hàng!');
                                                }
                                            }
                                        };
                                        xhr.send();
                                    }
        </script>

        <!-- Back to Home Button -->
        <div style="text-align: center; margin-top: 40px; padding: 20px;">
            <a href="home" 
               style="display: inline-flex; align-items: center; gap: 8px; padding: 12px 24px; background: linear-gradient(135deg, #667eea, #764ba2); color: white; text-decoration: none; border-radius: 8px; font-weight: 600; transition: all 0.3s ease;"
               onmouseover="this.style.transform='translateY(-2px)'; this.style.boxShadow='0 4px 20px rgba(102, 126, 234, 0.3)'"
               onmouseout="this.style.transform='translateY(0)'; this.style.boxShadow='none'">
                <i class="fa fa-home"></i>
                Về trang chủ
            </a>
        </div>

    </body>
</html>

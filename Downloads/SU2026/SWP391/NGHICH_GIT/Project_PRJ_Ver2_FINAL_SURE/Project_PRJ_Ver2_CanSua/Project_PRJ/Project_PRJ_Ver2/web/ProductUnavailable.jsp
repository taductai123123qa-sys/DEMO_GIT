<%-- 
    Sản phẩm không còn bán - hiển thị khi user truy cập sản phẩm INACTIVE
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Sản phẩm không còn bán - Electro</title>
    <link href="https://fonts.googleapis.com/css?family=Montserrat:400,500,700" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/font-awesome.min.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css"/>
    <style>
        .unavailable-box {
            max-width: 560px;
            margin: 80px auto;
            padding: 48px 40px;
            background: #fff;
            border-radius: 8px;
            box-shadow: 0 4px 20px rgba(0,0,0,.08);
            text-align: center;
        }
        .unavailable-box i {
            font-size: 64px;
            color: #D10024;
            margin-bottom: 20px;
        }
        .unavailable-box h2 {
            font-size: 22px;
            font-weight: 700;
            color: #333;
            margin-bottom: 12px;
        }
        .unavailable-box p {
            font-size: 15px;
            color: #666;
            line-height: 1.6;
            margin-bottom: 24px;
        }
    </style>
</head>
<body>
    <div class="container" style="padding-top:40px;">
        <a href="${pageContext.request.contextPath}/home" class="btn btn-outline-secondary btn-sm mb-3">&laquo; Về trang chủ</a>
        <div class="unavailable-box">
            <i class="fa fa-exclamation-circle"></i>
            <h2>Sản phẩm không còn bán</h2>
            <p>Xin lỗi quý khách, hiện nay trang web không còn bán sản phẩm này.</p>
            <a href="${pageContext.request.contextPath}/home" class="btn btn-primary">Tiếp tục mua sắm</a>
        </div>
    </div>
</body>
</html>

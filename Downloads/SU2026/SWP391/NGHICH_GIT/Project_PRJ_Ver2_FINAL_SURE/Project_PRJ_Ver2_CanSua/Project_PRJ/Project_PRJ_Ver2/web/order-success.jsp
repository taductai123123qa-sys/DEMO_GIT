<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Đặt hàng thành công</title>
        <link rel="stylesheet" href="css/bootstrap.min.css"/>
    </head>
    <body class="bg-light">
        <div class="container" style="max-width:700px;margin-top:60px;">
            <div class="card shadow-sm">
                <div class="card-body text-center">
                    <h3 class="card-title mb-3">Cảm ơn bạn đã đặt hàng!</h3>
                    <p class="text-muted">Mã đơn hàng của bạn là <strong>#${orderId}</strong>.</p>
                    <p class="mb-4">Bạn có thể xem lại chi tiết tại trang lịch sử đơn hàng.</p>
                    <a href="orderhistory" class="btn btn-primary me-2">Xem lịch sử đơn</a>
                    <a href="home" class="btn btn-outline-secondary">Tiếp tục mua sắm</a>
                </div>
            </div>
        </div>
    </body>
</html>


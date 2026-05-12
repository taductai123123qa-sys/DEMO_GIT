<%-- 
Hiển thị giỏ hàng
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Giỏ hàng - Electro</title>
        <link rel="stylesheet" href="css/bootstrap.min.css"/>
        <link rel="stylesheet" href="css/font-awesome.min.css">
        <style>
            body{font-family:'Montserrat',sans-serif;background:#f5f5f5;}
            .container{max-width:1200px;margin:30px auto;}
            .cart-table{width:100%;background:#fff;border-collapse:collapse;}
            .cart-table th,.cart-table td{padding:12px;border-bottom:1px solid #eee;font-size:13px;}
            .cart-table th{background:#111827;color:#fff;text-transform:uppercase;font-size:11px;letter-spacing:1px;}
            .cart-img{width:72px;}
            .cart-actions button{border:none;background:none;color:#D10024;cursor:pointer;}
            .summary{margin-top:20px;background:#fff;padding:18px;border:1px solid #eee;}
            .summary-row{display:flex;justify-content:space-between;margin-bottom:6px;font-size:13px;}
            .summary-total{font-weight:700;font-size:15px;color:#D10024;}
            .btn-primary{background:#D10024;color:#fff;border:none;padding:10px 20px;font-size:13px;font-weight:700;text-transform:uppercase;}
            .empty{text-align:center;background:#fff;padding:60px 20px;}
            .qty-control{display:flex;align-items:center;gap:0;border:1px solid #ddd;border-radius:4px;overflow:hidden;}
            .qty-btn{width:32px;height:32px;border:none;background:#f0f0f0;cursor:pointer;font-size:16px;display:flex;align-items:center;justify-content:center;padding:0;}
            .qty-btn:hover{background:#e0e0e0;}
            .qty-input{border:none;border-left:1px solid #ddd;border-right:1px solid #ddd;width:45px;text-align:center;font-size:14px;-moz-appearance:textfield;}
            .qty-input::-webkit-outer-spin-button,.qty-input::-webkit-inner-spin-button{-webkit-appearance:none;margin:0;}
        </style>
    </head>
    <body>
        <div class="container">
            <h3>Giỏ hàng</h3>
            <c:choose>
                <c:when test="${cart != null && not empty cart.items}">
                    <table class="cart-table">
                        <thead>
                            <tr>
                                <th style="width:40px;"><input type="checkbox" id="selectAll" checked></th>
                                <th>Sản phẩm</th>
                                <th>Đơn giá</th>
                                <th>Số lượng</th>
                                <th>Thành tiền</th>
                                <th></th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="item" items="${cart.items}">
                                <tr data-product-id="${item.product.productId}" data-unit-price="${item.product.price}" data-stock="${item.product.stock}">
                                    <td><input type="checkbox" class="item-checkbox" value="${item.product.productId}" checked></td>
                                    <td>
                                        <div style="display:flex;align-items:center;gap:10px;">
                                            <img class="cart-img" src="${pageContext.request.contextPath}/${item.product.images}" onerror="this.src='${pageContext.request.contextPath}/img/product01.png'">
                                            <div>${item.product.name}</div>
                                        </div>
                                    </td>
                                    <td>
                                        <fmt:formatNumber value="${item.product.price}" type="number" groupingUsed="true"/>đ
                                    </td>
                                    <td>
                                        <form action="cart" method="post" class="qty-form" style="display:inline-block;">
                                            <input type="hidden" name="action" value="update">
                                            <input type="hidden" name="productId" value="${item.product.productId}">
                                            <input type="hidden" name="quantity" class="qty-hidden">
                                            <div class="qty-control">
                                                <button type="button" class="qty-btn qty-minus" aria-label="Giảm">−</button>
                                                <input type="text" class="qty-input" value="${item.quantity}" readonly>
                                                <button type="button" class="qty-btn qty-plus" aria-label="Tăng">+</button>
                                            </div>
                                        </form>
                                    </td>
                                    <td class="item-total">
                                        <fmt:formatNumber value="${item.totalPrice}" type="number" groupingUsed="true"/>đ
                                    </td>
                                    <td class="cart-actions">
                                        <form action="cart" method="post" style="display:inline;">
                                            <input type="hidden" name="action" value="remove">
                                            <input type="hidden" name="productId" value="${item.product.productId}">
                                            <button type="submit"><i class="fa fa-trash"></i></button>
                                        </form>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>

                    <div class="summary">
                        <div class="summary-row">
                            <span>Tổng số lượng:</span>
                            <span id="summary-qty">${cart.totalQuantity}</span>
                        </div>
                        <div class="summary-row summary-total">
                            <span>Tổng tiền:</span>
                            <span id="summary-total"><fmt:formatNumber value="${cart.totalAmount}" type="number" groupingUsed="true"/>đ</span>
                        </div>
                        <div style="margin-top:15px;display:flex;gap:10px;justify-content:flex-end;">
                            <a href="home" class="btn btn-light">Tiếp tục mua hàng</a>
                            <button type="button" id="btnCheckout" class="btn-primary">Thanh toán</button>
                        </div>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="empty">
                        <i class="fa fa-shopping-cart" style="font-size:40px;color:#ddd;"></i>
                        <h4>Giỏ hàng của bạn đang trống</h4>
                        <p>Hãy chọn vài sản phẩm ở trang chủ nhé.</p>
                        <a href="home" class="btn-primary" style="margin-top:15px;display:inline-block;">Về trang chủ</a>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
        <script>
(function(){
    var qtyForms = document.querySelectorAll('.qty-form');
    qtyForms.forEach(function(form){
        var row = form.closest('tr');
        var qtyInput = form.querySelector('.qty-input');
        var qtyHidden = form.querySelector('.qty-hidden');
        var stock = parseInt(row.dataset.stock) || 9999;
        var minusBtn = form.querySelector('.qty-minus');
        var plusBtn = form.querySelector('.qty-plus');
        function submitQty(q){
            q = Math.max(1, Math.min(q, stock));
            qtyHidden.value = q;
            qtyInput.value = q;
            form.submit();
        }
        minusBtn.addEventListener('click', function(){ submitQty(parseInt(qtyInput.value) - 1); });
        plusBtn.addEventListener('click', function(){ submitQty(parseInt(qtyInput.value) + 1); });
    });

    function formatNum(n){ return n.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ','); }
    function updateSummary(){
        var totalQty = 0, totalMoney = 0;
        document.querySelectorAll('.item-checkbox:checked').forEach(function(cb){
            var row = cb.closest('tr');
            var qty = parseInt(row.querySelector('.qty-input').value) || 0;
            var price = parseFloat(row.dataset.unitPrice) || 0;
            totalQty += qty;
            totalMoney += qty * price;
        });
        var sq = document.getElementById('summary-qty');
        var st = document.getElementById('summary-total');
        if(sq) sq.textContent = totalQty;
        if(st) st.textContent = formatNum(Math.round(totalMoney)) + 'đ';
    }

    var selectAll = document.getElementById('selectAll');
    var itemCbs = document.querySelectorAll('.item-checkbox');
    if(selectAll){
        selectAll.addEventListener('change', function(){
            itemCbs.forEach(function(cb){ cb.checked = selectAll.checked; });
            updateSummary();
        });
    }
    itemCbs.forEach(function(cb){
        cb.addEventListener('change', function(){
            var checked = document.querySelectorAll('.item-checkbox:checked').length;
            if(selectAll) selectAll.checked = (checked === itemCbs.length);
            updateSummary();
        });
    });
    updateSummary();

    var btnCheckout = document.getElementById('btnCheckout');
    if(btnCheckout){
        btnCheckout.addEventListener('click', function(){
            var ids = [];
            document.querySelectorAll('.item-checkbox:checked').forEach(function(cb){ ids.push(cb.value); });
            if(ids.length === 0){ alert('Vui lòng chọn ít nhất một sản phẩm để thanh toán.'); return; }
            window.location = 'checkout?selected=' + ids.join(',');
        });
    }
})();
        </script>
    </body>
</html>

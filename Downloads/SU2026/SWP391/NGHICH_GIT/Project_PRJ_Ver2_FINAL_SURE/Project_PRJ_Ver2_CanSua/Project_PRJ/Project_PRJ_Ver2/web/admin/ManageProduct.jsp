<%-- 
Trang CRUD sản phẩm
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="curSort" value="${empty curSort ? 'created_desc' : curSort}"/>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Quản lý sản phẩm</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css"/>
        <style>
            body{
                background:#f5f6fa;
                font-family:Arial,Helvetica,sans-serif;
            }
            .page-wrapper{
                max-width:1200px;
                margin:30px auto;
                background:#fff;
                border-radius:8px;
                box-shadow:0 2px 10px rgba(0,0,0,.06);
                padding:24px 28px;
            }
            .page-header{
                display:flex;
                justify-content:space-between;
                align-items:center;
                margin-bottom:18px;
            }
            .badge-status{
                padding:3px 9px;
                border-radius:999px;
                font-size:11px;
                font-weight:600;
            }
            .badge-active{
                background:#e6ffed;
                color:#1a7f37;
                border:1px solid #a6f3b3;
            }
            .badge-inactive{
                background:#fff5e6;
                color:#b25e09;
                border:1px solid #ffd19b;
            }
            table th,table td{
                font-size:12px;
                vertical-align:middle!important;
            }
            .btn-xs{
                padding:3px 7px;
                font-size:11px;
            }
            .form-card{
                background:#f8f9fb;
                border-radius:6px;
                padding:16px 18px;
                margin-bottom:20px;
                border:1px solid #e1e5ee;
            }
            .form-card .form-mota{
                margin-top:0.5rem;
            }
            .form-card .form-mota .form-label{
                margin-bottom:0.25rem;
            }
            .search-sort-container {
                background:#f8f9fb;
                border-radius:6px;
                padding:16px;
                margin-bottom:20px;
                border:1px solid #e1e5ee;
            }
        </style>
    </head>
    <body>
        <div class="page-wrapper">
            <div class="page-header">
                <div>
                    <h3 style="margin:0;">Quản lý sản phẩm</h3>
                    <small class="text-muted">Thêm / sửa / ẩn hiện sản phẩm</small>
                </div>
                <a href="${pageContext.request.contextPath}/admindashboard" class="btn btn-outline-secondary btn-sm">
                    &​laquo; Về Dashboard
                </a>
            </div>

            <c:if test="${not empty message}">
                <div class="alert alert-success alert-sm">${message}</div>
            </c:if>
            <c:if test="${not empty error}">
                <div class="alert alert-danger alert-sm">${error}</div>
            </c:if>

            <div class="form-card">
                <h6 style="font-weight:700;margin-bottom:12px;">
                    <c:choose>
                        <c:when test="${not empty editingProduct}">Sửa sản phẩm</c:when>
                        <c:otherwise>Thêm sản phẩm mới</c:otherwise>
                    </c:choose>
                </h6>
                <form action="${pageContext.request.contextPath}/manageproduct" method="post"
                      enctype="multipart/form-data">
                    <input type="hidden" name="action" value="save"/>
                    <input type="hidden" name="productId" value="${editingProduct.productId}"/>
                    <input type="hidden" name="sort" value="${curSort}"/>
                    <input type="hidden" name="keyword" value="${curKeyword}"/>

                    <div class="row g-2">
                        <div class="col-md-4">
                            <label class="form-label d-block">Tên sản phẩm</label>
                            <input type="text" name="name" class="form-control form-control-sm"
                                   value="${editingProduct.name}" required>
                        </div>
                        <div class="col-md-2">
                            <label class="form-label d-block">Giá (VND)</label>
                            <input type="number" name="price" class="form-control form-control-sm"
                                   value="${editingProduct.price}" min="0" step="1000" required>
                        </div>
                        <div class="col-md-2">
                            <label class="form-label d-block">Tồn kho</label>
                            <input type="number" name="stock" class="form-control form-control-sm"
                                   value="${editingProduct.stock}" min="0" required>
                        </div>
                        <div class="col-md-2" style="display:flex;flex-direction:column;">
                            <label class="form-label">Category</label>
                            <select name="categoryId" class="form-select form-select-sm w-100" required>
                                <option value="">--Chọn--</option>
                                <c:forEach var="c" items="${categories}">
                                    <option value="${c.categoryId}"
                                            ${editingProduct.categoryId == c.categoryId ? 'selected' : ''}>
                                        ${c.name}
                                    </option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="col-md-2" style="display:flex;flex-direction:column;">
                            <label class="form-label">Brand</label>
                            <select name="brandId" class="form-select form-select-sm w-100" required>
                                <option value="">--Chọn--</option>
                                <c:forEach var="b" items="${brands}">
                                    <option value="${b.brandId}"
                                            ${editingProduct.brandId == b.brandId ? 'selected' : ''}>
                                        ${b.name}
                                    </option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>

                    <div class="row g-2 mt-2">
                        <div class="col-md-6">
                            <label class="form-label d-block">Link ảnh chính</label>
                            <input type="text" name="images" class="form-control form-control-sm"
                                   value="${editingProduct.images}">
                            <small class="text-muted d-block">Ví dụ: images/products/product_01.jpg</small>
                            <small class="text-muted">Hoặc tải ảnh mới bên dưới, hệ thống sẽ tự cập nhật đường dẫn.</small>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label d-block">Upload ảnh</label>
                            <input type="file" name="imageFile" accept="image/*" class="form-control form-control-sm">
                            <small class="text-muted">Nên dùng ảnh JPG/PNG kích thước vừa phải.</small>
                        </div>
                    </div>

                    <div class="row g-2 mt-2">
                        <div class="col-md-6">
                            <label class="form-label d-block">Trạng thái</label>
                            <select name="status" class="form-select form-select-sm">
                                <option value="ACTIVE" ${editingProduct.status == 'ACTIVE' ? 'selected' : ''}>ACTIVE</option>
                                <option value="INACTIVE" ${editingProduct.status == 'INACTIVE' ? 'selected' : ''}>INACTIVE</option>
                            </select>
                        </div>
                    </div>

                    <div class="form-mota mt-2">
                        <label class="form-label">Mô tả</label>
                        <textarea name="description" rows="2" class="form-control form-control-sm w-100">${editingProduct.description}</textarea>
                    </div>

                    <div class="row mt-3">
                        <div class="col-12 d-flex justify-content-end gap-2">
                            <a href="${pageContext.request.contextPath}/manageproduct" class="btn btn-outline-secondary btn-sm">
                                Hủy
                            </a>
                            <button type="submit" class="btn btn-primary btn-sm">
                                <c:choose>
                                    <c:when test="${not empty editingProduct}">Cập nhật</c:when>
                                    <c:otherwise>Thêm mới</c:otherwise>
                                </c:choose>
                            </button>
                        </div>
                    </div>
                </form>
            </div>

            <!-- SEARCH AND SORT SECTION -->
            <div class="search-sort-container">
                <div class="row align-items-center">
                    <div class="col-md-6">
                        <form action="${pageContext.request.contextPath}/manageproduct" method="get" class="d-flex gap-2">
                            <input type="text" name="keyword" class="form-control form-control-sm" 
                                   placeholder="Tìm kiếm sản phẩm..." 
                                   value="${curKeyword != null ? curKeyword : ''}" 
                                   style="width: 200px;">
                            <input type="hidden" name="sort" value="${curSort}"/>
                            <button type="submit" class="btn btn-outline-primary btn-sm">
                                <i class="fa fa-search"></i> Tìm
                            </button>
                        </form>
                    </div>
                    <div class="col-md-6">
                        <div class="d-flex align-items-center gap-2 justify-content-end">
                            <label class="mb-0 small text-muted">Sắp xếp:</label>
                            <select class="form-select form-select-sm" style="width:auto;" 
                                    onchange="location.href='${pageContext.request.contextPath}/manageproduct?sort='+this.value+'&keyword=${curKeyword != null ? curKeyword : ''}'">
                                <option value="id_asc" ${curSort == 'id_asc' ? 'selected' : ''}>ID tăng dần</option>
                                <option value="id_desc" ${curSort == 'id_desc' ? 'selected' : ''}>ID giảm dần</option>
                                <option value="created_desc" ${curSort == 'created_desc' ? 'selected' : ''}>Mới thêm trước</option>
                                <option value="created_asc" ${curSort == 'created_asc' ? 'selected' : ''}>Cũ nhất trước</option>
                                <option value="price_asc" ${curSort == 'price_asc' ? 'selected' : ''}>Giá tăng dần</option>
                                <option value="price_desc" ${curSort == 'price_desc' ? 'selected' : ''}>Giá giảm dần</option>
                            </select>
                        </div>
                    </div>
                </div>
            </div>

            <div class="table-responsive">
                <table class="table table-sm table-hover align-middle">
                    <thead class="table-light">
                        <tr>
                            <th>ID</th>
                            <th>Tên</th>
                            <th>Giá</th>
                            <th>Tồn kho</th>
                            <th>Đã bán</th>
                            <th>Category</th>
                            <th>Brand</th>
                            <th>Trạng thái</th>
                            <th style="width:180px;">Hành động</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="p" items="${products}">
                            <tr>
                                <td>${p.productId}</td>
                                <td>${p.name}</td>
                                <td>
                                    <fmt:formatNumber value="${p.price}" type="currency" currencySymbol="₫" groupingUsed="true"/>
                                </td>
                                <td>${p.stock}</td>
                                <td>${p.soldCount}</td>
                                <td>${p.categoryId}</td>
                                <td>${p.brandId}</td>
                                <td>
                                    <span class="badge-status ${p.status == 'ACTIVE' ? 'badge-active' : 'badge-inactive'}">
                                        ${p.status}
                                    </span>
                                </td>
                                <td>
                                    <a href="${pageContext.request.contextPath}/manageproduct?editId=${p.productId}&sort=${curSort}&keyword=${curKeyword}"
                                       class="btn btn-outline-primary btn-xs">Sửa</a>

                                    <form action="${pageContext.request.contextPath}/manageproduct" method="post"
                                          style="display:inline-block;margin-left:4px;"
                                          onsubmit="return confirm('Xóa sản phẩm này?');">
                                        <input type="hidden" name="action" value="delete"/>
                                        <input type="hidden" name="productId" value="${p.productId}"/>
                                        <input type="hidden" name="sort" value="${curSort}"/>
                                        <input type="hidden" name="keyword" value="${curKeyword}"/>
                                        <button type="submit" class="btn btn-outline-danger btn-xs">Xóa</button>
                                    </form>

                                    <form action="${pageContext.request.contextPath}/manageproduct" method="post"
                                          style="display:inline-block;margin-left:4px;">
                                        <input type="hidden" name="action" value="toggleStatus"/>
                                        <input type="hidden" name="productId" value="${p.productId}"/>
                                        <input type="hidden" name="currentStatus" value="${p.status}"/>
                                        <input type="hidden" name="sort" value="${curSort}"/>
                                        <input type="hidden" name="keyword" value="${curKeyword}"/>
                                        <button type="submit"
                                                class="btn btn-xs ${p.status == 'ACTIVE' ? 'btn-warning' : 'btn-success'}">
                                            <c:choose>
                                                <c:when test="${p.status == 'ACTIVE'}">Ẩn</c:when>
                                                <c:otherwise>Hiện</c:otherwise>
                                            </c:choose>
                                        </button>
                                    </form>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>

        <script src="${pageContext.request.contextPath}/js/bootstrap.bundle.min.js"></script>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    </body>
</html>
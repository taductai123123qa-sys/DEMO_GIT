<%-- 
    Document   : ManageUser
    Created on : Feb 17, 2026, 9:37:28 PM
    Author     : Lecoo
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Quản lý người dùng</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css"/>
        <style>
            body{
                background:#f5f6fa;
                font-family:Arial,Helvetica,sans-serif;
            }
            .page-wrapper{
                max-width:1100px;
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
                padding:4px 10px;
                border-radius:999px;
                font-size:12px;
                font-weight:600;
            }
            .badge-active{
                background:#e6ffed;
                color:#1a7f37;
                border:1px solid #a6f3b3;
            }
            .badge-block{
                background:#ffe8e6;
                color:#b00020;
                border:1px solid #ffb1aa;
            }
            table th,table td{
                vertical-align:middle!important;
                font-size:13px;
            }
            .btn-xs{
                padding:3px 8px;
                font-size:11px;
            }
        </style>
    </head>
    <body>
        <div class="page-wrapper">
            <div class="page-header">
                <div>
                    <h3 style="margin:0;">Quản lý người dùng</h3>
                    <small class="text-muted">Phân quyền và khóa/mở khóa tài khoản</small>
                </div>
                <a href="${pageContext.request.contextPath}/admindashboard" class="btn btn-outline-secondary btn-sm">
                    &laquo; Về Dashboard
                </a>
            </div>

            <c:if test="${not empty message}">
                <div class="alert alert-success alert-sm">${message}</div>
            </c:if>
            <c:if test="${not empty error}">
                <div class="alert alert-danger alert-sm">${error}</div>
            </c:if>

            <div class="table-responsive">
                <table class="table table-sm table-hover">
                    <thead class="table-light">
                        <tr>
                            <th>ID</th>
                            <th>Họ tên</th>
                            <th>Email</th>
                            <th>Username</th>
                            <th>Vai trò</th>
                            <th>Trạng thái</th>
                            <th style="width:210px;">Hành động</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="u" items="${users}">
                            <tr>
                                <td>${u.userId}</td>
                                <td>${u.fullName}</td>
                                <td>${u.email}</td>
                                <td>${u.username}</td>
                                <td>
                                    <span class="badge ${u.role == 'ADMIN' ? 'bg-danger' : 'bg-secondary'}">
                                        ${u.role}
                                    </span>
                                </td>
                                <td>
                                    <span class="badge-status ${u.status == 'BLOCK' ? 'badge-block' : 'badge-active'}">
                                        <c:choose>
                                            <c:when test="${u.status == 'BLOCK'}">Bị khóa</c:when>
                                            <c:otherwise>Đang hoạt động</c:otherwise>
                                        </c:choose>
                                    </span>
                                </td>
                                <td>
                                    <form action="${pageContext.request.contextPath}/manageuser" method="post" style="display:inline-block;">
                                        <input type="hidden" name="userId" value="${u.userId}"/>
                                        <input type="hidden" name="action" value="toggleStatus"/>
                                        <button type="submit"
                                                class="btn btn-xs ${u.status == 'BLOCK' ? 'btn-success' : 'btn-outline-danger'}">
                                            <c:choose>
                                                <c:when test="${u.status == 'BLOCK'}">Mở khóa</c:when>
                                                <c:otherwise>Khóa tài khoản</c:otherwise>
                                            </c:choose>
                                        </button>
                                    </form>

                                    <form action="${pageContext.request.contextPath}/manageuser" method="post" style="display:inline-block;margin-left:6px;">
                                        <input type="hidden" name="userId" value="${u.userId}"/>
                                        <input type="hidden" name="action" value="toggleRole"/>
                                        <button type="submit"
                                                class="btn btn-xs ${u.role == 'ADMIN' ? 'btn-outline-secondary' : 'btn-warning'}">
                                            <c:choose>
                                                <c:when test="${u.role == 'ADMIN'}">Chuyển USER</c:when>
                                                <c:otherwise>Set ADMIN</c:otherwise>
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
    </body>
</html>

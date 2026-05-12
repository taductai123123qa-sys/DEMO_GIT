<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.*"%>
<%@page import="dal.ProductDAO"%>
<%@page import="dal.UserDAO"%>
<%@page import="model.Product"%>
<%@page import="model.User"%>
<!DOCTYPE html>
<html>
<head>
    <title>Test DB</title>
    <style>
        body { font-family: Arial; padding: 20px; }
        table { border-collapse: collapse; width: 100%; margin-bottom: 30px; }
        th, td { border: 1px solid #ddd; padding: 8px; font-size: 12px; }
        th { background: #16213e; color: white; }
        tr:nth-child(even) { background: #f5f5f5; }
        .ok   { color: green; font-weight: bold; font-size: 18px; }
        .fail { color: red;   font-weight: bold; font-size: 18px; }
    </style>
</head>
<body>
    <h2>Test Kết Nối DB</h2>

    <%
        try {
            ProductDAO dao = new ProductDAO();
            List<Product> products = dao.getNewProducts();
    %>
            <p class="ok">✅ KẾT NỐI DB THÀNH CÔNG!</p>
            <p>Số sản phẩm lấy được: <strong><%= products.size() %></strong></p>

            <h3>Danh sách Products:</h3>
            <table>
                <tr>
                    <th>ID</th>
                    <th>Tên sản phẩm</th>
                    <th>Giá</th>
                    <th>Stock</th>
                    <th>SoldCount</th>
                    <th>Status</th>
                    <th>Images</th>
                </tr>
                <%
                    for (Product p : products) {
                %>
                <tr>
                    <td><%= p.getProductId() %></td>
                    <td><%= p.getName() %></td>
                    <td><%= p.getPrice() %></td>
                    <td><%= p.getStock() %></td>
                    <td><%= p.getSoldCount() %></td>
                    <td><%= p.getStatus() %></td>
                    <td><%= p.getImages() %></td>
                </tr>
                <%
                    }
                %>
            </table>

            <h3>Test Login user1:</h3>
            <%
                UserDAO userDAO = new UserDAO();
                User user = userDAO.checkLogin("user1@shop.com", "user123");
                if (user != null) {
            %>
                <p class="ok">✅ LOGIN user1 THÀNH CÔNG! Tên: <%= user.getFullName() %></p>
            <%
                } else {
            %>
                <p class="fail">❌ LOGIN user1 THẤT BẠI!</p>
            <%
                }
            %>

    <%
        } catch (Exception e) {
    %>
        <p class="fail">❌ LỖI: <%= e.getMessage() %></p>
        <pre><%= e.toString() %></pre>
    <%
        }
    %>
</body>
</html>





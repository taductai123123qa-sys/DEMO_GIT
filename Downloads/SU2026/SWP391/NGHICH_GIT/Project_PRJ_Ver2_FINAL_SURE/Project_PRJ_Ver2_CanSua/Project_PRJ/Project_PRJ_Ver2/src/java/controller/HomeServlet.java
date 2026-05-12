/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.ProductDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import model.Product;

@WebServlet(name = "HomeServlet", urlPatterns = {"/home"})  // hỗ trợ cả / và /home
public class HomeServlet extends HttpServlet {

    private static final int PAGE_SIZE = 8;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

          // ===== 1. LẤY PARAM =====
        String category = request.getParameter("category");
        String brand    = request.getParameter("brand");
        String price    = request.getParameter("price");
        String sort     = request.getParameter("sort");
        String keyword  = request.getParameter("keyword");
        String pageStr  = request.getParameter("page");

        // ===== 2. DEFAULT VALUE =====
        if (category == null) category = "all";
        if (brand == null)    brand    = "all";
        if (price == null)    price    = "all";
        if (sort == null)     sort     = "newest";
        if (keyword == null)  keyword  = "";
        int page = (pageStr == null) ? 1 : Integer.parseInt(pageStr);

        // ===== 3. LẤY DATA =====
        ProductDAO dao = new ProductDAO();

        List<Product> products = dao.searchProducts(
                category, brand, price, sort, keyword, page, PAGE_SIZE);

        int totalProducts = dao.countProducts(
                category, brand, price, keyword);

        int totalPages = (int) Math.ceil((double) totalProducts / PAGE_SIZE);

        // ===== 4. SET ATTRIBUTE =====
        request.setAttribute("products", products);
        request.setAttribute("totalProducts", totalProducts);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("currentPage", page);

        request.setAttribute("curCat", category);
        request.setAttribute("curBrand", brand);
        request.setAttribute("curPrice", price);
        request.setAttribute("curSort", sort);
        request.setAttribute("curKw", keyword);

        // ===== 5. FORWARD =====
        request.getRequestDispatcher("HomePage.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Nếu sau này cần xử lý form POST (ví dụ tìm kiếm bằng form POST)
        // Hiện tại có thể để trống hoặc redirect về doGet
        doGet(request, response);
    }

    private String nvl(String val, String def) {
        return (val != null && !val.trim().isEmpty()) ? val.trim() : def;
    }

    @Override
    public String getServletInfo() {
        return "Home page servlet with filtering and pagination";
    }
}
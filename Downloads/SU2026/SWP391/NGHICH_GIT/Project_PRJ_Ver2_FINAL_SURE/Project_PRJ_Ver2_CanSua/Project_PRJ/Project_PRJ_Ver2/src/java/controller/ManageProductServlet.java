/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.BrandDAO;
import dal.CategoryDAO;
import dal.ProductDAO;
import java.io.File;
import java.io.IOException;
import java.math.BigDecimal;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import model.Brand;
import model.Category;
import model.Product;

@WebServlet(name = "ManageProductServlet", urlPatterns = {"/manageproduct"})
@MultipartConfig
public class ManageProductServlet extends HttpServlet {

    private final ProductDAO productDAO = new ProductDAO();
    private final CategoryDAO categoryDAO = new CategoryDAO();
    private final BrandDAO brandDAO = new BrandDAO();

//    @Override
//    protected void doGet(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//
//        String editId = request.getParameter("editId");
//        if (editId != null) {
//            try {
//                int id = Integer.parseInt(editId);
//                Product editing = productDAO.getById(id);
//                request.setAttribute("editingProduct", editing);
//            } catch (NumberFormatException ignored) {
//            }
//        }
//
//        String sort = request.getParameter("sort");
//        if (sort == null || sort.isBlank()) sort = "created_desc";
//        loadCommonData(request, sort);
//        request.setAttribute("curSort", sort);
//        request.getRequestDispatcher("/admin/ManageProduct.jsp").forward(request, response);
//    }
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String editId = request.getParameter("editId");
        String sort = request.getParameter("sort");
        String keyword = request.getParameter("keyword");

        if (sort == null || sort.isBlank()) {
            sort = "created_desc";
        }

        if (editId != null) {
            try {
                int id = Integer.parseInt(editId);
                Product editing = productDAO.getById(id);
                request.setAttribute("editingProduct", editing);
            } catch (NumberFormatException ignored) {
            }
        }

        loadCommonData(request, sort, keyword);
        request.setAttribute("curSort", sort);
        request.setAttribute("curKeyword", keyword);
        request.getRequestDispatcher("/admin/ManageProduct.jsp").forward(request, response);
    }

//    @Override
//    protected void doPost(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//
//        request.setCharacterEncoding("UTF-8");
//        String action = request.getParameter("action");
//
//        if ("save".equals(action)) {
//            handleSave(request);
//        } else if ("delete".equals(action)) {
//            handleDelete(request);
//        } else if ("toggleStatus".equals(action)) {
//            handleToggleStatus(request);
//        }
//
//        String sort = request.getParameter("sort");
//        if (sort == null || sort.isBlank()) sort = "created_desc";
//        loadCommonData(request, sort);
//        request.setAttribute("curSort", sort);
//        request.getRequestDispatcher("/admin/ManageProduct.jsp").forward(request, response);
//    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");

        String sort = request.getParameter("sort");
        String keyword = request.getParameter("keyword");

        if (sort == null || sort.isBlank()) {
            sort = "created_desc";
        }

        if ("save".equals(action)) {
            handleSave(request);
        } else if ("delete".equals(action)) {
            handleDelete(request);
        } else if ("toggleStatus".equals(action)) {
            handleToggleStatus(request);
        }

        loadCommonData(request, sort, keyword);
        request.setAttribute("curSort", sort);
        request.setAttribute("curKeyword", keyword);
        request.getRequestDispatcher("/admin/ManageProduct.jsp").forward(request, response);
    }
//
//    private void loadCommonData(HttpServletRequest request, String sort) {
//        List<Product> products = productDAO.findAll(sort);
//        List<Category> categories = categoryDAO.findAll();
//        List<Brand> brands = brandDAO.findAll();
//
//        request.setAttribute("products", products);
//        request.setAttribute("categories", categories);
//        request.setAttribute("brands", brands);
//    }

    private void loadCommonData(HttpServletRequest request, String sort, String keyword) {
        List<Product> products;
        List<Category> categories = categoryDAO.findAll();
        List<Brand> brands = brandDAO.findAll();

        if (keyword != null && !keyword.trim().isEmpty()) {
            // Sử dụng method searchProducts() có sẵn
            products = productDAO.searchProducts("all", "all", "all", sort, keyword.trim(), 1, 1000);
        } else {
            products = productDAO.findAll(sort);
        }

        request.setAttribute("products", products);
        request.setAttribute("categories", categories);
        request.setAttribute("brands", brands);
    }

    private void handleSave(HttpServletRequest request) throws ServletException, IOException {
        String idStr = request.getParameter("productId");
        String name = request.getParameter("name");
        String description = request.getParameter("description");
        String priceStr = request.getParameter("price");
        String stockStr = request.getParameter("stock");
        String categoryStr = request.getParameter("categoryId");
        String brandStr = request.getParameter("brandId");
        String images = request.getParameter("images");
        String status = request.getParameter("status");

        if (status == null || status.isBlank()) {
            status = "ACTIVE";
        }

        try {
            BigDecimal price = new BigDecimal(priceStr);
            int stock = Integer.parseInt(stockStr);
            int categoryId = Integer.parseInt(categoryStr);
            int brandId = Integer.parseInt(brandStr);

            // Upload file ảnh nếu có
            Part imagePart = null;
            try {
                imagePart = request.getPart("imageFile");
            } catch (IllegalStateException ignored) {
                // Không phải multipart hoặc lỗi kích thước, bỏ qua
            }

            if (imagePart != null && imagePart.getSize() > 0) {
                String submittedName = Paths.get(imagePart.getSubmittedFileName())
                        .getFileName().toString();
                if (!submittedName.isBlank()) {
                    String uploadDir = getServletContext().getRealPath("/images/products");
                    if (uploadDir != null) {
                        Path dirPath = Paths.get(uploadDir);
                        if (!Files.exists(dirPath)) {
                            Files.createDirectories(dirPath);
                        }
                        File dest = new File(dirPath.toFile(), submittedName);
                        imagePart.write(dest.getAbsolutePath());
                        images = "images/products/" + submittedName;
                    }
                }
            }

            Product p = new Product();
            p.setName(name);
            p.setDescription(description);
            p.setPrice(price);
            p.setStock(stock);
            p.setCategoryId(categoryId);
            p.setBrandId(brandId);
            p.setImages(images);
            p.setStatus(status);
            p.setSoldCount(0);

            boolean ok;
            if (idStr == null || idStr.isBlank()) {
                ok = productDAO.create(p);
            } else {
                p.setProductId(Integer.parseInt(idStr));
                ok = productDAO.update(p);
            }

            request.setAttribute("message", ok ? "Lưu sản phẩm thành công." : "Không thể lưu sản phẩm.");
        } catch (Exception e) {
            request.setAttribute("error", "Dữ liệu không hợp lệ: " + e.getMessage());
        }
    }

    private void handleDelete(HttpServletRequest request) {
        String idStr = request.getParameter("productId");
        try {
            int id = Integer.parseInt(idStr);
            boolean ok = productDAO.delete(id);
            request.setAttribute("message", ok ? "Xóa sản phẩm thành công." : "Không thể xóa sản phẩm.");
        } catch (NumberFormatException e) {
            request.setAttribute("error", "ID sản phẩm không hợp lệ.");
        }
    }

    private void handleToggleStatus(HttpServletRequest request) {
        String idStr = request.getParameter("productId");
        String currentStatus = request.getParameter("currentStatus");
        if (currentStatus == null) {
            currentStatus = "ACTIVE";
        }

        try {
            int id = Integer.parseInt(idStr);
            String newStatus = "ACTIVE".equalsIgnoreCase(currentStatus) ? "INACTIVE" : "ACTIVE";
            boolean ok = productDAO.updateStatus(id, newStatus);
            request.setAttribute("message", ok ? "Cập nhật trạng thái sản phẩm thành công." : "Không thể cập nhật trạng thái.");
        } catch (NumberFormatException e) {
            request.setAttribute("error", "ID sản phẩm không hợp lệ.");
        }
    }
}

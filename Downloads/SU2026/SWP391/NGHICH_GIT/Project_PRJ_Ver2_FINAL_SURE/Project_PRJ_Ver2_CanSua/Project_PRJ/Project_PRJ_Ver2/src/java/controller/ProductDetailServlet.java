
/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import dal.ProductDAO;
import dal.ProductImageDAO;
import dal.ReviewDAO;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Product;
import model.ProductImage;
import model.Review;
import model.User;
import service.ReviewService;
import utils.SessionUtil;

@WebServlet(name = "ProductDetailServlet", urlPatterns = {"/productdetail"})
public class ProductDetailServlet extends HttpServlet {

    private final ProductDAO productDAO = new ProductDAO();
    private final ProductImageDAO imageDAO = new ProductImageDAO();
    private final ReviewService reviewService = new ReviewService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idParam = request.getParameter("id");
        if (idParam == null) {
            response.sendRedirect(request.getContextPath() + "/home");
            return;
        }

        int id;
        try {
            id = Integer.parseInt(idParam);
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/home");
            return;
        }

        Product product = productDAO.getById(id);
        if (product == null || !"ACTIVE".equalsIgnoreCase(product.getStatus())) {
            request.getRequestDispatcher("/ProductUnavailable.jsp").forward(request, response);
            return;
        }

        List<ProductImage> images = imageDAO.findByProductId(id);
        List<Review> reviews = reviewService.getReviewsForProduct(id);
        ReviewDAO.ReviewSummary summary = reviewService.getSummaryForProduct(id);
        ReviewDAO.RatingBreakdown breakdown = reviewService.getBreakdownForProduct(id);

        User user = SessionUtil.getUser(request);
        boolean hasPurchased = false;
        boolean hasReviewed = false;
        boolean canReview = false;
        if (user != null) {
            hasPurchased = reviewService.hasUserPurchasedProduct(id, user.getUserId());
            hasReviewed = reviewService.hasUserReviewed(id, user.getUserId());
            canReview = hasPurchased && !hasReviewed;
        }
        java.util.List<Product> relatedProducts = productDAO.findRelatedProducts(id, product.getCategoryId(), 4);
        request.setAttribute("product", product);
        request.setAttribute("images", images);
        request.setAttribute("reviews", reviews);
        request.setAttribute("averageRating", summary.getAverageRating());
        request.setAttribute("reviewCount", summary.getTotalReviews());
        request.setAttribute("ratingBreakdown", breakdown);
        request.setAttribute("hasPurchased", hasPurchased);
        request.setAttribute("hasReviewed", hasReviewed);
        request.setAttribute("canReview", canReview);
        request.setAttribute("relatedProducts", relatedProducts);

        request.getRequestDispatcher("/Product.jsp").forward(request, response);
    }
}


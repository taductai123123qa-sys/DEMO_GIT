package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.User;
import service.ReviewService;
import utils.SessionUtil;

import java.io.IOException;

@WebServlet(name = "ReviewServlet", urlPatterns = {"/review"})
public class ReviewServlet extends HttpServlet {

    private final ReviewService reviewService = new ReviewService();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        User user = SessionUtil.getUser(request);
        if (user == null) {
            String productIdParam = request.getParameter("productId");
            String redirect = request.getContextPath() + "/login?redirect=productdetail?id=" + productIdParam;
            response.sendRedirect(redirect);
            return;
        }

        String productIdParam = request.getParameter("productId");
        String ratingParam = request.getParameter("rating");
        String comment = request.getParameter("comment");

        int productId;
        int rating;
        try {
            productId = Integer.parseInt(productIdParam);
            rating = Integer.parseInt(ratingParam);
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/home");
            return;
        }

        try {
            boolean ok = reviewService.addReview(request, productId, rating, comment);
            if (!ok) {
                request.getSession().setAttribute("reviewError", "Không thể lưu đánh giá, vui lòng thử lại.");
            } else {
                request.getSession().setAttribute("reviewMessage", "Cảm ơn bạn đã đánh giá sản phẩm.");
            }
        } catch (IllegalArgumentException e) {
            request.getSession().setAttribute("reviewError", e.getMessage());
        } catch (Exception e) {
            request.getSession().setAttribute("reviewError", "Có lỗi xảy ra, vui lòng thử lại.");
        }

        response.sendRedirect(request.getContextPath() + "/productdetail?id=" + productId + "#tab3");
    }
}


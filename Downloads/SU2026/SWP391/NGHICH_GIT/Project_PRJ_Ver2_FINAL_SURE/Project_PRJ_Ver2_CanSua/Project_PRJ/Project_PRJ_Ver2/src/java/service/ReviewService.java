package service;

import dal.ReviewDAO;
import jakarta.servlet.http.HttpServletRequest;
import model.Review;
import model.User;
import utils.SessionUtil;

import java.util.List;

public class ReviewService {

    private final ReviewDAO reviewDAO = new ReviewDAO();

    public List<Review> getReviewsForProduct(int productId) {
        return reviewDAO.findByProduct(productId);
    }

    public ReviewDAO.ReviewSummary getSummaryForProduct(int productId) {
        return reviewDAO.getSummary(productId);
    }

    public ReviewDAO.RatingBreakdown getBreakdownForProduct(int productId) {
        return reviewDAO.getRatingBreakdown(productId);
    }

    public boolean hasUserPurchasedProduct(int productId, int userId) {
        return reviewDAO.hasUserPurchasedProduct(productId, userId);
    }

    public boolean hasUserReviewed(int productId, int userId) {
        return reviewDAO.hasUserReviewed(productId, userId);
    }

    public boolean addReview(HttpServletRequest request, int productId, int rating, String comment) {
        User user = SessionUtil.getUser(request);
        if (user == null) {
            throw new IllegalStateException("User not logged in");
        }
        if (rating < 1 || rating > 5) {
            throw new IllegalArgumentException("Rating must be between 1 and 5");
        }
        if (comment == null || comment.isBlank()) {
            throw new IllegalArgumentException("Comment is required");
        }
        return reviewDAO.insert(productId, user.getUserId(), rating, comment.trim());
    }
}


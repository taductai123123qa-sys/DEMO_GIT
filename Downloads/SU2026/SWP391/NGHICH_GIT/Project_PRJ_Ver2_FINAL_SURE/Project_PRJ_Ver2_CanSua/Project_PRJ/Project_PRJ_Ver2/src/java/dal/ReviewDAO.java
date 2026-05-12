package dal;

import model.Review;
import utils.DBContext;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ReviewDAO {

    private boolean isInvalidColumn(SQLException e, String column) {
        String msg = e.getMessage();
        if (msg == null) return false;
        return msg.toLowerCase().contains("invalid column") && msg.toLowerCase().contains(column.toLowerCase());
    }

    public List<Review> findByProduct(int productId) {
        List<Review> list = new ArrayList<>();
        String sqlJoinWithCreatedAt = "SELECT r.reviewId, r.productId, r.userId, r.rating, r.comment, r.createdAt, " +
                "u.fullName, u.username " +
                "FROM Reviews r LEFT JOIN Users u ON r.userId = u.userId " +
                "WHERE r.productId = ? " +
                "ORDER BY r.createdAt DESC";

        String sqlJoinNoCreatedAt = "SELECT r.reviewId, r.productId, r.userId, r.rating, r.comment, " +
                "u.fullName, u.username " +
                "FROM Reviews r LEFT JOIN Users u ON r.userId = u.userId " +
                "WHERE r.productId = ? " +
                "ORDER BY r.reviewId DESC";

        String sqlNoJoinWithCreatedAt = "SELECT reviewId, productId, userId, rating, comment, createdAt " +
                "FROM Reviews WHERE productId = ? ORDER BY createdAt DESC";

        String sqlNoJoinNoCreatedAt = "SELECT reviewId, productId, userId, rating, comment " +
                "FROM Reviews WHERE productId = ? ORDER BY reviewId DESC";

        try (Connection conn = DBContext.getConnection()) {
            // 1) Try join query (with createdAt)
            try {
                try (PreparedStatement ps = conn.prepareStatement(sqlJoinWithCreatedAt)) {
                    ps.setInt(1, productId);
                    try (ResultSet rs = ps.executeQuery()) {
                        while (rs.next()) {
                            Review r = new Review();
                            r.setReviewId(rs.getInt("reviewId"));
                            r.setProductId(rs.getInt("productId"));
                            r.setUserId(rs.getInt("userId"));
                            r.setRating(rs.getInt("rating"));
                            r.setComment(rs.getString("comment"));
                            try {
                                r.setCreatedAt(rs.getTimestamp("createdAt"));
                            } catch (SQLException ignored) {
                            }
                            
                            // Ưu tiên hiển thị username, fallback sang fullName
                            String username = rs.getString("username");
                            String fullName = rs.getString("fullName");
                            if (username != null && !username.isBlank()) {
                                r.setUserName("@" + username);
                            } else if (fullName != null && !fullName.isBlank()) {
                                r.setUserName(fullName);
                            } else {
                                r.setUserName("User #" + r.getUserId());
                            }
                            list.add(r);
                        }
                    }
                }
            } catch (SQLException noJoinErr) {
                if (isInvalidColumn(noJoinErr, "createdAt")) {
                    try (PreparedStatement ps2 = conn.prepareStatement(sqlJoinNoCreatedAt)) {
                        ps2.setInt(1, productId);
                        try (ResultSet rs2 = ps2.executeQuery()) {
                            while (rs2.next()) {
                                Review r = new Review();
                                r.setReviewId(rs2.getInt("reviewId"));
                                r.setProductId(rs2.getInt("productId"));
                                r.setUserId(rs2.getInt("userId"));
                                r.setRating(rs2.getInt("rating"));
                                r.setComment(rs2.getString("comment"));
                                
                                // Ưu tiên hiển thị username, fallback sang fullName
                                String username = rs2.getString("username");
                                String fullName = rs2.getString("fullName");
                                if (username != null && !username.isBlank()) {
                                    r.setUserName("@" + username);
                                } else if (fullName != null && !fullName.isBlank()) {
                                    r.setUserName(fullName);
                                } else {
                                    r.setUserName("User #" + r.getUserId());
                                }
                                list.add(r);
                            }
                        }
                    }
                } else {
                    System.err.println("ReviewDAO.findByProduct no-join error: " + noJoinErr.getMessage());
                    noJoinErr.printStackTrace();
                }
            }
        } catch (SQLException e) {
            System.err.println("ReviewDAO.findByProduct error: " + e.getMessage());
            e.printStackTrace();
        }

        System.out.println(">>> ReviewDAO.findByProduct(productId=" + productId + ") -> " + list.size() + " row(s)");

        return list;
    }

    public boolean insert(int productId, int userId, int rating, String comment) {
        String sql = "INSERT INTO Reviews (productId, userId, rating, comment) VALUES (?, ?, ?, ?)";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, productId);
            ps.setInt(2, userId);
            ps.setInt(3, rating);
            ps.setString(4, comment);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("ReviewDAO.insert error: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    public ReviewSummary getSummary(int productId) {
        String sql = "SELECT COUNT(*) AS totalReviews, AVG(CAST(rating AS FLOAT)) AS avgRating " +
                "FROM Reviews WHERE productId = ?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, productId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    int total = rs.getInt("totalReviews");
                    double avg = rs.getDouble("avgRating");
                    if (total == 0) {
                        return new ReviewSummary(0, 0.0);
                    }
                    return new ReviewSummary(total, avg);
                }
            }
        } catch (SQLException e) {
            System.err.println("ReviewDAO.getSummary error: " + e.getMessage());
            e.printStackTrace();
        }
        return new ReviewSummary(0, 0.0);
    }

    public RatingBreakdown getRatingBreakdown(int productId) {
        int[] counts = new int[6];
        String sql = "SELECT rating, COUNT(*) AS cnt FROM Reviews WHERE productId = ? GROUP BY rating";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, productId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    int rating = rs.getInt("rating");
                    int count = rs.getInt("cnt");
                    if (rating >= 1 && rating <= 5) {
                        counts[rating] = count;
                    }
                }
            }
        } catch (SQLException e) {
            System.err.println("ReviewDAO.getRatingBreakdown error: " + e.getMessage());
            e.printStackTrace();
        }
        return new RatingBreakdown(counts[1], counts[2], counts[3], counts[4], counts[5]);
    }

    public boolean hasUserReviewed(int productId, int userId) {
        String sql = "SELECT 1 FROM Reviews WHERE productId = ? AND userId = ?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, productId);
            ps.setInt(2, userId);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next();
            }
        } catch (SQLException e) {
            System.err.println("ReviewDAO.hasUserReviewed error: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    public boolean hasUserPurchasedProduct(int productId, int userId) {
        String sql = "SELECT 1 " +
                "FROM Orders o JOIN OrderDetails d ON o.orderId = d.orderId " +
                "WHERE o.userId = ? AND d.productId = ? AND (o.status IS NULL OR LOWER(o.status) <> 'cancelled')";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, userId);
            ps.setInt(2, productId);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next();
            }
        } catch (SQLException e) {
            System.err.println("ReviewDAO.hasUserPurchasedProduct error: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    public static class ReviewSummary {
        private final int totalReviews;
        private final double averageRating;

        public ReviewSummary(int totalReviews, double averageRating) {
            this.totalReviews = totalReviews;
            this.averageRating = averageRating;
        }

        public int getTotalReviews() {
            return totalReviews;
        }

        public double getAverageRating() {
            return averageRating;
        }
    }

    public static class RatingBreakdown {
        private final int star1;
        private final int star2;
        private final int star3;
        private final int star4;
        private final int star5;

        public RatingBreakdown(int star1, int star2, int star3, int star4, int star5) {
            this.star1 = star1;
            this.star2 = star2;
            this.star3 = star3;
            this.star4 = star4;
            this.star5 = star5;
        }

        public int getStar1() {
            return star1;
        }

        public int getStar2() {
            return star2;
        }

        public int getStar3() {
            return star3;
        }

        public int getStar4() {
            return star4;
        }

        public int getStar5() {
            return star5;
        }
    }
}


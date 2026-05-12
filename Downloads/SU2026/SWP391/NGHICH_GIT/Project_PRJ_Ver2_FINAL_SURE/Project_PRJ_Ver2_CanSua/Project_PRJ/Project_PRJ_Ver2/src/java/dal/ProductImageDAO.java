package dal;

import model.ProductImage;
import utils.DBContext;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ProductImageDAO {

    public List<ProductImage> findByProductId(int productId) {
        List<ProductImage> list = new ArrayList<>();
        String sql = "SELECT imageId, productId, imageUrl FROM ProductImages WHERE productId = ?";

        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, productId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    ProductImage img = new ProductImage();
                    img.setImageId(rs.getInt("imageId"));
                    img.setProductId(rs.getInt("productId"));
                    img.setImageUrl(rs.getString("imageUrl"));
                    list.add(img);
                }
            }
        } catch (SQLException e) {
            System.err.println("ProductImageDAO.findByProductId error: " + e.getMessage());
            e.printStackTrace();
        }

        return list;
    }
}


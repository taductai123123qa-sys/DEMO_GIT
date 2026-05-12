package dal;

import model.Product;
import utils.DBContext;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ProductDAO {

    /**
     * Lấy danh sách sản phẩm theo bộ lọc
     */
    public List<Product> searchProducts(String category, String brand,
                                        String price, String sort, String keyword,
                                        int page, int pageSize) {

        List<Product> list = new ArrayList<>();

        StringBuilder sql = new StringBuilder("SELECT * FROM Products where 1=1");
        List<Object> params = new ArrayList<>();

        // Lọc theo category
        if (!"all".equals(category)) {
            sql.append(" AND categoryId = ?");
            params.add(Integer.parseInt(category));
        }

        // Lọc theo brand
        if (!"all".equals(brand)) {
            sql.append(" AND brandId = ?");
            params.add(Integer.parseInt(brand));
        }

        // Lọc theo khoảng giá
        if (!"all".equals(price)) {
            switch (price) {
                case "under10":
                    sql.append(" AND price < 10000000");
                    break;
                case "10to20":
                    sql.append(" AND price BETWEEN 10000000 AND 20000000");
                    break;
                case "20to30":
                    sql.append(" AND price BETWEEN 20000001 AND 30000000");
                    break;
                case "30to50":
                    sql.append(" AND price BETWEEN 30000001 AND 50000000");
                    break;
                case "over50":
                    sql.append(" AND price > 50000000");
                    break;
            }
        }

        // Từ khóa tìm kiếm
        if (keyword != null && !keyword.trim().isEmpty()) {
            sql.append(" AND name LIKE ?");
            params.add("%" + keyword.trim() + "%");
        }

        // Chỉ hiển thị sản phẩm ACTIVE trên trang chủ
        sql.append(" AND (status IS NULL OR status = 'ACTIVE')");

        // Sắp xếp
        if ("bestsell".equals(sort)) {
            sql.append(" ORDER BY soldCount DESC");
        } else if ("price_asc".equals(sort)) {
            sql.append(" ORDER BY price ASC");
        } else if ("price_desc".equals(sort)) {
            sql.append(" ORDER BY price DESC");
        } else {
            sql.append(" ORDER BY createdAt DESC");
        }

        // Phân trang
        sql.append(" OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");

        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            conn = DBContext.getConnection();
            ps = conn.prepareStatement(sql.toString());
            int index = 1;
            for (Object param : params) {
                ps.setObject(index++, param);
            }
            ps.setInt(index++, (page - 1) * pageSize);
            ps.setInt(index, pageSize);

            rs = ps.executeQuery();

            while (rs.next()) {
                Product p = new Product();
                p.setProductId(rs.getInt("productId"));
                p.setName(rs.getString("name"));
                p.setPrice(rs.getBigDecimal("price"));
                p.setImages(rs.getString("images"));
                p.setSoldCount(rs.getInt("soldCount"));
                list.add(p);
            }

        } catch (SQLException e) {
            System.err.println("Lỗi searchProducts: " + e.getMessage());
            e.printStackTrace();
        } finally {
            DBContext.closeQuietly(conn, ps, rs);
        }

        return list;
    }

    private Product mapRow(ResultSet rs) throws SQLException {
        Product p = new Product();
        p.setProductId(rs.getInt("productId"));
        p.setName(rs.getString("name"));
        p.setDescription(rs.getString("description"));
        p.setPrice(rs.getBigDecimal("price"));
        p.setStock(rs.getInt("stock"));
        p.setSoldCount(rs.getInt("soldCount"));
        p.setCategoryId(rs.getInt("categoryId"));
        p.setBrandId(rs.getInt("brandId"));
        p.setCreatedAt(rs.getTimestamp("createdAt"));
        p.setImages(rs.getString("images"));
        p.setStatus(rs.getString("status"));
        return p;
    }

    public Product getById(int productId) {
        String sql = "SELECT * FROM Products WHERE productId = ?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, productId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapRow(rs);
                }
            }
        } catch (SQLException e) {
            System.err.println("ProductDAO.getById error: " + e.getMessage());
            e.printStackTrace();
        }
        return null;
    }

    /**
     * Lấy sản phẩm liên quan (cùng category, trừ sản phẩm hiện tại). Tối đa limit sản phẩm.
     */
    public List<Product> findRelatedProducts(int currentProductId, Integer categoryId, int limit) {
        List<Product> list = new ArrayList<>();
        String sql;
        if (categoryId != null) {
            sql = "SELECT * FROM Products WHERE categoryId = ? AND productId != ? AND (status IS NULL OR status = 'ACTIVE') ORDER BY soldCount DESC OFFSET 0 ROWS FETCH NEXT ? ROWS ONLY";
        } else {
            sql = "SELECT * FROM Products WHERE productId != ? AND (status IS NULL OR status = 'ACTIVE') ORDER BY soldCount DESC OFFSET 0 ROWS FETCH NEXT ? ROWS ONLY";
        }
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            int idx = 1;
            if (categoryId != null) {
                ps.setInt(idx++, categoryId);
            }
            ps.setInt(idx++, currentProductId);
            ps.setInt(idx, limit);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(mapRow(rs));
                }
            }
        } catch (SQLException e) {
            System.err.println("ProductDAO.findRelatedProducts error: " + e.getMessage());
            e.printStackTrace();
        }
        return list;
    }

    /**
     * Đếm tổng số sản phẩm theo bộ lọc (dùng cho phân trang)
     */
    public int countProducts(String category, String brand, String priceRange, String keyword) {
        int total = 0;
        StringBuilder sql = new StringBuilder("SELECT COUNT(*) FROM Products WHERE 1=1");

        List<Object> params = new ArrayList<>();

        if (!"all".equals(category)) {
            sql.append(" AND categoryId = ?");
            params.add(Integer.parseInt(category));
        }

        if (!"all".equals(brand)) {
            sql.append(" AND brandId = ?");
            params.add(Integer.parseInt(brand));
        }

        if (!"all".equals(priceRange)) {
            switch (priceRange) {
                case "under10":
                    sql.append(" AND price < 10000000");
                    break;
                case "10to20":
                    sql.append(" AND price BETWEEN 10000000 AND 20000000");
                    break;
                case "20to30":
                    sql.append(" AND price BETWEEN 20000001 AND 30000000");
                    break;
                case "30to50":
                    sql.append(" AND price BETWEEN 30000001 AND 50000000");
                    break;
                case "over50":
                    sql.append(" AND price > 50000000");
                    break;
            }
        }

        if (keyword != null && !keyword.trim().isEmpty()) {
            sql.append(" AND name LIKE ?");
            params.add("%" + keyword.trim() + "%");
        }

        sql.append(" AND (status IS NULL OR status = 'ACTIVE')");

        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            conn = DBContext.getConnection();
            ps = conn.prepareStatement(sql.toString());

            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }

            rs = ps.executeQuery();
            if (rs.next()) {
                total = rs.getInt(1);
            }
        } catch (SQLException e) {
            System.err.println("Lỗi countProducts: " + e.getMessage());
            e.printStackTrace();
        } finally {
            DBContext.closeQuietly(conn, ps, rs);
        }

        return total;
    }

    /**
     * Lấy tất cả sản phẩm (admin CRUD), có thể sắp xếp.
     * sort: id_asc, id_desc, created_asc, created_desc (mặc định created_desc)
     */
//    public java.util.List<Product> findAll(String sort) {
//        java.util.List<Product> list = new java.util.ArrayList<>();
//        String orderBy = "ORDER BY createdAt DESC";
//        if (sort != null) {
//            switch (sort) {
//                case "id_asc":
//                    orderBy = "ORDER BY productId ASC";
//                    break;
//                case "id_desc":
//                    orderBy = "ORDER BY productId DESC";
//                    break;
//                case "created_asc":
//                    orderBy = "ORDER BY createdAt ASC";
//                    break;
//                case "created_desc":
//                default:
//                    orderBy = "ORDER BY createdAt DESC";
//                    break;
//            }
//        }
//        String sql = "SELECT * FROM Products " + orderBy;
//        try (Connection conn = DBContext.getConnection();
//             PreparedStatement ps = conn.prepareStatement(sql);
//             ResultSet rs = ps.executeQuery()) {
//
//            while (rs.next()) {
//                list.add(mapRow(rs));
//            }
//        } catch (SQLException e) {
//            System.err.println("ProductDAO.findAll error: " + e.getMessage());
//            e.printStackTrace();
//        }
//        return list;
//    }
    
    public java.util.List<Product> findAll(String sort) {
    java.util.List<Product> list = new java.util.ArrayList<>();
    String orderBy = "ORDER BY createdAt DESC";
    if (sort != null) {
        switch (sort) {
            case "id_asc":
                orderBy = "ORDER BY productId ASC";
                break;
            case "id_desc":
                orderBy = "ORDER BY productId DESC";
                break;
            case "created_asc":
                orderBy = "ORDER BY createdAt ASC";
                break;
            case "created_desc":
            default:
                orderBy = "ORDER BY createdAt DESC";
                break;
            // THÊM CASE CHO SORT THEO GIÁ
            case "price_asc":
                orderBy = "ORDER BY price ASC";
                break;
            case "price_desc":
                orderBy = "ORDER BY price DESC";
                break;
        }
    }
    String sql = "SELECT * FROM Products " + orderBy;
    try (Connection conn = DBContext.getConnection();
         PreparedStatement ps = conn.prepareStatement(sql);
         ResultSet rs = ps.executeQuery()) {

        while (rs.next()) {
            list.add(mapRow(rs));
        }
    } catch (SQLException e) {
        System.err.println("ProductDAO.findAll error: " + e.getMessage());
        e.printStackTrace();
    }
    return list;
}

    public java.util.List<Product> findAll() {
        return findAll("created_desc");
    }

    public boolean create(Product p) {
        String sql = "INSERT INTO Products (name, description, price, stock, soldCount, " +
                "categoryId, brandId, images, status) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, p.getName());
            ps.setString(2, p.getDescription());
            ps.setBigDecimal(3, p.getPrice());
            ps.setInt(4, p.getStock());
            ps.setInt(5, p.getSoldCount());
            ps.setInt(6, p.getCategoryId());
            ps.setInt(7, p.getBrandId());
            ps.setString(8, p.getImages());
            ps.setString(9, p.getStatus());

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("ProductDAO.create error: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    public boolean update(Product p) {
        String sql = "UPDATE Products SET name = ?, description = ?, price = ?, stock = ?, " +
                "categoryId = ?, brandId = ?, images = ?, status = ? WHERE productId = ?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, p.getName());
            ps.setString(2, p.getDescription());
            ps.setBigDecimal(3, p.getPrice());
            ps.setInt(4, p.getStock());
            ps.setInt(5, p.getCategoryId());
            ps.setInt(6, p.getBrandId());
            ps.setString(7, p.getImages());
            ps.setString(8, p.getStatus());
            ps.setInt(9, p.getProductId());

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("ProductDAO.update error: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    public boolean delete(int productId) {
        String sql = "DELETE FROM Products WHERE productId = ?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, productId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("ProductDAO.delete error: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    public boolean updateStatus(int productId, String status) {
        String sql = "UPDATE Products SET status = ? WHERE productId = ?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, status);
            ps.setInt(2, productId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("ProductDAO.updateStatus error: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
}
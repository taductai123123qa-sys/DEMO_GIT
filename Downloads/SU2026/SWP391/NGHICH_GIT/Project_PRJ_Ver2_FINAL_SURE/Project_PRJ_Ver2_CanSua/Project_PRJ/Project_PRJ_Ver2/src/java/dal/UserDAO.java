package dal;

import model.User;
import utils.DBContext;
import utils.PasswordUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UserDAO {

    private static final String BASE_SELECT =
            "SELECT userId, username, password, email, fullName, role, status FROM Users ";

    public User findByEmail(String email) {
        String sql = BASE_SELECT + "WHERE email = ?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, email);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapRow(rs);
                }
            }
        } catch (SQLException e) {
            System.err.println("UserDAO.findByEmail error: " + e.getMessage());
            e.printStackTrace();
        }
        return null;
    }

    public boolean emailExists(String email) {
        String sql = "SELECT 1 FROM Users WHERE email = ?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, email);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next();
            }
        } catch (SQLException e) {
            System.err.println("UserDAO.emailExists error: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Đăng ký user mới, mật khẩu được hash bằng BCrypt.
     * Mặc định role = 'USER', status = 'ACTIVE'.
     */
    public User createUser(String fullName, String email, String rawPassword) {
        String username = email.split("@")[0];
        String hashed = PasswordUtil.hash(rawPassword);

        String sql = "INSERT INTO Users (username, password, email, fullName, role, status) " +
                     "VALUES (?, ?, ?, ?, ?, ?)";

        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS)) {

            ps.setString(1, username);
            ps.setString(2, hashed);
            ps.setString(3, email);
            ps.setString(4, fullName);
            ps.setString(5, "USER");
            ps.setString(6, "ACTIVE");

            int affected = ps.executeUpdate();
            if (affected == 0) {
                return null;
            }

            try (ResultSet rs = ps.getGeneratedKeys()) {
                if (rs.next()) {
                    int id = rs.getInt(1);
                    User u = new User();
                    u.setUserId(id);
                    u.setUsername(username);
                    u.setPassword(hashed);
                    u.setEmail(email);
                    u.setFullName(fullName);
                    u.setRole("USER");
                    u.setStatus("ACTIVE");
                    return u;
                }
            }
        } catch (SQLException e) {
            System.err.println("UserDAO.createUser error: " + e.getMessage());
            e.printStackTrace();
        }
        return null;
    }

    /**
     * Kiểm tra đăng nhập bằng email hoặc username + mật khẩu thô.
     * So sánh mật khẩu bằng BCrypt.
     */
    public User checkLogin(String emailOrUsername, String rawPassword) {
        String sql = BASE_SELECT +
                "WHERE (email = ? OR username = ?) AND (status IS NULL OR status = 'ACTIVE')";

        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, emailOrUsername);
            ps.setString(2, emailOrUsername);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    String storedPassword = rs.getString("password");

                    boolean isBcrypt = storedPassword != null
                            && (storedPassword.startsWith("$2a$")
                            || storedPassword.startsWith("$2b$")
                            || storedPassword.startsWith("$2y$"));

                    boolean ok = false;
                    if (isBcrypt) {
                        ok = PasswordUtil.check(rawPassword, storedPassword);
                    } else {
                        // Hỗ trợ data cũ: mật khẩu lưu plain text trong DB
                        ok = storedPassword != null && storedPassword.equals(rawPassword);
                    }

                    if (ok) {
                        return mapRow(rs);
                    }
                }
            }
        } catch (SQLException e) {
            System.err.println("UserDAO.checkLogin error: " + e.getMessage());
            e.printStackTrace();
        }
        return null;
    }

    public java.util.List<User> findAll() {
        String sql = BASE_SELECT + "ORDER BY userId DESC";
        java.util.List<User> users = new java.util.ArrayList<>();

        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                users.add(mapRow(rs));
            }
        } catch (SQLException e) {
            System.err.println("UserDAO.findAll error: " + e.getMessage());
            e.printStackTrace();
        }
        return users;
    }

    public boolean updateStatus(int userId, String status) {
        String sql = "UPDATE Users SET status = ? WHERE userId = ?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, status);
            ps.setInt(2, userId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("UserDAO.updateStatus error: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    public boolean updateRole(int userId, String role) {
        String sql = "UPDATE Users SET role = ? WHERE userId = ?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, role);
            ps.setInt(2, userId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("UserDAO.updateRole error: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    public User getById(int userId) {
        String sql = BASE_SELECT + "WHERE userId = ?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapRow(rs);
                }
            }
        } catch (SQLException e) {
            System.err.println("UserDAO.getById error: " + e.getMessage());
            e.printStackTrace();
        }
        return null;
    }

    public boolean updatePassword(int userId, String newPassword) {
        String sql = "UPDATE Users SET password = ? WHERE userId = ?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, newPassword);
            ps.setInt(2, userId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("UserDAO.updatePassword error: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    private User mapRow(ResultSet rs) throws SQLException {
        User u = new User();
        u.setUserId(rs.getInt("userId"));
        u.setUsername(rs.getString("username"));
        u.setPassword(rs.getString("password"));
        u.setEmail(rs.getString("email"));
        u.setFullName(rs.getString("fullName"));
        u.setRole(rs.getString("role"));
        u.setStatus(rs.getString("status"));
        return u;
    }
}
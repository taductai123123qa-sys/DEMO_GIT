package controller;

import dal.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.User;
import utils.SessionUtil;

import java.io.IOException;

@WebServlet(name = "UserServlet", urlPatterns = {"/profile", "/change-password"})
public class UserServlet extends HttpServlet {

    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        User user = SessionUtil.getUser(request);
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String path = request.getServletPath();
        
        if ("/profile".equals(path)) {
            // Hiển thị trang profile
            User fullUser = userDAO.getById(user.getUserId());
            request.setAttribute("user", fullUser);
            request.getRequestDispatcher("/profile.jsp").forward(request, response);
            
        } else if ("/change-password".equals(path)) {
            // Hiển thị trang đổi mật khẩu
            request.getRequestDispatcher("/change-password.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        User user = SessionUtil.getUser(request);
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String path = request.getServletPath();
        
        if ("/change-password".equals(path)) {
            String currentPassword = request.getParameter("currentPassword");
            String newPassword = request.getParameter("newPassword");
            String confirmPassword = request.getParameter("confirmPassword");

            try {
                // Validate
                if (currentPassword == null || currentPassword.isBlank()) {
                    throw new IllegalArgumentException("Vui lòng nhập mật khẩu hiện tại");
                }
                if (newPassword == null || newPassword.isBlank()) {
                    throw new IllegalArgumentException("Vui lòng nhập mật khẩu mới");
                }
                if (!newPassword.equals(confirmPassword)) {
                    throw new IllegalArgumentException("Mật khẩu xác nhận không khớp");
                }
                if (newPassword.length() < 6) {
                    throw new IllegalArgumentException("Mật khẩu mới phải có ít nhất 6 ký tự");
                }

                // Check current password - hỗ trợ cả plain text và BCrypt
                User currentUser = userDAO.getById(user.getUserId());
                String storedPassword = currentUser.getPassword();
                
                boolean passwordMatch = false;
                if (storedPassword != null) {
                    // Kiểm tra xem có phải BCrypt hash không
                    boolean isBcrypt = storedPassword.startsWith("$2a$") || storedPassword.startsWith("$2b$") || storedPassword.startsWith("$2y$");
                    
                    if (isBcrypt) {
                        // Dùng PasswordUtil để check BCrypt
                        passwordMatch = utils.PasswordUtil.check(currentPassword, storedPassword);
                    } else {
                        // Plain text comparison cho data cũ
                        passwordMatch = currentPassword.equals(storedPassword);
                    }
                }
                
                if (!passwordMatch) {
                    throw new IllegalArgumentException("Mật khẩu hiện tại không đúng");
                }

                // Update password - hash password mới trước khi lưu
                String hashedPassword = utils.PasswordUtil.hash(newPassword);
                boolean success = userDAO.updatePassword(user.getUserId(), hashedPassword);
                if (success) {
                    request.getSession().setAttribute("successMessage", "Đổi mật khẩu thành công!");
                } else {
                    throw new IllegalArgumentException("Có lỗi xảy ra, vui lòng thử lại");
                }

            } catch (IllegalArgumentException e) {
                request.getSession().setAttribute("errorMessage", e.getMessage());
            }

            response.sendRedirect(request.getContextPath() + "/change-password");
        }
    }
}

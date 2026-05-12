package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

import model.User;
import service.AuthService;
import utils.SessionUtil;

/**
 * Login servlet: nhận email/username + password, gọi AuthService,
 * lưu user vào session và redirect theo role.
 */
@WebServlet(name = "LoginServlet", urlPatterns = {"/login"})
public class LoginServlet extends HttpServlet {

    private final AuthService authService = new AuthService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (SessionUtil.isLoggedIn(request)) {
            String redirect = request.getParameter("redirect");
            if (redirect != null && !redirect.isBlank()) {
                response.sendRedirect(redirect);
            } else {
                response.sendRedirect(request.getContextPath() + "/home");
            }
            return;
        }
        request.getRequestDispatcher("Login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String usernameOrEmail = request.getParameter("email");
        String password = request.getParameter("password");

        User user = authService.login(usernameOrEmail, password);

        if (user == null) {
            request.setAttribute("error", "Sai tài khoản hoặc mật khẩu");
            request.getRequestDispatcher("Login.jsp").forward(request, response);
            return;
        }

        SessionUtil.storeUser(request, user);

        String redirect = request.getParameter("redirect");
        if (redirect != null && !redirect.isBlank()) {
            if (!redirect.startsWith("http")) {
                response.sendRedirect(redirect);
            } else {
                response.sendRedirect(request.getContextPath() + "/home");
            }
            return;
        }

        if ("ADMIN".equalsIgnoreCase(user.getRole())) {
            response.sendRedirect("admindashboard");
        } else {
            response.sendRedirect("home");
        }
    }

    @Override
    public String getServletInfo() {
        return "Login servlet";
    }
}

package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import utils.GoogleOAuthConfig;

/**
 * Bắt đầu flow "Sign in with Google":
 *  - Redirect user đến trang đăng nhập Google với scope email + profile.
 */
@WebServlet(name = "GoogleLoginServlet", urlPatterns = {"/google-login"})
public class GoogleLoginServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String clientId = GoogleOAuthConfig.CLIENT_ID;
        String redirectUri = GoogleOAuthConfig.REDIRECT_URI;

        // Nếu chưa cấu hình clientId thì quay lại trang login với thông báo.
        if (clientId == null || clientId.startsWith("YOUR_GOOGLE_CLIENT_ID")) {
            request.setAttribute("error", "Google Sign-In chưa được cấu hình.");
            request.getRequestDispatcher("Login.jsp").forward(request, response);
            return;
        }

        String scope = "openid email profile";

        String authUrl = GoogleOAuthConfig.AUTH_ENDPOINT
                + "?client_id=" + URLEncoder.encode(clientId, StandardCharsets.UTF_8)
                + "&redirect_uri=" + URLEncoder.encode(redirectUri, StandardCharsets.UTF_8)
                + "&response_type=code"
                + "&scope=" + URLEncoder.encode(scope, StandardCharsets.UTF_8)
                + "&access_type=online"
                + "&prompt=select_account";

        response.sendRedirect(authUrl);
    }

    @Override
    public String getServletInfo() {
        return "Khởi tạo đăng nhập bằng Google";
    }
}


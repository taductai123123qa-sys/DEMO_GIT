package controller;

import dal.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.security.SecureRandom;
import model.User;
import utils.GoogleOAuthConfig;
import utils.SessionUtil;

/**
 * Xử lý redirect từ Google sau khi user chọn tài khoản.
 *  - Đổi authorization code lấy access token.
 *  - Gọi Google UserInfo API để lấy email + tên.
 *  - Tìm user trong DB, nếu chưa có thì tạo mới.
 *  - Đăng nhập user vào hệ thống.
 */
@WebServlet(name = "GoogleCallbackServlet", urlPatterns = {"/google-callback"})
public class GoogleCallbackServlet extends HttpServlet {

    private final UserDAO userDAO = new UserDAO();
    private final SecureRandom secureRandom = new SecureRandom();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String error = request.getParameter("error");
        if (error != null) {
            request.setAttribute("error", "Google Sign-In bị hủy hoặc xảy ra lỗi.");
            request.getRequestDispatcher("Login.jsp").forward(request, response);
            return;
        }

        String code = request.getParameter("code");
        if (code == null || code.isEmpty()) {
            request.setAttribute("error", "Không nhận được mã xác thực từ Google.");
            request.getRequestDispatcher("Login.jsp").forward(request, response);
            return;
        }

        try {
            String tokenResponse = exchangeCodeForToken(code);
            String accessToken = extractJsonValue(tokenResponse, "access_token");

            if (accessToken == null) {
                request.setAttribute("error", "Không lấy được access token từ Google.");
                request.getRequestDispatcher("Login.jsp").forward(request, response);
                return;
            }

            String userInfoJson = fetchUserInfo(accessToken);
            String email = extractJsonValue(userInfoJson, "email");
            String fullName = extractJsonValue(userInfoJson, "name");

            if (email == null || email.isEmpty()) {
                request.setAttribute("error", "Không lấy được email từ Google.");
                request.getRequestDispatcher("Login.jsp").forward(request, response);
                return;
            }

            User user = userDAO.findByEmail(email);
            if (user == null) {
                // Tạo user mới với mật khẩu ngẫu nhiên (không dùng đến vì login qua Google).
                String randomPassword = generateRandomPassword();
                user = userDAO.createUser(fullName != null ? fullName : email, email, randomPassword);
            }

            if (user == null) {
                request.setAttribute("error", "Không thể tạo tài khoản từ Google.");
                request.getRequestDispatcher("Login.jsp").forward(request, response);
                return;
            }

            SessionUtil.storeUser(request, user);

            if ("ADMIN".equalsIgnoreCase(user.getRole())) {
                response.sendRedirect("admindashboard");
            } else {
                response.sendRedirect("home");
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Đăng nhập bằng Google thất bại: " + e.getMessage());
            request.getRequestDispatcher("Login.jsp").forward(request, response);
        }
    }

    private String exchangeCodeForToken(String code) throws IOException {
        URL url = new URL(GoogleOAuthConfig.TOKEN_ENDPOINT);
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("POST");
        conn.setDoOutput(true);
        conn.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");

        String body = "code=" + URLEncoder.encode(code, StandardCharsets.UTF_8)
                + "&client_id=" + URLEncoder.encode(GoogleOAuthConfig.CLIENT_ID, StandardCharsets.UTF_8)
                + "&client_secret=" + URLEncoder.encode(GoogleOAuthConfig.CLIENT_SECRET, StandardCharsets.UTF_8)
                + "&redirect_uri=" + URLEncoder.encode(GoogleOAuthConfig.REDIRECT_URI, StandardCharsets.UTF_8)
                + "&grant_type=authorization_code";

        try (OutputStream os = conn.getOutputStream()) {
            os.write(body.getBytes(StandardCharsets.UTF_8));
        }

        int status = conn.getResponseCode();
        BufferedReader reader = new BufferedReader(new InputStreamReader(
                status >= 200 && status < 300 ? conn.getInputStream() : conn.getErrorStream(),
                StandardCharsets.UTF_8));

        StringBuilder sb = new StringBuilder();
        String line;
        while ((line = reader.readLine()) != null) {
            sb.append(line);
        }
        reader.close();
        conn.disconnect();

        return sb.toString();
    }

    private String fetchUserInfo(String accessToken) throws IOException {
        URL url = new URL(GoogleOAuthConfig.USERINFO_ENDPOINT + "?access_token=" + URLEncoder.encode(accessToken, StandardCharsets.UTF_8));
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("GET");

        BufferedReader reader = new BufferedReader(new InputStreamReader(conn.getInputStream(), StandardCharsets.UTF_8));
        StringBuilder sb = new StringBuilder();
        String line;
        while ((line = reader.readLine()) != null) {
            sb.append(line);
        }
        reader.close();
        conn.disconnect();

        return sb.toString();
    }

    /**
     * Hàm parse JSON rất đơn giản (không phụ thuộc thư viện bên ngoài).
     * Chỉ dùng cho các trường text dạng: "key":"value"
     */
    private String extractJsonValue(String json, String key) {
        if (json == null || key == null) return null;

        String pattern = "\"" + key + "\"";
        int idx = json.indexOf(pattern);
        if (idx == -1) return null;

        int colon = json.indexOf(':', idx + pattern.length());
        if (colon == -1) return null;

        int startQuote = json.indexOf('"', colon + 1);
        if (startQuote == -1) return null;
        int endQuote = json.indexOf('"', startQuote + 1);
        if (endQuote == -1) return null;

        return json.substring(startQuote + 1, endQuote);
    }

    private String generateRandomPassword() {
        byte[] bytes = new byte[16];
        secureRandom.nextBytes(bytes);
        StringBuilder sb = new StringBuilder();
        for (byte b : bytes) {
            sb.append(String.format("%02x", b));
        }
        return sb.toString();
    }

    @Override
    public String getServletInfo() {
        return "Callback xử lý đăng nhập với Google OAuth2";
    }
}


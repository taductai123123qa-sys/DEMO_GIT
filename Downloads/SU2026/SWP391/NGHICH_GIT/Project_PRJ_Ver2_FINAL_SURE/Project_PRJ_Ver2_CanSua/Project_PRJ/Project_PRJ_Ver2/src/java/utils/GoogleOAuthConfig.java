package utils;

/**
 * Cấu hình OAuth2 với Google.
 *
 * Lưu ý:
 *  - Bạn cần tạo OAuth 2.0 Client ID trong Google Cloud Console.
 *  - Sau đó điền clientId, clientSecret và redirectUri tương ứng bên dưới.
 *  - redirectUri phải trùng với giá trị khai báo trong Google Cloud, ví dụ:
 *      http://localhost:8080/Project_PRJ/google-callback
 */
public class GoogleOAuthConfig {

    // TODO: Điền thông tin thật của bạn vào đây trước khi dùng.
    public static final String CLIENT_ID = "6987726354-542srpub0ash40j66hkq85cqp8a380fq.apps.googleusercontent.com";
    public static final String CLIENT_SECRET = "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";

    /**
     * URL callback của ứng dụng (phải public hoặc localhost khi dev).
     * Ở máy bạn đang chạy: http://localhost:9999/Project_PRJ/login
     * Vì vậy redirect URI đúng phải là:
     *     http://localhost:9999/Project_PRJ/google-callback
     */
    public static final String REDIRECT_URI = "http://localhost:9999/Project_PRJ/google-callback";

    public static final String AUTH_ENDPOINT = "https://accounts.google.com/o/oauth2/v2/auth";
    public static final String TOKEN_ENDPOINT = "https://oauth2.googleapis.com/token";
    public static final String USERINFO_ENDPOINT = "https://www.googleapis.com/oauth2/v3/userinfo";

    private GoogleOAuthConfig() {
    }
}


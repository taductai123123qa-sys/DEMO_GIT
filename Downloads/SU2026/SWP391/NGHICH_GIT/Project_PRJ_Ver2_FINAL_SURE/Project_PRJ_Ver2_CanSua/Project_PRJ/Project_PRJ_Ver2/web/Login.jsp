<%-- 
    Document   : Login
    Created on : Feb 17, 2026, 8:37:44 PM
    Author     : Lecoo
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Login - Electro</title>
        <link href="https://fonts.googleapis.com/css?family=Montserrat:400,500,600,700" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }

            :root {
                --primary:    #D10024;
                --dark2:      #16213e;
                --text:       #333;
                --text-light: #999;
                --border:     #e0e0e0;
            }

            body {
                font-family: 'Montserrat', sans-serif;
                background: #f5f5f5;
                min-height: 100vh;
                display: flex;
                flex-direction: column;
                align-items: center;
                justify-content: center;
                padding: 40px 15px;
            }

            /* LOGO */
            .logo-text {
                font-size: 30px;
                font-weight: 700;
                color: var(--dark2);
                letter-spacing: 3px;
                margin-bottom: 24px;
                text-align: center;
            }
            .logo-text em {
                color: var(--primary);
                font-style: normal;
            }

            /* CARD */
            .auth-card {
                background: #fff;
                border-radius: 4px;
                box-shadow: 0 4px 30px rgba(0,0,0,0.10);
                width: 100%;
                max-width: 440px;
                overflow: hidden;
            }

            /* CARD HEADER */
            .auth-card-header {
                background: var(--dark2);
                padding: 32px 40px 28px;
                text-align: center;
            }
            .auth-card-header::after {
                content: '';
                display: block;
                width: 50px;
                height: 3px;
                background: var(--primary);
                margin: 14px auto 0;
            }
            .auth-card-header h2 {
                color: #fff;
                font-size: 22px;
                font-weight: 700;
                letter-spacing: 2px;
                text-transform: uppercase;
            }
            .auth-card-header p {
                color: #aaa;
                font-size: 12px;
                margin-top: 6px;
            }

            /* CARD BODY */
            .auth-card-body {
                padding: 36px 40px 32px;
            }

            /* FORM */
            .form-group {
                margin-bottom: 20px;
            }
            .form-group label {
                display: block;
                font-size: 11px;
                font-weight: 600;
                letter-spacing: 1px;
                text-transform: uppercase;
                color: var(--text);
                margin-bottom: 8px;
            }

            /* INPUT WRAPPER — icon trái + nút mắt phải */
            .input-wrapper {
                position: relative;
            }
            .input-wrapper .icon-left {
                position: absolute;
                left: 14px;
                top: 50%;
                transform: translateY(-50%);
                color: var(--text-light);
                font-size: 14px;
                transition: color .2s;
                pointer-events: none;
            }
            .input-wrapper .toggle-password {
                position: absolute;
                right: 12px;
                top: 50%;
                transform: translateY(-50%);
                background: none;
                border: none;
                cursor: pointer;
                padding: 4px;
                color: var(--text-light);
                font-size: 15px;
                transition: color .2s;
            }
            .input-wrapper .toggle-password:hover {
                color: var(--primary);
            }
            .input-wrapper:focus-within .icon-left  {
                color: var(--primary);
            }

            .form-control {
                width: 100%;
                padding: 12px 40px 12px 40px; /* padding phải để tránh đè nút mắt */
                border: 1px solid var(--border);
                border-radius: 2px;
                font-family: 'Montserrat', sans-serif;
                font-size: 13px;
                color: var(--text);
                outline: none;
                background: #fafafa;
                transition: border-color .2s, box-shadow .2s;
            }
            .form-control:focus {
                border-color: var(--primary);
                box-shadow: 0 0 0 3px rgba(209,0,36,.08);
                background: #fff;
            }

            /* OPTIONS */
            .form-options {
                display: flex;
                align-items: center;
                justify-content: space-between;
                margin-bottom: 24px;
                font-size: 12px;
            }
            .remember-me {
                display: flex;
                align-items: center;
                gap: 7px;
                color: var(--text);
                cursor: pointer;
                font-weight: 500;
            }
            .remember-me input {
                accent-color: var(--primary);
                width: 14px;
                height: 14px;
            }
            .forgot-link {
                color: var(--primary);
                text-decoration: none;
                font-weight: 600;
                transition: opacity .2s;
            }
            .forgot-link:hover {
                opacity: .75;
            }

            /* BUTTON */
            .btn-primary {
                width: 100%;
                padding: 13px;
                background: var(--primary);
                color: #fff;
                border: none;
                border-radius: 2px;
                font-family: 'Montserrat', sans-serif;
                font-size: 13px;
                font-weight: 700;
                letter-spacing: 1.5px;
                text-transform: uppercase;
                cursor: pointer;
                transition: background .2s, transform .1s;
            }
            .btn-primary:hover  {
                background: #b8001f;
            }
            .btn-primary:active {
                transform: scale(.98);
            }

            /* SOCIAL LOGIN */
            .social-login {
                margin-top: 16px;
            }
            .btn-google {
                width: 100%;
                padding: 11px;
                border-radius: 2px;
                border: 1px solid #4285F4;
                background: #fff;
                color: #4285F4;
                font-family: 'Montserrat', sans-serif;
                font-size: 13px;
                font-weight: 600;
                cursor: pointer;
                display: flex;
                align-items: center;
                justify-content: center;
                gap: 8px;
                transition: background .2s, color .2s, box-shadow .2s;
            }
            .btn-google i {
                font-size: 15px;
            }
            .btn-google:hover {
                background: #4285F4;
                color: #fff;
                box-shadow: 0 4px 12px rgba(66,133,244,0.3);
            }

            /* DIVIDER */
            .divider {
                display: flex;
                align-items: center;
                gap: 12px;
                margin: 24px 0;
                color: var(--text-light);
                font-size: 11px;
                font-weight: 600;
                letter-spacing: 1px;
            }
            .divider::before, .divider::after {
                content: '';
                flex: 1;
                height: 1px;
                background: var(--border);
            }

            /* FOOTER LINK */
            .auth-footer {
                text-align: center;
                font-size: 13px;
                color: var(--text-light);
            }
            .auth-footer a {
                color: var(--primary);
                text-decoration: none;
                font-weight: 700;
                transition: opacity .2s;
            }
            .auth-footer a:hover {
                opacity: .75;
            }

            /* ALERT */
            .alert-error {
                background: #fff0f0;
                border-left: 3px solid var(--primary);
                color: var(--primary);
                padding: 10px 14px;
                font-size: 12px;
                font-weight: 500;
                border-radius: 2px;
                margin-bottom: 20px;
            }
            .alert-error i {
                margin-right: 6px;
            }
        </style>
    </head>
    <body>
        <!-- LOGO -->
        <div class="logo-text"><em>E</em>LECTRO</div>

        <!-- CARD -->
        <div class="auth-card">

            <div class="auth-card-header">
                <h2>Welcome Back</h2>
                <p>Sign in to your Electro account</p>
            </div>

            <div class="auth-card-body">

                <% if (request.getAttribute("error") != null) { %>
                <div class="alert-error">
                    <i class="fa fa-exclamation-circle"></i>
                    <%= request.getAttribute("error") %>
                </div>
                <% } %>

                <form action="${pageContext.request.contextPath}/login" method="POST">
                    <c:if test="${not empty param.redirect}">
                        <input type="hidden" name="redirect" value="${param.redirect}"/>
                    </c:if>

                    <div class="form-group">
                        <label>Email hoặc Username</label>
                        <div class="input-wrapper">
                            <input type="text" name="email" class="form-control"
                                   placeholder="admin / admin@shop.com"
                                   value="${param.email}"
                                   required>
                            <i class="fa fa-envelope-o"></i>
                        </div>
                    </div>
                    <!-- PASSWORD + NÚT MẮT -->
                    <div class="form-group">
                        <label>Password</label>
                        <div class="input-wrapper">
                            <input type="password" name="password" id="passwordInput"
                                   class="form-control" placeholder="••••••••" required>
                            <i class="fa fa-lock icon-left"></i>
                            <button type="button" class="toggle-password" onclick="togglePassword()">
                                <span id="eyeIcon">👁</span>
                            </button>
                        </div>
                    </div>

                    <div class="form-options">
                        <label class="remember-me">
                            <input type="checkbox" name="remember"> Remember me
                        </label>
                        <a href="#" class="forgot-link">Forgot password?</a>
                    </div>

                    <button type="submit" class="btn-primary">
                        <i class="fa fa-sign-in"></i> &nbsp;Sign In
                    </button>

                </form>

                <div class="social-login">
                    <button type="button" class="btn-google" onclick="window.location.href = '${pageContext.request.contextPath}/google-login';">
                        <i class="fa fa-google"></i>
                        <span>Sign in with Google</span>
                    </button>
                </div>

                <div class="divider">OR</div>

                <div class="auth-footer">
                    Don't have an account? &nbsp;
                    <a href="${pageContext.request.contextPath}/register">Create Account</a>
                </div>

            </div>
        </div>

    </body>
</html>
<script>
    function togglePassword() {
        const input   = document.getElementById('passwordInput');
        const eyeIcon = document.getElementById('eyeIcon');

        if (input.type === 'password') {
            input.type = 'text';
            eyeIcon.textContent = '🙈';  // đổi icon khi hiện mật khẩu
        } else {
            input.type = 'password';
            eyeIcon.textContent = '👁';  // về icon mắt bình thường
        }
    }
</script>
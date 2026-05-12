<%-- 
    Document   : Register
    Created on : Feb 17, 2026, 8:38:02 PM
    Author     : Lecoo
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Register - Electro</title>
        <link href="https://fonts.googleapis.com/css?family=Montserrat:400,500,600,700" rel="stylesheet">
        <link rel="stylesheet" href="css/font-awesome.min.css">
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
                max-width: 500px;
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
            .form-row {
                display: flex;
                gap: 16px;
            }
            .form-row .form-group {
                flex: 1;
            }
            .form-group {
                margin-bottom: 18px;
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
            .input-wrapper {
                position: relative;
            }
            .input-wrapper i {
                position: absolute;
                left: 14px;
                top: 50%;
                transform: translateY(-50%);
                color: var(--text-light);
                font-size: 14px;
                transition: color .2s;
                pointer-events: none;
            }
            .form-control {
                width: 100%;
                padding: 12px 14px 12px 40px;
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
            .input-wrapper:focus-within i {
                color: var(--primary);
            }

            /* STRENGTH BAR */
            .strength-bar {
                display: flex;
                gap: 4px;
                margin-top: 8px;
            }
            .strength-bar span {
                flex: 1;
                height: 3px;
                background: var(--border);
                border-radius: 2px;
                transition: background .3s;
            }
            .strength-label {
                font-size: 10px;
                font-weight: 600;
                letter-spacing: .5px;
                margin-top: 4px;
                color: var(--text-light);
            }

            /* TERMS */
            .terms-check {
                display: flex;
                align-items: flex-start;
                gap: 9px;
                margin-bottom: 22px;
                font-size: 12px;
                color: var(--text-light);
                line-height: 1.5;
            }
            .terms-check input {
                accent-color: var(--primary);
                width: 14px;
                height: 14px;
                margin-top: 2px;
                flex-shrink: 0;
            }
            .terms-check a {
                color: var(--primary);
                text-decoration: none;
                font-weight: 600;
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
                <h2>Create Account</h2>
                <p>Join Electro and start shopping today</p>
            </div>

            <div class="auth-card-body">

                <% if (request.getAttribute("error") != null) { %>
                <div class="alert-error">
                    <i class="fa fa-exclamation-circle"></i>
                    <%= request.getAttribute("error") %>
                </div>
                <% } %>

                <form action="${pageContext.request.contextPath}/register" method="POST">

                    <!-- First & Last Name -->
                    <div class="form-row">
                        <div class="form-group">
                            <label>First Name</label>
                            <div class="input-wrapper">
                                <input type="text" name="firstname" class="form-control"
                                       placeholder="John" value="${param.firstname}" required>
                                <i class="fa fa-user-o"></i>
                            </div>
                        </div>
                        <div class="form-group">
                            <label>Last Name</label>
                            <div class="input-wrapper">
                                <input type="text" name="lastname" class="form-control"
                                       placeholder="Doe" value="${param.lastname}" required>
                                <i class="fa fa-user-o"></i>
                            </div>
                        </div>
                    </div>

                    <!-- Email -->
                    <div class="form-group">
                        <label>Email Address</label>
                        <div class="input-wrapper">
                            <input type="email" name="email" class="form-control"
                                   placeholder="your@email.com" value="${param.email}" required>
                            <i class="fa fa-envelope-o"></i>
                        </div>
                    </div>

                    <!-- Phone -->
                    <div class="form-group">
                        <label>Phone Number</label>
                        <div class="input-wrapper">
                            <input type="tel" name="phone" class="form-control"
                                   placeholder="+84 900 000 000">
                            <i class="fa fa-phone"></i>
                        </div>
                    </div>

                    <!-- Password -->
                    <div class="form-group">
                        <label>Password</label>
                        <div class="input-wrapper">
                            <input type="password" name="password" id="password"
                                   class="form-control" placeholder="Tối thiểu 6 ký tự"
                                   required oninput="checkStrength(this.value)">
                            <i class="fa fa-lock"></i>
                        </div>
                        <div class="strength-bar">
                            <span id="s1"></span><span id="s2"></span>
                            <span id="s3"></span><span id="s4"></span>
                        </div>
                        <div class="strength-label" id="strength-label"></div>
                    </div>

                    <!-- Confirm Password -->
                    <div class="form-group">
                        <label>Confirm Password</label>
                        <div class="input-wrapper">
                            <input type="password" name="confirm_password" id="confirm"
                                   class="form-control" placeholder="Nhập lại mật khẩu"
                                   required oninput="checkMatch()">
                            <i class="fa fa-lock"></i>
                        </div>
                        <div class="strength-label" id="match-label"></div>
                    </div>

                    <!-- Terms -->
                    <div class="terms-check">
                        <input type="checkbox" name="terms" required>
                        <span>
                            Tôi đồng ý với <a href="#">Terms & Conditions</a>
                            và <a href="#">Privacy Policy</a> của Electro
                        </span>
                    </div>

                    <button type="submit" class="btn-primary">
                        <i class="fa fa-user-plus"></i> &nbsp;Create Account
                    </button>

                </form>

                <div class="divider">OR</div>

                <div class="auth-footer">
                    Already have an account? &nbsp;
                    <a href="${pageContext.request.contextPath}/login">Sign In</a>
                </div>

            </div>
        </div>

        <script>
            function checkStrength(val) {
                const colors = ['#e74c3c', '#e67e22', '#f1c40f', '#28a745'];
                const labels = ['Yếu', 'Trung bình', 'Khá', 'Mạnh'];
                let score = 0;
                if (val.length >= 6)
                    score++;
                if (/[A-Z]/.test(val))
                    score++;
                if (/[0-9]/.test(val))
                    score++;
                if (/[^A-Za-z0-9]/.test(val) && val.length >= 8)
                    score++;

                ['s1', 's2', 's3', 's4'].forEach((id, i) => {
                    document.getElementById(id).style.background = i < score ? colors[score - 1] : '#e0e0e0';
                });
                const label = document.getElementById('strength-label');
                label.textContent = val.length ? (labels[score - 1] || '') : '';
                label.style.color = val.length ? colors[score - 1] : '#999';
            }

            function checkMatch() {
                const pw = document.getElementById('password').value;
                const cfm = document.getElementById('confirm').value;
                const label = document.getElementById('match-label');
                if (!cfm) {
                    label.textContent = '';
                    return;
                }
                if (pw === cfm) {
                    label.textContent = '✓ Mật khẩu khớp';
                    label.style.color = '#28a745';
                } else {
                    label.textContent = '✗ Mật khẩu chưa khớp';
                    label.style.color = '#D10024';
                }
            }
        </script>
        
        <!-- Back to Home Button -->
        <div style="text-align: center; margin-top: 30px; padding: 20px;">
            <a href="home" 
               style="display: inline-flex; align-items: center; gap: 8px; padding: 12px 24px; background: linear-gradient(135deg, #667eea, #764ba2); color: white; text-decoration: none; border-radius: 8px; font-weight: 600; transition: all 0.3s ease;"
               onmouseover="this.style.transform='translateY(-2px)'; this.style.boxShadow='0 4px 20px rgba(102, 126, 234, 0.3)'"
               onmouseout="this.style.transform='translateY(0)'; this.style.boxShadow='none'">
                <i class="fa fa-home"></i>
                Về trang chủ
            </a>
        </div>
    </body>
</html>

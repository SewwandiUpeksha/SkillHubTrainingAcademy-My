
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>SkillHub Academy | Login</title>

    <link rel="icon"
          type="image/png"
          href="${pageContext.request.contextPath}/asserts/images/academyicon.png">

    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: "Segoe UI", Arial, sans-serif;
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 20px;
            background: linear-gradient(135deg, #101b3b, #174a7e, #3478a9);
        }

        .login-container {
            width: 100%;
            max-width: 430px;
            background: #ffffff;
            border-radius: 20px;
            padding: 42px 36px;
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.25);
        }

        .brand {
            text-align: center;
            margin-bottom: 32px;
        }

        .brand-icon {
            width: 70px;
            height: 70px;
            object-fit: contain;
            margin-bottom: 14px;
        }

        .brand h1 {
            font-size: 27px;
            color: #173b68;
            font-weight: 750;
            letter-spacing: -0.5px;
        }

        .brand p {
            color: #718096;
            font-size: 14px;
            margin-top: 8px;
        }

        .login-heading {
            font-size: 23px;
            color: #202b3c;
            margin-bottom: 8px;
        }

        .login-description {
            font-size: 14px;
            color: #788496;
            margin-bottom: 27px;
            line-height: 1.6;
        }

        .form-group {
            margin-bottom: 21px;
        }

        label {
            display: block;
            color: #344054;
            font-size: 14px;
            font-weight: 600;
            margin-bottom: 9px;
        }

        input {
            width: 100%;
            padding: 13px 14px;
            border: 1px solid #d5dce6;
            border-radius: 9px;
            outline: none;
            font-size: 14px;
            color: #202b3c;
            background: #fbfcfe;
            transition: border-color 0.2s, box-shadow 0.2s;
        }

        input::placeholder {
            color: #a0aaba;
        }

        input:focus {
            border-color: #3478d4;
            box-shadow: 0 0 0 3px rgba(52, 120, 212, 0.13);
            background: #ffffff;
        }

        .error-message {
            color: #b42318;
            background: #fef3f2;
            border: 1px solid #fecdca;
            padding: 12px 14px;
            border-radius: 8px;
            font-size: 14px;
            margin-bottom: 22px;
            line-height: 1.5;
        }

        .login-button {
            width: 100%;
            padding: 14px;
            margin-top: 5px;
            background: linear-gradient(135deg, #2563b9, #174a7e);
            color: #ffffff;
            border: none;
            border-radius: 9px;
            font-size: 15px;
            font-weight: 650;
            cursor: pointer;
            transition: transform 0.2s, box-shadow 0.2s;
        }

        .login-button:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 18px rgba(37, 99, 185, 0.25);
        }

        .login-button:active {
            transform: translateY(0);
        }

        .footer-text {
            text-align: center;
            color: #8993a3;
            font-size: 12px;
            margin-top: 28px;
            line-height: 1.6;
        }

        @media (max-width: 480px) {
            .login-container {
                padding: 32px 24px;
            }

            .brand h1 {
                font-size: 24px;
            }
        }
    </style>
</head>

<body>

<div class="login-container">

    <div class="brand">
        <img class="brand-icon"
             src="${pageContext.request.contextPath}/asserts/images/academyicon.png"
             alt="SkillHub Academy Logo">

        <h1>SkillHub Academy</h1>
        <p>Training &amp; Professional Development</p>
    </div>

    <h2 class="login-heading">Welcome Back!</h2>

    <p class="login-description">
        Sign in to access your training management dashboard.
    </p>

    <%
    String error = (String) request.getAttribute("error");

    if (error != null) {
    %>

    <div class="error-message" role="alert">
        <%= error %>
    </div>

    <%
    }
    %>

    <form action="${pageContext.request.contextPath}/login" method="post">

        <div class="form-group">
            <label for="username">Username</label>
            <input
                    type="text"
                    id="username"
                    name="username"
                    placeholder="Enter your username"
                    autocomplete="username"
                    required>
        </div>

        <div class="form-group">
            <label for="password">Password</label>
            <input
                    type="password"
                    id="password"
                    name="password"
                    placeholder="Enter your password"
                    autocomplete="current-password"
                    required>
        </div>

        <button type="submit" class="login-button">
            Log In
        </button>

    </form>

    <div class="footer-text">
        &copy; 2026 SkillHub Training Academy<br>
        Empowering Skills. Building Futures.
    </div>

</div>

</body>
</html>
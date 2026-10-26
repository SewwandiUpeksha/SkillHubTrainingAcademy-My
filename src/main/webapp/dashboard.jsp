<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="lk.jiat.academy.model.User" %>

<%
User user = (User) session.getAttribute("loggedUser");

if (user == null) {
response.sendRedirect(
request.getContextPath() + "/login.jsp");
return;
}
%>


<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>SkillHub Academy | Dashboard</title>

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
            background: #f3f6fb;
            color: #253247;
        }

        /* Top navigation */
        .navbar {
            background: #ffffff;
            min-height: 76px;
            padding: 15px 6%;
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 20px;
            box-shadow: 0 2px 12px rgba(23, 59, 104, 0.07);
        }

        .brand {
            display: flex;
            align-items: center;
            gap: 13px;
        }

        .brand img {
            width: 45px;
            height: 45px;
            object-fit: contain;
        }

        .brand h1 {
            font-size: 21px;
            color: #173b68;
            font-weight: 750;
        }

        .brand p {
            color: #7b8798;
            font-size: 12px;
            margin-top: 3px;
        }

        .nav-right {
            display: flex;
            align-items: center;
            gap: 18px;
        }

        .user-info {
            text-align: right;
        }

        .user-info strong {
            display: block;
            font-size: 14px;
            color: #253247;
        }

        .user-info span {
            display: inline-block;
            margin-top: 4px;
            font-size: 11px;
            color: #2563b9;
            background: #eaf2ff;
            padding: 4px 9px;
            border-radius: 20px;
        }

        .logout-button {
            padding: 10px 17px;
            border: 1px solid #e1a5a5;
            border-radius: 8px;
            background: #ffffff;
            color: #b42318;
            font-size: 13px;
            font-weight: 600;
            cursor: pointer;
            transition: background 0.2s, color 0.2s;
        }

        .logout-button:hover {
            background: #b42318;
            color: #ffffff;
        }

        /* Main content */
        .container {
            width: 88%;
            max-width: 1250px;
            margin: 38px auto;
        }

        .welcome-banner {
            background: linear-gradient(120deg, #173b68, #2563b9, #3478a9);
            color: #ffffff;
            padding: 36px 38px;
            border-radius: 17px;
            position: relative;
            overflow: hidden;
            box-shadow: 0 10px 28px rgba(37, 99, 185, 0.15);
        }

        .welcome-banner h2 {
            font-size: 29px;
            margin-bottom: 12px;
        }

        .welcome-banner p {
            color: #e3edff;
            font-size: 15px;
            line-height: 1.7;
            max-width: 600px;
        }

        .welcome-label {
            display: inline-block;
            margin-bottom: 15px;
            padding: 6px 12px;
            border-radius: 20px;
            background: rgba(255, 255, 255, 0.15);
            font-size: 12px;
            letter-spacing: 0.5px;
        }

        .section-heading {
            margin: 35px 0 19px;
        }

        .section-heading h2 {
            font-size: 21px;
            color: #203b5c;
        }

        .section-heading p {
            margin-top: 6px;
            font-size: 14px;
            color: #7b8798;
        }

        /* Dashboard cards */
        .dashboard-grid {
            display: grid;
            grid-template-columns: repeat(3, minmax(0, 1fr));
            gap: 20px;
        }

        .dashboard-card {
            background: #ffffff;
            border: 1px solid #e7edf5;
            border-radius: 14px;
            padding: 25px;
            min-height: 185px;
            box-shadow: 0 4px 15px rgba(31, 54, 86, 0.035);
            transition: transform 0.2s, box-shadow 0.2s;
        }

        .dashboard-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 10px 25px rgba(31, 54, 86, 0.09);
        }

        .card-icon {
            display: flex;
            justify-content: center;
            align-items: center;
            width: 48px;
            height: 48px;
            border-radius: 12px;
            background: #eaf2ff;
            color: #2563b9;
            font-size: 23px;
            margin-bottom: 19px;
        }

        .dashboard-card h3 {
            color: #253b58;
            font-size: 17px;
            margin-bottom: 9px;
        }

        .dashboard-card p {
            color: #7b8798;
            font-size: 13px;
            line-height: 1.7;
        }

        /* Account information */
        .account-panel {
            margin-top: 25px;
            padding: 26px;
            background: #ffffff;
            border: 1px solid #e7edf5;
            border-radius: 14px;
        }

        .account-panel h3 {
            color: #203b5c;
            font-size: 18px;
            margin-bottom: 20px;
        }

        .account-details {
            display: grid;
            grid-template-columns: repeat(3, minmax(0, 1fr));
            gap: 20px;
        }

        .detail-item {
            padding: 15px;
            background: #f7f9fc;
            border-radius: 9px;
            overflow-wrap: anywhere;
        }

        .detail-item span {
            display: block;
            color: #7b8798;
            font-size: 12px;
            margin-bottom: 8px;
        }

        .detail-item strong {
            color: #253b58;
            font-size: 14px;
        }

        /* Footer */
        .footer {
            padding: 25px 15px;
            text-align: center;
            color: #8a96a7;
            font-size: 12px;
            margin-top: 20px;
        }

        @media (max-width: 850px) {
            .dashboard-grid {
                grid-template-columns: repeat(2, minmax(0, 1fr));
            }

            .account-details {
                grid-template-columns: 1fr;
            }

            .container {
                width: 92%;
            }
        }

        @media (max-width: 550px) {
            .navbar {
                padding: 15px 4%;
                align-items: flex-start;
                flex-direction: column;
            }

            .nav-right {
                width: 100%;
                justify-content: space-between;
            }

            .container {
                margin: 22px auto;
            }

            .welcome-banner {
                padding: 27px 23px;
            }

            .welcome-banner h2 {
                font-size: 24px;
            }

            .dashboard-grid {
                grid-template-columns: 1fr;
            }

            .dashboard-card {
                min-height: auto;
            }

            .brand h1 {
                font-size: 18px;
            }
        }
    </style>
</head>

<body>

<header class="navbar">

    <div class="brand">
        <img
                src="${pageContext.request.contextPath}/asserts/images/academyicon.png"
                alt="SkillHub Academy Logo">

        <div>
            <h1>SkillHub Academy</h1>
            <p>Training Management Portal</p>
        </div>
    </div>

    <div class="nav-right">

        <div class="user-info">
            <strong><%= user.getDisplayName() %></strong>
            <span><%= user.getRole() %></span>
        </div>


        <form action="${pageContext.request.contextPath}/logout"
              method="post">
            <button type="submit" class="logout-button">Logout</button>
        </form>


    </div>

</header>

<main class="container">

    <section class="welcome-banner">

        <span class="welcome-label">SKILLHUB LEARNING PORTAL</span>

        <h2>Welcome back, <%= user.getDisplayName() %>!</h2>

        <p>
            You have successfully logged in to SkillHub Training Academy.
            Access your training information and explore the services
            available to your account.
        </p>

    </section>

    <section class="section-heading">
        <h2>Your Dashboard</h2>
        <p>
            <% if ("STUDENT".equals(user.getRole())) { %>
            Manage your learning activities from one place.
            <% } else if ("ADMIN".equals(user.getRole())) { %>
            Access the main training administration functions.
            <% } else { %>
            View your account information and available services.
            <% } %>
        </p>
    </section>

    <section class="dashboard-grid">

        <% if ("STUDENT".equals(user.getRole())) { %>

        <article class="dashboard-card">
            <div class="card-icon">&#128218;</div>
            <h3>Available Courses</h3>
            <p>Explore courses, descriptions, trainers, and course fees.</p>

            <a href="${pageContext.request.contextPath}/available-courses">
                View Courses
            </a>
        </article>

        <article class="dashboard-card">
            <div class="card-icon">&#128203;</div>
            <h3>My Enrolments</h3>
            <p>Review your course enrolment information.</p>
            <a href="${pageContext.request.contextPath}/my-enrolments">
                View Enrolments
            </a>
        </article>


        <article class="dashboard-card">
            <div class="card-icon">&#128197;</div>
            <h3>My Attendance</h3>
            <p>View your attendance records for enrolled courses.</p>
            <a href="${pageContext.request.contextPath}/my-attendance">
                View Attendance
            </a>
        </article>


        <% } else if ("ADMIN".equals(user.getRole())) { %>


        <article class="dashboard-card">
            <div class="card-icon">&#128101;</div>

            <h3>Student Management</h3>

            <p>
                Access student registration and student information.
            </p>

            <a href="${pageContext.request.contextPath}/students">
                Manage Students
            </a>
        </article>


        <article class="dashboard-card">
            <div class="card-icon">&#127891;</div>
            <h3>Course Management</h3>
            <p>Review training courses and course details.</p>
            <a href="${pageContext.request.contextPath}/courses">
                Manage Courses
            </a>
        </article>

        <article class="dashboard-card">
            <div class="card-icon">&#128104;&#8205;&#127979;</div>
            <h3>Trainer Management</h3>
            <p>Access trainer information and professional details.</p>

            <a href="${pageContext.request.contextPath}/trainers">
                Manage Trainers
            </a>

        </article>


        <article class="dashboard-card">
            <div class="card-icon">&#128197;</div>
            <h3>Attendance Management</h3>
            <p>Record and view student attendance.</p>
            <a href="${pageContext.request.contextPath}/attendance">
                Manage Attendance
            </a>
        </article>


        <% } %>

    </section>

    <section class="account-panel">

        <h3>Account Information</h3>

        <div class="account-details">

            <div class="detail-item">
                <span>Display Name</span>
                <strong><%= user.getDisplayName() %></strong>
            </div>

            <div class="detail-item">
                <span>Username</span>
                <strong><%= user.getUsername() %></strong>
            </div>

            <div class="detail-item">
                <span>Account Role</span>
                <strong><%= user.getRole() %></strong>
            </div>

        </div>

    </section>

        <br/><br/>

    <p>
        Active Sessions:
        <%= application.getAttribute("activeSessions") == null
        ? 0
        : application.getAttribute("activeSessions") %>
    </p>

</main>

<footer class="footer">
    &copy; 2026 SkillHub Training Academy. All rights reserved.
    <br><br>
    Empowering Skills . Building Futures.
</footer>

</body>
</html>
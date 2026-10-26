
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="lk.jiat.academy.model.Course" %>

<%
List<Course> myCourses =
  (List<Course>) request.getAttribute("myCourses");

    if (myCourses == null) {
    response.sendRedirect(
    request.getContextPath() + "/my-enrolments");
    return;
    }

    String status = request.getParameter("status");
    %>

    <!DOCTYPE html>
    <html lang="en">
    <head>
      <meta charset="UTF-8">
      <meta name="viewport" content="width=device-width, initial-scale=1.0">

      <title>My Enrolments | SkillHub Academy</title>

      <!-- Academy favicon -->
      <link rel="icon" type="image/png"
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

        /* Header */
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
          flex-shrink: 0;
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

        /* Main content */
        .container {
          width: 88%;
          max-width: 1400px;
          margin: 38px auto;
        }

        .page-header {
          margin-bottom: 25px;
        }

        .page-header h2 {
          font-size: 27px;
          color: #203b5c;
          margin-bottom: 10px;
        }

        .page-header p {
          font-size: 14px;
          line-height: 1.7;
          color: #7b8798;
        }

        /* Enrolment panel */
        .enrolment-panel {
          background: #ffffff;
          padding: 28px;
          border: 1px solid #e7edf5;
          border-radius: 14px;
          box-shadow: 0 4px 15px rgba(31, 54, 86, 0.04);
        }

        .total-courses {
          margin-bottom: 20px;
          color: #2563b9;
          font-size: 15px;
          font-weight: 600;
        }

        /* Status messages */
        .message {
          padding: 13px 16px;
          margin-bottom: 20px;
          border-radius: 8px;
          font-size: 14px;
          line-height: 1.5;
        }

        .success-message {
          background: #e9f8ef;
          color: #187443;
          border: 1px solid #bce8cc;
        }

        .info-message {
          background: #eef5ff;
          color: #24579b;
          border: 1px solid #cbdfff;
        }

        /* Responsive table */
        .table-wrapper {
          width: 100%;
          overflow-x: auto;
        }

        table {
          width: 100%;
          border-collapse: collapse;
          background: #ffffff;
        }

        thead {
          background: #173b68;
          color: #ffffff;
        }

        th,
        td {
          padding: 15px 18px;
          text-align: left;
          border-bottom: 1px solid #e7edf5;
          font-size: 14px;
          line-height: 1.6;
        }

        th {
          font-weight: 600;
          white-space: nowrap;
        }

        tbody tr {
          transition: background 0.2s ease;
        }

        tbody tr:hover {
          background: #f3f7fd;
        }

        tbody tr:last-child td {
          border-bottom: none;
        }

        .empty-message {
          text-align: center;
          color: #7b8798;
          padding: 25px;
        }

        .fee {
          white-space: nowrap;
          font-weight: 600;
          color: #203b5c;
        }

        /* Navigation buttons */
        .actions {
          display: flex;
          flex-wrap: wrap;
          gap: 12px;
          margin-top: 25px;
        }

        .button {
          display: inline-block;
          padding: 11px 18px;
          background: #173b68;
          color: #ffffff;
          text-decoration: none;
          border: none;
          border-radius: 8px;
          font-size: 14px;
          font-weight: 600;
          transition: background 0.2s ease;
        }

        .button:hover {
          background: #2563b9;
        }

        .secondary-button {
          background: #e9eff8;
          color: #173b68;
        }

        .secondary-button:hover {
          background: #d9e5f5;
        }

        /* Footer */
        .footer {
          padding: 25px 15px;
          text-align: center;
          color: #8a96a7;
          font-size: 12px;
          margin-top: 20px;
        }

        /* Responsive layout */
        @media (max-width: 850px) {
          .container {
            width: 92%;
          }
        }

        @media (max-width: 550px) {
          .navbar {
            padding: 15px 4%;
          }

          .brand img {
            width: 40px;
            height: 40px;
          }

          .brand h1 {
            font-size: 18px;
          }

          .brand p {
            font-size: 11px;
          }

          .container {
            margin: 22px auto;
          }

          .page-header h2 {
            font-size: 23px;
          }

          .enrolment-panel {
            padding: 18px;
          }

          th,
          td {
            padding: 12px;
            font-size: 13px;
          }

          .button {
            text-align: center;
          }
        }
      </style>
    </head>

    <body>

    <!-- Academy header -->
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
    </header>

    <!-- Main content -->
    <main class="container">

      <section class="page-header">
        <h2>My Enrolments</h2>
        <p>View the courses you have enrolled in at SkillHub Academy.</p>
      </section>

      <section class="enrolment-panel">

        <!-- Enrolment status -->
        <% if ("success".equals(status)) { %>
        <div class="message success-message">
          Successfully enrolled in the course.
        </div>
        <% } else if ("alreadyEnrolled".equals(status)) { %>
        <div class="message info-message">
          You are already enrolled in this course.
        </div>
        <% } %>

        <p class="total-courses">
          Total Enrolled Courses: <%= myCourses.size() %>
        </p>

        <div class="table-wrapper">
          <table>
            <thead>
            <tr>
              <th>Course ID</th>
              <th>Course Title</th>
              <th>Description</th>
              <th>Trainer</th>
              <th>Fee (LKR)</th>
            </tr>
            </thead>

            <tbody>
            <% if (myCourses.isEmpty()) { %>
            <tr>
              <td colspan="5" class="empty-message">
                You have not enrolled in any courses yet.
              </td>
            </tr>
            <% } else {
            for (Course course : myCourses) { %>
            <tr>
              <td><%= course.getId() %></td>
              <td><%= course.getTitle() %></td>
              <td><%= course.getDescription() %></td>
              <td><%= course.getTrainer() %></td>
              <td class="fee">
                <%= String.format("%,.2f", course.getFee()) %>
              </td>
            </tr>
            <%  }
            } %>
            </tbody>
          </table>
        </div>

        <!-- Navigation -->
        <div class="actions">
          <a class="button"
             href="<%= request.getContextPath() %>/available-courses">
            Go to Available Courses
          </a>

          <a class="button secondary-button"
             href="<%= request.getContextPath() %>/dashboard">
            Back to Dashboard
          </a>
        </div>

      </section>

    </main>

    <!-- Footer -->
    <footer class="footer">
      &copy; 2026 SkillHub Training Academy. All rights reserved.
      <br><br>
      Empowering Skills . Building Futures.
    </footer>

    </body>
    </html>

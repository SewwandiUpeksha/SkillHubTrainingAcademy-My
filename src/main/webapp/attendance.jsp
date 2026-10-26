
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="lk.jiat.academy.model.Student" %>
<%@ page import="lk.jiat.academy.model.Course" %>
<%@ page import="lk.jiat.academy.model.Attendance" %>

<%
List<Student> students =
  (List<Student>) request.getAttribute("students");

    List<Course> courses =
      (List<Course>) request.getAttribute("courses");

        List<Attendance> attendance =
          (List<Attendance>) request.getAttribute("attendance");

            String status = request.getParameter("status");
            %>

            <!DOCTYPE html>
            <html lang="en">
            <head>
              <meta charset="UTF-8">
              <meta name="viewport" content="width=device-width, initial-scale=1.0">

              <title>Attendance Management | SkillHub Academy</title>

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

                /* Panels */
                .panel {
                  background: #ffffff;
                  padding: 28px;
                  border: 1px solid #e7edf5;
                  border-radius: 14px;
                  box-shadow: 0 4px 15px rgba(31, 54, 86, 0.04);
                  margin-bottom: 25px;
                }

                .panel h3 {
                  font-size: 19px;
                  color: #203b5c;
                  margin-bottom: 22px;
                }

                /* Status messages */
                .message {
                  padding: 13px 16px;
                  margin-bottom: 22px;
                  border-radius: 8px;
                  font-size: 14px;
                  line-height: 1.6;
                }

                .success-message {
                  background: #e9f8ef;
                  color: #187443;
                  border: 1px solid #bce8cc;
                }

                .error-message {
                  background: #fdecec;
                  color: #b42318;
                  border: 1px solid #f5c2c2;
                }

                .info-message {
                  background: #eef5ff;
                  color: #24579b;
                  border: 1px solid #cbdfff;
                }

                /* Attendance form */
                .attendance-form {
                  display: grid;
                  grid-template-columns: repeat(2, minmax(0, 1fr));
                  gap: 22px;
                }

                .form-group {
                  display: flex;
                  flex-direction: column;
                  gap: 8px;
                  min-width: 0;
                }

                .form-group label {
                  color: #34445a;
                  font-size: 14px;
                  font-weight: 600;
                }

                .form-group select,
                .form-group input {
                  width: 100%;
                  min-height: 44px;
                  padding: 10px 12px;
                  border: 1px solid #d6dfeb;
                  border-radius: 8px;
                  background: #ffffff;
                  color: #253247;
                  font-family: inherit;
                  font-size: 14px;
                  outline: none;
                  transition: border-color 0.2s, box-shadow 0.2s;
                }

                .form-group select:focus,
                .form-group input:focus {
                  border-color: #2563b9;
                  box-shadow: 0 0 0 3px rgba(37, 99, 185, 0.12);
                }

                .form-actions {
                  grid-column: 1 / -1;
                }

                .save-button {
                  display: inline-block;
                  padding: 12px 20px;
                  background: #173b68;
                  color: #ffffff;
                  border: none;
                  border-radius: 8px;
                  font-family: inherit;
                  font-size: 14px;
                  font-weight: 600;
                  cursor: pointer;
                  transition: background 0.2s ease;
                }

                .save-button:hover {
                  background: #2563b9;
                }

                /* Attendance records table */
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
                  line-height: 1.5;
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

                /* Status badges */
                .status-badge {
                  display: inline-block;
                  padding: 5px 12px;
                  border-radius: 20px;
                  font-size: 12px;
                  font-weight: 600;
                  white-space: nowrap;
                }

                .present {
                  background: #e5f7ec;
                  color: #187443;
                }

                .absent {
                  background: #fdecec;
                  color: #b42318;
                }

                .other-status {
                  background: #eef2f7;
                  color: #536277;
                }

                /* Navigation */
                .back-link {
                  display: inline-block;
                  margin-top: 0;
                  padding: 11px 18px;
                  background: #173b68;
                  color: #ffffff;
                  text-decoration: none;
                  border-radius: 8px;
                  font-size: 14px;
                  font-weight: 600;
                  transition: background 0.2s ease;
                }

                .back-link:hover {
                  background: #2563b9;
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

                  .attendance-form {
                    grid-template-columns: 1fr;
                  }

                  .form-actions {
                    grid-column: auto;
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

                  .panel {
                    padding: 18px;
                  }

                  th,
                  td {
                    padding: 12px;
                    font-size: 13px;
                  }

                  .save-button {
                    width: 100%;
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
                <h2>Attendance Management</h2>
                <p>Record and manage student attendance for academy courses.</p>
              </section>

              <!-- Feedback messages -->
              <% if ("success".equals(status)) { %>
              <div class="message success-message">
                Attendance recorded successfully.
              </div>
              <% } else if ("duplicate".equals(status)) { %>
              <div class="message info-message">
                Attendance has already been recorded for this student,
                course, and date.
              </div>
              <% } else if ("notEnrolled".equals(status)) { %>
              <div class="message error-message">
                Invalid student or course, or the student is not enrolled.
              </div>
              <% } else if ("invalid".equals(status)) { %>
              <div class="message error-message">
                Please enter a valid date and attendance status.
              </div>
              <% } %>

              <!-- Record attendance form -->
              <section class="panel">
                <h3>Record Attendance</h3>

                <form class="attendance-form"
                      action="<%= request.getContextPath() %>/attendance"
                      method="post">

                  <div class="form-group">
                    <label for="studentId">Student</label>

                    <select id="studentId" name="studentId" required>
                      <option value="">Select Student</option>

                      <% if (students != null) {
                      for (Student student : students) { %>
                      <option value="<%= student.getId() %>">
                        <%= student.getId() %> -
                        <%= student.getName() %>
                      </option>
                      <%  }
                      } %>
                    </select>
                  </div>

                  <div class="form-group">
                    <label for="courseId">Course</label>

                    <select id="courseId" name="courseId" required>
                      <option value="">Select Course</option>

                      <% if (courses != null) {
                      for (Course course : courses) { %>
                      <option value="<%= course.getId() %>">
                        <%= course.getId() %> -
                        <%= course.getTitle() %>
                      </option>
                      <%  }
                      } %>
                    </select>
                  </div>

                  <div class="form-group">
                    <label for="date">Attendance Date</label>

                    <input type="date"
                           id="date"
                           name="date"
                           max="<%= java.time.LocalDate.now() %>"
                           required>
                  </div>

                  <div class="form-group">
                    <label for="attendanceStatus">Attendance Status</label>

                    <select id="attendanceStatus" name="status" required>
                      <option value="PRESENT">Present</option>
                      <option value="ABSENT">Absent</option>
                    </select>
                  </div>

                  <div class="form-actions">
                    <button class="save-button" type="submit">
                      Save Attendance
                    </button>
                  </div>

                </form>
              </section>

              <!-- Attendance records -->
              <section class="panel">
                <h3>Attendance Records</h3>

                <div class="table-wrapper">
                  <table>
                    <thead>
                    <tr>
                      <th>Student ID</th>
                      <th>Course ID</th>
                      <th>Date</th>
                      <th>Status</th>
                    </tr>
                    </thead>

                    <tbody>
                    <% if (attendance == null || attendance.isEmpty()) { %>
                    <tr>
                      <td colspan="4" class="empty-message">
                        No attendance records available.
                      </td>
                    </tr>
                    <% } else {
                    synchronized (attendance) {
                    for (Attendance record : attendance) {
                    String attendanceStatus = record.getStatus();
                    String statusClass = "other-status";

                    if ("PRESENT".equalsIgnoreCase(attendanceStatus)) {
                    statusClass = "present";
                    } else if ("ABSENT".equalsIgnoreCase(attendanceStatus)) {
                    statusClass = "absent";
                    }
                    %>
                    <tr>
                      <td><%= record.getStudentId() %></td>
                      <td><%= record.getCourseId() %></td>
                      <td><%= record.getDate() %></td>
                      <td>
                                <span class="status-badge <%= statusClass %>">
                                    <%= attendanceStatus %>
                                </span>
                      </td>
                    </tr>
                    <%      }
                    }
                    } %>
                    </tbody>
                  </table>
                </div>
              </section>

              <a class="back-link"
                 href="<%= request.getContextPath() %>/dashboard">
                Back to Dashboard
              </a>

            </main>

            <!-- Footer -->
            <footer class="footer">
              &copy; 2026 SkillHub Training Academy. All rights reserved.
              <br><br>
              Empowering Skills . Building Futures.
            </footer>

            </body>
            </html>

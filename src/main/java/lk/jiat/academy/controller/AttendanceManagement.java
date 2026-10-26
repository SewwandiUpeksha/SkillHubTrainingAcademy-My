
package lk.jiat.academy.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import lk.jiat.academy.model.User;

import java.io.IOException;
import java.time.LocalDate;
import java.util.List;

@WebServlet("/attendance")
public class AttendanceManagement extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null ||
                session.getAttribute("loggedUser") == null) {
            response.sendRedirect(
                    request.getContextPath() + "/login.jsp");
            return;
        }

        User user = (User) session.getAttribute("loggedUser");

        if (!"ADMIN".equals(user.getRole())) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN);
            return;
        }

        request.setAttribute("students",
                getServletContext().getAttribute("students"));
        request.setAttribute("courses",
                getServletContext().getAttribute("courses"));
        request.setAttribute("attendance",
                getServletContext().getAttribute("attendance"));

        request.getRequestDispatcher("/attendance.jsp")
                .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        String contextPath = request.getContextPath();

        HttpSession session = request.getSession(false);

        if (session == null ||
                session.getAttribute("loggedUser") == null) {
            response.sendRedirect(contextPath + "/login.jsp");
            return;
        }

        User user = (User) session.getAttribute("loggedUser");

        if (!"ADMIN".equals(user.getRole())) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN);
            return;
        }

        String studentId = request.getParameter("studentId");
        String courseId = request.getParameter("courseId");
        String date = request.getParameter("date");
        String status = request.getParameter("status");

        if (studentId == null || courseId == null ||
                date == null || status == null) {
            response.sendRedirect(
                    contextPath + "/attendance?status=invalid");
            return;
        }

        studentId = studentId.trim();
        courseId = courseId.trim();
        date = date.trim();
        status = status.trim().toUpperCase();

        // Validate date and attendance status
        try {
            LocalDate attendanceDate = LocalDate.parse(date);

            if (attendanceDate.isAfter(LocalDate.now()) ||
                    !(status.equals("PRESENT") ||
                            status.equals("ABSENT"))) {
                response.sendRedirect(
                        contextPath + "/attendance?status=invalid");
                return;
            }
        } catch (java.time.format.DateTimeParseException e) {
            response.sendRedirect(
                    contextPath + "/attendance?status=invalid");
            return;
        }

        List<lk.jiat.academy.model.Student> students =
                (List<lk.jiat.academy.model.Student>)
                        getServletContext().getAttribute("students");

        List<lk.jiat.academy.model.Course> courses =
                (List<lk.jiat.academy.model.Course>)
                        getServletContext().getAttribute("courses");

        List<lk.jiat.academy.model.Enrolments> enrolments =
                (List<lk.jiat.academy.model.Enrolments>)
                        getServletContext().getAttribute("enrolments");

        List<lk.jiat.academy.model.Attendance> attendance =
                (List<lk.jiat.academy.model.Attendance>)
                        getServletContext().getAttribute("attendance");

        if (students == null || courses == null ||
                enrolments == null || attendance == null) {
            response.sendError(
                    HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            return;
        }

        boolean studentExists = false;
        boolean courseExists = false;
        boolean enrolled = false;

        synchronized (students) {
            for (lk.jiat.academy.model.Student student : students) {
                if (student.getId().equals(studentId)) {
                    studentExists = true;
                    break;
                }
            }
        }

        synchronized (courses) {
            for (lk.jiat.academy.model.Course course : courses) {
                if (course.getId().equals(courseId)) {
                    courseExists = true;
                    break;
                }
            }
        }

        synchronized (enrolments) {
            for (lk.jiat.academy.model.Enrolments enrolment : enrolments) {
                if (enrolment.getStudentId().equals(studentId) &&
                        enrolment.getCourseId().equals(courseId)) {
                    enrolled = true;
                    break;
                }
            }
        }

        if (!studentExists || !courseExists || !enrolled) {
            response.sendRedirect(
                    contextPath + "/attendance?status=notEnrolled");
            return;
        }

        synchronized (attendance) {

            for (lk.jiat.academy.model.Attendance record : attendance) {
                if (record.getStudentId().equals(studentId) &&
                        record.getCourseId().equals(courseId) &&
                        record.getDate().equals(date)) {
                    response.sendRedirect(
                            contextPath + "/attendance?status=duplicate");
                    return;
                }
            }

            attendance.add(
                    new lk.jiat.academy.model.Attendance(
                            studentId, courseId, date, status));
        }

        response.sendRedirect(
                contextPath + "/attendance?status=success");
    }
}


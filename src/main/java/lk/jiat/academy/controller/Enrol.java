
package lk.jiat.academy.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import lk.jiat.academy.model.User;

import java.io.IOException;
import java.util.List;

@WebServlet("/enrol")
public class Enrol extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        String contextPath = request.getContextPath();

        // Check login
        HttpSession session = request.getSession(false);

        if (session == null ||
                session.getAttribute("loggedUser") == null) {

            response.sendRedirect(contextPath + "/login.jsp");
            return;
        }

        User user = (User) session.getAttribute("loggedUser");

        // Only students can enrol
        if (!"STUDENT".equals(user.getRole())) {
            response.sendError(
                    HttpServletResponse.SC_FORBIDDEN,
                    "Only students can enrol in courses.");
            return;
        }

        String courseId = request.getParameter("courseId");

        if (courseId == null || courseId.trim().isEmpty()) {
            response.sendRedirect(
                    contextPath + "/available-courses");
            return;
        }

        courseId = courseId.trim();

        // Retrieve shared application data
        List<lk.jiat.academy.model.Student> students =
                (List<lk.jiat.academy.model.Student>) getServletContext().getAttribute("students");

        List<lk.jiat.academy.model.Course> courses =
                (List<lk.jiat.academy.model.Course>) getServletContext().getAttribute("courses");

        List<lk.jiat.academy.model.Enrolments> enrolments =
                (List<lk.jiat.academy.model.Enrolments>) getServletContext().getAttribute("enrolments");

        if (students == null || courses == null || enrolments == null) {
            response.sendError(
                    HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                    "Application data is unavailable.");
            return;
        }

        /*
         * In the current sample data, the logged-in student's
         * display name matches the student's name in students.
         */
        String studentId = null;

        synchronized (students) {
            for (lk.jiat.academy.model.Student student : students) {
                if (student.getName().equals(user.getDisplayName())) {
                    studentId = student.getId();
                    break;
                }
            }
        }

        if (studentId == null) {
            response.sendRedirect(
                    contextPath + "/available-courses?status=studentNotFound");
            return;
        }

        // Confirm that the selected course exists
        boolean courseExists = false;

        synchronized (courses) {
            for (lk.jiat.academy.model.Course course : courses) {
                if (course.getId().equals(courseId)) {
                    courseExists = true;
                    break;
                }
            }
        }

        if (!courseExists) {
            response.sendRedirect(
                    contextPath + "/available-courses?status=invalidCourse");
            return;
        }

        // Prevent duplicate enrolments
        synchronized (enrolments) {

            for (lk.jiat.academy.model.Enrolments enrolment : enrolments) {
                if (enrolment.getStudentId().equals(studentId)
                        && enrolment.getCourseId().equals(courseId)) {

                    response.sendRedirect(
                            contextPath + "/my-enrolments?status=alreadyEnrolled");
                    return;
                }
            }

            // Create and store the enrolment
            enrolments.add(
                    new lk.jiat.academy.model.Enrolments(
                            studentId, courseId));
        }

        response.sendRedirect(
                contextPath + "/my-enrolments?status=success");
    }
}


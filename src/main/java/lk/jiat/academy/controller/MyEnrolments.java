
package lk.jiat.academy.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import lk.jiat.academy.model.User;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/my-enrolments")
public class MyEnrolments extends HttpServlet {

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

        if (!"STUDENT".equals(user.getRole())) {
            response.sendError(
                    HttpServletResponse.SC_FORBIDDEN,
                    "Only students can view their enrolments.");
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

        if (students == null || courses == null || enrolments == null) {
            response.sendError(
                    HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                    "Application data is unavailable.");
            return;
        }

        // Find the logged-in student's ID
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
            response.sendError(
                    HttpServletResponse.SC_NOT_FOUND,
                    "Student record not found.");
            return;
        }

        // Find the courses belonging to this student
        List<lk.jiat.academy.model.Course> myCourses =
                new ArrayList<>();

        synchronized (enrolments) {
            synchronized (courses) {

                for (lk.jiat.academy.model.Enrolments enrolment
                        : enrolments) {

                    if (enrolment.getStudentId().equals(studentId)) {

                        for (lk.jiat.academy.model.Course course : courses) {

                            if (course.getId().equals(
                                    enrolment.getCourseId())) {

                                myCourses.add(course);
                                break;
                            }
                        }
                    }
                }
            }
        }

        request.setAttribute("myCourses", myCourses);

        request.getRequestDispatcher("/my-enrolments.jsp")
                .forward(request, response);
    }
}


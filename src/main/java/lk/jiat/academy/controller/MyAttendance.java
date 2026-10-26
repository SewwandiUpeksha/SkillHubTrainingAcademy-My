
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

@WebServlet("/my-attendance")
public class MyAttendance extends HttpServlet {

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
            response.sendError(HttpServletResponse.SC_FORBIDDEN);
            return;
        }

        List<lk.jiat.academy.model.Student> students =
                (List<lk.jiat.academy.model.Student>)
                        getServletContext().getAttribute("students");

        List<lk.jiat.academy.model.Attendance> attendance =
                (List<lk.jiat.academy.model.Attendance>)
                        getServletContext().getAttribute("attendance");

        List<lk.jiat.academy.model.Course> courses =
                (List<lk.jiat.academy.model.Course>)
                        getServletContext().getAttribute("courses");

        if (students == null || attendance == null || courses == null) {
            response.sendError(
                    HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            return;
        }

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

        List<lk.jiat.academy.model.Attendance> myAttendance =
                new ArrayList<>();

        synchronized (attendance) {
            for (lk.jiat.academy.model.Attendance record : attendance) {
                if (record.getStudentId().equals(studentId)) {
                    myAttendance.add(record);
                }
            }
        }

        request.setAttribute("myAttendance", myAttendance);
        request.setAttribute("courses", courses);

        request.getRequestDispatcher("/my-attendance.jsp")
                .forward(request, response);
    }
}


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

@WebServlet("/available-courses")
public class AvailableCourses extends HttpServlet {

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
                    "Only students can access available courses.");
            return;
        }

        List<lk.jiat.academy.model.Course> courses = (List<lk.jiat.academy.model.Course>) getServletContext().getAttribute("courses");

        request.setAttribute("courses", courses);

        request.getRequestDispatcher("/available-courses.jsp")
                .forward(request, response);
    }
}


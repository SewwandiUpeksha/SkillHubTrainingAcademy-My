
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

@WebServlet("/courses")
public class Course extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        // Check whether the user is logged in
        HttpSession session = request.getSession(false);

        if (session == null ||
                session.getAttribute("loggedUser") == null) {

            response.sendRedirect(
                    request.getContextPath() + "/login.jsp");
            return;
        }

        // Check admin authorization
        User user = (User) session.getAttribute("loggedUser");

        if (!"ADMIN".equals(user.getRole())) {
            response.sendError(
                    HttpServletResponse.SC_FORBIDDEN,
                    "You are not authorized to access course management.");
            return;
        }

        // Get courses stored in ServletContext
        List<lk.jiat.academy.model.Course> courses = (List<lk.jiat.academy.model.Course>) getServletContext().getAttribute("courses");

        // Send courses to the JSP
        request.setAttribute("courses", courses);

        // Display the course management page
        request.getRequestDispatcher("/course.jsp")
                .forward(request, response);
    }
}

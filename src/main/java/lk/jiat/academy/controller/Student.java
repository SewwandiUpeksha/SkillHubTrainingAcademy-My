
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

@WebServlet("/students")
public class Student extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        // Check the login session
        HttpSession session = request.getSession(false);

        if (session == null ||
                session.getAttribute("loggedUser") == null) {

            response.sendRedirect(
                    request.getContextPath() + "/login.jsp");
            return;
        }

        // Get the logged-in user
        User user = (User) session.getAttribute("loggedUser");

        // Only administrators can access student management
        if (!"ADMIN".equals(user.getRole())) {
            response.sendError(
                    HttpServletResponse.SC_FORBIDDEN,
                    "You are not authorized to access student management.");
            return;
        }

        // Retrieve students from ServletContext
        List<lk.jiat.academy.model.Student> students = (List<lk.jiat.academy.model.Student>) getServletContext().getAttribute("students");

        // Pass student data to the JSP
        request.setAttribute("students", students);

        // Forward to student.jsp
        request.getRequestDispatcher("/student.jsp")
                .forward(request, response);
    }
}

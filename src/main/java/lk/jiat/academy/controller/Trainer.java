
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

@WebServlet("/trainers")
public class Trainer extends HttpServlet {

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

        // Allow only administrators to manage trainers
        User user = (User) session.getAttribute("loggedUser");

        if (!"ADMIN".equals(user.getRole())) {
            response.sendError(
                    HttpServletResponse.SC_FORBIDDEN,
                    "You are not authorized to access trainer management.");
            return;
        }

        // Retrieve trainers from ServletContext
        List<lk.jiat.academy.model.Trainer> trainers = (List<lk.jiat.academy.model.Trainer>) getServletContext().getAttribute("trainers");

        // Pass trainer data to the JSP
        request.setAttribute("trainers", trainers);

        // Forward the request to trainer.jsp
        request.getRequestDispatcher("/trainer.jsp")
                .forward(request, response);
    }
}

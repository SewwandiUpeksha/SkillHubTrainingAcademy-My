
package lk.jiat.academy.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import lk.jiat.academy.model.User;

import java.io.IOException;

@WebServlet("/dashboard")
public class Dashboard extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        // Check whether the user has logged in
        if (session == null ||
                session.getAttribute("loggedUser") == null) {

            response.sendRedirect(
                    request.getContextPath() + "/login.jsp");
            return;
        }

        // Get the logged-in user
        User user = (User) session.getAttribute("loggedUser");

        // Send user information to dashboard.jsp
        request.setAttribute("user", user);

        request.getRequestDispatcher("/dashboard.jsp")
                .forward(request, response);
    }
}


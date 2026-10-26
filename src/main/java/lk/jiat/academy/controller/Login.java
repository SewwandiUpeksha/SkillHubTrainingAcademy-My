
package lk.jiat.academy.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import lk.jiat.academy.model.User;

import java.io.IOException;
import java.util.Map;

@WebServlet("/login")
public class Login extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        Map<String, User> users = (Map<String, User>) getServletContext().getAttribute("users");

        User user = null;

        if (users != null && username != null) {
            user = users.get(username.trim());
        }

        if (user != null && password != null && user.getPassword().equals(password)) {

            // Create a new session after successful login
            HttpSession session = request.getSession();
            session.setAttribute("loggedUser", user);

            // Redirect to the Dashboard servlet
            response.sendRedirect(
                    request.getContextPath() + "/dashboard");

        } else {

            request.setAttribute(
                    "error", "Invalid username or password!");

            request.getRequestDispatcher("/login.jsp")
                    .forward(request, response);
        }
    }
}

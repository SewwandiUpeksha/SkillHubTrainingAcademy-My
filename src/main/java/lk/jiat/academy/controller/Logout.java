
package lk.jiat.academy.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/logout")
public class Logout extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        // Get the existing session without creating a new one
        HttpSession session = request.getSession(false);

        // Invalidate the session if it exists
        if (session != null) {
            session.invalidate();
        }

        // Prevent the browser from displaying cached pages
        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
        response.setHeader("Pragma", "no-cache");
        response.setDateHeader("Expires", 0);

        // Redirect to the login page
        response.sendRedirect(
                request.getContextPath() + "/login.jsp");
    }

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        // Logout should be performed using POST
        response.sendError(
                HttpServletResponse.SC_METHOD_NOT_ALLOWED,
                "Please use the logout form.");
    }
}


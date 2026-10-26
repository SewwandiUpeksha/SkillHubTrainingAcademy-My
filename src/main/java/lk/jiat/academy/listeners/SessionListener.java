
package lk.jiat.academy.listeners;

import jakarta.servlet.ServletContext;
import jakarta.servlet.annotation.WebListener;
import jakarta.servlet.http.HttpSessionEvent;
import jakarta.servlet.http.HttpSessionListener;

@WebListener
public class SessionListener implements HttpSessionListener {

    @Override
    public void sessionCreated(HttpSessionEvent se) {

        ServletContext context =
                se.getSession().getServletContext();

        synchronized (context) {

            Integer activeSessions =
                    (Integer) context.getAttribute("activeSessions");

            if (activeSessions == null) {
                activeSessions = 0;
            }

            activeSessions++;

            context.setAttribute("activeSessions", activeSessions);

            System.out.println(
                    "Session Created. Total Active Sessions: "
                            + activeSessions);
        }
    }

    @Override
    public void sessionDestroyed(HttpSessionEvent se) {

        ServletContext context =
                se.getSession().getServletContext();

        synchronized (context) {

            Integer activeSessions =
                    (Integer) context.getAttribute("activeSessions");

            if (activeSessions == null) {
                activeSessions = 0;
            } else if (activeSessions > 0) {
                activeSessions--;
            }

            context.setAttribute("activeSessions", activeSessions);

            System.out.println(
                    "Session Destroyed. Total Active Sessions: "
                            + activeSessions);
        }
    }
}


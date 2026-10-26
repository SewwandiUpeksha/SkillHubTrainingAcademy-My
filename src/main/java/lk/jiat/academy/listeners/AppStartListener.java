package lk.jiat.academy.listeners;

import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;
import lk.jiat.academy.model.*;

import java.util.*;

@WebListener
public class AppStartListener implements ServletContextListener {

    @Override
    public void contextInitialized(ServletContextEvent sce) {

        ServletContext context = sce.getServletContext();

        Map<String, User> users = new HashMap<>();
        //Map<String, Trainer> trainers = new HashMap<>();
        //Map<String, Student> students = new HashMap<>();

        // Create users
        users.put("admin",new User("admin","Admin@123","ADMIN","Academy Administrator"));
        users.put("student",new User("student","Student@123","STUDENT","Academy Student"));

        // Create students
        List<Student> students =
                Collections.synchronizedList(new ArrayList<>());

        students.add(new Student(
                "ST001",
                "Academy Student",
                "student@skillhub.lk"
        ));

        context.setAttribute("students", students);

        // Create trainers
        List<Trainer> trainers =
                Collections.synchronizedList(new ArrayList<>());

        trainers.add(new Trainer(
                "TR001", "Nimal Perera", "Software Engineering"));

        // Create courses
        List<Course> courses =
                Collections.synchronizedList(new ArrayList<>());

        courses.add(new Course(
                "CR001",
                "Java Web Development",
                "Build web apps with Java Servlets and JSP",
                "Nimal Perera",
                25000));

        courses.add(new Course(
                "CR002",
                "Business Communication",
                "Professional communication skills",
                "Academy Team",
                15000));

        // Create enrolments
        List<Enrolments> enrolments =
                Collections.synchronizedList(new ArrayList<>());

        // Create attendance records
        List<Attendance> attendance =
                Collections.synchronizedList(new ArrayList<>());

        // Store all collections in ServletContext
        context.setAttribute("users", users);

        context.setAttribute("trainers", trainers);
        context.setAttribute("courses", courses);
        context.setAttribute("enrolments", enrolments);
        context.setAttribute("attendance", attendance);

        System.out.println("SkillHub application initialized ... !");
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        System.out.println("ServletContext Destroyed..!");
    }
}

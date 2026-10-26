package lk.jiat.academy.model;

public class Enrolments {
    private final String studentId;
    private final String courseId;

    public Enrolments(String studentId, String courseId) {
        this.studentId = studentId;
        this.courseId = courseId;
    }

    public String getStudentId() {
        return studentId;
    }

    public String getCourseId() {

        return courseId;
    }
}

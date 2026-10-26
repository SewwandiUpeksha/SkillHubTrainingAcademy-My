package lk.jiat.academy.model;

public class Attendance {

    private final String studentId;
    private final String courseId;
    private final String date;
    private final String status;

    public Attendance(String studentId, String courseId, String date, String status) {
        this.studentId = studentId;
        this.courseId = courseId;
        this.date = date;
        this.status = status;
    }

    public String getStudentId() {
        return studentId;
    }

    public String getDate() {
        return date;
    }

    public String getStatus() {
        return status;
    }

    public String getCourseId() {
        return courseId;
    }
}

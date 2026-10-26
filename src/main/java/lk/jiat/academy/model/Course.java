package lk.jiat.academy.model;

public class Course {

    private final String id;
    private final String title;
    private final String description;
    private final String trainer;
    private final double fee;

    public Course(String id, String title, String description, String trainer, double fee) {
        this.id = id;
        this.title = title;
        this.description = description;
        this.trainer = trainer;
        this.fee = fee;
    }

    public String getId() {
        return id;
    }

    public String getTitle() {
        return title;
    }

    public String getDescription() {
        return description;
    }

    public String getTrainer() {
        return trainer;
    }

    public double getFee() {
        return fee;
    }
}

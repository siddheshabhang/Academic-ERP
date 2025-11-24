package com.iiitb.erp.placement.entity;

import jakarta.persistence.*;
import lombok.Data;
import java.util.Date;

@Entity
@Table(name = "placement_student")
@Data
public class PlacementStudent {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @ManyToOne
    @JoinColumn(name = "placement_id")
    private Placement placement;

    @ManyToOne
    @JoinColumn(name = "student_id")
    private Student student;

    @Column(name = "cv_application")
    private String cvApplication;

    private String about;

    private Boolean acceptance; // True = Selected

    private String comments;

    @Temporal(TemporalType.DATE)
    private Date date;
}
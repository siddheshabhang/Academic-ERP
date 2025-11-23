package com.iiitb.erp.placement.entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

@Entity
@Table(name = "placement_student")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class PlacementStudent {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "placement_student_id")
    private Long id;

    @Column(name = "placement_id")
    private Long placementId;

    @Column(name = "student_id")
    private Long studentId;

    @Column(name = "cv_application")
    private String cvApplication;

    @Column(name = "acceptance")
    private String acceptance;

    @Column(name = "date")
    @Temporal(TemporalType.DATE)
    private Date date;
}

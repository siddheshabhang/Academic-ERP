package com.iiitb.erp.placement.entity;

import jakarta.persistence.*;
import lombok.Data;

@Entity
@Table(name = "placement")
@Data
public class Placement {

    @Id
    private Integer id;

    @ManyToOne
    @JoinColumn(name = "organisation_id")
    private Organisation organisation;

    private String profile;
    private String description;
    private Integer intake;

    @Column(name = "minimum_grade")
    private Double minGrade;
}
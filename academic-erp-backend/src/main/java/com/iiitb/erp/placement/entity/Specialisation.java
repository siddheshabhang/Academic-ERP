package com.iiitb.erp.placement.entity;

import jakarta.persistence.*;
import lombok.Data;

@Entity
@Table(name = "specialisation")
@Data
public class Specialisation {
    @Id
    @Column(name = "specialisation_id")
    private Integer id;

    private String code;
    private String name;
    private String description;
    private Integer year;
    private Integer credits_required;
}
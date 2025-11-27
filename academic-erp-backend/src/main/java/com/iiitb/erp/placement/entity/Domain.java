package com.iiitb.erp.placement.entity;

import jakarta.persistence.*;
import lombok.Data;

@Entity
@Table(name = "domains")
@Data
public class Domain {
    @Id
    @Column(name = "domain_id")
    private Integer id;

    private String program;
    private String batch;
    private Integer capacity;
    private String qualification;
}
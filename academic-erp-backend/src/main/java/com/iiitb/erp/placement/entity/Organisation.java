package com.iiitb.erp.placement.entity;

import jakarta.persistence.*;
import lombok.Data;

@Entity
@Table(name = "organisations")
@Data
public class Organisation {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id; // Changed from Long to Integer

    private String name;

    private String address;
}
package com.iiitb.erp.placement.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class StudentDTO {
    private Integer id;
    private String rollNumber;
    private String firstName;
    private String lastName;
    private String email;
    private String photographPath;
    private Double cgpa;
    private Integer totalCredits;
    private Integer graduationYear;
    private DomainDTO domain; // Nested object for frontend compatibility
    private SpecialisationDTO specialisation; // Nested object for frontend compatibility
}

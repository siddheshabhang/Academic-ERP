package com.iiitb.erp.placement.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import java.util.Date;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class AppliedStudentDTO {
    private Long applicationId;
    private Long studentId;
    private String rollNumber;
    private String name;
    private String email;
    private String cvUrl;
    private String status;      // e.g., PENDING, SELECTED
    private Date appliedDate;
}
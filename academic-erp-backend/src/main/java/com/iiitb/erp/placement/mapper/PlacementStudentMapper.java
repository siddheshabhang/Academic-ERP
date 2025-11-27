package com.iiitb.erp.placement.mapper;

import com.iiitb.erp.placement.dto.AppliedStudentDTO;
import com.iiitb.erp.placement.entity.PlacementStudent;
import com.iiitb.erp.placement.entity.Student;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class PlacementStudentMapper {

    @Autowired
    private DomainMapper domainMapper;

    @Autowired
    private SpecialisationMapper specialisationMapper;

    /**
     * Convert PlacementStudent and Student entities to AppliedStudentDTO
     * This mapper extracts the inline mapping logic previously in
     * PlacementStudentService
     * 
     * @param application PlacementStudent entity
     * @param student     Student entity
     * @return AppliedStudentDTO
     */
    public AppliedStudentDTO toDTO(PlacementStudent application, Student student) {
        if (application == null || student == null) {
            return null;
        }

        // Build full name
        String fullName = student.getFirstName() + " " +
                (student.getLastName() != null ? student.getLastName() : "");

        // Determine status based on acceptance
        String status = application.isAcceptance() ? "SELECTED" : "PENDING";

        AppliedStudentDTO dto = new AppliedStudentDTO();
        dto.setApplicationId(Long.valueOf(application.getId()));
        dto.setStudentId(Long.valueOf(student.getId()));
        dto.setRollNumber(student.getRollNumber());
        dto.setName(fullName);
        dto.setEmail(student.getEmail());
        dto.setCvUrl(application.getCvApplication());
        dto.setStatus(status);
        dto.setAppliedDate(application.getDate());
        dto.setCgpa(student.getCgpa());
        dto.setDomain(domainMapper.toDTO(student.getDomain()));
        dto.setSpecialisation(specialisationMapper.toDTO(student.getSpecialisation()));

        return dto;
    }

    /**
     * Convert PlacementStudent to AppliedStudentDTO
     * This method extracts the student from the application entity
     * 
     * @param application PlacementStudent entity with student attached
     * @return AppliedStudentDTO
     */
    public AppliedStudentDTO toDTO(PlacementStudent application) {
        if (application == null) {
            return null;
        }
        return toDTO(application, application.getStudent());
    }
}

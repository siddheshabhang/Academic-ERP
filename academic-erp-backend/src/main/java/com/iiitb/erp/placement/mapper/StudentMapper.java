package com.iiitb.erp.placement.mapper;

import com.iiitb.erp.placement.dto.StudentDTO;
import com.iiitb.erp.placement.entity.Student;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class StudentMapper {

    @Autowired
    private DomainMapper domainMapper;

    @Autowired
    private SpecialisationMapper specialisationMapper;

    /**
     * Convert Student entity to StudentDTO
     * 
     * @param student Student entity
     * @return StudentDTO
     */
    public StudentDTO toDTO(Student student) {
        if (student == null) {
            return null;
        }

        return new StudentDTO(
                student.getId(),
                student.getRollNumber(),
                student.getFirstName(),
                student.getLastName(),
                student.getEmail(),
                student.getPhotographPath(),
                student.getCgpa(),
                student.getTotalCredits(),
                student.getGraduationYear(),
                domainMapper.toDTO(student.getDomain()),
                specialisationMapper.toDTO(student.getSpecialisation()));
    }

    /**
     * Convert Student entity to StudentDTO (alternative method name for clarity)
     * 
     * @param student Student entity
     * @return StudentDTO
     */
    public StudentDTO entityToDTO(Student student) {
        return toDTO(student);
    }
}

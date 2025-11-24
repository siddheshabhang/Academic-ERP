package com.iiitb.erp.placement.service;

import com.iiitb.erp.placement.dto.AppliedStudentDTO;
import com.iiitb.erp.placement.entity.PlacementStudent;
import com.iiitb.erp.placement.entity.Student;
import com.iiitb.erp.placement.repository.PlacementStudentRepository;
import com.iiitb.erp.placement.repository.StudentRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class PlacementStudentService {

    @Autowired
    private PlacementStudentRepository placementStudentRepository;

    @Autowired
    private StudentRepository studentRepository;

    // UPDATED: Added filter parameters (minGrade, specialisationId, domainId)
    public List<AppliedStudentDTO> getAppliedStudents(Integer offerId, Double minGrade, Integer specialisationId, Integer domainId) {
        // 1. Fetch all applications for this specific offer
        List<PlacementStudent> applications = placementStudentRepository.findByPlacementId(offerId);

        List<AppliedStudentDTO> result = new ArrayList<>();

        for (PlacementStudent app : applications) {
            // 2. Fetch the student details
            Student student = studentRepository.findById(app.getStudent().getId()).orElse(null);

            if (student != null) {
                // --- FILTERING LOGIC START ---

                // Filter by Grade (CGPA)
                if (minGrade != null && (student.getCgpa() == null || student.getCgpa() < minGrade)) {
                    continue; // Skip this student
                }

                // Filter by Specialisation
                if (specialisationId != null && (student.getSpecialisation() == null || !student.getSpecialisation().getId().equals(specialisationId))) {
                    continue; // Skip
                }

                // Filter by Domain
                if (domainId != null && (student.getDomain() == null || !student.getDomain().getId().equals(domainId))) {
                    continue; // Skip
                }
                // --- FILTERING LOGIC END ---

                // 3. Map to DTO
                String fullName = student.getFirstName() + " " + (student.getLastName() != null ? student.getLastName() : "");
                String status = (app.getAcceptance() != null && app.getAcceptance()) ? "SELECTED" : "PENDING";

                result.add(new AppliedStudentDTO(
                        Long.valueOf(app.getId()),
                        Long.valueOf(student.getId()),
                        student.getRollNumber(),
                        fullName,
                        student.getEmail(),
                        app.getCvApplication(),
                        status,
                        app.getDate()
                ));
            }
        }
        return result;
    }
}
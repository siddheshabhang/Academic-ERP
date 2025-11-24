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

    // Changed Long -> Integer
    public List<AppliedStudentDTO> getAppliedStudents(Integer offerId) {
        List<PlacementStudent> applications = placementStudentRepository.findByPlacementId(offerId);

        List<AppliedStudentDTO> result = new ArrayList<>();

        for (PlacementStudent app : applications) {
            // Changed Long -> Integer for Student ID lookup
            Student student = studentRepository.findById(app.getStudent().getId()).orElse(null);

            if (student != null) {
                String fullName = student.getFirstName() + " " + (student.getLastName() != null ? student.getLastName() : "");

                // Handle boolean to String conversion for DTO if necessary
                String status = (app.getAcceptance() != null && app.getAcceptance()) ? "SELECTED" : "PENDING";

                result.add(new AppliedStudentDTO(
                        Long.valueOf(app.getId()), // Cast to Long if DTO expects Long
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
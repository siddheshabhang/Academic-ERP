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

    public List<AppliedStudentDTO> getAppliedStudents(Long offerId) {
        // 1. Fetch all applications for this specific Offer ID
        List<PlacementStudent> applications = placementStudentRepository.findByPlacementId(offerId);

        List<AppliedStudentDTO> result = new ArrayList<>();

        // 2. Loop through applications and fetch Student details for each
        for (PlacementStudent app : applications) {
            Student student = studentRepository.findById(app.getStudentId()).orElse(null);

            if (student != null) {
                String fullName = student.getFirstName() + " " + (student.getLastName() != null ? student.getLastName() : "");

                result.add(new AppliedStudentDTO(
                        app.getId(),
                        student.getId(),
                        student.getRollNumber(),
                        fullName,
                        student.getEmail(),
                        app.getCvApplication(),
                        app.getAcceptance(),
                        app.getDate()
                ));
            }
        }
        return result;
    }
}
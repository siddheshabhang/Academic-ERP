package com.iiitb.erp.placement.service;

import com.iiitb.erp.placement.dto.AppliedStudentDTO;
import com.iiitb.erp.placement.entity.*;
import com.iiitb.erp.placement.repository.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

@Service
public class SelectionService {

    @Autowired
    private PlacementRepository placementRepository;

    @Autowired
    private PlacementFilterRepository placementFilterRepository;

    @Autowired
    private StudentRepository studentRepository;

    @Autowired
    private PlacementStudentRepository placementStudentRepository;

    /**
     * 1. View Eligible Students:
     * Finds all students who meet the Offer's criteria (Min Grade, Domain, Specialisation)
     * regardless of whether they have applied or not.
     */
    public List<Student> getEligibleStudents(Long offerId) {
        Placement offer = placementRepository.findById(offerId)
                .orElseThrow(() -> new RuntimeException("Offer not found"));

        // Get requirements (Domains/Specialisations)
        List<PlacementFilter> filters = placementFilterRepository.findByPlacementId(offerId);

        // Fetch all students (In a real large DB, you would filter at query level)
        List<Student> allStudents = studentRepository.findAll();

        return allStudents.stream().filter(student -> {
            // Check CGPA
            if (offer.getMinGrade() != null && student.getCgpa() < offer.getMinGrade()) {
                return false;
            }

            // Check Domain/Specialisation if filters exist
            if (!filters.isEmpty()) {
                boolean matchesDomain = filters.stream()
                        .anyMatch(f -> f.getDomain() != null && f.getDomain().equalsIgnoreCase(student.getDomain()));

                boolean matchesSpec = filters.stream()
                        .anyMatch(f -> f.getSpecialisation() != null && f.getSpecialisation().equalsIgnoreCase(student.getSpecialisation()));

                // Logic: If filters exist, student must match at least one relevant filter
                // (Assuming filters are OR conditions for eligibility, or you can implement strict matching)
                return matchesDomain || matchesSpec;
            }
            return true;
        }).collect(Collectors.toList());
    }

    /**
     * 2. Filter Applied Students:
     * Fetches students who applied, but allows dynamic filtering on top of the list.
     */
    public List<AppliedStudentDTO> getFilteredApplicants(Long offerId, Double minGrade, String domain, String specialisation) {
        // Fetch all raw applications
        List<PlacementStudent> applications = placementStudentRepository.findByPlacementId(offerId);
        List<AppliedStudentDTO> result = new ArrayList<>();

        for (PlacementStudent app : applications) {
            Student student = studentRepository.findById(app.getStudentId()).orElse(null);

            if (student != null) {
                // Apply Filters
                if (minGrade != null && student.getCgpa() < minGrade) continue;
                if (domain != null && !domain.isEmpty() && !domain.equalsIgnoreCase(student.getDomain())) continue;
                if (specialisation != null && !specialisation.isEmpty() && !specialisation.equalsIgnoreCase(student.getSpecialisation())) continue;

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

    /**
     * 3. Select Student:
     * Updates the application status to 'SELECTED'
     */
    public String selectStudentForOffer(Long offerId, Long studentId) {
        PlacementStudent application = placementStudentRepository.findByPlacementIdAndStudentId(offerId, studentId)
                .orElseThrow(() -> new RuntimeException("Application not found for this student and offer"));

        application.setAcceptance("SELECTED");
        placementStudentRepository.save(application);

        return "Student " + studentId + " successfully selected for Offer " + offerId;
    }
}
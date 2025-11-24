package com.iiitb.erp.placement.service;

import com.iiitb.erp.placement.entity.*;
import com.iiitb.erp.placement.repository.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

import com.iiitb.erp.placement.exception.ResourceNotFoundException;

@Service
public class SelectionService {

    @Autowired
    private PlacementRepository placementRepo;
    @Autowired
    private PlacementStudentRepository placementStudentRepo;
    @Autowired
    private PlacementFilterRepository placementFilterRepo; // Ensure you have this Repository interface
    @Autowired
    private StudentRepository studentRepo;

    // Use Case 8.6: View Eligible Students (Not just those who applied)
    public List<Student> getEligibleStudents(Integer offerId) {
        Placement offer = placementRepo.findById(offerId)
                .orElseThrow(() -> new ResourceNotFoundException("Offer not found with ID: " + offerId));
        List<PlacementFilter> filters = placementFilterRepo.findByPlacementId(offerId);
        List<Student> allStudents = studentRepo.findAll();

        return allStudents.stream()
                .filter(student -> {
                    // 1. Grade Check
                    if (offer.getMinGrade() != null && student.getCgpa() < offer.getMinGrade()) return false;

                    // 2. Filter Check (Domain/Specialisation)
                    if (filters.isEmpty()) return true; // No filters = open to all

                    boolean matches = filters.stream().anyMatch(filter -> {
                        boolean domainMatch = (filter.getDomain() == null) ||
                                (filter.getDomain().getId().equals(student.getDomain().getId()));
                        boolean specMatch = (filter.getSpecialisation() == null) ||
                                (filter.getSpecialisation().getId().equals(student.getSpecialisation().getId()));
                        return domainMatch && specMatch;
                    });
                    return matches;
                })
                .collect(Collectors.toList());
    }

    // Use Case 8.6: View Applied Students with Filters
    public List<Student> getFilteredApplicants(Integer offerId, Double minGrade, Integer specialisationId, Integer domainId) {
        List<PlacementStudent> applications = placementStudentRepo.findByPlacementId(offerId);
        return applications.stream()
                .map(PlacementStudent::getStudent)
                .filter(student -> {
                    if (minGrade != null && student.getCgpa() < minGrade) return false;
                    if (specialisationId != null && !student.getSpecialisation().getId().equals(specialisationId)) return false;
                    if (domainId != null && !student.getDomain().getId().equals(domainId)) return false;
                    return true;
                })
                .collect(Collectors.toList());
    }

    public String selectStudent(Integer offerId, Integer studentId) {
        PlacementStudent application = placementStudentRepo.findByPlacementIdAndStudentId(offerId, studentId);
        if (application == null) {
            throw new ResourceNotFoundException("Application not found for Student ID " + studentId + " in Offer " + offerId);
        }
        application.setAcceptance(true);
        application.setComments("Selected by Outreach");
        placementStudentRepo.save(application);
        return "Success";
    }
}
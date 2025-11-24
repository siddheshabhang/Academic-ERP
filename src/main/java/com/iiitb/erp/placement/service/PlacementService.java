package com.iiitb.erp.placement.service;

import com.iiitb.erp.placement.entity.Placement;
import com.iiitb.erp.placement.entity.PlacementStudent;
import com.iiitb.erp.placement.entity.Student;
import com.iiitb.erp.placement.repository.PlacementRepository;
import com.iiitb.erp.placement.repository.PlacementStudentRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

import com.iiitb.erp.placement.exception.ResourceNotFoundException;
import com.iiitb.erp.placement.exception.BadRequestException;

@Service
public class PlacementService {

    @Autowired
    private PlacementRepository placementRepository;

    @Autowired
    private PlacementStudentRepository placementStudentRepo;

    public List<Placement> getAllOffers() {
        return placementRepository.findAll();
    }

    public Placement getOfferById(Integer id) {
        return placementRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Offer not found with ID: " + id));
    }

    public List<Student> getFilteredApplicants(Integer offerId, Double minGrade, Integer specialisationId, Integer domainId) {
        List<PlacementStudent> applications = placementStudentRepo.findByPlacementId(offerId);

        return applications.stream()
                .map(PlacementStudent::getStudent)
                .filter(student -> {
                    if (minGrade != null && student.getCgpa() < minGrade) return false;
                    // Using IDs for comparison
                    if (specialisationId != null && !student.getSpecialisation().getId().equals(specialisationId)) return false;
                    if (domainId != null && !student.getDomain().getId().equals(domainId)) return false;
                    return true;
                })
                .collect(Collectors.toList());
    }

    public boolean selectStudent(Integer offerId, Integer studentId) {
        PlacementStudent application = placementStudentRepo.findByPlacementIdAndStudentId(offerId, studentId);
        if (application != null) {
            application.setAcceptance(true);
            application.setComments("Selected by Outreach Department");
            placementStudentRepo.save(application);
            return true;
        }
        throw new BadRequestException("Student has not applied for this offer or application not found.");
    }
}
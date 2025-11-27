package com.iiitb.erp.placement.service;

import com.iiitb.erp.placement.dto.PlacementDTO;
import com.iiitb.erp.placement.dto.StudentDTO;
import com.iiitb.erp.placement.entity.Placement;
import com.iiitb.erp.placement.entity.PlacementStudent;
import com.iiitb.erp.placement.mapper.PlacementMapper;
import com.iiitb.erp.placement.mapper.StudentMapper;
import com.iiitb.erp.placement.repository.PlacementRepository;
import com.iiitb.erp.placement.repository.PlacementStudentRepository;
import com.iiitb.erp.placement.exception.ResourceNotFoundException;
import com.iiitb.erp.placement.exception.BadRequestException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
public class PlacementService {

    @Autowired
    private PlacementRepository placementRepository;

    @Autowired
    private PlacementStudentRepository placementStudentRepo;

    @Autowired
    private PlacementMapper placementMapper;

    @Autowired
    private StudentMapper studentMapper;

    // ========== EXISTING METHODS ==========

    public List<PlacementDTO> getAllOffers() {
        return placementRepository.findAll().stream()
                .map(placementMapper::toDTO)
                .collect(Collectors.toList());
    }

    public PlacementDTO getOfferById(Integer id) {
        Placement placement = placementRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Offer not found with ID: " + id));
        return placementMapper.toDTO(placement);
    }

    public List<StudentDTO> getFilteredApplicants(Integer offerId, Double minGrade, Integer specialisationId,
            Integer domainId) {
        List<PlacementStudent> applications = placementStudentRepo.findByPlacementId(offerId);

        return applications.stream()
                .map(PlacementStudent::getStudent)
                .filter(student -> {
                    if (minGrade != null && student.getCgpa() < minGrade)
                        return false;
                    if (specialisationId != null && !student.getSpecialisation().getId().equals(specialisationId))
                        return false;
                    if (domainId != null && !student.getDomain().getId().equals(domainId))
                        return false;
                    return true;
                })
                .map(studentMapper::toDTO)
                .collect(Collectors.toList());
    }

    // ========== STUDENT SELECTION WITH VALIDATION ==========
    /**
     * Select a student for a placement offer with comprehensive validation.
     *
     * Validations:
     * 1. Check if placement exists
     * 2. Check if student has applied for this offer
     * 3. Check if student is already selected (prevent duplicate)
     * 4. Update acceptance status
     *
     * @param offerId   The placement offer ID
     * @param studentId The student ID
     * @throws ResourceNotFoundException if placement or application not found
     * @throws BadRequestException       if student already selected or validation
     *                                   fails
     */
    public void selectStudent(Integer offerId, Integer studentId) {
        // Validation 1: Check if placement exists
        Placement placement = placementRepository.findById(offerId)
                .orElseThrow(() -> new ResourceNotFoundException("Placement offer not found with ID: " + offerId));

        // Validation 2: Check if application exists for this student
        PlacementStudent application = placementStudentRepo.findByPlacementIdAndStudentId(offerId, studentId);

        if (application == null) {
            throw new BadRequestException("Student ID " + studentId + " has not applied for this offer.");
        }

        // Validation 3: Check if already selected (prevent duplicate)
        if (application.isAcceptance()) {
            throw new BadRequestException("Student ID " + studentId + " is already selected for this offer.");
        }

        // Validation 4: Update acceptance status
        application.setAcceptance(true);
        application.setComments("Selected by Outreach Department");
        placementStudentRepo.save(application);
    }

    /**
     * Get a specific application for a student and offer
     */
    public PlacementStudent getApplication(Integer offerId, Integer studentId) {
        PlacementStudent application = placementStudentRepo.findByPlacementIdAndStudentId(offerId, studentId);
        if (application == null) {
            throw new ResourceNotFoundException("Application not found");
        }
        return application;
    }

    /**
     * Check if a student is already selected for an offer
     */
    public boolean isStudentSelected(Integer offerId, Integer studentId) {
        PlacementStudent application = placementStudentRepo.findByPlacementIdAndStudentId(offerId, studentId);
        // SIMPLIFIED: Using primitive boolean
        return application != null && application.isAcceptance();
    }
}
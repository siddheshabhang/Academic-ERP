package com.iiitb.erp.placement.controller;

import com.iiitb.erp.placement.entity.Placement;
import com.iiitb.erp.placement.entity.Student;
import com.iiitb.erp.placement.dto.AppliedStudentDTO;
import com.iiitb.erp.placement.service.PlacementService;
import com.iiitb.erp.placement.service.PlacementStudentService;
import com.iiitb.erp.placement.service.SelectionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/offers")
public class PlacementController {

    @Autowired
    private PlacementService placementService;

    @Autowired
    private PlacementStudentService placementStudentService;

    @Autowired
    private SelectionService selectionService; // Inject the new service

    @GetMapping
    public List<Placement> getAllOffers() {
        return placementService.getAllOffers();
    }

    @GetMapping("/{id}")
    public Placement getOfferById(@PathVariable Long id) {
        return placementService.getOfferById(id);
    }

    // Existing: Get all applications without filter
    @GetMapping("/{id}/applications")
    public List<AppliedStudentDTO> getAppliedStudents(@PathVariable Long id) {
        return placementStudentService.getAppliedStudents(id);
    }

    // 1. Get Eligible Students (Potential candidates who fit criteria)
    @GetMapping("/{id}/eligible")
    public List<Student> getEligibleStudents(@PathVariable Long id) {
        return selectionService.getEligibleStudents(id);
    }

    // 2. Filter Applicants (Search/Filter within the applied pool)
    @GetMapping("/{id}/applications/filter")
    public List<AppliedStudentDTO> getFilteredApplications(
            @PathVariable Long id,
            @RequestParam(required = false) Double minGrade,
            @RequestParam(required = false) String domain,
            @RequestParam(required = false) String specialisation) {
        return selectionService.getFilteredApplicants(id, minGrade, domain, specialisation);
    }

    // 3. Select a Student (Update status to SELECTED)
    @PostMapping("/{id}/select/{studentId}")
    public String selectStudent(@PathVariable Long id, @PathVariable Long studentId) {
        return selectionService.selectStudentForOffer(id, studentId);
    }
}
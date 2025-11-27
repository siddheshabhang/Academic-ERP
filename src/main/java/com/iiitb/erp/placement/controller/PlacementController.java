package com.iiitb.erp.placement.controller;

import com.iiitb.erp.placement.dto.AppliedStudentDTO;
import com.iiitb.erp.placement.dto.DomainDTO;
import com.iiitb.erp.placement.dto.PlacementDTO;
import com.iiitb.erp.placement.dto.SpecialisationDTO;
import com.iiitb.erp.placement.dto.StudentDTO;
import com.iiitb.erp.placement.mapper.DomainMapper;
import com.iiitb.erp.placement.mapper.SpecialisationMapper;
import com.iiitb.erp.placement.repository.DomainRepository;
import com.iiitb.erp.placement.repository.SpecialisationRepository;
import com.iiitb.erp.placement.service.PlacementService;
import com.iiitb.erp.placement.service.PlacementStudentService;
import com.iiitb.erp.placement.service.SelectionService;
import io.swagger.v3.oas.annotations.Operation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/placement")
public class PlacementController {

    @Autowired
    private PlacementService placementService;

    @Autowired
    private SelectionService selectionService;

    @Autowired
    private PlacementStudentService placementStudentService;

    @Autowired
    private DomainRepository domainRepository;

    @Autowired
    private SpecialisationRepository specialisationRepository;

    @Autowired
    private DomainMapper domainMapper;

    @Autowired
    private SpecialisationMapper specialisationMapper;

    // 1. Fetch all offers
    @Operation(summary = "Get All Placement Offers", description = "Returns a list of all available job offers.")
    @GetMapping("/all")
    public List<PlacementDTO> getAllOffers() {
        return placementService.getAllOffers();
    }

    // 2. Fetch offer by ID
    @Operation(summary = "Get Offer by ID", description = "Returns details of a specific job offer.")
    @GetMapping("/{id}")
    public PlacementDTO getOfferById(@PathVariable Integer id) {
        return placementService.getOfferById(id);
    }

    // 3. View Eligible Students
    @Operation(summary = "Get Eligible Students", description = "Returns students who meet the criteria for an offer.")
    @GetMapping("/{offerId}/eligible")
    public ResponseEntity<List<StudentDTO>> getEligibleStudents(@PathVariable Integer offerId) {
        return ResponseEntity.ok(selectionService.getEligibleStudents(offerId));
    }

    // 4. View Applied Students with Filters
    @Operation(summary = "Get Applied Students", description = "View students who applied, with optional filters (minGrade, domain, etc).")
    @GetMapping("/{offerId}/applications")
    public ResponseEntity<List<AppliedStudentDTO>> getAppliedStudents(
            @PathVariable Integer offerId,
            @RequestParam(required = false) Double minGrade,
            @RequestParam(required = false) Integer specialisationId,
            @RequestParam(required = false) Integer domainId) {

        return ResponseEntity
                .ok(placementStudentService.getAppliedStudents(offerId, minGrade, specialisationId, domainId));
    }

    // 5. Select Student
    @Operation(summary = "Select Student", description = "Mark a student as accepted.")
    @PostMapping("/{offerId}/select/{studentId}")
    public ResponseEntity<String> selectStudentForOffer(
            @PathVariable Integer offerId,
            @PathVariable Integer studentId) {
        placementService.selectStudent(offerId, studentId);
        return ResponseEntity.ok("Student " + studentId + " selected successfully.");
    }

    // 6. Get all domains (for filter dropdown)
    @Operation(summary = "Get All Domains", description = "Returns a list of all domains (programs) for filtering.")
    @GetMapping("/domains")
    public ResponseEntity<List<DomainDTO>> getAllDomains() {
        return ResponseEntity.ok(domainRepository.findAll().stream()
                .map(domainMapper::toDTO)
                .collect(java.util.stream.Collectors.toList()));
    }

    // 7. Get all specialisations (for filter dropdown)
    @Operation(summary = "Get All Specialisations", description = "Returns a list of all specialisations for filtering.")
    @GetMapping("/specialisations")
    public ResponseEntity<List<SpecialisationDTO>> getAllSpecialisations() {
        return ResponseEntity.ok(specialisationRepository.findAll().stream()
                .map(specialisationMapper::toDTO)
                .collect(java.util.stream.Collectors.toList()));
    }

    // Add this new endpoint
    @Operation(summary = "Validate Session", description = "Checks if the user is logged in")
    @GetMapping("/validate")
    public ResponseEntity<String> validateSession() {
        return ResponseEntity.ok("Valid");
    }
}
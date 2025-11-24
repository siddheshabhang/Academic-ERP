package com.iiitb.erp.placement.controller;

import com.iiitb.erp.placement.dto.AppliedStudentDTO;
import com.iiitb.erp.placement.entity.Placement;
import com.iiitb.erp.placement.entity.Student;
import com.iiitb.erp.placement.service.PlacementService;
import com.iiitb.erp.placement.service.PlacementStudentService; // Import this
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
    private PlacementStudentService placementStudentService; // Inject the service

    // 1. Fetch all offers
    @Operation(summary = "Get All Placement Offers", description = "Returns a list of all available job offers.")
    @GetMapping("/all")
    public List<Placement> getAllOffers() {
        return placementService.getAllOffers();
    }

    // 2. Fetch offer by ID
    @Operation(summary = "Get Offer by ID", description = "Returns details of a specific job offer.")
    @GetMapping("/{id}")
    public Placement getOfferById(@PathVariable Integer id) {
        return placementService.getOfferById(id);
    }

    // 3. View Eligible Students (Use Case 8.6 - Eligible but maybe not applied)
    @Operation(summary = "Get Eligible Students", description = "Returns students who meet the criteria for an offer.")
    @GetMapping("/{offerId}/eligible")
    public ResponseEntity<List<Student>> getEligibleStudents(@PathVariable Integer offerId) {
        return ResponseEntity.ok(selectionService.getEligibleStudents(offerId));
    }

    // 4. NEW: View Applied Students with Filters (Use Case 8.6 - Applied students)
    @Operation(summary = "Get Applied Students", description = "View students who applied, with optional filters (minGrade, domain, etc).")
    @GetMapping("/{offerId}/applications")
    public ResponseEntity<List<AppliedStudentDTO>> getAppliedStudents(
            @PathVariable Integer offerId,
            @RequestParam(required = false) Double minGrade,
            @RequestParam(required = false) Integer specialisationId,
            @RequestParam(required = false) Integer domainId) {

        return ResponseEntity.ok(placementStudentService.getAppliedStudents(offerId, minGrade, specialisationId, domainId));
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
}
package com.iiitb.erp.placement.controller;

import com.iiitb.erp.placement.entity.Student;
import com.iiitb.erp.placement.service.SelectionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/placement")
public class PlacementController {

    @Autowired
    private SelectionService selectionService;

    // 1. View ALL Eligible students (Applied OR Not) - based on filters
    @GetMapping("/{offerId}/eligible")
    public ResponseEntity<List<Student>> getEligibleStudents(@PathVariable Integer offerId) {
        return ResponseEntity.ok(selectionService.getEligibleStudents(offerId));
    }

    // 2. View Applied Students with dynamic filtering (Grade, Domain, etc.)
    @GetMapping("/{offerId}/applicants")
    public ResponseEntity<List<Student>> getFilteredApplicants(
            @PathVariable Integer offerId,
            @RequestParam(required = false) Double minGrade,
            @RequestParam(required = false) Integer specialisationId,
            @RequestParam(required = false) Integer domainId) {

        List<Student> students = selectionService.getFilteredApplicants(offerId, minGrade, specialisationId, domainId);
        return ResponseEntity.ok(students);
    }

    // 3. Select a student
    @PostMapping("/{offerId}/select/{studentId}")
    public ResponseEntity<String> selectStudentForOffer(
            @PathVariable Integer offerId,
            @PathVariable Integer studentId) {

        String result = selectionService.selectStudent(offerId, studentId);
        if (result.startsWith("Error")) {
            return ResponseEntity.badRequest().body(result);
        }
        return ResponseEntity.ok(result);
    }
}
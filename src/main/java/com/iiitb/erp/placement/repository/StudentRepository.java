package com.iiitb.erp.placement.repository;

import com.iiitb.erp.placement.entity.Student;
import org.springframework.data.jpa.repository.JpaRepository;

public interface StudentRepository extends JpaRepository<Student, Long> {
}
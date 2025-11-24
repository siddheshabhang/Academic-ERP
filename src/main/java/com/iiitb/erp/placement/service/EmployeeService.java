package com.iiitb.erp.placement.service;

import com.iiitb.erp.placement.entity.Employee;
import com.iiitb.erp.placement.repository.EmployeeRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class EmployeeService {

    @Autowired
    private EmployeeRepository employeeRepository;

    // NOTE: Manual login/token generation is removed because we use OAuth2 now.

    public Employee getEmployeeByEmail(String email) {
        return employeeRepository.findByEmail(email)
                .orElseThrow(() -> new RuntimeException("Employee not found"));
    }
}
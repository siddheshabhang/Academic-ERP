package com.iiitb.erp.placement.controller;

import com.iiitb.erp.placement.service.EmployeeService;
import lombok.Data;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/auth")
public class AuthController {

    @Autowired
    private EmployeeService employeeService;

    @PostMapping("/login")
    public String login(@RequestBody LoginRequest request) {
        return employeeService.login(request.getEmail(), request.getPassword());
    }
}

@Data
class LoginRequest {
    private String email;
    private String password;
}
package com.iiitb.erp.placement.controller;

import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/auth")
public class AuthController {

    // The manual /login endpoint is removed.
    // Please use the "Authorize" button in Swagger UI with the mock token.

    @GetMapping("/status")
    public String status() {
        return "Auth Service is running. Use OAuth2 for login.";
    }
}
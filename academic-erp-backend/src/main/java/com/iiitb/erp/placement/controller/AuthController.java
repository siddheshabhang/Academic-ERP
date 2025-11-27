package com.iiitb.erp.placement.controller;

import com.iiitb.erp.placement.entity.Employee;
import com.iiitb.erp.placement.exception.BadRequestException;
import com.iiitb.erp.placement.repository.EmployeeRepository;
import com.iiitb.erp.placement.service.SessionService;
import com.iiitb.erp.placement.service.TokenService;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.io.IOException;
import java.util.Map;
import com.iiitb.erp.placement.service.TokenService;

@RestController
@RequestMapping("/auth")
public class AuthController {

    @Autowired
    private TokenService tokenService;

    @Autowired
    private SessionService sessionService;

    @Autowired
    private EmployeeRepository employeeRepository;

    @Value("${google.client.id}")
    private String clientId;

    private static final String REDIRECT_URI = "http://localhost:8080/auth/oauth2/callback";
    private static final String FRONTEND_URL = "http://localhost:5173";

    // 1. STEP 1: USER HITS /LOGIN (Redirects to Google)
    @GetMapping("/login")
    public void login(HttpServletResponse response) throws IOException {
        String googleAuthUrl = "https://accounts.google.com/o/oauth2/v2/auth?" +
                "scope=openid%20email%20profile&" +
                "access_type=offline&" + // Request refresh token
                "include_granted_scopes=true&" +
                "response_type=code&" +
                "redirect_uri=" + REDIRECT_URI + "&" +
                "client_id=" + clientId;

        response.sendRedirect(googleAuthUrl);
    }

    // 2. STEP 2 & 3: GOOGLE CALLBACK & EXCHANGE CODE
    @GetMapping("/oauth2/callback")
    public void callback(@RequestParam("code") String code, HttpSession session, HttpServletResponse response)
            throws IOException {
        try {
            // Exchange code for tokens
            Map<String, String> tokens = tokenService.exchangeCode(code);
            String accessToken = tokens.get("access_token");
            String idToken = tokens.get("id_token");
            String refreshToken = tokens.get("refresh_token");

            // Extract User Info
            String email = tokenService.getEmailFromToken(idToken);

            // Check DB Role
            Employee employee = employeeRepository.findByEmail(email).orElse(null);
            if (employee == null || !"OUTREACH".equalsIgnoreCase(employee.getRole())) {
                response.sendRedirect(FRONTEND_URL + "/login?error=Unauthorized");
                return;
            }

            // STORE TOKENS (PDF Requirements)
            // "Access token -> stored in server session"
            // "Refresh token -> stored in server session"
            sessionService.storeSession(email, accessToken, refreshToken, idToken);
            session.setAttribute("email", email);

            // "ID token -> stored in an HTTP-only cookie"
            setHttpOnlyCookie(response, "id_token", idToken);

            // Redirect to Homepage
            response.sendRedirect(FRONTEND_URL + "/dashboard");

        } catch (Exception e) {
            response.sendRedirect(FRONTEND_URL + "/login?error=" + e.getMessage());
        }
    }

    // 3. LOGOUT (PDF Step 6)
    @PostMapping("/signout")
    public ResponseEntity<?> signout(HttpSession session, HttpServletResponse response) {
        String email = (String) session.getAttribute("email");
        if (email != null) {
            sessionService.invalidateSession(email);
        }

        // 1. Delete ID token cookie
        clearHttpOnlyCookie(response, "id_token");

        // 2. Invalidate session
        session.invalidate();

        return ResponseEntity.ok(Map.of("message", "Signed out successfully"));
    }

    // VALIDATE SESSION ENDPOINT (Used by Frontend to check login status)
    @GetMapping("/api/validate-token") // <--- Note the path change
    public ResponseEntity<?> validateToken(@CookieValue(value = "id_token", required = false) String idToken) {
        if (idToken == null) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("No token found");
        }
        String email = tokenService.getEmailFromToken(idToken);

        return ResponseEntity.ok(Map.of("valid", true, "email", email));
    }

    private void setHttpOnlyCookie(HttpServletResponse response, String name, String value) {
        response.addHeader(HttpHeaders.SET_COOKIE,
                name + "=" + value + "; Path=/; HttpOnly; Secure; SameSite=Lax; Max-Age=3600");
    }

    private void clearHttpOnlyCookie(HttpServletResponse response, String name) {
        response.addHeader(HttpHeaders.SET_COOKIE,
                name + "=; Path=/; HttpOnly; Secure; SameSite=Lax; Max-Age=0");
    }
}
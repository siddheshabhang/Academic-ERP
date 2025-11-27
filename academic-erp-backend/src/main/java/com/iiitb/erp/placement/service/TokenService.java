package com.iiitb.erp.placement.service;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.*;
import org.springframework.stereotype.Service;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestTemplate;

import java.util.HashMap;
import java.util.Map;

@Service
public class TokenService {

    @Value("${google.client.id}")
    private String clientId;

    @Value("${google.client.secret}")
    private String clientSecret;

    // Must match the redirect URI registered in Google Console
    private static final String REDIRECT_URI = "http://localhost:8080/auth/oauth2/callback";

    private final RestTemplate restTemplate = new RestTemplate();
    private final ObjectMapper objectMapper = new ObjectMapper();

    // 1. EXCHANGE CODE FOR TOKENS (PDF Step 3)
    public Map<String, String> exchangeCode(String authorizationCode) {
        try {
            String tokenEndpoint = "https://oauth2.googleapis.com/token";

            MultiValueMap<String, String> params = new LinkedMultiValueMap<>();
            params.add("code", authorizationCode);
            params.add("client_id", clientId);
            params.add("client_secret", clientSecret);
            params.add("redirect_uri", REDIRECT_URI);
            params.add("grant_type", "authorization_code");

            HttpHeaders headers = new HttpHeaders();
            headers.setContentType(MediaType.APPLICATION_FORM_URLENCODED);

            HttpEntity<MultiValueMap<String, String>> request = new HttpEntity<>(params, headers);

            ResponseEntity<String>response = restTemplate.postForEntity(tokenEndpoint, request, String.class);
            JsonNode root = objectMapper.readTree(response.getBody());

            Map<String, String> tokens = new HashMap<>();
            tokens.put("access_token", root.path("access_token").asText());
            tokens.put("id_token", root.path("id_token").asText());

            // Refresh token is only returned on the first login or if access_type=offline is sent
            if (root.has("refresh_token")) {
                tokens.put("refresh_token", root.path("refresh_token").asText());
            }

            return tokens;

        } catch (Exception e) {
            throw new RuntimeException("Failed to exchange authorization code: " + e.getMessage());
        }
    }

    // 2. VALIDATE TOKEN WITH GOOGLE (PDF Step 5)
    // "TokenService makes a request to Google's tokeninfo endpoint"
    public boolean validateTokenWithGoogle(String idToken) {
        try {
            String url = "https://oauth2.googleapis.com/tokeninfo?id_token=" + idToken;
            ResponseEntity<String> response = restTemplate.getForEntity(url, String.class);
            return response.getStatusCode() == HttpStatus.OK;
        } catch (Exception e) {
            return false;
        }
    }

    // 3. EXTRACT EMAIL FROM ID TOKEN
    public String getEmailFromToken(String idToken) {
        try {
            String url = "https://oauth2.googleapis.com/tokeninfo?id_token=" + idToken;
            ResponseEntity<String> response = restTemplate.getForEntity(url, String.class);
            JsonNode root = objectMapper.readTree(response.getBody());
            return root.path("email").asText();
        } catch (Exception e) {
            throw new RuntimeException("Failed to extract email from token");
        }
    }
}
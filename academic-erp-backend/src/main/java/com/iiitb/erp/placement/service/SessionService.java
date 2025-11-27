package com.iiitb.erp.placement.service;

import lombok.Data;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

@Service
public class SessionService {

    @Data
    public static class SessionData {
        private String email;
        private String accessToken;
        private String refreshToken;
        private String idToken;
        private LocalDateTime createdAt;
        private LocalDateTime expiresAt;

        public SessionData(String email, String accessToken, String refreshToken, String idToken) {
            this.email = email;
            this.accessToken = accessToken;
            this.refreshToken = refreshToken;
            this.idToken = idToken;
            this.createdAt = LocalDateTime.now();
            // Assume 1 hour expiry
            this.expiresAt = LocalDateTime.now().plusHours(1);
        }

        public boolean isExpired() {
            return LocalDateTime.now().isAfter(expiresAt);
        }
    }

    // Store sessions: key = email, value = SessionData
    private final Map<String, SessionData> sessions = new ConcurrentHashMap<>();

    // 1. STORE SESSION (Server-side)
    public void storeSession(String email, String accessToken, String refreshToken, String idToken) {
        sessions.put(email, new SessionData(email, accessToken, refreshToken, idToken));
    }

    // 2. RETRIEVE SESSION
    public SessionData getSession(String email) {
        return sessions.get(email);
    }

    // 3. INVALIDATE SESSION (Logout)
    public void invalidateSession(String email) {
        sessions.remove(email);
    }

    // 4. VALIDATE SESSION
    public boolean isSessionValid(String email) {
        SessionData session = sessions.get(email);
        if (session == null) return false;
        if (session.isExpired()) {
            invalidateSession(email);
            return false;
        }
        return true;
    }

    // 5. UPDATE ACCESS TOKEN (After refresh)
    public void updateAccessToken(String email, String newAccessToken, String newRefreshToken) {
        SessionData session = sessions.get(email);
        if (session != null) {
            session.setAccessToken(newAccessToken);
            if (newRefreshToken != null) {
                session.setRefreshToken(newRefreshToken);
            }
            session.setExpiresAt(LocalDateTime.now().plusHours(1));
        }
    }

    // 6. CLEAR ALL SESSIONS (Admin use)
    public void clearAllSessions() {
        sessions.clear();
    }
}
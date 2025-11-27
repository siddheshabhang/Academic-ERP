import axios from 'axios';
const API_URL = 'http://localhost:8080';

const api = axios.create({
    baseURL: API_URL,
    withCredentials: true,
    headers: {
        'Content-Type': 'application/json',
    }
});

export const placementService = {
    // === AUTHENTICATION ===

    // Status check (Validation)
    validateToken: () => api.get('/api/placement/validate'),

    // Logout
    logout: () => api.post('/auth/signout'),

    // === PLACEMENT OFFERS ===
    // Note: appended '/api/placement' because we changed baseURL to root
    getAllOffers: () => api.get('/api/placement/all'),
    getOfferById: (id) => api.get(`/api/placement/${id}`),

    // === STUDENT FILTERING ===
    getEligibleStudents: (offerId) => api.get(`/api/placement/${offerId}/eligible`),
    getAppliedStudents: (offerId, filters = {}) =>
        api.get(`/api/placement/${offerId}/applications`, { params: filters }),

    // === STUDENT SELECTION ===
    selectStudent: (offerId, studentId) => api.post(`/api/placement/${offerId}/select/${studentId}`),

    // === DROPDOWN DATA ===
    getAllDomains: () => api.get('/api/placement/domains'), // Assuming you have this endpoint
    getAllSpecialisations: () => api.get('/api/placement/specialisations'), // Assuming you have this endpoint
};

export default api;
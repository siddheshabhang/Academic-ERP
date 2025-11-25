import axios from 'axios';

// Ensure this matches your Spring Boot port (usually 8080)
const API_URL = 'http://localhost:8080/api/placement';

const api = axios.create({
    baseURL: API_URL,
});

// Automatically add the token to every request if it exists
api.interceptors.request.use(
    (config) => {
        const token = localStorage.getItem('token');
        if (token) {
            config.headers['Authorization'] = `Bearer ${token}`;
        }
        return config;
    },
    (error) => {
        return Promise.reject(error);
    }
);

export const placementService = {
    // === AUTHENTICATION ===
    login: (token) => localStorage.setItem('token', token),
    logout: () => localStorage.removeItem('token'),

    // === PLACEMENT OFFERS ===
    getAllOffers: () => api.get('/all'),
    getOfferById: (id) => api.get(`/${id}`),

    // === STUDENT FILTERING ===
    getEligibleStudents: (offerId) => api.get(`/${offerId}/eligible`),
    getAppliedStudents: (offerId, filters = {}) =>
        api.get(`/${offerId}/applications`, { params: filters }),

    // === STUDENT SELECTION ===
    selectStudent: (offerId, studentId) => api.post(`/${offerId}/select/${studentId}`),

    // === NEW: DROPDOWN DATA ===
    getAllDomains: () => api.get('/domains'),
    getAllSpecialisations: () => api.get('/specialisations'),
};

export default api;
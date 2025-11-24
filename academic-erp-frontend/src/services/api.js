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
    login: (token) => localStorage.setItem('token', token),
    logout: () => localStorage.removeItem('token'),
    getAllOffers: () => api.get('/all'),
    getOfferById: (id) => api.get(`/${id}`),
    getEligibleStudents: (offerId) => api.get(`/${offerId}/eligible`),
    getAppliedStudents: (offerId, filters = {}) => api.get(`/${offerId}/applications`, { params: filters }),
    selectStudent: (offerId, studentId) => api.post(`/${offerId}/select/${studentId}`)
};

export default api;

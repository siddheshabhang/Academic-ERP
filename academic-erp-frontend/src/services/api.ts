import axios, { AxiosResponse } from 'axios';
import type { Offer, Student, AppliedStudent, Domain, Specialisation, Filters } from '../types';

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
    validateToken: (): Promise<AxiosResponse<void>> => api.get('/api/placement/validate'),

    // Logout
    logout: (): Promise<AxiosResponse<void>> => api.post('/auth/signout'),

    // === PLACEMENT OFFERS ===
    getAllOffers: (): Promise<AxiosResponse<Offer[]>> => api.get('/api/placement/all'),
    getOfferById: (id: string | number): Promise<AxiosResponse<Offer>> => api.get(`/api/placement/${id}`),

    // === STUDENT FILTERING ===
    getEligibleStudents: (offerId: string | number): Promise<AxiosResponse<Student[]>> =>
        api.get(`/api/placement/${offerId}/eligible`),
    getAppliedStudents: (offerId: string | number, filters: Filters = { minGrade: '', domainId: '', specialisationId: '' }): Promise<AxiosResponse<AppliedStudent[]>> =>
        api.get(`/api/placement/${offerId}/applications`, { params: filters }),

    // === STUDENT SELECTION ===
    selectStudent: (offerId: string | number, studentId: number): Promise<AxiosResponse<void>> =>
        api.post(`/api/placement/${offerId}/select/${studentId}`),

    // === DROPDOWN DATA ===
    getAllDomains: (): Promise<AxiosResponse<Domain[]>> => api.get('/api/placement/domains'),
    getAllSpecialisations: (): Promise<AxiosResponse<Specialisation[]>> => api.get('/api/placement/specialisations'),
};

export default api;

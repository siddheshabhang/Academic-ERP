// Type definitions for Academic ERP Frontend

export interface Organisation {
    id: number;
    name: string;
}

export interface Offer {
    id: number;
    profile: string;
    description: string;
    intake: number;
    minGrade: number;
    organisation?: Organisation;
}

export interface Domain {
    id: number;
    program: string;
    batch: string;
}

export interface Specialisation {
    id: number;
    name: string;
}

export interface Student {
    id: number;
    firstName: string;
    lastName: string;
    email: string;
    rollNumber: string;
    cgpa?: number;
    domain?: Domain;
    specialisation?: Specialisation;
    placementStatus?: 'UNPLACED' | 'PLACED'; // Simplified
}

export interface AppliedStudent {
    studentId: number;
    name: string;
    email: string;
    rollNumber: string;
    cgpa: number;
    status: 'PENDING' | 'SELECTED';
    domain?: Domain;
    specialisation?: Specialisation;
    placementStatus?: 'UNPLACED' | 'PLACED'; // Simplified
}

export interface Filters {
    minGrade: string;
    domainId: string;
    specialisationId: string;
}

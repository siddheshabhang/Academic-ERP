import React, { useEffect, useState, FormEvent, ChangeEvent } from 'react';
import { useParams } from 'react-router-dom';
import { placementService } from '../services/api';
import type { Offer, Student, AppliedStudent, Domain, Specialisation, Filters } from '../types';

const OfferDetails: React.FC = () => {
    const { id } = useParams<{ id: string }>();

    const [offer, setOffer] = useState<Offer | null>(null);
    const [students, setStudents] = useState<(Student | AppliedStudent)[]>([]);
    const [activeTab, setActiveTab] = useState<'APPLIED' | 'ELIGIBLE'>('APPLIED');

    const [domains, setDomains] = useState<Domain[]>([]);
    const [specialisations, setSpecialisations] = useState<Specialisation[]>([]);
    const [loadingDropdowns, setLoadingDropdowns] = useState<boolean>(true);

    const [filters, setFilters] = useState<Filters>({
        minGrade: '',
        domainId: '',
        specialisationId: ''
    });
    const [message, setMessage] = useState<string>('');
    const [loadingStudents, setLoadingStudents] = useState<boolean>(false);

    useEffect(() => {
        if (id) {
            loadOfferDetails();
            loadDropdownData();
        }
    }, [id]);

    useEffect(() => {
        if (id) {
            loadStudents();
        }
    }, [id, activeTab]);

    const loadOfferDetails = async (): Promise<void> => {
        if (!id) return;
        try {
            const res = await placementService.getOfferById(id);
            setOffer(res.data);
        } catch (error) {
            console.error("Error loading offer", error);
        }
    };

    const loadDropdownData = async (): Promise<void> => {
        try {
            setLoadingDropdowns(true);
            const [domainsRes, specialisationsRes] = await Promise.all([
                placementService.getAllDomains(),
                placementService.getAllSpecialisations()
            ]);
            setDomains(domainsRes.data);
            setSpecialisations(specialisationsRes.data);
        } catch (error) {
            console.error("Error loading dropdown data", error);
        } finally {
            setLoadingDropdowns(false);
        }
    };

    const loadStudents = async (): Promise<void> => {
        if (!id) return;
        try {
            setLoadingStudents(true);
            let res;
            if (activeTab === 'ELIGIBLE') {
                res = await placementService.getEligibleStudents(id);
            } else {
                res = await placementService.getAppliedStudents(id, filters);
            }

            // MOCK: Randomly assign placement status for demonstration, but ensure consistency
            const mockStudents = res.data.map((s: any) => ({
                ...s,
                placementStatus: s.status === 'SELECTED' ? 'PLACED' : (s.placementStatus || (Math.random() > 0.7 ? 'PLACED' : 'UNPLACED'))
            }));

            setStudents(mockStudents);
            setMessage('');
        } catch (error) {
            console.error("Error loading students", error);
            setMessage('Error loading students. Please try again.');
        } finally {
            setLoadingStudents(false);
        }
    };

    const handleFilterChange = (e: ChangeEvent<HTMLInputElement | HTMLSelectElement>): void => {
        setFilters({ ...filters, [e.target.name]: e.target.value });
    };

    const applyFilters = (e: FormEvent<HTMLFormElement>): void => {
        e.preventDefault();
        loadStudents();
    };

    const handleResetFilters = async (): Promise<void> => {
        // Clear the filters in state
        setFilters({ minGrade: '', domainId: '', specialisationId: '' });

        // Immediately reload with empty filters (don't wait for state update)
        if (!id) return;
        try {
            setLoadingStudents(true);
            const emptyFilters = { minGrade: '', domainId: '', specialisationId: '' };
            const res = await placementService.getAppliedStudents(id, emptyFilters);

            const mockStudents = res.data.map((s: any) => ({
                ...s,
                placementStatus: s.status === 'SELECTED' ? 'PLACED' : (s.placementStatus || (Math.random() > 0.7 ? 'PLACED' : 'UNPLACED'))
            }));

            setStudents(mockStudents);
            setMessage('');
        } catch (error) {
            console.error("Error resetting filters", error);
            setMessage('Error loading students. Please try again.');
        } finally {
            setLoadingStudents(false);
        }
    };

    const handleSelectStudent = async (studentId: number): Promise<void> => {
        if (!window.confirm("Are you sure you want to select this student?")) return;
        if (!id) return;

        try {
            await placementService.selectStudent(id, studentId);
            setMessage("Student selected successfully!");
            loadStudents();
            setTimeout(() => setMessage(''), 3000);
        } catch (error: any) {
            const errorMsg = error.response?.data?.message || "Failed to select student.";
            setMessage(errorMsg);
        }
    };

    const isAppliedStudent = (student: Student | AppliedStudent): student is AppliedStudent => {
        return 'status' in student;
    };

    if (!offer) {
        return (
            <div className="page-shell">
                <div className="loading-state">
                    <span className="spinner-border text-primary"></span>
                    <p className="mt-3 text-muted mb-0">Loading offer details...</p>
                </div>
            </div>
        );
    }

    return (
        <div className="page-shell">
            <div className="container py-4">
                {/* Header Card */}
                <div className="glass-panel offer-summary">
                    <div>
                        <span className="brand-pill mb-2 d-inline-block">
                            {offer.organisation?.name || 'Partner organisation'}
                        </span>
                        <h3>{offer.profile}</h3>
                        <p className="text-muted mb-0">{offer.description}</p>
                    </div>
                    <div className="summary-tags">
                        <div>
                            <p className="label">Intake</p>
                            <span className="badge bg-outline">{offer.intake} seats</span>
                        </div>
                        <div>
                            <p className="label">Minimum CGPA</p>
                            <span className="badge bg-outline">{offer.minGrade}</span>
                        </div>
                    </div>
                </div>

                {/* Success/Error Message */}
                {message && (
                    <div className={`alert alert-${message.includes("successfully") ? "success" : "danger"}`}>
                        {message}
                    </div>
                )}

                {/* Navigation Tabs */}
                <div className="tab-strip glass-panel">
                    <button
                        className={`tab-link ${activeTab === 'APPLIED' ? 'active' : ''}`}
                        onClick={() => setActiveTab('APPLIED')}
                    >
                        <i className="bi bi-clipboard-check me-2"></i>
                        Applied Students
                    </button>
                    <button
                        className={`tab-link ${activeTab === 'ELIGIBLE' ? 'active' : ''}`}
                        onClick={() => setActiveTab('ELIGIBLE')}
                    >
                        <i className="bi bi-lightning-charge me-2"></i>
                        Eligible Students
                    </button>
                </div>

                {/* Filter Section (Only on Applied Tab) */}
                {activeTab === 'APPLIED' && (
                    <form onSubmit={applyFilters} className="filters-card glass-panel">
                        <div className="filter-field">
                            <label className="form-label small fw-bold">CGPA</label>
                            <input
                                type="number"
                                step="0.1"
                                min="0"
                                max="4"
                                name="minGrade"
                                className="form-control"
                                placeholder="e.g. 3.5"
                                value={filters.minGrade}
                                onChange={handleFilterChange}
                            />
                        </div>

                        {/* Domain Filter Dropdown */}
                        <div className="filter-field">
                            <label className="form-label small fw-bold">Filter by Domain</label>
                            <select
                                name="domainId"
                                className="form-select"
                                value={filters.domainId}
                                onChange={handleFilterChange}
                                disabled={loadingDropdowns}
                            >
                                <option value="">All Domains</option>
                                {domains.map(domain => (
                                    <option key={domain.id} value={domain.id}>
                                        {domain.program} ({domain.batch})
                                    </option>
                                ))}
                            </select>
                        </div>

                        {/* Specialisation Filter Dropdown */}
                        <div className="filter-field">
                            <label className="form-label small fw-bold">Filter by Specialisation</label>
                            <select
                                name="specialisationId"
                                className="form-select"
                                value={filters.specialisationId}
                                onChange={handleFilterChange}
                                disabled={loadingDropdowns}
                            >
                                <option value="">All Specialisations</option>
                                {specialisations.map(spec => (
                                    <option key={spec.id} value={spec.id}>
                                        {spec.name}
                                    </option>
                                ))}
                            </select>
                        </div>

                        <div className="filter-field filter-field__action">
                            <label className="form-label small fw-bold" style={{ visibility: 'hidden' }}>Actions</label>
                            <div style={{ display: 'flex', gap: '0.5rem' }}>
                                <button
                                    type="submit"
                                    className="btn btn-gradient"
                                    disabled={loadingStudents}
                                    style={{ flex: 1 }}
                                >
                                    {loadingStudents ? 'Filtering...' : 'Apply Filters'}
                                </button>
                                <button
                                    type="button"
                                    className="btn btn-outline-secondary"
                                    onClick={handleResetFilters}
                                    disabled={loadingStudents}
                                >
                                    Reset
                                </button>
                            </div>
                        </div>
                    </form>
                )}

                {/* Student List Table */}
                <div className="table-responsive glass-panel">
                    {loadingStudents && <div className="text-center py-4"><span className="spinner-border spinner-border-sm"></span> Loading students...</div>}
                    {!loadingStudents && (
                        <table className="table modern-table">
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Name</th>
                                    <th>Roll Number</th>
                                    <th>Email</th>
                                    <th>Domain</th>
                                    <th>Specialisation</th>
                                    {activeTab === 'APPLIED' && <th>CGPA</th>}
                                    {activeTab === 'APPLIED' && <th>Placement Status</th>}
                                    {activeTab === 'APPLIED' && <th>Current Status</th>}
                                    {activeTab === 'APPLIED' && <th>Action</th>}
                                </tr>
                            </thead>
                            <tbody>
                                {students.length === 0 && (
                                    <tr><td colSpan={9} className="text-center py-4 text-muted">
                                        {activeTab === 'APPLIED'
                                            ? 'No students have applied yet.'
                                            : 'No eligible students found for this offer.'}
                                    </td></tr>
                                )}

                                {students.map(student => {
                                    const studentId = isAppliedStudent(student) ? student.studentId : student.id;
                                    const studentName = isAppliedStudent(student)
                                        ? student.name
                                        : `${student.firstName} ${student.lastName}`;

                                    return (
                                        <tr key={studentId}>
                                            <td>{studentId}</td>
                                            <td>{studentName}</td>
                                            <td>{student.rollNumber}</td>
                                            <td>{student.email}</td>
                                            <td>{student.domain?.program || '-'}</td>
                                            <td>{student.specialisation?.name || '-'}</td>
                                            {activeTab === 'APPLIED' && isAppliedStudent(student) && (
                                                <td>{student.cgpa?.toFixed(2) || '-'}</td>
                                            )}
                                            {activeTab === 'APPLIED' && (
                                                <td>
                                                    {student.placementStatus === 'PLACED' && <span className="badge bg-success">Placed</span>}
                                                    {student.placementStatus === 'UNPLACED' && <span className="badge bg-secondary">Unplaced</span>}
                                                </td>
                                            )}
                                            {activeTab === 'APPLIED' && isAppliedStudent(student) && (
                                                <td>
                                                    {student.status === 'SELECTED'
                                                        ? <span className="badge bg-success">SELECTED</span>
                                                        : <span className="badge bg-warning text-dark">PENDING</span>}
                                                </td>
                                            )}
                                            {activeTab === 'APPLIED' && (
                                                <td>
                                                    {isAppliedStudent(student) && student.status !== 'SELECTED' && (
                                                        <button
                                                            className="btn btn-success btn-sm"
                                                            onClick={() => handleSelectStudent(student.studentId)}
                                                            disabled={loadingStudents || student.placementStatus === 'PLACED'}
                                                            title={student.placementStatus === 'PLACED' ? "Student is already placed." : "Select Student"}
                                                        >
                                                            Select
                                                        </button>
                                                    )}
                                                    {isAppliedStudent(student) && student.status === 'SELECTED' && (
                                                        <span className="text-success small">✓ Selected</span>
                                                    )}
                                                </td>
                                            )}
                                        </tr>
                                    );
                                })}
                            </tbody>
                        </table>
                    )}
                </div>
            </div>
        </div>
    );
};

export default OfferDetails;

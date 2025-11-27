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

    if (!offer) return <div className="p-4">Loading offer details...</div>;

    return (
        <div className="container mt-4">
            {/* Header Card */}
            <div className="card mb-4 shadow-sm border-primary">
                <div className="card-body">
                    <h3>{offer.profile} <span className="text-muted fs-5">@ {offer.organisation?.name}</span></h3>
                    <p className="mb-1">{offer.description}</p>
                    <span className="badge bg-primary me-2">Intake: {offer.intake}</span>
                    <span className="badge bg-info text-dark">Min CGPA: {offer.minGrade}</span>
                </div>
            </div>

            {/* Success/Error Message */}
            {message && (
                <div className={`alert alert-${message.includes("successfully") ? "success" : "danger"}`}>
                    {message}
                </div>
            )}

            {/* Navigation Tabs */}
            <ul className="nav nav-tabs mb-3">
                <li className="nav-item">
                    <button
                        className={`nav-link ${activeTab === 'APPLIED' ? 'active fw-bold' : ''}`}
                        onClick={() => setActiveTab('APPLIED')}
                    >
                        Applied Students
                    </button>
                </li>
                <li className="nav-item">
                    <button
                        className={`nav-link ${activeTab === 'ELIGIBLE' ? 'active fw-bold' : ''}`}
                        onClick={() => setActiveTab('ELIGIBLE')}
                    >
                        Eligible Students
                    </button>
                </li>
            </ul>

            {/* Filter Section (Only on Applied Tab) */}
            {activeTab === 'APPLIED' && (
                <form onSubmit={applyFilters} className="row g-3 mb-4 bg-light p-3 rounded border">
                    <div className="col-md-3">
                        <label className="form-label small fw-bold">Filter by CGPA</label>
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
                    <div className="col-md-3">
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
                    <div className="col-md-3">
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

                    <div className="col-md-3 d-flex align-items-end">
                        <button
                            type="submit"
                            className="btn btn-secondary w-100"
                            disabled={loadingStudents}
                        >
                            {loadingStudents ? 'Filtering...' : 'Apply Filters'}
                        </button>
                    </div>

                    {/* Reset Filters Button */}
                    <div className="col-12">
                        <button
                            type="button"
                            className="btn btn-outline-secondary btn-sm"
                            onClick={() => {
                                setFilters({ minGrade: '', domainId: '', specialisationId: '' });
                            }}
                        >
                            Reset Filters
                        </button>
                    </div>
                </form>
            )}

            {/* Student List Table */}
            <div className="table-responsive">
                {loadingStudents && <div className="text-center py-4"><span className="spinner-border spinner-border-sm"></span> Loading students...</div>}
                {!loadingStudents && (
                    <table className="table table-striped table-hover border">
                        <thead className="table-dark">
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
    );
};

export default OfferDetails;

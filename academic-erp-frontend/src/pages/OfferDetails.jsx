import React, { useEffect, useState } from 'react';
import { useParams } from 'react-router-dom';
import { placementService } from '../services/api';

const OfferDetails = () => {
    // 1. Get the 'id' from the URL (e.g., /offer/1)
    const { id } = useParams();

    // 2. STATE: Data for this page
    const [offer, setOffer] = useState(null);
    const [students, setStudents] = useState([]);
    const [activeTab, setActiveTab] = useState('APPLIED');

    // Dropdown Options State
    const [domains, setDomains] = useState([]);
    const [specialisations, setSpecialisations] = useState([]);
    const [loadingDropdowns, setLoadingDropdowns] = useState(true);

    // Filters State
    const [filters, setFilters] = useState({
        minGrade: '',
        domainId: '',
        specialisationId: ''
    });
    const [message, setMessage] = useState('');
    const [loadingStudents, setLoadingStudents] = useState(false);

    // 3. Load Offer Details and Dropdown Data immediately
    useEffect(() => {
        loadOfferDetails();
        loadDropdownData();
    }, [id]);

    // 4. Load Students whenever Tab changes OR ID changes
    useEffect(() => {
        loadStudents();
    }, [id, activeTab]);

    const loadOfferDetails = async () => {
        try {
            const res = await placementService.getOfferById(id);
            setOffer(res.data);
        } catch (err) {
            console.error("Error loading offer", err);
        }
    };

    // Load domains and specialisations for dropdowns
    const loadDropdownData = async () => {
        try {
            setLoadingDropdowns(true);
            const [domainsRes, specialisationsRes] = await Promise.all([
                placementService.getAllDomains(),
                placementService.getAllSpecialisations()
            ]);
            setDomains(domainsRes.data);
            setSpecialisations(specialisationsRes.data);
        } catch (err) {
            console.error("Error loading dropdown data", err);
        } finally {
            setLoadingDropdowns(false);
        }
    };

    const loadStudents = async () => {
        try {
            setLoadingStudents(true);
            let res;
            if (activeTab === 'ELIGIBLE') {
                // Use Case: View Eligible
                res = await placementService.getEligibleStudents(id);
            } else {
                // Use Case: View Applied + Filtering
                res = await placementService.getAppliedStudents(id, filters);
            }
            setStudents(res.data);
            setMessage(''); // Clear previous messages
        } catch (err) {
            console.error("Error loading students", err);
            setMessage('Error loading students. Please try again.');
        } finally {
            setLoadingStudents(false);
        }
    };

    // Handle typing in filter boxes
    const handleFilterChange = (e) => {
        setFilters({ ...filters, [e.target.name]: e.target.value });
    };

    // Handle clicking "Filter Results"
    const applyFilters = (e) => {
        e.preventDefault();
        loadStudents();
    };

    // Handle "Select" button
    const handleSelectStudent = async (studentId) => {
        if (!window.confirm("Are you sure you want to select this student?")) return;

        try {
            await placementService.selectStudent(id, studentId);
            setMessage("Student selected successfully!");
            loadStudents(); // Refresh list
            setTimeout(() => setMessage(''), 3000); // Clear message after 3 seconds
        } catch (err) {
            const errorMsg = err.response?.data?.message || "Failed to select student.";
            setMessage(errorMsg);
        }
    };

    if (!offer) return <div className="p-4">Loading offer details...</div>;

    return (
        <div>
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
                                {activeTab === 'APPLIED' && <th>Status</th>}
                                {activeTab === 'APPLIED' && <th>Action</th>}
                            </tr>
                        </thead>
                        <tbody>
                            {students.length === 0 && (
                                <tr><td colSpan="8" className="text-center py-4 text-muted">
                                    {activeTab === 'APPLIED'
                                        ? 'No students have applied yet.'
                                        : 'No eligible students found for this offer.'}
                                </td></tr>
                            )}

                            {students.map(student => (
                                <tr key={activeTab === 'APPLIED' ? student.studentId : student.id}>
                                    {/* Handle ID differences between DTO and Entity */}
                                    <td>{activeTab === 'APPLIED' ? student.studentId : student.id}</td>
                                    <td>{activeTab === 'APPLIED' ? student.name : `${student.firstName} ${student.lastName}`}</td>
                                    <td>{student.rollNumber}</td>
                                    <td>{student.email}</td>
                                    <td>{student.domain?.program || '-'}</td>
                                    <td>{student.specialisation?.name || '-'}</td>
                                    {activeTab === 'APPLIED' && <td>{student.cgpa?.toFixed(2) || '-'}</td>}
                                    {activeTab === 'APPLIED' && (
                                        <td>
                                            {student.status === 'SELECTED'
                                                ? <span className="badge bg-success">SELECTED</span>
                                                : <span className="badge bg-warning text-dark">PENDING</span>}
                                        </td>
                                    )}
                                    <td>
                                        {/* Selection Logic - Only for Applied Students */}
                                        {activeTab === 'APPLIED' && student.status !== 'SELECTED' && (
                                            <button
                                                className="btn btn-success btn-sm"
                                                onClick={() => handleSelectStudent(student.studentId)}
                                                disabled={loadingStudents}
                                            >
                                                Select
                                            </button>
                                        )}
                                        {activeTab === 'APPLIED' && student.status === 'SELECTED' && (
                                            <span className="text-success small">✓ Selected</span>
                                        )}
                                    </td>
                                </tr>
                            ))}
                        </tbody>
                    </table>
                )}
            </div>
        </div>
    );
};

export default OfferDetails;
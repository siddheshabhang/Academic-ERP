import React, { useEffect, useState } from 'react';
import { useParams } from 'react-router-dom';
import { placementService } from '../services/api';

const OfferDetails = () => {
    // 1. Get the 'id' from the URL (e.g., /offer/1)
    const { id } = useParams();

    // 2. STATE: Data for this page
    const [offer, setOffer] = useState(null);
    const [students, setStudents] = useState([]);
    const [activeTab, setActiveTab] = useState('APPLIED'); // Default tab

    // Filters State
    const [filters, setFilters] = useState({ minGrade: '', domainId: '', specialisationId: '' });
    const [message, setMessage] = useState('');

    // 3. Load Offer Details immediately
    useEffect(() => {
        loadOfferDetails();
    }, [id]);

    // 4. Load Students whenever Tab changes OR Filters are applied
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

    const loadStudents = async () => {
        try {
            let res;
            if (activeTab === 'ELIGIBLE') {
                // Use Case: View Eligible
                res = await placementService.getEligibleStudents(id);
            } else {
                // Use Case: View Applied + Filtering
                res = await placementService.getAppliedStudents(id, filters);
            }
            setStudents(res.data);
        } catch (err) {
            console.error("Error loading students", err);
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
            loadStudents(); // Refresh list to show 'SELECTED' status
        } catch (err) {
            alert("Failed to select student.");
        }
    };

    if (!offer) return <div className="p-4">Loading...</div>;

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

            {/* Success Message */}
            {message && <div className="alert alert-success">{message}</div>}

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
                            name="minGrade"
                            className="form-control"
                            placeholder="e.g. 3.5"
                            onChange={handleFilterChange}
                        />
                    </div>
                    <div className="col-md-3 d-flex align-items-end">
                        <button type="submit" className="btn btn-secondary w-100">Apply Filters</button>
                    </div>
                </form>
            )}

            {/* Student List Table */}
            <div className="table-responsive">
                <table className="table table-striped table-hover border">
                    <thead className="table-dark">
                        <tr>
                            <th>ID</th>
                            <th>Name</th>
                            <th>Roll Number</th>
                            <th>Email</th>
                            {activeTab === 'APPLIED' && <th>Status</th>}
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        {students.length === 0 && (
                            <tr><td colSpan="6" className="text-center py-4">No students found.</td></tr>
                        )}

                        {students.map(student => (
                            <tr key={activeTab === 'APPLIED' ? student.studentId : student.id}>
                                {/* Handle ID differences between DTO and Entity */}
                                <td>{activeTab === 'APPLIED' ? student.studentId : student.id}</td>
                                <td>{activeTab === 'APPLIED' ? student.name : `${student.firstName} ${student.lastName}`}</td>
                                <td>{student.rollNumber}</td>
                                <td>{student.email}</td>

                                {activeTab === 'APPLIED' && (
                                    <td>
                                        {student.status === 'SELECTED'
                                            ? <span className="badge bg-success">SELECTED</span>
                                            : <span className="badge bg-warning text-dark">PENDING</span>}
                                    </td>
                                )}

                                <td>
                                    {/* Selection Logic */}
                                    {activeTab === 'APPLIED' && student.status !== 'SELECTED' && (
                                        <button
                                            className="btn btn-success btn-sm"
                                            onClick={() => handleSelectStudent(student.studentId)}
                                        >
                                            Select
                                        </button>
                                    )}
                                </td>
                            </tr>
                        ))}
                    </tbody>
                </table>
            </div>
        </div>
    );
};

export default OfferDetails;
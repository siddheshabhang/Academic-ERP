import React, { useEffect, useMemo, useState } from 'react';
import { Link, useNavigate } from 'react-router-dom';
import { placementService } from '../services/api';
import type { Offer } from '../types';

const Dashboard: React.FC = () => {
    const navigate = useNavigate();
    const [offers, setOffers] = useState<Offer[]>([]);
    const [error, setError] = useState<string>('');
    const [isValidating, setIsValidating] = useState<boolean>(true);

    useEffect(() => {
        validateAndLoadData();
    }, []);

    const validateAndLoadData = async (): Promise<void> => {
        try {
            await placementService.validateToken();
            loadOffers();
        } catch (err) {
            setError("Session expired. Please login again.");
            setTimeout(() => navigate('/login'), 2000);
        } finally {
            setIsValidating(false);
        }
    };

    const loadOffers = async (): Promise<void> => {
        try {
            const response = await placementService.getAllOffers();
            setOffers(response.data);
        } catch (err) {
            setError("Failed to fetch offers. Are you logged in?");
        }
    };

    const handleLogout = async (): Promise<void> => {
        try {
            await placementService.logout();
            navigate('/login');
        } catch (err) {
            console.error('Logout error:', err);
            navigate('/login');
        }
    };

    const totalIntake = useMemo(
        () => offers.reduce((sum, offer) => sum + (offer.intake || 0), 0),
        [offers]
    );

    const avgCgpa = useMemo(() => {
        if (!offers.length) return '-';
        const valid = offers.filter((offer) => typeof offer.minGrade === 'number');
        if (!valid.length) return '-';
        const total = valid.reduce((sum, offer) => sum + (offer.minGrade || 0), 0);
        return (total / valid.length).toFixed(2);
    }, [offers]);

    const heroSubtext = offers.length
        ? `${offers.length} open ${offers.length === 1 ? 'offer' : 'offers'} monitored in real-time`
        : 'Connect with hiring partners and manage applications at scale.';

    if (isValidating) {
        return (
            <div className="page-shell">
                <div className="loading-state">
                    <span className="spinner-border text-primary"></span>
                    <p className="mt-3 text-muted mb-0">Validating session...</p>
                </div>
            </div>
        );
    }

    return (
        <div className="page-shell dashboard-page">
            <div className="container py-4">
            {/* Header Section */}
                <div className="erp-hero">
                    <div>
                        <p className="eyebrow mb-1">Recruitment Analytics</p>
                        <h2 className="hero-title">Placement Dashboard</h2>
                        <p className="hero-subtitle">{heroSubtext}</p>
                    </div>
                    <button className="btn btn-outline-light btn-sm" onClick={handleLogout}>
                        <i className="bi bi-box-arrow-right me-2"></i>
                    Logout
                </button>
            </div>

                {/* Stats */}
                <div className="stats-grid">
                    <div className="stat-card">
                        <p className="label">Active Offers</p>
                        <h3>{offers.length || '—'}</h3>
                        <span className="trend text-success">
                            <i className="bi bi-arrow-up-right"></i> Live data
                        </span>
                    </div>
                    <div className="stat-card">
                        <p className="label">Total Intake</p>
                        <h3>{totalIntake || '—'}</h3>
                        <span className="trend text-primary">Seats planned</span>
                    </div>
                    <div className="stat-card">
                        <p className="label">Average Min CGPA</p>
                        <h3>{avgCgpa}</h3>
                        <span className="trend text-warning">Eligibility benchmark</span>
                    </div>
                </div>

            {/* Error Message */}
                {error && <div className="alert alert-danger mt-4">{error}</div>}

            {/* Empty State */}
            {offers.length === 0 && !error && (
                    <div className="empty-state glass-panel mt-4">
                        <i className="bi bi-folder2-open"></i>
                        <p className="mb-1 fw-semibold">No offers found</p>
                        <span className="text-muted">Create an offer to begin tracking applicants.</span>
                </div>
            )}

            {/* Offers Grid */}
                <div className="offer-grid mt-4">
                {offers.map((offer) => (
                        <div className="offer-card glass-panel" key={offer.id}>
                            <div className="offer-card__header">
                                <div>
                                    <p className="label text-uppercase mb-1">
                                        {offer.organisation?.name || 'Unknown Organisation'}
                                    </p>
                                    <h5>{offer.profile}</h5>
                                </div>
                                <span className="badge bg-gradient">{offer.intake} seats</span>
                            </div>

                            <p className="offer-description">{offer.description}</p>

                            <div className="offer-meta">
                                <div>
                                    <p className="label mb-0">Min CGPA</p>
                                    <h6 className="mb-0">{offer.minGrade || '-'}</h6>
                                </div>
                                <div>
                                    <p className="label mb-0">Organisation</p>
                                    <h6 className="mb-0">
                                        {offer.organisation?.name || 'Not provided'}
                                </h6>
                                </div>
                            </div>

                            <Link to={`/offer/${offer.id}`} className="btn btn-outline-primary w-100">
                                Manage Applications
                            </Link>
                        </div>
                    ))}
                    </div>
            </div>
        </div>
    );
};

export default Dashboard;

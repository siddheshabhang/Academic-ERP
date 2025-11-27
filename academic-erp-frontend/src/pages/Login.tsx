import React, { useEffect, useState } from 'react';
import { useSearchParams, useNavigate } from 'react-router-dom';
import { placementService } from '../services/api';

const Login: React.FC = () => {
    const [searchParams] = useSearchParams();
    const navigate = useNavigate();
    const [errorMessage, setErrorMessage] = useState<string>('');

    useEffect(() => {
        const error = searchParams.get('error');
        if (error) {
            if (error === 'Unauthorized') {
                setErrorMessage("Access Denied: You are not authorized to access this portal.");
            } else {
                setErrorMessage(error);
            }
        }
    }, [searchParams]);

    const handleGoogleLogin = (): void => {
        window.location.href = "http://localhost:8080/auth/login";
    };

    useEffect(() => {
        const checkAuth = async (): Promise<void> => {
            try {
                await placementService.validateToken();
                navigate('/dashboard');
            } catch (err) {
                // Not logged in, stay on login page
            }
        };
        checkAuth();
    }, [navigate]);

    const trustBadges = [
        { icon: 'bi-shield-check', label: 'Secure OAuth2 Login' },
        { icon: 'bi-bar-chart', label: 'Live Offer Insights' },
        { icon: 'bi-people', label: 'Candidate Shortlisting' },
    ];

    return (
        <div className="page-shell login-page">
            <div className="login-grid container">
                <div className="login-showcase">
                    <span className="brand-pill">IIITB · Outreach</span>
                    <h1>
                        Placement Cell <span className="text-highlight">Command Center</span>
                    </h1>
                    <p>
                        Track offers, shortlist candidates, and collaborate with the Outreach team
                        through a single secure dashboard tailored for recruitment drives.
                    </p>

                    <div className="showcase-cards">
                        {trustBadges.map((badge) => (
                            <div className="showcase-card" key={badge.label}>
                                <i className={`bi ${badge.icon}`}></i>
                                <span>{badge.label}</span>
                            </div>
                        ))}
                    </div>

                    <div className="glow-blur"></div>
                </div>

                <div className="glass-panel login-panel">
                <div className="text-center mb-4">
                        <h3 className="fw-bold text-primary mb-1">Academic ERP</h3>
                        <p className="text-muted mb-0">Placement Cell Portal</p>
                </div>

                {errorMessage && (
                    <div className="alert alert-danger text-center small" role="alert">
                        {errorMessage}
                    </div>
                )}

                    <div className="login-actions">
                    <button
                            className="google-btn"
                        onClick={handleGoogleLogin}
                    >
                        <img
                            src="https://developers.google.com/identity/images/g-logo.png"
                            alt="G"
                                className="google-icon"
                        />
                        <span>Sign in with Google</span>
                    </button>
                        <p className="text-muted small text-center mb-0 mt-3">
                            Only authorized Outreach employees can access this dashboard.
                        </p>
                </div>
                </div>
            </div>
        </div>
    );
};

export default Login;

import React, { useEffect, useState } from 'react';
import { useSearchParams, useNavigate } from 'react-router-dom';
import { placementService } from '../services/api';

const Login = () => {
    const [searchParams] = useSearchParams();
    const navigate = useNavigate();
    const [errorMessage, setErrorMessage] = useState('');

    useEffect(() => {
        const error = searchParams.get('error');
        if (error) {
            // Clean up the error message for display
            if (error === 'Unauthorized') {
                setErrorMessage("Access Denied: You are not authorized to access this portal.");
            } else {
                setErrorMessage(error);
            }
        }
    }, [searchParams]);

    const handleGoogleLogin = () => {
        // Redirect to backend OAuth endpoint
        window.location.href = "http://localhost:8080/auth/login";
    };

    // If already logged in, redirect to dashboard
    useEffect(() => {
        const checkAuth = async () => {
            try {
                await placementService.validateToken();
                navigate('/dashboard'); // Changed from '/' to '/dashboard'
            } catch (err) {
                // Not logged in, stay on login page
            }
        };
        checkAuth();
    }, [navigate]);

    return (
        <div className="container d-flex justify-content-center align-items-center vh-100">
            <div className="card shadow-lg p-4" style={{ width: '400px', borderRadius: '15px' }}>
                <div className="text-center mb-4">
                    <h3 className="fw-bold text-primary">Academic ERP</h3>
                    <p className="text-muted">Placement Cell Portal</p>
                </div>

                {/* ERROR MESSAGE DISPLAY */}
                {errorMessage && (
                    <div className="alert alert-danger text-center small" role="alert">
                        {errorMessage}
                    </div>
                )}

                <div className="d-flex justify-content-center my-3">
                    <button
                        className="btn btn-light border w-100 d-flex align-items-center justify-content-center py-2 shadow-sm"
                        onClick={handleGoogleLogin}
                        style={{ gap: '10px', fontSize: '16px', fontWeight: '500' }}
                    >
                        <img
                            src="https://developers.google.com/identity/images/g-logo.png"
                            alt="G"
                            style={{ width: '20px', height: '20px' }}
                        />
                        <span>Sign in with Google</span>
                    </button>
                </div>

                <div className="text-center mt-3">
                    <small className="text-muted">
                        Only authorized Outreach employees can access this dashboard.
                    </small>
                </div>
            </div>
        </div>
    );
};

export default Login;
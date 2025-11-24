import React, { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { GoogleLogin } from '@react-oauth/google';
import { placementService } from '../services/api';

const Login = () => {
    const navigate = useNavigate();
    const [errorMessage, setErrorMessage] = useState('');

    const handleSuccess = (credentialResponse) => {
        try {
            const token = credentialResponse.credential;
            console.log("Google Token:", token);
            placementService.login(token);
            navigate('/');
        } catch (err) {
            setErrorMessage("Login failed. Please try again.");
        }
    };

    const handleError = () => {
        setErrorMessage("Google Sign-In failed. Please check your network.");
    };

    return (
        <div className="container d-flex justify-content-center align-items-center vh-100">
            <div className="card shadow-lg p-4" style={{ width: '400px', borderRadius: '15px' }}>
                <div className="text-center mb-4">
                    <h3 className="fw-bold text-primary">Academic ERP</h3>
                    <p className="text-muted">Placement Cell Portal</p>
                </div>

                {errorMessage && (
                    <div className="alert alert-danger text-center" role="alert">
                        {errorMessage}
                    </div>
                )}

                <div className="d-flex justify-content-center my-3">
                    <GoogleLogin
                        onSuccess={handleSuccess}
                        onError={handleError}
                        size="large"
                        width="300"
                        theme="outline"
                        text="signin_with"
                        shape="pill"
                    />
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
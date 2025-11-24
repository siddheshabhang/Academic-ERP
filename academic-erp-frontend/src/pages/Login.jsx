import React, { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { placementService } from '../services/api';

const Login = () => {
    const [token, setToken] = useState('');
    const navigate = useNavigate();

    const handleLogin = (e) => {
        e.preventDefault();
        // 1. Save the token to the browser
        placementService.login(token);
        // 2. Go to the Dashboard
        navigate('/');
    };

    return (
        <div className="card p-4 mx-auto shadow" style={{ maxWidth: '400px', marginTop: '100px' }}>
            <h3 className="text-center mb-3">ERP Login</h3>

            <div className="alert alert-info small">
                <strong>Dev Hint:</strong><br/>
                Enter <code>123</code> for Suresh (Outreach).<br/>
                Enter <code>456</code> for Ramesh (Admin).
            </div>

            <form onSubmit={handleLogin}>
                <div className="mb-3">
                    <label className="form-label">Enter Mock Token:</label>
                    <input
                        type="text"
                        className="form-control"
                        value={token}
                        onChange={(e) => setToken(e.target.value)}
                        placeholder="e.g. 123"
                        required
                    />
                </div>
                <button type="submit" className="btn btn-primary w-100">Login</button>
            </form>
        </div>
    );
};

export default Login;
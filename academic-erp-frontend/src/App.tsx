import React from 'react';
import { BrowserRouter as Router, Routes, Route, Navigate } from 'react-router-dom';
import Login from './pages/Login';
import Dashboard from './pages/Dashboard';
import OfferDetails from './pages/OfferDetails';
import PrivateRoute from './components/PrivateRoute';
import 'bootstrap/dist/css/bootstrap.min.css';
import 'bootstrap-icons/font/bootstrap-icons.css';

const App: React.FC = () => {
    return (
        <Router>
            <Routes>
                {/* Login Page */}
                <Route path="/login" element={<Login />} />

                {/* Dashboard (Protected) */}
                <Route path="/dashboard" element={
                    <PrivateRoute>
                        <Dashboard />
                    </PrivateRoute>
                } />

                {/* Offer Details Page (Protected) */}
                <Route path="/offer/:id" element={
                    <PrivateRoute>
                        <OfferDetails />
                    </PrivateRoute>
                } />

                {/* Default Route - Redirect to Login */}
                <Route path="/" element={<Navigate to="/login" replace />} />
            </Routes>
        </Router>
    );
};

export default App;

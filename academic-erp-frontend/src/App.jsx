import React, { useState, useEffect } from 'react';
import { BrowserRouter as Router, Routes, Route, Navigate } from 'react-router-dom';
import Login from './pages/Login';
import Dashboard from './pages/Dashboard';
import OfferDetails from './pages/OfferDetails';
import 'bootstrap/dist/css/bootstrap.min.css';
import { placementService } from './services/api';

const PrivateRoute = ({ children }) => {
  const [isAuthenticated, setIsAuthenticated] = useState(null); // null = checking, true/false = result

  useEffect(() => {
    checkAuth();
  }, []);

  const checkAuth = async () => {
    try {
      await placementService.validateToken();
      setIsAuthenticated(true);
    } catch (err) {
      setIsAuthenticated(false);
    }
  };

  // Still checking
  if (isAuthenticated === null) {
    return <div className="p-4">Checking authentication...</div>;
  }

  // Not authenticated - redirect to login
  if (!isAuthenticated) {
    return <Navigate to="/login" replace />;
  }

  // Authenticated - show the protected content
  return children;
};

function App() {
  return (
    <Router>
      <div className="container mt-4">
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
      </div>
    </Router>
  );
}

export default App;
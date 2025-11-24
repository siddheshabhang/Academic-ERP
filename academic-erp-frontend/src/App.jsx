import React from 'react';
import { BrowserRouter as Router, Routes, Route, Navigate } from 'react-router-dom';
import Login from './pages/Login';
import Dashboard from './pages/Dashboard';
import OfferDetails from './pages/OfferDetails'; // <--- IMPORT THIS
import 'bootstrap/dist/css/bootstrap.min.css';

// Security Guard
const PrivateRoute = ({ children }) => {
    const isAuthenticated = localStorage.getItem('token');
    return isAuthenticated ? children : <Navigate to="/login" />;
};

function App() {
  return (
    <Router>
      <div className="container mt-4">
        <Routes>
          {/* Login Page */}
          <Route path="/login" element={<Login />} />

          {/* Dashboard (Home) */}
          <Route path="/" element={
            <PrivateRoute>
              <Dashboard />
            </PrivateRoute>
          } />

          {/* Offer Details Page */}
          <Route path="/offer/:id" element={
            <PrivateRoute>
              <OfferDetails />
            </PrivateRoute>
          } />
        </Routes>
      </div>
    </Router>
  );
}

export default App;
import React from 'react';
import { BrowserRouter as Router, Routes, Route, Navigate } from 'react-router-dom';
import Login from './pages/Login';
import Dashboard from './pages/Dashboard';
import 'bootstrap/dist/css/bootstrap.min.css';

// --- SECURITY GUARD ---
// This simple component checks if you have a token.
// If yes -> Let you through (children).
// If no  -> Redirect you to "/login".
const PrivateRoute = ({ children }) => {
    const isAuthenticated = localStorage.getItem('token');
    return isAuthenticated ? children : <Navigate to="/login" />;
};

function App() {
  return (
    <Router>
      <div className="container mt-4">
        <Routes>
          {/* Public Route: Anyone can see this */}
          <Route path="/login" element={<Login />} />

          {/* Private Route: Only logged-in users can see this */}
          <Route path="/" element={
            <PrivateRoute>
              <Dashboard />
            </PrivateRoute>
          } />
        </Routes>
      </div>
    </Router>
  );
}

export default App;
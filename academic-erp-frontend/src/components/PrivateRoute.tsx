import React, { useState, useEffect, ReactNode } from 'react';
import { Navigate } from 'react-router-dom';
import { placementService } from '../services/api';

interface PrivateRouteProps {
    children: ReactNode;
}

const PrivateRoute: React.FC<PrivateRouteProps> = ({ children }) => {
    const [isAuthenticated, setIsAuthenticated] = useState<boolean | null>(null);

    useEffect(() => {
        checkAuth();
    }, []);

    const checkAuth = async (): Promise<void> => {
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
    return <>{children}</>;
};

export default PrivateRoute;

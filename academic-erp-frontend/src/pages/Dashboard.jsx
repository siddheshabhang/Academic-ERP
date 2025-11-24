import React, { useEffect, useState } from 'react';
import { Link } from 'react-router-dom'; // Allows us to switch pages without reloading
import { placementService } from '../services/api';

const Dashboard = () => {
    // 1. STATE: Memory to hold our data
    const [offers, setOffers] = useState([]);
    const [error, setError] = useState('');

    // 2. EFFECT: Run this ONCE when the page loads
    useEffect(() => {
        loadOffers();
    }, []);

    const loadOffers = async () => {
        try {
            // Call the Java Backend
            const response = await placementService.getAllOffers();
            // Save the data to React memory
            setOffers(response.data);
        } catch (err) {
            setError("Failed to fetch offers. Are you logged in as Outreach?");
        }
    };

    const handleLogout = () => {
        placementService.logout();
        window.location.reload(); // Reloads page -> triggers security check -> sends to login
    };

    return (
        <div>
            {/* Header Section */}
            <div className="d-flex justify-content-between align-items-center mb-4 border-bottom pb-3">
                <h2>Placement Dashboard</h2>
                <button className="btn btn-outline-danger" onClick={handleLogout}>
                    Logout
                </button>
            </div>

            {/* Error Message */}
            {error && <div className="alert alert-danger">{error}</div>}

            {/* Empty State */}
            {offers.length === 0 && !error && (
                <div className="alert alert-info">
                    No offers found in the database.
                </div>
            )}

            {/* Offers Grid */}
            <div className="row">
                {offers.map(offer => (
                    <div className="col-md-4 mb-4" key={offer.id}>
                        <div className="card h-100 shadow-sm">
                            <div className="card-header bg-primary text-white">
                                <h5 className="mb-0">{offer.profile}</h5>
                            </div>
                            <div className="card-body">
                                <h6 className="card-subtitle mb-2 text-muted">
                                    {offer.organisation ? offer.organisation.name : 'Unknown Company'}
                                </h6>
                                <p className="card-text text-truncate">
                                    {offer.description}
                                </p>
                                <ul className="list-group list-group-flush mb-3">
                                    <li className="list-group-item px-0">
                                        <strong>Intake:</strong> {offer.intake} students
                                    </li>
                                    <li className="list-group-item px-0">
                                        <strong>Min CGPA:</strong> {offer.minGrade}
                                    </li>
                                </ul>

                                <Link to={`/offer/${offer.id}`} className="btn btn-primary w-100">
                                    Manage Applications
                                </Link>
                            </div>
                        </div>
                    </div>
                ))}
            </div>
        </div>
    );
};

export default Dashboard;
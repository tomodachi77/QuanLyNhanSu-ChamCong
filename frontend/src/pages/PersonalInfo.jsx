import React, { useEffect, useState } from 'react';

function PersonalInfo() {
    const [admin, setAdmin] = useState(null);
    const [error, setError] = useState('');

    useEffect(() => {
        const fetchAdminInfo = async () => {
            const token = localStorage.getItem('token');
            try {
                const response = await fetch('http://localhost:3000/api/admin-info', {
                    method: 'GET',
                    headers: {
                        'Authorization': `Bearer ${token}`,
                        'Content-Type': 'application/json',
                    },
                });
                const data = await response.json();
                if (!data.success) {
                    setError(data.message);
                    return;
                }
                setAdmin(data.admin);
            } catch (error) {
                setError('An error occurred while fetching admin info.');
            }
        };

        fetchAdminInfo();
    }, []);

    if (error) {
        return <p className="text-red-500">{error}</p>;
    }

    if (!admin) {
        return <p>Loading...</p>;
    }

    return (
        <div className="p-6 bg-white rounded-lg shadow-md w-96 mx-auto">
            <h1 className="text-2xl font-bold mb-4">Thông tin cá nhân</h1>
            <p><strong>Họ và tên:</strong> {admin.fullname}</p>
            <p><strong>Email:</strong> {admin.email}</p>
        </div>
    );
}

export default PersonalInfo;
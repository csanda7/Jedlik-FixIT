const connection = require('../config/database');


// Fetch all locations
const getLocations = (req, res) => {
    const query = 'SELECT terem FROM termek';
    connection.query(query, (err, results) => {
        if (err) {
            console.error('Error fetching locations:', err);
            return res.status(500).json({ error: 'Database error' });
        }
        res.json(results);
    });
};

module.exports = {getLocations};
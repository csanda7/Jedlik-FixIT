// src/controllers/logController.js
const connection = require('../config/database');

// Function to fetch log entries based on a specific bug ID
const fetchLogEntries = (req, res) => {
    const { id } = req.params; // Extracting the ID from request parameters
    const query = 'SELECT ID,Status, Komment, Updated_at, modosito, assignedTo, deadLine, priority FROM Log WHERE ID = ?'; // Use your actual foreign key
    connection.query(query, [id], (error, results) => {
      if (error) {
        console.error('Error fetching log entries:', error);
        return res.status(500).json({ error: 'Database query error' });
      }
  
      res.json(results); // Send the results as JSON
    });
  };
  
  module.exports = { fetchLogEntries };

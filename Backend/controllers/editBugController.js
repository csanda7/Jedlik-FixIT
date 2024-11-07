const connection = require('../config/database'); // Import the database connection

// Controller function to update the bug details
const editBug = (req, res) => {
  const { id } = req.params;
  const { priority, assignedTo, deadline, modosito } = req.body;

  // SQL query to update the bug details
  const updateQuery = `
    UPDATE hibabejelentesek 
    SET priority = ?, assignedTo = ?, deadline = ?, updated_at = NOW(), updated_at = NOW()
    WHERE ID = ?
  `;

  connection.query(updateQuery, [priority, assignedTo, deadline, id], (error, results) => {
    if (error) {
      console.error('Error updating bug:', error);
      res.status(500).json({ message: 'Error updating bug' });
      return;
    }

    // Check if the update affected any rows (meaning the bug existed and was updated)
    if (results.affectedRows === 0) {
      res.status(404).json({ message: 'Bug not found' });
    } else {
      const logQuery = 'INSERT INTO Log (ID, modosito, updated_at, priority, assignedTo, deadline) VALUES (?, ?, NOW(), ?, ?, ?)';
      connection.query(logQuery, [id, modosito, priority, assignedTo, deadline], (logError) => {
        if (logError) {
          console.error('Error logging status update:', logError);
          res.status(500).json({ message: 'Status updated, but log entry failed' });
          return;
        }
        res.status(200).json({ message: 'Status updated and logged successfully' });});
    }
  });
};

module.exports = { editBug }; // Export the controller function

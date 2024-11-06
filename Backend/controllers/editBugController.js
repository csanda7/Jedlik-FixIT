const connection = require('../config/database'); // Import the database connection

// Controller function to update the bug details
const editBug = (req, res) => {
  const { id } = req.params;
  const { priority, assignedTo, deadline, modosito } = req.body;

  // SQL query to update the bug details
  const updateQuery = `
    UPDATE hibabejelentesek 
    SET priority = ?, assignedTo = ?, deadline = ?, updated_at = NOW()
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
      res.status(200).json({ message: 'Bug updated successfully' });
    }
  });
};

module.exports = { editBug }; // Export the controller function

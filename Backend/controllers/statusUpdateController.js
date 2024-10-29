const connection = require('../config/database'); // Import the database connection

// Controller function to update the status of a bug
const updateBugStatus = (req, res) => {
  const bugId = req.params.id;
  const newStatus = req.body.status;

  // SQL query to update the status
  const query = 'UPDATE hibabejelentesek SET Status = ? WHERE ID = ?';

  connection.query(query, [newStatus, bugId], (error, results) => {
    if (error) {
      console.error('Error updating status:', error);
      res.status(500).json({ message: 'Error updating status' });
      return;
    }

    if (results.affectedRows === 0) {
      res.status(404).json({ message: 'Bug not found' });
    } else {
      res.status(200).json({ message: 'Status updated successfully' });
    }
  });
};

module.exports = { updateBugStatus }; // Export the controller function

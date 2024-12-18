const connection = require('../config/database'); // Import the database connection

// Controller function to update the status of a bug
const updateStatusandAssigndTo = (req, res) => {
  const bugId = req.params.id;
  const newStatus = req.body.status;
  const komment = req.body.komment;
  const modosito = req.body.modosito;


  // SQL query to update the status
  const updateQuery = 'UPDATE hibabejelentesek SET Status = ?, AssignedTo = "", updated_at = NOW() WHERE ID = ?';

  connection.query(updateQuery, [newStatus, bugId], (error, results) => {
    if (error) {
      console.error('Error updating status:', error);
      res.status(500).json({ message: 'Error updating status' });
      return;
    }

    if (results.affectedRows === 0) {
      res.status(404).json({ message: 'Bug not found' });
    } else {
      // Insert a new log entry with the updated status and komment
      const logQuery = 'INSERT INTO Log (ID, Status, Komment, modosito, updated_at) VALUES (?, ?, ?, ?, NOW())';
      connection.query(logQuery, [bugId, newStatus, komment, modosito], (logError) => {
        if (logError) {
          console.error('Error logging status update:', logError);
          res.status(500).json({ message: 'Status updated, but log entry failed' });
          return;
        }
        res.status(200).json({ message: 'Status updated and logged successfully' });
      });
    }
  });
};

module.exports = { updateStatusandAssigndTo }; // Export the controller function

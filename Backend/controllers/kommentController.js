const connection = require('../config/database'); // Import the database connection

// Controller function to update the status of a bug
const addComment = (req, res) => {
  const bugId = req.params.id;
  const komment = req.body.komment;
  const modosito = req.body.modosito;


  // SQL query to update the status
  const updateQuery = 'UPDATE hibabejelentesek SET Updated_at = NOW() WHERE ID = ?';

  connection.query(updateQuery, [bugId], (error, results) => {
    if (error) {
      console.error('Error updating status:', error);
      res.status(500).json({ message: 'Error updating status' });
      return;
    }

    if (results.affectedRows === 0) {
      res.status(404).json({ message: 'Bug not found' });
    } else {
      // Insert a new log entry with the updated status and komment
      const logQuery = 'INSERT INTO Log (ID, LStatus, Komment, modosito) VALUES (?, ?, ?, ?)';
      connection.query(logQuery, [bugId, '', komment, modosito], (logError) => {
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

module.exports = { addComment }; // Export the controller function

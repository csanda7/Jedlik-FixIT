const connection = require('../config/database'); // Import the database connection

// Controller function to update the bug details
const editBug = (req, res) => {
  const { id } = req.params;
  const { priority, assignedTo, deadline, modosito } = req.body;

  // First, get the original values of the bug
  const selectQuery = `SELECT priority, assignedTo, deadline FROM hibabejelentesek WHERE ID = ?`;

  connection.query(selectQuery, [id], (selectError, originalResults) => {
    if (selectError) {
      console.error('Error retrieving original bug details:', selectError);
      res.status(500).json({ message: 'Error retrieving bug details' });
      return;
    }

    if (originalResults.length === 0) {
      res.status(404).json({ message: 'Bug not found' });
      return;
    }

    const originalBug = originalResults[0];

    // Ensure we safely check and compare the values
    const updatedPriority =
      priority !== undefined && priority !== originalBug.priority ? priority : null;
    const updatedAssignedTo =
      assignedTo !== undefined && assignedTo !== originalBug.assignedTo ? assignedTo : null;
    const updatedDeadline =
      deadline !== undefined &&
      new Date(deadline).toISOString() !== new Date(originalBug.deadline).toISOString()
        ? deadline
        : null;

    // Debugging the output to see the values

    // If no main fields (priority, assignedTo, deadline) have changed, skip logging
    if (updatedPriority === null && updatedAssignedTo === null && updatedDeadline === null) {
      res.status(200).json({ message: 'No significant changes made' });
      return;
    }

    // Update the bug details in the database
    const updateQuery = `
      UPDATE hibabejelentesek 
      SET priority = COALESCE(?, priority), assignedTo = COALESCE(?, assignedTo), deadline = COALESCE(?, deadline), updated_at = NOW()
      WHERE ID = ?
    `;

    connection.query(updateQuery, [priority, assignedTo, deadline, id], (updateError, results) => {
      if (updateError) {
        console.error('Error updating bug:', updateError);
        res.status(500).json({ message: 'Error updating bug' });
        return;
      }

      if (results.affectedRows === 0) {
        res.status(404).json({ message: 'Bug not found' });
      } else {
        // Insert log entry only if any of the main fields have changed
        const logQuery = `
          INSERT INTO Log (ID, modosito, updated_at, priority, assignedTo, deadline) 
          VALUES (?, ?, NOW(), ?, ?, ?)
        `;
        connection.query(
          logQuery,
          [id, modosito, updatedPriority, updatedAssignedTo, updatedDeadline],
          (logError) => {
            if (logError) {
              console.error('Error logging status update:', logError);
              res.status(500).json({ message: 'Status updated, but log entry failed' });
              return;
            }
            res.status(200).json({ message: 'Status updated and logged successfully' });
          }
        );
      }
    });
  });
};

module.exports = { editBug }; // Export the controller function

const bugModel = require('../models/bugModel');

// Get all bugs
const fetchBugs = (req, res) => {
  bugModel.getAllBugs((error, results) => {
    if (error) {
      console.error('Error fetching bugs:', error);
      return res.status(500).json({ message: 'Database error' });
    }
    res.json(results);
  });
};

// Update assignedTo
const updateAssignedTo = (req, res) => {
  const { id } = req.params;
  const { assignedTo, komment, modosito } = req.body;

  if (!id || !assignedTo) {
    return res.status(400).json({ message: 'Missing ID or assignedTo field' });
  }

  // Pass assignedTo, komment, and modosito to the model function
  bugModel.updateAssignedTo(id, assignedTo, komment, modosito, (error, results) => {
    if (error) {
      console.error('Error updating assignedTo:', error);
      return res.status(500).json({ message: 'Database update error' });
    }

    res.status(200).json({ message: 'Task successfully assigned', id, assignedTo });
  });
};

module.exports = {
  fetchBugs,
  updateAssignedTo
};

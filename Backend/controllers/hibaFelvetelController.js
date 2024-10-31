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
  const { assignedTo } = req.body;

  if (!id || !assignedTo) {
    return res.status(400).json({ message: 'Missing ID or assignedTo field' });
  }

  bugModel.updateAssignedTo(id, assignedTo, (error, results) => {
    if (error) {
      console.error('Error updating assignedTo:', error);
      return res.status(500).json({ message: 'Database update error' });
    }
  //   res.status(200).json({ message: 'Task successfully assigned', id, assignedTo });
  // });
  // if (!id || !assignedTo) {
  //   return res.status(400).json({ message: 'Missing ID or assignedTo field' });
  // }

  // bugModel.updateAssignedTo(id, assignedTo, (error, results) => {
  //   if (error) {
  //     console.error('Error updating assignedTo:', error);
  //     return res.status(500).json({ message: 'Database update error' });
  //   }

  //   // E-mail küldés a rendszergazdának
  //   const bugName = results.title; // Ha elérhető a bug neve az eredményekből
  //   notifyAdmin(assignedTo, bugName);

    res.status(200).json({ message: 'Task successfully assigned', id, assignedTo });
  });
};

module.exports = {
  fetchBugs,
  updateAssignedTo
};

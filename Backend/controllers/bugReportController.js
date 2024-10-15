const express = require('express');
const router = express.Router();
const upload = require('../middleware/upload'); // Import the upload middleware
const bugReport = require('../config/database'); // Import the database connection

// API to handle bug report submissions
router.post('/', upload.single('photo'), (req, res) => {
  const { bugName, priority, bugDescription, location, label, reported_by } = req.body;
  const file = req.file; // Access the file object here

  // Use the filename of the uploaded file
  const photo = file ? file.filename : null;

  // Validate input fields
  if (!bugName || !priority || !bugDescription || !location || !label || !reported_by) {
    return res.status(400).json({
      msg: 'Validation Failed',
      errors: {
        bugName: !bugName ? ['Bug name is required'] : [],
        priority: !priority ? ['Priority is required'] : [],
        bugDescription: !bugDescription ? ['Bug description is required'] : [],
        location: !location ? ['Location is required'] : [],
        label: !label ? ['Label is required'] : []
      }
    });
  }

  // Prepare SQL query
  const sql = `
    INSERT INTO hibabejelentesek (Title, Description, Photo, Reported_by, Location, Reported_at, Updated_at, Priority, Status, Label)
    VALUES (?, ?, ?, ?, ?, NOW(), NOW(), ?, 'Bejelentve', ?)
  `;

  // Insert data into the database
  bugReport.query(sql, [bugName, bugDescription, photo, reported_by, location, priority, label], (err, result) => {
    if (err) {
      console.error('Error inserting bug report:', err);
      return res.status(500).json({ msg: 'Something Went Wrong', error: err.message });
    }
    res.json({ msg: 'Successfully Saved' });
  });
});

module.exports = router; // Export the router

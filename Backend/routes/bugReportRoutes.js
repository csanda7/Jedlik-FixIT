const express = require('express');
const router = express.Router();
const { submitBugReport } = require('../controllers/bugReportController'); // Adjust the path as necessary
const multer = require('multer');

// Set up Multer for file uploads
const storage = multer.diskStorage({
  destination: function (req, file, cb) {
    cb(null, 'uploads/'); // Make sure this folder exists
  },
  filename: function (req, file, cb) {
    cb(null, Date.now() + '-' + file.originalname); // Unique file name
  }
});

// Initialize the upload middleware
const upload = multer({ storage: storage });

// Define the route for bug report submission
router.post('/api/bugReport', upload.single('photo'), submitBugReport);

module.exports = router; // Export the router

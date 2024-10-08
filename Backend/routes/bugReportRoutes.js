const express = require('express');
const router = express.Router();
const multer = require('multer');
const path = require('path');
const bugReportController = require('../controllers/bugReportController');
const authenticateUser = require('../middleware/authenticateUser');

// Setup multer for file uploads
const storage = multer.diskStorage({
  destination: function (req, file, cb) {
    cb(null, 'uploads/');
  },
  filename: function (req, file, cb) {
    cb(null, Date.now() + path.extname(file.originalname));
  }
});

const upload = multer({ storage: storage });

// Route to handle bug report submissions
router.post('/api/bugReport', authenticateUser, upload.single('photo'), bugReportController.submitBugReport);

module.exports = router;

const multer = require('multer');
const upload = multer({ dest: 'uploads/' }); // Adjust destination as needed
const bugReportController = require('../controllers/bugReportController');
const express = require('express');

const router = express.Router();
// Route definition with file upload
router.post('/api/bugReport', upload.array('photos', 4), bugReportController.createBugReport);

module.exports = router;
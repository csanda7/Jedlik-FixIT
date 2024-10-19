const express = require('express');
const router = express.Router();
const bugController = require('../controllers/hibaFelvetelController');

// Route to get all bugs
router.get('/hibakKiir', bugController.fetchBugs);

// Route to update assignedTo
router.put('/updateAssignedTo/:id', bugController.updateAssignedTo);

module.exports = router;

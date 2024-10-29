const express = require('express');
const router = express.Router();
const bugController = require('../controllers/hibaFelvetelController');
const statusUpdateController = require('../controllers/statusUpdateController');

// Route to get all bugs
router.get('/hibakKiir', bugController.fetchBugs);

// Route to update assignedTo
router.put('/updateAssignedTo/:id', bugController.updateAssignedTo);

router.put('/updateStatus/:id', statusUpdateController.updateBugStatus);



module.exports = router;

const express = require('express');
const router = express.Router();
const bugController = require('../controllers/hibaFelvetelController');
const statusUpdateController = require('../controllers/statusUpdateController');
const kommentController = require('../controllers/kommentController');
const ujrakiosztController = require('../controllers/ujrakiosztController');

// Route to get all bugs
router.get('/hibakKiir', bugController.fetchBugs);

// Route to update assignedTo
router.put('/updateAssignedTo/:id', bugController.updateAssignedTo);

router.put('/updateStatus/:id', statusUpdateController.updateBugStatus);

router.put('/addComment/:id', kommentController.addComment);

router.put('/updateStatusandAssigndTo/:id', ujrakiosztController.updateStatusandAssigndTo)



module.exports = router;

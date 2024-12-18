const express = require('express');
const router = express.Router();
const bugController = require('../controllers/assignTaskController');
const statusUpdateController = require('../controllers/statusUpdateController');
const kommentController = require('../controllers/commentController');
const ujrakiosztController = require('../controllers/reAssignTaskController');
const editBugController = require('../controllers/editBugController');

// Route to get all bugs
router.get('/hibakKiir', bugController.fetchBugs);

// Route to update assignedTo
router.put('/updateAssignedTo/:id', bugController.updateAssignedTo);

router.put('/updateStatus/:id', statusUpdateController.updateBugStatus);

router.put('/addComment/:id', kommentController.addComment);

router.put('/updateStatusandAssigndTo/:id', ujrakiosztController.updateStatusandAssigndTo)

router.put('/editBug/:id', editBugController.editBug)



module.exports = router;

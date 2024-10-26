const express = require('express');
const router = express.Router();
const { authenticateUser } = require('../controllers/authController');

// Authentication route
router.post('/', authenticateUser);

module.exports = router;


module.exports = router;

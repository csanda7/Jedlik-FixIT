const express = require('express');
const router = express.Router();
const { authenticateUser, checkSession, logoutUser } = require('../controllers/authController');

// Authentication route
router.post('/', authenticateUser);

// Session check route
router.get('/session', checkSession);

// Logout route
router.post('/logout', logoutUser);

module.exports = router;

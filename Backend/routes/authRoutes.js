// /routes/authRoutes.js
const express = require('express');
const authController = require('../controllers/loginController');

const router = express.Router();

// Login route
router.post('/login', authController.login);

module.exports = router;

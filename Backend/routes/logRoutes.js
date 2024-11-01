// src/routes/logRoutes.js
const express = require('express');
const { fetchLogEntries } = require('../controllers/logController');

const router = express.Router();

// Define the route for fetching log entries
router.get('/:id', fetchLogEntries);

module.exports = router;

const express = require('express');
const router = express.Router();
const { getLocations } = require('../controllers/locationController');

// Route to fetch all hibabejelentesek entries
router.get('/', getLocations);

module.exports = router;

const express = require('express');
const router = express.Router();
const { getHibakKiir } = require('../controllers/hibakKiirController');

// Route to fetch all hibabejelentesek entries
router.get('/', getHibakKiir);

module.exports = router;

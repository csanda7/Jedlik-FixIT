// routes/userRoutes.js
const express = require('express');
const router = express.Router();
const usersWithRolesController = require('../controllers/usersWithRolesController');

// Route to get users with specific roles
router.get('/', usersWithRolesController.getUsersWithRoles);


module.exports = router;

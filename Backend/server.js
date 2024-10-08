const mysql = require('mysql2');
const express = require('express');
const path = require('path');
const bodyParser = require('body-parser');
const cors = require('cors');


const encoder = bodyParser.urlencoded({ extended: true });
const authRoutes = require('./routes/authRoutes');
const bugReportRoutes = require('./routes/bugReportRoutes');
const authenticateUser = require('./middleware/authenticateUser');

const app = express();

const corsOptions = {
  origin: 'http://localhost:5173', // Change this to the correct URL of your Vue.js app
  methods: 'GET,HEAD,PUT,PATCH,POST,DELETE',
  credentials: true,
};

app.use(cors(corsOptions));

// Serve static files from the frontend (if necessary)
const frontendPath = path.join(__dirname, '..', '..', 'frontend');
app.use(express.static(frontendPath));

// Middleware
app.use(bodyParser.urlencoded({ extended: true }));
app.use(express.json()); // For parsing application/json
app.use(express.urlencoded({ extended: true })); // For parsing application/x-www-form-urlencoded

// Routes
app.use(authRoutes);
app.use('/api', bugReportRoutes);
app.use(authenticateUser)


// Start the server
const PORT = 4500;
app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});

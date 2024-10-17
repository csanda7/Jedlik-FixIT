
const express = require('express');
const path = require('path');
const bodyParser = require('body-parser');
const cors = require('cors');
const app = express();

const encoder = bodyParser.urlencoded({ extended: true });
const authRoutes = require('./routes/authRoutes');
const bugReportController = require('./controllers/bugReportController'); // Import bug report routes
const hibakKiirRoutes = require('./routes/hibakKiirRoutes');




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
app.use('/api', bugReportController); // Make sure the route prefix is correct

// Routes
app.use(authRoutes);
app.use('/api/bugReport', bugReportController);
app.use('/api/hibakKiir', hibakKiirRoutes);


// Start the server
const PORT = 4500;
app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});

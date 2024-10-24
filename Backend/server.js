const express = require('express');
const path = require('path');
const bodyParser = require('body-parser');
const cors = require('cors');

const app = express();
const authRoutes = require('./routes/authRoutes'); // Adjusted to match your routes
const bugReportController = require('./controllers/bugReportController'); // Import bug report routes
const hibakKiirRoutes = require('./routes/hibaKiirRoutes');
const hibaFelvetelRoutes = require('./routes/hibaFelvetelRoutes'); // Import bug routes

const corsOptions = {
  origin: 'http://localhost:5173', // Change this to the correct URL of your Vue.js app
  methods: 'GET,HEAD,PUT,PATCH,POST,DELETE',
  credentials: true,
};

app.use(cors(corsOptions));
app.use(bodyParser.urlencoded({ extended: true }));
app.use(express.json()); // For parsing application/json
app.use(express.urlencoded({ extended: true })); // For parsing application/x-www-form-urlencoded

// Serve static files from the frontend (if necessary)
const frontendPath = path.join(__dirname, '..', '..', 'frontend');
app.use(express.static(frontendPath));

// Routes
app.use('/api/login', authRoutes); // Ensure the route prefix is correct
app.use('/api/bugReport', bugReportController);
app.use('/api/hibakKiir', hibakKiirRoutes);
app.use('/api', hibaFelvetelRoutes);
app.use('/uploads', express.static(path.join(__dirname, '../uploads'))); // Adjust to your actual path

// Start the server
const PORT = 4500;
app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});

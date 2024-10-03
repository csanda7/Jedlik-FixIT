const mysql = require('mysql2');
const express = require('express');
const path = require('path');
const bodyParser = require("body-parser");
const cors = require('cors');  // Add CORS support

const encoder = bodyParser.urlencoded({ extended: true });
const app = express();

// Enable CORS for your Vue app
app.use(cors());

// Serve static files from the frontend (if necessary)
const frontendPath = path.join(__dirname, '..','..', 'frontend');

const connection = mysql.createConnection({
  host: 'localhost',       
  user: 'root',            
  password: '',   
  database: 'jedlikfixit_teszt'
});

// Connect to the database
connection.connect(function(error) {
  if (error) {
    throw error
  }
  else {
    console.log('Database connected');
  }
});

// Middleware
app.use(cors());
app.use(express.json()); // For parsing application/json
app.use(express.urlencoded({ extended: true })); // For parsing application/x-www-form-urlencoded

// POST request endpoint
app.post('/api/data', (req, res) => {
    const data = req.body; // Get the data from the request body
    console.log(data); // Log the received data to the console
    res.json({ message: 'Data received successfully!', receivedData: data }); // Send a response back
});

// Handle login POST requests
app.post("/", encoder, function(req, res) {
  const { username, password } = req.body;

  connection.query("SELECT * FROM felhasznalok WHERE Login_name = ? AND Password = ?", [username, password], function(error, results) {
    if (error) {
      return res.status(500).json({ success: false, message: "Database error" });
    }
    
    if (results.length > 0) {
      // Credentials are correct, send a success response
      res.json({ success: true });
    } else {
      // Invalid credentials
      res.json({ success: false });
    }
  });
});


app.listen(4500, () => {
  console.log("Server is running on port 4500");
});

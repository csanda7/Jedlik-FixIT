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
const frontendPath = path.join(__dirname, '..','..', 'frontend','public');

const connection = mysql.createConnection({
  host: 'localhost',       
  user: 'root',            
  password: '',   
  database: 'test'
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

// Serve the login page (if you have frontend files here)
app.get("/", function(req, res) {
  res.sendFile(path.join(frontendPath, 'test.html'));
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

// Serve another page after login (optional)
app.get("/test2", function(req, res) {
  res.sendFile(path.join(frontendPath, 'test2.html'));
});

app.listen(4500, () => {
  console.log("Server is running on port 4500");
});

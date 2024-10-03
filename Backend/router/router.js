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
const frontendPath = path.join(__dirname, '..', '..', 'frontend');

const connection = mysql.createConnection({
  host: 'localhost',
  user: 'root',
  password: '',
  database: 'jedlikfixit_teszt'
});

// Connect to the database
connection.connect(function(error) {
  if (error) {
    throw error;
  } else {
    console.log('Database connected');
  }
});

// Middleware
app.use(express.json()); // For parsing application/json
app.use(express.urlencoded({ extended: true })); // For parsing application/x-www-form-urlencoded

// Handle login POST requests
app.post("/", encoder, function(req, res) {
  const { username, password } = req.body;

  // Modify the SQL query to fetch the role along with the user
  connection.query(
    "SELECT Role FROM felhasznalok WHERE Login_name = ? AND Password = ?", 
    [username, password], 
    function(error, results) {
      if (error) {
        return res.status(500).json({ success: false, message: "Database error" });
      }

      if (results.length > 0) {
        // Credentials are correct, send a success response with the role
        const userRole = results[0].Role; // Get the role from the result
        res.json({ success: true, isAdmin: userRole === 'a' }); // Assuming 'a' indicates admin
      } else {
        // Invalid credentials
        res.json({ success: false });
      }
    }
  );
});

app.listen(4500, () => {
  console.log("Server is running on port 4500");
});

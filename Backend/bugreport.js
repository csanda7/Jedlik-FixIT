const express = require('express');
const multer = require('multer');
const mysql = require('mysql2');
const path = require('path');

const app = express();

// Setup multer for file uploads
const storage = multer.diskStorage({
  destination: (req, file, cb) => {
    cb(null, 'uploads/'); // Adjust the path as needed
  },
  filename: (req, file, cb) => {
    cb(null, file.originalname); // Keep the original name
  }
});

const upload = multer({ storage });

// Setup MySQL connection
const db = mysql.createConnection({
  host: 'localhost',
  user: 'root',
  password: '',
  database: 'jedlikfixit_teszt',
  charset: 'utf8mb4_hungarian_ci' // Ensure charset supports utf8mb4
});

// Connect to MySQL
db.connect(err => {
  if (err) {
    console.error('Database connection failed:', err);
    return;
  }
  console.log('Connected to the database.');
});

// API to handle bug report submissions
app.post('/api/bugReport', upload.single('photo'), (req, res) => {
  const { bugName, priority, bugDescription, location, label, reported_by } = req.body;
  const file = req.file; // Access the file object here

  // Use the filename of the uploaded file
  const photo = file ? file.filename : null;

  // Validate input fields
  if (!bugName || !priority || !bugDescription || !location || !label || !reported_by) {
    return res.status(400).json({
      msg: 'Validation Failed',
      errors: {
        bugName: !bugName ? ['Bug name is required'] : [],
        priority: !priority ? ['Priority is required'] : [],
        bugDescription: !bugDescription ? ['Bug description is required'] : [],
        location: !location ? ['Location is required'] : [],
        label: !label ? ['Label is required'] : []
      }
    });
  }

  // Prepare SQL query
  const sql = `
    INSERT INTO hibabejelentesek (Title, Description, Photo, Reported_by, Location, Reported_at, Updated_at, Priority, Status, Label)
    VALUES (?, ?, ?, ?, ?, NOW(), NOW(), ?, 'fasz', ?)
  `;

  // Insert data into the database
  db.query(sql, [bugName, bugDescription, photo, reported_by, location, priority, label], (err, result) => {
    if (err) {
      console.error('Error inserting bug report:', err);
      return res.status(500).json({ msg: 'Something Went Wrong', error: err.message });
    }
    res.json({ msg: 'Successfully Saved' });
  });
});

// Start the server
const PORT = 3000; // Adjust your port as needed
app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});

const express = require('express');
const router = express.Router();
const upload = require('../middlewares/multer'); // Import the multer configuration
const connection = require('../config/database');

router.post('/bugReport', upload, (req, res) => {

  const { bugName, bugDescription, reported_by, location, priority, label, assignedTo, hiba_idopont } = req.body;
  const photos = req.files; // Use req.files to access uploaded files

  // SQL to insert the bug report
  const sql = 'INSERT INTO hibabejelentesek (Title, Description, Location, Priority, Reported_By, Reported_At, Updated_At, Status, label, assignedTo) VALUES (?, ?, ?, ?, ?, NOW(), NOW(), "Bejelentve", ?, ?)';

  connection.query(sql, [bugName, bugDescription, location, priority, reported_by, label, assignedTo, hiba_idopont], (err, result) => {
      if (err) {
          console.error('Error inserting bug report:', err);
          return res.status(500).json({ msg: 'Something Went Wrong', error: err.message });
      }

      // Insert a new record into the Log table for this bug report
      const logQuery = 'INSERT INTO Log (ID, Status, Komment) VALUES (?, ?, ?)';
      connection.query(logQuery, [result.insertId, 'Bejelentve', ''], (logErr) => {
          if (logErr) {
              console.error('Error inserting into Log:', logErr);
              return res.status(500).json({ msg: 'Error saving log entry', error: logErr.message });
          }

          // Handle photo uploads
          if (photos && photos.length > 0) {
              const photoInsertPromises = [];

              for (let i = 0; i < photos.length; i++) {
                  const photo = photos[i];
                  const kepId = i + 1; // Start from 1 for kep_id

                  const insertPhotoQuery = `INSERT INTO kepek (ID, kep, kep_id) VALUES (?, ?, ?)`;
                  photoInsertPromises.push(
                      new Promise((resolve, reject) => {
                          connection.query(insertPhotoQuery, [result.insertId, photo.filename, kepId], (err) => {
                              if (err) {
                                  console.error('Error inserting into kepek:', err);
                                  reject(err);
                              } else {
                                  resolve();
                              }
                          });
                      })
                  );
              }

              // Wait for all photo insertions to complete
              Promise.all(photoInsertPromises)
                  .then(() => {
                      res.json({ msg: 'Successfully Saved with photos and log entry' });
                  })
                  .catch((error) => {
                      res.status(500).json({ msg: 'Error saving photos', error });
                  });
          } else {
              res.json({ msg: 'Successfully Saved without photos but with log entry' });
          }
      });
  });
});

module.exports = router;

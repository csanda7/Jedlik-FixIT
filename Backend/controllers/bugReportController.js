const express = require('express');
const router = express.Router();
const upload = require('./../middleware/multer'); // Import the multer configuration
const connection = require('../config/database');

router.post('/bugReport', upload, (req, res) => {

    const { bugName, bugDescription, reported_by, location, priority, label} = req.body;

    const photos = req.files; // Use req.files to access uploaded files

    const sql = 'INSERT INTO hibabejelentesek (Title, Description, Location, Priority, Reported_By, Reported_At, Updated_At, Status, label) VALUES (?, ?, ?,?, ?, NOW(), NOW(), "Bejelentve",?)';
    
    connection.query(sql, [bugName, bugDescription, location, priority, reported_by, label], (err, result) => {
        if (err) {
            console.error('Error inserting bug report:', err);
            return res.status(500).json({ msg: 'Something Went Wrong', error: err.message });
        }

        // Handle photo uploads
        if (photos && photos.length > 0) {
            const insertPhotoSql = 'INSERT INTO kepek (ID, kep) VALUES (?, ?)';
            const photoInsertPromises = [];

            for (let i = 0; i < photos.length; i++) {
                photoInsertPromises.push(
                    new Promise((resolve, reject) => {
                        connection.query(insertPhotoSql, [result.insertId, photos[i].filename], (err) => {
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

            Promise.all(photoInsertPromises)
                .then(() => {
                    res.json({ msg: 'Successfully Saved' });
                })
                .catch((error) => {
                    res.status(500).json({ msg: 'Error saving photos', error });
                });
        } else {
            res.json({ msg: 'Successfully Saved without photos' });
        }
    });
});

module.exports = router;

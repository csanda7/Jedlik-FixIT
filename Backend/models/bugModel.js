const connection = require('../config/database');

// Function to get all bugs
const getAllBugs = (callback) => {
  const query = 'SELECT ID, `Hiba neve`, `Prioritás`, `Címke`, `Státusz`, `Terem`, `Bejelentette`, `Bejelentés ideje`, `Hiba leírása`, `assignedTo` FROM hibabejelentesek';
  connection.query(query, callback);
};

// Function to update assignedTo and add a log entry
const updateAssignedTo = (id, assignedTo, komment, modosito, callback) => {
  const updateQuery = 'UPDATE hibabejelentesek SET assignedTo = ?, Updated_at = NOW(), Status = "Folyamatban" WHERE ID = ?';
  
  connection.query(updateQuery, [assignedTo, id], (error, results) => {
    if (error) return callback(error);

    // If update is successful, insert a new log entry
    const logQuery = 'INSERT INTO Log (ID, Status, Komment, modosito) VALUES (?, ?, ?, ?)';
    connection.query(logQuery, [id, 'Folyamatban', komment, modosito], (logError, logResults) => {
      if (logError) return callback(logError);
      
      callback(null, { results, logResults });
    });
  });
};

module.exports = {
  getAllBugs,
  updateAssignedTo
};

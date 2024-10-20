const connection = require('../config/database');

// Function to get all bugs
const getAllBugs = (callback) => {
  const query = 'SELECT ID, `Hiba neve`, `Prioritás`, `Címke`, `Státusz`, `Terem`, `Bejelentette`, `Bejelentés ideje`, `Hiba leírása`, `assignedTo` FROM hibabejelentesek';
  connection.query(query, callback);
};

// Function to update assignedTo
const updateAssignedTo = (id, assignedTo, callback) => {
  const updateQuery = 'UPDATE hibabejelentesek SET assignedTo = ?, Updated_at = NOW(), Status = "Folyamatban"  WHERE ID = ?';
  connection.query(updateQuery, [assignedTo, id], callback);
};

module.exports = {
  getAllBugs,
  updateAssignedTo
};

const connection = require('../config/database');

// Controller to get all bug reports along with associated pictures
const getHibakKiir = (req, res) => {
  const query = `
    SELECT 
      h.ID, 
      h.Title AS 'Hiba neve', 
      h.Priority AS 'Prioritás', 
      h.Label AS 'Címke', 
      h.Status AS 'Státusz', 
      h.Location AS 'Terem', 
      h.Reported_By AS 'Bejelentette', 
      h.Reported_At AS 'Bejelentés ideje',
      h.Description AS 'Hiba leírása', 
      h.assignedTo,
      h.deadLine AS 'Határidő',
      GROUP_CONCAT(k.kep) AS photos
    FROM 
      hibabejelentesek h
    LEFT JOIN 
      kepek k ON h.ID = k.ID
    GROUP BY 
      h.ID
  `;
  
  connection.query(query, (err, results) => {
    if (err) {
      console.error('Error fetching data from the database:', err);
      res.status(500).send('Server error');
      return;
    }
    // Send the results as JSON response
    res.json(results);
  });
};

module.exports = { getHibakKiir };

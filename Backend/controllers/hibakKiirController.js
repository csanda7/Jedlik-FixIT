const connection = require('../config/database');



// Controller to get all bug reports
const getHibakKiir = (req, res) => {
  const query = `
    SELECT ID, Title AS 'Hiba neve', Priority AS 'Prioritás', Label AS 'Címke', Status AS 'Státusz', Location AS 'Terem', 
           Reported_By AS 'Bejelentette', Reported_At AS 'Bejelentés ideje', Description AS 'Hiba leírása', assignedTo
    FROM hibabejelentesek
  `;
  
  connection.query(query, (err, results) => {
    if (err) {
      console.error('Error fetching data from the database:', err);
      res.status(500).send('Server error');
      return;
    }
    res.json(results);
  });
};

module.exports = { getHibakKiir };

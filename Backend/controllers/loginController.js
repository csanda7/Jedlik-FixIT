// /controllers/authController.js
const connection = require('../config/database');

exports.login = (req, res) => {
  const { username, password } = req.body;

  connection.query(
    "SELECT Role FROM felhasznalok WHERE Login_name = ? AND Password = ?", 
    [username, password], 
    function (error, results) {
      if (error) {
        return res.status(500).json({ success: false, message: "Database error" });
      }

      if (results.length > 0) {
        const userRole = results[0].Role; // Get the role from the result
        res.json({ success: true, isAdmin: userRole === 'a' }); // Assuming 'a' indicates admin
      } else {
        res.json({ success: false });
      }
    }
  );
};

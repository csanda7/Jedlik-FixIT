const bugReport = require('../config/database');

exports.login = (req, res) => {
    const { username} = req.body;
  
    connection.query(
      "SELECT Name FROM felhasznalok WHERE Login_name = ?", 
      [username], 
      function (error, results) {
        if (error) {
          return res.status(500).json({ success: false, message: "Database error" });
        }
  
        if (results.length > 0) {
          const Name = results[0].Name;
          res.json({ 
            success: true, 
            Name
          });
        } else {
          res.json({ success: false });
        }
      }
    );
  };

// Controller function to handle bug report submissions
exports.submitBugReport = (req, res) => {
  const { bugName, priority, bugDescription, location, label } = req.body;
  const photo = req.file ? req.file.filename : null;

  // Simulated user ID from the authenticated session (replace with your actual auth system)
  const reportedBy = req.user.id;  // Assuming you are using some authentication system to get the signed-in user's ID

  // Basic server-side validation
  if (!bugName || !bugDescription || !location || !label) {
    return res.status(400).json({
      msg: 'Validation Failed',
      errors: {
        bugName: !bugName ? ['Bug name is required'] : [],
        bugDescription: !bugDescription ? ['Bug description is required'] : [],
        location: !location ? ['Location is required'] : [],
        label: !label ? ['Label is required'] : [],
      }
    });
  }

  // Insert data into the database, including reported_by, reported_at, updated_at, and status
  const sql = `INSERT INTO hibabejelentesek (Title, Description, Location, Priority, Photo, ReportedBy, ReportedAt, UpdatedAt, Status) 
               VALUES (?, ?, ?, ?, ?, ?, NOW(), NOW(), ?)`;

  bugReport.query(sql, [bugName, bugDescription, location, priority, photo, reportedBy, 'Kiosztva'], (err, result) => {
    if (err) {
      console.error('Error inserting into database:', err);
      return res.status(500).json({ msg: 'Something Went Wrong' });
    }
    res.json({ msg: 'Successfully Saved', data: result });
  });
};

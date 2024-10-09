exports.submitBugReport = (req, res) => {
  const { bugName, priority, bugDescription, location, label } = req.body;
  const reported_by = req.body.reported_by; // Ensure you retrieve reported_by from req.body
  const photo = req.file ? req.file.filename : null;

  console.log("Reported By:", reported_by); // Log to check if reported_by is received

  if (!reported_by) {
      console.error('Missing reported_by field');
      return res.status(400).json({ success: false, message: "Missing reported_by field" });
  }

  bugReport.query(
      "SELECT id FROM felhasznalok WHERE Login_name = ?", 
      [reported_by], 
      (err, results) => {
          if (err) {
              console.error('Database error while selecting user:', err);
              return res.status(500).json({ success: false, message: "Database error" });
          }

          if (results.length > 0) {
              const userId = results[0].id;

              const sql = `INSERT INTO hibabejelentesek 
                           (Title, Priority, Description, Location, Tag, Photo, Reported_by, Reported_at, Updated_at, Status) 
                           VALUES (?, ?, ?, ?, ?, ?, ?, NOW(), NOW(), 'Kiosztva')`;
              bugReport.query( // Ensure you use the correct variable here
                  sql, 
                  [bugName, priority, bugDescription, location, label, photo, userId], 
                  (err, results) => {
                      if (err) {
                          console.error('Insert error:', err);
                          return res.status(500).json({ success: false, message: "Failed to insert report" });
                      }
                      res.json({ success: true });
                  }
              );
          } else {
              console.error('User not found for reported_by:', reported_by);
              res.status(400).json({ success: false, message: "User not found" });
          }
      }
  );
};

// /config/database.js

const mysql = require('mysql2');
const cron = require('node-cron');

const connection = mysql.createConnection({
  host: 'localhost',
  user: 'root',
  password: '',
  database: 'jedlikfixit_teszt',
  charset: 'utf8mb4_hungarian_ci' // Ensure charset supports utf8mb4
});

connection.connect(function (error) {
  if (error) {
    console.error('Error connecting to the database:', error);
    throw error;
  } else {
    console.log('Database connected');
  }
});

cron.schedule('0 0 * * *', () => { // Runs at midnight every day
  connection.query(
      "DELETE FROM hibabejelentesek WHERE updated_at < NOW() - INTERVAL 3 YEAR",
      (error, results) => {
          if (error) {
              console.error('Error running cleanup query:', error);
              return;
          }
          console.log('Old records deleted:', results.affectedRows);
      }
  );
});

module.exports = connection;

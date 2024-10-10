// /config/database.js

const mysql = require('mysql2');

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

const bugReport = mysql.createConnection({
  host: 'localhost',
  user: 'root',
  password: '',
  database: 'jedlikfixit_teszt',
  charset: 'utf8mb4_hungarian_ci' // Ensure charset supports utf8mb4
});

bugReport.connect(function (error) {
  if (error) {
    console.error('Error connecting to the database:', error);
    throw error;
  } else {
    console.log('Database connected');
  }
});

module.exports = connection;
module.exports = bugReport;


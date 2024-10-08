// /config/database.js

const mysql = require('mysql2');

const connection = mysql.createConnection({
  host: 'localhost',
  user: 'root',
  password: '',
  database: 'jedlikfixit_teszt'
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
  database: 'jedlikfixit_teszt'
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

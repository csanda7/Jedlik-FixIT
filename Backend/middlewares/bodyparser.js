// middlewares/bodyParser.js
const bodyParser = require('body-parser');

const jsonParser = bodyParser.json(); // Middleware for JSON body parsing

module.exports = {
  jsonParser
};

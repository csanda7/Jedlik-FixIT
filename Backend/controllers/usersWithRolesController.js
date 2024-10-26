// userController.js
const demoUsers = require('../Users/demoUsers'); // Import demoUsers

exports.getUsersWithRoles = (req, res) => {
  // Filter users based on role and map to return only usernames
  const usernames = demoUsers
    .filter(user => user.role === 'rendszergazda' || user.role === 'muszakivezeto')
    .map(user => user.username);

  res.json(usernames); // Respond with the array of usernames
};

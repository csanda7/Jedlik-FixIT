const authenticateUser = (req, res, next) => {
    // Assuming the user is authenticated via some middleware (JWT, sessions, etc.)
    // For example, req.user could be populated by a JWT middleware
    if (req.user) {
      return next(); // Proceed if user is authenticated
    }
    return res.status(401).json({ msg: 'Unauthorized' });
  };
  
  module.exports = authenticateUser;
  
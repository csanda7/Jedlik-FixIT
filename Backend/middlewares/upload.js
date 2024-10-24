const multer = require('multer');
const path = require('path');

// Setup multer for file uploads
const storage = multer.diskStorage({
  destination: (req, file, cb) => {
    cb(null, 'uploads/'); // Adjust the path as needed
  },
  filename: (req, file, cb) => {
    cb(null, file.originalname); // Keep the original name
  }
});

const upload = multer({ storage });

module.exports = upload; // Export the upload middleware

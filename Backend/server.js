const express = require('express');
const cors = require('cors');
const app = express();

app.use(cors()); // Enable CORS for frontend
app.use(express.json());


// Sample API endpoint
app.get('/api/message', (req, res) => {
  res.json({ message: 'Hello from the backend!' });
});


const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});
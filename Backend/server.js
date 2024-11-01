const express = require('express');
const session = require('express-session');
require('dotenv').config();
const path = require('path');
const bodyParser = require('body-parser');
const cors = require('cors');

const app = express();
const { jsonParser } = require('./middlewares/bodyParser');
const authRoutes = require('./routes/authRoutes');
const bugReportController = require('./controllers/bugReportController');
const hibakKiirRoutes = require('./routes/hibaKiirRoutes');
const hibaModositasRountes = require('./routes/hibaModositasRoutes');
const usersWithRolesRoutes = require('./routes/usersWithRolesRoutes');
const logRoutes = require('./routes/logRoutes');

const corsOptions = {
  origin: 'http://localhost:5173',
  methods: 'GET,HEAD,PUT,PATCH,POST,DELETE',
  credentials: true,
};

app.use(cors(corsOptions));
app.use(jsonParser);
app.use(bodyParser.urlencoded({ extended: true }));
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

// Session configuration
app.use(
  session({
    secret: process.env.SESSION_SECRET || 'mySecret', // Replace with a secure secret
    resave: false,
    saveUninitialized: false,
    cookie: {
      httpOnly: true,
      secure: process.env.NODE_ENV === 'production', // Set to true in production
      maxAge: 1 * 60 * 60 * 1000, // 1 day session duration
    },
  })
);

// Routes
app.use('/api/login', authRoutes);
app.use('/api/bugReport', bugReportController);
app.use('/api/hibakKiir', hibakKiirRoutes);
app.use('/api', hibaModositasRountes);
app.use('/uploads', express.static(path.join(__dirname, '../uploads')));
app.use('/api', bugReportController);
app.use('/api/usersWithRoles', usersWithRolesRoutes);
app.use('/api/logs', logRoutes);

// Start the server
const PORT = 4500;
app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});

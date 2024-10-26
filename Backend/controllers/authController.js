const demoUsers = require('../Users/demoUsers'); // Ensure you have a file for demo users

// Authentication function
const authenticateUser = (req, res) => {
    const { username, password } = req.body;

    if (!username || !password) {
        return res.status(400).json({ error: 'Felhasználónév és jelszó szükséges' });
    }

    // Check for demo user
    const user = demoUsers.find(user => user.username === username);

    if (!user) {
        return res.status(401).json({ error: 'Érvénytelen hitelesítő adatok' });
    }

    // Simulate password verification
    if (user.password === password) {
        // Return role in the response
        return res.status(200).json({ success: true, message: 'Sikeres hitelesítés', role: user.role });
    } else {
        return res.status(401).json({ error: 'Érvénytelen hitelesítő adatok' });
    }
};

module.exports = { authenticateUser };

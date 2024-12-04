const demoUsers = require('../Users/demoUsers');

const authenticateUser = (req, res) => {
    const { username, password } = req.body;

    if (!username || !password) {
        return res.status(400).json({ error: 'Felhasználónév és jelszó szükséges' });
    }

    const user = demoUsers.find(user => user.username === username);

    if (!user) {
        return res.status(401).json({ error: 'Érvénytelen hitelesítő adatok' });
    }

    if (user.password === password) {
        // Store user data in the session
        req.session.userId = user.username;
        req.session.role = user.role;
        
        return res.status(200).json({ success: true, message: 'Sikeres hitelesítés', role: user.role });
    } else {
        return res.status(401).json({ error: 'Érvénytelen hitelesítő adatok' });
    }
};

// Route to check session
const checkSession = (req, res) => {
    if (req.session.userId) {
        return res.json({ loggedIn: true, userId: req.session.userId, role: req.session.role });
    }
    return res.json({ loggedIn: false });
};

// Logout route to destroy session
const logoutUser = (req, res) => {
    req.session.destroy((err) => {
        if (err) return res.status(500).json({ message: 'Logout failed' });
        res.clearCookie('connect.sid');
        return res.status(200).json({ message: 'Logged out successfully' });
    });
};

module.exports = { authenticateUser, checkSession, logoutUser };

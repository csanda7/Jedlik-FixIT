import { defineStore } from 'pinia';
import axios from 'axios';

export const useAuthStore = defineStore('auth', {
  state: () => ({
    username: '',
    isAuthenticated: false,
    isAdmin: false,
  }),
  actions: {
    async login(user, pass) {
      try {
        const response = await axios.post('http://localhost:4500/api/login', {
          username: user,
          password: pass,
        }, { withCredentials: true }); // Ensure cookies are included

        if (response.data.success) {
          this.username = user;
          this.isAuthenticated = true;
          return true;
        } else {
          return false;
        }
      } catch (error) {
        console.error("Login error:", error);
        return false;
      }
    },
    async checkSession() {
      try {
        const response = await axios.get('http://localhost:4500/api/login/session', { withCredentials: true });
    
        // Clear previous session data if not logged in
        if (!response.data.loggedIn) {
          this.isAuthenticated = false;
          this.username = '';
          this.role = null; // Clear role information
          sessionStorage.removeItem('username'); // Clear session storage
          sessionStorage.removeItem('role');
          return;
        }
    
        // If logged in, set the username and role
        this.username = response.data.userId;
        this.isAuthenticated = true;
        this.role = response.data.role; // Assuming role is returned in response
        sessionStorage.setItem('username', this.username); // Store the username
        sessionStorage.setItem('role', this.role); // Store the role
        this.isAdmin = this.role === 'a'; // Update isAdmin based on role
      } catch (error) {
        console.error("Session check error:", error);
        this.isAuthenticated = false;
        this.username = '';
        this.role = null; // Ensure role is cleared on error
      }
    },
    
     logout() {
        axios.post('http://localhost:4500/api/login/logout', {}, { withCredentials: true });
        this.isAuthenticated = false;
        this.username = '';
        sessionStorage.removeItem('username');
        sessionStorage.removeItem('role');
        this.isAdmin = false;
    },
  },
});

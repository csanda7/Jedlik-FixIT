// src/modules/AuthModule.js
import { defineStore } from 'pinia';
import axios from 'axios';

export const useAuthStore = defineStore('auth', {
  state: () => ({
    username: '',
    password: '',
    isAuthenticated: false,
    isAdmin: false // New property for admin status
  }),
  actions: {
    async login(user, pass) {
      try {
        const response = await axios.post('http://localhost:4500/login', {
          username: user,
          password: pass
        });

        // Assuming your backend returns an object with success and isAdmin fields
        if (response.data.success) {
          this.username = user;
          this.isAuthenticated = true;
          this.isAdmin = response.data.isAdmin === 'a'; // Assuming 'a' indicates admin
          return true;
        } else {
          return false;
        }
      } catch (error) {
        console.error("Login error:", error);
        return false; // Handle error appropriately
      }
    },
    logout() {
      this.username = '';
      this.isAuthenticated = false;
      this.isAdmin = false; // Reset isAdmin on logout
    }
  }
});

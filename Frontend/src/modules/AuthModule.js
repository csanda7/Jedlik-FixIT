// src/modules/AuthModule.js
import { defineStore } from 'pinia';

export const useAuthStore = defineStore('auth', {
  state: () => ({
    username: '',
    password: '',
    isAuthenticated: false,
  }),
  actions: {
    login(user, pass) {
      if (user === 'admin' && pass === 'password') { // Dummy check
        this.username = user;
        this.isAuthenticated = true;
        return true;
      } else {
        return false;
      }
    },
    logout() {
      this.username = '';
      this.isAuthenticated = false;
    }
  }
});

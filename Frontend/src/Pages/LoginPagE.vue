<template>
  <div :class="{'bg': true, 'dark-mode': isDarkMode}">
    <div class="bg">
      <div class="login-container container d-flex justify-content-center align-items-center vh-100">
        <div class="login-box card p-4 shadow-sm" style="max-width: 400px; width: 100%;">
          <div class="title-bar text-center mb-4">
            <h1 class="mb-3">Bejelentkezés</h1>
          </div>
          <form @submit.prevent="handleLogin">
            <div class="form-group mb-3">
              <input
                type="text"
                :class="['form-control', isDarkMode ? 'dark-textbox' : '']"
                v-model="username"
                placeholder="Felhasználónév"
                required
                id="username"
              />
            </div>
            <div class="form-group mb-3">
              <input
                type="password"
                :class="['form-control', isDarkMode ? 'dark-textbox' : '']"
                v-model="password"
                placeholder="Jelszó"
                required
                id="password"
              />
            </div>
            <button type="submit" class="btn btn-primary w-100">Bejelentkezés</button>
            <p v-if="loginError" class="text-danger mt-3">Hibás felhasználónév vagy jelszó!</p>
          </form>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import axios from 'axios';
import { useAuthStore } from '../modules/AuthModule';

export default {
  data() {
    return {
      username: '',
      password: '',
      loginError: false,
      isDarkMode: false,
    };
  },
  mounted() {
    this.isDarkMode = localStorage.getItem('theme') === 'dark';
    window.addEventListener('theme-changed', this.updateTheme);
  },
  beforeDestroy() {
    window.removeEventListener('theme-changed', this.updateTheme);
  },
  methods: {
    async handleLogin() {
    try {
        const response = await axios.post('http://localhost:4500/api/login', {
            username: this.username,
            password: this.password
        });
        
        if (response.data.success) { // Now checks for success
            const authStore = useAuthStore();
            authStore.isAuthenticated = true;
            sessionStorage.setItem('username', this.username); // Store the username in sessionStorage
            console.log('Logged in as:', this.username); // Log the username
            this.$router.push('/report'); // Navigate to the report page
        } else {
            this.loginError = true; // Handles unsuccessful logins
        }
    } catch (error) {
        console.error("Login failed", error);
        this.loginError = true; // Sets login error for any other errors
    }
},


    updateTheme() {
      this.isDarkMode = localStorage.getItem('theme') === 'dark'; // Update theme based on local storage
    },
  },
};
</script>

<style scoped>

.login-container {
  position: absolute;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
  width: 100%;
  max-width: 400px;
  padding: 20px;
  display: flex;
  justify-content: center;
  align-items: center;
}

/* Removed the background logo */

/* Responsive styles */
@media (max-width: 400px) {
  .bg::before {
    max-width: 100%;
  }
}

.login-box {
  border-radius: 10px;
  background-color: #ffffff; /* Original light mode background color */
  color: #343a40; /* Original text color */
}

.title-bar h1 {
  font-size: 1.8rem;
  font-weight: 600;
  color: #343a40; /* Original text color */
}

.dark-mode .login-box {
  background-color: #3a3a3a; /* Dark grey for dark mode */
  color: #ffffff; /* Text color for better contrast in dark mode */
}

.dark-mode .title-bar h1 {
  color: white;
}

.dark-textbox {
  background-color: #555;
  border: #555;
  color: white;
}

#username::placeholder{
  color: rgb(168, 168, 168);
}

#password::placeholder{
  color: rgb(168, 168, 168);
}




</style>


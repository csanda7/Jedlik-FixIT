<template>
  <div class="login-container container vh-100 d-flex justify-content-center align-items-center">
    <div class="login-box card p-4 shadow-sm">
      <div class="title-bar text-center mb-4">
        <h1 class="mb-3">Bejelentkezés</h1>
      </div>
      <form @submit.prevent="handleLogin">
        <div class="form-group mb-3">
          <input
            type="text"
            v-model="username"
            class="form-control"
            placeholder="Felhasználónév"
            required
          />
        </div>
        <div class="form-group mb-3">
          <input
            type="password"
            v-model="password"
            class="form-control"
            placeholder="Jelszó"
            required
          />
        </div>
        <button type="submit" class="btn btn-primary w-100">Bejelentkezés</button>
        <p v-if="loginError" class="text-danger mt-3">Hibás felhasználónév vagy jelszó!</p>
      </form>
    </div>
  </div>
</template>

<script>
import axios from 'axios';
import { useRouter } from 'vue-router';
import { useAuthStore } from '../modules/AuthModule';

export default {
  data() {
    return {
      username: '',
      password: '',
      loginError: false
    };
  },
  methods: {
    async handleLogin() {
      try {
        const response = await axios.post('http://localhost:4500/login', {
          username: this.username,
          password: this.password
        });

        if (response.data.success) {
          const authStore = useAuthStore();
          authStore.isAuthenticated = true;
          this.$router.push('/report'); // Navigate to the report page
        } else {
          this.loginError = true;
        }
      } catch (error) {
        console.error("Login failed", error);
        this.loginError = true;
      }
    }
  }
};
</script>

<style scoped>
.login-container {
  min-height: calc(100vh - 56px); /* Adjust height to keep footer in view */
}

.card {
  max-width: 400px; /* Optional: restrict max width */
  width: 100%; /* Make it responsive */
}
</style>

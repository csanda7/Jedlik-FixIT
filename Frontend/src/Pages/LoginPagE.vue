<template>
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
          localStorage.setItem('username', response.data.username);
          console.log('Logged in as:', response.data.username);
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
  position: absolute;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%); /* Center the container */
  width: 100%;
  max-width: 400px; /* Set a max width for the form */
  padding: 20px;
  display: flex;
  justify-content: center;
  align-items: center;
}
.bg::before{
  content: "";
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background-image: url('../assets/Jedlik_logo_2020_200_3c5beeccf8.png'); /* Replace with your image path */
  background-size: contain; /* Ensures the image scales to fit the container */
  background-position: center;
  background-repeat: no-repeat;
  background-attachment: fixed;
  opacity: 0.07; /* Set the opacity of the image */
  z-index: -1;
}
@media (max-width: 400px) {
  .bg::before {
    max-width: 100%; /* Ensure the image fills the screen on smaller devices */
  }
}



.login-box {
  border-radius: 10px;
  background-color: #ffffff;
}

.title-bar h1 {
  font-size: 1.8rem;
  font-weight: 600;
  color: #343a40;
}

.form-control {
  height: 45px;
  font-size: 1rem;
}

.btn {
  padding: 10px;
  font-size: 1.1rem;
  border-radius: 5px;
  transition: background-color 0.3s ease;
}

.btn:hover {
  background-color: #ffffff;
  color:rgb(0, 0, 86);
}


</style>

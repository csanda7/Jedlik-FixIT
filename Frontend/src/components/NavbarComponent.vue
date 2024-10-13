<template>
<nav class="navbar navbar-expand-lg navbar-light bg-primary">
    <div class="container-fluid">
      <a class="navbar-brand d-flex align-items-center" href="">
        <img src="../assets/Jedlik_logo_2020_200_3c5beeccf8.png" alt="Jedlik FixIT Logo" style="max-height: 50px;" class="me-2">
        <span class="text-white fw-bold fs-3">Jedlik FixIT</span>
      </a>
      <button
        class="navbar-toggler"
        type="button"
        data-bs-toggle="collapse"
        data-bs-target="#navbarNav"
        aria-controls="navbarNav"
        aria-expanded="false"
        aria-label="Toggle navigation"
      >
        <span class="navbar-toggler-icon"></span>
      </button>
      <div class="collapse navbar-collapse mx-3 row" id="navbarNav">
        <ul class="navbar-nav col-md-10 col-sm-12">
          <li class="nav-item" v-if="isAuthenticated">
            <router-link class="nav-link " to="/report">HIBA BEJELENTÉSE</router-link> <!-- Corrected link -->
          </li>
          <li class="nav-item" v-if="isAuthenticated">
            <router-link class="nav-link" to="/reported">HIBÁK LISTÁJA</router-link> <!-- Corrected link -->
          </li>
          <li class="nav-item" v-if="isAuthenticated">
            <router-link class="nav-link" to="mytasks">FELADATAIM</router-link>
          </li>
          <li class="nav-item" v-if="isAuthenticated">
            <router-link class="nav-link " to="archive">ARCHÍVUM</router-link>
          </li>
          <li class="nav-item" v-if="isAuthenticated">
            <button class="btn btn-outline-light" @click="logout">KILÉPÉS <i class="bi bi-box-arrow-right"></i></button>
          </li>
        </ul>
      </div>
    </div>
  </nav>

</template>

<script>
import { useAuthStore } from '../modules/AuthModule';
import { RouterLink } from 'vue-router';

export default {
  name: 'NavbarComponent',
  components: {
    RouterLink // Ensure router-link is available
  },
  computed: {
    isAuthenticated() {
      const authStore = useAuthStore();
      return authStore.isAuthenticated;
    },
    isAdmin() {
      const authStore = useAuthStore();
      return authStore.isAdmin; // Assuming isAdmin is a property in your AuthModule
    }
  },
  methods: {
    logout() {
      const authStore = useAuthStore();
      authStore.logout(); // You would implement this method in AuthModule
      this.$router.push('/login'); // Redirect to login page on logout
    }
  }
};
</script>



<style scoped>
.navbar-brand {
  color: white;
}


.nav-link {
  color: white;
}

.btn-outline-light {
  color: white;
  border-color: white;
}
.nav-item:hover{
  background-color: white;
  color: #007bff;
  border-radius: 5px;
}

</style>

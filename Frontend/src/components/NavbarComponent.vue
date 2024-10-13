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
            <router-link 
              class="nav-link" 
              :class="{'active-link': $route.path === '/report'}" 
              to="/report">
              HIBA BEJELENTÉSE
            </router-link>
          </li>
          <li class="nav-item" v-if="isAuthenticated">
            <router-link 
              class="nav-link" 
              :class="{'active-link': $route.path === '/reported'}" 
              to="/reported">
              HIBÁK LISTÁJA
            </router-link>
          </li>
          <li class="nav-item" v-if="isAuthenticated">
            <router-link 
              class="nav-link" 
              :class="{'active-link': $route.path === '/mytasks'}" 
              to="mytasks">
              FELADATAIM
            </router-link>
          </li>
          <li class="nav-item" v-if="isAuthenticated">
            <router-link 
              class="nav-link" 
              :class="{'active-link': $route.path === '/archive'}" 
              to="archive">
              ARCHÍVUM
            </router-link>
          </li>
          <li class="nav-item" v-if="isAuthenticated">
            <button class="btn btn-outline-light" @click="logout">
              KILÉPÉS <i class="bi bi-box-arrow-right"></i>
            </button>
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
  border-radius: 5px; /* Make sure there's no border-radius by default */
  transition: background-color 0.5s ease, color 0.5s ease, border-radius 0.5s ease; /* Smooth transition */
}

.nav-link.active-link {
  background-color: white;
  color: #595959;
  border-radius: 5px; /* Apply border-radius to the active link */
}

.nav-item:hover .nav-link {
  background-color: white;
  color: #595959;
  border-radius: 5px;
}

.nav-item:hover .nav-link.active-link {
  background-color: white;
  color: #595959;
  border-radius: 5px;
}

.btn-outline-light {
  color: white;
  border-color: white;
}
.nav-item{
  margin-left:1vh;
}
</style>

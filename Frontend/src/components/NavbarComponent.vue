<template>
  <nav :class="['navbar', 'navbar-expand-lg', isDarkMode ? 'bg-dark-blue' : 'bg-primary']">
    <div class="container-fluid">
      <a class="navbar-brand d-flex align-items-center" href="">
        <img src="../assets/Jedlik_logo_2020_200_3c5beeccf8.png" alt="Jedlik FixIT Logo" style="max-height: 50px;" class="me-2">
        <span :class="{ 'text-white': isDarkMode, 'text-dark': !isDarkMode }" class="fw-bold fs-3">Jedlik FixIT</span>
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
        <ul class="navbar-nav col-lg-10 col-md-9">
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
        </ul>
        <div class="d-lg-flex justify-content-lg-end col-lg-2 mt-lg-0 mt-3" v-if="isAuthenticated">
          <button @click="toggleTheme" class="theme-toggle-btn">
            {{ isDarkMode ? 'Light' : 'Dark' }} Mode
          </button>
          <button class="btn btn-outline-light logout" @click="logout">
            KILÉPÉS <i class="bi bi-box-arrow-right"></i>
          </button>
        </div>
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
    RouterLink, // Ensure router-link is available
  },
  data() {
    return {
      isDarkMode: localStorage.getItem('theme') === 'dark',
    };
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
    },
    toggleTheme() {
      // Toggle the theme and update isDarkMode
      this.isDarkMode = !this.isDarkMode;
      localStorage.setItem('theme', this.isDarkMode ? 'dark' : 'light'); // Update local storage
      document.documentElement.setAttribute('data-theme', this.isDarkMode ? 'dark' : 'light'); // Set the document theme
      window.dispatchEvent(new Event('theme-changed')); // Dispatch a custom event
    }
  }
}
</script>

<style scoped>
.navbar-brand {
  color: white;
}

.logout {
  max-width: fit-content;
}

.nav-link {
  color: white;
  border-radius: 5px;
  transition: background-color 0.5s ease, color 0.5s ease, border-radius 0.5s ease;
}

.nav-link.active-link {
  background-color: white;
  color: #595959;
  border-radius: 5px;
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

.nav-item {
  margin-left: 1vh;
}

@media (max-width: 991.98px) {
  /* On screens smaller than large, stack the logout button below the nav items */
  .navbar-collapse .d-lg-flex {
    justify-content: flex-start !important;
  }
  
  .logout {
    margin-top: 1rem;
  }
}

.theme-toggle-btn {
  cursor: pointer;
  padding: 0.5em 1em;
  border: none;
  border-radius: 5px;
  background-color: #4285f4;
  color: white;
}

/* Define the background color for dark mode */
.bg-dark-blue {
  background-color: #004080; /* Darker shade of blue */
}
</style>

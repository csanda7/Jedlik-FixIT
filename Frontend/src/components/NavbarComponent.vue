<template>
  <nav :class="['navbar', 'navbar-expand-lg', isDarkMode ? 'bg-dark-blue' : 'bg-primary']" id="navbar">
    <div class="container-fluid">
      <a class="navbar-brand d-flex align-items-center" href="">
        <img src="../assets/Jedlik_logo_2020_200_3c5beeccf8.png" alt="Jedlik FixIT Logo" style="max-height: 50px;" class="me-2">
        <span  class="fw-bold fs-3">Jedlik FixIT</span>
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
          <div class="theme-switch mx-2 my-auto">
                <input type="checkbox" id="theme-checkbox" @click="toggleTheme"/>
                    <label for="theme-checkbox">
                    <div></div>
                    <span>
            <svg
              xmlns="http://www.w3.org/2000/svg"
              viewBox="0 0 24 24"
              fill="currentColor"
              class="w-6 h-6"
            >
              <path
                fill-rule="evenodd"
                d="M9.528 1.718a.75.75 0 01.162.819A8.97 8.97 0 009 6a9 9 0 009 9 8.97 8.97 0 003.463-.69.75.75 0 01.981.98 10.503 10.503 0 01-9.694 6.46c-5.799 0-10.5-4.701-10.5-10.5 0-4.368 2.667-8.112 6.46-9.694a.75.75 0 01.818.162z"
                clip-rule="evenodd"
              ></path>
            </svg>
                    </span>
                    <span>
            <svg
              xmlns="http://www.w3.org/2000/svg"
              viewBox="0 0 24 24"
              fill="currentColor"
              class="w-6 h-6"
            >
              <path
                d="M12 2.25a.75.75 0 01.75.75v2.25a.75.75 0 01-1.5 0V3a.75.75 0 01.75-.75zM7.5 12a4.5 4.5 0 119 0 4.5 4.5 0 01-9 0zM18.894 6.166a.75.75 0 00-1.06-1.06l-1.591 1.59a.75.75 0 101.06 1.061l1.591-1.59zM21.75 12a.75.75 0 01-.75.75h-2.25a.75.75 0 010-1.5H21a.75.75 0 01.75.75zM17.834 18.894a.75.75 0 001.06-1.06l-1.59-1.591a.75.75 0 10-1.061 1.06l1.59 1.591zM12 18a.75.75 0 01.75.75V21a.75.75 0 01-1.5 0v-2.25A.75.75 0 0112 18zM7.758 17.303a.75.75 0 00-1.061-1.06l-1.591 1.59a.75.75 0 001.06 1.061l1.591-1.59zM6 12a.75.75 0 01-.75.75H3a.75.75 0 010-1.5h2.25A.75.75 0 016 12zM6.697 7.757a.75.75 0 001.06-1.06l-1.59-1.591a.75.75 0 00-1.061 1.06l1.59 1.591z"
              ></path>
            </svg>
                  </span>
                  </label>
          </div>

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

.theme-switch {
  position: relative;
  display: flex;
  justify-content: center;
  direction: rtl;
}

#theme-checkbox {
  display: none;
}

#theme-checkbox + label {
  /* change the font-size below to change the size of the switch button*/
  font-size: 2rem;
  height: 1em;
  width: 2.5em;
  border-radius: 0.25em;
  cursor: pointer;
  display: flex;
  justify-content: space-between;
  background-color: #cecece;
  position: relative;
}

#theme-checkbox:checked + label {
  background-color: #3a3a3a;
}

#theme-checkbox + label:active {
  transform: scale(0.85);
  transition: transform 0.2s;
}

#theme-checkbox + label div {
  width: 0.8em;
  height: 0.8em;
  border-radius: inherit;
  position: absolute;
  top: 0.1em;
  left: 0.1em;
  z-index: 10;
  transition: 0.5s cubic-bezier(1, 0.33, 0.11, 1.34);
  background-color: #f2f2f2;
}

#theme-checkbox:checked + label div {
  /* left: calc(2.5em - .8em - .1em); */
  left: 1.6em;
  background-color: #212121;
}

#theme-checkbox + label span {
  display: flex;
}

#theme-checkbox + label svg {
  display: inline-block;
  height: 1em;
  width: 1em;
  padding: 0.15em;
  box-sizing: border-box;
}

#theme-checkbox + label span:first-of-type {
  color: #3a3a3a;
}

#theme-checkbox + label span:last-of-type {
  color: #cecece;
}

/* Dark Mode */
.dark-mode .nav-link {
  color: #cecece;
  border-radius: 5px;
  transition: background-color 0.5s ease, color 0.5s ease, border-radius 0.5s ease, border 0.5s ease;
  border: 2px solid transparent; /* Default border set to transparent */
}

.dark-mode .nav-link.active-link {
  background-color: #212121; /* Dark background for active link in dark mode */
  color: white; 
  border-radius: 5px;
}

.dark-mode .nav-item:hover .nav-link {
  background-color: #333; /* Dark background on hover in dark mode */
  color: white;
  border-radius: 5px;
}

.dark-mode .nav-item:hover .nav-link.active-link {
  background-color: #333; /* Darker background for active link on hover in dark mode */
  color: white;
  border-radius: 5px;
}

#navbar{
  position: fixed; /* Ensure the navbar stays at the top */
  top: 0; /* Stick the navbar to the top */
  width: 100%; /* Make sure it takes the full width */
  z-index: 1000; /* Ensure it's above other elements */
}




</style>

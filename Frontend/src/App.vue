<template>
  <div :class="{ 'dark-mode': isDarkMode }">
    <!-- Navbar is always visible at the top -->
    <NavbarComponent @toggle-dark-mode="toggleDarkMode" />
    <div class="content">
      <router-view />
    </div>
  </div>
</template>

<script>
import NavbarComponent from './components/NavbarComponent.vue';

export default {
  components: {
    NavbarComponent,
  },
  data() {
    return {
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
    updateTheme() {
      this.isDarkMode = localStorage.getItem('theme') === 'dark';
    },
  }
};  
</script>

<style scoped>

html,
body {
  height: 100%;
  margin: 0;
}
.h2 {
  color: rgb(59, 59, 59);
  padding: 0.5em;
}

.bg {
  background-color: rgb(255, 255, 255);
  z-index: 500;
  border-radius: 5vh;
}
.form-control {
  height: 45px;
  font-size: 1rem;
}
.form-range {
  width: 100%;
}

.content {
  flex: 1; /* Allow content to grow and fill the remaining space */
  flex-direction: column;
  min-height: 100vh; /* Ensure content takes up full height */
  overflow: auto; /* Allow scrolling within content if needed */
  margin-top: 4rem;
  
}
.card {
  max-width: 600px;
  margin: 0 auto;
}
.card-header {
  background-color: #f93943;
  color: white;
  padding: 1.2rem;
  border-bottom: none;
}

.card-header h1 {
  margin-left: -10px;
}
.btn {
  padding: 10px;
  font-size: 1.1rem;
  border-radius: 5px;
  transition: background-color 0.3s ease;
}

.btn:hover {
  background-color: #ffffff;
  color: rgb(0, 0, 86);
}
.btn-primary {
  background-color: #4285f4;
  border-color: #4285f4;
}

.btn-secondary {
  background-color: #636363;
  color: white;
  padding: 0.5rem 1rem;
  border: none;
  border-radius: 5px;
  cursor: pointer;
}

.btn-secondary:hover {
  background-color: #4285f4;
  color: white;
}


.btn-close {
  background: none;
  border: none;
  font-size: 1.5rem;
  cursor: pointer;
}





/* DARK MODE */

.dark-mode {
  background-color: #222222; /* Dark mode background color */
  color: white; /* Text color for dark mode */
  min-height: 100vh; /* Ensure it takes full height */
 
}

</style>

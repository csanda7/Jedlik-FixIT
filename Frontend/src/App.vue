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


.dark-mode {
  background-color: #222222; /* Dark mode background color */
  color: white; /* Text color for dark mode */
  min-height: 100vh; /* Ensure it takes full height */
  overflow: hidden; /* Prevent scroll in dark mode */
}

.content {
  flex: 1; /* Allow content to grow and fill the remaining space */
  flex-direction: column;
  min-height: 100vh; /* Ensure content takes up full height */
  overflow: auto; /* Allow scrolling within content if needed */
}

</style>

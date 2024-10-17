<template>
  <div>
    <!-- Navbar is always visible at the top -->
    <NavbarComponent class="navbar" />
    <div class="content">
      <router-view/>
    </div>
  </div>
</template>

<script>
import NavbarComponent from './components/NavbarComponent.vue';
import FooterComponent from './components/FooterComponent.vue';

export default {
  components: {
    NavbarComponent,
    FooterComponent
  }
};
</script>

<style scoped>
.navbar {
  position: fixed;
  top: 0;
  width: 100%;
  z-index: 1000; /* Ensure the navbar is above other content */
  background-color: white; /* Add background color to prevent overlapping content */
  box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1); /* Optional: adds shadow for better visibility */
}

.content {
  margin-top: 18vh; /* Adjust margin to prevent content from being hidden under the navbar */
  margin-bottom: 8vh; /* Adjust margin to prevent content from being hidden under the navbar */
}
</style>

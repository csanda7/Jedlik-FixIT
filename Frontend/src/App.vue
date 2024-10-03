<template>
    <div>
      <!-- Navbar and Footer are now always visible -->
      <NavbarComponent />
      <router-view />
      <FooterComponent />
    </div>
  </template>
  
  <script>
  import NavbarComponent from './components/NavbarComponent.vue';
  import FooterComponent from './components/FooterComponent.vue';
  
  export default {
    components: {
      NavbarComponent,
      //FooterComponent
    }
  };
  </script>
  
  <style>
  /* Add global styles here if needed */
  </style>
  
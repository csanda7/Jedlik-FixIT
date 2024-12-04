<template>
  <footer class="bg-light text-center py-3">
    <div class="container">
      <p>&copy; 2024 Jedlik FixIT</p>
    </div>
  </footer>
</template>

<script>
export default {
  name: 'FooterComponent'
};
</script>

<style scoped>
html, body {
  height: 100%; /* Ensure the html and body take the full height */
  margin: 0; /* Remove default margin */
}

.container {
  display: flex;
  justify-content: center; /* Center content horizontally */
}

footer {
  width: 100%; /* Full width */
  position: fixed; /* Fix the footer to the bottom */
  bottom: 0; /* Align it at the bottom */
}
</style>

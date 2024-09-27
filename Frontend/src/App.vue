<template>
  <div id="app">
    <h1>{{ message }}</h1>
  </div>
</template>

<script>
export default {
  data() {
    return {
      message: '',
    };
  },
  mounted() {
    fetch('http://localhost:3000/api/message')
      .then(response => response.json())
      .then(data => {
        this.message = data.message;
      });
  },
};
</script>

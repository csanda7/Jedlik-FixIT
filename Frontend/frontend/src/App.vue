<template>
  <div id="app">
    <h1>{{ message }}</h1>
    <button @click="getMessage">Get Message from Backend</button>
  </div>
</template>

<script>
export default {
  data() {
    return {
      message: "Hello from Vue.js!"
    };
  },
  methods: {
    async getMessage() {
      try {
        const response = await fetch('http://localhost:3000/api/message');
        const data = await response.json();
        this.message = data.message;
      } catch (error) {
        console.error("Error fetching the message:", error);
      }
    }
  }
}
</script>

<style scoped>
h1 {
  color: #42b983;
}
</style>

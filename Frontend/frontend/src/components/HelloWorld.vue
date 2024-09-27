<template>
  <div>
    <h1>Vue.js Frontend</h1>
    <p>{{ message }}</p>
    <button @click="getMessage">Get Message from Backend</button>
  </div>
</template>

<script>
import axios from 'axios';

export default {
  data() {
    return {
      message: ''
    }
  },
  methods: {
    async getMessage() {
      try {
        const response = await axios.get('http://localhost:3000/api/message');
        this.message = response.data.message;
      } catch (error) {
        console.error('Error fetching data:', error);
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

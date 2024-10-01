import { createApp } from 'vue';
import App from './App.vue';
import router from './router/router.js';
import { createPinia } from 'pinia'; // Import Pinia
import 'bootstrap/dist/css/bootstrap.min.css';
import 'bootstrap';

const pinia = createPinia(); // Create Pinia instance

createApp(App).use(pinia).use(router).mount('#app');

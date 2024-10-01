import { createRouter, createWebHistory } from 'vue-router';
import { useAuthStore } from '../modules/AuthModule';
import ReportPage from '../Pages/ReportPage.vue';
import Login from '../components/Login.vue';

const routes = [
  {
    path: '/',
    redirect: '/login' // Redirect to login by default
  },
  {
    path: '/login',
    name: 'Login',
    component: Login
  },
  {
    path: '/report',
    name: 'Report',
    component: ReportPage,
    meta: { requiresAuth: true } // This requires authentication
  }
];

const router = createRouter({
  history: createWebHistory(),
  routes
});

// Navigation guard to protect the report page
router.beforeEach((to, from, next) => {
  const authStore = useAuthStore();

  if (to.meta.requiresAuth && !authStore.isAuthenticated) {
    next('/login'); // Redirect to login if not authenticated
  } else if (to.path === '/login' && authStore.isAuthenticated) {
    next('/report'); // Redirect to report if already logged in
  } else {
    next(); // Proceed as usual
  }
});

export default router;

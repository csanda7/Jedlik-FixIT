import { createRouter, createWebHistory } from 'vue-router';
import { useAuthStore } from '../modules/AuthModule';
import ReportPage from '../Pages/ReportPage.vue';
import AlreadyReportedPage from '../Pages/AlreadyReportedPage.vue'; // Import the AlreadyReportedPage
import LoginPage from '../Pages/LoginPagE.vue'; // Updated import

const routes = [
  {
    path: '/',
    redirect: '/login' // Redirect to login by default
  },
  {
    path: '/login',
    name: 'Login',
    component: LoginPage // Updated component reference
  },
  {
    path: '/report',
    name: 'Report',
    component: ReportPage
  },
  {
    path: '/reported',
    name: 'AlreadyReported',
    component: AlreadyReportedPage
  },
];

const router = createRouter({
  history: createWebHistory(),
  routes
});

// Navigation guard to protect the report and reported page
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

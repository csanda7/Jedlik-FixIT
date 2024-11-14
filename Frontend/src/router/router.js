import { createRouter, createWebHistory } from 'vue-router';
import { useAuthStore } from '../modules/AuthModule';
import ReportPage from '../Pages/ReportPage.vue';
import AlreadyReportedPage from '../Pages/AlreadyReportedPage.vue';
import LoginPage from '../Pages/LoginPagE.vue';
import MyTasks from '../Pages/MyTasks.vue';
import Archive from '../Pages/Archive.vue';
import TaskSupervisor from '../Pages/TaskSupervisor.vue';

const routes = [
  { path: '/', redirect: '/login' },
  { path: '/login', name: 'Login', component: LoginPage },
  { path: '/report', name: 'Report', component: ReportPage, meta: { requiresAuth: true } },
  { path: '/reported', name: 'AlreadyReported', component: AlreadyReportedPage, meta: { requiresAuth: true } },
  { path: '/mytasks', name: 'MyTasks', component: MyTasks, meta: { requiresAuth: true } },
  { path: '/archive', name: 'Archive', component: Archive, meta: { requiresAuth: true } },
  { path: '/tasksupervisor', name: 'TaskSupervisor', component: TaskSupervisor, meta: { requiresAuth: true } },
];

const router = createRouter({
  history: createWebHistory(),
  routes,
});

router.beforeEach(async (to, from, next) => {
  const authStore = useAuthStore();
  
  if (!authStore.isAuthenticated) {
    await authStore.checkSession(); // Check session if not already authenticated
  }

  if (to.meta.requiresAuth && !authStore.isAuthenticated) {
    next('/login');
  } else if (to.path === '/login' && authStore.isAuthenticated) {
    next('/report');
  } else {
    next();
  }
});

export default router;

import { createRouter, createWebHistory } from 'vue-router'
import SeletorRaca from '../components/compendio/SeletorRaca.vue'

const router = createRouter({
  history: createWebHistory(),
  routes: [
    { path: '/', redirect: '/racas' },
    { path: '/racas', name: 'racas', component: SeletorRaca }
  ]
})

export default router

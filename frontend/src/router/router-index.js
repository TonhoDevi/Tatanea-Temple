import { createRouter, createWebHistory } from 'vue-router';
import Home from '../views/Home.vue';
import SeletorRaca from '../components/compendio/SeletorRaca.vue';
import CompendioTalentos from '../components/compendio/CompendioTalentos.vue';
import CompendioAlquimia from '../components/compendio/CompendioAlquimia.vue';
import CompendioClasses from '../components/compendio/CompendioClasses.vue';
import Login from '../views/Login.vue';
import Registro from '../views/Registro.vue';
import MeusPersonagens from '../views/MeusPersonagens.vue';
import FichaPersonagem from '../views/FichaPersonagem.vue';

const routes = [
  { path: '/', name: 'home', component: Home },
  { path: '/racas', name: 'racas', component: SeletorRaca },
  { path: '/talentos', name: 'talentos', component: CompendioTalentos },
  { path: '/alquimia', name: 'alquimia', component: CompendioAlquimia },
  { path: '/classes', name: 'classes', component: CompendioClasses },
  { path: '/login', name: 'login', component: Login },
  { path: '/registro', name: 'registro', component: Registro },
  { path: '/personagens', name: 'personagens', component: MeusPersonagens, meta: { requerAuth: true } },
  { path: '/personagens/:id', name: 'ficha-personagem', component: FichaPersonagem, meta: { requerAuth: true } },
];

const router = createRouter({
  history: createWebHistory(),
  routes,
});

router.beforeEach((to) => {
  if (to.meta.requerAuth && !localStorage.getItem('tatanea_token')) {
    return { path: '/login' };
  }
  return true;
});

export default router;
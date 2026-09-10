import { createRouter, createWebHistory } from 'vue-router';
import Home from '../views/Home.vue';
import CompendioRacas from '../components/compendio/CompendioRacas.vue';
import DetalheRaca from '../components/compendio/DetalheRaca.vue';
import CompendioTalentos from '../components/compendio/CompendioTalentos.vue';
import DetalheTalento from '../components/compendio/DetalheTalento.vue';
import CompendioTalentosRaciais from '../components/compendio/CompendioTalentosRaciais.vue';
import DetalheTalentoRacial from '../components/compendio/DetalheTalentoRacial.vue';
import CompendioAlquimia from '../components/compendio/CompendioAlquimia.vue';
import CompendioClasses from '../components/compendio/CompendioClasses.vue';
import Login from '../views/Login.vue';
import Registro from '../views/Registro.vue';
import MeusPersonagens from '../views/MeusPersonagens.vue';
import FichaPersonagem from '../views/FichaPersonagem.vue';

const routes = [
  { path: '/', name: 'home', component: Home },
  { path: '/racas', name: 'racas', component: CompendioRacas },
  { path: '/racas/:id', name: 'raca-detalhe', component: DetalheRaca },
  { path: '/talentos', name: 'talentos', component: CompendioTalentos },
  { path: '/talentos/:id', name: 'talento-detalhe', component: DetalheTalento },
  { path: '/talentos-raciais', name: 'talentos-raciais', component: CompendioTalentosRaciais },
  { path: '/talentos-raciais/:id', name: 'talento-racial-detalhe', component: DetalheTalentoRacial },
  { path: '/alquimia', name: 'alquimia', component: CompendioAlquimia },
  { path: '/classes', name: 'classes', component: CompendioClasses },
  { path: '/login', name: 'login', component: Login, meta: { hideNavbar: true } },
  { path: '/registro', name: 'registro', component: Registro, meta: { hideNavbar: true } },
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
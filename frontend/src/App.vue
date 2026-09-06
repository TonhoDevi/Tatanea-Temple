<script setup>
import { RouterLink, RouterView, useRouter } from 'vue-router';
import { useAuthStore } from './stores/authStore';

const auth = useAuthStore();
const router = useRouter();

function sair() {
  auth.logout();
  router.push('/login');
}
</script>

<template>
  <header class="app-header">
    <div class="app-header-inner">
      <span class="app-logo">Tatanea Temple</span>
      <nav class="app-nav">
        <RouterLink to="/racas">Raças</RouterLink>
        <RouterLink to="/talentos">Talentos</RouterLink>
        <RouterLink to="/alquimia">Alquimia</RouterLink>
        <RouterLink to="/classes">Classes</RouterLink>
        <RouterLink v-if="auth.estaLogado" to="/personagens">Meus Personagens</RouterLink>
        <RouterLink v-if="!auth.estaLogado" to="/login">Entrar</RouterLink>
        <button v-else class="nav-sair" @click="sair">Sair</button>
      </nav>
    </div>
  </header>

  <main>
    <RouterView />
  </main>
</template>

<style scoped>
.app-header {
  background: #1a1330;
  border-bottom: 1px solid #4a3a6a;
  padding: 0.75rem 1rem;
}

.app-header-inner {
  max-width: 1100px;
  margin: 0 auto;
  display: flex;
  align-items: center;
  justify-content: space-between;
  flex-wrap: wrap;
  gap: 0.75rem;
}

.app-logo {
  font-family: 'Pirata One', cursive;
  font-size: 1.4rem;
  color: #e8e0f5;
}

.app-nav {
  display: flex;
  align-items: center;
  gap: 1.2rem;
}

.app-nav a {
  color: #c9bce8;
  text-decoration: none;
  font-family: 'Cinzel', serif;
  font-size: 0.95rem;
  padding: 0.3rem 0.2rem;
  border-bottom: 2px solid transparent;
  transition: border-color 0.15s ease, color 0.15s ease;
}

.app-nav a:hover,
.app-nav a.router-link-active {
  color: #e8e0f5;
  border-bottom-color: #8a6ac0;
}

.nav-sair {
  background: none;
  border: 1px solid #5a4a7a;
  color: #c9bce8;
  border-radius: 6px;
  padding: 0.3rem 0.7rem;
  font-family: 'Cinzel', serif;
  font-size: 0.85rem;
  cursor: pointer;
}
</style>
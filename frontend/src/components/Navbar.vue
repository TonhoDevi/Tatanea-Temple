<script setup>
import { ref } from 'vue';
import { RouterLink, useRouter } from 'vue-router';
import { useAuthStore } from '../stores/authStore';
import logo from '../assets/img/Rose_logo_1_SF.png';

const auth = useAuthStore();
const router = useRouter();
const menuAberto = ref(false);

function alternarMenu() {
  menuAberto.value = !menuAberto.value;
}

function fecharMenu() {
  menuAberto.value = false;
}

function sair() {
  fecharMenu();
  auth.logout();
  router.push('/login');
}
</script>

<template>
  <nav class="navbar">
    <div class="navbar-container">
      <RouterLink to="/" class="navbar-logo" @click="fecharMenu">
        <img :src="logo" alt="Templo de Tatânea" class="navbar-mini-logo" />
        <span class="navbar-logo-text">Templo de Tatânea</span>
      </RouterLink>

      <ul class="navbar-menu" :class="{ active: menuAberto }">
        <li><RouterLink to="/racas" @click="fecharMenu">Raças</RouterLink></li>
        <li><RouterLink to="/talentos" @click="fecharMenu">Talentos</RouterLink></li>
        <li><RouterLink to="/alquimia" @click="fecharMenu">Alquimia</RouterLink></li>
        <li><RouterLink to="/classes" @click="fecharMenu">Classes</RouterLink></li>
        <li v-if="auth.estaLogado">
          <RouterLink to="/personagens" @click="fecharMenu">Meus Personagens</RouterLink>
        </li>
        <li v-if="!auth.estaLogado">
          <RouterLink to="/login" @click="fecharMenu">Entrar</RouterLink>
        </li>
        <li v-else>
          <button class="navbar-sair" @click="sair">Sair</button>
        </li>
      </ul>

      <button
          class="navbar-toggle"
          :aria-expanded="menuAberto"
          aria-label="Abrir menu"
          @click="alternarMenu"
      >
        ☰
      </button>
    </div>
  </nav>
</template>

<style scoped>
.navbar {
  background: linear-gradient(
      135deg,
      var(--color-foundation-darkest, #050814) 0%,
      var(--color-foundation-dark, #090d24) 60%,
      var(--color-accent-gold-dark, #0a0d28) 100%
  );
  border-bottom: 2px solid var(--color-accent-amber, #6055a0);
  position: sticky;
  top: 0;
  z-index: 1000;
  box-shadow: 0 4px 20px rgba(0, 0, 0, 0.75), 0 1px 0 rgba(144, 128, 200, 0.1);
  backdrop-filter: blur(10px);
}

.navbar::before {
  content: '';
  position: absolute;
  bottom: 0;
  left: 0;
  width: 100%;
  height: 1px;
  background: linear-gradient(
      90deg,
      transparent,
      var(--color-accent-gold-medium, #9080c8) 20%,
      var(--color-accent-gold-bright, #c8bce8) 50%,
      var(--color-accent-gold-medium, #9080c8) 80%,
      transparent
  );
  opacity: 0.5;
}

.navbar-container {
  max-width: 1400px;
  margin: 0 auto;
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 14px 30px;
  position: relative;
}

.navbar-logo {
  display: flex;
  align-items: center;
  gap: 12px;
  text-decoration: none;
}

.navbar-mini-logo {
  width: 38px;
  height: 38px;
  object-fit: contain;
  filter: drop-shadow(0 0 6px rgba(200, 188, 232, 0.4));
}

.navbar-logo-text {
  font-family: 'Pirata One', cursive;
  font-size: 1.6rem;
  color: var(--color-accent-gold-bright, #c8bce8);
  text-shadow: 2px 2px 6px rgba(0, 0, 0, 0.85), 0 0 20px rgba(144, 128, 200, 0.4);
  letter-spacing: 1px;
  transition: color 0.3s ease, text-shadow 0.3s ease;
}

.navbar-logo:hover .navbar-logo-text {
  color: var(--color-text-highlight, #ede8ff);
  text-shadow: 0 0 15px rgba(144, 128, 200, 0.6), 0 0 35px rgba(96, 85, 160, 0.5);
}

.navbar-menu {
  display: flex;
  list-style: none;
  gap: 26px;
  margin: 0;
  padding: 0;
}

.navbar-menu a,
.navbar-sair {
  color: var(--color-text-secondary, #7870a0);
  text-decoration: none;
  font-family: 'Cinzel', serif;
  font-size: 0.85rem;
  font-weight: 600;
  text-transform: uppercase;
  letter-spacing: 1.5px;
  padding: 8px 4px;
  border-bottom: 2px solid transparent;
  position: relative;
  transition: color 0.3s ease;
  background: none;
  border-left: none;
  border-right: none;
  border-top: none;
  cursor: pointer;
}

.navbar-menu a::after {
  content: '';
  position: absolute;
  bottom: -2px;
  left: 50%;
  width: 0;
  height: 2px;
  background: linear-gradient(
      90deg,
      var(--color-accent-amber, #6055a0),
      var(--color-accent-gold-bright, #c8bce8)
  );
  transition: width 0.3s ease;
  transform: translateX(-50%);
}

.navbar-menu a:hover,
.navbar-menu a.router-link-active {
  color: var(--color-text-highlight, #ede8ff);
}

.navbar-menu a:hover::after,
.navbar-menu a.router-link-active::after {
  width: 100%;
}

.navbar-toggle {
  display: none;
  background: none;
  border: 2px solid var(--color-accent-amber, #6055a0);
  color: var(--color-accent-gold-bright, #c8bce8);
  font-size: 1.3rem;
  padding: 4px 13px;
  cursor: pointer;
  border-radius: 4px;
  transition: all 0.3s ease;
}

.navbar-toggle:hover {
  background: var(--color-accent-amber-translucid, rgba(60, 50, 120, 0.5));
}

/* ===== Responsivo ===== */
@media (max-width: 768px) {
  .navbar-container {
    padding: 8px 16px;
  }

  .navbar-logo-text {
    font-size: 1.2rem;
  }

  .navbar-mini-logo {
    width: 30px;
    height: 30px;
  }

  .navbar-menu {
    display: none;
    flex-direction: column;
    justify-content: center;
    align-items: center;
    position: fixed;
    inset: 0;
    width: 100%;
    height: 100vh;
    background: rgba(5, 8, 20, 0.98);
    padding: 0;
    gap: 28px;
    backdrop-filter: blur(10px);
    z-index: 999;
  }

  .navbar-menu.active {
    display: flex;
  }

  .navbar-menu a,
  .navbar-sair {
    font-size: 1.3rem;
  }

  .navbar-toggle {
    display: block;
    position: relative;
    z-index: 1000;
  }
}
</style>
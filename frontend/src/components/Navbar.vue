<script setup>
import { ref, onMounted, onBeforeUnmount } from 'vue';
import { RouterLink, useRouter } from 'vue-router';
import { useAuthStore } from '../stores/authStore';
import logo from '../assets/img/Rose_logo_1_SF.png';
import RoladorDados from './RoladorDados.vue';

const auth = useAuthStore();
const router = useRouter();

const rolagemAberta = ref(false);
const contaAberta = ref(false);
const contaMenuEl = ref(null);

function alternarConta() {
  contaAberta.value = !contaAberta.value;
}

function fecharConta() {
  contaAberta.value = false;
}

function aoClicarFora(evento) {
  if (contaAberta.value && contaMenuEl.value && !contaMenuEl.value.contains(evento.target)) {
    fecharConta();
  }
}

onMounted(() => document.addEventListener('click', aoClicarFora));
onBeforeUnmount(() => document.removeEventListener('click', aoClicarFora));

function sair() {
  fecharConta();
  auth.logout();
  router.push('/login');
}
</script>

<template>
  <nav class="navbar">
    <div class="navbar-container">
      <RouterLink to="/" class="navbar-logo">
        <img :src="logo" alt="Templo de Tatânea" class="navbar-mini-logo" />
        <span class="navbar-logo-text">Templo de Tatânea</span>
      </RouterLink>

      <div class="navbar-right">
        <div class="navbar-icons">
          <RouterLink to="/" class="navbar-icon-btn" title="Início">
            <svg class="navbar-icon-svg" viewBox="0 0 32 32" aria-hidden="true">
              <circle cx="16" cy="5.5" r="1.6" />
              <path d="M16 8 L23 16 H9 Z" />
              <path d="M9 16 H23 V20 H9 Z" />
              <path d="M6 20 H26 V24 H6 Z" />
              <path d="M2 24 H30 V28 H2 Z" />
              <path d="M14 28 V25 A2 2 0 0 1 18 25 V28" />
            </svg>
          </RouterLink>
          <button class="navbar-icon-btn" title="Rolador de dados" @click="rolagemAberta = true">
            <svg class="navbar-icon-svg" viewBox="0 0 32 32" aria-hidden="true">
              <path d="M16 4 L26.4 10 L26.4 22 L16 28 L5.6 22 L5.6 10 Z" />
              <path
                  class="navbar-icon-svg-fina"
                  d="M16 16 L16 4 M16 16 L26.4 10 M16 16 L26.4 22 M16 16 L16 28 M16 16 L5.6 22 M16 16 L5.6 10"
              />
              <circle cx="16" cy="9.5" r="1" fill="currentColor" stroke="none" />
              <circle cx="21.5" cy="16.5" r="1" fill="currentColor" stroke="none" />
              <circle cx="23.5" cy="19.8" r="1" fill="currentColor" stroke="none" />
            </svg>
          </button>
          <RouterLink v-if="auth.estaLogado" to="/personagens" class="navbar-icon-btn" title="Meus personagens">
            <svg class="navbar-icon-svg" viewBox="0 0 32 32" aria-hidden="true">
              <ellipse cx="16" cy="7" rx="9" ry="3" />
              <ellipse cx="16" cy="25" rx="9" ry="3" />
              <path d="M7 7 V25 M25 7 V25" />
              <path class="navbar-icon-svg-fina" d="M11 13 H21 M11 17 H21 M11 21 H18" />
            </svg>
          </RouterLink>

          <div v-if="auth.estaLogado" class="navbar-conta" ref="contaMenuEl">
            <button
                class="navbar-icon-btn"
                title="Conta"
                :aria-expanded="contaAberta"
                @click="alternarConta"
            >
              <svg class="navbar-icon-svg" viewBox="0 0 32 32" aria-hidden="true">
                <rect x="14.5" y="3" width="3" height="5" rx="0.8" />
                <rect x="14.5" y="3" width="3" height="5" rx="0.8" transform="rotate(45 16 16)" />
                <rect x="14.5" y="3" width="3" height="5" rx="0.8" transform="rotate(90 16 16)" />
                <rect x="14.5" y="3" width="3" height="5" rx="0.8" transform="rotate(135 16 16)" />
                <rect x="14.5" y="3" width="3" height="5" rx="0.8" transform="rotate(180 16 16)" />
                <rect x="14.5" y="3" width="3" height="5" rx="0.8" transform="rotate(225 16 16)" />
                <rect x="14.5" y="3" width="3" height="5" rx="0.8" transform="rotate(270 16 16)" />
                <rect x="14.5" y="3" width="3" height="5" rx="0.8" transform="rotate(315 16 16)" />
                <circle cx="16" cy="16" r="8.5" />
                <circle class="navbar-icon-svg-fina" cx="16" cy="16" r="6" />
                <circle cx="16" cy="16" r="3" />
              </svg>
            </button>
            <div class="navbar-conta-menu" v-if="contaAberta">
              <div class="navbar-conta-menu-title">Conta</div>
              <button class="navbar-conta-menu-item" disabled title="Em breve">Editar perfil</button>
              <button class="navbar-conta-menu-item" disabled title="Em breve">Trocar senha</button>
            </div>
          </div>
        </div>

        <div class="navbar-session">
          <template v-if="auth.estaLogado">
            <span class="navbar-apelido">{{ auth.usuario?.nome || auth.usuario?.email }}</span>
            <button class="navbar-sair" @click="sair">Sair</button>
          </template>
          <RouterLink v-else to="/login" class="navbar-entrar">Entrar</RouterLink>
        </div>
      </div>
    </div>

  </nav>

  <Teleport to="body">
    <RoladorDados v-if="rolagemAberta" @fechar="rolagemAberta = false" />
  </Teleport>
</template>

<style scoped>
.navbar {
  --jungle-void: var(--bg-deep);
  --jungle-darkest: color-mix(in srgb, var(--bg-deep) 75%, black);
  --jungle-dark: var(--bg-card);
  --jungle-moss: var(--bg-subcard);
  --jungle-green: var(--accent-green);
  --tribal-red: var(--accent-terracotta);
  --tribal-gold: var(--accent-gold);
  --tribal-yellow: var(--accent-gold);
  --bone: var(--text-pale);
  --pale-green: var(--text-muted);

  background: linear-gradient(
      135deg,
      var(--jungle-darkest) 0%,
      var(--jungle-void) 60%,
      var(--jungle-dark) 100%
  );
  border-bottom: 2px solid var(--tribal-gold);
  position: sticky;
  top: 0;
  z-index: 1000;
  box-shadow: 0 4px 20px rgba(0, 0, 0, 0.75), 0 1px 0 rgba(212, 163, 89, 0.1);
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
      var(--tribal-gold) 20%,
      var(--tribal-yellow) 50%,
      var(--tribal-gold) 80%,
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
  gap: 16px;
  padding: 12px 30px;
  position: relative;
}

.navbar-right {
  display: flex;
  align-items: center;
  gap: 20px;
  flex: none;
}

.navbar-logo {
  display: flex;
  align-items: center;
  gap: 12px;
  text-decoration: none;
  min-width: 0;
}

.navbar-mini-logo {
  width: 38px;
  height: 38px;
  object-fit: contain;
  flex: none;
  filter: drop-shadow(0 0 6px rgba(200, 188, 232, 0.4));
}

.navbar-logo-text {
  font-family: 'Pirata One', cursive;
  font-size: 1.6rem;
  color: var(--tribal-yellow);
  text-shadow: 2px 2px 6px rgba(0, 0, 0, 0.85), 0 0 20px rgba(35, 110, 71, 0.4);
  letter-spacing: 1px;
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
  transition: color 0.3s ease, text-shadow 0.3s ease;
}

.navbar-logo:hover .navbar-logo-text {
  color: var(--bone);
  text-shadow: 0 0 15px rgba(212, 163, 89, 0.6), 0 0 35px rgba(35, 110, 71, 0.5);
}

/* ===== Ícones (direita) ===== */
.navbar-icons {
  display: flex;
  align-items: center;
  gap: 10px;
  flex: none;
}

.navbar-icon-btn {
  display: flex;
  align-items: center;
  justify-content: center;
  width: 42px;
  height: 42px;
  background: rgba(35, 110, 71, 0.14);
  border: 1.5px solid var(--jungle-green);
  border-radius: 8px;
  font-size: 1.25rem;
  color: var(--pale-green);
  text-decoration: none;
  cursor: pointer;
  transition: background-color 0.25s ease, border-color 0.25s ease, transform 0.15s ease;
}

.navbar-icon-svg {
  width: 20px;
  height: 20px;
  fill: none;
  stroke: currentColor;
  stroke-width: 1.4;
  stroke-linecap: round;
  stroke-linejoin: round;
  transition: stroke 0.25s ease;
}

.navbar-icon-svg-fina {
  stroke-width: 0.9;
}

.navbar-icon-btn:hover .navbar-icon-svg {
  stroke: var(--tribal-yellow);
}

.navbar-icon-btn:hover {
  background: rgba(35, 110, 71, 0.32);
  border-color: var(--tribal-gold);
  transform: translateY(-1px);
}

.navbar-icon-btn.router-link-active {
  border-color: var(--tribal-gold);
  background: rgba(212, 163, 89, 0.22);
}

/* ===== Menu da engrenagem ===== */
.navbar-conta {
  position: relative;
}

.navbar-conta-menu {
  position: absolute;
  top: calc(100% + 10px);
  right: 0;
  min-width: 190px;
  background: var(--jungle-darkest);
  border: 1px solid var(--tribal-gold);
  border-radius: 8px;
  padding: 8px;
  box-shadow: 0 12px 30px rgba(0, 0, 0, 0.6);
  display: flex;
  flex-direction: column;
  gap: 4px;
  z-index: 10;
}

.navbar-conta-menu-title {
  font-family: 'Cinzel', serif;
  font-size: 0.65rem;
  letter-spacing: 0.14em;
  text-transform: uppercase;
  color: var(--pale-green);
  padding: 4px 8px;
}

.navbar-conta-menu-item {
  text-align: left;
  background: none;
  border: none;
  border-radius: 6px;
  padding: 8px;
  font-family: 'Cinzel', serif;
  font-size: 0.8rem;
  color: var(--tribal-yellow);
  cursor: not-allowed;
  opacity: 0.55;
}

.navbar-conta-menu-item:hover {
  background: rgba(35, 110, 71, 0.2);
}

/* ===== Sessão (apelido / sair / entrar) ===== */
.navbar-session {
  display: flex;
  align-items: center;
  gap: 12px;
  flex: none;
}

.navbar-apelido {
  font-family: 'Cinzel', serif;
  font-size: 0.85rem;
  font-weight: 600;
  color: var(--bone);
  max-width: 160px;
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
}

.navbar-entrar,
.navbar-sair {
  color: var(--tribal-yellow);
  text-decoration: none;
  font-family: 'Cinzel', serif;
  font-size: 0.8rem;
  font-weight: 600;
  text-transform: uppercase;
  letter-spacing: 1.2px;
  padding: 8px 14px;
  background: none;
  border: 1.5px solid var(--jungle-green);
  border-radius: 6px;
  cursor: pointer;
  transition: background-color 0.25s ease, border-color 0.25s ease;
}

.navbar-entrar:hover,
.navbar-sair:hover {
  background: var(--tribal-red);
  border-color: var(--tribal-red);
  color: var(--bone);
}

/* ===== Responsivo ===== */
@media (max-width: 768px) {
  .navbar-container {
    flex-wrap: wrap;
    padding: 10px 16px;
    gap: 10px;
  }

  .navbar-logo-text {
    font-size: 1.2rem;
  }

  .navbar-mini-logo {
    width: 30px;
    height: 30px;
  }

  .navbar-right {
    width: 100%;
    justify-content: space-between;
    flex-wrap: wrap;
    gap: 10px;
  }

  .navbar-icon-btn {
    width: 38px;
    height: 38px;
    font-size: 1.1rem;
  }

  .navbar-icon-svg {
    width: 18px;
    height: 18px;
  }
}
</style>

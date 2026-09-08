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
            <span aria-hidden="true">🏠</span>
          </RouterLink>
          <button class="navbar-icon-btn" title="Rolador de dados" @click="rolagemAberta = true">
            <span aria-hidden="true">🎲</span>
          </button>
          <RouterLink v-if="auth.estaLogado" to="/personagens" class="navbar-icon-btn" title="Meus personagens">
            <span aria-hidden="true">📜</span>
          </RouterLink>

          <div v-if="auth.estaLogado" class="navbar-conta" ref="contaMenuEl">
            <button
                class="navbar-icon-btn"
                title="Conta"
                :aria-expanded="contaAberta"
                @click="alternarConta"
            >
              <span aria-hidden="true">⚙️</span>
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
  --jungle-void: #0b2013;
  --jungle-darkest: #071a0f;
  --jungle-dark: #0e2818;
  --jungle-moss: #1a3d26;
  --jungle-green: #2e7d4f;
  --tribal-red: #b8362f;
  --tribal-gold: #c9a227;
  --tribal-yellow: #e8c14a;
  --bone: #f2ede1;
  --pale-green: #a8c4a2;

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
  box-shadow: 0 4px 20px rgba(0, 0, 0, 0.75), 0 1px 0 rgba(201, 162, 39, 0.1);
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
  text-shadow: 2px 2px 6px rgba(0, 0, 0, 0.85), 0 0 20px rgba(46, 125, 79, 0.4);
  letter-spacing: 1px;
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
  transition: color 0.3s ease, text-shadow 0.3s ease;
}

.navbar-logo:hover .navbar-logo-text {
  color: var(--bone);
  text-shadow: 0 0 15px rgba(232, 193, 74, 0.6), 0 0 35px rgba(46, 125, 79, 0.5);
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
  background: rgba(46, 125, 79, 0.14);
  border: 1.5px solid var(--jungle-green);
  border-radius: 8px;
  font-size: 1.25rem;
  color: var(--pale-green);
  text-decoration: none;
  cursor: pointer;
  transition: background-color 0.25s ease, border-color 0.25s ease, transform 0.15s ease;
}

.navbar-icon-btn:hover {
  background: rgba(46, 125, 79, 0.32);
  border-color: var(--tribal-gold);
  transform: translateY(-1px);
}

.navbar-icon-btn.router-link-active {
  border-color: var(--tribal-gold);
  background: rgba(201, 162, 39, 0.22);
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
  background: rgba(46, 125, 79, 0.2);
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
}
</style>

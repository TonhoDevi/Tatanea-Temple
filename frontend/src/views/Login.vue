<template>
  <div class="acesso-page">
    <div class="acesso-top-band" aria-hidden="true"></div>

    <header class="acesso-header">
      <RouterLink to="/" class="acesso-back">← Templo de Tatânea</RouterLink>
      <span class="acesso-kicker">Acesso</span>
    </header>

    <main class="acesso-main">
      <div class="acesso-strip acesso-strip-left" aria-hidden="true"></div>
      <div class="acesso-strip acesso-strip-right" aria-hidden="true"></div>

      <div class="acesso-frame">
        <span class="acesso-frame-inner" aria-hidden="true"></span>
        <span class="acesso-frame-band acesso-frame-band-top" aria-hidden="true"></span>
        <span class="acesso-frame-band acesso-frame-band-bottom" aria-hidden="true"></span>

        <div class="acesso-body">
          <div class="acesso-heading">
            <p class="acesso-eyebrow">Templo de Tatânea</p>
            <h1 class="acesso-title">Entrar</h1>
            <p class="acesso-sub">A mata só abre caminho para quem já foi nomeado.</p>
          </div>

          <div class="acesso-tabs">
            <span class="acesso-tab acesso-tab-active">Entrar</span>
            <RouterLink to="/registro" class="acesso-tab">Iniciação</RouterLink>
          </div>

          <form class="acesso-form" @submit.prevent="entrar">
            <label class="acesso-field">
              <span class="acesso-field-label">E-mail</span>
              <input v-model="email" type="email" placeholder="voce@mesa.com" required />
            </label>

            <label class="acesso-field">
              <span class="acesso-field-label">Senha ritual</span>
              <input v-model="senha" type="password" placeholder="••••••••" required />
            </label>

            <div class="acesso-row">
              <label class="acesso-checkbox">
                <input v-model="lembrar" type="checkbox" />
                <span>Lembrar de mim</span>
              </label>
              <a href="#" class="acesso-link-muted" @click.prevent>Esqueci a senha</a>
            </div>

            <p v-if="erro" class="acesso-erro">{{ erro }}</p>

            <button class="acesso-cta acesso-cta-login" type="submit" :disabled="carregando">
              {{ carregando ? 'Atravessando...' : 'Atravessar' }}
            </button>

            <div class="acesso-divider" aria-hidden="true">
              <span></span><i></i><span></span>
            </div>

            <p class="acesso-switch">
              Primeira vez na mata? <RouterLink to="/registro">peça iniciação</RouterLink>
            </p>
          </form>
        </div>
      </div>

      <div class="acesso-art">[ folhagem cobrindo a base do pórtico ]</div>
    </main>

    <footer class="acesso-footer">
      <div class="acesso-footer-band" aria-hidden="true"></div>
      <div class="acesso-footer-inner">
        <span>Sistema homebrew para D&amp;D 5e.</span>
        <span class="acesso-footer-links">
          <a href="#" @click.prevent>Erratas</a>
          <a href="#" @click.prevent>Mesa aberta</a>
        </span>
      </div>
    </footer>
  </div>
</template>

<script setup>
import { ref } from 'vue';
import { useRouter } from 'vue-router';
import { useAuthStore } from '../stores/authStore';

const email = ref('');
const senha = ref('');
const lembrar = ref(false);
const erro = ref(null);
const carregando = ref(false);

const auth = useAuthStore();
const router = useRouter();

async function entrar() {
  erro.value = null;
  carregando.value = true;
  try {
    await auth.login(email.value, senha.value);
    router.push('/personagens');
  } catch (e) {
    erro.value = e.response?.data || 'Não foi possível entrar. Confira e-mail e senha.';
  } finally {
    carregando.value = false;
  }
}
</script>

<style scoped>
.acesso-page {
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

  min-height: 100vh;
  display: flex;
  flex-direction: column;
  font-family: 'Crimson Text', Georgia, serif;
  background-color: var(--jungle-void);
  background-image: repeating-linear-gradient(0deg, rgba(10, 28, 17, 0.5) 0 22px, transparent 22px 44px),
  radial-gradient(120% 90% at 50% 6%, var(--jungle-moss) 0, var(--jungle-void) 62%, var(--jungle-darkest) 100%);
  color: var(--bone);
}

.acesso-top-band {
  height: 20px;
  background-image: repeating-linear-gradient(
      90deg,
      var(--tribal-gold) 0 4px,
      transparent 4px 10px,
      var(--tribal-red) 10px 14px,
      transparent 14px 26px
  );
  opacity: 0.8;
}

.acesso-header {
  display: flex;
  align-items: center;
  justify-content: space-between;
  gap: 16px;
  padding: 14px clamp(16px, 4vw, 44px);
}

.acesso-back {
  font-family: 'Cinzel', serif;
  font-weight: 700;
  font-size: 13px;
  letter-spacing: 0.22em;
  text-transform: uppercase;
  color: var(--tribal-gold);
  text-decoration: none;
}

.acesso-back:hover {
  color: var(--tribal-yellow);
}

.acesso-kicker {
  font-family: 'Cinzel', serif;
  font-size: 10px;
  letter-spacing: 0.24em;
  text-transform: uppercase;
  color: var(--pale-green);
}

.acesso-main {
  flex: 1;
  position: relative;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  gap: 26px;
  padding: clamp(28px, 5vw, 70px) clamp(16px, 5vw, 48px);
}

.acesso-strip {
  position: absolute;
  top: 0;
  bottom: 0;
  width: clamp(20px, 6vw, 80px);
  background-image: repeating-linear-gradient(0deg, rgba(35, 110, 71, 0.5) 0 2px, transparent 2px 16px);
  pointer-events: none;
}

.acesso-strip-left {
  left: 0;
}

.acesso-strip-right {
  right: 0;
  background-image: repeating-linear-gradient(0deg, rgba(35, 110, 71, 0.5) 0 2px, transparent 2px 16px);
}

.acesso-frame {
  position: relative;
  z-index: 2;
  width: 100%;
  max-width: 460px;
  padding: clamp(24px, 4vw, 36px) clamp(20px, 3.4vw, 30px);
  border: 2px solid var(--tribal-gold);
  background: rgba(9, 26, 16, 0.92);
  box-shadow: 0 24px 70px rgba(0, 0, 0, 0.5);
}

.acesso-frame-inner {
  position: absolute;
  inset: 7px;
  border: 1px solid rgba(140, 59, 43, 0.7);
  pointer-events: none;
}

.acesso-frame-band {
  position: absolute;
  left: -2px;
  right: -2px;
  height: 9px;
  background-image: repeating-linear-gradient(
      90deg,
      var(--tribal-gold) 0 8px,
      var(--tribal-red) 8px 12px,
      transparent 12px 24px
  );
}

.acesso-frame-band-top {
  top: -2px;
}

.acesso-frame-band-bottom {
  bottom: -2px;
}

.acesso-body {
  position: relative;
  display: flex;
  flex-direction: column;
  gap: 18px;
}

.acesso-heading {
  text-align: center;
}

.acesso-eyebrow {
  margin: 0;
  font-family: 'Cinzel', serif;
  font-size: 10px;
  letter-spacing: 0.36em;
  text-transform: uppercase;
  color: var(--pale-green);
}

.acesso-title {
  margin: 8px 0 0;
  font-family: 'Cinzel Decorative', 'Cinzel', serif;
  font-weight: 900;
  font-size: clamp(28px, 6vw, 38px);
  line-height: 1;
  color: var(--bone);
}

.acesso-sub {
  margin: 10px 0 0;
  font-size: 16px;
  line-height: 1.5;
  color: var(--pale-green);
}

.acesso-tabs {
  display: flex;
  border: 1px solid var(--jungle-green);
}

.acesso-tab {
  flex: 1;
  padding: 11px;
  border: 0;
  background: transparent;
  color: var(--pale-green);
  font-family: 'Cinzel', serif;
  font-weight: 600;
  font-size: 10px;
  letter-spacing: 0.2em;
  text-transform: uppercase;
  text-align: center;
  text-decoration: none;
  cursor: pointer;
}

.acesso-tab:hover {
  color: var(--tribal-yellow);
}

.acesso-tab-active {
  background: var(--jungle-green);
  color: var(--bone);
  cursor: default;
}

.acesso-tab-active:hover {
  color: var(--bone);
}

.acesso-form {
  display: flex;
  flex-direction: column;
  gap: 18px;
}

.acesso-field {
  display: flex;
  flex-direction: column;
  gap: 6px;
}

.acesso-field-label {
  font-family: 'Cinzel', serif;
  font-size: 10px;
  letter-spacing: 0.2em;
  text-transform: uppercase;
  color: var(--tribal-gold);
}

.acesso-field input {
  width: 100%;
  box-sizing: border-box;
  padding: 12px;
  background: var(--bg-card);
  border: 1px solid var(--jungle-green);
  color: var(--bone);
  font-family: 'Crimson Text', Georgia, serif;
  font-size: 17px;
  outline: none;
}

.acesso-field input:focus {
  border-color: var(--tribal-yellow);
}

.acesso-row {
  display: flex;
  justify-content: space-between;
  align-items: center;
  gap: 10px;
  font-size: 15px;
  color: var(--pale-green);
}

.acesso-checkbox {
  display: flex;
  gap: 8px;
  align-items: center;
  cursor: pointer;
}

.acesso-checkbox input {
  width: 14px;
  height: 14px;
  accent-color: var(--tribal-gold);
}

.acesso-link-muted {
  color: var(--pale-green);
  text-decoration: none;
}

.acesso-link-muted:hover {
  color: var(--tribal-yellow);
}

.acesso-erro {
  margin: 0;
  font-size: 14px;
  color: color-mix(in srgb, var(--tribal-red) 60%, white);
}

.acesso-cta {
  padding: 15px;
  border: 1px solid var(--tribal-yellow);
  color: var(--bone);
  font-family: 'Cinzel', serif;
  font-weight: 700;
  font-size: 12px;
  letter-spacing: 0.2em;
  text-transform: uppercase;
  cursor: pointer;
  transition: background-color 0.2s ease;
}

.acesso-cta:disabled {
  opacity: 0.6;
  cursor: not-allowed;
}

.acesso-cta-login {
  background: var(--jungle-green);
}

.acesso-cta-login:hover:not(:disabled) {
  background: var(--tribal-red);
}

.acesso-cta-register {
  background: var(--tribal-red);
}

.acesso-cta-register:hover:not(:disabled) {
  background: var(--jungle-green);
}

.acesso-divider {
  display: flex;
  align-items: center;
  gap: 10px;
}

.acesso-divider span {
  flex: 1;
  height: 1px;
  background: var(--jungle-green);
}

.acesso-divider i {
  width: 9px;
  height: 9px;
  background: var(--tribal-red);
  transform: rotate(45deg);
}

.acesso-switch {
  margin: 0;
  text-align: center;
  font-size: 15px;
  color: var(--pale-green);
}

.acesso-switch a {
  color: var(--tribal-gold);
  text-decoration: none;
}

.acesso-switch a:hover {
  color: var(--tribal-yellow);
}

.acesso-art {
  position: relative;
  z-index: 2;
  width: 100%;
  max-width: 460px;
  height: 76px;
  box-sizing: border-box;
  border: 1px solid var(--jungle-green);
  display: flex;
  align-items: flex-end;
  padding: 9px;
  font-family: ui-monospace, Menlo, monospace;
  font-size: 10px;
  letter-spacing: 0.06em;
  color: var(--pale-green);
}

.acesso-footer {
  border-top: 1px solid var(--jungle-green);
  background: var(--jungle-darkest);
}

.acesso-footer-band {
  height: 22px;
  background-image: repeating-linear-gradient(
      90deg,
      var(--tribal-gold) 0 5px,
      transparent 5px 11px,
      var(--tribal-red) 11px 16px,
      transparent 16px 30px
  ),
  repeating-linear-gradient(0deg, rgba(35, 110, 71, 0.4) 0 2px, transparent 2px 8px);
}

.acesso-footer-inner {
  padding: 16px clamp(16px, 4vw, 44px);
  display: flex;
  flex-wrap: wrap;
  gap: 12px 26px;
  justify-content: space-between;
  font-size: 15px;
  color: var(--pale-green);
}

.acesso-footer-links {
  display: flex;
  gap: 20px;
}

.acesso-footer-links a {
  color: var(--tribal-gold);
  text-decoration: none;
}

.acesso-footer-links a:hover {
  color: var(--tribal-yellow);
}
</style>

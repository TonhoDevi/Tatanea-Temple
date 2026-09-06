<template>
  <div class="auth-page">
    <div class="auth-card">
      <h1 class="auth-title">Entrar</h1>

      <form @submit.prevent="entrar">
        <div class="input-group">
          <label class="input-label">E-mail</label>
          <input v-model="email" type="email" required />
        </div>
        <div class="input-group">
          <label class="input-label">Senha</label>
          <input v-model="senha" type="password" required />
        </div>

        <p v-if="erro" class="auth-erro">{{ erro }}</p>

        <button class="btn btn-primary" type="submit" :disabled="carregando">
          {{ carregando ? 'Entrando...' : 'Entrar' }}
        </button>
      </form>

      <p class="auth-link">
        Não tem conta? <RouterLink to="/registro">Cadastre-se</RouterLink>
      </p>
    </div>
  </div>
</template>

<script setup>
import { ref } from 'vue';
import { useRouter } from 'vue-router';
import { useAuthStore } from '../stores/authStore';

const email = ref('');
const senha = ref('');
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
.auth-page {
  min-height: 70vh;
  display: flex;
  align-items: center;
  justify-content: center;
  padding: 2rem 1rem;
}

.auth-card {
  background: #201735;
  border: 1px solid #4a3a6a;
  border-radius: 12px;
  padding: 2rem;
  width: 100%;
  max-width: 380px;
}

.auth-title {
  font-family: 'Pirata One', cursive;
  font-size: 2rem;
  text-align: center;
  color: #e8e0f5;
  margin-bottom: 1.5rem;
}

.input-group {
  margin-bottom: 1rem;
}

.input-label {
  display: block;
  font-family: 'Cinzel', serif;
  font-size: 0.75rem;
  letter-spacing: 0.05em;
  color: #c9bce8;
  margin-bottom: 0.3rem;
}

.input-group input {
  width: 100%;
  padding: 0.6rem 0.8rem;
  border-radius: 6px;
  border: 1px solid #5a4a7a;
  background: #1a1330;
  color: #e8e0f5;
  box-sizing: border-box;
}

.btn {
  width: 100%;
  padding: 0.7rem;
  border-radius: 6px;
  border: none;
  font-family: 'Cinzel', serif;
  cursor: pointer;
  margin-top: 0.5rem;
}

.btn-primary {
  background: #8a6ac0;
  color: #fff;
}

.btn-primary:disabled {
  opacity: 0.6;
  cursor: not-allowed;
}

.auth-erro {
  color: #e87070;
  font-size: 0.85rem;
  margin-bottom: 0.5rem;
}

.auth-link {
  text-align: center;
  margin-top: 1rem;
  font-size: 0.85rem;
  color: #c9bce8;
}

.auth-link a {
  color: #8a6ac0;
}
</style>
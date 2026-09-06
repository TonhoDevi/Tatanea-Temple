<template>
  <div class="dado-overlay" @click.self="$emit('fechar')">
    <div class="dado-modal">
      <button class="fechar" @click="$emit('fechar')">×</button>
      <h2 class="titulo">🎲 Rolador de Dados</h2>

      <div class="grid-dados">
        <button v-for="d in FACES" :key="d" class="btn-dado" @click="rolar(d)">d{{ d }}</button>
      </div>

      <div class="config-extra">
        <label>
          Quantidade
          <input type="number" v-model.number="quantidade" min="1" max="20" />
        </label>
        <label>
          Modificador
          <input type="number" v-model.number="modificador" />
        </label>
      </div>

      <div v-if="ultimaRolagem" class="resultado">
        <div class="resultado-total">{{ ultimaRolagem.total }}</div>
        <div class="resultado-detalhe">
          {{ ultimaRolagem.descricao }} = [{{ ultimaRolagem.valores.join(', ') }}]
          <span v-if="modificador">{{ modificador >= 0 ? '+' : '' }}{{ modificador }}</span>
        </div>
      </div>

      <div v-if="historico.length" class="historico">
        <div class="historico-titulo">Histórico</div>
        <div v-for="(h, i) in historico" :key="i" class="historico-item">
          {{ h.descricao }} → <strong>{{ h.total }}</strong>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref } from 'vue';

const FACES = [4, 6, 8, 10, 12, 20, 100];

const quantidade = ref(1);
const modificador = ref(0);
const ultimaRolagem = ref(null);
const historico = ref([]);

function rolar(faces) {
  const valores = [];
  for (let i = 0; i < quantidade.value; i++) {
    valores.push(1 + Math.floor(Math.random() * faces));
  }
  const soma = valores.reduce((a, b) => a + b, 0);
  const total = soma + (modificador.value || 0);
  const descricao = `${quantidade.value}d${faces}`;

  ultimaRolagem.value = { descricao, valores, total };
  historico.value.unshift({ descricao, total });
  if (historico.value.length > 8) historico.value.pop();
}

defineEmits(['fechar']);
</script>

<style scoped>
.dado-overlay {
  position: fixed;
  inset: 0;
  background: rgba(0, 0, 0, 0.7);
  display: flex;
  align-items: center;
  justify-content: center;
  z-index: 300;
  padding: 1rem;
}

.dado-modal {
  background: #1a1330;
  border: 1px solid #4a3a6a;
  border-radius: 12px;
  padding: 1.5rem;
  width: 100%;
  max-width: 360px;
  position: relative;
  color: #e8e0f5;
}

.fechar {
  position: absolute;
  top: 0.6rem;
  right: 0.9rem;
  background: none;
  border: none;
  color: #e8e0f5;
  font-size: 1.4rem;
  cursor: pointer;
}

.titulo {
  font-family: 'Pirata One', cursive;
  text-align: center;
  margin: 0 0 1rem;
}

.grid-dados {
  display: grid;
  grid-template-columns: repeat(4, 1fr);
  gap: 0.5rem;
  margin-bottom: 1rem;
}

.btn-dado {
  background: #362a54;
  border: 1px solid #5a4a7a;
  color: #e8e0f5;
  border-radius: 8px;
  padding: 0.6rem 0;
  font-family: 'Cinzel', serif;
  cursor: pointer;
}

.btn-dado:hover {
  background: #4a3a6a;
}

.config-extra {
  display: flex;
  gap: 1rem;
  margin-bottom: 1rem;
}

.config-extra label {
  flex: 1;
  display: flex;
  flex-direction: column;
  font-size: 0.7rem;
  gap: 0.2rem;
}

.config-extra input {
  padding: 0.4rem;
  border-radius: 6px;
  border: 1px solid #5a4a7a;
  background: #201735;
  color: #e8e0f5;
}

.resultado {
  text-align: center;
  background: #201735;
  border: 1px solid #4a3a6a;
  border-radius: 8px;
  padding: 1rem;
  margin-bottom: 1rem;
}

.resultado-total {
  font-family: 'Cinzel', serif;
  font-size: 2.2rem;
  color: #e8c060;
}

.resultado-detalhe {
  font-size: 0.75rem;
  opacity: 0.8;
}

.historico-titulo {
  font-family: 'Cinzel', serif;
  font-size: 0.75rem;
  opacity: 0.7;
  margin-bottom: 0.4rem;
}

.historico-item {
  font-size: 0.8rem;
  padding: 0.15rem 0;
  opacity: 0.85;
}
</style>
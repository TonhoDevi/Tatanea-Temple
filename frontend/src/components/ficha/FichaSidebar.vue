<template>
  <aside class="ficha-sidebar">
    <div class="fc-box fc-identity">
      <div class="fc-portrait">
        <img v-if="ficha.imagemUrl" :src="ficha.imagemUrl" :alt="ficha.nome" />
        <span v-else>[ retrato ]</span>
      </div>
      <input type="text" class="fc-name-input" v-model="ficha.nome" placeholder="Nome do personagem" @input="agendarSalvar" />
      <div class="fc-identity-meta">Nível {{ ficha.nivel }} · {{ classeNomeAtual || 'sem classe' }}</div>

      <label class="fc-field">
        <span class="fc-mini-label">Raça</span>
        <select v-model="ficha.racaId" class="fc-select" @change="selecionarRaca">
          <option :value="null">Nenhuma</option>
          <option v-for="raca in racasDisponiveis" :key="raca.id" :value="raca.id">{{ raca.nome }}</option>
        </select>
      </label>
      <label class="fc-field">
        <span class="fc-mini-label">Classe</span>
        <select v-model="ficha.classeId" class="fc-select" @change="agendarSalvar">
          <option :value="null">Nenhuma</option>
          <option v-for="classe in classesDisponiveis" :key="classe.id" :value="classe.id">{{ classe.nome }}</option>
        </select>
      </label>

      <div class="fc-row-tight">
        <span class="fc-mini-label">Nível</span>
        <div class="qty-spinner">
          <button class="qty-btn" @click="alterar('nivel', -1, 1)">−</button>
          <input type="number" class="fc-mini-number" v-model.number="ficha.nivel" @input="agendarSalvar" />
          <button class="qty-btn" @click="alterar('nivel', 1)">+</button>
        </div>
      </div>
      <div class="fc-row-tight">
        <span class="fc-mini-label">Bônus de proficiência</span>
        <input type="number" class="fc-mini-number-plain" v-model.number="bonusProficiencia" />
      </div>

      <label class="fc-field">
        <span class="fc-mini-label">Jogador</span>
        <input type="text" v-model="ficha.nomeJogador" @input="agendarSalvar" />
      </label>
      <label class="fc-field">
        <span class="fc-mini-label">Antecedente</span>
        <input type="text" v-model="ficha.antecedente" @input="agendarSalvar" />
      </label>
      <label class="fc-field">
        <span class="fc-mini-label">Tendência</span>
        <input type="text" v-model="ficha.tendencia" @input="agendarSalvar" />
      </label>
    </div>

    <div class="fc-box">
      <RouterLink class="fc-btn fc-btn-block" to="/personagens">← Meus personagens</RouterLink>
      <button class="fc-btn fc-btn-block" @click="exportarJSON">Exportar JSON</button>
      <button class="fc-btn fc-btn-block" @click="$refs.importInput.click()">Importar JSON</button>
      <input ref="importInput" type="file" accept=".json" style="display:none" @change="importarJSON" />
      <button class="fc-btn fc-btn-block fc-btn-danger" @click="excluir">Excluir personagem</button>
    </div>
  </aside>
</template>

<script setup>
import { computed } from 'vue';
import { useFichaPersonagem } from '../../composables/useFichaPersonagem';

const {
  ficha, bonusProficiencia, racasDisponiveis, classesDisponiveis,
  agendarSalvar, alterar, selecionarRaca,
  exportarJSON, importarJSON, excluir,
} = useFichaPersonagem();

const classeNomeAtual = computed(
    () => classesDisponiveis.value.find((c) => c.id === ficha.value.classeId)?.nome
);
</script>

<style scoped>
.ficha-sidebar {
  flex: 0 0 260px;
  min-width: 0;
  display: flex;
  flex-direction: column;
  gap: 14px;
  position: sticky;
  top: 76px;
}

.fc-portrait {
  width: 100%;
  aspect-ratio: 3 / 4;
  border: 1px solid var(--border-gold);
  border-radius: 6px;
  background: linear-gradient(180deg, var(--bg-card) 0%, var(--bg-sub) 100%);
  display: flex;
  align-items: flex-end;
  justify-content: center;
  padding: 6px;
  font-family: ui-monospace, Menlo, monospace;
  font-size: 10px;
  color: var(--pale-green);
  overflow: hidden;
}

.fc-portrait img {
  width: 100%;
  height: 100%;
  object-fit: cover;
}

.fc-name-input {
  font-family: 'Cinzel Decorative', 'Cinzel', serif;
  font-weight: 700;
  font-size: 18px;
  text-align: center;
}

.fc-identity-meta {
  text-align: center;
  font-family: ui-monospace, Menlo, monospace;
  font-size: 10px;
  color: var(--pale-green);
}

.fc-row-tight {
  display: flex;
  align-items: center;
  justify-content: space-between;
  gap: 8px;
}

.fc-mini-number-plain {
  width: 56px;
  text-align: center;
  -moz-appearance: textfield;
  appearance: textfield;
}

.fc-mini-number-plain::-webkit-outer-spin-button,
.fc-mini-number-plain::-webkit-inner-spin-button {
  -webkit-appearance: none;
  margin: 0;
}

@media (max-width: 900px) {
  .ficha-sidebar {
    flex: none;
    width: 100%;
    position: static;
  }
}
</style>
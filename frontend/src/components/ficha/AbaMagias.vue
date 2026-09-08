<template>
  <div>
    <div class="fc-box" v-for="nivel in 10" :key="nivel - 1">
      <div class="fc-box-title-row">
        <div class="fc-box-title" style="margin: 0">{{ nivel === 1 ? 'Truques' : `Nível ${nivel - 1}` }}</div>
        <div v-if="nivel > 1" class="fc-slot-inputs">
          <label>Slots <input type="number" class="fc-mini-number" v-model.number="slotDe(nivel - 1).total" min="0" /></label>
          <label>Restantes <input type="number" class="fc-mini-number" v-model.number="slotDe(nivel - 1).restantes" min="0" /></label>
        </div>
      </div>
      <div v-for="(m, i) in magiasPorNivel(nivel - 1)" :key="i" class="fc-magia-card">
        <div class="fc-magia-top">
          <input type="text" v-model="m.nome" placeholder="Nome da magia" class="fc-magia-nome" @input="agendarSalvar" />
          <div class="fc-magia-meta">
            <input type="text" v-model="extraDe(m).tempoConjuracao" placeholder="Tempo de conjuração" class="fc-magia-tempo" />
            <label class="fc-checkbox-row fc-col-small">
              <input type="checkbox" v-model="m.preparada" @change="agendarSalvar" />
              Preparada
            </label>
            <button class="fc-btn-remove" @click="removerMagia(m)">×</button>
          </div>
        </div>
        <textarea v-model="extraDe(m).descricao" placeholder="Descrição" class="fc-magia-descricao"></textarea>
      </div>
      <button class="fc-btn-add" @click="adicionarMagia(nivel - 1)">+ Adicionar</button>
    </div>
  </div>
</template>

<script setup>
import { useFichaPersonagem } from '../../composables/useFichaPersonagem';

const {
  agendarSalvar, magiasPorNivel, slotDe, extraDe, adicionarMagia, removerMagia,
} = useFichaPersonagem();
</script>

<style scoped>
.fc-box-title-row {
  display: flex;
  justify-content: space-between;
  align-items: center;
  flex-wrap: wrap;
  gap: 8px;
}

.fc-slot-inputs {
  display: flex;
  align-items: center;
  gap: 10px;
}

.fc-slot-inputs label {
  display: flex;
  align-items: center;
  gap: 6px;
  font-family: 'Cinzel', serif;
  font-size: 9px;
  letter-spacing: 0.1em;
  text-transform: uppercase;
  color: var(--pale-green);
}

.fc-slot-inputs .fc-mini-number {
  width: 44px;
}

.fc-magia-card {
  border: 1px solid rgba(46, 125, 79, 0.6);
  padding: 10px;
  display: flex;
  flex-direction: column;
  gap: 6px;
}

.fc-magia-top {
  display: flex;
  align-items: center;
  gap: 10px;
  flex-wrap: wrap;
}

.fc-magia-nome {
  flex: 1;
  min-width: 140px;
  font-weight: 700;
}

.fc-magia-meta {
  display: flex;
  align-items: center;
  gap: 10px;
  flex: none;
}

.fc-magia-tempo {
  width: 160px;
}

.fc-magia-descricao {
  min-height: 44px;
  font-size: 13px;
}
</style>
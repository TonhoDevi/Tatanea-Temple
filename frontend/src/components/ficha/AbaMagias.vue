<template>
  <div>
    <div class="fc-box fc-magia-header">
      <div class="fc-box-title">Conjuração</div>
      <div class="fc-magia-header-linha">
        <label class="fc-magia-campo fc-magia-campo-crescer">
          <span class="fc-mini-label">Atributo de Magia</span>
          <select v-model="ficha.atributoMagia" class="fc-select" @change="agendarSalvar">
            <option :value="null">Nenhum</option>
            <option v-for="attr in ATRIBUTOS" :key="attr.chave" :value="attr.chave">{{ attr.nome }}</option>
          </select>
        </label>

        <div class="fc-magia-stat">
          <span class="fc-mini-label">Bônus de Magia</span>
          <span class="fc-magia-stat-valor">{{ formatarMod(bonusMagiaTotal) }}</span>
        </div>

        <div class="fc-magia-stat">
          <span class="fc-mini-label">CD de Magia</span>
          <span class="fc-magia-stat-valor">{{ cdMagiaTotal }}</span>
        </div>

        <label class="fc-magia-campo">
          <span class="fc-mini-label">Bônus extra</span>
          <input type="number" class="fc-mini-number" v-model.number="ficha.bonusMagiaExtra" placeholder="+0" @input="agendarSalvar" />
        </label>
      </div>
      <p class="fc-hint">Bônus de Magia e CD somam atributo + proficiência automaticamente; o bônus extra (item, talento etc.) entra nos dois.</p>
    </div>

    <div class="fc-box" v-for="nivel in 10" :key="nivel - 1">
      <div class="fc-box-title-row">
        <div class="fc-box-title" style="margin: 0">{{ nivel === 1 ? 'Truques' : `Nível ${nivel - 1}` }}</div>
        <div v-if="nivel > 1" class="fc-slot-inputs">
          <label>Slots <input type="number" class="fc-mini-number" v-model.number="slotDe(nivel - 1).total" min="0" @input="agendarSalvar" /></label>
          <label>Restantes <input type="number" class="fc-mini-number" v-model.number="slotDe(nivel - 1).restantes" min="0" @input="agendarSalvar" /></label>
        </div>
      </div>
      <div v-for="(m, i) in magiasPorNivel(nivel - 1)" :key="i" class="fc-magia-card">
        <div class="fc-magia-top">
          <input type="text" v-model="m.nome" placeholder="Nome da magia" class="fc-magia-nome" @input="agendarSalvar" />
          <div class="fc-magia-meta">
            <input type="text" v-model="m.tempoConjuracao" placeholder="Tempo de conjuração" class="fc-magia-tempo" @input="agendarSalvar" />
            <label class="fc-checkbox-row fc-col-small">
              <input type="checkbox" v-model="m.preparada" @change="agendarSalvar" />
              Preparada
            </label>
            <button class="fc-btn-remove" @click="removerMagia(m)">×</button>
          </div>
        </div>
        <textarea v-model="m.descricao" placeholder="Descrição" class="fc-magia-descricao" @input="agendarSalvar"></textarea>
      </div>
      <button class="fc-btn-add" @click="adicionarMagia(nivel - 1)">+ Adicionar</button>
    </div>
  </div>
</template>

<script setup>
import { useFichaPersonagem } from '../../composables/useFichaPersonagem';

const {
  ficha, agendarSalvar, magiasPorNivel, slotDe, adicionarMagia, removerMagia,
  ATRIBUTOS, formatarMod, bonusMagiaTotal, cdMagiaTotal,
} = useFichaPersonagem();
</script>

<style scoped>
.fc-magia-header-linha {
  display: flex;
  flex-wrap: wrap;
  gap: 14px;
  align-items: flex-end;
}

.fc-magia-campo {
  display: flex;
  flex-direction: column;
  gap: 4px;
}

.fc-magia-campo-crescer {
  flex: 1;
  min-width: 160px;
}

.fc-magia-stat {
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 4px;
  padding: 0 10px;
  border-left: 1px solid var(--border-color);
}

.fc-magia-stat-valor {
  font-family: 'Cinzel Decorative', 'Cinzel', serif;
  font-weight: 700;
  font-size: 22px;
  color: var(--accent-title);
}

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
  border: 1px solid var(--border-color);
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
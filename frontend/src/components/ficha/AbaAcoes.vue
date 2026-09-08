<template>
  <div>
    <div class="fc-box">
      <div class="fc-badge-panel">
        <span class="fc-badge-side-label">Inspiração</span>
        <div class="fc-badge-diamonds">
          <button
              type="button"
              class="fc-badge-toggle"
              :class="{ 'fc-badge-toggle-active': ficha.inspiracao }"
              @click="alternarBooleano('inspiracao')"
              title="Inspiração"
          >
            <span class="fc-badge-diamond">
              <span class="fc-badge-diamond-inner"></span>
              <span class="fc-badge-icon">✦</span>
            </span>
          </button>
          <button
              type="button"
              class="fc-badge-toggle"
              :class="{ 'fc-badge-toggle-active': ficha.pontoHeroico }"
              @click="alternarBooleano('pontoHeroico')"
              title="Ponto heroico"
          >
            <span class="fc-badge-diamond">
              <span class="fc-badge-diamond-inner"></span>
              <span class="fc-badge-icon">⛨</span>
            </span>
          </button>
        </div>
        <span class="fc-badge-side-label">Ponto heroico</span>
      </div>
    </div>

    <div class="fc-box">
      <div class="fc-box-title">Ataques</div>
      <div v-for="(a, i) in ficha.ataques" :key="i" class="fc-list-row">
        <input type="text" v-model="a.nome" placeholder="Nome" @input="agendarSalvar" />
        <input type="text" v-model="a.bonusAtaque" placeholder="Bônus" class="fc-col-small" @input="agendarSalvar" />
        <input type="text" v-model="a.dano" placeholder="Dano" class="fc-col-small" @input="agendarSalvar" />
        <input type="text" v-model="a.tipoDano" placeholder="Tipo" class="fc-col-small" @input="agendarSalvar" />
        <button class="fc-btn-remove" @click="removerItem(ficha.ataques, i)">×</button>
      </div>
      <button class="fc-btn-add" @click="adicionarAtaque">+ Adicionar ataque</button>
    </div>

    <div class="fc-box">
      <div class="fc-box-title">Deslocamento</div>
      <div class="fc-field-grid">
        <label class="fc-field">
          <span class="fc-mini-label">Andar</span>
          <input type="text" v-model="ficha.deslocamento" @input="agendarSalvar" />
        </label>
        <label class="fc-field">
          <span class="fc-mini-label">Nadar</span>
          <input type="text" v-model="ficha.deslocNadar" @input="agendarSalvar" />
        </label>
        <label class="fc-field">
          <span class="fc-mini-label">Voar</span>
          <input type="text" v-model="ficha.deslocVoar" @input="agendarSalvar" />
        </label>
        <label class="fc-field">
          <span class="fc-mini-label">Escalar</span>
          <input type="text" v-model="ficha.deslocEscalar" @input="agendarSalvar" />
        </label>
        <label class="fc-field">
          <span class="fc-mini-label">Salto</span>
          <input type="text" v-model="ficha.salto" @input="agendarSalvar" />
        </label>
      </div>
    </div>
  </div>
</template>

<script setup>
import { useFichaPersonagem } from '../../composables/useFichaPersonagem';

const { ficha, agendarSalvar, alternarBooleano, removerItem, adicionarAtaque } = useFichaPersonagem();
</script>

<style scoped>
.fc-badge-panel {
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 16px;
  padding: 16px 12px;
  border: 1px solid rgba(46, 125, 79, 0.6);
}

.fc-badge-side-label {
  flex: 1;
  min-width: 0;
  font-family: 'Cinzel', serif;
  font-size: 11px;
  letter-spacing: 0.14em;
  text-transform: uppercase;
  color: var(--pale-green);
}

.fc-badge-side-label:first-child {
  text-align: right;
}

.fc-badge-side-label:last-child {
  text-align: left;
}

.fc-badge-diamonds {
  flex: none;
  display: flex;
}

.fc-badge-toggle {
  display: flex;
  align-items: center;
  justify-content: center;
  background: none;
  border: none;
  padding: 0;
  cursor: pointer;
}

.fc-badge-diamond {
  position: relative;
  width: 56px;
  height: 56px;
  display: flex;
  align-items: center;
  justify-content: center;
  transform: rotate(45deg);
  border: 2px solid rgba(168, 196, 162, 0.5);
  background: var(--jungle-void);
  transition: border-color 0.2s ease, background-color 0.2s ease, box-shadow 0.2s ease;
}

.fc-badge-diamond-inner {
  position: absolute;
  inset: 12px;
  border: 1.5px solid rgba(184, 54, 47, 0.7);
  transition: border-color 0.2s ease;
}

.fc-badge-icon {
  position: relative;
  z-index: 1;
  display: inline-block;
  transform: rotate(-45deg);
  font-size: 20px;
  line-height: 1;
  color: rgba(168, 196, 162, 0.6);
  transition: color 0.2s ease, text-shadow 0.2s ease;
}

.fc-badge-toggle:hover .fc-badge-diamond {
  border-color: var(--tribal-gold);
}

.fc-badge-toggle-active .fc-badge-diamond {
  border-color: var(--tribal-yellow);
  background: linear-gradient(135deg, var(--tribal-gold), var(--tribal-yellow));
  box-shadow: 0 0 16px 3px rgba(232, 193, 74, 0.65);
}

.fc-badge-toggle-active .fc-badge-diamond-inner {
  border-color: rgba(11, 32, 19, 0.7);
}

.fc-badge-toggle-active .fc-badge-icon {
  color: var(--jungle-void);
  text-shadow: 0 0 6px rgba(255, 255, 255, 0.6);
}
</style>
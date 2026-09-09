<template>
  <div>
    <div class="fc-box">
      <div class="fc-field-grid">
        <label class="fc-field">
          <span class="fc-mini-label">Raça</span>
          <select v-model="ficha.racaId" class="fc-select" @change="agendarSalvar">
            <option :value="null" disabled>Selecione uma raça...</option>
            <option v-for="raca in racasDisponiveis" :key="raca.id" :value="raca.id">{{ raca.nome }}</option>
          </select>
        </label>
        <label class="fc-field">
          <span class="fc-mini-label">Classe</span>
          <select v-model="ficha.classeId" class="fc-select" @change="agendarSalvar">
            <option value="" disabled>Selecione uma classe...</option>
            <option v-for="classe in OPCOES_CLASSE" :key="classe" :value="classe">{{ classe }}</option>
          </select>
        </label>
      </div>
    </div>

    <div class="fc-box">
      <div class="fc-box-title">Atributos & salvaguardas</div>
      <div class="fc-attr-cards">
        <div class="fc-attr-card" v-for="attr in ATRIBUTOS" :key="attr.chave">
          <div class="fc-attr-card-top">
            <span class="fc-attr-nome">{{ attr.nome }}</span>
            <label class="fc-hex-label" title="Proficiente em salvaguarda">
              <input
                  type="checkbox"
                  class="fc-save-check-hidden"
                  :checked="salvaguardaDe(attr.chave).proficiente"
                  @change="alternarSalvaguarda(attr.chave, $event.target.checked)"
              />
              <div class="fc-hex-box" :class="{ active: salvaguardaDe(attr.chave).proficiente }">
                <span class="fc-hex-star" v-if="salvaguardaDe(attr.chave).proficiente">★</span>
              </div>
            </label>
          </div>
          <div class="fc-attr-card-big" :class="{ 'fc-attr-card-big-save': salvaguardaDe(attr.chave).proficiente }">
            {{ formatarMod(valorSalvaguarda(attr)) }}
          </div>
          <div class="qty-spinner attr-stepper">
            <button class="qty-btn" @click="alterarAtributo(attr.chave, -1)">−</button>
            <input type="number" class="fc-mini-number" v-model.number="ficha[attr.chave]" @input="agendarSalvar" />
            <button class="qty-btn" @click="alterarAtributo(attr.chave, 1)">+</button>
          </div>
        </div>
      </div>
      <p class="fc-hint">Salvaguardas — provisório, ainda só neste navegador, não é salvo com a ficha.</p>
    </div>

    <div class="fc-box">
      <div class="fc-box-title">Perícias</div>
      <p class="fc-hint">○ nada · 🟠 proficiente · 🔵 maior = especialista — clique para alternar</p>
      <div class="fc-skills-grid">
        <div v-for="s in SKILLS" :key="s.name" class="fc-skill-row">
          <button
              type="button"
              class="fc-skill-toggle"
              :class="estadoPericia(s.name)"
              @click="alternarEstadoPericia(s.name)"
              :title="periciaDe(s.name).expertise ? 'Especialista' : periciaDe(s.name).proficiente ? 'Proficiente' : 'Sem proficiência'"
          >
            <span class="fc-skill-toggle-dot"></span>
          </button>
          <span class="fc-skill-nome">{{ s.label }}</span>
          <span class="fc-skill-attr">({{ attrAbrev(s.attr) }})</span>
          <span class="fc-skill-valor">{{ formatarMod(valorPericia(s)) }}</span>
        </div>
      </div>

      <div class="fc-field-grid" style="margin-top: 10px">
        <label class="fc-field">
          <span class="fc-mini-label">Percepção passiva</span>
          <input type="text" :value="10 + valorPericiaPorNome('Percepcao')" readonly />
        </label>
        <label class="fc-field">
          <span class="fc-mini-label">Intuição passiva</span>
          <input type="text" :value="10 + valorPericiaPorNome('Intuicao')" readonly />
        </label>
      </div>
    </div>

    <div class="fc-box">
      <div class="fc-box-title">Idiomas & proficiências</div>
      <textarea v-model="ficha.idiomas" @input="agendarSalvar" style="min-height: 72px"></textarea>
    </div>

    <div class="fc-box">
      <div class="fc-box-title">Resistências & vulnerabilidades</div>
      <div class="fc-tag-add">
        <input type="text" v-model="novaTag" placeholder="Dano, condição, etc..." />
        <button class="fc-btn" @click="adicionarTag('resistencia')">+ Res</button>
        <button class="fc-btn" @click="adicionarTag('vulnerabilidade')">+ Vul</button>
      </div>
      <div class="fc-tag-list">
        <span v-for="(t, i) in ficha.tags" :key="i" class="fc-tag" :class="'fc-tag-' + t.tipo">
          {{ t.texto }}
          <button class="fc-tag-remove" @click="removerItem(ficha.tags, i)">×</button>
        </span>
      </div>
    </div>
  </div>
</template>

<script setup>
import { useFichaPersonagem } from '../../composables/useFichaPersonagem';

const {
  ficha, novaTag, ATRIBUTOS, SKILLS, racasDisponiveis, OPCOES_CLASSE,
  agendarSalvar, salvaguardaDe, valorSalvaguarda, alternarSalvaguarda,
  alterarAtributo, formatarMod, periciaDe, valorPericia, valorPericiaPorNome,
  estadoPericia, alternarEstadoPericia, attrAbrev, adicionarTag, removerItem,
} = useFichaPersonagem();
</script>

<style scoped>
.fc-attr-cards {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: 10px;
}

.fc-attr-card {
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 8px;
  padding: 10px;
  border: 1px solid var(--jungle-green);
  background: var(--jungle-void);
}

.fc-attr-card-top {
  width: 100%;
  display: flex;
  align-items: center;
  justify-content: space-between;
}

.fc-attr-nome {
  font-family: 'Cinzel', serif;
  font-size: 11px;
  letter-spacing: 0.1em;
  text-transform: uppercase;
  font-weight: 700;
  color: var(--pale-green);
}

.fc-save-check-hidden {
  display: none;
}

.fc-hex-label {
  display: inline-block;
  cursor: pointer;
}

.fc-hex-box {
  width: 24px;
  height: 24px;
  background: var(--jungle-void);
  border: 1px solid var(--jungle-green);
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  transition: background-color 0.2s ease, border-color 0.2s ease, box-shadow 0.2s ease;
}

.fc-hex-box.active {
  background: var(--tribal-yellow);
  border-color: var(--tribal-yellow);
  box-shadow: 0 0 10px rgba(232, 193, 74, 0.6);
}

.fc-hex-star {
  color: var(--jungle-void);
  font-size: 14px;
  line-height: 1;
  text-shadow: 0 0 4px rgba(255, 255, 255, 0.4);
}

.fc-attr-card-big {
  font-family: 'Cinzel Decorative', 'Cinzel', serif;
  font-weight: 700;
  font-size: 36px;
  color: var(--bone);
}

.fc-attr-card-big-save {
  color: var(--tribal-yellow);
}

.fc-attr-card .attr-stepper {
  width: 100%;
}

.fc-attr-card .qty-btn:first-child {
  background: var(--tribal-red);
  color: var(--bone);
}

.fc-attr-card .qty-btn:first-child:hover {
  background: #942a24;
}

.fc-attr-card .qty-btn:last-child {
  background: var(--tribal-yellow);
  color: var(--jungle-void);
}

.fc-attr-card .qty-btn:last-child:hover {
  background: var(--tribal-gold);
}

.fc-skills-grid {
  display: grid;
  grid-template-columns: repeat(2, 1fr);
  gap: 4px 16px;
}

.fc-skill-row {
  display: flex;
  align-items: center;
  gap: 8px;
  padding: 5px 0;
  border-bottom: 1px dashed rgba(46, 125, 79, 0.4);
}

.fc-skill-toggle {
  flex: none;
  width: 24px;
  height: 24px;
  display: flex;
  align-items: center;
  justify-content: center;
  background: none;
  border: none;
  padding: 0;
  cursor: pointer;
}

.fc-skill-toggle-dot {
  display: block;
  border-radius: 50%;
  transition: width 0.15s ease, height 0.15s ease, background-color 0.15s ease, box-shadow 0.15s ease,
  border-color 0.15s ease;
}

.fc-skill-toggle-vazio .fc-skill-toggle-dot {
  width: 12px;
  height: 12px;
  background: transparent;
  border: 1.5px solid rgba(168, 196, 162, 0.5);
}

.fc-skill-toggle-prof .fc-skill-toggle-dot {
  width: 14px;
  height: 14px;
  background: #d97726;
  border: 1.5px solid #d97726;
  box-shadow: 0 0 6px 2px rgba(217, 119, 38, 0.6);
}

.fc-skill-toggle-exp .fc-skill-toggle-dot {
  width: 18px;
  height: 18px;
  background: #2a75d3;
  border: 1.5px solid #2a75d3;
  box-shadow: 0 0 8px 3px rgba(42, 117, 211, 0.6);
}

.fc-skill-nome {
  flex: 1;
  min-width: 0;
  font-size: 14px;
  text-align: center;
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
}

.fc-skill-attr {
  font-family: ui-monospace, Menlo, monospace;
  font-size: 10px;
  color: var(--pale-green);
}

.fc-skill-valor {
  font-family: 'Cinzel', serif;
  font-weight: 700;
  min-width: 2.4em;
  text-align: right;
  color: var(--tribal-yellow);
}

.fc-tag-add {
  display: flex;
  gap: 6px;
}

.fc-tag-add input {
  flex: 1;
}

.fc-tag-list {
  display: flex;
  flex-wrap: wrap;
  gap: 6px;
}

.fc-tag {
  display: inline-flex;
  align-items: center;
  gap: 6px;
  padding: 4px 10px;
  font-family: 'Cinzel', serif;
  font-size: 10px;
  letter-spacing: 0.1em;
  text-transform: uppercase;
  border: 1px solid var(--jungle-green);
}

.fc-tag-resistencia {
  color: var(--pale-green);
}

.fc-tag-vulnerabilidade {
  border-color: var(--tribal-red);
  color: var(--bone);
}

.fc-tag-remove {
  background: none;
  border: none;
  color: inherit;
  cursor: pointer;
}

@media (max-width: 900px) {
  .fc-attr-cards {
    grid-template-columns: repeat(2, 1fr);
  }

  .fc-skills-grid {
    grid-template-columns: 1fr;
  }
}
</style>
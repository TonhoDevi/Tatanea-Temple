<template>
  <aside class="ficha-sidebar">
    <div class="fc-box fc-identity">
      <div class="fc-portrait">
        <img v-if="ficha.imagemUrl" :src="ficha.imagemUrl" :alt="ficha.nome" />
        <span v-else>[ retrato ]</span>
      </div>
      <input type="text" class="fc-name-input" v-model="ficha.nome" placeholder="Nome do personagem" @input="agendarSalvar" />
      <div class="fc-identity-meta">Nível {{ ficha.nivel }} · {{ ficha.classeId || 'sem classe' }}</div>

      <label class="fc-field">
        <span class="fc-mini-label">Classe</span>
        <textarea class="fc-class-textarea" v-model="ficha.classeId" placeholder="Classe" @input="agendarSalvar"></textarea>
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
    </div>

    <div class="fc-box">
      <div class="fc-box-title">Pontos de vida</div>
      <div class="fc-pv">
        <template v-if="ficha.pvTemporario > 0"><span class="fc-pv-temp">{{ ficha.pvTemporario }}</span><span class="fc-pv-temp-plus">+</span></template
        >{{ ficha.pvAtual }}/{{ ficha.pvMaximo }}
      </div>
      <div class="fc-pv-bar"><div class="fc-pv-bar-fill" :style="{ width: pvPct + '%' }"></div></div>
      <input type="number" class="fc-mini-number fc-pv-qtd" v-model.number="ajustePv" min="0" placeholder="qtd" />
      <div class="fc-pv-adjust">
        <button class="fc-btn fc-btn-dano" @click="aplicarDano">−dano</button>
        <button class="fc-btn fc-btn-cura" @click="aplicarCura">+cura</button>
        <button class="fc-btn fc-btn-temp" @click="aplicarVidaTemp">+temp</button>
      </div>

      <div class="fc-field-grid">
        <label class="fc-field">
          <span class="fc-mini-label">Vida atual</span>
          <input type="number" v-model.number="ficha.pvAtual" @input="agendarSalvar" />
        </label>
        <label class="fc-field">
          <span class="fc-mini-label">Vida máxima</span>
          <input type="number" v-model.number="ficha.pvMaximo" @input="agendarSalvar" />
        </label>
      </div>

      <div class="fc-stat-grid">
        <label class="fc-stat-box">
          <span>CA</span>
          <input type="number" v-model.number="ficha.ca" @input="agendarSalvar" />
        </label>
        <label class="fc-stat-box">
          <span>Iniciativa</span>
          <input type="number" v-model.number="ficha.iniciativaBonus" @input="agendarSalvar" />
        </label>
        <label class="fc-stat-box">
          <span>Temp.</span>
          <input type="number" v-model.number="ficha.pvTemporario" @input="agendarSalvar" />
        </label>
      </div>
    </div>

    <div class="fc-box">
      <div class="fc-box-title">Atributos</div>
      <div class="fc-attr-list">
        <div class="fc-attr-row fc-attr-row-readonly" v-for="attr in ATRIBUTOS" :key="attr.chave">
          <span class="fc-attr-sigla fc-attr-sigla-full">{{ attr.nome }}</span>
          <span class="fc-attr-valor">{{ ficha[attr.chave] }}</span>
          <span class="fc-attr-mod">{{ formatarMod(modificador(ficha[attr.chave])) }}</span>
        </div>
      </div>
      <p class="fc-hint">Editar valores e salvaguardas: aba Características.</p>
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
import { useFichaPersonagem } from '../../composables/useFichaPersonagem';

const {
  ficha, ATRIBUTOS, bonusProficiencia, pvPct, ajustePv,
  agendarSalvar, alterar, aplicarDano, aplicarCura, aplicarVidaTemp,
  modificador, formatarMod, exportarJSON, importarJSON, excluir,
} = useFichaPersonagem();
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
  border: 1px solid rgba(168, 196, 162, 0.45);
  background-image: repeating-linear-gradient(45deg, rgba(46, 125, 79, 0.35) 0 6px, transparent 6px 14px);
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

.fc-class-textarea {
  min-height: 44px;
  resize: vertical;
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

.fc-pv {
  text-align: center;
  font-family: 'Cinzel Decorative', 'Cinzel', serif;
  font-weight: 700;
  font-size: 24px;
  color: var(--bone);
}

.fc-pv-temp {
  color: #4fa8d8;
}

.fc-pv-temp-plus {
  color: #4fa8d8;
  margin: 0 2px;
}

.fc-pv-bar {
  height: 6px;
  border: 1px solid var(--jungle-green);
  background: var(--jungle-void);
}

.fc-pv-bar-fill {
  height: 100%;
  background: var(--tribal-red);
  transition: width 0.2s ease;
}

.fc-pv-qtd {
  width: 100%;
  box-sizing: border-box;
  text-align: center;
}

.fc-pv-adjust {
  display: grid;
  grid-template-columns: 1fr 1fr 1fr;
  gap: 6px;
}

.fc-btn-dano {
  background: transparent;
  border-color: var(--tribal-red);
  color: var(--bone);
}

.fc-btn-dano:hover {
  background: var(--tribal-red);
}

.fc-btn-cura {
  background: transparent;
  border-color: var(--jungle-green);
  color: var(--pale-green);
}

.fc-btn-cura:hover {
  background: var(--jungle-green);
  color: var(--bone);
}

.fc-btn-temp {
  background: transparent;
  border-color: #4fa8d8;
  color: #4fa8d8;
}

.fc-btn-temp:hover {
  background: #4fa8d8;
  color: var(--jungle-void);
}

.fc-stat-grid {
  display: grid;
  grid-template-columns: 1fr 1fr 1fr;
  gap: 6px;
}

.fc-stat-box {
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 4px;
  padding: 6px;
  border: 1px solid var(--jungle-green);
  text-align: center;
}

.fc-stat-box span {
  font-family: 'Cinzel', serif;
  font-size: 9px;
  letter-spacing: 0.1em;
  text-transform: uppercase;
  color: var(--pale-green);
}

.fc-stat-box input {
  text-align: center;
  padding: 4px;
  border: none;
  background: transparent;
  font-family: 'Cinzel Decorative', 'Cinzel', serif;
  font-size: 15px;
}

.fc-attr-list {
  display: flex;
  flex-direction: column;
  gap: 8px;
}

.fc-attr-row {
  display: flex;
  align-items: center;
  gap: 6px;
}

.fc-attr-row-readonly {
  justify-content: space-between;
}

.fc-attr-valor {
  flex: 1;
  text-align: center;
  font-family: 'Cinzel Decorative', 'Cinzel', serif;
  font-size: 18px;
  color: var(--bone);
}

.fc-attr-sigla {
  flex: none;
  width: 32px;
  font-family: 'Cinzel', serif;
  font-size: 10px;
  letter-spacing: 0.1em;
  color: var(--pale-green);
}

.fc-attr-sigla-full {
  flex: 1;
  width: auto;
  font-size: 13px;
  text-transform: uppercase;
}

.fc-attr-mod {
  flex: none;
  width: 36px;
  text-align: right;
  font-family: 'Cinzel Decorative', 'Cinzel', serif;
  font-size: 16px;
  font-weight: 700;
  color: var(--tribal-yellow);
}

@media (max-width: 900px) {
  .ficha-sidebar {
    flex: none;
    width: 100%;
    position: static;
  }
}
</style>
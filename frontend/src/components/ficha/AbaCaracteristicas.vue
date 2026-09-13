<template>
  <div>
    <div
        class="fc-box"
        v-if="racaDetalhe && (atributosFixos(racaDetalhe.atributos).length || atributosEscolha(racaDetalhe.atributos).length)"
    >
      <div class="fc-box-title">Bônus de atributo da raça</div>

      <div v-if="atributosFixos(racaDetalhe.atributos).length" class="fc-talento-bonus-row">
        <span v-for="(a, i) in atributosFixos(racaDetalhe.atributos)" :key="'fixo-' + i" class="fc-talento-bonus">
          +{{ a.valor }} {{ atributoNome(a.atributo) }}
        </span>
      </div>

      <template v-for="(a, ai) in atributosEscolha(racaDetalhe.atributos)" :key="'esc-' + ai">
        <div v-if="slotsEscolhidos('raca', racaDetalhe.id, ai, a.quantidadeEscolhas).length" class="fc-talento-bonus-row">
          <button
              v-for="n in slotsEscolhidos('raca', racaDetalhe.id, ai, a.quantidadeEscolhas)"
              :key="n"
              type="button"
              class="fc-talento-bonus fc-talento-bonus-clicavel"
              title="Clique para mudar a escolha"
              @click="editandoEscolha[chaveEscolha('raca', racaDetalhe.id, ai, n)] = true"
          >
            +{{ a.valor }} {{ atributoNome(ficha.escolhasAtributo[chaveEscolha('raca', racaDetalhe.id, ai, n)]) }}
          </button>
        </div>

        <div v-if="slotsPendentes('raca', racaDetalhe.id, ai, a.quantidadeEscolhas).length" class="fc-talento-escolha">
          <p class="fc-talento-escolha-titulo">
            Escolha {{ slotsPendentes('raca', racaDetalhe.id, ai, a.quantidadeEscolhas).length }}
            atributo{{ slotsPendentes('raca', racaDetalhe.id, ai, a.quantidadeEscolhas).length > 1 ? 's' : '' }}
            para +{{ a.valor }}{{ a.quantidadeEscolhas > 1 ? ' cada' : '' }}
          </p>
          <div class="fc-talento-escolha-selects">
            <label class="fc-escolha-slot" v-for="n in slotsPendentes('raca', racaDetalhe.id, ai, a.quantidadeEscolhas)" :key="n">
              <span class="fc-escolha-slot-num">{{ n }}º</span>
              <select
                  v-model="ficha.escolhasAtributo[chaveEscolha('raca', racaDetalhe.id, ai, n)]"
                  class="fc-select"
                  @change="editandoEscolha[chaveEscolha('raca', racaDetalhe.id, ai, n)] = false; agendarSalvar()"
              >
                <option value="">Selecione...</option>
                <option
                    v-for="attr in opcoesParaSlot('raca', racaDetalhe.id, ai, a.quantidadeEscolhas, n)"
                    :key="attr.chave"
                    :value="attr.chave"
                >{{ attr.nome }}</option>
              </select>
            </label>
          </div>
        </div>
      </template>
    </div>

    <div class="fc-combate-row">
      <div class="fc-combate-block fc-ca-block">
        <span class="fc-rivet fc-rivet-tl"></span>
        <span class="fc-rivet fc-rivet-tr"></span>
        <span class="fc-rivet fc-rivet-bl"></span>
        <span class="fc-rivet fc-rivet-br"></span>
        <button type="button" class="fc-combate-face" @click="caAberto = !caAberto">
          <span class="fc-combate-icone-fundo" aria-hidden="true">🛡️</span>
          <span class="fc-combate-valor">{{ caTotal }}</span>
          <span class="fc-combate-label">Classe de Armadura</span>
        </button>
        <div v-if="caAberto" class="fc-combate-detalhe">
          <div class="fc-combate-item" v-for="(p, i) in armaduraPecas" :key="i">
            <input type="text" v-model="p.nome" placeholder="Nome da peça" @input="sincronizarCa" />
            <input type="number" class="fc-mini-number" v-model.number="p.bonus" @input="sincronizarCa" />
            <button type="button" class="fc-btn-remove" @click="removerArmadura(i)">×</button>
          </div>
          <button type="button" class="fc-btn-add" @click="adicionarArmadura">+ Adicionar peça de armadura</button>
        </div>
      </div>

      <div class="fc-combate-block fc-ini-block">
        <span class="fc-estrela4 fc-estrela4-tl"></span>
        <span class="fc-estrela4 fc-estrela4-tr"></span>
        <span class="fc-estrela4 fc-estrela4-bl"></span>
        <span class="fc-estrela4 fc-estrela4-br"></span>
        <button type="button" class="fc-combate-face" @click="iniciativaAberta = !iniciativaAberta">
          <span class="fc-combate-icone-fundo" aria-hidden="true">⚡</span>
          <span class="fc-combate-valor fc-combate-valor-medalhao">{{ formatarMod(iniciativaTotal) }}</span>
          <span class="fc-combate-label">Iniciativa</span>
        </button>
        <div v-if="iniciativaAberta" class="fc-combate-detalhe">
          <div class="fc-combate-item fc-combate-item-base">
            <span>Base (salvaguarda de Destreza)</span>
            <span class="fc-combate-item-base-valor">{{ formatarMod(iniciativaBase) }}</span>
          </div>
          <div class="fc-combate-item" v-for="(m, i) in iniciativaModificadores" :key="i">
            <input type="text" v-model="m.nome" placeholder="Nome do modificador" @input="sincronizarIniciativa" />
            <input type="number" class="fc-mini-number" v-model.number="m.bonus" @input="sincronizarIniciativa" />
            <button type="button" class="fc-btn-remove" @click="removerModificadorIniciativa(i)">×</button>
          </div>
          <button type="button" class="fc-btn-add" @click="adicionarModificadorIniciativa">+ Adicionar modificador</button>
        </div>
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
          <button
              type="button"
              class="fc-attr-card-big"
              :class="{ 'fc-attr-card-big-save': salvaguardaDe(attr.chave).proficiente }"
              @click="atributoAberto = atributoAberto === attr.chave ? null : attr.chave"
          >
            {{ formatarMod(valorSalvaguarda(attr)) }}
          </button>

          <div v-if="atributoAberto === attr.chave" class="fc-attr-detalhe">
            <div class="fc-attr-detalhe-linha">
              <span>Valor base</span><span>{{ ficha[attr.chave] }}</span>
            </div>
            <div v-if="bonusRacaAtributo(attr.chave)" class="fc-attr-detalhe-linha">
              <span>Raça</span><span>+{{ bonusRacaAtributo(attr.chave) }}</span>
            </div>
            <div v-if="bonusTalentoAtributo(attr.chave)" class="fc-attr-detalhe-linha">
              <span>Talento</span><span>+{{ bonusTalentoAtributo(attr.chave) }}</span>
            </div>
            <div class="fc-attr-detalhe-linha fc-attr-detalhe-total">
              <span>Atributo total</span>
              <span>{{ valorTotalAtributo(attr.chave) }} ({{ formatarMod(modificador(valorTotalAtributo(attr.chave))) }})</span>
            </div>
            <div v-if="salvaguardaDe(attr.chave).proficiente" class="fc-attr-detalhe-linha">
              <span>Proficiência (salvaguarda)</span><span>+{{ bonusProficiencia }}</span>
            </div>
            <div class="fc-attr-detalhe-linha fc-attr-detalhe-total">
              <span>Salvaguarda</span><span>{{ formatarMod(valorSalvaguarda(attr)) }}</span>
            </div>
          </div>

          <div class="qty-spinner attr-stepper">
            <button class="qty-btn" @click="alterarAtributo(attr.chave, -1)">‹</button>
            <input type="number" class="fc-mini-number" min="0" max="30" v-model.number="ficha[attr.chave]" @input="clamparAtributo(attr.chave)" />
            <button class="qty-btn" @click="alterarAtributo(attr.chave, 1)">›</button>
          </div>
        </div>
      </div>
    </div>

    <div class="fc-box">
      <div class="fc-box-title">Perícias</div>
      <p class="fc-hint">○ nada · 🟡 proficiente · 🔵 maior = especialista — clique para alternar</p>
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
        <button type="button" class="fc-btn-vulnerabilidade" @click="adicionarTag('vulnerabilidade')">Vulnerabilidade</button>
        <input type="text" v-model="novaTag" placeholder="Dano, condição, etc..." class="fc-tag-input" />
        <button type="button" class="fc-btn-resistencia" @click="adicionarTag('resistencia')">Resistência</button>
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
import { ref } from 'vue';
import { useFichaPersonagem } from '../../composables/useFichaPersonagem';

const {
  ficha, novaTag, ATRIBUTOS, SKILLS,
  agendarSalvar, salvaguardaDe, valorSalvaguarda, alternarSalvaguarda,
  alterarAtributo, clamparAtributo, formatarMod, modificador, bonusProficiencia,
  bonusRacaAtributo, bonusTalentoAtributo, valorTotalAtributo,
  periciaDe, valorPericia, valorPericiaPorNome,
  estadoPericia, alternarEstadoPericia, attrAbrev, adicionarTag, removerItem,
  racaDetalhe, atributosFixos, atributosEscolha, atributoNome,
  editandoEscolha, chaveEscolha, opcoesParaSlot,
  slotsEscolhidos, slotsPendentes,
  armaduraPecas, iniciativaModificadores, caTotal, iniciativaTotal, iniciativaBase,
  adicionarArmadura, removerArmadura, sincronizarCa,
  adicionarModificadorIniciativa, removerModificadorIniciativa, sincronizarIniciativa,
} = useFichaPersonagem();

// Qual card de atributo está com o detalhamento do cálculo aberto (só um por vez).
const atributoAberto = ref(null);

// Se os blocos de CA/Iniciativa estão com o detalhamento (peças/modificadores) aberto.
const caAberto = ref(false);
const iniciativaAberta = ref(false);
</script>

<style scoped>
.fc-combate-row {
  display: flex;
  gap: 12px;
}

.fc-combate-block {
  position: relative;
  flex: 1;
  min-width: 0;
  display: flex;
  flex-direction: column;
  overflow: hidden;
}

.fc-combate-face {
  position: relative;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  gap: 2px;
  padding: 20px 10px 16px;
  min-height: 104px;
  background: none;
  border: none;
  cursor: pointer;
  width: 100%;
  font: inherit;
  overflow: hidden;
}

.fc-combate-icone-fundo {
  position: absolute;
  inset: 0;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 76px;
  line-height: 1;
  opacity: 0.16;
  pointer-events: none;
}

.fc-combate-valor {
  position: relative;
  font-family: 'Cinzel Decorative', 'Cinzel', serif;
  font-weight: 700;
  font-size: 30px;
  line-height: 1.15;
}

.fc-combate-label {
  position: relative;
  font-family: 'Cinzel', serif;
  font-size: 9px;
  font-weight: 700;
  letter-spacing: 0.14em;
  text-transform: uppercase;
}

.fc-combate-detalhe {
  display: flex;
  flex-direction: column;
  gap: 6px;
  padding: 10px;
  border-top: 1px solid rgba(0, 0, 0, 0.3);
  background: rgba(0, 0, 0, 0.18);
}

.fc-combate-item {
  display: flex;
  gap: 6px;
  align-items: center;
}

.fc-combate-item input[type='text'] {
  flex: 1;
  min-width: 0;
}

.fc-combate-item .fc-mini-number {
  flex: none;
  width: 56px;
  text-align: center;
}

.fc-combate-item-base {
  display: flex;
  align-items: center;
  justify-content: space-between;
  gap: 10px;
  padding-bottom: 6px;
  margin-bottom: 2px;
  border-bottom: 1px dashed color-mix(in srgb, var(--accent-title) 40%, transparent);
  font-family: 'Cinzel', serif;
  font-size: 12px;
  color: var(--pale-green);
}

.fc-combate-item-base-valor {
  font-weight: 700;
  color: var(--tribal-yellow);
}

/* ===== CA — placas de ferro ===== */
.fc-ca-block {
  background: linear-gradient(180deg, var(--bg-card) 0%, var(--bg-sub) 100%);
  border: 2px solid var(--border-gold);
  box-shadow: inset 0 0 0 1px rgba(0, 0, 0, 0.45);
}

.fc-ca-block .fc-combate-valor {
  color: var(--text-main);
  text-shadow: 0 1px 2px rgba(0, 0, 0, 0.6);
}

.fc-ca-block .fc-combate-label {
  color: var(--text-muted);
}

/* Parafusos — cabeça hexagonal com fenda, um em cada canto da placa. */
.fc-rivet {
  position: absolute;
  z-index: 1;
  width: 10px;
  height: 10px;
  clip-path: polygon(25% 0%, 75% 0%, 100% 50%, 75% 100%, 25% 100%, 0% 50%);
  background: radial-gradient(circle at 35% 35%, color-mix(in srgb, var(--text-main) 85%, white), color-mix(in srgb, var(--text-muted) 60%, black) 75%);
  box-shadow: 0 1px 2px rgba(0, 0, 0, 0.6);
}

.fc-rivet::after {
  content: '';
  position: absolute;
  top: 50%;
  left: 15%;
  right: 15%;
  height: 1.5px;
  background: rgba(0, 0, 0, 0.55);
  transform: translateY(-50%);
}

.fc-rivet-tl { top: 6px; left: 6px; }
.fc-rivet-tr { top: 6px; right: 6px; }
.fc-rivet-bl { bottom: 6px; left: 6px; }
.fc-rivet-br { bottom: 6px; right: 6px; }

/* ===== Iniciativa — amarela, zigue-zague e símbolos estrelados ===== */
.fc-ini-block {
  background: linear-gradient(180deg, var(--bg-card) 0%, var(--bg-sub) 100%);
  border: 2px solid var(--tribal-gold);
}

.fc-ini-block .fc-combate-label {
  color: var(--tribal-yellow);
}

.fc-combate-valor-medalhao {
  display: flex;
  align-items: center;
  justify-content: center;
  width: 56px;
  height: 56px;
  margin: 2px 0;
  clip-path: polygon(
      50% 2%, 57.7% 31.5%, 83.9% 16.1%, 68.5% 42.4%,
      98% 50%, 68.5% 57.7%, 83.9% 83.9%, 57.7% 68.5%,
      50% 98%, 42.4% 68.5%, 16.1% 83.9%, 31.5% 57.7%,
      2% 50%, 31.5% 42.4%, 16.1% 16.1%, 42.4% 31.5%
  );
  background: radial-gradient(circle, var(--tribal-yellow) 0%, var(--tribal-gold) 100%);
  color: var(--jungle-void);
  font-size: 19px;
  filter: drop-shadow(0 0 5px color-mix(in srgb, var(--accent-title) 60%, transparent));
}

/* Estrelinhas de 4 pontas, uma em cada canto do bloco. */
.fc-estrela4 {
  position: absolute;
  z-index: 1;
  width: 11px;
  height: 11px;
  clip-path: polygon(50% 0%, 61% 35%, 100% 50%, 61% 65%, 50% 100%, 39% 65%, 0% 50%, 39% 35%);
  background: var(--tribal-yellow);
  filter: drop-shadow(0 0 2px color-mix(in srgb, var(--accent-title) 70%, transparent));
}

.fc-estrela4-tl { top: 6px; left: 6px; }
.fc-estrela4-tr { top: 6px; right: 6px; }
.fc-estrela4-bl { bottom: 6px; left: 6px; }
.fc-estrela4-br { bottom: 6px; right: 6px; }

@media (max-width: 700px) {
  .fc-combate-row {
    flex-direction: column;
  }
}

.fc-talento-bonus-row {
  display: flex;
  flex-wrap: wrap;
  gap: 6px;
}

.fc-talento-bonus {
  display: inline-block;
  padding: 4px 10px;
  border: 1px solid var(--accent-title);
  border-radius: 3px;
  background: color-mix(in srgb, var(--accent-title) 18%, transparent);
  font-family: 'Cinzel', serif;
  font-size: 12px;
  font-weight: 700;
  letter-spacing: 0.06em;
  text-transform: uppercase;
  color: color-mix(in srgb, var(--accent-title) 60%, white);
}

.fc-talento-bonus-clicavel {
  cursor: pointer;
  transition: background-color 0.15s ease, border-color 0.15s ease;
}

.fc-talento-bonus-clicavel:hover {
  background: color-mix(in srgb, var(--accent-title) 30%, transparent);
  border-color: color-mix(in srgb, var(--accent-title) 60%, white);
}

.fc-talento-escolha {
  display: flex;
  flex-direction: column;
  gap: 8px;
  padding: 10px 12px;
  border: 1px dashed var(--tribal-gold);
  background: color-mix(in srgb, var(--accent-title) 10%, transparent);
}

.fc-talento-escolha-titulo {
  margin: 0;
  font-family: 'Cinzel', serif;
  font-size: 12px;
  font-weight: 700;
  letter-spacing: 0.06em;
  text-transform: uppercase;
  color: var(--tribal-gold);
}

.fc-talento-escolha-selects {
  display: flex;
  flex-wrap: wrap;
  gap: 8px;
}

.fc-escolha-slot {
  display: flex;
  align-items: center;
  gap: 8px;
  flex: 1 1 160px;
}

.fc-escolha-slot-num {
  flex: none;
  display: flex;
  align-items: center;
  justify-content: center;
  width: 22px;
  height: 22px;
  border-radius: 50%;
  border: 1px solid var(--tribal-gold);
  background: var(--jungle-void);
  font-family: 'Cinzel', serif;
  font-weight: 700;
  font-size: 11px;
  color: var(--tribal-yellow);
}

.fc-escolha-slot .fc-select {
  flex: 1;
  min-width: 0;
}

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
  border: 1px solid var(--border-gold);
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
  border: 1px solid var(--border-gold);
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  transition: background-color 0.2s ease, border-color 0.2s ease, box-shadow 0.2s ease;
}

.fc-hex-box.active {
  background: var(--tribal-yellow);
  border-color: var(--tribal-yellow);
  box-shadow: 0 0 10px color-mix(in srgb, var(--accent-title) 60%, transparent);
}

.fc-hex-star {
  color: var(--jungle-void);
  font-size: 14px;
  line-height: 1;
  text-shadow: 0 0 4px rgba(255, 255, 255, 0.4);
}

.fc-attr-card-big {
  display: block;
  width: 100%;
  padding: 0;
  background: none;
  border: none;
  cursor: pointer;
  font-family: 'Cinzel Decorative', 'Cinzel', serif;
  font-weight: 700;
  font-size: 36px;
  color: var(--bone);
}

.fc-attr-card-big-save {
  color: var(--tribal-yellow);
}

.fc-attr-detalhe {
  width: 100%;
  display: flex;
  flex-direction: column;
  gap: 4px;
  padding: 8px 10px;
  background: var(--jungle-darkest);
  border: 1px solid var(--border-gold);
}

.fc-attr-detalhe-linha {
  display: flex;
  justify-content: space-between;
  gap: 10px;
  font-size: 12px;
  color: var(--pale-green);
}

.fc-attr-detalhe-total {
  padding-top: 4px;
  border-top: 1px dashed color-mix(in srgb, var(--accent-title) 50%, transparent);
  color: var(--bone);
  font-weight: 700;
}

.fc-attr-card .attr-stepper {
  width: 100%;
}

.fc-attr-card .attr-stepper .qty-btn {
  font-size: 44px;
  line-height: 1;
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
  border-bottom: 1px dashed color-mix(in srgb, var(--accent-title) 40%, transparent);
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
  border: 1.5px solid rgba(196, 181, 157, 0.5);
}

.fc-skill-toggle-prof .fc-skill-toggle-dot {
  width: 14px;
  height: 14px;
  background: var(--accent-title);
  border: 1.5px solid var(--accent-title);
  box-shadow: 0 0 6px 2px color-mix(in srgb, var(--accent-title) 60%, transparent);
}

.fc-skill-toggle-exp .fc-skill-toggle-dot {
  width: 18px;
  height: 18px;
  background: #2fa8c0;
  border: 1.5px solid #4fc9e0;
  box-shadow: 0 0 10px 4px rgba(47, 168, 192, 0.6);
}

.fc-skill-nome {
  flex: 1;
  min-width: 0;
  font-size: 14px;
  text-align: center;
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
  transition: color 0.15s ease;
}

.fc-skill-attr {
  font-family: ui-monospace, Menlo, monospace;
  font-size: 10px;
  color: var(--pale-green);
  transition: color 0.15s ease;
}

.fc-skill-valor {
  font-family: 'Cinzel', serif;
  font-weight: 700;
  min-width: 2.4em;
  text-align: right;
  color: var(--pale-green);
  transition: color 0.15s ease;
}

/* A fileira acompanha a cor do check marcado (proficiente/especialista). */
.fc-skill-toggle-prof ~ .fc-skill-nome,
.fc-skill-toggle-prof ~ .fc-skill-valor {
  color: var(--accent-title);
}

.fc-skill-toggle-prof ~ .fc-skill-attr {
  color: color-mix(in srgb, var(--accent-title) 70%, var(--pale-green));
}

.fc-skill-toggle-exp ~ .fc-skill-nome,
.fc-skill-toggle-exp ~ .fc-skill-valor {
  color: #4fc9e0;
}

.fc-skill-toggle-exp ~ .fc-skill-attr {
  color: #4fc9e0;
}

.fc-tag-add {
  display: flex;
  align-items: stretch;
  gap: 10px;
  flex-wrap: wrap;
}

.fc-tag-input {
  flex: 1;
  min-width: 160px;
  text-align: center;
}

.fc-btn-resistencia,
.fc-btn-vulnerabilidade {
  flex: none;
  padding: 12px 20px;
  border-radius: 6px;
  font-family: 'Cinzel', serif;
  font-weight: 700;
  font-size: 14px;
  letter-spacing: 0.06em;
  text-transform: uppercase;
  cursor: pointer;
  transition: filter 0.2s ease;
}

.fc-btn-resistencia {
  background: var(--btn-heal-bg);
  border: 1px solid color-mix(in srgb, var(--btn-heal-bg) 60%, white);
  color: var(--btn-heal-text);
}

.fc-btn-resistencia:hover {
  filter: brightness(1.15);
}

.fc-btn-vulnerabilidade {
  background: var(--btn-damage-bg);
  border: 1px solid color-mix(in srgb, var(--btn-damage-bg) 60%, white);
  color: var(--btn-damage-text);
}

.fc-btn-vulnerabilidade:hover {
  filter: brightness(1.15);
}

.fc-tag-list {
  display: flex;
  flex-wrap: wrap;
  gap: 6px;
}

.fc-tag {
  display: inline-flex;
  align-items: center;
  gap: 8px;
  padding: 8px 14px;
  font-family: 'Cinzel', serif;
  font-size: 12px;
  letter-spacing: 0.1em;
  text-transform: uppercase;
  background: var(--bg-main);
  color: var(--text-main);
  border: 1px solid var(--border-gold);
}

.fc-tag-resistencia {
  border-color: var(--btn-heal-bg);
}

.fc-tag-vulnerabilidade {
  border-color: var(--btn-damage-bg);
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
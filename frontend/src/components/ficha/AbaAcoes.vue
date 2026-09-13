<template>
  <div>
    <div class="fc-vida-block">
      <span class="fc-goticula fc-goticula-tl"></span>
      <span class="fc-goticula fc-goticula-tr"></span>
      <span class="fc-goticula fc-goticula-bl"></span>
      <span class="fc-goticula fc-goticula-br"></span>

      <button type="button" class="fc-vida-topo" @click="pvMaximoAberto = !pvMaximoAberto">
        <span class="fc-vida-titulo">Pontos de Vida</span>
        <span class="fc-vida-numero">
          <template v-if="ficha.pvTemporario > 0"
            ><span class="fc-vida-temp">{{ ficha.pvTemporario }}</span><span class="fc-vida-temp-plus">+</span></template
          >{{ ficha.pvAtual }}<span class="fc-vida-max">/{{ ficha.pvMaximo }}</span>
        </span>
      </button>

      <div class="fc-vida-bar">
        <div class="fc-vida-bar-fill" :style="{ width: pvPct + '%' }"></div>
        <div v-if="ficha.pvTemporario > 0" class="fc-vida-bar-temp" :style="{ width: pvTempPct + '%' }"></div>
      </div>
      <div class="fc-vida-bar-legenda">
        <span v-if="ficha.pvTemporario > 0" class="fc-vida-bar-temp-label">Temporários +{{ ficha.pvTemporario }}</span>
        <span class="fc-vida-bar-pct">{{ pvPct }}% de vitalidade</span>
      </div>

      <div v-if="pvMaximoAberto" class="fc-vida-max-detalhe">
        <div class="fc-vida-max-item" v-for="(c, i) in pvMaximoComponentes" :key="i">
          <input type="text" v-model="c.nome" placeholder="Nome do componente" @input="sincronizarPvMaximo" />
          <input type="number" class="fc-mini-number" v-model.number="c.bonus" @input="sincronizarPvMaximo" />
          <button type="button" class="fc-btn-remove" @click="removerComponentePv(i)">×</button>
        </div>
        <button type="button" class="fc-btn-add" @click="adicionarComponentePv">+ Adicionar componente</button>
      </div>

      <div class="fc-vida-adjust">
        <div class="fc-vida-qtd-linha">
          <span class="fc-vida-qtd-ornamento"></span>
          <div class="qty-spinner fc-vida-qtd-spinner">
            <button type="button" class="qty-btn" @click="ajustePv = Math.max(0, (ajustePv || 0) - 1)">‹</button>
            <input type="number" class="fc-mini-number fc-vida-qtd" v-model.number="ajustePv" min="0" placeholder="qtd" />
            <button type="button" class="qty-btn" @click="ajustePv = (ajustePv || 0) + 1">›</button>
          </div>
          <span class="fc-vida-qtd-ornamento"></span>
        </div>
        <div class="fc-vida-adjust-botoes">
          <button class="fc-btn fc-btn-dano" @click="aplicarDano">−dano</button>
          <button class="fc-btn fc-btn-cura" @click="aplicarCura">+cura</button>
          <button class="fc-btn fc-btn-temp" @click="aplicarVidaTemp">+temp</button>
        </div>
      </div>
    </div>

    <div class="fc-box">
      <div class="fc-badge-grid">
        <button
            type="button"
            class="fc-badge-card fc-badge-card-inspiracao"
            :class="{ 'fc-badge-card-active': ficha.inspiracao }"
            @click="alternarBooleano('inspiracao')"
        >
          <span class="fc-badge-texto">
            <span class="fc-badge-titulo">Inspiração</span>
            <span class="fc-badge-sub">{{ ficha.inspiracao ? 'Disponível · clique para gastar' : 'Indisponível · clique para conceder' }}</span>
          </span>
          <span class="fc-badge-medalha-wrap">
            <span class="fc-badge-medalha">
              <span class="fc-badge-medalha-anel"></span>
              <span class="fc-badge-medalha-estrela"></span>
            </span>
            <span class="fc-badge-icone">✦</span>
          </span>
        </button>
        <button
            type="button"
            class="fc-badge-card fc-badge-card-heroico"
            :class="{ 'fc-badge-card-active': ficha.pontoHeroico }"
            @click="alternarBooleano('pontoHeroico')"
        >
          <span class="fc-badge-medalha-wrap">
            <span class="fc-badge-medalha">
              <span class="fc-badge-medalha-anel"></span>
              <span class="fc-badge-medalha-estrela"></span>
            </span>
            <span class="fc-badge-icone">⛨</span>
          </span>
          <span class="fc-badge-texto">
            <span class="fc-badge-titulo">Ponto heroico</span>
            <span class="fc-badge-sub">{{ ficha.pontoHeroico ? 'Disponível · clique para gastar' : 'Indisponível · clique para conceder' }}</span>
          </span>
        </button>
      </div>
    </div>

    <div class="fc-box">
      <div class="fc-box-title-row">
        <span class="fc-box-title">Ataques</span>
        <span class="fc-ataque-contagem">{{ ficha.ataques.length }} {{ ficha.ataques.length === 1 ? 'item' : 'itens' }}</span>
      </div>
      <div v-for="(a, i) in ficha.ataques" :key="i" class="fc-ataque-card">
        <div class="fc-ataque-linha">
          <div class="fc-ataque-nome-view">
            <span class="fc-ataque-nome-texto">{{ a.nome || 'Sem nome' }}</span>
            <span v-if="a.descricao && ataqueEditando !== i" class="fc-ataque-descricao-preview">{{ a.descricao }}</span>
          </div>

          <div class="fc-ataque-stat">
            <div class="fc-ataque-stat-valor">{{ formatarMod(acertoAtaqueTotal(a)) }}</div>
            <span class="fc-ataque-stat-label">Acerto</span>
          </div>

          <div class="fc-ataque-stat">
            <div class="fc-ataque-stat-valor">{{ danoAtaqueResumo(a) }}</div>
            <span class="fc-ataque-stat-label">Dano</span>
          </div>

          <button type="button" class="fc-ataque-rolar" title="Rolar" @click="ataqueRolando = i">⚅</button>
          <button
              type="button"
              class="fc-ataque-editar"
              :class="{ 'fc-ataque-editar-fechar': ataqueEditando === i }"
              :title="ataqueEditando === i ? 'Fechar' : 'Editar'"
              @click="ataqueEditando = ataqueEditando === i ? null : i"
          >
            <span class="fc-ataque-editar-icone" :class="{ 'fc-ataque-editar-icone-lapis': ataqueEditando !== i }">
              {{ ataqueEditando === i ? '✖' : '✏' }}
            </span>
          </button>
        </div>

        <div v-if="ataqueEditando === i" class="fc-ataque-form">
          <div class="fc-ataque-form-linha">
            <div class="fc-ataque-mini-campo fc-ataque-campo-crescer">
              <span class="fc-mini-label">Nome</span>
              <input type="text" v-model="a.nome" @input="agendarSalvar" />
            </div>
            <div class="fc-ataque-mini-campo fc-ataque-campo-crescer">
              <span class="fc-mini-label">Atributo</span>
              <select v-model="a.bonusAtributo" class="fc-select" @change="agendarSalvar">
                <option :value="null">Nenhum</option>
                <option v-for="attr in ATRIBUTOS" :key="attr.chave" :value="attr.chave">{{ attr.nome }}</option>
              </select>
            </div>
            <div class="fc-ataque-mini-campo">
              <span class="fc-mini-label">Prof</span>
              <label class="fc-checkbox-row">
                <input type="checkbox" class="fc-prof-check-hidden" v-model="a.bonusProficiente" @change="agendarSalvar" />
                <span class="fc-prof-box" :class="{ active: a.bonusProficiente }">
                  <span v-if="a.bonusProficiente" class="fc-prof-star">★</span>
                </span>
              </label>
            </div>
            <div class="fc-ataque-mini-campo">
              <span class="fc-mini-label">Bônus</span>
              <input type="number" class="fc-mini-number" v-model.number="a.bonusExtra" placeholder="+0" @input="agendarSalvar" />
            </div>
          </div>

          <div class="fc-ataque-danos">
            <div v-for="(d, di) in a.danos" :key="di" class="fc-ataque-subcard">
              <div class="fc-ataque-mini-campo">
                <span class="fc-mini-label">Nº de dados</span>
                <input type="number" class="fc-mini-number" min="1" v-model.number="d.quantidade" @input="agendarSalvar" />
              </div>
              <div class="fc-ataque-mini-campo fc-ataque-campo-crescer">
                <span class="fc-mini-label">Tipo de dado</span>
                <select v-model="d.dado" class="fc-select" @change="agendarSalvar">
                  <option v-for="dado in TIPOS_DADO" :key="dado" :value="dado">{{ dado }}</option>
                </select>
              </div>
              <div class="fc-ataque-mini-campo">
                <span class="fc-mini-label">Bônus</span>
                <input type="number" class="fc-mini-number" v-model.number="d.bonus" placeholder="+0" @input="agendarSalvar" />
              </div>
              <div class="fc-ataque-mini-campo fc-ataque-campo-crescer">
                <span class="fc-mini-label">Tipo de dano</span>
                <select v-model="d.tipoDano" class="fc-select" @change="agendarSalvar">
                  <option :value="null">Nenhum</option>
                  <option v-for="tipo in TIPOS_DANO" :key="tipo" :value="tipo">{{ tipo }}</option>
                </select>
              </div>
              <button type="button" class="fc-btn-remove" @click="removerDano(a, di)">×</button>
            </div>
            <button type="button" class="fc-btn-add" @click="adicionarDano(a)">+ Adicionar dano</button>
          </div>

          <label class="fc-field">
            <span class="fc-mini-label">Descrição</span>
            <textarea v-model="a.descricao" @input="agendarSalvar"></textarea>
          </label>

          <button type="button" class="fc-btn-add fc-btn-remove-wide" @click="removerItem(ficha.ataques, i)">× Remover ataque</button>
        </div>
      </div>
      <button class="fc-btn-add" @click="adicionarAtaque">+ Adicionar ataque</button>
    </div>

    <div class="fc-box">
      <div class="fc-desloc-header">
        <span class="fc-desloc-titulo">Deslocamento</span>
        <div class="fc-desloc-unidade-grupo">
          <span class="fc-desloc-unidade-label">Unidade de Medida</span>
          <select v-model="unidadeDeslocamento" class="fc-select fc-desloc-unidade">
            <option v-for="u in UNIDADES_DESLOCAMENTO" :key="u.chave" :value="u.chave">{{ u.label }}</option>
          </select>
        </div>
      </div>
      <div class="fc-desloc-linha">
        <template v-for="(campo, i) in CAMPOS_DESLOCAMENTO" :key="campo.chave">
          <span class="fc-desloc-item">
            <span class="fc-desloc-nome">{{ campo.label }}</span>
            <input
                type="text"
                inputmode="decimal"
                class="fc-desloc-input"
                :value="deslocDisplay[campo.chave]"
                @input="onDeslocInput(campo.chave, $event)"
                placeholder="—"
            />
            <span class="fc-desloc-sufixo">{{ unidadeLabelAtual }}</span>
          </span>
          <span v-if="i < CAMPOS_DESLOCAMENTO.length - 1" class="fc-desloc-separador">|</span>
        </template>
      </div>
    </div>

    <RolagemAtaque
        v-if="ataqueRolando !== null"
        :ataque="ficha.ataques[ataqueRolando]"
        :acerto-bonus="acertoAtaqueTotal(ficha.ataques[ataqueRolando])"
        @fechar="ataqueRolando = null"
    />
  </div>
</template>

<script setup>
import { computed, reactive, ref, watch } from 'vue';
import { useFichaPersonagem } from '../../composables/useFichaPersonagem';
import RolagemAtaque from './RolagemAtaque.vue';

const {
  ficha, agendarSalvar, alternarBooleano, removerItem, adicionarAtaque,
  acertoAtaqueTotal, danoAtaqueResumo, adicionarDano, removerDano, formatarMod, ATRIBUTOS, TIPOS_DADO, TIPOS_DANO,
  pvPct, ajustePv, aplicarDano, aplicarCura, aplicarVidaTemp,
  pvMaximoComponentes, adicionarComponentePv, removerComponentePv, sincronizarPvMaximo,
} = useFichaPersonagem();

const pvMaximoAberto = ref(false);
const ataqueEditando = ref(null);
const ataqueRolando = ref(null);

const pvTempPct = computed(() => {
  if (!ficha.value || !ficha.value.pvMaximo) return 0;
  const espacoLivre = Math.max(0, 100 - pvPct.value);
  return Math.max(0, Math.min(espacoLivre, Math.round((ficha.value.pvTemporario / ficha.value.pvMaximo) * 100)));
});

// ===== Deslocamento — persistido sempre em metros; a unidade escolhida aqui
// (M / ft / square) só controla a exibição/edição no front. =====
const CAMPOS_DESLOCAMENTO = [
  { chave: 'deslocamento', label: 'Andar' },
  { chave: 'deslocNadar', label: 'Nadar' },
  { chave: 'deslocVoar', label: 'Voar' },
  { chave: 'deslocEscalar', label: 'Escalar' },
  { chave: 'salto', label: 'Salto' },
];

const UNIDADES_DESLOCAMENTO = [
  { chave: 'm', label: 'M' },
  { chave: 'ft', label: 'ft' },
  { chave: 'square', label: 'square' },
];

// Conversão de jogo (não a real 0,3048 m/ft): 1 quadrado = 1,5 m = 5 pés.
const FT_POR_METRO = 10 / 3;
const METROS_POR_QUADRADO = 1.5;

const unidadeDeslocamento = ref('m');
const deslocDisplay = reactive({});

const unidadeLabelAtual = computed(() =>
    UNIDADES_DESLOCAMENTO.find((u) => u.chave === unidadeDeslocamento.value)?.label || '',
);

function arredondar(valor) {
  return Math.round(valor * 100) / 100;
}

function metrosParaUnidade(metros, unidade) {
  if (unidade === 'ft') return metros * FT_POR_METRO;
  if (unidade === 'square') return metros / METROS_POR_QUADRADO;
  return metros;
}

function unidadeParaMetros(valor, unidade) {
  if (unidade === 'ft') return valor / FT_POR_METRO;
  if (unidade === 'square') return valor * METROS_POR_QUADRADO;
  return valor;
}

function sincronizarDeslocDisplay() {
  if (!ficha.value) return;
  CAMPOS_DESLOCAMENTO.forEach((campo) => {
    const metros = ficha.value[campo.chave];
    deslocDisplay[campo.chave] = metros === null || metros === undefined
        ? ''
        : String(arredondar(metrosParaUnidade(Number(metros), unidadeDeslocamento.value)));
  });
}

watch(() => ficha.value, sincronizarDeslocDisplay, { immediate: true });
watch(unidadeDeslocamento, sincronizarDeslocDisplay);

// Só aceita dígitos e um separador decimal (vírgula é normalizada pra ponto).
function onDeslocInput(chave, evento) {
  let bruto = evento.target.value.replace(',', '.').replace(/[^0-9.]/g, '');
  const partes = bruto.split('.');
  if (partes.length > 2) bruto = partes[0] + '.' + partes.slice(1).join('');
  deslocDisplay[chave] = bruto;
  evento.target.value = bruto;

  const numero = bruto === '' || bruto === '.' ? null : Number(bruto);
  ficha.value[chave] = numero === null || Number.isNaN(numero)
      ? null
      : arredondar(unidadeParaMetros(numero, unidadeDeslocamento.value));
  agendarSalvar();
}
</script>

<style scoped>
/* ===== Pontos de vida — bloco personalizado, tema de sangue ===== */
.fc-vida-block {
  position: relative;
  overflow: hidden;
  display: flex;
  flex-direction: column;
  gap: 10px;
  padding: 14px;
  margin-bottom: 16px;
  background: linear-gradient(90deg, var(--bg-card), var(--bg-sub));
  border: 2px solid var(--border-color);
  box-shadow: inset 0 0 0 1px rgba(0, 0, 0, 0.4);
}

.fc-vida-topo,
.fc-vida-bar,
.fc-vida-qtd,
.fc-vida-adjust,
.fc-vida-max-detalhe {
  position: relative;
  z-index: 1;
}

.fc-vida-topo {
  display: flex;
  align-items: center;
  justify-content: space-between;
  gap: 10px;
  flex-wrap: wrap;
  width: 100%;
  background: none;
  border: none;
  padding: 0;
  margin: 0;
  font: inherit;
  text-align: left;
  cursor: pointer;
}

.fc-vida-titulo {
  font-family: 'Cinzel', serif;
  font-weight: 700;
  font-size: 24px;
  letter-spacing: 0.04em;
  text-transform: uppercase;
  color: var(--pale-green);
}

.fc-vida-numero {
  font-family: 'Cinzel Decorative', 'Cinzel', serif;
  font-weight: 700;
  font-size: 38px;
  color: var(--accent-color);
  text-shadow: 0 0 12px color-mix(in srgb, var(--accent-color) 35%, transparent);
}

.fc-vida-max {
  font-size: 26px;
  color: var(--pale-green);
}

.fc-vida-temp {
  color: color-mix(in srgb, var(--magic-color) 45%, white);
}

.fc-vida-temp-plus {
  color: color-mix(in srgb, var(--magic-color) 45%, white);
  margin: 0 2px;
}

.fc-vida-bar {
  height: 20px;
  display: flex;
  border: 1px solid var(--border-gold);
  border-radius: 4px;
  background: linear-gradient(180deg, var(--bg-sub), var(--bg-main));
  box-shadow: inset 0 2px 6px rgba(0, 0, 0, 0.9);
  overflow: hidden;
}

.fc-vida-bar-fill {
  height: 100%;
  background: linear-gradient(180deg, color-mix(in srgb, var(--accent-color) 60%, white), var(--accent-color) 55%, color-mix(in srgb, var(--accent-color) 70%, black));
  box-shadow: 0 0 12px color-mix(in srgb, var(--accent-color) 55%, transparent), inset 0 1px 0 rgba(210, 255, 225, 0.3);
  transition: width 0.2s ease;
}

.fc-vida-bar-temp {
  height: 100%;
  background: repeating-linear-gradient(45deg, color-mix(in srgb, var(--magic-color) 60%, white) 0 4px, var(--magic-color) 4px 8px);
  box-shadow: 0 0 12px color-mix(in srgb, var(--magic-color) 60%, transparent);
  transition: width 0.2s ease;
}

.fc-vida-bar-legenda {
  display: flex;
  justify-content: space-between;
  font-family: 'Cinzel', serif;
  font-size: 9px;
  letter-spacing: 0.1em;
  text-transform: uppercase;
  color: var(--text-muted);
}

.fc-vida-bar-temp-label {
  color: color-mix(in srgb, var(--magic-color) 45%, white);
  text-shadow: 0 0 10px color-mix(in srgb, var(--magic-color) 60%, transparent);
}

.fc-vida-max-detalhe {
  display: flex;
  flex-direction: column;
  gap: 6px;
  padding: 10px;
  border: 1px solid var(--border-color);
  background: rgba(0, 0, 0, 0.25);
}

.fc-vida-max-item {
  display: flex;
  gap: 6px;
  align-items: center;
}

.fc-vida-max-item input[type='text'] {
  flex: 1;
  min-width: 0;
}

.fc-vida-max-item .fc-mini-number {
  flex: none;
  width: 56px;
  text-align: center;
}

.fc-vida-qtd {
  flex: 1;
  box-sizing: border-box;
  padding: 8px 4px !important;
  text-align: center;
  background: var(--bg-sub) !important;
  color: var(--text-main) !important;
}

.fc-vida-qtd-spinner {
  flex: none;
  width: 140px;
}

.fc-vida-qtd-spinner .qty-btn {
  font-size: 18px;
  line-height: 1;
}

.fc-vida-qtd-linha {
  display: flex;
  align-items: center;
  gap: 10px;
}

.fc-vida-qtd-ornamento {
  position: relative;
  flex: 1;
  height: 1px;
  background: var(--border-color);
}

.fc-vida-qtd-ornamento::before {
  content: '';
  position: absolute;
  top: 50%;
  left: 50%;
  width: 8px;
  height: 8px;
  background: var(--accent-title);
  transform: translate(-50%, -50%) rotate(45deg);
}

.fc-vida-adjust {
  display: flex;
  flex-direction: column;
  gap: 8px;
}

.fc-vida-adjust-botoes {
  display: flex;
  gap: 6px;
}

.fc-vida-adjust-botoes .fc-btn {
  flex: 1;
}

.fc-btn-dano,
.fc-btn-cura,
.fc-btn-temp {
  border-width: 1px;
  border-style: solid;
  box-shadow: none;
  transition: filter 0.2s ease;
}

.fc-btn-dano {
  background: var(--btn-damage-bg);
  border-color: rgba(254, 205, 213, 0.3);
  color: var(--btn-damage-text);
}

.fc-vida-adjust .fc-btn-dano:hover {
  filter: brightness(1.1);
}

.fc-btn-cura {
  background: var(--btn-heal-bg);
  border-color: rgba(220, 252, 231, 0.3);
  color: var(--btn-heal-text);
}

.fc-vida-adjust .fc-btn-cura:hover {
  filter: brightness(1.1);
}

.fc-btn-temp {
  background: var(--btn-temp-bg);
  border-color: rgba(243, 232, 255, 0.3);
  color: var(--btn-temp-text);
}

.fc-vida-adjust .fc-btn-temp:hover {
  filter: brightness(1.1);
}

/* Gotículas de sangue nos cantos. */
.fc-goticula {
  position: absolute;
  z-index: 1;
  width: 10px;
  height: 10px;
  background: var(--tribal-red);
  border-radius: 50% 50% 50% 0;
  transform: rotate(-45deg);
  box-shadow: 0 0 3px color-mix(in srgb, var(--tribal-red) 70%, transparent);
}

.fc-goticula-tl { top: 8px; left: 8px; }
.fc-goticula-tr { top: 8px; right: 8px; }
.fc-goticula-bl { bottom: 8px; left: 8px; }
.fc-goticula-br { bottom: 8px; right: 8px; }

.fc-badge-grid {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 12px;
}

.fc-badge-card {
  position: relative;
  display: flex;
  align-items: center;
  gap: 14px;
  border: 1px solid var(--border-color);
  background:
    radial-gradient(color-mix(in srgb, var(--text-main) 6%, transparent) 1px, transparent 1.4px) 0 0/16px 16px,
    linear-gradient(160deg, var(--bg-sub), var(--bg-main));
  box-shadow: inset 0 0 32px rgba(0, 0, 0, 0.65);
  padding: 14px 16px;
  cursor: pointer;
  font-family: inherit;
  transition: border-color 0.2s ease, box-shadow 0.2s ease;
}

.fc-badge-card:first-child {
  justify-content: flex-end;
}

.fc-badge-card:hover {
  border-color: var(--tribal-gold);
}

.fc-badge-card-active {
  border-color: color-mix(in srgb, var(--accent-title) 70%, transparent);
  box-shadow: inset 0 0 32px rgba(0, 0, 0, 0.65), 0 0 18px color-mix(in srgb, var(--accent-title) 20%, transparent);
}

.fc-badge-texto {
  display: flex;
  flex-direction: column;
  gap: 5px;
}

.fc-badge-card:first-child .fc-badge-texto {
  align-items: flex-end;
  text-align: right;
}

.fc-badge-titulo {
  font-family: 'Cinzel', serif;
  font-weight: 700;
  font-size: 11px;
  letter-spacing: 0.18em;
  text-transform: uppercase;
  color: var(--text-muted);
}

.fc-badge-card-active .fc-badge-titulo {
  color: var(--tribal-yellow);
  text-shadow: 0 0 10px color-mix(in srgb, var(--accent-title) 50%, transparent);
}

.fc-badge-sub {
  font-family: 'Cinzel', serif;
  font-size: 9px;
  letter-spacing: 0.1em;
  text-transform: uppercase;
  color: var(--text-muted);
}

.fc-badge-medalha-wrap {
  position: relative;
  flex: none;
  width: 56px;
  height: 56px;
  display: flex;
  align-items: center;
  justify-content: center;
}

.fc-badge-medalha {
  position: relative;
  width: 56px;
  height: 56px;
  border-radius: 50%;
  background: var(--bg-card);
  overflow: hidden;
  display: flex;
  align-items: center;
  justify-content: center;
  transform-origin: center;
  transition: background 0.2s ease, box-shadow 0.2s ease, transform 0.9s cubic-bezier(0.22, 1, 0.36, 1);
}

.fc-badge-medalha-anel {
  position: absolute;
  width: 82%;
  height: 82%;
  border: 4px solid var(--border-color);
  border-radius: 50%;
  z-index: 1;
  transform-origin: center;
  transition: border-color 0.2s ease, transform 0.9s cubic-bezier(0.22, 1, 0.36, 1);
}

.fc-badge-medalha-estrela {
  position: absolute;
  inset: 0;
  background: var(--bg-sub);
  clip-path: polygon(50% 0%, 65% 35%, 100% 50%, 65% 65%, 50% 100%, 35% 65%, 0% 50%, 35% 35%);
  z-index: 2;
  transform-origin: center;
  transition: background 0.2s ease, transform 0.9s cubic-bezier(0.22, 1, 0.36, 1);
}

.fc-badge-icone {
  position: absolute;
  top: 50%;
  left: 50%;
  z-index: 3;
  font-size: 20px;
  line-height: 1;
  color: color-mix(in srgb, var(--text-main) 55%, transparent);
  transform: translate(-50%, calc(-50% + 1px)) scale(1);
  transition: color 0.2s ease, text-shadow 0.2s ease, transform 0.9s cubic-bezier(0.22, 1, 0.36, 1);
}

.fc-badge-card-active .fc-badge-medalha {
  background: color-mix(in srgb, var(--accent-title) 65%, black);
  box-shadow: 0 0 22px color-mix(in srgb, var(--accent-title) 70%, transparent);
  transform: rotate(180deg);
}

.fc-badge-card-active .fc-badge-medalha-anel {
  border-color: color-mix(in srgb, var(--accent-title) 35%, white);
  transform: rotate(-180deg);
}

.fc-badge-card-active .fc-badge-medalha-estrela {
  background: var(--accent-title);
  transform: rotate(90deg);
}

.fc-badge-card-active .fc-badge-icone {
  color: var(--bg-main);
  text-shadow: 0 0 6px rgba(255, 255, 255, 0.6);
  transform: translate(-50%, calc(-50% + 1px));
}

/* O glifo do escudo (⛨) tem uma caixa vertical diferente da estrela (✦) e
   precisa de um empurrão extra pra baixo pra centralizar igual. */
.fc-badge-card-heroico .fc-badge-icone {
  transform: translate(-50%, calc(-50% + 3px)) scale(1);
}

.fc-badge-card-heroico.fc-badge-card-active .fc-badge-icone {
  transform: translate(-50%, calc(-50% + 3px));
}

.fc-box-title-row {
  display: flex;
  align-items: center;
  justify-content: space-between;
}

.fc-ataque-contagem {
  font-family: 'Cinzel', serif;
  font-size: 9px;
  letter-spacing: 0.12em;
  text-transform: uppercase;
  color: var(--pale-green);
  opacity: 0.75;
}

/* ===== Ataques — cartões no tema esmeralda do primeiro cartão de referência ===== */
.fc-ataque-card {
  display: flex;
  flex-direction: column;
}

.fc-ataque-linha {
  display: flex;
  align-items: center;
  gap: 10px;
  border: 1px solid var(--border-color);
  background: linear-gradient(90deg, var(--bg-card), var(--bg-sub));
  padding: 10px 12px;
}

.fc-ataque-nome-view {
  flex: 1;
  min-width: 0;
  display: flex;
  flex-direction: column;
  gap: 2px;
}

.fc-ataque-nome-texto {
  font-family: 'Cinzel Decorative', 'Cinzel', serif;
  font-size: 17px;
  color: var(--text-main);
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
}

.fc-ataque-descricao-preview {
  font-family: 'Crimson Text', Georgia, serif;
  font-style: italic;
  font-size: 12px;
  color: var(--text-muted);
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
}

.fc-ataque-stat {
  flex: none;
  width: 84px;
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 3px;
  padding: 0 8px;
  border-left: 1px solid var(--border-color);
}

.fc-ataque-stat-valor {
  width: 100%;
  font-family: 'Cinzel Decorative', 'Cinzel', serif;
  font-size: 16px;
  text-align: center;
  color: var(--accent-title);
}

.fc-ataque-stat-label {
  max-width: 100%;
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
  font-family: 'Cinzel', serif;
  font-size: 8px;
  letter-spacing: 0.12em;
  text-transform: uppercase;
  color: var(--text-muted);
}

.fc-ataque-rolar,
.fc-ataque-editar {
  flex: none;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 24px;
  line-height: 1;
  padding: 9px 15px;
  cursor: pointer;
  transition: background-color 0.2s ease, border-color 0.2s ease;
}

.fc-ataque-rolar {
  background: var(--accent-title);
  border: 1px solid color-mix(in srgb, var(--accent-title) 60%, white);
  color: var(--bg-main);
}

.fc-ataque-rolar:hover {
  filter: brightness(1.15);
}

.fc-ataque-editar {
  background: transparent;
  border: 1px solid var(--accent-title);
  color: var(--accent-title);
}

.fc-ataque-editar:hover {
  background: color-mix(in srgb, var(--accent-title) 18%, transparent);
}

.fc-ataque-editar-fechar {
  border: 1px solid color-mix(in srgb, var(--btn-damage-bg) 60%, white);
  color: color-mix(in srgb, var(--btn-damage-bg) 60%, white);
}

.fc-ataque-editar-fechar:hover {
  background: color-mix(in srgb, var(--btn-damage-bg) 18%, transparent);
}

.fc-ataque-editar-icone {
  display: inline-block;
}

.fc-ataque-editar-icone-lapis {
  transform: rotate(45deg);
}

.fc-ataque-form {
  display: flex;
  flex-direction: column;
  gap: 10px;
  padding: 12px;
  border: 1px solid var(--border-color);
  border-top: none;
  background: rgba(0, 0, 0, 0.25);
}

.fc-ataque-form-linha {
  display: flex;
  flex-wrap: wrap;
  gap: 8px;
  align-items: center;
}

.fc-ataque-form-linha .fc-select,
.fc-ataque-subcard .fc-select {
  flex: 1;
  min-width: 0;
  height: 38px;
  box-sizing: border-box;
}

.fc-ataque-form-linha .fc-mini-number,
.fc-ataque-subcard .fc-mini-number {
  flex: none;
  width: 64px;
  height: 38px;
  box-sizing: border-box;
}

.fc-ataque-danos {
  display: flex;
  flex-direction: column;
  gap: 8px;
}

.fc-ataque-subcard {
  display: flex;
  flex-wrap: wrap;
  align-items: center;
  gap: 8px;
  border: 1px solid var(--border-color);
  background: rgba(0, 0, 0, 0.2);
  padding: 8px;
}

.fc-ataque-mini-campo {
  flex: none;
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 4px;
}

.fc-ataque-campo-crescer {
  flex: 1;
  min-width: 0;
  align-items: stretch;
}

.fc-ataque-campo-crescer .fc-mini-label {
  text-align: left;
}

.fc-ataque-form-linha input[type='text'] {
  height: 38px;
  box-sizing: border-box;
}

.fc-prof-check-hidden {
  display: none;
}

.fc-prof-box {
  flex: none;
  width: 38px;
  height: 38px;
  box-sizing: border-box;
  background: var(--bg-sub);
  border: 1px solid var(--border-color);
  display: flex;
  align-items: center;
  justify-content: center;
  transition: background-color 0.2s ease, border-color 0.2s ease, box-shadow 0.2s ease;
}

.fc-prof-box.active {
  background: var(--tribal-yellow);
  border-color: var(--tribal-yellow);
  box-shadow: 0 0 8px color-mix(in srgb, var(--accent-title) 60%, transparent);
}

.fc-prof-star {
  color: var(--bg-main);
  font-size: 18px;
  line-height: 1;
}

/* ===== Deslocamento — cabeçalho com título à esquerda e unidade à direita;
   abaixo, uma linha só com "nome [input] sufixo" por campo, separados por | ===== */
.fc-desloc-header {
  display: flex;
  align-items: center;
  justify-content: space-between;
  gap: 10px;
  margin-bottom: 10px;
  flex-wrap: wrap;
}

.fc-desloc-titulo {
  font-family: 'Cinzel', serif;
  font-weight: 700;
  font-size: 13px;
  letter-spacing: 0.2em;
  text-transform: uppercase;
  color: var(--tribal-gold);
}

.fc-desloc-unidade-grupo {
  display: flex;
  align-items: center;
  gap: 10px;
}

.fc-desloc-unidade-label {
  font-family: 'Crimson Text', Georgia, serif;
  font-weight: 500;
  font-size: 16px;
  color: var(--bone);
}

/* Largura fixa (cabe "square", a maior opção) pra trocar de unidade não
   redimensionar o select e empurrar o resto do cabeçalho. */
select.fc-desloc-unidade {
  flex: none;
  width: 100px;
  padding: 6px 24px 6px 10px;
  font-size: 15px;
}

.fc-desloc-linha {
  display: flex;
  align-items: center;
  gap: 14px;
  flex-wrap: wrap;
  row-gap: 12px;
}

.fc-desloc-item {
  display: inline-flex;
  align-items: center;
  gap: 8px;
}

.fc-desloc-nome {
  font-family: 'Crimson Text', Georgia, serif;
  font-size: 16px;
  color: var(--pale-green);
}

.fc-desloc-input {
  width: 70px;
  flex: none;
  box-sizing: border-box;
  text-align: center;
  border: 1px solid var(--border-gold);
  border-radius: 6px;
  background: var(--jungle-void);
  padding: 8px 6px;
  font-family: 'Crimson Text', Georgia, serif;
  font-size: 16px;
  color: var(--bone);
}

.fc-desloc-input:focus {
  outline: none;
  border-color: var(--tribal-yellow);
}

/* Largura fixa (cabe "square") pra trocar de unidade não empurrar o próximo
   item da linha — só o texto muda, o espaço reservado fica igual. */
.fc-desloc-sufixo {
  flex: none;
  width: 56px;
  font-family: 'Cinzel', serif;
  font-size: 14px;
  letter-spacing: 0.05em;
  color: var(--tribal-gold);
}

.fc-desloc-separador {
  color: var(--border-color);
  font-size: 18px;
}
</style>
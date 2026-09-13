<template>
  <div class="compendio-alquimia">
    <section class="ca-hero">
      <div class="ca-hero-inner">
        <div class="ca-hero-title-row">
          <h1 class="ca-hero-title">Compêndio de Alquimia</h1>
          <span class="ca-dashed-line"></span>
          <span class="ca-hero-tag">Sala IV</span>
        </div>
        <div class="ca-hero-text-row">
          <p class="ca-hero-text">
            Venenos, resinas e curas feitas com o que só cresce sob o dossel fechado.
          </p>
          <button type="button" class="ca-btn-pergaminhos" @click="mostrarArquivos = !mostrarArquivos">
            {{ mostrarArquivos ? '← Voltar' : 'Pergaminhos' }}
          </button>
        </div>
      </div>
    </section>

    <section v-if="mostrarArquivos" class="ca-arquivos">
      <div class="ca-arquivos-inner">
        <p class="ca-arquivos-texto">
          Os arquivos da Sala da Alquimia ainda estão sendo transcritos.
        </p>

        <div class="ca-essencias-inner">
          <h2 class="ca-essencias-titulo">Essências</h2>
          <div class="grid-essencias">
            <div v-for="e in essencias" :key="e.simbolo" class="chip-essencia" :style="{ borderColor: e.cor, background: e.corFundo }">
              <span class="simbolo" :style="{ color: e.cor }">{{ e.simbolo }}</span>
              <div>
                <strong>{{ e.nome }}</strong>
                <span class="elemento">{{ e.elemento }}</span>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>

    <div v-if="!mostrarArquivos" class="ca-filterbar">
      <div class="ca-filterbar-inner">
        <div class="ca-row">
          <div class="ca-search">
            <span class="ca-search-tag">BUSCA</span>
            <input type="text" v-model="busca" placeholder="nome da poção…" class="ca-search-input" />
          </div>
          <button class="ca-btn-limpar" @click="limparFiltros">Limpar filtros</button>
        </div>

        <div class="ca-subfilter">
          <span class="ca-subfilter-label">Ordenar por</span>
          <div class="ca-row ca-row-wrap">
            <button
                v-for="ord in ORDENS"
                :key="ord.id"
                class="ca-pill-btn ca-pill-btn-gold"
                :class="{ 'ca-pill-btn-ativo': ordem === ord.id }"
                @click="ordem = ord.id"
            >
              <span class="ca-pill-btn-fill" v-if="ordem === ord.id"></span>
              <span class="ca-pill-btn-label">{{ ord.label }}</span>
            </button>
          </div>
        </div>

        <div class="ca-subfilter">
          <span class="ca-subfilter-label">Raridade</span>
          <div class="ca-row ca-row-wrap">
            <button
                v-for="r in raridades"
                :key="r"
                class="ca-pill-btn ca-pill-btn-green"
                :class="{ 'ca-pill-btn-ativo': raridadeSelecionada === r }"
                @click="raridadeSelecionada = r"
            >
              <span class="ca-pill-btn-fill" v-if="raridadeSelecionada === r"></span>
              <span class="ca-pill-btn-label">{{ r === 'todas' ? 'Todas' : r }}</span>
            </button>
          </div>
        </div>
      </div>
    </div>

    <section v-if="!mostrarArquivos" class="ca-results">
      <div class="ca-results-inner">
        <p v-if="!carregando && !erro" class="ca-results-label">{{ resultadoLabel }}</p>

        <p v-if="carregando" class="ca-status">Carregando compêndio…</p>
        <p v-else-if="erro" class="ca-status ca-status-erro">{{ erro }}</p>

        <div v-else class="ca-grid">
          <button v-for="p in pocoesFiltradas" :key="p.id" class="ca-card" @click="abrirDetalhe(p.id)">
            <span class="ca-card-frame-1"></span>
            <span class="ca-card-frame-2"></span>
            <span class="ca-card-frame-3"></span>
            <span class="ca-card-frame-4"></span>
            <span class="ca-card-diamond ca-card-diamond-top"></span>
            <span class="ca-card-diamond ca-card-diamond-bottom"></span>
            <span class="ca-card-diamond ca-card-diamond-left"></span>
            <span class="ca-card-diamond ca-card-diamond-right"></span>

            <span class="ca-card-icone">{{ p.icone || '◆' }}</span>

            <span class="ca-card-info">
              <span class="ca-card-nome">{{ p.nome }}</span>
              <span class="ca-card-bonus-row">
                <span class="ca-card-bonus-badge">{{ p.raridade }}</span>
              </span>
              <span class="ca-card-descricao">{{ p.descricao }}</span>
            </span>
          </button>
        </div>

        <p v-if="!carregando && !erro && pocoesFiltradas.length === 0" class="ca-vazio">
          Nenhuma poção carrega esses sinais.
        </p>
      </div>
    </section>

    <div v-if="detalhe" class="modal-overlay" @click.self="fecharDetalhe">
      <div class="modal-conteudo">
        <button class="fechar" @click="fecharDetalhe">×</button>
        <div class="modal-header">
          <span class="icone-grande">{{ detalhe.icone }}</span>
          <div>
            <h2>{{ detalhe.nome }}</h2>
            <span class="raridade">{{ detalhe.raridade }}</span>
          </div>
        </div>

        <p class="descricao">{{ detalhe.descricao }}</p>

        <div class="grid-info">
          <div><strong>Fórmula:</strong> {{ detalhe.formula }}</div>
          <div><strong>Duração:</strong> {{ detalhe.duracao }}</div>
          <div v-if="detalhe.nucleo"><strong>Núcleo:</strong> {{ detalhe.nucleo }}</div>
        </div>

        <div v-if="detalhe.melhoria" class="secao">
          <h3>Melhoria</h3>
          <p>{{ detalhe.melhoria }}</p>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, computed, onMounted } from 'vue';
import alquimiaService from '../../services/alquimiaService';

const ORDENS = [
  { id: 'az', label: 'A → Z' },
  { id: 'raridade', label: 'Por raridade' },
];

const essencias = ref([]);
const pocoes = ref([]);
const mostrarArquivos = ref(false);
const busca = ref('');
const ordem = ref('az');
const raridadeSelecionada = ref('todas');
const carregando = ref(true);
const erro = ref(null);
const detalhe = ref(null);

// Ordem canônica de raridade (não alfabética) — qualquer valor fora dessa
// lista cai no fim, em ordem alfabética entre si.
const ORDEM_RARIDADE = ['comum', 'incomum', 'raro', 'muito raro', 'lendário'];

function compararRaridade(a, b) {
  const ia = ORDEM_RARIDADE.indexOf(a.toLowerCase());
  const ib = ORDEM_RARIDADE.indexOf(b.toLowerCase());
  if (ia === -1 && ib === -1) return a.localeCompare(b, 'pt');
  if (ia === -1) return 1;
  if (ib === -1) return -1;
  return ia - ib;
}

const raridades = computed(() => {
  const unicas = [...new Set(pocoes.value.map((p) => p.raridade).filter(Boolean))];
  return ['todas', ...unicas.sort(compararRaridade)];
});

function limparFiltros() {
  busca.value = '';
  ordem.value = 'az';
  raridadeSelecionada.value = 'todas';
}

const pocoesFiltradas = computed(() => {
  const termo = busca.value.toLowerCase().trim();
  return pocoes.value
      .filter((p) => {
        if (termo) {
          const alvo = [p.nome, p.raridade, p.descricao].join(' ').toLowerCase();
          if (!alvo.includes(termo)) return false;
        }
        if (raridadeSelecionada.value !== 'todas' && p.raridade !== raridadeSelecionada.value) return false;
        return true;
      })
      .sort((a, b) => {
        if (ordem.value === 'raridade' && a.raridade && b.raridade) {
          const cmp = compararRaridade(a.raridade, b.raridade);
          if (cmp !== 0) return cmp;
        }
        return a.nome.localeCompare(b.nome, 'pt');
      });
});

const resultadoLabel = computed(
    () => `Mostrando ${pocoesFiltradas.value.length} de ${pocoes.value.length} poções`
);

async function carregar() {
  carregando.value = true;
  erro.value = null;
  try {
    [essencias.value, pocoes.value] = await Promise.all([
      alquimiaService.listarEssencias(),
      alquimiaService.listarPocoes(),
    ]);
  } catch (e) {
    erro.value = 'Não foi possível carregar a alquimia.';
  } finally {
    carregando.value = false;
  }
}

async function abrirDetalhe(id) {
  try {
    detalhe.value = await alquimiaService.buscarPocaoPorId(id);
  } catch (e) {
    erro.value = 'Não foi possível carregar os detalhes da poção.';
  }
}

function fecharDetalhe() {
  detalhe.value = null;
}

onMounted(carregar);
</script>

<style scoped>
.compendio-alquimia {
  --jungle-void: var(--bg-deep);
  --jungle-darkest: color-mix(in srgb, var(--bg-deep) 75%, black);
  --jungle-dark: var(--bg-card);
  --jungle-card: var(--bg-card);
  --jungle-moss: var(--bg-subcard);
  --jungle-green: var(--accent-green);
  --tribal-red: var(--accent-terracotta);
  --tribal-gold: var(--accent-gold);
  --tribal-yellow: var(--accent-gold);
  --bone: var(--text-pale);
  --pale-green: var(--text-muted);

  background: var(--jungle-void);
  color: var(--bone);
  min-height: 100vh;
}

/* ===== Hero — padronizado com o Compêndio de Talentos/Raças ===== */
.ca-hero {
  padding: clamp(40px, 6vw, 80px) clamp(16px, 5vw, 64px) 24px;
  background: var(--jungle-dark);
}

.ca-hero-inner {
  max-width: 1200px;
  margin: 0 auto;
  display: flex;
  flex-direction: column;
  gap: 18px;
}

.ca-hero-title-row {
  display: flex;
  align-items: baseline;
  gap: 16px;
  flex-wrap: wrap;
}

.ca-hero-title {
  margin: 0;
  font-family: 'Cinzel Decorative', 'Cinzel', serif;
  font-weight: 700;
  font-size: clamp(26px, 4vw, 44px);
  color: var(--tribal-yellow);
}

.ca-dashed-line {
  flex: 1;
  min-width: 60px;
  height: 1px;
  background: repeating-linear-gradient(90deg, var(--jungle-green) 0 6px, transparent 6px 12px);
}

.ca-hero-tag {
  font-family: 'Cinzel', serif;
  font-size: 11px;
  letter-spacing: 0.24em;
  text-transform: uppercase;
  color: var(--pale-green);
}

.ca-hero-text {
  margin: 0;
  max-width: 70ch;
  font-size: clamp(15px, 1.8vw, 18px);
  line-height: 1.7;
  color: var(--bone);
}

.ca-hero-text-row {
  display: flex;
  align-items: center;
  justify-content: space-between;
  gap: 24px;
  flex-wrap: wrap;
}

.ca-btn-pergaminhos {
  flex: none;
  font-family: 'Cinzel', serif;
  font-weight: 700;
  font-size: 17px;
  letter-spacing: 0.16em;
  text-transform: uppercase;
  padding: 18px 40px;
  background: transparent;
  border: 2px solid var(--tribal-gold);
  color: var(--tribal-yellow);
  cursor: pointer;
  clip-path: polygon(14px 0, 100% 0, 100% calc(100% - 14px), calc(100% - 14px) 100%, 0 100%, 0 14px);
  transition: background-color 0.2s ease, color 0.2s ease;
}

.ca-btn-pergaminhos:hover {
  background: var(--tribal-gold);
  color: var(--jungle-darkest);
}

.ca-arquivos {
  padding: 40px clamp(16px, 5vw, 64px) clamp(56px, 8vw, 96px);
  background: var(--jungle-void);
}

.ca-arquivos-inner {
  max-width: 900px;
  margin: 0 auto;
  padding: clamp(24px, 4vw, 44px);
  border: 1px solid var(--tribal-gold);
  background: var(--jungle-dark);
}

.ca-arquivos-texto {
  margin: 0;
  font-size: clamp(15px, 1.6vw, 17px);
  line-height: 1.9;
  color: var(--bone);
  white-space: pre-line;
}

/* ===== Essências ===== */
.ca-essencias-inner {
  margin-top: 28px;
  padding-top: 24px;
  border-top: 1px dashed var(--jungle-green);
}

.ca-essencias-titulo {
  font-family: 'Cinzel', serif;
  font-size: 1.1rem;
  margin: 0 0 0.75rem;
  color: var(--tribal-yellow);
}

.grid-essencias {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(160px, 1fr));
  gap: 0.6rem;
}

.chip-essencia {
  display: flex;
  align-items: center;
  gap: 0.6rem;
  border: 1px solid;
  border-radius: 8px;
  padding: 0.6rem 0.8rem;
}

.chip-essencia .simbolo {
  font-size: 1.4rem;
  font-family: 'Cinzel', serif;
}

.chip-essencia strong {
  display: block;
  font-size: 0.85rem;
}

.chip-essencia .elemento {
  font-size: 0.7rem;
  opacity: 0.7;
}

.raridade {
  font-size: 0.75rem;
  opacity: 0.7;
  text-transform: capitalize;
}

/* ===== Filtro — padronizado com o Compêndio de Talentos ===== */
.ca-filterbar {
  position: sticky;
  top: 0;
  z-index: 90;
  background: var(--jungle-void);
  border-top: 1px solid var(--jungle-green);
  border-bottom: 1px solid var(--tribal-gold);
  box-shadow: 0 12px 30px rgba(0, 0, 0, 0.5);
}

.ca-filterbar-inner {
  max-width: 1200px;
  margin: 0 auto;
  padding: 18px clamp(16px, 5vw, 64px);
  display: flex;
  flex-direction: column;
  gap: 16px;
}

.ca-row {
  display: flex;
  gap: 12px;
  align-items: center;
}

.ca-row-wrap {
  flex-wrap: wrap;
}

.ca-search {
  flex: 1 1 260px;
  min-width: 0;
  display: flex;
  align-items: center;
  gap: 10px;
  border: 1px solid var(--jungle-green);
  background: var(--jungle-darkest);
  padding: 10px 14px;
  clip-path: polygon(11px 0, 100% 0, 100% calc(100% - 11px), calc(100% - 11px) 100%, 0 100%, 0 11px);
}

.ca-search-tag {
  font-family: ui-monospace, Menlo, monospace;
  font-size: 11px;
  color: var(--pale-green);
  letter-spacing: 0.08em;
}

.ca-search-input {
  flex: 1;
  min-width: 0;
  background: transparent;
  border: none;
  outline: none;
  color: var(--bone);
  font-family: 'Crimson Text', serif;
  font-size: 17px;
}

.ca-btn-limpar {
  font-family: 'Cinzel', serif;
  font-weight: 700;
  font-size: 11px;
  letter-spacing: 0.2em;
  text-transform: uppercase;
  padding: 13px 20px;
  background: transparent;
  border: 1px solid var(--tribal-red);
  color: var(--bone);
  cursor: pointer;
  clip-path: polygon(11px 0, 100% 0, 100% calc(100% - 11px), calc(100% - 11px) 100%, 0 100%, 0 11px);
}

.ca-btn-limpar:hover {
  background: var(--tribal-red);
}

.ca-subfilter {
  display: flex;
  flex-direction: column;
  gap: 8px;
}

.ca-subfilter-label {
  font-family: 'Cinzel', serif;
  font-size: 10px;
  letter-spacing: 0.24em;
  text-transform: uppercase;
  color: var(--pale-green);
}

.ca-pill-btn {
  position: relative;
  overflow: hidden;
  font-family: 'Cinzel', serif;
  font-weight: 700;
  font-size: 11px;
  letter-spacing: 0.18em;
  text-transform: uppercase;
  padding: 11px 18px;
  background: transparent;
  color: var(--bone);
  cursor: pointer;
  clip-path: polygon(10px 0, 100% 0, 100% calc(100% - 10px), calc(100% - 10px) 100%, 0 100%, 0 10px);
}

.ca-pill-btn-gold { border: 1px solid var(--tribal-gold); }
.ca-pill-btn-green { border: 1px solid var(--jungle-green); }

.ca-pill-btn-fill {
  position: absolute;
  inset: 0;
  background: var(--jungle-green);
}

.ca-pill-btn-label {
  position: relative;
}

/* ===== Resultados / mostruário — padronizado com o Compêndio de Talentos ===== */
.ca-results {
  padding: 28px clamp(16px, 5vw, 64px) clamp(56px, 8vw, 96px);
  background: var(--jungle-void);
}

.ca-results-inner {
  max-width: 1200px;
  margin: 0 auto;
  display: flex;
  flex-direction: column;
  gap: 20px;
}

.ca-results-label {
  margin: 0;
  font-family: ui-monospace, Menlo, monospace;
  font-size: 11px;
  letter-spacing: 0.1em;
  color: var(--pale-green);
}

.ca-status {
  margin: 0;
  padding: 60px 0;
  text-align: center;
  font-size: 17px;
  color: var(--pale-green);
}

.ca-status-erro {
  color: var(--tribal-red);
}

.ca-grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(220px, 1fr));
  gap: 18px;
}

.ca-card {
  position: relative;
  overflow: visible;
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 14px;
  text-align: center;
  padding: 26px 18px;
  background: transparent;
  border: none;
  color: inherit;
  font: inherit;
  cursor: pointer;
  min-width: 0;
}

.ca-card:hover {
  filter: drop-shadow(0 0 12px rgba(212, 163, 89, 0.35));
}

.ca-card-frame-1 {
  position: absolute;
  inset: 0;
  background: var(--tribal-gold);
  pointer-events: none;
  clip-path: polygon(20px 0, calc(100% - 20px) 0, 100% 20px, 100% calc(100% - 20px), calc(100% - 20px) 100%, 20px 100%, 0 calc(100% - 20px), 0 20px);
}

.ca-card-frame-2 {
  position: absolute;
  inset: 2px;
  background: var(--jungle-card);
  pointer-events: none;
  clip-path: polygon(18px 0, calc(100% - 18px) 0, 100% 18px, 100% calc(100% - 18px), calc(100% - 18px) 100%, 18px 100%, 0 calc(100% - 18px), 0 18px);
}

.ca-card-frame-3 {
  position: absolute;
  inset: 7px;
  background: rgba(35, 110, 71, 0.75);
  pointer-events: none;
  clip-path: polygon(14px 0, calc(100% - 14px) 0, 100% 14px, 100% calc(100% - 14px), calc(100% - 14px) 100%, 14px 100%, 0 calc(100% - 14px), 0 14px);
}

.ca-card-frame-4 {
  position: absolute;
  inset: 8px;
  background: var(--jungle-card);
  pointer-events: none;
  clip-path: polygon(13px 0, calc(100% - 13px) 0, 100% 13px, 100% calc(100% - 13px), calc(100% - 13px) 100%, 13px 100%, 0 calc(100% - 13px), 0 13px);
}

.ca-card-diamond {
  position: absolute;
  width: 13px;
  height: 13px;
  background: var(--tribal-gold);
  pointer-events: none;
}

.ca-card-diamond-top { top: 0; left: 50%; transform: translate(-50%, -50%) rotate(45deg); }
.ca-card-diamond-bottom { bottom: 0; left: 50%; transform: translate(-50%, 50%) rotate(45deg); }
.ca-card-diamond-left { left: 0; top: 50%; transform: translate(-50%, -50%) rotate(45deg); }
.ca-card-diamond-right { right: 0; top: 50%; transform: translate(50%, -50%) rotate(45deg); }

.ca-card-icone {
  position: relative;
  font-size: 40px;
  line-height: 1;
}

.ca-card-info {
  position: relative;
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 8px;
  min-width: 0;
}

.ca-card-nome {
  font-family: 'Cinzel Decorative', 'Cinzel', serif;
  font-weight: 700;
  font-size: 18px;
  line-height: 1.2;
  color: var(--bone);
}

.ca-card-bonus-row {
  display: flex;
  flex-wrap: wrap;
  justify-content: center;
  gap: 6px;
}

.ca-card-bonus-badge {
  font-family: 'Cinzel', serif;
  font-size: 10px;
  font-weight: 700;
  letter-spacing: 0.18em;
  text-transform: uppercase;
  padding: 5px 10px;
  border: 1px solid var(--tribal-gold);
  color: var(--tribal-yellow);
  clip-path: polygon(7px 0, 100% 0, 100% calc(100% - 7px), calc(100% - 7px) 100%, 0 100%, 0 7px);
}

.ca-card-descricao {
  font-size: 12px;
  line-height: 1.5;
  color: var(--pale-green);
  display: -webkit-box;
  -webkit-line-clamp: 3;
  -webkit-box-orient: vertical;
  overflow: hidden;
}

.ca-vazio {
  margin: 0;
  padding: 60px 0;
  text-align: center;
  font-style: italic;
  font-size: 18px;
  color: var(--pale-green);
}

.modal-overlay {
  position: fixed;
  inset: 0;
  background: rgba(0, 0, 0, 0.7);
  display: flex;
  align-items: center;
  justify-content: center;
  padding: 1rem;
  z-index: 100;
}

.modal-conteudo {
  background: var(--jungle-void);
  border: 1px solid var(--tribal-gold);
  border-radius: 12px;
  padding: 2rem;
  max-width: 560px;
  width: 100%;
  max-height: 85vh;
  overflow-y: auto;
  position: relative;
}

.fechar {
  position: absolute;
  top: 0.75rem;
  right: 1rem;
  background: none;
  border: none;
  color: var(--bone);
  font-size: 1.5rem;
  cursor: pointer;
}

.modal-header {
  display: flex;
  gap: 1rem;
  align-items: center;
  margin-bottom: 1rem;
}

.icone-grande {
  font-size: 2.2rem;
}

.descricao {
  margin-bottom: 1rem;
  line-height: 1.5;
}

.grid-info {
  display: grid;
  gap: 0.4rem;
  margin-bottom: 1rem;
  font-size: 0.9rem;
}

.secao h3 {
  font-family: 'Cinzel', serif;
  font-size: 1rem;
  margin-bottom: 0.5rem;
  border-bottom: 1px solid var(--tribal-gold);
  padding-bottom: 0.3rem;
}
</style>
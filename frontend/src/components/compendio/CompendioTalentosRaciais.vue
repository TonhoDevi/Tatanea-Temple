<template>
  <div class="ct-page">
    <section class="ct-hero">
      <div class="ct-hero-inner">
        <div class="ct-hero-title-row">
          <h1 class="ct-hero-title">Compêndio de Talentos</h1>
          <span class="ct-dashed-line"></span>
          <span class="ct-hero-tag">Sala III</span>
        </div>
        <p class="ct-hero-text">
          Marcas ganhas no corpo. Cada talento deixa cicatriz, tinta ou dívida.
        </p>
        <div class="ct-tabs">
          <router-link to="/talentos" class="ct-tab">Talentos Comuns</router-link>
          <router-link to="/talentos-raciais" class="ct-tab ct-tab-ativo">Talentos Raciais</router-link>
        </div>
      </div>
    </section>

    <div class="ct-filterbar">
      <div class="ct-filterbar-inner">
        <div class="ct-row">
          <div class="ct-search">
            <span class="ct-search-tag">BUSCA</span>
            <input type="text" v-model="busca" placeholder="nome do talento…" class="ct-search-input" />
          </div>
          <button class="ct-btn-limpar" @click="limparFiltros">Limpar filtros</button>
        </div>

        <div class="ct-subfilter">
          <span class="ct-subfilter-label">Raça</span>
          <select v-model="racaSelecionada" class="ct-select">
            <option value="">Todas as raças</option>
            <option v-for="r in racasDisponiveis" :key="r.id" :value="r.id">{{ r.nome }}</option>
          </select>
        </div>

        <div class="ct-subfilter">
          <span class="ct-subfilter-label">Ordenar por</span>
          <div class="ct-row ct-row-wrap">
            <button
                v-for="ord in ORDENS"
                :key="ord.id"
                class="ct-pill-btn ct-pill-btn-gold"
                :class="{ 'ct-pill-btn-ativo': ordem === ord.id }"
                @click="ordem = ord.id"
            >
              <span class="ct-pill-btn-fill" v-if="ordem === ord.id"></span>
              <span class="ct-pill-btn-label">{{ ord.label }}</span>
            </button>
          </div>
        </div>
      </div>
    </div>

    <section class="ct-results">
      <div class="ct-results-inner">
        <p v-if="!carregando && !erro" class="ct-results-label">{{ resultadoLabel }}</p>

        <p v-if="carregando" class="ct-status">Carregando compêndio…</p>
        <p v-else-if="erro" class="ct-status ct-status-erro">{{ erro }}</p>

        <div v-else class="ct-grid">
          <button
              v-for="t in listaFiltrada"
              :key="t.id"
              class="ct-card"
              @click="abrir(t)"
          >
            <span class="ct-card-frame-1"></span>
            <span class="ct-card-frame-2"></span>
            <span class="ct-card-frame-3"></span>
            <span class="ct-card-frame-4"></span>
            <span class="ct-card-diamond ct-card-diamond-top"></span>
            <span class="ct-card-diamond ct-card-diamond-bottom"></span>
            <span class="ct-card-diamond ct-card-diamond-left"></span>
            <span class="ct-card-diamond ct-card-diamond-right"></span>

            <span class="ct-card-icone">{{ t.icone || '◆' }}</span>

            <span class="ct-card-info">
              <span class="ct-card-nome">{{ t.nome }}</span>
              <span class="ct-card-requisito-badge">{{ t.racaNome }} · nível {{ t.nivelMinimo }}</span>
              <span class="ct-card-bonus-row" v-if="t.atributos && t.atributos.length">
                <span v-for="(a, i) in t.atributos" :key="i" class="ct-card-bonus-badge">
                  +{{ a.atributo ? (ATR_ABREV[a.atributo] || a.atributo) : 'ESCOLHA' }}
                </span>
              </span>
              <span v-else class="ct-card-bonus-badge ct-card-bonus-badge-vazio">sem bônus</span>
            </span>
          </button>
        </div>

        <p v-if="!carregando && !erro && listaFiltrada.length === 0" class="ct-vazio">
          Nenhum talento racial carrega esses sinais.
        </p>
      </div>
    </section>
  </div>
</template>

<script setup>
import { ref, computed, onMounted } from 'vue';
import { useRouter } from 'vue-router';
import talentoRacialService from '../../services/talentoRacialService';
import { racaService } from '../../services/racaService';

const ATR_ABREV = {
  forca: 'FOR', destreza: 'DES', constituicao: 'CON',
  inteligencia: 'INT', sabedoria: 'SAB', carisma: 'CAR',
};
const ORDENS = [
  { id: 'az', label: 'A → Z' },
  { id: 'nivel', label: 'Nível mínimo' },
];

const router = useRouter();

const talentos = ref([]);
const racasDisponiveis = ref([]);
const carregando = ref(true);
const erro = ref(null);

const busca = ref('');
const racaSelecionada = ref('');
const ordem = ref('az');

function limparFiltros() {
  busca.value = '';
  racaSelecionada.value = '';
  ordem.value = 'az';
}

const listaFiltrada = computed(() => {
  const q = busca.value.trim().toLowerCase();
  return talentos.value
      .filter((t) => {
        if (q && !t.nome.toLowerCase().includes(q)) return false;
        if (racaSelecionada.value && String(t.racaId) !== String(racaSelecionada.value)) return false;
        return true;
      })
      .sort((a, b) => {
        if (ordem.value === 'nivel') {
          if (a.nivelMinimo !== b.nivelMinimo) return a.nivelMinimo - b.nivelMinimo;
        }
        return a.nome.localeCompare(b.nome, 'pt');
      });
});

const resultadoLabel = computed(
    () => `Mostrando ${listaFiltrada.value.length} de ${talentos.value.length} talentos raciais`
);

function abrir(talento) {
  router.push(`/talentos-raciais/${talento.id}`);
}

onMounted(async () => {
  try {
    talentos.value = await talentoRacialService.listar();
  } catch (e) {
    erro.value = 'Não foi possível carregar o compêndio de talentos raciais.';
  } finally {
    carregando.value = false;
  }

  try {
    const todas = await racaService.listar();
    racasDisponiveis.value = [...todas].sort((a, b) => a.nome.localeCompare(b.nome, 'pt'));
  } catch (e) {
    // Filtro de raça é complementar — não bloqueia a listagem de talentos.
  }
});
</script>

<style scoped>
.ct-page {
  --jungle-void: #0b2013;
  --jungle-darkest: #071a0f;
  --jungle-dark: #0e2818;
  --jungle-card: #123020;
  --jungle-moss: #1a3d26;
  --jungle-green: #2e7d4f;
  --tribal-red: #b8362f;
  --tribal-gold: #c9a227;
  --tribal-yellow: #e8c14a;
  --bone: #f2ede1;
  --pale-green: #a8c4a2;

  background: var(--jungle-dark);
  color: var(--bone);
  font-family: 'Crimson Text', Georgia, serif;
  min-height: 100vh;
}

.ct-hero {
  padding: clamp(40px, 6vw, 80px) clamp(16px, 5vw, 64px) 24px;
  background: var(--jungle-dark);
}

.ct-hero-inner {
  max-width: 1200px;
  margin: 0 auto;
  display: flex;
  flex-direction: column;
  gap: 18px;
}

.ct-hero-title-row {
  display: flex;
  align-items: baseline;
  gap: 16px;
  flex-wrap: wrap;
}

.ct-hero-title {
  margin: 0;
  font-family: 'Cinzel Decorative', 'Cinzel', serif;
  font-weight: 700;
  font-size: clamp(26px, 4vw, 44px);
  color: var(--tribal-yellow);
}

.ct-dashed-line {
  flex: 1;
  min-width: 60px;
  height: 1px;
  background: repeating-linear-gradient(90deg, var(--jungle-green) 0 6px, transparent 6px 12px);
}

.ct-hero-tag {
  font-family: 'Cinzel', serif;
  font-size: 11px;
  letter-spacing: 0.24em;
  text-transform: uppercase;
  color: var(--pale-green);
}

.ct-hero-text {
  margin: 0;
  max-width: 70ch;
  font-size: clamp(15px, 1.8vw, 18px);
  line-height: 1.7;
  color: var(--bone);
}

.ct-tabs {
  display: flex;
  gap: 10px;
}

.ct-tab {
  font-family: 'Cinzel', serif;
  font-weight: 700;
  font-size: 12px;
  letter-spacing: 0.14em;
  text-transform: uppercase;
  padding: 10px 18px;
  border: 1px solid var(--jungle-green);
  color: var(--pale-green);
  text-decoration: none;
  clip-path: polygon(10px 0, 100% 0, 100% calc(100% - 10px), calc(100% - 10px) 100%, 0 100%, 0 10px);
}

.ct-tab:hover {
  border-color: var(--tribal-yellow);
  color: var(--bone);
}

.ct-tab-ativo {
  background: var(--jungle-green);
  border-color: var(--tribal-gold);
  color: var(--bone);
}

.ct-filterbar {
  position: sticky;
  top: 0;
  z-index: 90;
  background: var(--jungle-void);
  border-top: 1px solid var(--jungle-green);
  border-bottom: 1px solid var(--tribal-gold);
  box-shadow: 0 12px 30px rgba(0, 0, 0, 0.5);
}

.ct-filterbar-inner {
  max-width: 1200px;
  margin: 0 auto;
  padding: 18px clamp(16px, 5vw, 64px);
  display: flex;
  flex-direction: column;
  gap: 16px;
}

.ct-select {
  align-self: flex-start;
  min-width: 220px;
  font-family: 'Crimson Text', serif;
  font-size: 15px;
  padding: 10px 14px;
  border: 1px solid var(--jungle-green);
  background: var(--jungle-darkest);
  color: var(--bone);
  clip-path: polygon(11px 0, 100% 0, 100% calc(100% - 11px), calc(100% - 11px) 100%, 0 100%, 0 11px);
}

.ct-select:hover,
.ct-select:focus {
  border-color: var(--tribal-yellow);
  outline: none;
}

.ct-select option {
  background: var(--jungle-dark);
  color: var(--bone);
}

.ct-row {
  display: flex;
  gap: 12px;
  align-items: center;
}

.ct-row-wrap {
  flex-wrap: wrap;
}

.ct-search {
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

.ct-search-tag {
  font-family: ui-monospace, Menlo, monospace;
  font-size: 11px;
  color: var(--pale-green);
  letter-spacing: 0.08em;
}

.ct-search-input {
  flex: 1;
  min-width: 0;
  background: transparent;
  border: none;
  outline: none;
  color: var(--bone);
  font-family: 'Crimson Text', serif;
  font-size: 17px;
}

.ct-btn-limpar {
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

.ct-btn-limpar:hover {
  background: var(--tribal-red);
}

.ct-subfilter {
  display: flex;
  flex-direction: column;
  gap: 8px;
}

.ct-subfilter-label {
  font-family: 'Cinzel', serif;
  font-size: 10px;
  letter-spacing: 0.24em;
  text-transform: uppercase;
  color: var(--pale-green);
}

.ct-pill-btn {
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

.ct-pill-btn-gold { border: 1px solid var(--tribal-gold); }

.ct-pill-btn-fill {
  position: absolute;
  inset: 0;
  background: var(--jungle-green);
}

.ct-pill-btn-label {
  position: relative;
}

.ct-results {
  padding: 28px clamp(16px, 5vw, 64px) clamp(56px, 8vw, 96px);
  background: var(--jungle-void);
}

.ct-results-inner {
  max-width: 1200px;
  margin: 0 auto;
  display: flex;
  flex-direction: column;
  gap: 20px;
}

.ct-results-label {
  margin: 0;
  font-family: ui-monospace, Menlo, monospace;
  font-size: 11px;
  letter-spacing: 0.1em;
  color: var(--pale-green);
}

.ct-status {
  margin: 0;
  padding: 60px 0;
  text-align: center;
  font-size: 17px;
  color: var(--pale-green);
}

.ct-status-erro {
  color: var(--tribal-red);
}

.ct-grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(220px, 1fr));
  gap: 18px;
}

.ct-card {
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

.ct-card:hover {
  filter: drop-shadow(0 0 12px rgba(232, 193, 74, 0.35));
}

.ct-card-frame-1 {
  position: absolute;
  inset: 0;
  background: var(--tribal-gold);
  pointer-events: none;
  clip-path: polygon(20px 0, calc(100% - 20px) 0, 100% 20px, 100% calc(100% - 20px), calc(100% - 20px) 100%, 20px 100%, 0 calc(100% - 20px), 0 20px);
}

.ct-card-frame-2 {
  position: absolute;
  inset: 2px;
  background: var(--jungle-card);
  pointer-events: none;
  clip-path: polygon(18px 0, calc(100% - 18px) 0, 100% 18px, 100% calc(100% - 18px), calc(100% - 18px) 100%, 18px 100%, 0 calc(100% - 18px), 0 18px);
}

.ct-card-frame-3 {
  position: absolute;
  inset: 7px;
  background: rgba(46, 125, 79, 0.75);
  pointer-events: none;
  clip-path: polygon(14px 0, calc(100% - 14px) 0, 100% 14px, 100% calc(100% - 14px), calc(100% - 14px) 100%, 14px 100%, 0 calc(100% - 14px), 0 14px);
}

.ct-card-frame-4 {
  position: absolute;
  inset: 8px;
  background: var(--jungle-card);
  pointer-events: none;
  clip-path: polygon(13px 0, calc(100% - 13px) 0, 100% 13px, 100% calc(100% - 13px), calc(100% - 13px) 100%, 13px 100%, 0 calc(100% - 13px), 0 13px);
}

.ct-card-diamond {
  position: absolute;
  width: 13px;
  height: 13px;
  background: var(--tribal-gold);
  pointer-events: none;
}

.ct-card-diamond-top { top: 0; left: 50%; transform: translate(-50%, -50%) rotate(45deg); }
.ct-card-diamond-bottom { bottom: 0; left: 50%; transform: translate(-50%, 50%) rotate(45deg); }
.ct-card-diamond-left { left: 0; top: 50%; transform: translate(-50%, -50%) rotate(45deg); }
.ct-card-diamond-right { right: 0; top: 50%; transform: translate(50%, -50%) rotate(45deg); }

.ct-card-icone {
  position: relative;
  font-size: 40px;
  line-height: 1;
}

.ct-card-info {
  position: relative;
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 8px;
  min-width: 0;
}

.ct-card-nome {
  font-family: 'Cinzel Decorative', 'Cinzel', serif;
  font-weight: 700;
  font-size: 18px;
  line-height: 1.2;
  color: var(--bone);
}

.ct-card-requisito-badge {
  font-family: 'Cinzel', serif;
  font-size: 10px;
  font-weight: 700;
  letter-spacing: 0.1em;
  text-transform: uppercase;
  color: var(--pale-green);
}

.ct-card-bonus-row {
  display: flex;
  flex-wrap: wrap;
  justify-content: center;
  gap: 6px;
}

.ct-card-bonus-badge {
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

.ct-card-bonus-badge-vazio {
  border-color: var(--jungle-green);
  color: var(--pale-green);
}

.ct-vazio {
  margin: 0;
  padding: 60px 0;
  text-align: center;
  font-style: italic;
  font-size: 18px;
  color: var(--pale-green);
}
</style>

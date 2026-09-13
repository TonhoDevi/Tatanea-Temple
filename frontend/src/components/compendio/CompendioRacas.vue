<template>
  <div class="cr-page">
    <section class="cr-hero">
      <div class="cr-hero-inner">
        <div class="cr-hero-title-row">
          <h1 class="cr-hero-title">Compêndio de Raças</h1>
          <span class="cr-dashed-line"></span>
          <span class="cr-hero-tag">Sala I</span>
        </div>
        <div class="cr-hero-text-row">
          <p class="cr-hero-text">
            Nove povos do interior da mata, cada um com um pacto diferente com a floresta.
            Cada ficha traz a linhagem, o corpo e a dívida que aquele povo carrega.
          </p>
          <button type="button" class="cr-btn-pergaminhos" @click="mostrarArquivos = !mostrarArquivos">
            {{ mostrarArquivos ? '← Voltar' : 'Pergaminhos' }}
          </button>
        </div>
      </div>
    </section>

    <section v-if="mostrarArquivos" class="cr-arquivos">
      <div class="cr-arquivos-inner">
        <p class="cr-arquivos-texto">
          Os arquivos da Sala das Raças ainda estão sendo transcritos.
        </p>
      </div>
    </section>

    <div v-if="!mostrarArquivos" class="cr-filterbar">
      <div class="cr-filterbar-inner">
        <div class="cr-cat-label">
          <span class="cr-cat-bullet"></span>
          <span>Categoria</span>
        </div>

        <div class="cr-cat-grid">
          <button
              v-for="cat in categorias"
              :key="cat.chave"
              class="cr-cat-btn"
              :class="{ 'cr-cat-btn-ativo': categoriasSelecionadas.includes(cat.chave) }"
              @click="alternar(categoriasSelecionadas, cat.chave)"
          >
            <span class="cr-cat-btn-fill" v-if="categoriasSelecionadas.includes(cat.chave)"></span>
            <span class="cr-corner cr-corner-tl"></span>
            <span class="cr-corner cr-corner-tr"></span>
            <span class="cr-corner cr-corner-bl"></span>
            <span class="cr-corner cr-corner-br"></span>
            <span class="cr-bracket cr-bracket-tl"></span>
            <span class="cr-bracket cr-bracket-tr"></span>
            <span class="cr-bracket cr-bracket-bl"></span>
            <span class="cr-bracket cr-bracket-br"></span>
            <span class="cr-cat-badge">{{ cat.contagem }}</span>
            <span class="cr-cat-label-text">{{ cat.label }}</span>
          </button>
        </div>

        <div class="cr-row">
          <div class="cr-search">
            <span class="cr-search-tag">BUSCA</span>
            <input type="text" v-model="busca" placeholder="nome da raça…" class="cr-search-input" />
          </div>
          <button class="cr-btn-limpar" @click="limparFiltros">Limpar filtros</button>
        </div>

        <div class="cr-subfilter">
          <span class="cr-subfilter-label">Ordenar por</span>
          <div class="cr-row cr-row-wrap">
            <button
                v-for="ord in ORDENS"
                :key="ord.id"
                class="cr-pill-btn cr-pill-btn-gold"
                :class="{ 'cr-pill-btn-ativo': ordem === ord.id }"
                @click="ordem = ord.id"
            >
              <span class="cr-pill-btn-fill" v-if="ordem === ord.id"></span>
              <span class="cr-pill-btn-label">{{ ord.label }}</span>
            </button>
          </div>
        </div>

        <div class="cr-subfilter">
          <span class="cr-subfilter-label">Tamanho</span>
          <div class="cr-row cr-row-wrap">
            <button
                v-for="tam in tamanhosDisponiveis"
                :key="tam.chave"
                class="cr-pill-btn cr-pill-btn-green"
                :class="{ 'cr-pill-btn-ativo': tamanhosSelecionados.includes(tam.chave) }"
                @click="alternar(tamanhosSelecionados, tam.chave)"
            >
              <span class="cr-pill-btn-fill" v-if="tamanhosSelecionados.includes(tam.chave)"></span>
              <span class="cr-pill-btn-label">{{ tam.label }}</span>
            </button>
          </div>
        </div>
      </div>
    </div>

    <section v-if="!mostrarArquivos" class="cr-results">
      <div class="cr-results-inner">
        <p v-if="!carregando && !erro" class="cr-results-label">{{ resultadoLabel }}</p>

        <p v-if="carregando" class="cr-status">Carregando compêndio…</p>
        <p v-else-if="erro" class="cr-status cr-status-erro">{{ erro }}</p>

        <div v-else class="cr-grid">
          <button
              v-for="raca in listaFiltrada"
              :key="raca.id"
              class="cr-card"
              @click="abrir(raca)"
          >
            <span class="cr-card-frame-1"></span>
            <span class="cr-card-frame-2"></span>
            <span class="cr-card-frame-3"></span>
            <span class="cr-card-frame-4"></span>
            <span class="cr-card-diamond cr-card-diamond-top"></span>
            <span class="cr-card-diamond cr-card-diamond-bottom"></span>
            <span class="cr-card-diamond cr-card-diamond-left"></span>
            <span class="cr-card-diamond cr-card-diamond-right"></span>

            <span class="cr-card-retrato">
              <img v-if="raca.imagemUrl" :src="raca.imagemUrl" :alt="raca.nome" class="cr-card-retrato-img" />
              <span v-else class="cr-card-retrato-placeholder">[ retrato ]</span>
            </span>

            <span class="cr-card-info">
              <span class="cr-card-nome">{{ raca.nome }}</span>
              <span class="cr-card-cat-badge">{{ categoriaSingular(raca.categoria) }}</span>
              <span class="cr-card-hab"><span class="cr-card-hab-icone">⚔</span>{{ raca.quantidadeHabilidadesEspeciais }} habilidades especiais</span>
              <span class="cr-card-tamanho">{{ tamanhoLabel(raca.tamanho) }}</span>
            </span>
          </button>
        </div>

        <p v-if="!carregando && !erro && listaFiltrada.length === 0" class="cr-vazio">
          A mata não devolveu nenhum povo com esses sinais.
        </p>
      </div>
    </section>
  </div>
</template>

<script setup>
import { ref, computed, onMounted } from 'vue';
import { useRouter } from 'vue-router';
import { racaService } from '../../services/racaService';

const CAT = { global: 'Globais', tribal: 'Tribais', mistica: 'Místicas', sobrenatural: 'Sobrenaturais' };
const CAT_SING = { global: 'Global', tribal: 'Tribal', mistica: 'Mística', sobrenatural: 'Sobrenatural' };
const TAM = { miudo: 'Miúdo', pequeno: 'Pequeno', medio: 'Médio', grande: 'Grande', enorme: 'Enorme' };
const ORDEM_TAM = ['miudo', 'pequeno', 'medio', 'grande', 'enorme'];
const ORDENS = [
  { id: 'az', label: 'A → Z' },
  { id: 'habilidades', label: 'Nº de habilidades' },
  { id: 'tamanho', label: 'Tamanho' },
];

const router = useRouter();

const racas = ref([]);
const carregando = ref(true);
const erro = ref(null);

const mostrarArquivos = ref(false);
const busca = ref('');
const categoriasSelecionadas = ref([]);
const tamanhosSelecionados = ref([]);
const ordem = ref('az');

function alternar(lista, valor) {
  const idx = lista.indexOf(valor);
  if (idx === -1) lista.push(valor);
  else lista.splice(idx, 1);
}

function limparFiltros() {
  busca.value = '';
  categoriasSelecionadas.value = [];
  tamanhosSelecionados.value = [];
  ordem.value = 'az';
}

function categoriaSingular(codigo) {
  return CAT_SING[codigo] || codigo;
}

function tamanhoLabel(codigo) {
  return TAM[codigo] || codigo;
}

const categorias = computed(() =>
  Object.keys(CAT).map((chave) => ({
    chave,
    label: CAT[chave],
    contagem: racas.value.filter((r) => r.categoria === chave).length,
  }))
);

const tamanhosDisponiveis = computed(() =>
  Object.keys(TAM).map((chave) => ({ chave, label: TAM[chave] }))
);

const listaFiltrada = computed(() => {
  const q = busca.value.trim().toLowerCase();
  return racas.value
      .filter((r) => {
        if (q && !r.nome.toLowerCase().includes(q)) return false;
        if (categoriasSelecionadas.value.length && !categoriasSelecionadas.value.includes(r.categoria)) return false;
        if (tamanhosSelecionados.value.length && !tamanhosSelecionados.value.includes(r.tamanho)) return false;
        return true;
      })
      .sort((a, b) => {
        if (ordem.value === 'habilidades') return b.quantidadeHabilidadesEspeciais - a.quantidadeHabilidadesEspeciais;
        if (ordem.value === 'tamanho') return ORDEM_TAM.indexOf(a.tamanho) - ORDEM_TAM.indexOf(b.tamanho);
        return a.nome.localeCompare(b.nome, 'pt');
      });
});

const resultadoLabel = computed(
    () => `Mostrando ${listaFiltrada.value.length} de ${racas.value.length} raças`
);

function abrir(raca) {
  router.push(`/racas/${raca.id}`);
}

onMounted(async () => {
  try {
    racas.value = await racaService.listar();
  } catch (e) {
    erro.value = 'Não foi possível carregar o compêndio de raças.';
  } finally {
    carregando.value = false;
  }
});
</script>

<style scoped>
.cr-page {
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

  background: var(--jungle-dark);
  color: var(--bone);
  font-family: 'Crimson Text', Georgia, serif;
  min-height: 100vh;
}

.cr-hero {
  padding: clamp(40px, 6vw, 80px) clamp(16px, 5vw, 64px) 24px;
  background: var(--jungle-dark);
}

.cr-hero-inner {
  max-width: 1200px;
  margin: 0 auto;
  display: flex;
  flex-direction: column;
  gap: 18px;
}

.cr-hero-title-row {
  display: flex;
  align-items: baseline;
  gap: 16px;
  flex-wrap: wrap;
}

.cr-hero-title {
  margin: 0;
  font-family: 'Cinzel Decorative', 'Cinzel', serif;
  font-weight: 700;
  font-size: clamp(26px, 4vw, 44px);
  color: var(--tribal-yellow);
}

.cr-dashed-line {
  flex: 1;
  min-width: 60px;
  height: 1px;
  background: repeating-linear-gradient(90deg, var(--jungle-green) 0 6px, transparent 6px 12px);
}

.cr-hero-tag {
  font-family: 'Cinzel', serif;
  font-size: 11px;
  letter-spacing: 0.24em;
  text-transform: uppercase;
  color: var(--pale-green);
}

.cr-hero-text {
  margin: 0;
  max-width: 70ch;
  font-size: clamp(15px, 1.8vw, 18px);
  line-height: 1.7;
  color: var(--bone);
}

.cr-hero-text-row {
  display: flex;
  align-items: center;
  justify-content: space-between;
  gap: 24px;
  flex-wrap: wrap;
}

.cr-btn-pergaminhos {
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

.cr-btn-pergaminhos:hover {
  background: var(--tribal-gold);
  color: var(--jungle-darkest);
}

.cr-arquivos {
  padding: 40px clamp(16px, 5vw, 64px) clamp(56px, 8vw, 96px);
  background: var(--jungle-void);
}

.cr-arquivos-inner {
  max-width: 900px;
  margin: 0 auto;
  padding: clamp(24px, 4vw, 44px);
  border: 1px solid var(--tribal-gold);
  background: var(--jungle-dark);
}

.cr-arquivos-texto {
  margin: 0;
  font-size: clamp(15px, 1.6vw, 17px);
  line-height: 1.9;
  color: var(--bone);
  white-space: pre-line;
}

.cr-filterbar {
  position: sticky;
  top: 0;
  z-index: 90;
  background: var(--jungle-void);
  border-top: 1px solid var(--jungle-green);
  border-bottom: 1px solid var(--tribal-gold);
  box-shadow: 0 12px 30px rgba(0, 0, 0, 0.5);
}

.cr-filterbar-inner {
  max-width: 1200px;
  margin: 0 auto;
  padding: 18px clamp(16px, 5vw, 64px);
  display: flex;
  flex-direction: column;
  gap: 16px;
}

.cr-cat-label {
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 8px;
  padding-top: 4px;
}

.cr-cat-bullet {
  width: 14px;
  height: 14px;
  background: var(--jungle-green);
  transform: rotate(45deg);
}

.cr-cat-label span:last-child {
  font-family: 'Cinzel Decorative', 'Cinzel', serif;
  font-size: 20px;
  font-weight: 600;
  letter-spacing: 0.28em;
  text-transform: uppercase;
  color: var(--tribal-gold);
  text-align: center;
}

.cr-cat-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(150px, 1fr));
  gap: 26px;
  padding-top: 14px;
}

.cr-cat-btn {
  position: relative;
  overflow: visible;
  min-height: 96px;
  padding: 26px 18px 20px;
  border: 3px solid var(--tribal-gold);
  background: var(--jungle-dark);
  color: var(--bone);
  font: inherit;
  cursor: pointer;
  display: flex;
  align-items: center;
  justify-content: center;
}

.cr-cat-btn:hover {
  border-color: var(--tribal-yellow);
}

.cr-cat-btn-fill {
  position: absolute;
  inset: 0;
  background: var(--accent-glow);
}

.cr-corner {
  position: absolute;
  width: 16px;
  height: 16px;
  background: var(--tribal-gold);
  transform: rotate(45deg);
}

.cr-corner-tl { top: -9px; left: -9px; }
.cr-corner-tr { top: -9px; right: -9px; }
.cr-corner-bl { bottom: -9px; left: -9px; }
.cr-corner-br { bottom: -9px; right: -9px; }

.cr-bracket {
  position: absolute;
  width: 18px;
  height: 18px;
}

.cr-bracket-tl { top: 4px; left: 4px; border-top: 2px solid var(--jungle-green); border-left: 2px solid var(--jungle-green); }
.cr-bracket-tr { top: 4px; right: 4px; border-top: 2px solid var(--jungle-green); border-right: 2px solid var(--jungle-green); }
.cr-bracket-bl { bottom: 4px; left: 4px; border-bottom: 2px solid var(--jungle-green); border-left: 2px solid var(--jungle-green); }
.cr-bracket-br { bottom: 4px; right: 4px; border-bottom: 2px solid var(--jungle-green); border-right: 2px solid var(--jungle-green); }

.cr-cat-badge {
  position: absolute;
  top: -27px;
  left: 50%;
  transform: translateX(-50%);
  width: 54px;
  height: 54px;
  border-radius: 50%;
  border: 3px solid var(--tribal-gold);
  background: var(--jungle-void);
  display: flex;
  align-items: center;
  justify-content: center;
  font-family: 'Cinzel', serif;
  font-size: 22px;
  font-weight: 700;
  color: var(--tribal-yellow);
}

.cr-cat-label-text {
  position: relative;
  font-family: 'Cinzel', serif;
  font-size: clamp(13px, 1.35vw, 17px);
  font-weight: 700;
  letter-spacing: 0.1em;
  text-transform: uppercase;
  text-align: center;
  line-height: 1.2;
  overflow-wrap: anywhere;
}

.cr-row {
  display: flex;
  gap: 12px;
  align-items: center;
}

.cr-row-wrap {
  flex-wrap: wrap;
}

.cr-search {
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

.cr-search-tag {
  font-family: ui-monospace, Menlo, monospace;
  font-size: 11px;
  color: var(--pale-green);
  letter-spacing: 0.08em;
}

.cr-search-input {
  flex: 1;
  min-width: 0;
  background: transparent;
  border: none;
  outline: none;
  color: var(--bone);
  font-family: 'Crimson Text', serif;
  font-size: 17px;
}

.cr-btn-limpar {
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

.cr-btn-limpar:hover {
  background: var(--tribal-red);
}

.cr-subfilter {
  display: flex;
  flex-direction: column;
  gap: 8px;
}

.cr-subfilter-label {
  font-family: 'Cinzel', serif;
  font-size: 10px;
  letter-spacing: 0.24em;
  text-transform: uppercase;
  color: var(--pale-green);
}

.cr-pill-btn {
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

.cr-pill-btn-gold { border: 1px solid var(--tribal-gold); }
.cr-pill-btn-green { border: 1px solid var(--jungle-green); }

.cr-pill-btn-fill {
  position: absolute;
  inset: 0;
  background: var(--jungle-green);
}

.cr-pill-btn-label {
  position: relative;
}

.cr-results {
  padding: 28px clamp(16px, 5vw, 64px) clamp(56px, 8vw, 96px);
  background: var(--jungle-void);
}

.cr-results-inner {
  max-width: 1200px;
  margin: 0 auto;
  display: flex;
  flex-direction: column;
  gap: 20px;
}

.cr-results-label {
  margin: 0;
  font-family: ui-monospace, Menlo, monospace;
  font-size: 11px;
  letter-spacing: 0.1em;
  color: var(--pale-green);
}

.cr-status {
  margin: 0;
  padding: 60px 0;
  text-align: center;
  font-size: 17px;
  color: var(--pale-green);
}

.cr-status-erro {
  color: var(--tribal-red);
}

.cr-grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(320px, 1fr));
  gap: 18px;
}

.cr-card {
  position: relative;
  overflow: visible;
  display: flex;
  gap: 16px;
  text-align: left;
  padding: 20px;
  background: transparent;
  border: none;
  color: inherit;
  font: inherit;
  cursor: pointer;
  min-width: 0;
}

.cr-card:hover {
  filter: drop-shadow(0 0 12px rgba(212, 163, 89, 0.35));
}

.cr-card-frame-1 {
  position: absolute;
  inset: 0;
  background: var(--tribal-gold);
  pointer-events: none;
  clip-path: polygon(20px 0, calc(100% - 20px) 0, 100% 20px, 100% calc(100% - 20px), calc(100% - 20px) 100%, 20px 100%, 0 calc(100% - 20px), 0 20px);
}

.cr-card-frame-2 {
  position: absolute;
  inset: 2px;
  background: var(--jungle-card);
  pointer-events: none;
  clip-path: polygon(18px 0, calc(100% - 18px) 0, 100% 18px, 100% calc(100% - 18px), calc(100% - 18px) 100%, 18px 100%, 0 calc(100% - 18px), 0 18px);
}

.cr-card-frame-3 {
  position: absolute;
  inset: 7px;
  background: rgba(35, 110, 71, 0.75);
  pointer-events: none;
  clip-path: polygon(14px 0, calc(100% - 14px) 0, 100% 14px, 100% calc(100% - 14px), calc(100% - 14px) 100%, 14px 100%, 0 calc(100% - 14px), 0 14px);
}

.cr-card-frame-4 {
  position: absolute;
  inset: 8px;
  background: var(--jungle-card);
  pointer-events: none;
  clip-path: polygon(13px 0, calc(100% - 13px) 0, 100% 13px, 100% calc(100% - 13px), calc(100% - 13px) 100%, 13px 100%, 0 calc(100% - 13px), 0 13px);
}

.cr-card-diamond {
  position: absolute;
  width: 13px;
  height: 13px;
  background: var(--tribal-gold);
  pointer-events: none;
}

.cr-card-diamond-top { top: 0; left: 50%; transform: translate(-50%, -50%) rotate(45deg); }
.cr-card-diamond-bottom { bottom: 0; left: 50%; transform: translate(-50%, 50%) rotate(45deg); }
.cr-card-diamond-left { left: 0; top: 50%; transform: translate(-50%, -50%) rotate(45deg); }
.cr-card-diamond-right { right: 0; top: 50%; transform: translate(50%, -50%) rotate(45deg); }

.cr-card-retrato {
  position: relative;
  flex: 0 0 104px;
  height: 132px;
  border: 1px solid var(--jungle-green);
  display: flex;
  align-items: flex-end;
  padding: 6px;
  clip-path: polygon(14px 0, 100% 0, 100% calc(100% - 14px), calc(100% - 14px) 100%, 0 100%, 0 14px);
  overflow: hidden;
}

.cr-card-retrato-img {
  position: absolute;
  inset: 0;
  width: 100%;
  height: 100%;
  object-fit: cover;
}

.cr-card-retrato-placeholder {
  font-family: ui-monospace, Menlo, monospace;
  font-size: 9px;
  letter-spacing: 0.06em;
  color: var(--pale-green);
}

.cr-card-info {
  position: relative;
  flex: 1;
  min-width: 0;
  display: flex;
  flex-direction: column;
  gap: 10px;
}

.cr-card-nome {
  font-family: 'Cinzel Decorative', 'Cinzel', serif;
  font-weight: 700;
  font-size: 22px;
  line-height: 1.15;
  color: var(--bone);
}

.cr-card-cat-badge {
  align-self: flex-start;
  font-family: 'Cinzel', serif;
  font-size: 10px;
  font-weight: 700;
  letter-spacing: 0.18em;
  text-transform: uppercase;
  padding: 5px 10px;
  border: 1px solid var(--jungle-green);
  color: var(--tribal-yellow);
  clip-path: polygon(7px 0, 100% 0, 100% calc(100% - 7px), calc(100% - 7px) 100%, 0 100%, 0 7px);
}

.cr-card-hab {
  display: flex;
  align-items: center;
  gap: 8px;
  font-size: 15px;
  color: var(--pale-green);
}

.cr-card-hab-icone {
  color: var(--tribal-yellow);
}

.cr-card-tamanho {
  margin-top: auto;
  font-family: ui-monospace, Menlo, monospace;
  font-size: 10px;
  letter-spacing: 0.06em;
  color: var(--pale-green);
}

.cr-vazio {
  margin: 0;
  padding: 60px 0;
  text-align: center;
  font-style: italic;
  font-size: 18px;
  color: var(--pale-green);
}
</style>

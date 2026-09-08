<template>
  <div class="fichas-page">
    <section class="fichas-hero">
      <div class="fichas-hero-band" aria-hidden="true"></div>
      <div class="fichas-hero-inner">
        <div class="fichas-hero-text">
          <p class="fichas-kicker">Acervo de personagens</p>
          <h1 class="fichas-title">Minhas fichas</h1>
          <div class="fichas-stats">
            <span class="fichas-count">{{ used }}<span class="fichas-count-max">/{{ MAX_FICHAS }}</span></span>
            <span class="fichas-stats-text">fichas usadas — restam <strong>{{ left }}</strong> vagas no acervo</span>
          </div>
          <div class="fichas-progress">
            <div class="fichas-progress-fill" :style="{ width: pct + '%' }"></div>
          </div>
        </div>
        <button class="fichas-btn-criar" @click="criarNovo" :disabled="criando || isFull">
          {{ criando ? 'Criando...' : isFull ? 'Acervo cheio' : '+ Criar nova ficha' }}
        </button>
      </div>
    </section>

    <main class="fichas-main">
      <div v-if="carregando" class="fichas-loading">Carregando fichas...</div>

      <template v-else>
        <div class="fichas-list-heading">
          <h2>Fichas ({{ used }})</h2>
          <span class="fichas-list-rule" aria-hidden="true"></span>
        </div>

        <p v-if="erro" class="fichas-erro">{{ erro }}</p>

        <div v-if="!personagens.length" class="fichas-empty">
          Nenhum personagem ainda. Crie o primeiro acima.
        </div>

        <div v-else class="fichas-list">
          <article v-for="p in personagens" :key="p.id" class="ficha-card">
            <RouterLink :to="`/personagens/${p.id}`" class="ficha-card-art">
              <img v-if="p.imagemUrl" :src="p.imagemUrl" :alt="p.nome" />
              <span v-else>[ retrato ]</span>
            </RouterLink>
            <RouterLink :to="`/personagens/${p.id}`" class="ficha-card-body">
              <h3>{{ p.nome }}</h3>
              <div class="ficha-card-meta">
                <span class="ficha-card-level">Nível {{ p.nivel }}</span>
                <span class="ficha-card-classe">{{ p.classeId || 'Sem classe' }}</span>
              </div>
              <div class="ficha-card-pv">PV {{ p.pvAtual }} / {{ p.pvMaximo }}</div>
            </RouterLink>
            <div class="ficha-card-actions">
              <RouterLink :to="`/personagens/${p.id}`" class="ficha-btn ficha-btn-editar">Editar</RouterLink>
              <button class="ficha-btn ficha-btn-deletar" @click="pedirExclusao(p)">Deletar</button>
            </div>
          </article>
        </div>

        <button v-if="hasRoom" class="ficha-vaga-livre" @click="criarNovo" :disabled="criando">
          + Vaga livre — criar ficha ({{ left }} restantes)
        </button>
        <div v-else class="ficha-cheio-banner">
          Acervo cheio: {{ MAX_FICHAS }} de {{ MAX_FICHAS }} fichas. Delete uma ficha para abrir espaço.
        </div>
      </template>
    </main>

    <div v-if="fichaParaExcluir" class="confirm-overlay" @click.self="cancelarExclusao">
      <div class="confirm-modal">
        <span class="confirm-frame-band" aria-hidden="true"></span>
        <p class="confirm-eyebrow">Templo de Tatânea</p>
        <h3 class="confirm-title">Deletar ficha?</h3>
        <p class="confirm-text">
          Tem certeza que deseja deletar <strong>{{ fichaParaExcluir.nome }}</strong>? Essa ação não pode ser desfeita.
        </p>
        <div class="confirm-actions">
          <button class="confirm-btn confirm-btn-cancelar" @click="cancelarExclusao" :disabled="excluindo">
            Cancelar
          </button>
          <button class="confirm-btn confirm-btn-deletar" @click="confirmarExclusao" :disabled="excluindo">
            {{ excluindo ? 'Deletando...' : 'Deletar' }}
          </button>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, computed, onMounted } from 'vue';
import personagemService from '../services/personagemService';

const MAX_FICHAS = 5;

const personagens = ref([]);
const carregando = ref(true);
const criando = ref(false);
const erro = ref(null);

const fichaParaExcluir = ref(null);
const excluindo = ref(false);

const used = computed(() => personagens.value.length);
const left = computed(() => Math.max(0, MAX_FICHAS - used.value));
const pct = computed(() => Math.min(100, Math.round((used.value / MAX_FICHAS) * 100)));
const hasRoom = computed(() => left.value > 0);
const isFull = computed(() => left.value === 0);

async function carregar() {
  carregando.value = true;
  personagens.value = await personagemService.listar();
  carregando.value = false;
}

async function criarNovo() {
  if (isFull.value) return;

  erro.value = null;
  criando.value = true;
  try {
    const novo = await personagemService.criar({
      nome: 'Novo Personagem',
      tipo: 'dnd',
      nomeJogador: null,
      racaId: null,
      classeId: null,
      nivel: 1,
      imagemUrl: null,
      forca: 10,
      destreza: 10,
      constituicao: 10,
      inteligencia: 10,
      sabedoria: 10,
      carisma: 10,
      pvAtual: 0,
      pvMaximo: 0,
      pvTemporario: 0,
      ca: 10,
      deslocamento: '9 m',
      iniciativaBonus: 0,
      inspiracao: false,
      dadosVidaGastos: 0,
      antecedente: null,
      tendencia: null,
      pontoHeroico: false,
      moedaPc: 0,
      moedaPp: 0,
      moedaPo: 0,
      moedaPe: 0,
      moedaPl: 0,
      deslocNadar: null,
      deslocVoar: null,
      deslocEscalar: null,
      salto: null,
      idiomas: null,
      historia: null,
      anotacoes: null,
      pericias: [],
      ataques: [],
      inventario: [],
      itensMagicos: [],
      habilidades: [],
      magias: [],
      unidades: [],
      tags: [],
    });
    personagens.value.push(novo);
  } catch (e) {
    erro.value = e.response?.data || 'Não foi possível criar a ficha.';
  } finally {
    criando.value = false;
  }
}

function pedirExclusao(p) {
  fichaParaExcluir.value = p;
}

function cancelarExclusao() {
  if (excluindo.value) return;
  fichaParaExcluir.value = null;
}

async function confirmarExclusao() {
  if (!fichaParaExcluir.value) return;
  excluindo.value = true;
  try {
    await personagemService.remover(fichaParaExcluir.value.id);
    personagens.value = personagens.value.filter((p) => p.id !== fichaParaExcluir.value.id);
    fichaParaExcluir.value = null;
  } finally {
    excluindo.value = false;
  }
}

onMounted(carregar);
</script>

<style scoped>
.fichas-page {
  --jungle-void: #0b2013;
  --jungle-darkest: #071a0f;
  --jungle-dark: #0e2818;
  --jungle-moss: #1a3d26;
  --jungle-green: #2e7d4f;
  --tribal-red: #b8362f;
  --tribal-gold: #c9a227;
  --tribal-yellow: #e8c14a;
  --bone: #f2ede1;
  --pale-green: #a8c4a2;

  min-height: 70vh;
  font-family: 'Crimson Text', Georgia, serif;
  background: var(--jungle-dark);
  color: var(--bone);
}

.fichas-hero {
  position: relative;
  padding: clamp(28px, 5vw, 56px) clamp(16px, 5vw, 48px);
  background-color: var(--jungle-void);
  background-image: repeating-linear-gradient(112deg, rgba(46, 125, 79, 0.14) 0 3px, transparent 3px 13px),
  radial-gradient(120% 90% at 50% 0%, var(--jungle-moss) 0, var(--jungle-void) 66%);
  border-bottom: 1px solid var(--jungle-green);
}

.fichas-hero-band {
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  height: 14px;
  background-image: repeating-linear-gradient(
      90deg,
      var(--tribal-gold) 0 4px,
      transparent 4px 10px,
      var(--tribal-red) 10px 14px,
      transparent 14px 26px
  );
  opacity: 0.8;
}

.fichas-hero-inner {
  max-width: 1000px;
  margin: 0 auto;
  display: flex;
  flex-wrap: wrap;
  align-items: flex-end;
  justify-content: space-between;
  gap: 24px;
}

.fichas-hero-text {
  flex: 1 1 300px;
  min-width: 0;
  display: flex;
  flex-direction: column;
  gap: 12px;
}

.fichas-kicker {
  margin: 0;
  font-family: 'Cinzel', serif;
  font-size: 10px;
  letter-spacing: 0.34em;
  text-transform: uppercase;
  color: var(--pale-green);
}

.fichas-title {
  margin: 0;
  font-family: 'Cinzel Decorative', 'Cinzel', serif;
  font-weight: 900;
  font-size: clamp(30px, 6vw, 52px);
  line-height: 1;
  color: var(--bone);
}

.fichas-stats {
  display: flex;
  align-items: baseline;
  gap: 12px;
  flex-wrap: wrap;
}

.fichas-count {
  font-family: 'Cinzel', serif;
  font-weight: 700;
  font-size: clamp(26px, 4vw, 38px);
  color: var(--tribal-yellow);
}

.fichas-count-max {
  color: var(--pale-green);
}

.fichas-stats-text {
  font-size: 17px;
  color: var(--bone);
}

.fichas-stats-text strong {
  color: var(--tribal-yellow);
}

.fichas-progress {
  width: min(420px, 100%);
  height: 10px;
  border: 1px solid var(--jungle-green);
  background: var(--jungle-dark);
  padding: 2px;
  box-sizing: border-box;
}

.fichas-progress-fill {
  height: 100%;
  background-image: repeating-linear-gradient(90deg, var(--tribal-gold) 0 6px, var(--tribal-red) 6px 9px);
  transition: width 0.2s ease;
}

.fichas-btn-criar {
  flex: none;
  padding: 16px 26px;
  background: var(--jungle-green);
  border: 1px solid var(--tribal-yellow);
  color: var(--bone);
  font-family: 'Cinzel', serif;
  font-weight: 700;
  font-size: 12px;
  letter-spacing: 0.2em;
  text-transform: uppercase;
  cursor: pointer;
  transition: background-color 0.2s ease;
}

.fichas-btn-criar:hover:not(:disabled) {
  background: var(--tribal-red);
}

.fichas-btn-criar:disabled {
  opacity: 0.6;
  cursor: not-allowed;
}

.fichas-main {
  flex: 1;
  padding: clamp(24px, 4vw, 44px) clamp(16px, 5vw, 48px);
  max-width: 1000px;
  margin: 0 auto;
  display: flex;
  flex-direction: column;
  gap: 16px;
}

.fichas-loading,
.fichas-empty {
  padding: 2rem;
  text-align: center;
  color: var(--pale-green);
}

.fichas-list-heading {
  display: flex;
  align-items: baseline;
  gap: 14px;
}

.fichas-list-heading h2 {
  margin: 0;
  font-family: 'Cinzel', serif;
  font-weight: 700;
  font-size: 12px;
  letter-spacing: 0.24em;
  text-transform: uppercase;
  color: var(--tribal-gold);
}

.fichas-list-rule {
  flex: 1;
  height: 1px;
  background: repeating-linear-gradient(90deg, var(--jungle-green) 0 6px, transparent 6px 12px);
}

.fichas-erro {
  margin: 0;
  padding: 12px 16px;
  border: 1px solid var(--tribal-red);
  background: rgba(184, 54, 47, 0.14);
  font-size: 15px;
  color: var(--bone);
}

.fichas-list {
  display: flex;
  flex-direction: column;
  gap: 16px;
}

.ficha-card {
  display: flex;
  flex-wrap: wrap;
  align-items: center;
  gap: clamp(14px, 2.4vw, 22px);
  padding: 14px;
  background: var(--jungle-void);
  border: 1px solid var(--jungle-green);
  border-left: 3px solid var(--tribal-gold);
  transition: background-color 0.2s ease, border-color 0.2s ease;
}

.ficha-card:hover {
  background: #123020;
  border-color: var(--tribal-gold);
}

.ficha-card-art {
  flex: none;
  width: 88px;
  height: 88px;
  border: 1px solid rgba(168, 196, 162, 0.45);
  background-image: repeating-linear-gradient(45deg, rgba(46, 125, 79, 0.35) 0 5px, transparent 5px 12px);
  display: flex;
  align-items: flex-end;
  justify-content: center;
  padding: 5px;
  font-family: ui-monospace, Menlo, monospace;
  font-size: 9px;
  line-height: 1.2;
  color: var(--pale-green);
  text-decoration: none;
  overflow: hidden;
}

.ficha-card-art img {
  width: 100%;
  height: 100%;
  object-fit: cover;
}

.ficha-card-body {
  flex: 1 1 220px;
  min-width: 0;
  display: flex;
  flex-direction: column;
  gap: 6px;
  color: inherit;
  text-decoration: none;
}

.ficha-card-body h3 {
  margin: 0;
  font-family: 'Cinzel Decorative', 'Cinzel', serif;
  font-weight: 700;
  font-size: 23px;
  line-height: 1.1;
  color: var(--bone);
}

.ficha-card-meta {
  display: flex;
  flex-wrap: wrap;
  align-items: center;
  gap: 8px 14px;
  font-family: 'Cinzel', serif;
  font-size: 11px;
  letter-spacing: 0.14em;
  text-transform: uppercase;
}

.ficha-card-level {
  padding: 4px 9px;
  background: var(--jungle-green);
  color: var(--bone);
}

.ficha-card-classe {
  color: var(--tribal-yellow);
}

.ficha-card-pv {
  font-size: 15px;
  color: var(--pale-green);
}

.ficha-card-actions {
  flex: none;
  display: flex;
  gap: 10px;
  margin-left: auto;
}

.ficha-btn {
  padding: 11px 18px;
  background: transparent;
  font-family: 'Cinzel', serif;
  font-weight: 600;
  font-size: 11px;
  letter-spacing: 0.16em;
  text-transform: uppercase;
  cursor: pointer;
  text-decoration: none;
  transition: background-color 0.2s ease, color 0.2s ease;
}

.ficha-btn-editar {
  border: 1px solid var(--tribal-gold);
  color: var(--tribal-yellow);
}

.ficha-btn-editar:hover {
  background: var(--tribal-gold);
  color: var(--jungle-void);
}

.ficha-btn-deletar {
  border: 1px solid var(--tribal-red);
  color: var(--bone);
}

.ficha-btn-deletar:hover {
  background: var(--tribal-red);
}

.ficha-vaga-livre {
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 10px;
  padding: 22px;
  background: transparent;
  border: 1px dashed var(--jungle-green);
  color: var(--pale-green);
  font-family: 'Cinzel', serif;
  font-size: 11px;
  letter-spacing: 0.2em;
  text-transform: uppercase;
  cursor: pointer;
  transition: border-color 0.2s ease, color 0.2s ease;
}

.ficha-vaga-livre:hover:not(:disabled) {
  border-color: var(--tribal-yellow);
  color: var(--tribal-yellow);
}

.ficha-vaga-livre:disabled {
  opacity: 0.6;
  cursor: not-allowed;
}

.ficha-cheio-banner {
  padding: 18px;
  border: 1px solid var(--tribal-red);
  background: rgba(184, 54, 47, 0.14);
  font-size: 16px;
  line-height: 1.5;
  color: var(--bone);
}

/* ===== Modal de confirmação de exclusão ===== */
.confirm-overlay {
  position: fixed;
  inset: 0;
  z-index: 50;
  display: flex;
  align-items: center;
  justify-content: center;
  padding: 20px;
  background: rgba(5, 15, 9, 0.72);
}

.confirm-modal {
  position: relative;
  width: 100%;
  max-width: 400px;
  padding: 26px 24px;
  border: 2px solid var(--tribal-gold);
  background: var(--jungle-darkest);
  box-shadow: 0 24px 70px rgba(0, 0, 0, 0.55);
  display: flex;
  flex-direction: column;
  gap: 14px;
}

.confirm-frame-band {
  position: absolute;
  left: -2px;
  right: -2px;
  top: -2px;
  height: 8px;
  background-image: repeating-linear-gradient(
      90deg,
      var(--tribal-gold) 0 8px,
      var(--tribal-red) 8px 12px,
      transparent 12px 24px
  );
}

.confirm-eyebrow {
  margin: 0;
  font-family: 'Cinzel', serif;
  font-size: 10px;
  letter-spacing: 0.3em;
  text-transform: uppercase;
  color: var(--pale-green);
}

.confirm-title {
  margin: 0;
  font-family: 'Cinzel Decorative', 'Cinzel', serif;
  font-weight: 700;
  font-size: 24px;
  color: var(--bone);
}

.confirm-text {
  margin: 0;
  font-size: 16px;
  line-height: 1.5;
  color: var(--pale-green);
}

.confirm-text strong {
  color: var(--bone);
}

.confirm-actions {
  display: flex;
  justify-content: flex-end;
  gap: 10px;
  margin-top: 6px;
}

.confirm-btn {
  padding: 11px 20px;
  font-family: 'Cinzel', serif;
  font-weight: 700;
  font-size: 11px;
  letter-spacing: 0.18em;
  text-transform: uppercase;
  cursor: pointer;
  transition: background-color 0.2s ease;
}

.confirm-btn:disabled {
  opacity: 0.6;
  cursor: not-allowed;
}

.confirm-btn-cancelar {
  background: transparent;
  border: 1px solid var(--jungle-green);
  color: var(--pale-green);
}

.confirm-btn-cancelar:hover:not(:disabled) {
  border-color: var(--tribal-yellow);
  color: var(--tribal-yellow);
}

.confirm-btn-deletar {
  background: var(--tribal-red);
  border: 1px solid var(--tribal-yellow);
  color: var(--bone);
}

.confirm-btn-deletar:hover:not(:disabled) {
  background: #942a24;
}
</style>

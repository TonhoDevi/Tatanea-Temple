<template>
  <div class="compendio-classes">
    <section class="cc-hero">
      <div class="cc-hero-inner">
        <div class="cc-hero-title-row">
          <h1 class="cc-hero-title">Compêndio de Classes</h1>
          <span class="cc-dashed-line"></span>
          <span class="cc-hero-tag">Sala II</span>
        </div>
        <div class="cc-hero-text-row">
          <p class="cc-hero-text">
            Caminhos de combate e de reza — inclusive os que a mata ensina sem pedir permissão.
          </p>
          <button type="button" class="cc-btn-pergaminhos" @click="mostrarArquivos = !mostrarArquivos">
            {{ mostrarArquivos ? '← Voltar' : 'Pergaminhos' }}
          </button>
        </div>
      </div>
    </section>

    <section v-if="mostrarArquivos" class="cc-arquivos">
      <div class="cc-arquivos-inner">
        <p class="cc-arquivos-texto">
          Os arquivos da Sala das Classes ainda estão sendo transcritos.
        </p>
      </div>
    </section>

    <section v-if="!mostrarArquivos" class="cc-results">
      <div class="cc-results-inner">
        <p v-if="carregando" class="cc-status">Carregando compêndio…</p>
        <p v-else-if="erro" class="cc-status cc-status-erro">{{ erro }}</p>

        <template v-else>
          <div class="cc-grupo" v-for="grupo in gruposComClasses" :key="grupo.id">
            <div class="cc-grupo-emblema">
              <div class="cc-grupo-icone-semicirculo" v-if="grupo.icone">
                <span class="cc-grupo-icone">
                  <component :is="grupo.icone" />
                </span>
              </div>

              <div class="cc-grupo-linha-row">
                <span class="cc-grupo-linha"></span>
                <div class="cc-grupo-nome-retangulo">
                  <span class="cc-grupo-retangulo-circulo cc-grupo-retangulo-circulo-tl"></span>
                  <span class="cc-grupo-retangulo-circulo cc-grupo-retangulo-circulo-tr"></span>
                  <span class="cc-grupo-retangulo-circulo cc-grupo-retangulo-circulo-bl"></span>
                  <span class="cc-grupo-retangulo-circulo cc-grupo-retangulo-circulo-br"></span>
                  <span class="cc-grupo-rotulo">{{ grupo.titulo }}</span>
                </div>
                <span class="cc-grupo-linha"></span>
              </div>
            </div>

            <div class="cc-grid">
              <button
                  v-for="c in grupo.classes"
                  :key="c.id"
                  class="cc-card"
                  :style="{ '--cls-cor': c.cor }"
                  @click="abrir(c)"
              >
                <span class="cc-card-frame-1"></span>
                <span class="cc-card-frame-2"></span>
                <span class="cc-card-frame-3"></span>
                <span class="cc-card-frame-4"></span>
                <span class="cc-card-diamond cc-card-diamond-top"></span>
                <span class="cc-card-diamond cc-card-diamond-bottom"></span>
                <span class="cc-card-diamond cc-card-diamond-left"></span>
                <span class="cc-card-diamond cc-card-diamond-right"></span>

                <span class="cc-card-icone">{{ c.icone || '◆' }}</span>

                <span class="cc-card-info">
                  <span class="cc-card-nome">{{ c.nome }}</span>
                  <span class="subtitulo">{{ c.subtitulo }}</span>
                </span>
              </button>
            </div>
          </div>

          <p v-if="classes.length === 0" class="cc-vazio">
            Nenhuma classe cadastrada ainda.
          </p>
        </template>
      </div>
    </section>

  </div>
</template>

<script setup>
import { ref, computed, onMounted, markRaw } from 'vue';
import { useRouter } from 'vue-router';
import classeService from '../../services/classeService';
import IconeGrupoNatural from './icones/IconeGrupoNatural.vue';
import IconeGrupoArcano from './icones/IconeGrupoArcano.vue';
import IconeGrupoDivino from './icones/IconeGrupoDivino.vue';
import IconeGrupoMarcial from './icones/IconeGrupoMarcial.vue';

const router = useRouter();

const classes = ref([]);
const mostrarArquivos = ref(false);
const carregando = ref(true);
const erro = ref(null);

// São só 13 classes (talvez +3/4 no futuro) — não justifica busca nem
// ordenação. O único agrupamento que faz sentido pro jogador é por tipo de
// magia, decidido pelo usuário; fixo aqui em vez de vir do backend porque é
// taxonomia da classe, não um dado que muda com frequência.
const GRUPOS_MAGIA = [
  { id: 'natural', titulo: 'Naturais', icone: markRaw(IconeGrupoNatural), ids: ['caçador', 'druida'] },
  { id: 'arcano', titulo: 'Arcanos', icone: markRaw(IconeGrupoArcano), ids: ['mago', 'feiticeiro', 'bardo'] },
  { id: 'divino', titulo: 'Divinos', icone: markRaw(IconeGrupoDivino), ids: ['clérigo', 'bruxo', 'paladino'] },
  { id: 'marcial', titulo: 'Marciais', icone: markRaw(IconeGrupoMarcial), ids: ['guerreiro', 'bárbaro', 'monge', 'ladino'] },
];

const gruposComClasses = computed(() => {
  const porId = new Map(classes.value.map((c) => [c.id, c]));
  const usados = new Set();

  const grupos = GRUPOS_MAGIA.map((g) => {
    const classesDoGrupo = g.ids.map((id) => porId.get(id)).filter(Boolean);
    classesDoGrupo.forEach((c) => usados.add(c.id));
    return { id: g.id, titulo: g.titulo, icone: g.icone, classes: classesDoGrupo };
  });

  // Classe nova que ainda não entrou em nenhum grupo acima não devia
  // simplesmente sumir da lista — cai aqui até alguém decidir seu tipo.
  const restantes = classes.value.filter((c) => !usados.has(c.id));
  if (restantes.length) {
    grupos.push({ id: 'outras', titulo: 'Outras', classes: restantes });
  }

  return grupos.filter((g) => g.classes.length > 0);
});

async function carregar() {
  carregando.value = true;
  erro.value = null;
  try {
    classes.value = await classeService.listar();
  } catch (e) {
    erro.value = 'Não foi possível carregar as classes.';
  } finally {
    carregando.value = false;
  }
}

function abrir(classe) {
  router.push(`/classes/${classe.id}`);
}

onMounted(carregar);
</script>

<style scoped>
.compendio-classes {
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
.cc-hero {
  padding: clamp(40px, 6vw, 80px) clamp(16px, 5vw, 64px) 24px;
  background: var(--jungle-dark);
}

.cc-hero-inner {
  max-width: 1200px;
  margin: 0 auto;
  display: flex;
  flex-direction: column;
  gap: 18px;
}

.cc-hero-title-row {
  display: flex;
  align-items: baseline;
  gap: 16px;
  flex-wrap: wrap;
}

.cc-hero-title {
  margin: 0;
  font-family: 'Cinzel Decorative', 'Cinzel', serif;
  font-weight: 700;
  font-size: clamp(26px, 4vw, 44px);
  color: var(--tribal-yellow);
}

.cc-dashed-line {
  flex: 1;
  min-width: 60px;
  height: 1px;
  background: repeating-linear-gradient(90deg, var(--jungle-green) 0 6px, transparent 6px 12px);
}

.cc-hero-tag {
  font-family: 'Cinzel', serif;
  font-size: 11px;
  letter-spacing: 0.24em;
  text-transform: uppercase;
  color: var(--pale-green);
}

.cc-hero-text {
  margin: 0;
  max-width: 70ch;
  font-size: clamp(15px, 1.8vw, 18px);
  line-height: 1.7;
  color: var(--bone);
}

.cc-hero-text-row {
  display: flex;
  align-items: center;
  justify-content: space-between;
  gap: 24px;
  flex-wrap: wrap;
}

.cc-btn-pergaminhos {
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

.cc-btn-pergaminhos:hover {
  background: var(--tribal-gold);
  color: var(--jungle-darkest);
}

.cc-arquivos {
  padding: 40px clamp(16px, 5vw, 64px) clamp(56px, 8vw, 96px);
  background: var(--jungle-void);
}

.cc-arquivos-inner {
  max-width: 900px;
  margin: 0 auto;
  padding: clamp(24px, 4vw, 44px);
  border: 1px solid var(--tribal-gold);
  background: var(--jungle-dark);
}

.cc-arquivos-texto {
  margin: 0;
  font-size: clamp(15px, 1.6vw, 17px);
  line-height: 1.9;
  color: var(--bone);
  white-space: pre-line;
}

.subtitulo {
  font-size: 0.85rem;
  opacity: 0.7;
}

/* ===== Resultados / mostruário — padronizado com o Compêndio de Talentos/Alquimia ===== */
.cc-results {
  padding: 28px clamp(16px, 5vw, 64px) clamp(56px, 8vw, 96px);
  background: var(--jungle-void);
}

.cc-results-inner {
  max-width: 1200px;
  margin: 0 auto;
  display: flex;
  flex-direction: column;
  gap: 40px;
}

.cc-grupo {
  display: flex;
  flex-direction: column;
  gap: 24px;
}

/* Emblema do grupo — um selo só, sem peças soltas: um semicírculo com o
   ícone do tipo de magia colado direto (mesma largura, sem linha de
   junção) num retângulo com um círculo em cada vértice, onde mora o nome. */
.cc-grupo-emblema {
  display: flex;
  flex-direction: column;
  align-items: center;
}

.cc-grupo-linha-row {
  align-self: stretch;
  display: flex;
  align-items: center;
  gap: 16px;
}

.cc-grupo-linha {
  flex: 1;
  height: 1px;
  background: var(--jungle-green);
}

.cc-grupo-icone-semicirculo {
  position: relative;
  width: 150px;
  height: 75px;
  border-radius: 50% 50% 0 0 / 100% 100% 0 0;
  border: 3px solid var(--tribal-gold);
  border-bottom: none;
  background: var(--jungle-dark);
  display: flex;
  align-items: flex-end;
  justify-content: center;
  padding-bottom: 8px;
  overflow: hidden;
}

.cc-grupo-icone {
  flex: none;
  width: 62px;
  height: 62px;
}

.cc-grupo-nome-retangulo {
  position: relative;
  width: 150px;
  padding: 10px 8px;
  border: 3px solid var(--tribal-gold);
  border-top: none;
  background: var(--jungle-dark);
  display: flex;
  align-items: center;
  justify-content: center;
}

.cc-grupo-retangulo-circulo {
  position: absolute;
  width: 8px;
  height: 8px;
  border-radius: 50%;
  background: var(--tribal-gold);
}

.cc-grupo-retangulo-circulo-tl { top: -4px; left: -4px; }
.cc-grupo-retangulo-circulo-tr { top: -4px; right: -4px; }
.cc-grupo-retangulo-circulo-bl { bottom: -4px; left: -4px; }
.cc-grupo-retangulo-circulo-br { bottom: -4px; right: -4px; }

.cc-grupo-rotulo {
  font-family: 'Cinzel Decorative', 'Cinzel', serif;
  font-weight: 700;
  font-size: clamp(12px, 1.5vw, 15px);
  letter-spacing: 0.1em;
  text-transform: uppercase;
  color: var(--tribal-yellow);
  white-space: nowrap;
}

.cc-status {
  margin: 0;
  padding: 60px 0;
  text-align: center;
  font-size: 17px;
  color: var(--pale-green);
}

.cc-status-erro {
  color: var(--tribal-red);
}

.cc-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(220px, 260px));
  justify-content: center;
  gap: 18px;
}

.cc-card {
  position: relative;
  overflow: visible;
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 10px;
  text-align: center;
  padding: 26px 18px;
  background: transparent;
  border: none;
  color: inherit;
  font: inherit;
  cursor: pointer;
  min-width: 0;
}

.cc-card:hover {
  filter: drop-shadow(0 0 12px rgba(212, 163, 89, 0.35));
}

.cc-card-frame-1 {
  position: absolute;
  inset: 0;
  background: var(--tribal-gold);
  pointer-events: none;
  clip-path: polygon(20px 0, calc(100% - 20px) 0, 100% 20px, 100% calc(100% - 20px), calc(100% - 20px) 100%, 20px 100%, 0 calc(100% - 20px), 0 20px);
}

.cc-card-frame-2 {
  position: absolute;
  inset: 2px;
  background: var(--jungle-card);
  pointer-events: none;
  clip-path: polygon(18px 0, calc(100% - 18px) 0, 100% 18px, 100% calc(100% - 18px), calc(100% - 18px) 100%, 18px 100%, 0 calc(100% - 18px), 0 18px);
}

.cc-card-frame-3 {
  position: absolute;
  inset: 7px;
  background: color-mix(in srgb, var(--cls-cor, var(--jungle-green)) 75%, transparent);
  pointer-events: none;
  clip-path: polygon(14px 0, calc(100% - 14px) 0, 100% 14px, 100% calc(100% - 14px), calc(100% - 14px) 100%, 14px 100%, 0 calc(100% - 14px), 0 14px);
}

.cc-card-frame-4 {
  position: absolute;
  inset: 8px;
  background: var(--jungle-card);
  pointer-events: none;
  clip-path: polygon(13px 0, calc(100% - 13px) 0, 100% 13px, 100% calc(100% - 13px), calc(100% - 13px) 100%, 13px 100%, 0 calc(100% - 13px), 0 13px);
}

.cc-card-diamond {
  position: absolute;
  width: 13px;
  height: 13px;
  background: var(--tribal-gold);
  pointer-events: none;
}

.cc-card-diamond-top { top: 0; left: 50%; transform: translate(-50%, -50%) rotate(45deg); }
.cc-card-diamond-bottom { bottom: 0; left: 50%; transform: translate(-50%, 50%) rotate(45deg); }
.cc-card-diamond-left { left: 0; top: 50%; transform: translate(-50%, -50%) rotate(45deg); }
.cc-card-diamond-right { right: 0; top: 50%; transform: translate(50%, -50%) rotate(45deg); }

.cc-card-icone {
  position: relative;
  font-size: 40px;
  line-height: 1;
}

.cc-card-info {
  position: relative;
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 8px;
  min-width: 0;
}

.cc-card-nome {
  font-family: 'Cinzel Decorative', 'Cinzel', serif;
  font-weight: 700;
  font-size: 18px;
  line-height: 1.2;
  color: var(--bone);
}

.cc-vazio {
  margin: 0;
  padding: 60px 0;
  text-align: center;
  font-style: italic;
  font-size: 18px;
  color: var(--pale-green);
}

</style>
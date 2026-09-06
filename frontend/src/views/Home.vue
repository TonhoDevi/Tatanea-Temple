<script setup>
import { ref, onMounted, onBeforeUnmount } from 'vue';

const rooms = [
  { num: 'I', title: 'Sala das Raças', guardian: 'onça-pintada', art: '[ nicho de pedra com totens de linhagem ]', text: 'Nove povos do interior da mata, cada um com um pacto diferente com a floresta.', to: '/racas' },
  { num: 'II', title: 'Sala das Classes', guardian: 'arara-vermelha', art: '[ armas e adornos pendurados na parede ]', text: 'Caminhos de combate e de reza — inclusive os que a mata ensina sem pedir permissão.', to: '/classes' },
  { num: 'III', title: 'Sala dos Talentos', guardian: 'sapo venenoso', art: '[ entalhes geométricos em sequência ]', text: 'Marcas ganhas no corpo. Cada talento deixa cicatriz, tinta ou dívida.', to: '/talentos' },
  { num: 'IV', title: 'Sala da Alquimia', guardian: 'cobra-jararaca', art: '[ potes de barro, resinas, flores secas ]', text: 'Venenos, resinas e curas feitas com o que só cresce sob o dossel fechado.', to: '/alquimia' },
];

// Duplicamos a lista pra criar o efeito de loop infinito sem "costura" visível.
const roomsLoop = [...rooms, ...rooms];

const fauna = [
  { name: 'Onça', art: '[ onça entre raízes ]', text: 'Anda no escuro do templo e decide quem passa da entrada.' },
  { name: 'Arara', art: '[ arara em viga entalhada ]', text: 'Repete os nomes que ouviu — inclusive os que você não disse em voz alta.' },
  { name: 'Sapo', art: '[ sapo em folha molhada ]', text: 'Pele de aviso: quem entende a cor sai vivo da Sala dos Talentos.' },
  { name: 'Borboleta', art: '[ enxame de borboletas azuis ]', text: 'Aparece onde um pergaminho foi usado. Sempre depois, nunca antes.' },
];

// ===== Carrossel "Salas do templo": autoplay contínuo + arraste manual =====
const trackEl = ref(null);
let rafId = null;
let paused = false;
let dragging = false;
let dragStartX = 0;
let dragStartScroll = 0;
let dragMoved = false;
const speedPxPerFrame = 0.6;

function tick() {
  const el = trackEl.value;
  if (el && !paused && !dragging) {
    el.scrollLeft += speedPxPerFrame;
    const halfWidth = el.scrollWidth / 2;
    if (el.scrollLeft >= halfWidth) {
      el.scrollLeft -= halfWidth;
    }
  }
  rafId = requestAnimationFrame(tick);
}

function onPointerDown(event) {
  const el = trackEl.value;
  if (!el) return;
  dragging = true;
  dragMoved = false;
  dragStartX = event.clientX;
  dragStartScroll = el.scrollLeft;
  el.setPointerCapture?.(event.pointerId);
}

function onPointerMove(event) {
  if (!dragging) return;
  const el = trackEl.value;
  if (!el) return;
  const delta = event.clientX - dragStartX;
  if (Math.abs(delta) > 4) dragMoved = true;
  el.scrollLeft = dragStartScroll - delta;
}

function onPointerUp() {
  dragging = false;
}

// Evita que o clique "vazado" de um arraste dispare a navegação do RouterLink.
function onCardClick(event) {
  if (dragMoved) {
    event.preventDefault();
    dragMoved = false;
  }
}

onMounted(() => {
  const reduceMotion = window.matchMedia('(prefers-reduced-motion: reduce)').matches;
  if (!reduceMotion) {
    rafId = requestAnimationFrame(tick);
  }
});

onBeforeUnmount(() => {
  if (rafId) cancelAnimationFrame(rafId);
});
</script>

<template>
  <div class="temple">
    <!-- HERO -->
    <section class="hero">
      <div class="hero-strip hero-strip-top" aria-hidden="true"></div>
      <div class="hero-strip hero-strip-side hero-strip-left" aria-hidden="true"></div>
      <div class="hero-strip hero-strip-side hero-strip-right" aria-hidden="true"></div>

      <div class="hero-frame">
        <span class="hero-frame-inner" aria-hidden="true"></span>
        <span class="hero-frame-band hero-frame-band-top" aria-hidden="true"></span>
        <span class="hero-frame-band hero-frame-band-bottom" aria-hidden="true"></span>

        <p class="hero-eyebrow">Homebrew D&amp;D 5<span class="lowercase">e</span></p>
        <h1 class="hero-title">Templo de<br /><span class="hero-title-accent">Tatânea</span></h1>

        <div class="hero-divider" aria-hidden="true">
          <span class="hero-divider-line"></span>
          <span class="hero-divider-gem"></span>
          <span class="hero-divider-line"></span>
        </div>

        <p class="hero-subtitle">
          Pedra ritual engolida pela mata. Nas paredes, entalhes que ainda respondem a quem os
          toca — e quatro salas onde o compêndio deste mundo foi guardado.
        </p>

        <div class="hero-buttons">
          <a href="#salas" class="btn btn-solid">Entrar no templo</a>
          <a href="#acervo" class="btn btn-outline">Compêndio</a>
        </div>
      </div>

      <div class="hero-art-row">
        <div class="art-placeholder">[ folhagem — canto inferior esq. ]</div>
        <div class="art-placeholder">[ onça na penumbra ]</div>
        <div class="art-placeholder">[ arara / penas ]</div>
      </div>
    </section>

    <!-- SOBRE O MUNDO -->
    <section id="mundo" class="section">
      <div class="section-inner">
        <div class="section-heading">
          <h2 class="section-title">Sobre o mundo</h2>
          <span class="section-rule" aria-hidden="true"></span>
          <span class="section-chapter">Capítulo I</span>
        </div>

        <div class="mundo-panel">
          <div class="mundo-col">
            <p class="lead-text">
              Tatânea não foi construída sobre a floresta: foi construída
              <em class="highlight">com</em> ela. As lajes crescem onde as raízes decidem, e o
              mapa do templo muda conforme a mata avança sobre a pedra. Quem entra segue a
              vegetação, não a planta.
            </p>
            <p class="body-text">
              Os povos que o ergueram deixaram entalhes geométricos em cada viga — registro de
              linhagens, pactos e dívidas. Aventureiros chamam de decoração. Os guardiões chamam
              de contrato.
            </p>
          </div>

          <div class="mundo-col">
            <p class="body-text muted">
              A mata devolve o que se leva, sempre em outra moeda: um caminho aberto hoje é um
              corredor fechado na volta, e o silêncio dos bichos vale mais que qualquer aviso
              escrito na pedra.
            </p>
            <blockquote class="quote">
              “Toda pedra aqui tem nome. Pisar sem pedir licença é pisar em alguém.”
              <span class="quote-author">— guardiã do pórtico norte</span>
            </blockquote>
            <div class="tag-row">
              <span class="tag">Selva densa</span>
              <span class="tag">Ritual vivo</span>
              <span class="tag">Ouro e pedra</span>
            </div>
          </div>
        </div>

        <div class="art-placeholder art-placeholder-wide">
          [ faixa full-bleed — dossel da floresta visto de baixo ]
        </div>
      </div>
    </section>

    <!-- SALAS DO TEMPLO -->
    <section id="salas" class="section section-dark">
      <div class="section-inner">
        <div class="section-heading">
          <h2 class="section-title">Salas do templo</h2>
          <span class="section-rule" aria-hidden="true"></span>
          <span class="section-chapter">Capítulo II</span>
        </div>
        <p class="body-text">
          O compêndio está dividido entre quatro salas. Cada uma guarda um tipo de conhecimento —
          e um animal que decide se você vai levá-lo embora.
        </p>
        <p class="scroll-hint">→ arraste ou role para o lado</p>
      </div>

      <div
          ref="trackEl"
          class="rooms-track"
          @mouseenter="paused = true"
          @mouseleave="paused = false"
          @pointerdown="onPointerDown"
          @pointermove="onPointerMove"
          @pointerup="onPointerUp"
          @pointerleave="onPointerUp"
      >
        <RouterLink
            v-for="(room, i) in roomsLoop"
            :key="room.num + '-' + i"
            :to="room.to"
            class="room-card"
            @click="onCardClick"
        >
          <span class="room-card-band" aria-hidden="true"></span>
          <span class="room-card-num">{{ room.num }}</span>
          <div class="art-placeholder room-card-art">{{ room.art }}</div>
          <h3 class="room-card-title">{{ room.title }}</h3>
          <div class="room-card-guardian">Guardião: {{ room.guardian }}</div>
          <p class="room-card-text">{{ room.text }}</p>
          <span class="room-card-cta">Abrir a sala</span>
        </RouterLink>
      </div>
    </section>

    <!-- GUARDIÕES -->
    <section id="guardioes" class="section">
      <div class="section-inner">
        <div class="section-heading">
          <h2 class="section-title">A fauna que guarda o lugar</h2>
          <span class="section-rule" aria-hidden="true"></span>
          <span class="section-chapter">Capítulo III</span>
        </div>

        <div class="fauna-grid">
          <div v-for="f in fauna" :key="f.name" class="fauna-card">
            <div class="art-placeholder fauna-card-art">{{ f.art }}</div>
            <div class="fauna-card-name">{{ f.name }}</div>
            <p class="fauna-card-text">{{ f.text }}</p>
          </div>
        </div>
      </div>
    </section>

    <!-- ACERVO -->
    <section id="acervo" class="section section-darkest">
      <div class="section-inner">
        <div class="section-heading">
          <h2 class="section-title">Artefatos &amp; pergaminhos</h2>
          <span class="section-rule" aria-hidden="true"></span>
          <span class="section-chapter">Capítulo IV</span>
        </div>

        <div class="acervo-panel">
          <div class="acervo-col">
            <p class="lead-text">
              Os pergaminhos do templo não são consumíveis: são empréstimos. Cada uso registra
              uma dívida no entalhe da sala — e a mata cobra no momento em que menos convém.
            </p>
            <p class="body-text muted">
              Machados de pedra-do-rio, tinta de urucum ritual, resina da árvore-mãe, máscaras
              que calam quem as veste: o acervo completo, com raridade e o preço que cada peça
              cobra.
            </p>
            <RouterLink to="/alquimia" class="btn btn-danger">Ver tabela</RouterLink>
          </div>
          <div class="art-placeholder acervo-art">[ pergaminho aberto + borboletas ]</div>
        </div>
      </div>
    </section>
  </div>
</template>

<style scoped>
@import url('https://fonts.googleapis.com/css2?family=Cinzel+Decorative:wght@400;700;900&display=swap');

.temple {
  --jungle-void: #0b2013;
  --jungle-darkest: #071a0f;
  --jungle-dark: #0e2818;
  --jungle-moss: #1a3d26;
  --jungle-green: #2e7d4f;
  --jungle-green-soft: rgba(46, 125, 79, 0.35);
  --tribal-red: #b8362f;
  --tribal-gold: #c9a227;
  --tribal-yellow: #e8c14a;
  --bone: #f2ede1;
  --pale-green: #a8c4a2;

  background: var(--jungle-dark);
  color: var(--bone);
  font-family: 'Crimson Text', Georgia, serif;
  overflow-x: hidden;
}

.lowercase {
  text-transform: none;
}

/* ===== HERO ===== */
.hero {
  position: relative;
  min-height: min(92vh, 860px);
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  gap: 30px;
  padding: clamp(48px, 8vw, 110px) clamp(16px, 5vw, 64px);
  background-color: var(--jungle-void);
  background-image: repeating-linear-gradient(112deg, rgba(46, 125, 79, 0.16) 0 3px, transparent 3px 13px),
  repeating-linear-gradient(0deg, rgba(10, 28, 17, 0.55) 0 22px, transparent 22px 44px),
  radial-gradient(120% 90% at 50% 10%, var(--jungle-moss) 0, var(--jungle-void) 62%, var(--jungle-darkest) 100%);
  border-bottom: 1px solid var(--jungle-green);
}

.hero-strip {
  position: absolute;
}

.hero-strip-top {
  top: 0;
  left: 0;
  right: 0;
  height: 26px;
  background-image: repeating-linear-gradient(
      90deg,
      var(--tribal-gold) 0 4px,
      transparent 4px 10px,
      var(--tribal-red) 10px 14px,
      transparent 14px 26px
  );
  opacity: 0.75;
}

.hero-strip-side {
  top: 0;
  bottom: 0;
  width: clamp(28px, 7vw, 86px);
  background-image: repeating-linear-gradient(0deg, rgba(46, 125, 79, 0.5) 0 2px, transparent 2px 16px),
  repeating-linear-gradient(45deg, rgba(201, 162, 39, 0.18) 0 6px, transparent 6px 18px);
}

.hero-strip-left {
  left: 0;
}

.hero-strip-right {
  right: 0;
  background-image: repeating-linear-gradient(0deg, rgba(46, 125, 79, 0.5) 0 2px, transparent 2px 16px),
  repeating-linear-gradient(-45deg, rgba(201, 162, 39, 0.18) 0 6px, transparent 6px 18px);
}

.hero-frame {
  position: relative;
  z-index: 2;
  max-width: 760px;
  width: 100%;
  padding: clamp(22px, 4vw, 44px);
  border: 2px solid var(--tribal-gold);
  background: rgba(9, 26, 16, 0.86);
  box-shadow: 0 0 0 1px var(--jungle-dark) inset, 0 24px 70px rgba(0, 0, 0, 0.5);
  text-align: center;
}

.hero-frame-inner {
  position: absolute;
  inset: 8px;
  border: 1px solid rgba(184, 54, 47, 0.7);
  pointer-events: none;
}

.hero-frame-band {
  position: absolute;
  left: -2px;
  right: -2px;
  height: 10px;
  background-image: repeating-linear-gradient(
      90deg,
      var(--tribal-gold) 0 8px,
      var(--tribal-red) 8px 12px,
      transparent 12px 24px
  );
}

.hero-frame-band-top {
  top: -2px;
}

.hero-frame-band-bottom {
  bottom: -2px;
}

.hero-eyebrow {
  font-family: 'Cinzel', serif;
  font-size: 11px;
  letter-spacing: 0.4em;
  text-transform: uppercase;
  color: var(--pale-green);
  margin: 0 0 14px;
}

.hero-title {
  margin: 0;
  font-family: 'Cinzel Decorative', 'Cinzel', serif;
  font-weight: 700;
  font-size: clamp(38px, 8vw, 88px);
  line-height: 1.05;
  letter-spacing: 0.02em;
  color: var(--bone);
  text-transform: uppercase;
}

.hero-title-accent {
  font-weight: 700;
  color: var(--tribal-yellow);
}

.hero-divider {
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 12px;
  margin: 20px 0 6px;
}

.hero-divider-line {
  height: 1px;
  width: min(120px, 22vw);
  background: var(--jungle-green);
}

.hero-divider-gem {
  width: 10px;
  height: 10px;
  background: var(--tribal-red);
  transform: rotate(45deg);
}

.hero-subtitle {
  margin: 0 auto;
  max-width: 52ch;
  font-size: clamp(16px, 2.1vw, 20px);
  line-height: 1.6;
  color: var(--bone);
}

.hero-buttons {
  display: flex;
  flex-wrap: wrap;
  justify-content: center;
  gap: 14px;
  margin-top: 28px;
}

.btn {
  display: inline-block;
  font-family: 'Cinzel', serif;
  font-weight: 700;
  font-size: 12px;
  letter-spacing: 0.2em;
  text-transform: uppercase;
  padding: 14px 26px;
  text-decoration: none;
  transition: background-color 0.2s ease, border-color 0.2s ease, color 0.2s ease;
}

.btn-solid {
  background: var(--jungle-green);
  color: var(--bone);
  border: 1px solid var(--tribal-yellow);
}

.btn-solid:hover {
  background: var(--tribal-red);
  color: var(--bone);
}

.btn-outline {
  font-weight: 600;
  border: 1px solid var(--pale-green);
  color: var(--bone);
}

.btn-outline:hover {
  border-color: var(--tribal-yellow);
  color: var(--tribal-yellow);
}

.btn-danger {
  font-weight: 700;
  font-size: 11px;
  padding: 12px 22px;
  background: var(--tribal-red);
  color: var(--bone);
  border: 1px solid var(--tribal-yellow);
  align-self: flex-start;
}

.btn-danger:hover {
  background: var(--jungle-green);
}

.hero-art-row {
  position: relative;
  z-index: 2;
  display: flex;
  flex-wrap: wrap;
  justify-content: center;
  gap: 14px;
  width: 100%;
  max-width: 900px;
}

/* ===== PLACEHOLDER DE ARTE ===== */
.art-placeholder {
  border: 1px solid var(--jungle-green);
  background-image: repeating-linear-gradient(45deg, rgba(46, 125, 79, 0.35) 0 6px, transparent 6px 14px);
  display: flex;
  align-items: flex-end;
  padding: 8px;
  font-family: ui-monospace, Menlo, monospace;
  font-size: 10px;
  letter-spacing: 0.08em;
  color: var(--pale-green);
}

.hero-art-row .art-placeholder {
  flex: 1 1 200px;
  min-width: 0;
  height: 96px;
}

.art-placeholder-wide {
  height: 132px;
  background-image: repeating-linear-gradient(-45deg, rgba(46, 125, 79, 0.32) 0 7px, transparent 7px 16px);
}

/* ===== SEÇÕES ===== */
.section {
  padding: clamp(48px, 7vw, 96px) clamp(16px, 5vw, 64px);
  background: var(--jungle-dark);
  border-bottom: 1px solid rgba(46, 125, 79, 0.5);
}

.section-dark {
  background: var(--jungle-void);
  padding-left: 0;
  padding-right: 0;
}

.section-darkest {
  background: var(--jungle-darkest);
}

.section-inner {
  max-width: 1200px;
  margin: 0 auto;
  display: flex;
  flex-direction: column;
  gap: 20px;
}

.section-dark > .section-inner {
  padding: 0 clamp(16px, 5vw, 64px);
  gap: 14px;
}

.section-heading {
  display: flex;
  align-items: baseline;
  gap: 16px;
  flex-wrap: wrap;
}

.section-title {
  margin: 0;
  font-family: 'Cinzel Decorative', 'Cinzel', serif;
  font-weight: 700;
  font-size: clamp(26px, 4vw, 44px);
  color: var(--tribal-yellow);
}

.section-rule {
  flex: 1;
  min-width: 60px;
  height: 1px;
  background: repeating-linear-gradient(90deg, var(--jungle-green) 0 6px, transparent 6px 12px);
}

.section-chapter {
  font-family: 'Cinzel', serif;
  font-size: 11px;
  letter-spacing: 0.24em;
  text-transform: uppercase;
  color: var(--pale-green);
}

.body-text {
  margin: 0;
  font-size: clamp(15px, 1.8vw, 18px);
  line-height: 1.7;
  color: var(--bone);
}

.body-text.muted {
  color: var(--pale-green);
}

.lead-text {
  margin: 0;
  font-size: clamp(16px, 1.9vw, 20px);
  line-height: 1.68;
  color: var(--bone);
}

.highlight {
  color: var(--tribal-yellow);
}

.scroll-hint {
  display: flex;
  align-items: center;
  gap: 10px;
  font-family: ui-monospace, Menlo, monospace;
  font-size: 10px;
  letter-spacing: 0.1em;
  color: var(--pale-green);
  margin: 0;
}

/* ===== SOBRE O MUNDO ===== */
.mundo-panel {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
  gap: clamp(22px, 3.4vw, 48px);
  padding: clamp(18px, 2.6vw, 34px);
  background: var(--jungle-moss);
  border-left: 3px solid var(--tribal-red);
}

.mundo-col {
  display: flex;
  flex-direction: column;
  gap: 16px;
  min-width: 0;
}

.quote {
  margin: 0;
  padding: 14px 18px;
  border: 1px solid var(--tribal-gold);
  background: rgba(11, 32, 19, 0.6);
  font-style: italic;
  font-size: clamp(15px, 1.8vw, 18px);
  line-height: 1.6;
  color: var(--bone);
}

.quote-author {
  display: block;
  margin-top: 8px;
  font-style: normal;
  font-family: 'Cinzel', serif;
  font-size: 10px;
  letter-spacing: 0.2em;
  text-transform: uppercase;
  color: var(--pale-green);
}

.tag-row {
  display: flex;
  flex-wrap: wrap;
  gap: 10px;
}

.tag {
  font-family: 'Cinzel', serif;
  font-size: 10px;
  letter-spacing: 0.18em;
  text-transform: uppercase;
  padding: 7px 12px;
  border: 1px solid var(--jungle-green);
  color: var(--pale-green);
}

/* ===== SALAS (carrossel) ===== */
.rooms-track {
  margin-top: 10px;
  padding: 4px clamp(16px, 5vw, 64px) 22px;
  display: flex;
  gap: 22px;
  overflow-x: auto;
  scroll-behavior: auto;
  cursor: grab;
  touch-action: pan-y;
  user-select: none;
  scrollbar-width: none;
}

.rooms-track::-webkit-scrollbar {
  display: none;
}

.rooms-track:active {
  cursor: grabbing;
}

.room-card {
  position: relative;
  flex: 0 0 min(420px, 86vw);
  min-height: 560px;
  display: flex;
  flex-direction: column;
  justify-content: flex-end;
  gap: 14px;
  padding: 26px;
  border: 1px solid var(--tribal-gold);
  background-color: #123020;
  background-image: repeating-linear-gradient(90deg, rgba(46, 125, 79, 0.28) 0 4px, transparent 4px 12px);
  text-decoration: none;
  color: inherit;
  transition: border-color 0.2s ease, background-color 0.2s ease;
}

.room-card:hover {
  border-color: var(--tribal-yellow);
  background-color: #163a26;
}

.room-card-band {
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  height: 8px;
  background-image: repeating-linear-gradient(
      90deg,
      var(--tribal-gold) 0 6px,
      var(--tribal-red) 6px 10px,
      transparent 10px 20px
  );
}

.room-card-num {
  position: absolute;
  top: 20px;
  right: 20px;
  font-family: 'Cinzel', serif;
  font-size: 11px;
  letter-spacing: 0.24em;
  color: var(--tribal-gold);
}

.room-card-art {
  flex: 1;
  margin-top: 26px;
  height: auto;
}

.room-card-title {
  margin: 0;
  font-family: 'Cinzel Decorative', 'Cinzel', serif;
  font-weight: 700;
  font-size: 30px;
  color: var(--bone);
}

.room-card-guardian {
  font-family: 'Cinzel', serif;
  font-size: 10px;
  letter-spacing: 0.2em;
  text-transform: uppercase;
  color: var(--tribal-yellow);
}

.room-card-text {
  margin: 0;
  font-size: 17px;
  line-height: 1.55;
  color: var(--bone);
}

.room-card-cta {
  align-self: flex-start;
  font-family: 'Cinzel', serif;
  font-size: 11px;
  letter-spacing: 0.2em;
  text-transform: uppercase;
  padding: 10px 16px;
  border: 1px solid var(--jungle-green);
  color: var(--tribal-yellow);
  transition: background-color 0.2s ease, border-color 0.2s ease, color 0.2s ease;
}

.room-card:hover .room-card-cta {
  background: var(--tribal-red);
  border-color: var(--tribal-red);
  color: var(--bone);
}

/* ===== FAUNA ===== */
.fauna-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(190px, 1fr));
  gap: 18px;
}

.fauna-card {
  display: flex;
  flex-direction: column;
  gap: 10px;
  padding: 14px;
  background: var(--jungle-moss);
  border-top: 3px solid var(--tribal-gold);
  min-width: 0;
}

.fauna-card-art {
  height: 150px;
}

.fauna-card-name {
  font-family: 'Cinzel', serif;
  font-weight: 700;
  font-size: 13px;
  letter-spacing: 0.18em;
  text-transform: uppercase;
  color: var(--bone);
}

.fauna-card-text {
  margin: 0;
  font-size: 16px;
  line-height: 1.5;
  color: var(--pale-green);
}

/* ===== ACERVO ===== */
.acervo-panel {
  display: flex;
  flex-wrap: wrap;
  gap: clamp(20px, 3vw, 40px);
  align-items: stretch;
  padding: clamp(18px, 2.6vw, 32px);
  background: var(--jungle-moss);
  border-left: 3px solid var(--tribal-gold);
}

.acervo-col {
  flex: 1 1 320px;
  min-width: 0;
  display: flex;
  flex-direction: column;
  gap: 16px;
  align-items: flex-start;
}

.acervo-art {
  flex: 0 1 260px;
  min-width: 0;
  min-height: 280px;
  border-color: rgba(168, 196, 162, 0.4);
}

/* ===== RESPONSIVO ===== */
@media (max-width: 640px) {
  .hero-art-row {
    flex-direction: column;
  }

  .room-card {
    flex-basis: 86vw;
    min-height: 480px;
  }
}
</style>
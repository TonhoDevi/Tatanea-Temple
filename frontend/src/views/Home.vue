<script setup>
import { ref, computed } from 'vue';

// Ícones SVG dos cards de compêndio: sigilos abstratos, no mesmo espírito
// dos ícones de grupo do Compêndio de Classes (ver
// components/compendio/icones/IconeGrupo*.vue) — anel de círculos + raios
// em cruz + 4 pontos cardeais como moldura comum, com um glifo central
// diferente por sala em vez de uma ilustração literal do que a sala guarda.
const moldura = (corPonto) =>
  '<circle cx="32" cy="32" r="27" stroke="var(--tribal-gold)" stroke-width="1.6" opacity="0.5"/>' +
  '<circle cx="32" cy="32" r="19" stroke="var(--tribal-gold)" stroke-width="1" opacity="0.3"/>' +
  '<path d="M59 32 L54 32 M32 5 L32 10 M5 32 L10 32 M32 59 L32 54 M50.9 13.1 L47.6 16.4 M13.1 13.1 L16.4 16.4 M13.1 50.9 L16.4 47.6 M50.9 50.9 L47.6 47.6" stroke="var(--tribal-gold)" stroke-width="1.3" stroke-linecap="round" opacity="0.65"/>' +
  `<circle cx="32" cy="8" r="1.6" fill="${corPonto}"/><circle cx="56" cy="32" r="1.6" fill="${corPonto}"/><circle cx="32" cy="56" r="1.6" fill="${corPonto}"/><circle cx="8" cy="32" r="1.6" fill="${corPonto}"/>`;

const svgSigilo = (glifo) =>
  '<svg viewBox="0 0 64 64" width="160" height="160" fill="none" xmlns="http://www.w3.org/2000/svg" aria-hidden="true">' + glifo + '</svg>';

// Raças — marcas de linhagem: três gerações empilhadas, cada uma mais nova.
const iconeRacas = svgSigilo(
  moldura('var(--tribal-red)') +
  '<path d="M32 20 L38 30 L26 30 Z" fill="var(--jungle-dark)" stroke="var(--tribal-gold)" stroke-width="1.8" stroke-linejoin="round"/>' +
  '<path d="M32 28 L40 40 L24 40 Z" fill="var(--jungle-dark)" stroke="var(--tribal-gold)" stroke-width="1.8" stroke-linejoin="round" opacity="0.85"/>' +
  '<path d="M32 36 L42 50 L22 50 Z" fill="var(--jungle-dark)" stroke="var(--tribal-gold)" stroke-width="1.8" stroke-linejoin="round" opacity="0.7"/>' +
  '<circle cx="32" cy="20" r="2" fill="var(--tribal-red)"/>'
);

// Classes — disciplina: lâminas cruzadas abstraídas num X com núcleo losangular.
const iconeClasses = svgSigilo(
  moldura('var(--tribal-yellow)') +
  '<path d="M20 20 L44 44 M44 20 L20 44" stroke="var(--tribal-gold)" stroke-width="2.4" stroke-linecap="round"/>' +
  '<path d="M32 25 L39 32 L32 39 L25 32 Z" fill="var(--tribal-yellow)"/>' +
  '<circle cx="20" cy="20" r="1.6" fill="var(--tribal-yellow)"/><circle cx="44" cy="20" r="1.6" fill="var(--tribal-yellow)"/><circle cx="20" cy="44" r="1.6" fill="var(--tribal-yellow)"/><circle cx="44" cy="44" r="1.6" fill="var(--tribal-yellow)"/>'
);

// Talentos — constelação de marcas: três pontos ligados, um traço por talento adquirido.
const iconeTalentos = svgSigilo(
  moldura('var(--tribal-red)') +
  '<path d="M32 22 L44 42 L20 42 Z" stroke="var(--tribal-gold)" stroke-width="1.6" stroke-linejoin="round" fill="none" opacity="0.8"/>' +
  '<circle cx="32" cy="22" r="2.4" fill="var(--tribal-red)"/><circle cx="44" cy="42" r="2.4" fill="var(--tribal-red)"/><circle cx="20" cy="42" r="2.4" fill="var(--tribal-red)"/>' +
  '<circle cx="32" cy="35" r="1.6" fill="var(--tribal-yellow)"/>'
);

// Alquimia — glifo clássico de transmutação: círculo e triângulo sobrepostos.
const iconeAlquimia = svgSigilo(
  moldura('var(--jungle-green)') +
  '<circle cx="32" cy="30" r="10" stroke="var(--jungle-green)" stroke-width="1.8" opacity="0.85"/>' +
  '<path d="M32 18 L42 38 L22 38 Z" stroke="var(--tribal-gold)" stroke-width="1.8" stroke-linejoin="round" fill="none"/>' +
  '<circle cx="32" cy="30" r="2" fill="var(--jungle-green)"/>'
);

// Magias — círculo rúnico: octograma traçado por um losango e um quadrado sobrepostos.
const iconeMagias = svgSigilo(
  moldura('var(--tribal-yellow)') +
  '<path d="M32 18 L46 32 L32 46 L18 32 Z" stroke="var(--tribal-yellow)" stroke-width="1.6" stroke-linejoin="round" fill="none" opacity="0.85"/>' +
  '<path d="M22.1 22.1 L41.9 22.1 L41.9 41.9 L22.1 41.9 Z" stroke="var(--tribal-yellow)" stroke-width="1.6" stroke-linejoin="round" fill="none" opacity="0.85"/>' +
  '<circle cx="32" cy="32" r="2" fill="var(--tribal-yellow)"/>'
);

// Bestiário — três garras convergindo a um ponto, com uma presa abaixo.
const iconeBestiario = svgSigilo(
  moldura('var(--tribal-red)') +
  '<path d="M20 20 Q28 30 32 32" stroke="var(--tribal-red)" stroke-width="2.2" stroke-linecap="round" fill="none"/>' +
  '<path d="M32 16 Q32 26 32 32" stroke="var(--tribal-red)" stroke-width="2.2" stroke-linecap="round" fill="none"/>' +
  '<path d="M44 20 Q36 30 32 32" stroke="var(--tribal-red)" stroke-width="2.2" stroke-linecap="round" fill="none"/>' +
  '<path d="M28 40 L32 46 L36 40 Z" fill="var(--tribal-red)" opacity="0.85"/>' +
  '<circle cx="32" cy="32" r="2.2" fill="var(--tribal-yellow)"/>'
);

// Antecedentes — espiral de caminho: uma trajetória que se enrola sobre si mesma.
const iconeAntecedentes = svgSigilo(
  moldura('var(--tribal-yellow)') +
  '<path d="M32 22 a10 10 0 1 1 -7 3" stroke="var(--tribal-gold)" stroke-width="1.8" fill="none" stroke-linecap="round" opacity="0.85"/>' +
  '<path d="M25 25 a6 6 0 1 0 8 -2" stroke="var(--tribal-gold)" stroke-width="1.4" fill="none" stroke-linecap="round" opacity="0.6"/>' +
  '<circle cx="32" cy="32" r="2" fill="var(--tribal-yellow)"/>'
);

// Artes de Guerra — brasão hexagonal com diagonais cruzadas.
const iconeArtesDeGuerra = svgSigilo(
  moldura('var(--tribal-red)') +
  '<path d="M32 18 L44 25 L44 39 L32 46 L20 39 L20 25 Z" stroke="var(--tribal-gold)" stroke-width="1.8" stroke-linejoin="round" fill="rgba(196,158,74,0.08)"/>' +
  '<path d="M20 25 L44 39 M44 25 L20 39" stroke="var(--tribal-red)" stroke-width="1.8" stroke-linecap="round"/>' +
  '<circle cx="32" cy="32" r="2" fill="var(--tribal-red)"/>'
);

// Contos — olho de conhecimento revelado: pálpebra dupla em torno de uma íris.
const iconeContos = svgSigilo(
  moldura('var(--jungle-green)') +
  '<path d="M18 32 Q32 20 46 32 Q32 44 18 32 Z" stroke="var(--jungle-green)" stroke-width="1.8" stroke-linejoin="round" fill="rgba(35,110,71,0.12)"/>' +
  '<circle cx="32" cy="32" r="4" stroke="var(--tribal-yellow)" stroke-width="1.6" fill="none"/>' +
  '<circle cx="32" cy="32" r="1.6" fill="var(--tribal-yellow)"/>' +
  '<path d="M32 24 L32 18 M32 46 L32 40" stroke="var(--jungle-green)" stroke-width="1.4" opacity="0.6"/>'
);

const rooms = [
  { num: 'I', title: 'Sala das Raças', guardian: 'onça-pintada', art: '[ nicho de pedra com totens de linhagem ]', icon: iconeRacas, text: 'Todas as raças e sub-raças jogáveis, com atributos, deslocamento, tamanho e habilidades especiais completos.', to: '/racas' },
  { num: 'II', title: 'Sala das Classes', guardian: 'arara-vermelha', art: '[ armas e adornos pendurados na parede ]', icon: iconeClasses, text: 'Classes e subclasses com progressão de nível, proficiências e características detalhadas.', to: '/classes' },
  { num: 'III', title: 'Sala dos Talentos', guardian: 'sapo venenoso', art: '[ entalhes geométricos em sequência ]', icon: iconeTalentos, text: 'Talentos comuns e raciais com pré-requisitos, bônus de atributo e benefícios mecânicos completos.', to: '/talentos' },
  { num: 'IV', title: 'Sala da Alquimia', guardian: 'cobra-jararaca', art: '[ potes de barro, resinas, flores secas ]', icon: iconeAlquimia, text: 'Poções, venenos e itens alquímicos com efeito, custo e raridade documentados.', to: '/alquimia' },
  // Salas provisórias — ainda sem rota/página própria.
  { num: 'V', title: 'Sala das Magias', guardian: '???', art: '[ pergaminhos flutuando sobre um braseiro ]', icon: iconeMagias, text: 'Lista de magias por classe e círculo, com alcance, duração e componentes. Em construção.', to: null },
  { num: 'VI', title: 'Sala do Bestiário', guardian: '???', art: '[ ossadas e peles penduradas no teto ]', icon: iconeBestiario, text: 'Criaturas e monstros com estatísticas de combate completas. Em construção.', to: null },
  { num: 'VII', title: 'Sala dos Antecedentes', guardian: '???', art: '[ retratos entalhados na pedra ]', icon: iconeAntecedentes, text: 'Antecedentes de personagem com perícias, equipamento inicial e características. Em construção.', to: null },
  { num: 'VIII', title: 'Sala das Artes de Guerra', guardian: '???', art: '[ lanças e escudos cruzados na parede ]', icon: iconeArtesDeGuerra, text: 'Táticas e regras de combate em grupo. Em construção.', to: null },
  { num: 'IX', title: 'Sala dos Contos', guardian: '???', art: '[ pergaminhos históricos empilhados ]', icon: iconeContos, text: 'Contos, lendas e a história dos povos de Tatânea. Em construção.', to: null },
];

// ===== "Salas do templo": paginação manual de 3 em 3, sem giro automático =====
const ROOMS_PER_PAGE = 3;
const roomsTotalPages = Math.ceil(rooms.length / ROOMS_PER_PAGE);
const roomsPage = ref(0);

const visibleRooms = computed(() => {
  const start = roomsPage.value * ROOMS_PER_PAGE;
  return rooms.slice(start, start + ROOMS_PER_PAGE);
});

function goToRoomsPage(page) {
  if (page < 0 || page >= roomsTotalPages) return;
  roomsPage.value = page;
}
</script>

<template>
  <div class="temple">
    <!-- HERO -->
    <section class="hero">
      <div class="hero-strip hero-strip-top" aria-hidden="true"></div>

      <div class="hero-frame">
        <span class="hero-frame-corner hero-frame-corner-tl" aria-hidden="true"></span>
        <span class="hero-frame-corner hero-frame-corner-tr" aria-hidden="true"></span>
        <span class="hero-frame-corner hero-frame-corner-bl" aria-hidden="true"></span>
        <span class="hero-frame-corner hero-frame-corner-br" aria-hidden="true"></span>
        <span class="hero-frame-bracket hero-frame-bracket-tl" aria-hidden="true"></span>
        <span class="hero-frame-bracket hero-frame-bracket-tr" aria-hidden="true"></span>
        <span class="hero-frame-bracket hero-frame-bracket-bl" aria-hidden="true"></span>
        <span class="hero-frame-bracket hero-frame-bracket-br" aria-hidden="true"></span>

        <p class="hero-eyebrow">Homebrew D&amp;D 5<span class="lowercase">e</span></p>
        <h1 class="hero-title">Templo de<br /><span class="hero-title-accent">Tatânea</span></h1>

        <div class="hero-divider" aria-hidden="true">
          <span class="hero-divider-line"></span>
          <span class="hero-divider-gem"></span>
          <span class="hero-divider-line"></span>
        </div>

        <p class="hero-subtitle">
          Pela Glória de Tatânea. Alma incandecente da nação guerreira!
        </p>

        <div class="hero-buttons">
          <a href="#salas" class="btn btn-solid">Entrar no templo</a>
          <a href="#salas" class="btn btn-outline">Compêndio</a>
        </div>
      </div>

      <!-- Arte do hero removida temporariamente pro lançamento — restaurar quando houver imagens finais:
      <div class="hero-art-row">
        <div class="art-placeholder">[ folhagem — canto inferior esq. ]</div>
        <div class="art-placeholder">[ onça na penumbra ]</div>
        <div class="art-placeholder">[ arara / penas ]</div>
      </div>
      -->
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
              O Templo de Tatânea é o compêndio homebrew da mesa: raças, classes, talentos e
              itens documentados e prontos pra jogar, organizados por sala.
            </p>
            <p class="body-text">
              Não é só o material básico do 5e — aqui tem regras novas, classes remodeladas,
              talentos próprios, mecânicas inéditas e muito mais, feitos especialmente pra essa
              mesa.
            </p>
            <div class="tag-row">
              <span class="tag">Regras novas</span>
              <span class="tag">Classes remodeladas</span>
              <span class="tag">Talentos próprios</span>
              <span class="tag">Mecânicas inéditas</span>
            </div>
          </div>

          <div class="mundo-col">
            <p class="body-text muted">
              Além do compêndio, o templo guarda ferramentas pra jogar: ficha de personagem,
              rolador de dados e login pra salvar seus personagens entre sessões.
            </p>
            <div class="tag-row">
              <span class="tag">Ficha de personagem</span>
              <span class="tag">Rolador de dados</span>
              <span class="tag">Login e contas</span>
              <span class="tag">Sempre em expansão</span>
            </div>
          </div>
        </div>

        <!-- Faixa full-bleed removida temporariamente pro lançamento — restaurar quando houver imagem final:
        <div class="art-placeholder art-placeholder-wide">
          [ faixa full-bleed — dossel da floresta visto de baixo ]
        </div>
        -->
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
          Cada sala reúne um compêndio completo. Abra qualquer uma pra ver a lista cheia, com
          todos os detalhes prontos pra mesa. Algumas ainda estão em construção.
        </p>
      </div>

      <div class="rooms-viewport">
        <button
            type="button"
            class="rooms-nav rooms-nav-prev"
            :disabled="roomsPage === 0"
            aria-label="Salas anteriores"
            @click="goToRoomsPage(roomsPage - 1)"
        >‹</button>

        <div class="rooms-track">
          <component
              :is="room.to ? 'RouterLink' : 'div'"
              v-for="room in visibleRooms"
              :key="room.num"
              :to="room.to || undefined"
              class="room-card"
              :class="{ 'room-card-soon': !room.to }"
          >
            <span class="room-card-band" aria-hidden="true"></span>
            <span class="room-card-num">{{ room.num }}</span>
            <!-- Arte final do card entra aqui depois (ver `room.art`); por enquanto é um ícone SVG provisório. -->
            <div class="room-card-icon" v-html="room.icon"></div>
            <h3 class="room-card-title">{{ room.title }}</h3>
            <div class="room-card-guardian">Guardião: {{ room.guardian }}</div>
            <p class="room-card-text">{{ room.text }}</p>
            <span v-if="room.to" class="room-card-cta">Abrir a sala</span>
            <span v-else class="room-card-cta room-card-cta-soon">Em construção</span>
          </component>
        </div>

        <button
            type="button"
            class="rooms-nav rooms-nav-next"
            :disabled="roomsPage === roomsTotalPages - 1"
            aria-label="Próximas salas"
            @click="goToRoomsPage(roomsPage + 1)"
        >›</button>
      </div>
    </section>

    <!-- CONTOS -->
    <section id="contos" class="section section-darkest">
      <div class="section-inner">
        <div class="section-heading">
          <h2 class="section-title">Sala dos Contos</h2>
          <span class="section-rule" aria-hidden="true"></span>
          <span class="section-chapter">Capítulo III</span>
        </div>

        <div class="acervo-panel">
          <div class="acervo-col">
            <p class="lead-text">
              Os contos e a história completa de Tatânea — origem dos povos, geografia e os
              eventos que moldaram o mundo — vão ganhar uma sala própria.
            </p>
            <p class="body-text muted">
              Por enquanto os contos vivem espalhados nas descrições de cada raça e classe. Essa
              sala vai reunir tudo num só lugar.
            </p>
            <span class="btn btn-outline btn-soon">Em construção</span>
          </div>
          <!-- Arte da sala dos contos fica pra depois, quando houver imagem final:
          <div class="art-placeholder acervo-art">[ pergaminho aberto + borboletas ]</div>
          -->

        </div>
      </div>
    </section>
  </div>
</template>

<style scoped>
@import url('https://fonts.googleapis.com/css2?family=Cinzel+Decorative:wght@400;700;900&display=swap');

.temple {
  --jungle-void: var(--bg-deep);
  --jungle-darkest: color-mix(in srgb, var(--bg-deep) 75%, black);
  --jungle-dark: var(--bg-card);
  --jungle-moss: var(--bg-subcard);
  --jungle-green: var(--accent-green);
  --jungle-green-soft: rgba(35, 110, 71, 0.35);
  --tribal-red: var(--accent-terracotta);
  --tribal-gold: var(--accent-gold);
  --tribal-yellow: var(--accent-gold);
  --bone: var(--text-pale);
  --pale-green: var(--text-muted);

  /* Linha ondulada reutilizável (rio/serpente) — recolorida via
     background-color + mask em cada uso, no lugar das faixas retas. */
  --wave-mask: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 40 10'%3E%3Cpath d='M0 5 Q10 0 20 5 T40 5' fill='none' stroke='%23000' stroke-width='3' stroke-linecap='round'/%3E%3C/svg%3E");

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
  background-image: repeating-linear-gradient(0deg, rgba(10, 28, 17, 0.55) 0 22px, transparent 22px 44px),
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
  height: 10px;
  background-color: var(--tribal-gold);
  -webkit-mask-image: var(--wave-mask);
  mask-image: var(--wave-mask);
  -webkit-mask-repeat: repeat-x;
  mask-repeat: repeat-x;
  -webkit-mask-size: 40px 10px;
  mask-size: 40px 10px;
  opacity: 0.85;
}

.hero-frame {
  position: relative;
  z-index: 2;
  max-width: 760px;
  width: 100%;
  padding: clamp(22px, 4vw, 44px);
  border: 3px solid var(--tribal-gold);
  background: rgba(9, 26, 16, 0.86);
  box-shadow: 0 0 0 1px var(--jungle-dark) inset, 0 24px 70px rgba(0, 0, 0, 0.5);
  text-align: center;
}

/* Cantos no mesmo estilo dos cards de categoria do Compêndio de Raças:
   losango dourado por fora do quadro + moldura verde em L por dentro. */
.hero-frame-corner {
  position: absolute;
  width: 14px;
  height: 14px;
  background: var(--tribal-gold);
  transform: rotate(45deg);
}

.hero-frame-corner-tl { top: -9px; left: -9px; }
.hero-frame-corner-tr { top: -9px; right: -9px; }
.hero-frame-corner-bl { bottom: -9px; left: -9px; }
.hero-frame-corner-br { bottom: -9px; right: -9px; }

.hero-frame-bracket {
  position: absolute;
  width: 18px;
  height: 18px;
}

.hero-frame-bracket-tl { top: 5px; left: 5px; border-top: 2px solid var(--jungle-green); border-left: 2px solid var(--jungle-green); }
.hero-frame-bracket-tr { top: 5px; right: 5px; border-top: 2px solid var(--jungle-green); border-right: 2px solid var(--jungle-green); }
.hero-frame-bracket-bl { bottom: 5px; left: 5px; border-bottom: 2px solid var(--jungle-green); border-left: 2px solid var(--jungle-green); }
.hero-frame-bracket-br { bottom: 5px; right: 5px; border-bottom: 2px solid var(--jungle-green); border-right: 2px solid var(--jungle-green); }

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

.btn-soon,
.btn-soon:hover {
  font-size: 11px;
  padding: 12px 22px;
  align-self: flex-start;
  border-style: dashed;
  border-color: var(--pale-green);
  color: var(--pale-green);
  cursor: default;
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
}

/* ===== SEÇÕES ===== */
.section {
  padding: clamp(48px, 7vw, 96px) clamp(16px, 5vw, 64px);
  background: var(--jungle-dark);
  border-bottom: 1px solid rgba(35, 110, 71, 0.5);
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
  height: 6px;
  background-color: var(--jungle-green);
  -webkit-mask-image: var(--wave-mask);
  mask-image: var(--wave-mask);
  -webkit-mask-repeat: repeat-x;
  mask-repeat: repeat-x;
  -webkit-mask-size: 24px 6px;
  mask-size: 24px 6px;
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

/* ===== SALAS (paginação manual, 3 em 3) ===== */
.rooms-viewport {
  margin-top: 10px;
  padding: 4px clamp(16px, 5vw, 64px) 22px;
  display: flex;
  align-items: center;
  gap: 16px;
}

.rooms-nav {
  flex: 0 0 auto;
  width: 48px;
  height: 48px;
  display: flex;
  align-items: center;
  justify-content: center;
  border: 1px solid var(--tribal-gold);
  background: rgba(9, 26, 16, 0.86);
  color: var(--tribal-yellow);
  font-family: 'Cinzel', serif;
  font-size: 22px;
  line-height: 1;
  cursor: pointer;
  transition: background-color 0.2s ease, border-color 0.2s ease, color 0.2s ease;
}

.rooms-nav:hover:not(:disabled) {
  background: var(--tribal-red);
  border-color: var(--tribal-red);
  color: var(--bone);
}

.rooms-nav:disabled {
  opacity: 0.35;
  cursor: default;
}

.rooms-track {
  flex: 1;
  min-width: 0;
  display: flex;
  flex-wrap: wrap;
  justify-content: center;
  gap: 22px;
}

.room-card {
  position: relative;
  flex: 1 1 280px;
  max-width: 380px;
  min-height: 560px;
  display: flex;
  flex-direction: column;
  justify-content: flex-end;
  gap: 14px;
  padding: 26px;
  border: 1px solid var(--tribal-gold);
  background-color: var(--bg-card);
  text-decoration: none;
  color: inherit;
  transition: border-color 0.2s ease, background-color 0.2s ease;
}

.room-card:hover {
  border-color: var(--tribal-yellow);
  background-color: var(--jungle-moss);
}

.room-card-band {
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  height: 8px;
  background-color: var(--tribal-gold);
  -webkit-mask-image: var(--wave-mask);
  mask-image: var(--wave-mask);
  -webkit-mask-repeat: repeat-x;
  mask-repeat: repeat-x;
  -webkit-mask-size: 32px 8px;
  mask-size: 32px 8px;
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

/* Ícone SVG provisório no lugar da arte do card (ver `room.icon` no script). */
.room-card-icon {
  flex: 1;
  margin-top: 26px;
  display: flex;
  align-items: center;
  justify-content: center;
  opacity: 0.9;
}

.room-card-icon :deep(svg) {
  width: clamp(140px, 22vw, 200px);
  height: clamp(140px, 22vw, 200px);
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

/* ===== SALAS provisórias (sem rota ainda) ===== */
.room-card-soon {
  cursor: default;
  border-style: dashed;
  opacity: 0.72;
}

.room-card-soon:hover {
  border-color: var(--tribal-gold);
  background-color: var(--bg-card);
}

.room-card-cta-soon {
  border-style: dashed;
  color: var(--pale-green);
}

.room-card-soon:hover .room-card-cta-soon {
  background: none;
  border-color: var(--jungle-green);
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
  border-color: rgba(154, 176, 161, 0.4);
}

/* ===== RESPONSIVO ===== */
@media (max-width: 640px) {
  .hero-art-row {
    flex-direction: column;
  }

  .rooms-viewport {
    gap: 8px;
  }

  .rooms-nav {
    width: 36px;
    height: 36px;
    font-size: 18px;
  }

  .room-card {
    flex-basis: 100%;
    max-width: none;
    min-height: 480px;
  }
}
</style>
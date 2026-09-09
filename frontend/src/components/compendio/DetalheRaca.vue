<template>
  <div class="dr-page">
    <p v-if="carregando" class="dr-status">Carregando raça…</p>
    <p v-else-if="erro" class="dr-status dr-status-erro">{{ erro }}</p>

    <template v-else-if="raca">
      <section class="dr-top">
        <div class="dr-top-inner">
          <button class="dr-voltar" @click="voltar">← Voltar ao compêndio</button>
        </div>
      </section>

      <section class="dr-hero">
        <div class="dr-hero-inner">
          <div class="dr-retrato">
            <img v-if="raca.imagemUrl" :src="raca.imagemUrl" :alt="raca.nome" class="dr-retrato-img" />
            <span v-else class="dr-retrato-placeholder">[ retrato de corpo inteiro — {{ raca.nome }} ]</span>
          </div>

          <div class="dr-hero-info">
            <span class="dr-eyebrow">Ficha técnica</span>
            <h1 class="dr-nome">{{ raca.nome }}</h1>
            <div class="dr-hr-row">
              <span class="dr-hr-line dr-hr-line-fixed"></span>
              <span class="dr-hr-diamond"></span>
              <span class="dr-hr-line"></span>
            </div>
            <blockquote v-if="raca.quote" class="dr-quote">"{{ raca.quote }}"</blockquote>
            <div class="dr-categoria-bloco">
              <span class="dr-categoria-corner dr-categoria-corner-tl"></span>
              <span class="dr-categoria-corner dr-categoria-corner-tr"></span>
              <span class="dr-categoria-corner dr-categoria-corner-bl"></span>
              <span class="dr-categoria-corner dr-categoria-corner-br"></span>
              <span class="dr-categoria-bracket dr-categoria-bracket-tl"></span>
              <span class="dr-categoria-bracket dr-categoria-bracket-tr"></span>
              <span class="dr-categoria-bracket dr-categoria-bracket-bl"></span>
              <span class="dr-categoria-bracket dr-categoria-bracket-br"></span>
              <span class="dr-categoria-valor">{{ categoriaLabel }}</span>
            </div>
          </div>
        </div>
      </section>

      <section class="dr-body">
        <div class="dr-body-inner">

          <div class="dr-section">
            <div class="dr-section-title-row">
              <h2 class="dr-section-title">Informações gerais</h2>
              <span class="dr-title-line"></span>
            </div>
            <div class="dr-attr-grid">
              <div class="dr-attr-item">
                <span class="dr-attr-texto">Tamanho: {{ tamanhoLabel }}</span>
              </div>
              <div class="dr-attr-item">
                <span class="dr-attr-texto">Deslocamento: {{ raca.deslocamento }} m</span>
              </div>
              <div class="dr-attr-item">
                <span class="dr-attr-texto">{{ raca.habilidadesEspeciais.length }} habilidades especiais</span>
              </div>
            </div>
          </div>

          <div class="dr-section">
            <div class="dr-section-title-row">
              <h2 class="dr-section-title">Atributos</h2>
              <span class="dr-title-line"></span>
            </div>
            <div class="dr-attr-grid">
              <div class="dr-attr-item" v-for="(a, i) in raca.atributos" :key="i">
                <span class="dr-attr-texto">{{ atributoTexto(a) }}</span>
              </div>
            </div>
          </div>

          <div class="dr-section">
            <div class="dr-section-title-row">
              <h2 class="dr-section-title">Altura, peso e idade</h2>
              <span class="dr-title-line"></span>
            </div>
            <div class="dr-regua-grid">
              <div class="dr-regua-card" v-for="reg in reguas" :key="reg.titulo">
                <span class="dr-regua-titulo">{{ reg.titulo }}</span>
                <span class="dr-regua-valor">{{ reg.valor }}</span>
                <p class="dr-regua-texto">Em média um {{ raca.nome }} tem {{ reg.valor }}.</p>
              </div>
            </div>
          </div>

          <div class="dr-section">
            <div class="dr-section-title-row">
              <h2 class="dr-section-title">Idiomas</h2>
              <span class="dr-title-line"></span>
            </div>
            <p class="dr-idiomas">{{ raca.idiomas }}</p>
          </div>

          <div class="dr-section">
            <div class="dr-section-title-row">
              <h2 class="dr-section-title">Habilidades especiais</h2>
              <span class="dr-title-line"></span>
            </div>
            <div class="dr-hab-lista">
              <div class="dr-hab-item" v-for="(hab, i) in raca.habilidadesEspeciais" :key="i">
                <button class="dr-hab-cabecalho" @click="alternarHabilidade(i)">
                  <span class="dr-hab-seta">{{ habilidadesAbertas[i] ? '▾' : '▸' }}</span>
                  <span class="dr-hab-nome">{{ hab.nome }}</span>
                  <span class="dr-hab-tipo">{{ tipoLabel(hab.tipo) }}</span>
                </button>
                <p v-if="habilidadesAbertas[i]" class="dr-hab-descricao">{{ hab.descricao }}</p>
              </div>
            </div>
          </div>

          <div class="dr-section" v-for="txt in textos" :key="txt.titulo">
            <div class="dr-section-title-row">
              <h2 class="dr-section-title">{{ txt.titulo }}</h2>
              <span class="dr-title-line"></span>
            </div>
            <p class="dr-texto-corpo">{{ txt.corpo }}</p>
          </div>

          <div class="dr-rodape">
            <button class="dr-voltar-final" @click="voltar">← Voltar ao compêndio</button>
          </div>
        </div>
      </section>
    </template>
  </div>
</template>

<script setup>
import { ref, computed, onMounted } from 'vue';
import { useRoute, useRouter } from 'vue-router';
import { racaService } from '../../services/racaService';

const CAT_SING = { global: 'Global', tribal: 'Tribal', mistica: 'Mística', sobrenatural: 'Sobrenatural' };
const TAM = { miudo: 'Miúdo', pequeno: 'Pequeno', medio: 'Médio', grande: 'Grande', enorme: 'Enorme' };
const TIPO = { passiva: 'Passiva', uso_unico: 'Uso único', multiplos_usos: 'Múltiplos usos' };
const ATR = {
  forca: 'Força', destreza: 'Destreza', constituicao: 'Constituição',
  inteligencia: 'Inteligência', sabedoria: 'Sabedoria', carisma: 'Carisma',
};

const route = useRoute();
const router = useRouter();

const raca = ref(null);
const carregando = ref(true);
const erro = ref(null);
const habilidadesAbertas = ref({});

function fmtM(v) {
  return String(v).replace('.', ',') + ' m';
}

function fmtKg(v) {
  return String(v).replace('.', ',') + ' kg';
}

function atributoTexto(a) {
  if (!a.atributo) {
    return a.quantidadeEscolhas === 1
        ? `Escolha 1 atributo para +${a.valor}`
        : `Escolha ${a.quantidadeEscolhas} atributos para +${a.valor} cada`;
  }
  return `${ATR[a.atributo] || a.atributo} +${a.valor}`;
}

function tipoLabel(codigo) {
  return TIPO[codigo] || codigo;
}

function alternarHabilidade(indice) {
  habilidadesAbertas.value = { ...habilidadesAbertas.value, [indice]: !habilidadesAbertas.value[indice] };
}

const categoriaLabel = computed(() => (raca.value ? CAT_SING[raca.value.categoria] || raca.value.categoria : ''));
const tamanhoLabel = computed(() => (raca.value ? TAM[raca.value.tamanho] || raca.value.tamanho : ''));

const reguas = computed(() => {
  if (!raca.value) return [];
  const { altura, peso, idade } = raca.value;
  return [
    { titulo: 'Altura', valor: fmtM(altura.valorMedio) },
    { titulo: 'Peso', valor: fmtKg(peso.valorMedio) },
    { titulo: 'Idade', valor: `${idade.expectativaVida} anos` },
  ];
});

const textos = computed(() => {
  if (!raca.value) return [];
  return [
    { titulo: 'Anatomia', corpo: raca.value.anatomia },
    { titulo: 'Aparência', corpo: raca.value.aparencia },
    { titulo: 'Nomes Raciais', corpo: raca.value.nomesRaciais },
    { titulo: 'Traços Culturais', corpo: raca.value.tracosCulturais },
  ].filter((t) => t.corpo);
});

function voltar() {
  router.push('/racas');
}

onMounted(async () => {
  try {
    raca.value = await racaService.buscarPorId(route.params.id);
  } catch (e) {
    erro.value = 'Não foi possível carregar essa raça.';
  } finally {
    carregando.value = false;
  }
});
</script>

<style scoped>
.dr-page {
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

  background: var(--jungle-dark);
  color: var(--bone);
  font-family: 'Crimson Text', Georgia, serif;
  min-height: 100vh;
}

.dr-status {
  padding: 80px 0;
  text-align: center;
  font-size: 17px;
  color: var(--pale-green);
}

.dr-status-erro {
  color: var(--tribal-red);
}

.dr-top {
  padding: clamp(28px, 4vw, 48px) clamp(16px, 5vw, 64px) 0;
  background: var(--jungle-dark);
}

.dr-top-inner {
  max-width: 1100px;
  margin: 0 auto;
}

.dr-voltar {
  font-family: 'Cinzel', serif;
  font-weight: 700;
  font-size: 11px;
  letter-spacing: 0.2em;
  text-transform: uppercase;
  padding: 12px 20px;
  background: transparent;
  border: 1px solid var(--pale-green);
  color: var(--bone);
  cursor: pointer;
  clip-path: polygon(11px 0, 100% 0, 100% calc(100% - 11px), calc(100% - 11px) 100%, 0 100%, 0 11px);
}

.dr-voltar:hover {
  border-color: var(--tribal-yellow);
  color: var(--tribal-yellow);
}

.dr-hero {
  padding: clamp(24px, 4vw, 44px) clamp(16px, 5vw, 64px);
  background: var(--jungle-dark);
}

.dr-hero-inner {
  max-width: 1100px;
  margin: 0 auto;
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
  gap: clamp(22px, 3.4vw, 44px);
  align-items: start;
}

.dr-retrato {
  position: relative;
  min-width: 0;
  min-height: 360px;
  border: 1px solid var(--jungle-green);
  background-image: repeating-linear-gradient(45deg, rgba(46, 125, 79, 0.35) 0 6px, transparent 6px 14px);
  display: flex;
  align-items: flex-end;
  padding: 10px;
  clip-path: polygon(28px 0, 100% 0, 100% calc(100% - 28px), calc(100% - 28px) 100%, 0 100%, 0 28px);
  overflow: hidden;
}

.dr-retrato-img {
  position: absolute;
  inset: 0;
  width: 100%;
  height: 100%;
  object-fit: cover;
}

.dr-retrato-placeholder {
  font-family: ui-monospace, Menlo, monospace;
  font-size: 10px;
  letter-spacing: 0.08em;
  color: var(--pale-green);
}

.dr-hero-info {
  min-width: 0;
  display: flex;
  flex-direction: column;
  gap: 18px;
}

.dr-eyebrow {
  font-family: 'Cinzel', serif;
  font-size: 11px;
  letter-spacing: 0.4em;
  text-transform: uppercase;
  color: var(--pale-green);
}

.dr-nome {
  margin: 0;
  font-family: 'Cinzel Decorative', 'Cinzel', serif;
  font-weight: 700;
  font-size: clamp(34px, 5.4vw, 58px);
  line-height: 1.05;
  color: var(--bone);
  text-transform: uppercase;
}

.dr-hr-row {
  display: flex;
  align-items: center;
  gap: 12px;
}

.dr-hr-line {
  height: 1px;
  flex: 1;
  background: var(--jungle-green);
}

.dr-hr-line-fixed {
  flex: none;
  width: min(120px, 22vw);
}

.dr-hr-diamond {
  width: 10px;
  height: 10px;
  background: var(--tribal-red);
  transform: rotate(45deg);
}

.dr-quote {
  margin: 0;
  padding: 14px 18px;
  border-left: 3px solid var(--tribal-gold);
  background: rgba(11, 32, 19, 0.6);
  font-style: italic;
  font-size: clamp(15px, 1.8vw, 18px);
  line-height: 1.6;
  color: var(--bone);
}

.dr-categoria-bloco {
  position: relative;
  align-self: flex-start;
  min-width: min(420px, 100%);
  display: flex;
  align-items: center;
  justify-content: center;
  padding: 24px 32px;
  border: 3px solid var(--tribal-gold);
  background: var(--jungle-moss);
}

.dr-categoria-corner {
  position: absolute;
  width: 14px;
  height: 14px;
  background: var(--tribal-gold);
  transform: rotate(45deg);
}

.dr-categoria-corner-tl { top: -8px; left: -8px; }
.dr-categoria-corner-tr { top: -8px; right: -8px; }
.dr-categoria-corner-bl { bottom: -8px; left: -8px; }
.dr-categoria-corner-br { bottom: -8px; right: -8px; }

.dr-categoria-bracket {
  position: absolute;
  width: 16px;
  height: 16px;
}

.dr-categoria-bracket-tl { top: 4px; left: 4px; border-top: 2px solid var(--jungle-green); border-left: 2px solid var(--jungle-green); }
.dr-categoria-bracket-tr { top: 4px; right: 4px; border-top: 2px solid var(--jungle-green); border-right: 2px solid var(--jungle-green); }
.dr-categoria-bracket-bl { bottom: 4px; left: 4px; border-bottom: 2px solid var(--jungle-green); border-left: 2px solid var(--jungle-green); }
.dr-categoria-bracket-br { bottom: 4px; right: 4px; border-bottom: 2px solid var(--jungle-green); border-right: 2px solid var(--jungle-green); }

.dr-categoria-valor {
  position: relative;
  font-family: 'Cinzel Decorative', 'Cinzel', serif;
  font-weight: 700;
  font-size: 22px;
  text-transform: uppercase;
  color: var(--tribal-yellow);
  text-align: center;
}

.dr-body {
  padding: clamp(32px, 5vw, 64px) clamp(16px, 5vw, 64px);
  background: var(--jungle-void);
  border-top: 1px solid rgba(46, 125, 79, 0.5);
}

.dr-body-inner {
  max-width: 1100px;
  margin: 0 auto;
  display: flex;
  flex-direction: column;
  gap: 36px;
}

.dr-section {
  display: flex;
  flex-direction: column;
  gap: 16px;
  min-width: 0;
}

.dr-section-title-row {
  display: flex;
  align-items: center;
  gap: 16px;
  flex-wrap: wrap;
}

.dr-section-title {
  margin: 0;
  font-family: 'Cinzel Decorative', 'Cinzel', serif;
  font-weight: 700;
  font-size: clamp(22px, 3vw, 32px);
  color: var(--tribal-yellow);
}

.dr-title-line {
  flex: 1;
  min-width: 40px;
  height: 1px;
  background: var(--jungle-green);
}

.dr-attr-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
  gap: 12px;
}

.dr-attr-item {
  display: flex;
  align-items: baseline;
  gap: 12px;
  padding: 14px 16px;
  background: var(--jungle-moss);
  border-left: 3px solid var(--tribal-gold);
  min-width: 0;
  clip-path: polygon(12px 0, 100% 0, 100% calc(100% - 12px), calc(100% - 12px) 100%, 0 100%, 0 12px);
}

.dr-attr-texto {
  font-family: 'Cinzel', serif;
  font-size: 14px;
  letter-spacing: 0.06em;
  color: var(--bone);
}

.dr-regua-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(260px, 1fr));
  gap: 18px;
}

.dr-regua-card {
  display: flex;
  flex-direction: column;
  gap: 12px;
  padding: 18px;
  background: var(--jungle-moss);
  border-top: 3px solid var(--tribal-gold);
  min-width: 0;
  clip-path: polygon(14px 0, 100% 0, 100% calc(100% - 14px), calc(100% - 14px) 100%, 0 100%, 0 14px);
}

.dr-regua-titulo {
  font-family: 'Cinzel', serif;
  font-size: 10px;
  font-weight: 700;
  letter-spacing: 0.2em;
  text-transform: uppercase;
  color: var(--bone);
}

.dr-regua-valor {
  font-family: 'Cinzel Decorative', 'Cinzel', serif;
  font-weight: 700;
  font-size: 26px;
  color: var(--tribal-yellow);
}

.dr-regua-texto {
  margin: 0;
  font-size: 15px;
  line-height: 1.5;
  color: var(--pale-green);
}

.dr-idiomas {
  margin: 0;
  padding: 16px 20px;
  background: var(--jungle-moss);
  border-left: 3px solid var(--tribal-red);
  clip-path: polygon(14px 0, 100% 0, 100% calc(100% - 14px), calc(100% - 14px) 100%, 0 100%, 0 14px);
  font-size: 18px;
  line-height: 1.6;
  color: var(--bone);
}

.dr-hab-lista {
  display: flex;
  flex-direction: column;
  gap: 8px;
}

.dr-hab-item {
  border: 1px solid var(--jungle-green);
  background: #123020;
  min-width: 0;
  clip-path: polygon(14px 0, 100% 0, 100% calc(100% - 14px), calc(100% - 14px) 100%, 0 100%, 0 14px);
}

.dr-hab-cabecalho {
  width: 100%;
  display: flex;
  align-items: center;
  gap: 14px;
  text-align: left;
  padding: 15px 18px;
  background: transparent;
  border: none;
  color: inherit;
  font: inherit;
  cursor: pointer;
}

.dr-hab-cabecalho:hover {
  background: #163a26;
}

.dr-hab-seta {
  color: var(--tribal-yellow);
  font-size: 15px;
  width: 14px;
  flex: none;
}

.dr-hab-nome {
  flex: 1;
  min-width: 0;
  font-family: 'Cinzel', serif;
  font-size: 16px;
  font-weight: 600;
  color: var(--bone);
}

.dr-hab-tipo {
  flex: none;
  font-family: 'Cinzel', serif;
  font-size: 9px;
  font-weight: 700;
  letter-spacing: 0.18em;
  text-transform: uppercase;
  padding: 5px 10px;
  border: 1px solid var(--tribal-gold);
  color: var(--tribal-yellow);
  clip-path: polygon(7px 0, 100% 0, 100% calc(100% - 7px), calc(100% - 7px) 100%, 0 100%, 0 7px);
}

.dr-hab-descricao {
  margin: 0;
  padding: 0 18px 18px 46px;
  font-size: 17px;
  line-height: 1.65;
  color: var(--bone);
}

.dr-texto-corpo {
  margin: 0;
  max-width: 78ch;
  font-size: 18px;
  line-height: 1.75;
  color: var(--bone);
}

.dr-rodape {
  display: flex;
  justify-content: flex-start;
  padding-top: 8px;
  border-top: 1px solid rgba(46, 125, 79, 0.5);
}

.dr-voltar-final {
  margin-top: 24px;
  font-family: 'Cinzel', serif;
  font-weight: 700;
  font-size: 11px;
  letter-spacing: 0.2em;
  text-transform: uppercase;
  padding: 14px 24px;
  background: var(--tribal-red);
  border: 1px solid var(--tribal-yellow);
  color: var(--bone);
  cursor: pointer;
  clip-path: polygon(12px 0, 100% 0, 100% calc(100% - 12px), calc(100% - 12px) 100%, 0 100%, 0 12px);
}

.dr-voltar-final:hover {
  background: var(--jungle-green);
}

@media (max-width: 700px) {
  .dr-attr-grid,
  .dr-regua-grid {
    grid-template-columns: 1fr;
  }
}
</style>

<template>
  <div class="dt-page">
    <p v-if="carregando" class="dt-status">Carregando talento…</p>
    <p v-else-if="erro" class="dt-status dt-status-erro">{{ erro }}</p>

    <template v-else-if="talento">
      <section class="dt-top">
        <div class="dt-top-inner">
          <button class="dt-voltar" @click="voltar">← Voltar ao compêndio</button>
        </div>
      </section>

      <section class="dt-hero">
        <div class="dt-hero-inner">
          <div class="dt-icone-bloco">
            <span class="dt-icone">{{ talento.icone || '◆' }}</span>
          </div>

          <div class="dt-hero-info">
            <span class="dt-eyebrow">Ficha técnica</span>
            <h1 class="dt-nome">{{ talento.nome }}</h1>
            <div class="dt-hr-row">
              <span class="dt-hr-line dt-hr-line-fixed"></span>
              <span class="dt-hr-diamond"></span>
              <span class="dt-hr-line"></span>
            </div>
            <div class="dt-categoria-bloco">
              <span class="dt-categoria-corner dt-categoria-corner-tl"></span>
              <span class="dt-categoria-corner dt-categoria-corner-tr"></span>
              <span class="dt-categoria-corner dt-categoria-corner-bl"></span>
              <span class="dt-categoria-corner dt-categoria-corner-br"></span>
              <span class="dt-categoria-bracket dt-categoria-bracket-tl"></span>
              <span class="dt-categoria-bracket dt-categoria-bracket-tr"></span>
              <span class="dt-categoria-bracket dt-categoria-bracket-bl"></span>
              <span class="dt-categoria-bracket dt-categoria-bracket-br"></span>
              <span class="dt-categoria-valor">{{ bonusLabel }}</span>
            </div>
          </div>
        </div>
      </section>

      <section class="dt-body">
        <div class="dt-body-inner">

          <div class="dt-section">
            <div class="dt-section-title-row">
              <h2 class="dt-section-title">Pré-requisito</h2>
              <span class="dt-title-line"></span>
            </div>
            <div v-if="preRequisitos.length" class="dt-attr-grid">
              <div class="dt-attr-item" v-for="(pr, i) in preRequisitos" :key="i">
                <span class="dt-attr-texto">{{ pr }}</span>
              </div>
            </div>
            <p v-else class="dt-idiomas">Nenhum — disponível para qualquer personagem.</p>
          </div>

          <div class="dt-section">
            <div class="dt-section-title-row">
              <h2 class="dt-section-title">Descrição</h2>
              <span class="dt-title-line"></span>
            </div>
            <p class="dt-texto-corpo">{{ talento.descricao }}</p>
          </div>

          <div class="dt-section" v-if="talento.historia">
            <div class="dt-section-title-row">
              <h2 class="dt-section-title">História</h2>
              <span class="dt-title-line"></span>
              <span class="dt-marca">Origem</span>
            </div>
            <p class="dt-texto-corpo">{{ talento.historia }}</p>
          </div>

          <div class="dt-rodape">
            <button class="dt-voltar-final" @click="voltar">← Voltar ao compêndio</button>
          </div>
        </div>
      </section>
    </template>
  </div>
</template>

<script setup>
import { ref, computed, onMounted } from 'vue';
import { useRoute, useRouter } from 'vue-router';
import talentoService from '../../services/talentoService';

const ATR = {
  forca: 'Força', destreza: 'Destreza', constituicao: 'Constituição',
  inteligencia: 'Inteligência', sabedoria: 'Sabedoria', carisma: 'Carisma',
};

const route = useRoute();
const router = useRouter();

const talento = ref(null);
const carregando = ref(true);
const erro = ref(null);

const bonusLabel = computed(() => {
  if (!talento.value || !talento.value.atributos?.length) return 'Sem bônus de atributo';
  return talento.value.atributos
      .map((a) => {
        if (a.atributo) {
          const nome = ATR[a.atributo] || a.atributo;
          return `+${a.valor} ${nome}`;
        }
        return `+${a.valor} à escolha (${a.quantidadeEscolhas}x)`;
      })
      .join(' · ');
});

const preRequisitos = computed(() => {
  if (!talento.value || !talento.value.atributoRequerido) return [];
  const nome = ATR[talento.value.atributoRequerido] || talento.value.atributoRequerido;
  return [`${nome} ${talento.value.valorMinimoAtributoRequerido} ou mais`];
});

function voltar() {
  router.push('/talentos');
}

onMounted(async () => {
  try {
    talento.value = await talentoService.buscarPorId(route.params.id);
  } catch (e) {
    erro.value = 'Não foi possível carregar esse talento.';
  } finally {
    carregando.value = false;
  }
});
</script>

<style scoped>
.dt-page {
  --jungle-void: var(--bg-deep);
  --jungle-darkest: color-mix(in srgb, var(--bg-deep) 75%, black);
  --jungle-dark: var(--bg-card);
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

.dt-status {
  padding: 80px 0;
  text-align: center;
  font-size: 17px;
  color: var(--pale-green);
}

.dt-status-erro {
  color: var(--tribal-red);
}

.dt-top {
  padding: clamp(28px, 4vw, 48px) clamp(16px, 5vw, 64px) 0;
  background: var(--jungle-dark);
}

.dt-top-inner {
  max-width: 1100px;
  margin: 0 auto;
}

.dt-voltar {
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

.dt-voltar:hover {
  border-color: var(--tribal-yellow);
  color: var(--tribal-yellow);
}

.dt-hero {
  padding: clamp(24px, 4vw, 44px) clamp(16px, 5vw, 64px);
  background: var(--jungle-dark);
}

.dt-hero-inner {
  max-width: 1100px;
  margin: 0 auto;
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
  gap: clamp(22px, 3.4vw, 44px);
  align-items: start;
}

.dt-icone-bloco {
  position: relative;
  min-width: 0;
  min-height: 220px;
  border: 1px solid var(--jungle-green);
  display: flex;
  align-items: center;
  justify-content: center;
  clip-path: polygon(28px 0, 100% 0, 100% calc(100% - 28px), calc(100% - 28px) 100%, 0 100%, 0 28px);
}

.dt-icone {
  font-size: 96px;
  line-height: 1;
}

.dt-hero-info {
  min-width: 0;
  display: flex;
  flex-direction: column;
  gap: 18px;
}

.dt-eyebrow {
  font-family: 'Cinzel', serif;
  font-size: 11px;
  letter-spacing: 0.4em;
  text-transform: uppercase;
  color: var(--pale-green);
}

.dt-nome {
  margin: 0;
  font-family: 'Cinzel Decorative', 'Cinzel', serif;
  font-weight: 700;
  font-size: clamp(34px, 5.4vw, 58px);
  line-height: 1.05;
  color: var(--bone);
  text-transform: uppercase;
}

.dt-hr-row {
  display: flex;
  align-items: center;
  gap: 12px;
}

.dt-hr-line {
  height: 1px;
  flex: 1;
  background: var(--jungle-green);
}

.dt-hr-line-fixed {
  flex: none;
  width: min(120px, 22vw);
}

.dt-hr-diamond {
  width: 10px;
  height: 10px;
  background: var(--tribal-red);
  transform: rotate(45deg);
}

.dt-categoria-bloco {
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

.dt-categoria-corner {
  position: absolute;
  width: 14px;
  height: 14px;
  background: var(--tribal-gold);
  transform: rotate(45deg);
}

.dt-categoria-corner-tl { top: -8px; left: -8px; }
.dt-categoria-corner-tr { top: -8px; right: -8px; }
.dt-categoria-corner-bl { bottom: -8px; left: -8px; }
.dt-categoria-corner-br { bottom: -8px; right: -8px; }

.dt-categoria-bracket {
  position: absolute;
  width: 16px;
  height: 16px;
}

.dt-categoria-bracket-tl { top: 4px; left: 4px; border-top: 2px solid var(--jungle-green); border-left: 2px solid var(--jungle-green); }
.dt-categoria-bracket-tr { top: 4px; right: 4px; border-top: 2px solid var(--jungle-green); border-right: 2px solid var(--jungle-green); }
.dt-categoria-bracket-bl { bottom: 4px; left: 4px; border-bottom: 2px solid var(--jungle-green); border-left: 2px solid var(--jungle-green); }
.dt-categoria-bracket-br { bottom: 4px; right: 4px; border-bottom: 2px solid var(--jungle-green); border-right: 2px solid var(--jungle-green); }

.dt-categoria-valor {
  position: relative;
  font-family: 'Cinzel Decorative', 'Cinzel', serif;
  font-weight: 700;
  font-size: 22px;
  text-transform: uppercase;
  color: var(--tribal-yellow);
  text-align: center;
}

.dt-body {
  padding: clamp(32px, 5vw, 64px) clamp(16px, 5vw, 64px);
  background: var(--jungle-void);
  border-top: 1px solid rgba(35, 110, 71, 0.5);
}

.dt-body-inner {
  max-width: 1100px;
  margin: 0 auto;
  display: flex;
  flex-direction: column;
  gap: 36px;
}

.dt-section {
  display: flex;
  flex-direction: column;
  gap: 16px;
  min-width: 0;
}

.dt-section-title-row {
  display: flex;
  align-items: center;
  gap: 16px;
  flex-wrap: wrap;
}

.dt-section-title {
  margin: 0;
  font-family: 'Cinzel Decorative', 'Cinzel', serif;
  font-weight: 700;
  font-size: clamp(22px, 3vw, 32px);
  color: var(--tribal-yellow);
}

.dt-title-line {
  flex: 1;
  min-width: 40px;
  height: 1px;
  background: var(--jungle-green);
}

.dt-marca {
  font-family: 'Cinzel', serif;
  font-size: 10px;
  letter-spacing: 0.24em;
  text-transform: uppercase;
  color: var(--pale-green);
}

.dt-attr-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
  gap: 12px;
}

.dt-attr-item {
  display: flex;
  align-items: baseline;
  gap: 12px;
  padding: 14px 16px;
  background: var(--jungle-moss);
  border-left: 3px solid var(--tribal-gold);
  min-width: 0;
  clip-path: polygon(12px 0, 100% 0, 100% calc(100% - 12px), calc(100% - 12px) 100%, 0 100%, 0 12px);
}

.dt-attr-texto {
  font-family: 'Cinzel', serif;
  font-size: 14px;
  letter-spacing: 0.06em;
  color: var(--bone);
}

.dt-idiomas {
  margin: 0;
  padding: 16px 20px;
  background: var(--jungle-moss);
  border-left: 3px solid var(--jungle-green);
  clip-path: polygon(14px 0, 100% 0, 100% calc(100% - 14px), calc(100% - 14px) 100%, 0 100%, 0 14px);
  font-size: 17px;
  line-height: 1.6;
  color: var(--pale-green);
}

.dt-texto-corpo {
  margin: 0;
  max-width: 78ch;
  font-size: 18px;
  line-height: 1.75;
  color: var(--bone);
  white-space: pre-line;
}

.dt-rodape {
  display: flex;
  justify-content: flex-start;
  padding-top: 8px;
  border-top: 1px solid rgba(35, 110, 71, 0.5);
}

.dt-voltar-final {
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

.dt-voltar-final:hover {
  background: var(--jungle-green);
}

@media (max-width: 700px) {
  .dt-attr-grid {
    grid-template-columns: 1fr;
  }
}
</style>

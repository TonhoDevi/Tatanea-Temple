<template>
  <div class="ra-overlay" @click.self="$emit('fechar')">
    <div class="ra-modal">
      <button class="ra-fechar" @click="$emit('fechar')">×</button>
      <h2 class="ra-titulo"><span class="ra-titulo-deco">⚅</span> {{ ataque.nome || 'Ataque' }} <span class="ra-titulo-deco">⚅</span></h2>

      <div v-if="!modo" class="ra-escolha">
        <p class="ra-escolha-label">Como rolar o acerto?</p>
        <div class="ra-escolha-botoes">
          <button class="ra-modo-btn ra-modo-normal" @click="escolherModo('normal')">Normal</button>
          <button class="ra-modo-btn ra-modo-vantagem" @click="escolherModo('vantagem')">Vantagem</button>
          <button class="ra-modo-btn ra-modo-desvantagem" @click="escolherModo('desvantagem')">Desvantagem</button>
        </div>
      </div>

      <div v-else class="ra-resultado">
        <span class="ra-modo-tag" :class="'ra-modo-tag-' + modo">{{ MODO_LABEL[modo] }}</span>

        <div class="ra-acerto">
          <div class="ra-acerto-dados">
            <span
                v-for="(v, di) in d20Preview"
                :key="di"
                class="ra-d20"
                :class="{
                  'ra-d20-girando': di >= d20Revelados,
                  'ra-d20-assentado': di < d20Revelados,
                  'ra-d20-descartado': mostrarAcerto && resultado.d20s.length > 1 && di !== resultado.d20UsadoIndice,
                  'ra-critico': mostrarAcerto && di === resultado.d20UsadoIndice && v === 20,
                  'ra-critfalho': mostrarAcerto && di === resultado.d20UsadoIndice && v === 1,
                }"
            >{{ v }}</span>
          </div>

          <template v-if="mostrarAcerto">
            <span class="ra-acerto-divisor"></span>

            <div class="ra-acerto-bonus">{{ formatarMod(resultado.acertoBonus) }}</div>

            <span class="ra-acerto-divisor"></span>

            <div class="ra-acerto-total">
              <span class="ra-acerto-total-label">Total</span>
              <span class="ra-acerto-total-valor">{{ resultado.acertoTotal }}</span>
            </div>
          </template>
        </div>

        <p v-if="mostrarAcerto && resultado.critico" class="ra-aviso ra-aviso-critico">Acerto crítico!</p>
        <p v-if="mostrarAcerto && resultado.critFalho" class="ra-aviso ra-aviso-critfalho">Falha crítica!</p>

        <div v-if="mostrarAcerto && resultado.danos.length" class="ra-danos">
          <div v-for="(d, di) in resultado.danos" :key="di" class="ra-dano-linha">
            <span class="ra-dano-tipo">{{ d.tipoDano || 'Dano' }}</span>
            <div class="ra-dano-dados">
              <span
                  v-for="(v, ri) in dadosDaLinha(di)"
                  :key="ri"
                  class="ra-dano-dado"
                  :class="{
                    'ra-dano-dado-girando': resultado.danoOffsets[di] + ri >= danoRevelados,
                    'ra-dano-dado-assentado': resultado.danoOffsets[di] + ri < danoRevelados,
                  }"
              >{{ v }}</span>
              <span v-if="d.bonus" class="ra-dano-bonus-inline">{{ formatarMod(d.bonus) }}</span>
            </div>
            <span v-if="linhaDeDanoCompleta(di)" class="ra-dano-valor">{{ d.subtotal }}</span>
          </div>
          <div v-if="mostrarDanoTotal" class="ra-dano-total">
            <span class="ra-dano-total-label">Dano total</span>
            <span class="ra-dano-total-valor">{{ resultado.danoTotal }}</span>
          </div>
        </div>

        <div class="ra-acoes">
          <button class="ra-btn-rolar" :disabled="rolando" @click="rolar">⚅ Rolar novamente</button>
          <button class="ra-btn-trocar" :disabled="rolando" @click="trocarModo">Trocar modo</button>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, onBeforeUnmount } from 'vue';

const props = defineProps({
  ataque: { type: Object, required: true },
  acertoBonus: { type: Number, required: true },
});
defineEmits(['fechar']);

const MODO_LABEL = { normal: 'Rolagem normal', vantagem: 'Vantagem', desvantagem: 'Desvantagem' };

const modo = ref(null);
const resultado = ref(null);

// Mesma lógica de animação do Lançador de Dados (RoladorDados.vue): os dados
// ainda não revelados ficam sorteando valores a cada tick do intervalo; ao
// serem revelados, travam no valor final em sequência. Aqui em duas fases —
// primeiro o(s) d20 de acerto assentam e revelam o total, só então os dados
// de dano começam a girar e assentar por sua vez.
const rolando = ref(false);
const d20Preview = ref([]);
const d20Revelados = ref(0);
const mostrarAcerto = ref(false);
const danoPreview = ref([]);
const danoRevelados = ref(0);
const mostrarDanoTotal = ref(false);

let intervalIds = [];
let timeoutIds = [];

function limparTimers() {
  intervalIds.splice(0).forEach(clearInterval);
  timeoutIds.splice(0).forEach(clearTimeout);
}

function rolarDado(faces) {
  return Math.floor(Math.random() * faces) + 1;
}

function formatarMod(valor) {
  return valor >= 0 ? `+${valor}` : `${valor}`;
}

function escolherModo(m) {
  modo.value = m;
  rolar();
}

function trocarModo() {
  limparTimers();
  rolando.value = false;
  mostrarAcerto.value = false;
  mostrarDanoTotal.value = false;
  resultado.value = null;
  modo.value = null;
}

function dadosDaLinha(di) {
  if (!resultado.value) return [];
  const offset = resultado.value.danoOffsets[di];
  const qtd = resultado.value.danos[di].rolagens.length;
  return danoPreview.value.slice(offset, offset + qtd);
}

function linhaDeDanoCompleta(di) {
  if (!resultado.value) return false;
  const offset = resultado.value.danoOffsets[di];
  const qtd = resultado.value.danos[di].rolagens.length;
  return offset + qtd <= danoRevelados.value;
}

function iniciarAnimacaoDano(danosFinal, offsets, total) {
  const flatFinal = [];
  const flatFaces = [];
  danosFinal.forEach((d) => {
    d.rolagens.forEach((v) => {
      flatFinal.push(v);
      flatFaces.push(d.faces);
    });
  });

  danoPreview.value = flatFaces.map((faces) => rolarDado(faces));
  danoRevelados.value = 0;

  const danoInterval = setInterval(() => {
    danoPreview.value = danoPreview.value.map((v, i) => (i < danoRevelados.value ? v : rolarDado(flatFaces[i])));
  }, 65);
  intervalIds.push(danoInterval);

  const giroBaseDano = 380 + Math.random() * 180;
  const atrasoDano = 75;

  flatFinal.forEach((valor, i) => {
    const id = setTimeout(() => {
      danoRevelados.value = i + 1;
      danoPreview.value = danoPreview.value.map((v, idx) => (idx === i ? valor : v));

      if (i === flatFinal.length - 1) {
        clearInterval(danoInterval);
        const idFinal = setTimeout(() => {
          mostrarDanoTotal.value = true;
          rolando.value = false;
        }, 200);
        timeoutIds.push(idFinal);
      }
    }, giroBaseDano + i * atrasoDano);
    timeoutIds.push(id);
  });
}

function rolar() {
  limparTimers();
  rolando.value = true;
  mostrarAcerto.value = false;
  mostrarDanoTotal.value = false;

  const d20sFinal = modo.value === 'normal' ? [rolarDado(20)] : [rolarDado(20), rolarDado(20)];
  const alvo = modo.value === 'desvantagem' ? Math.min(...d20sFinal) : Math.max(...d20sFinal);
  const d20UsadoIndice = d20sFinal.indexOf(alvo);

  const danosFinal = (props.ataque.danos || []).map((d) => {
    const faces = Number((d.dado || 'd6').replace('d', '')) || 6;
    const quantidade = d.quantidade || 1;
    const rolagens = Array.from({ length: quantidade }, () => rolarDado(faces));
    const bonus = Number(d.bonus) || 0;
    const subtotal = rolagens.reduce((soma, v) => soma + v, 0) + bonus;
    return { quantidade, dado: d.dado || 'd6', bonus, rolagens, subtotal, tipoDano: d.tipoDano, faces };
  });

  let offset = 0;
  const offsets = danosFinal.map((d) => {
    const o = offset;
    offset += d.rolagens.length;
    return o;
  });
  const totalDanoDados = offset;

  resultado.value = {
    d20s: d20sFinal,
    d20UsadoIndice,
    acertoBonus: props.acertoBonus,
    acertoTotal: alvo + props.acertoBonus,
    critico: alvo === 20,
    critFalho: alvo === 1,
    danos: danosFinal,
    danoOffsets: offsets,
    danoTotal: danosFinal.reduce((soma, d) => soma + d.subtotal, 0),
  };

  // ---- fase 1: d20(s) de acerto ----
  d20Preview.value = d20sFinal.map(() => rolarDado(20));
  d20Revelados.value = 0;

  const d20Interval = setInterval(() => {
    d20Preview.value = d20Preview.value.map((v, i) => (i < d20Revelados.value ? v : rolarDado(20)));
  }, 65);
  intervalIds.push(d20Interval);

  const giroBaseAcerto = 420 + Math.random() * 200;
  const atrasoAcerto = 110;

  d20sFinal.forEach((valor, i) => {
    const id = setTimeout(() => {
      d20Revelados.value = i + 1;
      d20Preview.value = d20Preview.value.map((v, idx) => (idx === i ? valor : v));

      if (i === d20sFinal.length - 1) {
        clearInterval(d20Interval);
        const idAcerto = setTimeout(() => {
          mostrarAcerto.value = true;
          // ---- fase 2: dados de dano, só depois do acerto assentar ----
          if (totalDanoDados > 0) {
            iniciarAnimacaoDano(danosFinal, offsets, totalDanoDados);
          } else {
            rolando.value = false;
          }
        }, 220);
        timeoutIds.push(idAcerto);
      }
    }, giroBaseAcerto + i * atrasoAcerto);
    timeoutIds.push(id);
  });
}

onBeforeUnmount(limparTimers);
</script>

<style scoped>
.ra-overlay {
  position: fixed;
  inset: 0;
  background: rgba(0, 0, 0, 0.7);
  display: flex;
  align-items: center;
  justify-content: center;
  z-index: 300;
  padding: 1rem;
}

.ra-modal {
  background: linear-gradient(160deg, var(--jungle-darkest), var(--jungle-void));
  border: 1px solid var(--tribal-gold);
  border-radius: 14px;
  padding: 1.6rem;
  width: 100%;
  max-width: 460px;
  position: relative;
  color: var(--bone);
  box-shadow: 0 20px 50px rgba(0, 0, 0, 0.6);
}

.ra-fechar {
  position: absolute;
  top: 0.7rem;
  right: 0.9rem;
  background: none;
  border: none;
  color: var(--pale-green);
  font-size: 1.4rem;
  cursor: pointer;
  line-height: 1;
}

.ra-fechar:hover {
  color: var(--tribal-gold);
}

.ra-titulo {
  font-family: 'Cinzel Decorative', 'Cinzel', serif;
  text-transform: uppercase;
  letter-spacing: 0.08em;
  font-size: 1.15rem;
  text-align: center;
  margin: 0 0 1.4rem;
  color: var(--tribal-gold);
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 0.6rem;
}

.ra-titulo-deco {
  color: var(--tribal-yellow);
  font-size: 0.9rem;
}

.ra-escolha-label {
  text-align: center;
  font-family: 'Cinzel', serif;
  font-size: 0.85rem;
  letter-spacing: 0.06em;
  color: var(--pale-green);
  margin: 0 0 1rem;
}

.ra-escolha-botoes {
  display: flex;
  flex-direction: column;
  gap: 0.6rem;
}

.ra-modo-btn {
  padding: 0.85rem;
  border-radius: 8px;
  font-family: 'Cinzel', serif;
  font-weight: 700;
  font-size: 0.95rem;
  letter-spacing: 0.06em;
  text-transform: uppercase;
  cursor: pointer;
  background: none;
  color: var(--bone);
}

.ra-modo-normal {
  border: 1px solid var(--border-gold);
}

.ra-modo-normal:hover {
  background: color-mix(in srgb, var(--accent-title) 25%, transparent);
}

.ra-modo-vantagem {
  border: 1px solid var(--tribal-gold);
  color: var(--tribal-yellow);
}

.ra-modo-vantagem:hover {
  background: color-mix(in srgb, var(--accent-title) 18%, transparent);
}

.ra-modo-desvantagem {
  border: 1px solid var(--tribal-red);
  color: color-mix(in srgb, var(--btn-damage-bg) 55%, white);
}

.ra-modo-desvantagem:hover {
  background: rgba(192, 64, 90, 0.18);
}

.ra-modo-tag {
  display: block;
  width: fit-content;
  margin: 0 auto 1.2rem;
  padding: 4px 12px;
  font-family: 'Cinzel', serif;
  font-size: 0.7rem;
  letter-spacing: 0.12em;
  text-transform: uppercase;
  border: 1px solid var(--jungle-moss);
  color: var(--pale-green);
}

.ra-modo-tag-vantagem {
  border-color: var(--tribal-gold);
  color: var(--tribal-yellow);
}

.ra-modo-tag-desvantagem {
  border-color: var(--tribal-red);
  color: color-mix(in srgb, var(--btn-damage-bg) 55%, white);
}

.ra-acerto {
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 0.9rem;
  flex-wrap: wrap;
  padding-bottom: 1rem;
}

.ra-acerto-dados {
  display: flex;
  gap: 0.4rem;
}

.ra-d20 {
  --d20-roxo: #8b5cf6;
  --d20-roxo-clara: #b18cfa;

  display: flex;
  align-items: center;
  justify-content: center;
  width: 64px;
  height: 64px;
  clip-path: polygon(30% 0%, 70% 0%, 100% 30%, 100% 70%, 70% 100%, 30% 100%, 0% 70%, 0% 30%);
  background: linear-gradient(145deg, var(--d20-roxo-clara), var(--d20-roxo));
  font-family: 'Cinzel', serif;
  font-weight: 700;
  font-size: 1.8rem;
  color: var(--bone);
  box-shadow: 0 0 18px rgba(139, 92, 246, 0.6);
}

.ra-d20-descartado {
  background: color-mix(in srgb, var(--bg-sub) 70%, black);
  opacity: 0.45;
  box-shadow: none;
}

/* Mesma animação "gira, depois assenta" do Lançador de Dados. */
.ra-d20-girando {
  animation: ra-girando 0.13s ease-in-out infinite;
}

.ra-d20-assentado {
  animation: ra-assenta 0.32s cubic-bezier(0.175, 0.885, 0.32, 1.275);
}

@keyframes ra-girando {
  0%, 100% { opacity: 1; transform: translateY(0); }
  50% { opacity: 0.55; transform: translateY(-2px); }
}

@keyframes ra-assenta {
  0% { transform: scale(1.4) rotate(-8deg); }
  60% { transform: scale(0.94) rotate(2deg); }
  100% { transform: scale(1) rotate(0deg); }
}

.ra-d20.ra-critico {
  background: linear-gradient(145deg, var(--tribal-yellow), var(--tribal-gold));
  color: var(--jungle-void);
  box-shadow: 0 0 22px color-mix(in srgb, var(--accent-title) 85%, transparent);
}

.ra-d20.ra-critfalho {
  background: linear-gradient(145deg, color-mix(in srgb, var(--btn-damage-bg) 60%, white), var(--btn-damage-bg));
  box-shadow: 0 0 22px rgba(192, 64, 90, 0.75);
}

.ra-acerto-divisor {
  width: 1px;
  align-self: stretch;
  background: var(--jungle-moss);
}

.ra-acerto-bonus {
  font-family: 'Cinzel', serif;
  font-weight: 700;
  font-size: 2rem;
  color: var(--pale-green);
}

.ra-acerto-total {
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 0.1rem;
}

.ra-acerto-total-label {
  font-family: 'Cinzel', serif;
  font-size: 0.65rem;
  letter-spacing: 0.14em;
  text-transform: uppercase;
  color: var(--pale-green);
}

.ra-acerto-total-valor {
  font-family: 'Cinzel', serif;
  font-weight: 700;
  font-size: 3.4rem;
  line-height: 1;
  color: var(--tribal-gold);
}

.ra-aviso {
  text-align: center;
  font-family: 'Cinzel', serif;
  font-size: 0.9rem;
  letter-spacing: 0.1em;
  text-transform: uppercase;
  margin: -0.4rem 0 0.8rem;
}

.ra-aviso-critico {
  color: var(--tribal-yellow);
}

.ra-aviso-critfalho {
  color: color-mix(in srgb, var(--btn-damage-bg) 55%, white);
}

.ra-danos {
  display: flex;
  flex-direction: column;
  gap: 0.5rem;
  padding-top: 0.9rem;
  border-top: 1px solid var(--jungle-moss);
}

.ra-dano-linha {
  display: flex;
  align-items: center;
  justify-content: space-between;
  gap: 0.6rem;
}

.ra-dano-tipo {
  flex: none;
  font-family: 'Cinzel', serif;
  font-size: 0.7rem;
  letter-spacing: 0.1em;
  text-transform: uppercase;
  color: var(--pale-green);
}

.ra-dano-dados {
  flex: 1;
  display: flex;
  flex-wrap: wrap;
  align-items: center;
  justify-content: center;
  gap: 4px;
}

.ra-dano-dado {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  width: 26px;
  height: 26px;
  background: var(--jungle-moss);
  border: 1px solid var(--jungle-green);
  font-family: 'Cinzel', serif;
  font-weight: 700;
  font-size: 0.75rem;
  color: var(--bone);
}

.ra-dano-dado-girando {
  animation: ra-girando 0.13s ease-in-out infinite;
  color: var(--pale-green);
}

.ra-dano-dado-assentado {
  animation: ra-assenta 0.28s cubic-bezier(0.175, 0.885, 0.32, 1.275);
}

.ra-dano-bonus-inline {
  font-family: 'Cinzel', serif;
  font-size: 0.8rem;
  color: var(--pale-green);
}

.ra-dano-valor {
  flex: none;
  font-family: 'Cinzel', serif;
  font-weight: 700;
  font-size: 1.4rem;
  color: var(--bone);
}

.ra-dano-total {
  display: flex;
  align-items: baseline;
  justify-content: space-between;
  padding-top: 0.5rem;
  border-top: 1px dashed rgba(201, 138, 46, 0.4);
}

.ra-dano-total-label {
  font-family: 'Cinzel', serif;
  font-size: 0.75rem;
  letter-spacing: 0.1em;
  text-transform: uppercase;
  color: var(--tribal-gold);
}

.ra-dano-total-valor {
  font-family: 'Cinzel', serif;
  font-weight: 700;
  font-size: 2.2rem;
  color: var(--tribal-gold);
}

.ra-acoes {
  display: flex;
  gap: 0.8rem;
  margin-top: 1.4rem;
}

.ra-btn-rolar,
.ra-btn-trocar {
  flex: 1;
  padding: 0.65rem 0;
  border-radius: 8px;
  font-family: 'Cinzel', serif;
  font-size: 0.85rem;
  letter-spacing: 0.06em;
  cursor: pointer;
  text-transform: uppercase;
}

.ra-btn-rolar {
  background: var(--jungle-green);
  border: 1px solid var(--jungle-green);
  color: var(--bone);
}

.ra-btn-rolar:hover {
  background: var(--tribal-gold);
  border-color: var(--tribal-gold);
  color: var(--jungle-void);
}

.ra-btn-trocar {
  background: none;
  border: 1px solid var(--jungle-moss);
  color: var(--pale-green);
}

.ra-btn-trocar:hover {
  border-color: var(--tribal-red);
  color: var(--tribal-red);
}
</style>

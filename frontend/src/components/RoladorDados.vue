<template>
  <div class="dado-overlay" @click.self="$emit('fechar')">
    <div class="dado-modal">
      <span class="dado-strip" aria-hidden="true"></span>
      <span class="dado-corner dado-corner-tl" aria-hidden="true"></span>
      <span class="dado-corner dado-corner-tr" aria-hidden="true"></span>
      <span class="dado-corner dado-corner-bl" aria-hidden="true"></span>
      <span class="dado-corner dado-corner-br" aria-hidden="true"></span>
      <span class="dado-bracket dado-bracket-tl" aria-hidden="true"></span>
      <span class="dado-bracket dado-bracket-tr" aria-hidden="true"></span>
      <span class="dado-bracket dado-bracket-bl" aria-hidden="true"></span>
      <span class="dado-bracket dado-bracket-br" aria-hidden="true"></span>

      <button class="fechar" @click="$emit('fechar')" aria-label="Fechar">×</button>

      <h2 class="titulo">Lançador de Dados</h2>
      <div class="titulo-divisor" aria-hidden="true">
        <span class="titulo-linha"></span>
        <span class="titulo-gema"></span>
        <span class="titulo-linha"></span>
      </div>

      <div class="dado-body">
        <div class="dado-coluna">
          <div class="dado-rotulo">Quantidade</div>
          <div class="qtd-stepper">
            <button class="qtd-btn" :disabled="rolando" @click="quantidade = Math.max(1, quantidade - 1)">−</button>
            <span class="qtd-valor">{{ quantidade }}</span>
            <button class="qtd-btn" :disabled="rolando" @click="quantidade = Math.min(20, quantidade + 1)">+</button>
          </div>

          <div class="dado-rotulo">Tipo de dado</div>
          <div class="dado-calc" :class="{ 'is-rolando': rolando }">
            <div class="calc-row">
              <button
                  v-for="f in [4, 6, 8]" :key="f"
                  class="calc-key"
                  :class="{ active: faceAtual === f }"
                  :disabled="rolando"
                  @click="rolar(f)"
              >D{{ f }}</button>
            </div>
            <div class="calc-row">
              <button
                  v-for="f in [10, 12, 20]" :key="f"
                  class="calc-key"
                  :class="{ active: faceAtual === f }"
                  :disabled="rolando"
                  @click="rolar(f)"
              >D{{ f }}</button>
            </div>
            <div class="calc-row calc-row-single">
              <button
                  class="calc-key calc-key-wide"
                  :class="{ active: faceAtual === 100 }"
                  :disabled="rolando"
                  @click="rolar(100)"
              >D100</button>
            </div>
          </div>
        </div>

        <div class="dado-coluna dado-resultado">
          <div class="dado-rotulo">Resultado</div>

          <div class="resultado-palco">
            <p v-if="!faceAtual" class="resultado-vazio">Escolha um dado pra rolar.</p>
            <div v-else class="resultado-grade">
              <div
                  v-for="(v, i) in valoresPreview"
                  :key="i"
                  class="resultado-item"
                  :class="{
                    'is-assentado': i < revelados,
                    'is-girando': i >= revelados,
                    'is-max': i < revelados && v === faceAtual,
                    'is-min': i < revelados && v === 1,
                  }"
              >{{ v }}</div>
            </div>
          </div>

          <div v-if="ultimaRolagem" class="dado-total">
            <span class="total-rotulo">Total</span>
            <span class="total-valor">{{ ultimaRolagem.total }}</span>
            <span v-if="ultimaRolagem.valores.length > 1" class="total-formula">
              ({{ ultimaRolagem.valores.join(' + ') }})
            </span>
          </div>
        </div>
      </div>

      <div class="dado-acoes">
        <button class="btn-rolar" :disabled="!faceAtual || rolando" @click="rolarNovamente">Rolar de novo</button>
        <button class="btn-limpar" :disabled="rolando" @click="limpar">Limpar</button>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, onBeforeUnmount } from 'vue';

const quantidade = ref(1);
const modificador = ref(0);
const faceAtual = ref(null);
const ultimaRolagem = ref(null);

// Animação de rolagem: enquanto `rolando`, cada posição ainda não revelada
// (índice >= revelados) fica sorteando valores aleatórios a cada tick do
// intervalo; ao ser revelada, trava no valor final e para de ser sorteada —
// mesma lógica de "girar tudo, assentar um por um" do rolador antigo
// (js/shared/dice-roller.js: overlay com dados girando + resultados
// aparecendo em sequência), só que aqui quem gira é o número, não uma peça.
const rolando = ref(false);
const valoresPreview = ref([]);
const revelados = ref(0);

let cycleId = null;
const timeoutIds = [];

function limparTimers() {
  if (cycleId) {
    clearInterval(cycleId);
    cycleId = null;
  }
  timeoutIds.splice(0).forEach(clearTimeout);
}

function rolar(faces) {
  limparTimers();
  faceAtual.value = faces;
  ultimaRolagem.value = null;
  rolando.value = true;

  const qtd = quantidade.value;
  const sorteio = () => 1 + Math.floor(Math.random() * faces);
  const valoresFinais = Array.from({ length: qtd }, sorteio);

  const giroBase = 480 + Math.random() * 220;
  const atrasoPorDado = 90;

  valoresPreview.value = valoresFinais.map(sorteio);
  revelados.value = 0;

  cycleId = setInterval(() => {
    valoresPreview.value = valoresPreview.value.map((v, i) => (i < revelados.value ? v : sorteio()));
  }, 65);

  valoresFinais.forEach((valor, i) => {
    const id = setTimeout(() => {
      revelados.value = i + 1;
      valoresPreview.value = valoresPreview.value.map((v, idx) => (idx === i ? valor : v));

      if (i === valoresFinais.length - 1) {
        clearInterval(cycleId);
        cycleId = null;

        const soma = valoresFinais.reduce((a, b) => a + b, 0);
        const total = soma + (modificador.value || 0);
        const idFinal = setTimeout(() => {
          ultimaRolagem.value = { descricao: `${qtd}d${faces}`, valores: valoresFinais, total };
          rolando.value = false;
        }, 200);
        timeoutIds.push(idFinal);
      }
    }, giroBase + i * atrasoPorDado);
    timeoutIds.push(id);
  });
}

function rolarNovamente() {
  if (faceAtual.value && !rolando.value) rolar(faceAtual.value);
}

function limpar() {
  limparTimers();
  rolando.value = false;
  ultimaRolagem.value = null;
  faceAtual.value = null;
  valoresPreview.value = [];
  revelados.value = 0;
}

onBeforeUnmount(limparTimers);

defineEmits(['fechar']);
</script>

<style scoped>
.dado-overlay {
  /* Bloco próprio de tokens — este componente é aberto via Teleport a partir
     da Navbar (fora do escopo de qualquer página), então não pode depender
     de herdar os tokens jungle/tribal/bone de um ancestral. */
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

  --wave-mask: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 40 10'%3E%3Cpath d='M0 5 Q10 0 20 5 T40 5' fill='none' stroke='%23000' stroke-width='3' stroke-linecap='round'/%3E%3C/svg%3E");

  position: fixed;
  inset: 0;
  background: rgba(0, 0, 0, 0.7);
  display: flex;
  align-items: center;
  justify-content: center;
  z-index: 300;
  padding: 1rem;
  font-family: 'Crimson Text', Georgia, serif;
}

.dado-modal {
  position: relative;
  background: linear-gradient(160deg, var(--jungle-darkest), var(--jungle-void));
  border: 2px solid var(--tribal-gold);
  padding: 2rem 1.6rem 1.6rem;
  width: 100%;
  max-width: 520px;
  color: var(--bone);
  box-shadow: 0 20px 60px rgba(0, 0, 0, 0.65);
}

.dado-strip {
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  height: 7px;
  background-color: var(--tribal-gold);
  -webkit-mask-image: var(--wave-mask);
  mask-image: var(--wave-mask);
  -webkit-mask-repeat: repeat-x;
  mask-repeat: repeat-x;
  -webkit-mask-size: 30px 7px;
  mask-size: 30px 7px;
  opacity: 0.85;
}

/* Cantos ornamentais — mesmo desenho do hero da Home: losango dourado por
   fora + moldura verde em L por dentro. */
.dado-corner {
  position: absolute;
  width: 12px;
  height: 12px;
  background: var(--tribal-gold);
  transform: rotate(45deg);
}

.dado-corner-tl { top: -7px; left: -7px; }
.dado-corner-tr { top: -7px; right: -7px; }
.dado-corner-bl { bottom: -7px; left: -7px; }
.dado-corner-br { bottom: -7px; right: -7px; }

.dado-bracket {
  position: absolute;
  width: 16px;
  height: 16px;
}

.dado-bracket-tl { top: 6px; left: 6px; border-top: 2px solid var(--jungle-green); border-left: 2px solid var(--jungle-green); }
.dado-bracket-tr { top: 6px; right: 6px; border-top: 2px solid var(--jungle-green); border-right: 2px solid var(--jungle-green); }
.dado-bracket-bl { bottom: 6px; left: 6px; border-bottom: 2px solid var(--jungle-green); border-left: 2px solid var(--jungle-green); }
.dado-bracket-br { bottom: 6px; right: 6px; border-bottom: 2px solid var(--jungle-green); border-right: 2px solid var(--jungle-green); }

.fechar {
  position: absolute;
  top: 0.6rem;
  right: 0.8rem;
  background: none;
  border: none;
  color: var(--pale-green);
  font-size: 1.4rem;
  cursor: pointer;
  line-height: 1;
  z-index: 2;
}

.fechar:hover {
  color: var(--tribal-gold);
}

.titulo {
  font-family: 'Cinzel Decorative', 'Cinzel', serif;
  font-weight: 700;
  text-transform: uppercase;
  letter-spacing: 0.1em;
  font-size: clamp(1.1rem, 3vw, 1.4rem);
  text-align: center;
  margin: 0;
  color: var(--tribal-yellow);
}

.titulo-divisor {
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 10px;
  margin: 12px 0 20px;
}

.titulo-linha {
  height: 1px;
  width: 64px;
  background: var(--jungle-green);
}

.titulo-gema {
  width: 8px;
  height: 8px;
  background: var(--tribal-red);
  transform: rotate(45deg);
}

.dado-body {
  display: grid;
  grid-template-columns: 1.05fr 1fr;
  gap: 1.4rem;
  align-items: start;
}

.dado-coluna {
  display: flex;
  flex-direction: column;
  min-width: 0;
}

.dado-rotulo {
  font-family: 'Cinzel', serif;
  font-size: 0.68rem;
  letter-spacing: 0.16em;
  text-transform: uppercase;
  color: var(--pale-green);
  margin-bottom: 0.5rem;
}

.dado-rotulo:not(:first-child) {
  margin-top: 1.2rem;
}

/* ---------- Contador de quantidade ---------- */
.qtd-stepper {
  display: flex;
  align-items: center;
  gap: 0.4rem;
}

.qtd-btn {
  width: 32px;
  height: 32px;
  border: 1px solid var(--jungle-green);
  background: var(--jungle-moss);
  color: var(--pale-green);
  font-size: 1.1rem;
  cursor: pointer;
  display: flex;
  align-items: center;
  justify-content: center;
  clip-path: polygon(6px 0, 100% 0, 100% calc(100% - 6px), calc(100% - 6px) 100%, 0 100%, 0 6px);
  transition: background 0.15s, border-color 0.15s, color 0.15s;
}

.qtd-btn:hover:not(:disabled) {
  background: rgba(212, 163, 89, 0.16);
  border-color: var(--tribal-gold);
  color: var(--tribal-gold);
}

.qtd-btn:disabled {
  opacity: 0.4;
  cursor: not-allowed;
}

.qtd-valor {
  min-width: 40px;
  text-align: center;
  background: var(--jungle-void);
  border: 1px solid var(--jungle-moss);
  padding: 0.35rem 0;
  font-family: 'Cinzel', serif;
  font-weight: 700;
  color: var(--tribal-yellow);
}

/* ---------- Grade de dados, estilo calculadora ---------- */
.dado-calc {
  display: flex;
  flex-direction: column;
  gap: 8px;
}

.calc-row {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: 8px;
}

.calc-row-single {
  grid-template-columns: 1fr;
  justify-items: center;
}

.calc-key {
  font-family: 'Cinzel', serif;
  font-weight: 700;
  font-size: 0.85rem;
  letter-spacing: 0.04em;
  padding: 0.7rem 0;
  width: 100%;
  background: var(--jungle-moss);
  border: 1px solid var(--jungle-green);
  color: var(--bone);
  cursor: pointer;
  clip-path: polygon(9px 0, 100% 0, 100% calc(100% - 9px), calc(100% - 9px) 100%, 0 100%, 0 9px);
  transition: background 0.15s, border-color 0.15s, color 0.15s, transform 0.15s;
}

.calc-key-wide {
  padding: 0.7rem 2.2rem;
}

.calc-key:hover:not(:disabled) {
  border-color: var(--tribal-gold);
  color: var(--tribal-yellow);
  transform: translateY(-1px);
}

.calc-key:disabled {
  cursor: not-allowed;
  opacity: 0.55;
}

.calc-key.active {
  background: color-mix(in srgb, var(--tribal-gold) 22%, var(--jungle-moss));
  border-color: var(--tribal-gold);
  color: var(--tribal-yellow);
}

.dado-calc.is-rolando .calc-key.active {
  animation: rd-pulso 0.5s ease-in-out infinite;
}

@keyframes rd-pulso {
  0%, 100% { box-shadow: 0 0 0 rgba(212, 163, 89, 0.5); }
  50% { box-shadow: 0 0 14px rgba(212, 163, 89, 0.8); }
}

/* ---------- Resultado ---------- */
.dado-resultado {
  min-height: 210px;
}

.resultado-palco {
  flex: 1;
  background: rgba(0, 0, 0, 0.22);
  border-left: 3px solid var(--tribal-gold);
  padding: 14px;
  min-height: 120px;
  display: flex;
  align-items: center;
}

.resultado-vazio {
  margin: 0;
  font-size: 0.85rem;
  color: var(--pale-green);
  opacity: 0.75;
}

.resultado-grade {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(44px, 1fr));
  gap: 8px;
  width: 100%;
}

.resultado-item {
  aspect-ratio: 1;
  display: flex;
  align-items: center;
  justify-content: center;
  background: var(--jungle-moss);
  border: 1px solid var(--jungle-green);
  clip-path: polygon(7px 0, 100% 0, 100% calc(100% - 7px), calc(100% - 7px) 100%, 0 100%, 0 7px);
  font-family: 'Cinzel Decorative', 'Cinzel', serif;
  font-weight: 700;
  font-size: 0.95rem;
  color: var(--bone);
}

.resultado-item.is-girando {
  animation: rd-girando 0.13s ease-in-out infinite;
  color: var(--pale-green);
  border-color: var(--jungle-moss);
}

@keyframes rd-girando {
  0%, 100% { opacity: 1; transform: translateY(0); }
  50% { opacity: 0.5; transform: translateY(-2px); }
}

.resultado-item.is-assentado {
  animation: rd-assenta 0.32s cubic-bezier(0.175, 0.885, 0.32, 1.275);
}

@keyframes rd-assenta {
  0% { transform: scale(1.4) rotate(-8deg); }
  60% { transform: scale(0.94) rotate(2deg); }
  100% { transform: scale(1) rotate(0deg); }
}

.resultado-item.is-max {
  border-color: var(--tribal-yellow);
  color: var(--tribal-yellow);
  box-shadow: 0 0 12px rgba(212, 163, 89, 0.65);
}

.resultado-item.is-min {
  border-color: var(--tribal-red);
  color: var(--pale-green);
  opacity: 0.7;
}

.dado-total {
  display: flex;
  align-items: baseline;
  flex-wrap: wrap;
  gap: 10px;
  margin-top: 14px;
  padding-top: 10px;
  border-top: 1px solid var(--jungle-moss);
}

.total-rotulo {
  font-family: 'Cinzel', serif;
  font-size: 0.68rem;
  letter-spacing: 0.16em;
  text-transform: uppercase;
  color: var(--pale-green);
}

.total-valor {
  font-family: 'Cinzel Decorative', 'Cinzel', serif;
  font-size: 2rem;
  font-weight: 700;
  color: var(--tribal-yellow);
  line-height: 1;
}

.total-formula {
  font-size: 0.8rem;
  color: var(--pale-green);
  opacity: 0.85;
}

/* ---------- Ações ---------- */
.dado-acoes {
  display: flex;
  gap: 0.8rem;
  margin-top: 1.6rem;
}

.btn-rolar,
.btn-limpar {
  flex: 1;
  padding: 0.7rem 0;
  font-family: 'Cinzel', serif;
  font-weight: 700;
  font-size: 0.75rem;
  letter-spacing: 0.14em;
  text-transform: uppercase;
  cursor: pointer;
}

.btn-rolar {
  background: var(--jungle-green);
  border: 1px solid var(--tribal-yellow);
  color: var(--bone);
  transition: background 0.15s, color 0.15s;
}

.btn-rolar:hover:not(:disabled) {
  background: var(--tribal-red);
}

.btn-rolar:disabled {
  opacity: 0.45;
  cursor: not-allowed;
}

.btn-limpar {
  background: transparent;
  border: 1px solid var(--pale-green);
  color: var(--bone);
  transition: border-color 0.15s, color 0.15s;
}

.btn-limpar:hover:not(:disabled) {
  border-color: var(--tribal-red);
  color: var(--tribal-red);
}

.btn-limpar:disabled {
  opacity: 0.45;
  cursor: not-allowed;
}

@media (max-width: 560px) {
  .dado-body {
    grid-template-columns: 1fr;
  }
}
</style>

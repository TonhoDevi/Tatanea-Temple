<template>
  <div class="dado-overlay" @click.self="$emit('fechar')">
    <div class="dado-modal">
      <button class="fechar" @click="$emit('fechar')">×</button>
      <h2 class="titulo"><span class="titulo-deco">✦</span> Lançador de Dados <span class="titulo-deco">✦</span></h2>

      <div class="dado-body">
        <div class="dado-left">
          <div class="dado-label">Quantidade</div>
          <div class="qtd-stepper">
            <button class="qtd-btn" @click="quantidade = Math.max(1, quantidade - 1)">−</button>
            <span class="qtd-valor">{{ quantidade }}</span>
            <button class="qtd-btn" @click="quantidade = Math.min(20, quantidade + 1)">+</button>
          </div>

          <div class="dado-label">Tipo de dado</div>
          <div class="honeycomb">
            <button class="face-btn face-d6" style="grid-area: d6" @click="rolar(6)" title="d6">
              <span class="face-shape shape-square">6</span>
              <span class="face-name">D6</span>
            </button>
            <button class="face-btn face-d4" style="grid-area: d4" @click="rolar(4)" title="d4">
              <span class="face-shape shape-triangle"><span>4</span></span>
              <span class="face-name">D4</span>
            </button>
            <button class="face-btn face-d8" style="grid-area: d8" @click="rolar(8)" title="d8">
              <span class="face-shape shape-diamond">8</span>
              <span class="face-name">D8</span>
            </button>
            <button class="face-btn face-d20" style="grid-area: d20" @click="rolar(20)" title="d20">
              <span class="face-shape shape-hex">20</span>
              <span class="face-name">D20</span>
            </button>
            <button class="face-btn face-d10" style="grid-area: d10" @click="rolar(10)" title="d10">
              <span class="face-shape shape-diamond shape-diamond-tall">10</span>
              <span class="face-name">D10</span>
            </button>
            <button class="face-btn face-d12" style="grid-area: d12" @click="rolar(12)" title="d12">
              <span class="face-shape shape-pentagon">12</span>
              <span class="face-name">D12</span>
            </button>
            <button class="face-btn face-d100" style="grid-area: d100" @click="rolar(100)" title="d100">
              <span class="face-shape shape-octagon">100</span>
              <span class="face-name">D100</span>
            </button>
          </div>
        </div>

        <div class="dado-right">
          <div v-if="ultimaRolagem" class="resultado-hexes">
            <div
                v-for="(v, i) in ultimaRolagem.valores"
                :key="i"
                class="hex-result"
                :class="{ max: v === maiorValor, min: v === 1 }"
            >
              <span class="hex-result-shape">{{ v }}</span>
            </div>
          </div>
          <div v-else class="resultado-vazio">Escolha um dado para rolar</div>

          <div v-if="ultimaRolagem" class="dado-total">
            <span class="total-label">Total</span>
            <span class="total-valor">{{ ultimaRolagem.total }}</span>
            <span class="total-formula">({{ ultimaRolagem.valores.join(' + ') }}{{ modificador ? (modificador >= 0 ? ' + ' + modificador : ' - ' + Math.abs(modificador)) : '' }})</span>
          </div>
        </div>
      </div>

      <div class="dado-actions">
        <button class="btn-rolar" :disabled="!faceAtual" @click="rolarNovamente">🎲 Rolar</button>
        <button class="btn-limpar" @click="limpar">Limpar</button>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, computed } from 'vue';

const quantidade = ref(5);
const modificador = ref(0);
const faceAtual = ref(null);
const ultimaRolagem = ref(null);

const maiorValor = computed(() => (ultimaRolagem.value ? Math.max(...ultimaRolagem.value.valores) : null));

function rolar(faces) {
  faceAtual.value = faces;
  const valores = [];
  for (let i = 0; i < quantidade.value; i++) {
    valores.push(1 + Math.floor(Math.random() * faces));
  }
  const soma = valores.reduce((a, b) => a + b, 0);
  const total = soma + (modificador.value || 0);
  const descricao = `${quantidade.value}d${faces}`;

  ultimaRolagem.value = { descricao, valores, total };
}

function rolarNovamente() {
  if (faceAtual.value) rolar(faceAtual.value);
}

function limpar() {
  ultimaRolagem.value = null;
  faceAtual.value = null;
}

defineEmits(['fechar']);
</script>

<style scoped>
.dado-overlay {
  --jungle-void: #0b2013;
  --jungle-darkest: #071a0f;
  --jungle-dark: #0e2818;
  --jungle-moss: #1a3d26;
  --jungle-green: #2e7d4f;
  --tribal-red: #c0405a;
  --tribal-gold: #c9a227;
  --tribal-yellow: #e8c14a;
  --bone: #f2ede1;
  --pale-green: #a8c4a2;
  --dado-purple: #6b4fa0;
  --dado-purple-light: #8f6fd0;
  --dado-teal: #2fa89a;
  --dado-blue: #2f7fd4;
  --dado-orange: #d9822b;

  position: fixed;
  inset: 0;
  background: rgba(0, 0, 0, 0.7);
  display: flex;
  align-items: center;
  justify-content: center;
  z-index: 300;
  padding: 1rem;
}

.dado-modal {
  background: linear-gradient(160deg, var(--jungle-darkest), var(--jungle-void));
  border: 1px solid var(--tribal-gold);
  border-radius: 14px;
  padding: 1.5rem;
  width: 100%;
  max-width: 480px;
  position: relative;
  color: var(--bone);
  box-shadow: 0 20px 50px rgba(0, 0, 0, 0.6);
}

.fechar {
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

.fechar:hover {
  color: var(--tribal-gold);
}

.titulo {
  font-family: 'Cinzel', serif;
  text-transform: uppercase;
  letter-spacing: 0.12em;
  font-size: 1.05rem;
  text-align: center;
  margin: 0 0 1.4rem;
  color: var(--tribal-gold);
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 0.6rem;
}

.titulo-deco {
  color: var(--tribal-yellow);
  font-size: 0.9rem;
}

.dado-body {
  display: grid;
  grid-template-columns: 1.1fr 1fr;
  gap: 1.4rem;
  align-items: start;
}

.dado-label {
  font-family: 'Cinzel', serif;
  font-size: 0.68rem;
  letter-spacing: 0.12em;
  text-transform: uppercase;
  color: var(--pale-green);
  margin-bottom: 0.5rem;
}

.dado-label + .honeycomb {
  margin-top: 0;
}

.qtd-stepper {
  display: flex;
  align-items: center;
  gap: 0.5rem;
  margin-bottom: 1.3rem;
}

.qtd-btn {
  width: 30px;
  height: 30px;
  border-radius: 6px;
  border: 1px solid var(--jungle-green);
  background: rgba(46, 125, 79, 0.18);
  color: var(--pale-green);
  font-size: 1.1rem;
  cursor: pointer;
  display: flex;
  align-items: center;
  justify-content: center;
}

.qtd-btn:hover {
  background: rgba(46, 125, 79, 0.35);
  border-color: var(--tribal-gold);
  color: var(--tribal-gold);
}

.qtd-valor {
  flex: 1;
  text-align: center;
  background: var(--jungle-dark);
  border: 1px solid var(--jungle-moss);
  border-radius: 6px;
  padding: 0.35rem 0;
  font-family: 'Cinzel', serif;
  font-weight: 700;
  color: var(--tribal-yellow);
}

.honeycomb {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  grid-template-areas:
    ".    d6   ."
    "d4   .    d8"
    ".    d20  ."
    "d10  .    d12"
    ".    d100 .";
  row-gap: 0.35rem;
  column-gap: 0.35rem;
  justify-items: center;
  max-width: 220px;
}

.face-btn {
  background: none;
  border: none;
  cursor: pointer;
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 0.2rem;
  padding: 0.2rem;
}

.face-name {
  font-family: 'Cinzel', serif;
  font-size: 0.6rem;
  letter-spacing: 0.06em;
  color: var(--pale-green);
}

.face-shape {
  display: flex;
  align-items: center;
  justify-content: center;
  width: 40px;
  height: 40px;
  color: var(--bone);
  font-family: 'Cinzel', serif;
  font-weight: 700;
  font-size: 0.7rem;
  transition: transform 0.15s ease, filter 0.15s ease;
}

.face-btn:hover .face-shape {
  transform: translateY(-2px) scale(1.06);
  filter: brightness(1.15);
}

.shape-square {
  border-radius: 6px;
  background: var(--tribal-gold);
}

.shape-diamond {
  background: var(--dado-teal);
  transform: rotate(45deg);
}

.shape-diamond span {
  transform: rotate(-45deg);
}

.shape-diamond-tall {
  background: var(--dado-blue);
}

.shape-triangle {
  width: 0;
  height: 0;
  border-left: 20px solid transparent;
  border-right: 20px solid transparent;
  border-bottom: 36px solid var(--jungle-green);
  background: none !important;
  position: relative;
}

.shape-triangle span {
  position: absolute;
  top: 16px;
  left: -8px;
  font-size: 0.65rem;
}

.shape-pentagon {
  clip-path: polygon(50% 0%, 100% 38%, 82% 100%, 18% 100%, 0% 38%);
  background: var(--tribal-red);
}

.shape-octagon {
  clip-path: polygon(30% 0%, 70% 0%, 100% 30%, 100% 70%, 70% 100%, 30% 100%, 0% 70%, 0% 30%);
  background: var(--dado-orange);
  font-size: 0.6rem;
}

.shape-hex {
  clip-path: polygon(25% 0%, 75% 0%, 100% 50%, 75% 100%, 25% 100%, 0% 50%);
  background: var(--dado-purple);
  width: 58px;
  height: 58px;
  font-size: 0.95rem;
  box-shadow: 0 0 18px rgba(107, 79, 160, 0.6);
}

.face-d20 .face-name {
  color: var(--dado-purple-light);
  font-weight: 700;
}

.dado-right {
  display: flex;
  flex-direction: column;
  gap: 1rem;
  min-height: 220px;
}

.resultado-vazio {
  color: var(--pale-green);
  font-size: 0.8rem;
  opacity: 0.7;
  padding: 1rem 0;
}

.resultado-hexes {
  display: flex;
  flex-wrap: wrap;
  gap: 0.7rem;
}

.hex-result {
  display: flex;
  align-items: center;
  justify-content: center;
  width: 46px;
  height: 46px;
  clip-path: polygon(25% 0%, 75% 0%, 100% 50%, 75% 100%, 25% 100%, 0% 50%);
  background: var(--dado-purple);
}

.hex-result-shape {
  font-family: 'Cinzel', serif;
  font-weight: 700;
  color: var(--bone);
  font-size: 0.85rem;
}

.hex-result.max {
  background: linear-gradient(145deg, var(--tribal-yellow), var(--tribal-gold));
  box-shadow: 0 0 16px rgba(232, 193, 74, 0.75);
}

.hex-result.max .hex-result-shape {
  color: var(--jungle-void);
}

.hex-result.min {
  background: #4a4560;
  opacity: 0.85;
}

.dado-total {
  display: flex;
  flex-direction: column;
  gap: 0.15rem;
  padding-top: 0.6rem;
  border-top: 1px solid var(--jungle-moss);
}

.total-label {
  font-family: 'Cinzel', serif;
  font-size: 0.68rem;
  letter-spacing: 0.12em;
  text-transform: uppercase;
  color: var(--pale-green);
}

.total-valor {
  font-family: 'Cinzel', serif;
  font-size: 2.4rem;
  font-weight: 700;
  color: var(--tribal-gold);
  line-height: 1.1;
}

.total-formula {
  font-size: 0.75rem;
  color: var(--pale-green);
  opacity: 0.85;
}

.dado-actions {
  display: flex;
  gap: 0.8rem;
  margin-top: 1.4rem;
}

.btn-rolar,
.btn-limpar {
  flex: 1;
  padding: 0.65rem 0;
  border-radius: 8px;
  font-family: 'Cinzel', serif;
  font-size: 0.85rem;
  letter-spacing: 0.06em;
  cursor: pointer;
  text-transform: uppercase;
}

.btn-rolar {
  background: var(--jungle-green);
  border: 1px solid var(--jungle-green);
  color: var(--bone);
}

.btn-rolar:hover:not(:disabled) {
  background: var(--tribal-gold);
  border-color: var(--tribal-gold);
  color: var(--jungle-void);
}

.btn-rolar:disabled {
  opacity: 0.45;
  cursor: not-allowed;
}

.btn-limpar {
  background: none;
  border: 1px solid var(--jungle-moss);
  color: var(--pale-green);
}

.btn-limpar:hover {
  border-color: var(--tribal-red);
  color: var(--tribal-red);
}

@media (max-width: 520px) {
  .dado-body {
    grid-template-columns: 1fr;
  }
}
</style>

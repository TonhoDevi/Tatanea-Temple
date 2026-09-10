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
                v-for="(v, di) in resultado.d20s"
                :key="di"
                class="ra-d20"
                :class="{
                  'ra-d20-descartado': resultado.d20s.length > 1 && di !== resultado.d20UsadoIndice,
                  'ra-critico': di === resultado.d20UsadoIndice && v === 20,
                  'ra-critfalho': di === resultado.d20UsadoIndice && v === 1,
                }"
            >{{ v }}</span>
          </div>

          <span class="ra-acerto-divisor"></span>

          <div class="ra-acerto-bonus">{{ formatarMod(resultado.acertoBonus) }}</div>

          <span class="ra-acerto-divisor"></span>

          <div class="ra-acerto-total">
            <span class="ra-acerto-total-label">Total</span>
            <span class="ra-acerto-total-valor">{{ resultado.acertoTotal }}</span>
          </div>
        </div>

        <p v-if="resultado.critico" class="ra-aviso ra-aviso-critico">Acerto crítico!</p>
        <p v-if="resultado.critFalho" class="ra-aviso ra-aviso-critfalho">Falha crítica!</p>

        <div v-if="resultado.danos.length" class="ra-danos">
          <div v-for="(d, di) in resultado.danos" :key="di" class="ra-dano-linha">
            <span class="ra-dano-tipo">{{ d.tipoDano || 'Dano' }}</span>
            <span class="ra-dano-formula">{{ d.quantidade }}{{ d.dado }} ({{ d.rolagens.join(' + ') }}){{ d.bonus ? formatarMod(d.bonus) : '' }}</span>
            <span class="ra-dano-valor">{{ d.subtotal }}</span>
          </div>
          <div class="ra-dano-total">
            <span class="ra-dano-total-label">Dano total</span>
            <span class="ra-dano-total-valor">{{ resultado.danoTotal }}</span>
          </div>
        </div>

        <div class="ra-acoes">
          <button class="ra-btn-rolar" @click="rolar">⚅ Rolar novamente</button>
          <button class="ra-btn-trocar" @click="modo = null">Trocar modo</button>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref } from 'vue';

const props = defineProps({
  ataque: { type: Object, required: true },
  acertoBonus: { type: Number, required: true },
});
defineEmits(['fechar']);

const MODO_LABEL = { normal: 'Rolagem normal', vantagem: 'Vantagem', desvantagem: 'Desvantagem' };

const modo = ref(null);
const resultado = ref(null);

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

function rolar() {
  const d20s = modo.value === 'normal' ? [rolarDado(20)] : [rolarDado(20), rolarDado(20)];
  const alvo = modo.value === 'desvantagem' ? Math.min(...d20s) : Math.max(...d20s);
  const d20UsadoIndice = d20s.indexOf(alvo);

  const danos = (props.ataque.danos || []).map((d) => {
    const faces = Number((d.dado || 'd6').replace('d', '')) || 6;
    const quantidade = d.quantidade || 1;
    const rolagens = Array.from({ length: quantidade }, () => rolarDado(faces));
    const bonus = Number(d.bonus) || 0;
    const subtotal = rolagens.reduce((soma, v) => soma + v, 0) + bonus;
    return { quantidade, dado: d.dado || 'd6', bonus, rolagens, subtotal, tipoDano: d.tipoDano };
  });

  resultado.value = {
    d20s,
    d20UsadoIndice,
    acertoBonus: props.acertoBonus,
    acertoTotal: alvo + props.acertoBonus,
    critico: alvo === 20,
    critFalho: alvo === 1,
    danos,
    danoTotal: danos.reduce((soma, d) => soma + d.subtotal, 0),
  };
}
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
  display: flex;
  align-items: center;
  justify-content: center;
  width: 64px;
  height: 64px;
  clip-path: polygon(25% 0%, 75% 0%, 100% 50%, 75% 100%, 25% 100%, 0% 50%);
  background: linear-gradient(145deg, color-mix(in srgb, var(--magic-color) 55%, white), var(--magic-color));
  font-family: 'Cinzel', serif;
  font-weight: 700;
  font-size: 1.8rem;
  color: var(--bone);
  box-shadow: 0 0 18px rgba(107, 79, 160, 0.6);
}

.ra-d20-descartado {
  background: color-mix(in srgb, var(--bg-sub) 70%, black);
  opacity: 0.45;
  box-shadow: none;
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
  align-items: baseline;
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

.ra-dano-formula {
  flex: 1;
  text-align: center;
  font-size: 0.8rem;
  color: var(--pale-green);
  opacity: 0.85;
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

<template>
  <div v-if="avisoSairAberto" class="aviso-overlay" @click.self="continuarEditando">
    <div class="aviso-modal">
      <span class="aviso-corner aviso-corner-tl" aria-hidden="true"></span>
      <span class="aviso-corner aviso-corner-tr" aria-hidden="true"></span>
      <span class="aviso-corner aviso-corner-bl" aria-hidden="true"></span>
      <span class="aviso-corner aviso-corner-br" aria-hidden="true"></span>

      <h3 class="aviso-titulo">Alterações não salvas</h3>
      <p class="aviso-texto">
        Você tem alterações na ficha que ainda não foram salvas. Se sair agora
        sem salvar, elas serão perdidas.
      </p>

      <div class="aviso-acoes">
        <button class="fc-btn aviso-btn-salvar" @click="salvarESair">Salvar e sair</button>
        <button class="fc-btn fc-btn-block" @click="sairSemSalvar">Sair sem salvar</button>
        <button class="fc-btn fc-btn-block" @click="continuarEditando">Continuar editando</button>
      </div>

      <p class="aviso-nota">
        "Salvar e sair" já libera a navegação — o envio continua em segundo
        plano, mesmo que demore alguns segundos pra confirmar com o servidor.
      </p>
    </div>
  </div>
</template>

<script setup>
import { useFichaPersonagem } from '../../composables/useFichaPersonagem';

const { avisoSairAberto, salvarESair, sairSemSalvar, continuarEditando } = useFichaPersonagem();
</script>

<style scoped>
.aviso-overlay {
  position: fixed;
  inset: 0;
  background: rgba(0, 0, 0, 0.7);
  display: flex;
  align-items: center;
  justify-content: center;
  z-index: 400;
  padding: 1rem;
  font-family: 'Crimson Text', Georgia, serif;
}

.aviso-modal {
  position: relative;
  background: linear-gradient(160deg, var(--jungle-void), var(--bg-main));
  border: 2px solid var(--tribal-gold);
  padding: 1.8rem;
  width: 100%;
  max-width: 420px;
  color: var(--bone);
  box-shadow: 0 20px 60px rgba(0, 0, 0, 0.65);
}

.aviso-corner {
  position: absolute;
  width: 10px;
  height: 10px;
  background: var(--tribal-gold);
  transform: rotate(45deg);
}

.aviso-corner-tl { top: -6px; left: -6px; }
.aviso-corner-tr { top: -6px; right: -6px; }
.aviso-corner-bl { bottom: -6px; left: -6px; }
.aviso-corner-br { bottom: -6px; right: -6px; }

.aviso-titulo {
  margin: 0 0 10px;
  font-family: 'Cinzel Decorative', 'Cinzel', serif;
  font-weight: 700;
  text-transform: uppercase;
  letter-spacing: 0.08em;
  font-size: 1.05rem;
  color: var(--tribal-yellow);
  text-align: center;
}

.aviso-texto {
  margin: 0 0 18px;
  font-size: 0.95rem;
  line-height: 1.5;
  color: var(--pale-green);
  text-align: center;
}

.aviso-acoes {
  display: flex;
  flex-direction: column;
  gap: 8px;
}

.aviso-btn-salvar {
  background: var(--jungle-green);
  border-color: var(--tribal-yellow);
  color: var(--bone);
}

.aviso-btn-salvar:hover:not(:disabled) {
  filter: brightness(1.2);
}

.aviso-nota {
  margin: 14px 0 0;
  font-family: ui-monospace, Menlo, monospace;
  font-size: 10px;
  line-height: 1.5;
  color: var(--pale-green);
  opacity: 0.8;
  text-align: center;
}
</style>

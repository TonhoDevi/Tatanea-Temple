<template>
  <div class="ficha-page" v-if="ficha">
    <div
        class="save-indicator"
        :class="{ show: mostrarSalvo || houveAlteracao, 'save-indicator-pendente': houveAlteracao && !mostrarSalvo }"
    >
      {{ mostrarSalvo ? '✓ Salvo' : '● Alterações não salvas' }}
    </div>

    <div class="ficha-layout">
      <FichaSidebar />

      <section class="ficha-workspace">
        <nav class="fc-tabs">
          <button
              v-for="t in TABS"
              :key="t.id"
              class="fc-tab"
              :class="{ 'fc-tab-active': abaAtiva === t.id }"
              @click="abaAtiva = t.id"
          >
            {{ t.label }}
          </button>
        </nav>

        <component :is="abaAtivaComponent" class="fc-panel" />
      </section>
    </div>

    <button class="btn-dados-flutuante" @click="rolagemAberta = true" title="Rolador de Dados">🎲</button>
    <RoladorDados v-if="rolagemAberta" @fechar="rolagemAberta = false" />
    <AvisoAlteracoesPendentes />
  </div>

  <div v-else class="loading-state">Carregando ficha...</div>
</template>

<script setup>
import { ref, computed, onMounted } from 'vue';
import RoladorDados from '../components/RoladorDados.vue';
import FichaSidebar from '../components/ficha/FichaSidebar.vue';
import AvisoAlteracoesPendentes from '../components/ficha/AvisoAlteracoesPendentes.vue';
import AbaAcoes from '../components/ficha/AbaAcoes.vue';
import AbaCaracteristicas from '../components/ficha/AbaCaracteristicas.vue';
import AbaHabilidades from '../components/ficha/AbaHabilidades.vue';
import AbaMagias from '../components/ficha/AbaMagias.vue';
import AbaMochila from '../components/ficha/AbaMochila.vue';
import AbaLore from '../components/ficha/AbaLore.vue';
import { criarFichaPersonagem, TABS } from '../composables/useFichaPersonagem';

defineOptions({ name: 'FichaPersonagem' });

const rolagemAberta = ref(false);
const abaAtiva = ref('acoes');

const COMPONENTES_ABA = {
  acoes: AbaAcoes,
  caracteristicas: AbaCaracteristicas,
  habilidades: AbaHabilidades,
  magias: AbaMagias,
  mochila: AbaMochila,
  lore: AbaLore,
};

const abaAtivaComponent = computed(() => COMPONENTES_ABA[abaAtiva.value]);

// criarFichaPersonagem() faz o provide() do estado para o sidebar e todas as abas
// (inclusive o guard de saída de rota e o listener de beforeunload, que vivem
// lá junto do resto da lógica de salvar — ver AvisoAlteracoesPendentes.vue).
const { ficha, mostrarSalvo, houveAlteracao, carregar } = criarFichaPersonagem();

onMounted(carregar);
</script>

<style>
/* Import global — variáveis e classes utilitárias compartilhadas por todas as
   abas e pelo sidebar (fc-box, fc-btn, inputs, etc). Não usar "scoped" aqui,
   senão as abas filhas (componentes diferentes) não herdam essas classes. */
@import '../assets/styles/ficha-shared.css';
</style>
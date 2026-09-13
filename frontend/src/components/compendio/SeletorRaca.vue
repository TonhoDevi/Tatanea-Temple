<script setup>
import { onMounted } from 'vue'
import { useCompendioStore } from '../../stores/compendioStore'

const store = useCompendioStore()
onMounted(() => store.carregarRacas())
</script>

<template>
  <section class="seletor-raca">
    <h1>Escolha sua Raça</h1>

    <p v-if="store.carregando">Carregando raças...</p>
    <p v-else-if="store.erro" class="erro">{{ store.erro }}</p>

    <div v-else class="grid-racas">
      <button
        v-for="raca in store.racas"
        :key="raca.id"
        class="card-raca"
        @click="store.selecionarRaca(raca.id)"
      >
        <h2>{{ raca.nome }}</h2>
        <span class="tamanho">{{ raca.tamanho }}</span>
      </button>
    </div>

    <div v-if="store.racaSelecionada" class="detalhe-raca">
      <h2>{{ store.racaSelecionada.nome }}</h2>
      <p>{{ store.racaSelecionada.descricao }}</p>

      <h3>Traços</h3>
      <ul>
        <li v-for="(traco, i) in store.racaSelecionada.tracos" :key="i">{{ traco.texto }}</li>
      </ul>

      <h3>Habilidades</h3>
      <ul>
        <li v-for="hab in store.racaSelecionada.habilidades" :key="hab.nome">
          <strong>{{ hab.nome }}</strong> — {{ hab.descricao }}
        </li>
      </ul>
    </div>
  </section>
</template>

<style scoped>
.seletor-raca {
  --jungle-void: var(--bg-deep);
  --jungle-dark: var(--bg-card);
  --jungle-moss: var(--bg-subcard);
  --tribal-red: var(--accent-terracotta);
  --tribal-gold: var(--accent-gold);
  --tribal-yellow: var(--accent-gold);
  --bone: var(--text-pale);

  font-family: 'Crimson Text', serif;
  color: var(--bone);
  background: var(--jungle-void);
  min-height: 100vh;
  padding: 2rem;
}

h1 {
  font-family: 'Pirata One', cursive;
  font-size: 2.5rem;
}

.grid-racas {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(180px, 1fr));
  gap: 1rem;
  margin-top: 1.5rem;
}

.card-raca {
  background: var(--jungle-dark);
  border: 1px solid var(--tribal-gold);
  border-radius: 8px;
  padding: 1rem;
  color: inherit;
  cursor: pointer;
  text-align: left;
  transition: border-color 0.2s;
}

.card-raca:hover {
  border-color: var(--tribal-yellow);
}

.detalhe-raca {
  margin-top: 2rem;
  border-top: 1px solid var(--tribal-gold);
  padding-top: 1.5rem;
}

.erro {
  color: var(--tribal-red);
}
</style>

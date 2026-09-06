<template>
  <div class="page-main">
    <div class="page-header">
      <span class="page-header-rune">📜</span>
      <h1>Meus Personagens</h1>
      <p>Todas as suas fichas</p>
    </div>

    <div class="new-sheet-bar">
      <button class="btn-new" @click="criarNovo" :disabled="criando">
        ⚔️ {{ criando ? 'Criando...' : 'Nova Ficha D&D' }}
      </button>
    </div>

    <div v-if="carregando" class="loading-state">Carregando fichas...</div>
    <div v-else-if="!personagens.length" class="loading-state">
      Nenhum personagem ainda. Crie o primeiro acima.
    </div>

    <div v-else class="sheets-grid">
      <div v-for="p in personagens" :key="p.id" class="sheet-card">
        <RouterLink :to="`/personagens/${p.id}`" class="sheet-card-link">
          <div class="sheet-card-img" v-if="p.imagemUrl">
            <img :src="p.imagemUrl" :alt="p.nome" />
          </div>
          <div class="sheet-card-body">
            <h2>{{ p.nome }}</h2>
            <p>Nível {{ p.nivel }} · {{ p.classeId || 'Sem classe' }}</p>
            <p class="sheet-card-pv">PV {{ p.pvAtual }} / {{ p.pvMaximo }}</p>
          </div>
        </RouterLink>
        <button class="btn-remover" @click="remover(p.id)">Excluir</button>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue';
import personagemService from '../services/personagemService';

const personagens = ref([]);
const carregando = ref(true);
const criando = ref(false);

async function carregar() {
  carregando.value = true;
  personagens.value = await personagemService.listar();
  carregando.value = false;
}

async function criarNovo() {
  criando.value = true;
  try {
    const novo = await personagemService.criar({
      nome: 'Novo Personagem',
      tipo: 'dnd',
      nomeJogador: null,
      racaId: null,
      classeId: null,
      nivel: 1,
      imagemUrl: null,
      forca: 10,
      destreza: 10,
      constituicao: 10,
      inteligencia: 10,
      sabedoria: 10,
      carisma: 10,
      pvAtual: 0,
      pvMaximo: 0,
      pvTemporario: 0,
      ca: 10,
      deslocamento: '9 m',
      iniciativaBonus: 0,
      inspiracao: false,
      dadosVidaGastos: 0,
      antecedente: null,
      tendencia: null,
      pontoHeroico: false,
      moedaPc: 0,
      moedaPp: 0,
      moedaPo: 0,
      moedaPe: 0,
      moedaPl: 0,
      deslocNadar: null,
      deslocVoar: null,
      deslocEscalar: null,
      salto: null,
      idiomas: null,
      historia: null,
      anotacoes: null,
      pericias: [],
      ataques: [],
      inventario: [],
      itensMagicos: [],
      habilidades: [],
      magias: [],
      unidades: [],
      tags: [],
    });
    personagens.value.push(novo);
  } finally {
    criando.value = false;
  }
}

async function remover(id) {
  if (!confirm('Excluir esse personagem? Essa ação não pode ser desfeita.')) return;
  await personagemService.remover(id);
  personagens.value = personagens.value.filter((p) => p.id !== id);
}

onMounted(carregar);
</script>

<style scoped>
.page-main {
  max-width: 1100px;
  margin: 0 auto;
  padding: 2rem 1rem;
  color: #e8e0f5;
}

.page-header {
  text-align: center;
  margin-bottom: 1.5rem;
}

.page-header h1 {
  font-family: 'Pirata One', cursive;
  font-size: 2.2rem;
  margin: 0.3rem 0;
}

.page-header-rune {
  font-size: 2rem;
}

.new-sheet-bar {
  display: flex;
  justify-content: center;
  margin-bottom: 2rem;
}

.btn-new {
  background: #8a6ac0;
  color: #fff;
  border: none;
  border-radius: 8px;
  padding: 0.8rem 1.6rem;
  font-family: 'Cinzel', serif;
  cursor: pointer;
}

.btn-new:disabled {
  opacity: 0.6;
  cursor: not-allowed;
}

.loading-state {
  text-align: center;
  padding: 2rem;
  opacity: 0.8;
}

.sheets-grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(240px, 1fr));
  gap: 1rem;
}

.sheet-card {
  background: #201735;
  border: 1px solid #4a3a6a;
  border-radius: 10px;
  overflow: hidden;
  display: flex;
  flex-direction: column;
}

.sheet-card-link {
  color: inherit;
  text-decoration: none;
  flex: 1;
}

.sheet-card-img img {
  width: 100%;
  height: 140px;
  object-fit: cover;
}

.sheet-card-body {
  padding: 1rem;
}

.sheet-card-body h2 {
  font-family: 'Cinzel', serif;
  font-size: 1.1rem;
  margin: 0 0 0.4rem;
}

.sheet-card-body p {
  margin: 0.2rem 0;
  font-size: 0.85rem;
  opacity: 0.85;
}

.sheet-card-pv {
  color: #e87070;
}

.btn-remover {
  background: none;
  border: none;
  border-top: 1px solid #4a3a6a;
  color: #e87070;
  padding: 0.6rem;
  cursor: pointer;
  font-family: 'Cinzel', serif;
  font-size: 0.75rem;
}
</style>
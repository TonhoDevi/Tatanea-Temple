<template>
  <div class="compendio-alquimia">
    <h1 class="titulo-pagina">Compêndio de Alquimia</h1>

    <div class="secao-essencias">
      <h2 class="subtitulo">Essências</h2>
      <div class="grid-essencias">
        <div v-for="e in essencias" :key="e.simbolo" class="chip-essencia" :style="{ borderColor: e.cor, background: e.corFundo }">
          <span class="simbolo" :style="{ color: e.cor }">{{ e.simbolo }}</span>
          <div>
            <strong>{{ e.nome }}</strong>
            <span class="elemento">{{ e.elemento }}</span>
          </div>
        </div>
      </div>
    </div>

    <div class="filtros">
      <input v-model="busca" type="text" class="input-busca" placeholder="Buscar poção..." />
    </div>

    <p class="resultados-bar">
      Mostrando <strong>{{ pocoesFiltradas.length }}</strong> de
      <strong>{{ pocoes.length }}</strong> poções
    </p>

    <div v-if="carregando" class="carregando">Carregando alquimia...</div>
    <div v-else-if="erro" class="erro">{{ erro }}</div>

    <div v-else class="grid-pocoes">
      <button v-for="p in pocoesFiltradas" :key="p.id" class="card-pocao" @click="abrirDetalhe(p.id)">
        <div class="card-header">
          <span class="icone">{{ p.icone }}</span>
          <div>
            <h2 class="nome">{{ p.nome }}</h2>
            <span class="raridade">{{ p.raridade }}</span>
          </div>
        </div>
        <p class="descricao-curta">{{ p.descricao }}</p>
      </button>
    </div>

    <div v-if="detalhe" class="modal-overlay" @click.self="fecharDetalhe">
      <div class="modal-conteudo">
        <button class="fechar" @click="fecharDetalhe">×</button>
        <div class="modal-header">
          <span class="icone-grande">{{ detalhe.icone }}</span>
          <div>
            <h2>{{ detalhe.nome }}</h2>
            <span class="raridade">{{ detalhe.raridade }}</span>
          </div>
        </div>

        <p class="descricao">{{ detalhe.descricao }}</p>

        <div class="grid-info">
          <div><strong>Fórmula:</strong> {{ detalhe.formula }}</div>
          <div><strong>Duração:</strong> {{ detalhe.duracao }}</div>
          <div v-if="detalhe.nucleo"><strong>Núcleo:</strong> {{ detalhe.nucleo }}</div>
        </div>

        <div v-if="detalhe.melhoria" class="secao">
          <h3>Melhoria</h3>
          <p>{{ detalhe.melhoria }}</p>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, computed, onMounted } from 'vue';
import alquimiaService from '../../services/alquimiaService';

const essencias = ref([]);
const pocoes = ref([]);
const busca = ref('');
const carregando = ref(true);
const erro = ref(null);
const detalhe = ref(null);

const pocoesFiltradas = computed(() => {
  const termo = busca.value.toLowerCase().trim();
  if (!termo) return pocoes.value;
  return pocoes.value.filter((p) => {
    const alvo = [p.nome, p.raridade, p.descricao].join(' ').toLowerCase();
    return alvo.includes(termo);
  });
});

async function carregar() {
  carregando.value = true;
  erro.value = null;
  try {
    [essencias.value, pocoes.value] = await Promise.all([
      alquimiaService.listarEssencias(),
      alquimiaService.listarPocoes(),
    ]);
  } catch (e) {
    erro.value = 'Não foi possível carregar a alquimia.';
  } finally {
    carregando.value = false;
  }
}

async function abrirDetalhe(id) {
  try {
    detalhe.value = await alquimiaService.buscarPocaoPorId(id);
  } catch (e) {
    erro.value = 'Não foi possível carregar os detalhes da poção.';
  }
}

function fecharDetalhe() {
  detalhe.value = null;
}

onMounted(carregar);
</script>

<style scoped>
.compendio-alquimia {
  max-width: 1100px;
  margin: 0 auto;
  padding: 2rem 1rem;
  color: #e8e0f5;
}

.titulo-pagina {
  font-family: 'Pirata One', cursive;
  font-size: 2.5rem;
  text-align: center;
  margin-bottom: 1.5rem;
}

.subtitulo {
  font-family: 'Cinzel', serif;
  font-size: 1.1rem;
  margin-bottom: 0.75rem;
}

.secao-essencias {
  margin-bottom: 2rem;
}

.grid-essencias {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(160px, 1fr));
  gap: 0.6rem;
}

.chip-essencia {
  display: flex;
  align-items: center;
  gap: 0.6rem;
  border: 1px solid;
  border-radius: 8px;
  padding: 0.6rem 0.8rem;
}

.chip-essencia .simbolo {
  font-size: 1.4rem;
  font-family: 'Cinzel', serif;
}

.chip-essencia strong {
  display: block;
  font-size: 0.85rem;
}

.chip-essencia .elemento {
  font-size: 0.7rem;
  opacity: 0.7;
}

.filtros {
  display: flex;
  justify-content: center;
  margin-bottom: 1rem;
}

.input-busca {
  width: 100%;
  max-width: 400px;
  padding: 0.6rem 1rem;
  border-radius: 8px;
  border: 1px solid #5a4a7a;
  background: #1a1330;
  color: #e8e0f5;
}

.resultados-bar {
  text-align: center;
  opacity: 0.8;
  margin-bottom: 1.5rem;
}

.grid-pocoes {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(260px, 1fr));
  gap: 1rem;
}

.card-pocao {
  text-align: left;
  background: #201735;
  border: 1px solid #4a3a6a;
  border-radius: 10px;
  padding: 1rem;
  cursor: pointer;
  color: inherit;
  font: inherit;
  transition: transform 0.15s ease, box-shadow 0.15s ease;
}

.card-pocao:hover {
  transform: translateY(-3px);
  box-shadow: 0 6px 18px rgba(0, 0, 0, 0.4);
}

.card-header {
  display: flex;
  gap: 0.6rem;
  align-items: center;
  margin-bottom: 0.5rem;
}

.icone {
  font-size: 1.6rem;
}

.nome {
  font-family: 'Cinzel', serif;
  margin: 0;
  font-size: 1.05rem;
}

.raridade {
  font-size: 0.75rem;
  opacity: 0.7;
  text-transform: capitalize;
}

.descricao-curta {
  font-size: 0.82rem;
  opacity: 0.85;
  margin: 0;
  display: -webkit-box;
  -webkit-line-clamp: 3;
  -webkit-box-orient: vertical;
  overflow: hidden;
}

.carregando,
.erro {
  text-align: center;
  padding: 2rem;
}

.modal-overlay {
  position: fixed;
  inset: 0;
  background: rgba(0, 0, 0, 0.7);
  display: flex;
  align-items: center;
  justify-content: center;
  padding: 1rem;
  z-index: 100;
}

.modal-conteudo {
  background: #1a1330;
  border: 1px solid #4a3a6a;
  border-radius: 12px;
  padding: 2rem;
  max-width: 560px;
  width: 100%;
  max-height: 85vh;
  overflow-y: auto;
  position: relative;
}

.fechar {
  position: absolute;
  top: 0.75rem;
  right: 1rem;
  background: none;
  border: none;
  color: #e8e0f5;
  font-size: 1.5rem;
  cursor: pointer;
}

.modal-header {
  display: flex;
  gap: 1rem;
  align-items: center;
  margin-bottom: 1rem;
}

.icone-grande {
  font-size: 2.2rem;
}

.descricao {
  margin-bottom: 1rem;
  line-height: 1.5;
}

.grid-info {
  display: grid;
  gap: 0.4rem;
  margin-bottom: 1rem;
  font-size: 0.9rem;
}

.secao h3 {
  font-family: 'Cinzel', serif;
  font-size: 1rem;
  margin-bottom: 0.5rem;
  border-bottom: 1px solid #4a3a6a;
  padding-bottom: 0.3rem;
}
</style>
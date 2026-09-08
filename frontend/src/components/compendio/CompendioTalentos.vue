<template>
  <div class="compendio-talentos">
    <h1 class="titulo-pagina">Compêndio de Talentos</h1>

    <div class="filtros">
      <input v-model="busca" type="text" class="input-busca" placeholder="Buscar talento..." />
    </div>

    <p class="resultados-bar">
      Mostrando <strong>{{ talentosFiltrados.length }}</strong> de
      <strong>{{ talentos.length }}</strong> talentos
    </p>

    <div v-if="carregando" class="carregando">Carregando talentos...</div>
    <div v-else-if="erro" class="erro">{{ erro }}</div>

    <div v-else class="grid-talentos">
      <button
        v-for="t in talentosFiltrados"
        :key="t.id"
        class="card-talento"
        @click="abrirDetalhe(t.id)"
      >
        <div class="card-header">
          <span class="icone">{{ t.icone }}</span>
          <div>
            <h2 class="nome">{{ t.nome }}</h2>
            <span class="categoria">{{ t.categoria }}</span>
          </div>
        </div>
        <p class="descricao-curta">{{ t.descricao }}</p>
      </button>
    </div>

    <div v-if="detalhe" class="modal-overlay" @click.self="fecharDetalhe">
      <div class="modal-conteudo">
        <button class="fechar" @click="fecharDetalhe">×</button>
        <div class="modal-header">
          <span class="icone-grande">{{ detalhe.icone }}</span>
          <div>
            <h2>{{ detalhe.nome }}</h2>
            <span class="categoria">{{ detalhe.categoria }}</span>
          </div>
        </div>

        <p v-if="detalhe.prereq" class="prereq">Pré-requisito: {{ detalhe.prereq }}</p>

        <p class="descricao">{{ detalhe.descricao }}</p>

        <div class="secao">
          <h3>Benefícios</h3>
          <ul>
            <li v-for="(b, i) in detalhe.beneficios" :key="i">{{ b.texto }}</li>
          </ul>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, computed, onMounted } from 'vue';
import talentoService from '../../services/talentoService';

const talentos = ref([]);
const busca = ref('');
const carregando = ref(true);
const erro = ref(null);
const detalhe = ref(null);

const talentosFiltrados = computed(() => {
  const termo = busca.value.toLowerCase().trim();
  if (!termo) return talentos.value;
  return talentos.value.filter((t) => {
    const alvo = [t.nome, t.categoria, t.descricao].join(' ').toLowerCase();
    return alvo.includes(termo);
  });
});

async function carregar() {
  carregando.value = true;
  erro.value = null;
  try {
    talentos.value = await talentoService.listar();
  } catch (e) {
    erro.value = 'Não foi possível carregar os talentos.';
  } finally {
    carregando.value = false;
  }
}

async function abrirDetalhe(id) {
  try {
    detalhe.value = await talentoService.buscarPorId(id);
  } catch (e) {
    erro.value = 'Não foi possível carregar os detalhes do talento.';
  }
}

function fecharDetalhe() {
  detalhe.value = null;
}

onMounted(carregar);
</script>

<style scoped>
.compendio-talentos {
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

.grid-talentos {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(260px, 1fr));
  gap: 1rem;
}

.card-talento {
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

.card-talento:hover {
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

.categoria {
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

.prereq {
  font-size: 0.85rem;
  color: #e8c060;
  margin-bottom: 0.75rem;
}

.descricao {
  margin-bottom: 1rem;
  line-height: 1.5;
}

.secao h3 {
  font-family: 'Cinzel', serif;
  font-size: 1rem;
  margin-bottom: 0.5rem;
  border-bottom: 1px solid #4a3a6a;
  padding-bottom: 0.3rem;
}
</style>
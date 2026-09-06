<template>
  <div class="compendio-classes">
    <h1 class="titulo-pagina">Compêndio de Classes</h1>

    <div class="filtros">
      <input
          v-model="busca"
          type="text"
          class="input-busca"
          placeholder="Buscar classe..."
      />
    </div>

    <p class="resultados-bar">
      Mostrando <strong>{{ classesFiltradas.length }}</strong> de
      <strong>{{ classes.length }}</strong> classes
    </p>

    <div v-if="carregando" class="carregando">Carregando classes...</div>
    <div v-else-if="erro" class="erro">{{ erro }}</div>

    <div v-else class="grid-classes">
      <button
          v-for="c in classesFiltradas"
          :key="c.id"
          class="card-classe"
          :style="{ '--cls-cor': c.cor, borderLeftColor: c.cor }"
          @click="abrirDetalhe(c.id)"
      >
        <div class="card-header">
          <span class="icone">{{ c.icone }}</span>
          <div>
            <h2 class="nome">{{ c.nome }}</h2>
            <span class="subtitulo">{{ c.subtitulo }}</span>
          </div>
        </div>
        <div class="stats">
          <span class="pill">{{ c.dadoDeVida }} / nível</span>
          <span class="pill">{{ c.dificuldade }}</span>
        </div>
        <div class="papeis">
          <span v-for="p in c.papeis" :key="p" class="role-pill">{{ p }}</span>
        </div>
      </button>
    </div>

    <div v-if="detalhe" class="modal-overlay" @click.self="fecharDetalhe">
      <div class="modal-conteudo">
        <button class="fechar" @click="fecharDetalhe">×</button>
        <div class="modal-header">
          <span class="icone-grande">{{ detalhe.icone }}</span>
          <div>
            <h2>{{ detalhe.nome }}</h2>
            <span class="subtitulo">{{ detalhe.subtitulo }}</span>
          </div>
        </div>

        <p class="descricao">{{ detalhe.descricao }}</p>

        <div class="grid-info">
          <div><strong>Dado de Vida:</strong> {{ detalhe.dadoDeVida }}</div>
          <div><strong>Atributo Chave:</strong> {{ detalhe.atributoChave }}</div>
          <div><strong>Armadura:</strong> {{ detalhe.armadura }}</div>
          <div><strong>Armas:</strong> {{ detalhe.armas }}</div>
          <div><strong>Ferramentas:</strong> {{ detalhe.ferramentas }}</div>
          <div><strong>Resistências:</strong> {{ detalhe.resistencias }}</div>
        </div>

        <div class="secao">
          <h3>Perícias</h3>
          <p>{{ detalhe.pericias }}</p>
        </div>

        <div class="secao">
          <h3>Papéis</h3>
          <div class="papeis">
            <span v-for="p in detalhe.papeis" :key="p" class="role-pill">{{ p }}</span>
          </div>
        </div>

        <div class="secao">
          <h3>Habilidades em Destaque</h3>
          <ul>
            <li v-for="h in detalhe.habilidadesDestaque" :key="h">{{ h }}</li>
          </ul>
        </div>

        <div class="secao">
          <h3>Subclasses</h3>
          <div class="subclasses">
            <div v-for="s in detalhe.subclasses" :key="s.nome" class="subclasse">
              <span class="icone">{{ s.icone }}</span>
              <div>
                <strong>{{ s.nome }}</strong>
                <p>{{ s.descricao }}</p>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, computed, onMounted } from 'vue';
import classeService from '../../services/classeService';

const classes = ref([]);
const busca = ref('');
const carregando = ref(true);
const erro = ref(null);
const detalhe = ref(null);

const classesFiltradas = computed(() => {
  const termo = busca.value.toLowerCase().trim();
  if (!termo) return classes.value;
  return classes.value.filter(c => {
    const alvo = [c.nome, c.dificuldade, ...(c.papeis || [])].join(' ').toLowerCase();
    return alvo.includes(termo);
  });
});

async function carregar() {
  carregando.value = true;
  erro.value = null;
  try {
    classes.value = await classeService.listar();
  } catch (e) {
    erro.value = 'Não foi possível carregar as classes.';
  } finally {
    carregando.value = false;
  }
}

async function abrirDetalhe(id) {
  try {
    detalhe.value = await classeService.buscarPorId(id);
  } catch (e) {
    erro.value = 'Não foi possível carregar os detalhes da classe.';
  }
}

function fecharDetalhe() {
  detalhe.value = null;
}

onMounted(carregar);
</script>

<style scoped>
.compendio-classes {
  max-width: 1100px;
  margin: 0 auto;
  padding: 2rem 1rem;
  color: var(--cs-texto, #e8e0f5);
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

.grid-classes {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
  gap: 1.2rem;
}

.card-classe {
  text-align: left;
  background: #201735;
  border: 1px solid #4a3a6a;
  border-left: 4px solid var(--cls-cor, #8a6ac0);
  border-radius: 10px;
  padding: 1rem;
  cursor: pointer;
  color: inherit;
  font: inherit;
  transition: transform 0.15s ease, box-shadow 0.15s ease;
}

.card-classe:hover {
  transform: translateY(-3px);
  box-shadow: 0 6px 18px rgba(0, 0, 0, 0.4);
}

.card-header {
  display: flex;
  gap: 0.75rem;
  align-items: center;
  margin-bottom: 0.75rem;
}

.icone {
  font-size: 1.8rem;
}

.nome {
  font-family: 'Cinzel', serif;
  margin: 0;
  font-size: 1.2rem;
}

.subtitulo {
  font-size: 0.85rem;
  opacity: 0.7;
}

.stats {
  display: flex;
  gap: 0.5rem;
  margin-bottom: 0.5rem;
}

.pill,
.role-pill {
  background: #362a54;
  border-radius: 999px;
  padding: 0.2rem 0.7rem;
  font-size: 0.75rem;
}

.papeis {
  display: flex;
  flex-wrap: wrap;
  gap: 0.4rem;
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
  max-width: 640px;
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
  font-size: 2.5rem;
}

.descricao {
  margin-bottom: 1rem;
  line-height: 1.5;
}

.grid-info {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 0.5rem;
  margin-bottom: 1rem;
  font-size: 0.9rem;
}

.secao {
  margin-top: 1.2rem;
}

.secao h3 {
  font-family: 'Cinzel', serif;
  font-size: 1rem;
  margin-bottom: 0.5rem;
  border-bottom: 1px solid #4a3a6a;
  padding-bottom: 0.3rem;
}

.subclasses {
  display: flex;
  flex-direction: column;
  gap: 0.75rem;
}

.subclasse {
  display: flex;
  gap: 0.75rem;
  align-items: flex-start;
}

.subclasse p {
  margin: 0.2rem 0 0;
  font-size: 0.85rem;
  opacity: 0.85;
}
</style>
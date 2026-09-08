<template>
  <div>
    <!-- RETRATO + DETALHES FÍSICOS -->
    <div class="fc-box fc-lore-top">
      <div class="fc-retrato-col">
        <div class="fc-box-title">Retrato</div>
        <label class="fc-dropzone" :class="{ 'fc-dropzone-has-image': ficha.imagemUrl }">
          <img v-if="ficha.imagemUrl" :src="ficha.imagemUrl" class="fc-dropzone-img" :alt="ficha.nome" />
          <template v-else>
            <span class="fc-dropzone-icon">🖼</span>
            <span class="fc-dropzone-text">Clique para adicionar</span>
          </template>
          <input type="file" accept="image/*" class="fc-dropzone-input" @change="selecionarImagem" />
        </label>

        <button type="button" class="fc-btn fc-btn-block fc-btn-escolher" @click="$refs.imagemInput.click()">
          📤 Escolher
        </button>
        <input ref="imagemInput" type="file" accept="image/*" style="display:none" @change="selecionarImagem" />
        <button v-if="ficha.imagemUrl" type="button" class="fc-btn fc-btn-danger fc-btn-block" @click="removerImagem">
          Remover imagem
        </button>
      </div>

      <div class="fc-detalhes-col">
        <div class="fc-box-title">Detalhes físicos</div>
        <div class="fc-field-grid">
          <label class="fc-field">
            <span class="fc-mini-label">Idade</span>
            <input type="text" v-model="detalhesFisicos.idade" />
          </label>
          <label class="fc-field">
            <span class="fc-mini-label">Altura</span>
            <input type="text" v-model="detalhesFisicos.altura" />
          </label>
          <label class="fc-field">
            <span class="fc-mini-label">Peso</span>
            <input type="text" v-model="detalhesFisicos.peso" />
          </label>
        </div>
        <label class="fc-field">
          <span class="fc-mini-label">Características</span>
          <textarea
              v-model="detalhesFisicos.caracteristicas"
              placeholder="Aparência, marcas distintivas..."
          ></textarea>
        </label>
        <p class="fc-hint">Detalhes físicos — provisório, ainda só neste navegador, não é salvo com a ficha.</p>
      </div>
    </div>

    <!-- PERSONALIDADE -->
    <div class="fc-box">
      <div class="fc-box-title">Personalidade</div>
      <div class="fc-field-grid-2">
        <label class="fc-field">
          <span class="fc-mini-label">Traços</span>
          <textarea v-model="personalidade.tracos"></textarea>
        </label>
        <label class="fc-field">
          <span class="fc-mini-label">Ideais</span>
          <textarea v-model="personalidade.ideais"></textarea>
        </label>
        <label class="fc-field">
          <span class="fc-mini-label">Vínculos</span>
          <textarea v-model="personalidade.vinculos"></textarea>
        </label>
        <label class="fc-field">
          <span class="fc-mini-label">Defeitos</span>
          <textarea v-model="personalidade.defeitos"></textarea>
        </label>
      </div>
      <p class="fc-hint">Personalidade — provisório, ainda só neste navegador, não é salvo com a ficha.</p>
    </div>

    <div class="fc-box">
      <div class="fc-box-title">Identidade</div>
      <div class="fc-field-grid">
        <label class="fc-field">
          <span class="fc-mini-label">Jogador</span>
          <input type="text" v-model="ficha.nomeJogador" @input="agendarSalvar" />
        </label>
        <label class="fc-field">
          <span class="fc-mini-label">Antecedente</span>
          <input type="text" v-model="ficha.antecedente" @input="agendarSalvar" />
        </label>
        <label class="fc-field">
          <span class="fc-mini-label">Tendência</span>
          <input type="text" v-model="ficha.tendencia" @input="agendarSalvar" />
        </label>
      </div>
    </div>

    <div class="fc-box">
      <div class="fc-box-title">Conhecidos & aliados</div>
      <div v-for="(u, i) in ficha.unidades" :key="i" class="fc-list-row">
        <input type="text" v-model="u.nome" placeholder="Nome" @input="agendarSalvar" />
        <input type="text" v-model="u.tipo" placeholder="Tipo (familiar, montaria...)" @input="agendarSalvar" />
        <button class="fc-btn-remove" @click="removerItem(ficha.unidades, i)">×</button>
      </div>
      <button class="fc-btn-add" @click="adicionarUnidade">+ Adicionar conhecido</button>
    </div>

    <div class="fc-box">
      <div class="fc-box-title">História</div>
      <textarea v-model="ficha.historia" @input="agendarSalvar" style="min-height: 200px" placeholder="A história do personagem..."></textarea>
    </div>

    <div class="fc-box">
      <div class="fc-box-title">Anotações de sessão</div>
      <textarea v-model="ficha.anotacoes" @input="agendarSalvar" style="min-height: 160px" placeholder="Notas, lembretes, missões..."></textarea>
    </div>
  </div>
</template>

<script setup>
import { useFichaPersonagem } from '../../composables/useFichaPersonagem';

const {
  ficha, detalhesFisicos, personalidade,
  agendarSalvar, removerItem, adicionarUnidade,
  selecionarImagem, removerImagem,
} = useFichaPersonagem();
</script>

<style scoped>
.fc-lore-top {
  display: grid;
  grid-template-columns: minmax(220px, 300px) 1fr;
  gap: 20px;
  align-items: start;
}

.fc-retrato-col,
.fc-detalhes-col {
  display: flex;
  flex-direction: column;
  gap: 10px;
}

.fc-dropzone {
  position: relative;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  gap: 10px;
  aspect-ratio: 3 / 4;
  border: 2px dashed rgba(46, 125, 79, 0.7);
  background:
      repeating-linear-gradient(45deg, rgba(46, 125, 79, 0.28) 0 6px, transparent 6px 14px),
      var(--jungle-void);
  cursor: pointer;
  overflow: hidden;
  transition: border-color 0.2s ease;
}

.fc-dropzone:hover {
  border-color: var(--tribal-gold);
}

.fc-dropzone-icon {
  font-size: 40px;
  opacity: 0.55;
}

.fc-dropzone-text {
  font-family: 'Cinzel', serif;
  font-size: 10px;
  letter-spacing: 0.14em;
  text-transform: uppercase;
  color: var(--pale-green);
}

.fc-dropzone-input {
  display: none;
}

.fc-dropzone-img {
  width: 100%;
  height: 100%;
  object-fit: cover;
}

.fc-btn-escolher {
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 8px;
}

.fc-field-grid-2 {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 10px 16px;
}

@media (max-width: 700px) {
  .fc-lore-top {
    grid-template-columns: 1fr;
  }
  .fc-field-grid-2 {
    grid-template-columns: 1fr;
  }
}
</style>
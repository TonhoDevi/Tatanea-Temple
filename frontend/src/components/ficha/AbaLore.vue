<template>
  <div>
    <!-- RETRATO + DETALHES FÍSICOS -->
    <div class="fc-box fc-lore-top">
      <div class="fc-retrato-col">
        <div class="fc-box-title">Retrato</div>
        <label class="fc-dropzone" :class="{ 'fc-dropzone-has-image': ficha.imagemDados }">
          <img v-if="ficha.imagemDados" :src="ficha.imagemDados" class="fc-dropzone-img" :alt="ficha.nome" />
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
        <button v-if="ficha.imagemDados" type="button" class="fc-btn fc-btn-danger fc-btn-block" @click="removerImagem">
          Remover imagem
        </button>
      </div>

      <div class="fc-detalhes-col">
        <div class="fc-box-title">Detalhes físicos</div>
        <div class="fc-detalhes-fisicos-campos">
          <label class="fc-field">
            <span class="fc-mini-label">Idade</span>
            <input type="number" min="0" v-model.number="ficha.detalheIdade" @input="agendarSalvar" />
            <span v-if="mensagemIdade" class="fc-fisico-msg">{{ mensagemIdade }}</span>
          </label>
          <label class="fc-field">
            <span class="fc-mini-label">Altura (cm)</span>
            <input type="number" min="0" v-model.number="ficha.detalheAltura" @input="agendarSalvar" />
            <span v-if="mensagemAltura" class="fc-fisico-msg">{{ mensagemAltura }}</span>
          </label>
          <label class="fc-field">
            <span class="fc-mini-label">Peso (kg)</span>
            <input type="number" min="0" v-model.number="ficha.detalhePeso" @input="agendarSalvar" />
            <span v-if="mensagemPeso" class="fc-fisico-msg">{{ mensagemPeso }}</span>
          </label>
        </div>
        <label class="fc-field">
          <span class="fc-mini-label">Características</span>
          <textarea
              v-model="ficha.detalheCaracteristicas"
              placeholder="Aparência, marcas distintivas..."
              @input="agendarSalvar"
          ></textarea>
        </label>
      </div>
    </div>

    <!-- PERSONALIDADE -->
    <div class="fc-box">
      <div class="fc-box-title">Personalidade</div>
      <div class="fc-field-grid-2">
        <label class="fc-field">
          <span class="fc-mini-label">Traços</span>
          <textarea v-model="ficha.personalidadeTracos" @input="agendarSalvar"></textarea>
        </label>
        <label class="fc-field">
          <span class="fc-mini-label">Ideais</span>
          <textarea v-model="ficha.personalidadeIdeais" @input="agendarSalvar"></textarea>
        </label>
        <label class="fc-field">
          <span class="fc-mini-label">Vínculos</span>
          <textarea v-model="ficha.personalidadeVinculos" @input="agendarSalvar"></textarea>
        </label>
        <label class="fc-field">
          <span class="fc-mini-label">Defeitos</span>
          <textarea v-model="ficha.personalidadeDefeitos" @input="agendarSalvar"></textarea>
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
  ficha,
  mensagemIdade, mensagemAltura, mensagemPeso,
  agendarSalvar, removerItem, adicionarUnidade,
  selecionarImagem, removerImagem,
} = useFichaPersonagem();
</script>

<style scoped>
.fc-detalhes-fisicos-campos {
  display: flex;
  flex-direction: column;
  gap: 10px;
}

.fc-fisico-msg {
  font-family: 'Crimson Text', Georgia, serif;
  font-style: italic;
  font-size: 12px;
  color: var(--accent-title);
  margin-top: 2px;
}

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
  border: 2px dashed var(--border-gold);
  background: linear-gradient(180deg, var(--bg-card) 0%, var(--bg-sub) 100%);
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
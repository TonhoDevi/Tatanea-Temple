<template>
  <div>
    <div class="fc-box">
      <div class="fc-box-title">Habilidades de classe</div>
      <div v-for="(h, i) in ficha.habilidades" :key="i" class="fc-list-row-vertical">
        <input type="text" v-model="h.nome" placeholder="Nome da habilidade" @input="agendarSalvar" />
        <textarea v-model="h.descricao" placeholder="Descrição" @input="agendarSalvar"></textarea>
        <button class="fc-btn-add fc-btn-remove-wide" @click="removerItem(ficha.habilidades, i)">× Remover</button>
      </div>
      <button class="fc-btn-add" @click="adicionarHabilidade">+ Adicionar habilidade de classe</button>
    </div>

    <div class="fc-box">
      <div class="fc-box-title">Habilidades de raça</div>
      <p class="fc-hint">Provisório — ainda só neste navegador, não é salvo com a ficha.</p>
      <div v-for="(h, i) in habilidadesRaca" :key="i" class="fc-list-row-vertical">
        <input type="text" v-model="h.nome" placeholder="Nome da habilidade" />
        <textarea v-model="h.descricao" placeholder="Descrição"></textarea>
        <button class="fc-btn-add fc-btn-remove-wide" @click="habilidadesRaca.splice(i, 1)">× Remover</button>
      </div>
      <button class="fc-btn-add" @click="habilidadesRaca.push({ nome: '', descricao: '' })">+ Adicionar habilidade de raça</button>
    </div>

    <div class="fc-box">
      <div class="fc-box-title">Talentos</div>
      <div v-for="t in ficha.talentos" :key="t.talentoId" class="fc-talento-card">
        <div class="fc-talento-header">
          <span class="fc-talento-nome">{{ t.nome }}</span>
          <button class="fc-btn-remove" @click="removerTalentoDaFicha(t.talentoId)">×</button>
        </div>
        <p v-if="t.atributoRecebido" class="fc-talento-bonus">
          +{{ t.valorAtributoRecebido }} de {{ atributoNome(t.atributoRecebido) }}
        </p>
        <p v-if="t.descricao" class="fc-talento-descricao">{{ t.descricao }}</p>
      </div>
      <p v-if="!ficha.talentos.length" class="fc-hint">Nenhum talento ainda.</p>

      <div class="fc-talento-add">
        <select v-model="talentoSelecionado" class="fc-select">
          <option value="">Escolha um talento...</option>
          <option v-for="t in talentosDisponiveis" :key="t.id" :value="t.id">{{ t.nome }}</option>
        </select>
        <button class="fc-btn-add" @click="adicionarTalentoNaFicha">+ Adicionar</button>
      </div>
      <p v-if="erroTalento" class="fc-hint fc-hint-erro">{{ erroTalento }}</p>
    </div>
  </div>
</template>

<script setup>
import { useFichaPersonagem, ATRIBUTOS } from '../../composables/useFichaPersonagem';

const {
  ficha, habilidadesRaca, talentosDisponiveis, talentoSelecionado, erroTalento,
  agendarSalvar, removerItem, adicionarHabilidade,
  adicionarTalentoNaFicha, removerTalentoDaFicha,
} = useFichaPersonagem();

function atributoNome(chave) {
  return (ATRIBUTOS.find((a) => a.chave === chave)?.nome || chave).toUpperCase();
}
</script>

<style scoped>
.fc-list-row-vertical {
  display: flex;
  flex-direction: column;
  gap: 6px;
  padding-bottom: 10px;
  border-bottom: 1px dashed rgba(46, 125, 79, 0.6);
}

.fc-talento-card {
  display: flex;
  flex-direction: column;
  gap: 8px;
  padding: 10px 0;
  border-bottom: 1px dashed rgba(46, 125, 79, 0.4);
}

.fc-talento-header {
  display: flex;
  align-items: center;
  gap: 10px;
}

.fc-talento-nome {
  flex: 1;
  min-width: 0;
  font-weight: 600;
}

.fc-talento-bonus {
  margin: 0;
  font-family: 'Cinzel', serif;
  font-size: 11px;
  font-weight: 700;
  letter-spacing: 0.08em;
  color: #5aa9e6;
}

.fc-talento-descricao {
  margin: 0;
  padding: 10px 12px;
  background: var(--jungle-darkest);
  border-left: 3px solid var(--jungle-green);
  font-size: 14px;
  line-height: 1.6;
  color: var(--bone);
  white-space: pre-line;
}

.fc-talento-add {
  display: flex;
  gap: 8px;
  margin-top: 10px;
}

.fc-talento-add .fc-select {
  flex: 1;
}

.fc-hint-erro {
  color: var(--tribal-red);
}
</style>
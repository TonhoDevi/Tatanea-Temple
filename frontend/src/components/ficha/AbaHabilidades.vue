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
      <p class="fc-hint">Provisório — ainda só neste navegador, não é salvo com a ficha.</p>
      <div v-for="(t, i) in talentos" :key="i" class="fc-list-row-vertical">
        <input type="text" v-model="t.nome" placeholder="Nome do talento" />
        <textarea v-model="t.descricao" placeholder="Descrição"></textarea>
        <button class="fc-btn-add fc-btn-remove-wide" @click="talentos.splice(i, 1)">× Remover</button>
      </div>
      <button class="fc-btn-add" @click="talentos.push({ nome: '', descricao: '' })">+ Adicionar talento</button>
    </div>
  </div>
</template>

<script setup>
import { useFichaPersonagem } from '../../composables/useFichaPersonagem';

const {
  ficha, habilidadesRaca, talentos,
  agendarSalvar, removerItem, adicionarHabilidade,
} = useFichaPersonagem();
</script>

<style scoped>
.fc-list-row-vertical {
  display: flex;
  flex-direction: column;
  gap: 6px;
  padding-bottom: 10px;
  border-bottom: 1px dashed rgba(46, 125, 79, 0.6);
}
</style>
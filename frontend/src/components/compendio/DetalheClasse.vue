<template>
  <component :is="paginaDedicada" v-if="paginaDedicada"></component>

  <div v-else-if="carregando || erro" class="dc-page">
    <p v-if="carregando" class="dc-status">Carregando classe…</p>
    <p v-else class="dc-status dc-status-erro">{{ erro }}</p>
  </div>

  <ClassePaginaLayout v-else-if="classe" :classe="classe">
      <div class="dc-section" v-if="classe.descricaoIntro">
        <div class="dc-section-title-row">
          <h2 class="dc-section-title">Descrição</h2>
          <span class="dc-title-line"></span>
        </div>
        <div class="dc-descricao-colunas">
          <p v-for="(par, i) in descricaoParagrafos" :key="i" class="dc-texto-corpo">{{ par }}</p>
        </div>
      </div>

      <div class="dc-section" v-if="classe.niveis && classe.niveis.length">
        <div class="dc-section-title-row">
          <h2 class="dc-section-title">Progressão — O {{ classe.nome }}</h2>
          <span class="dc-title-line"></span>
        </div>
        <div class="dc-tabela-wrap">
          <table class="dc-tabela-niveis">
            <thead>
              <tr>
                <th>Nível</th>
                <th>Bônus de Proficiência</th>
                <th>Características</th>
              </tr>
            </thead>
            <tbody>
              <tr v-for="n in classe.niveis" :key="n.nivel">
                <td class="dc-tabela-nivel">{{ n.nivel }}º</td>
                <td class="dc-tabela-bonus">{{ n.bonusProficiencia }}</td>
                <td class="dc-tabela-carac">{{ n.caracteristicas }}</td>
              </tr>
            </tbody>
          </table>
        </div>
      </div>

      <div class="dc-section" v-if="fundamentos.length">
        <div class="dc-section-title-row">
          <h2 class="dc-section-title">Fundamentos da Classe</h2>
          <span class="dc-title-line"></span>
        </div>
        <p class="dc-fundamentos-nota">Regras comuns a toda classe — não são exclusivas d{{ classe.nome ? 'o ' + classe.nome : 'a classe' }}.</p>
        <div class="dc-fundamentos-grid">
          <div class="dc-fundamento" v-for="f in fundamentos" :key="f.titulo" :class="{ 'dc-fundamento-largo': f.titulo === 'Equipamento' }">
            <span class="dc-fundamento-titulo">{{ f.titulo }}</span>
            <p class="dc-fundamento-corpo">{{ f.corpo }}</p>
          </div>
        </div>
      </div>

      <div class="dc-section" v-if="conjuracao.length">
        <div class="dc-section-title-row">
          <h2 class="dc-section-title">Conjuração</h2>
          <span class="dc-title-line"></span>
        </div>
        <div class="dc-fundamentos-grid">
          <div class="dc-fundamento" v-for="c in conjuracao" :key="c.titulo">
            <span class="dc-fundamento-titulo">{{ c.titulo }}</span>
            <p class="dc-fundamento-corpo">{{ c.corpo }}</p>
          </div>
        </div>
      </div>

      <div class="dc-section" v-if="habilidades.length">
        <div class="dc-section-title-row">
          <h2 class="dc-section-title">Características da Classe</h2>
          <span class="dc-title-line"></span>
        </div>
        <div class="dc-hab-lista">
          <div class="dc-hab-item" v-for="(c, i) in habilidades" :key="i">
            <button class="dc-hab-cabecalho" @click="alternarCaracteristica(i)">
              <span class="dc-hab-seta">{{ caracteristicasAbertas[i] === false ? '▸' : '▾' }}</span>
              <span v-if="c.nivel" class="dc-hab-nivel">Nv. {{ c.nivel }}</span>
              <span class="dc-hab-nome">{{ c.titulo }}</span>
            </button>
            <p v-if="caracteristicasAbertas[i] !== false" class="dc-hab-descricao">{{ c.corpo }}</p>
          </div>
        </div>
      </div>

      <div class="dc-section" v-if="classe.subclasses && classe.subclasses.length">
        <div class="dc-section-title-row">
          <h2 class="dc-section-title">Subclasses</h2>
          <span class="dc-title-line"></span>
        </div>

        <div class="dc-subclasse" v-for="(s, si) in classe.subclasses" :key="s.nome">
          <div class="dc-subclasse-cabecalho">
            <span class="dc-subclasse-icone">{{ s.icone || '◆' }}</span>
            <h3 class="dc-subclasse-nome">{{ s.nome }}</h3>
          </div>

          <p v-if="s.introTexto" class="dc-texto-corpo">{{ s.introTexto }}</p>

          <div v-if="s.magiasTexto" class="dc-magias-box">
            <span class="dc-magias-titulo">Magias por nível</span>
            <p class="dc-magias-texto">{{ s.magiasTexto }}</p>
          </div>

          <div class="dc-hab-lista" v-if="s.caracteristicas && s.caracteristicas.length">
            <div class="dc-hab-item" v-for="(c, ci) in s.caracteristicas" :key="ci">
              <button class="dc-hab-cabecalho" @click="alternarSubclasse(chaveSub(si, ci))">
                <span class="dc-hab-seta">{{ subclasseAbertas[chaveSub(si, ci)] === false ? '▸' : '▾' }}</span>
                <span v-if="c.nivel" class="dc-hab-nivel">Nv. {{ c.nivel }}</span>
                <span class="dc-hab-nome">{{ c.titulo }}</span>
              </button>
              <p v-if="subclasseAbertas[chaveSub(si, ci)] !== false" class="dc-hab-descricao">{{ c.corpo }}</p>
            </div>
          </div>
        </div>
      </div>

      <div class="dc-section" v-if="classe.tabelasTextoBruto">
        <div class="dc-section-title-row">
          <h2 class="dc-section-title">Tabelas originais</h2>
          <span class="dc-title-line"></span>
        </div>
        <p class="dc-hint">
          Texto bruto das tabelas da fonte original, preservado na íntegra como referência
          (algumas colunas numéricas não puderam ser reconstruídas com segurança na extração).
        </p>
        <pre class="dc-tabela-bruta">{{ classe.tabelasTextoBruto }}</pre>
      </div>
  </ClassePaginaLayout>
</template>

<script setup>
import { ref, computed, onMounted, markRaw } from 'vue';
import { useRoute } from 'vue-router';
import classeService from '../../services/classeService';
import ClassePaginaLayout from './classes/ClassePaginaLayout.vue';
import CacadorPagina from './classes/CacadorPagina.vue';
import LadinoPagina from './classes/LadinoPagina.vue';
import PaladinoPagina from './classes/PaladinoPagina.vue';
import BarbaroPagina from './classes/BarbaroPagina.vue';
import BardoPagina from './classes/BardoPagina.vue';
import ClerigoPagina from './classes/ClerigoPagina.vue';
import GuerreiroPagina from './classes/GuerreiroPagina.vue';
import MongePagina from './classes/MongePagina.vue';
import MagoPagina from './classes/MagoPagina.vue';
import FeiticeiroPagina from './classes/FeiticeiroPagina.vue';
import DruidaPagina from './classes/DruidaPagina.vue';
import BruxoPagina from './classes/BruxoPagina.vue';

// Páginas de classe escritas à mão — cada uma cuida do próprio conteúdo
// (texto, tabelas) sem depender do formato genérico abaixo. O compêndio e a
// ficha não têm relação entre si: a ficha usa a API (habilidades com nível)
// pra puxar o que o personagem ganha, e essa página é só leitura.
const PAGINAS_DEDICADAS = {
  'caçador': markRaw(CacadorPagina),
  'ladino': markRaw(LadinoPagina),
  'paladino': markRaw(PaladinoPagina),
  'bárbaro': markRaw(BarbaroPagina),
  'bardo': markRaw(BardoPagina),
  'clérigo': markRaw(ClerigoPagina),
  'guerreiro': markRaw(GuerreiroPagina),
  'monge': markRaw(MongePagina),
  'mago': markRaw(MagoPagina),
  'feiticeiro': markRaw(FeiticeiroPagina),
  'druida': markRaw(DruidaPagina),
  'bruxo': markRaw(BruxoPagina),
};

const route = useRoute();

const paginaDedicada = computed(() => PAGINAS_DEDICADAS[route.params.id] || null);

const classe = ref(null);
const carregando = ref(true);
const erro = ref(null);
const caracteristicasAbertas = ref({});
const subclasseAbertas = ref({});

function alternarCaracteristica(chave) {
  const abertoAtual = caracteristicasAbertas.value[chave] !== false;
  caracteristicasAbertas.value = { ...caracteristicasAbertas.value, [chave]: !abertoAtual };
}

function alternarSubclasse(chave) {
  const abertoAtual = subclasseAbertas.value[chave] !== false;
  subclasseAbertas.value = { ...subclasseAbertas.value, [chave]: !abertoAtual };
}

function chaveSub(si, ci) {
  return `${si}-${ci}`;
}

const descricaoParagrafos = computed(() => {
  if (!classe.value?.descricaoIntro) return [];
  return classe.value.descricaoIntro.split(/\n\s*\n/).filter((p) => p.trim());
});

const fundamentos = computed(() => (classe.value?.caracteristicas || []).filter((c) => c.tipo === 'FUNDAMENTO'));
const conjuracao = computed(() => (classe.value?.caracteristicas || []).filter((c) => c.tipo === 'CONJURACAO'));
const habilidades = computed(() => (classe.value?.caracteristicas || []).filter((c) => c.tipo === 'HABILIDADE'));

onMounted(async () => {
  if (paginaDedicada.value) return;
  try {
    classe.value = await classeService.buscarPorId(route.params.id);
  } catch (e) {
    erro.value = 'Não foi possível carregar essa classe.';
  } finally {
    carregando.value = false;
  }
});
</script>

<template>
  <div class="dc-page">
    <section class="dc-top">
      <div class="dc-top-inner">
        <button class="dc-voltar" @click="voltar">← Voltar ao compêndio</button>
      </div>
    </section>

    <section class="dc-hero">
      <div class="dc-hero-inner">
        <div class="dc-retrato" :style="{ borderColor: classe.cor || 'var(--jungle-green)' }">
          <span class="dc-retrato-icone">{{ classe.icone || '◆' }}</span>
        </div>

        <div class="dc-hero-info">
          <span class="dc-eyebrow">Ficha técnica</span>
          <h1 class="dc-nome">{{ classe.nome }}</h1>
          <div class="dc-hr-row">
            <span class="dc-hr-line dc-hr-line-fixed"></span>
            <span class="dc-hr-diamond"></span>
            <span class="dc-hr-line"></span>
          </div>
          <blockquote v-if="classe.subtitulo" class="dc-quote">"{{ classe.subtitulo }}"</blockquote>

          <div class="dc-badges-row">
            <div class="dc-categoria-bloco">
              <span class="dc-categoria-corner dc-categoria-corner-tl"></span>
              <span class="dc-categoria-corner dc-categoria-corner-tr"></span>
              <span class="dc-categoria-corner dc-categoria-corner-bl"></span>
              <span class="dc-categoria-corner dc-categoria-corner-br"></span>
              <span class="dc-categoria-bracket dc-categoria-bracket-tl"></span>
              <span class="dc-categoria-bracket dc-categoria-bracket-tr"></span>
              <span class="dc-categoria-bracket dc-categoria-bracket-bl"></span>
              <span class="dc-categoria-bracket dc-categoria-bracket-br"></span>
              <span class="dc-categoria-valor">{{ classe.dadoDeVida }}</span>
            </div>
            <div class="dc-categoria-bloco dc-categoria-bloco-menor">
              <span class="dc-categoria-corner dc-categoria-corner-tl"></span>
              <span class="dc-categoria-corner dc-categoria-corner-tr"></span>
              <span class="dc-categoria-corner dc-categoria-corner-bl"></span>
              <span class="dc-categoria-corner dc-categoria-corner-br"></span>
              <span class="dc-categoria-bracket dc-categoria-bracket-tl"></span>
              <span class="dc-categoria-bracket dc-categoria-bracket-tr"></span>
              <span class="dc-categoria-bracket dc-categoria-bracket-bl"></span>
              <span class="dc-categoria-bracket dc-categoria-bracket-br"></span>
              <span class="dc-categoria-valor">{{ classe.dificuldade }}</span>
            </div>
          </div>

          <div v-if="classe.papeis && classe.papeis.length" class="dc-papeis-row">
            <span v-for="p in classe.papeis" :key="p" class="dc-papel-tag">{{ p }}</span>
          </div>
        </div>
      </div>
    </section>

    <section class="dc-body">
      <div class="dc-body-inner">
        <slot></slot>

        <div class="dc-rodape">
          <button class="dc-voltar-final" @click="voltar">← Voltar ao compêndio</button>
        </div>
      </div>
    </section>
  </div>
</template>

<script setup>
import { useRouter } from 'vue-router';

defineProps({
  classe: {
    type: Object,
    required: true,
  },
});

const router = useRouter();

function voltar() {
  router.push('/classes');
}
</script>

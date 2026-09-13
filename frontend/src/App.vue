<script setup>
import { RouterView, useRoute } from 'vue-router';
import Navbar from './components/Navbar.vue';

const route = useRoute();
</script>

<template>
  <Navbar v-if="!route.meta.hideNavbar" />

  <main>
    <RouterView v-slot="{ Component, route: r }">
      <keep-alive :include="['MeusPersonagens', 'FichaPersonagem']" :max="6">
        <component :is="Component" :key="r.fullPath" />
      </keep-alive>
    </RouterView>
  </main>
</template>
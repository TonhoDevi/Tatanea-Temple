import { defineStore } from 'pinia'
import { racaService } from '../services/racaService'

export const useCompendioStore = defineStore('compendio', {
  state: () => ({
    racas: [],
    racaSelecionada: null,
    carregando: false,
    erro: null
  }),
  actions: {
    async carregarRacas() {
      this.carregando = true
      this.erro = null
      try {
        this.racas = await racaService.listar()
      } catch (e) {
        this.erro = 'Não foi possível carregar as raças.'
      } finally {
        this.carregando = false
      }
    },
    async selecionarRaca(id) {
      this.racaSelecionada = await racaService.buscarPorId(id)
    }
  }
})

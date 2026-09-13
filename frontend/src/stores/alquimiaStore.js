import { defineStore } from 'pinia'
import alquimiaService from '../services/alquimiaService'

export const useAlquimiaStore = defineStore('alquimia', {
  state: () => ({
    essencias: [],
    pocoes: [],
    carregado: false,
    carregando: false,
    erro: null,
    detalhesPocao: {},
  }),
  actions: {
    async carregarLista() {
      if (this.carregado || this.carregando) return
      this.carregando = true
      this.erro = null
      try {
        [this.essencias, this.pocoes] = await Promise.all([
          alquimiaService.listarEssencias(),
          alquimiaService.listarPocoes(),
        ])
        this.carregado = true
      } catch (e) {
        this.erro = 'Não foi possível carregar a alquimia.'
      } finally {
        this.carregando = false
      }
    },
    async buscarDetalhePocao(id) {
      if (this.detalhesPocao[id]) return this.detalhesPocao[id]
      const dto = await alquimiaService.buscarPocaoPorId(id)
      this.detalhesPocao = { ...this.detalhesPocao, [id]: dto }
      return dto
    },
    recarregar() {
      this.carregado = false
      this.detalhesPocao = {}
      return this.carregarLista()
    },
  },
})

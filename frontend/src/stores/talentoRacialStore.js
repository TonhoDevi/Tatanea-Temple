import { defineStore } from 'pinia'
import talentoRacialService from '../services/talentoRacialService'

export const useTalentoRacialStore = defineStore('talentoRacial', {
  state: () => ({
    lista: [],
    carregado: false,
    carregando: false,
    erro: null,
    detalhes: {},
  }),
  actions: {
    async carregarLista() {
      if (this.carregado || this.carregando) return
      this.carregando = true
      this.erro = null
      try {
        this.lista = await talentoRacialService.listar()
        this.carregado = true
      } catch (e) {
        this.erro = 'Não foi possível carregar o compêndio de talentos raciais.'
      } finally {
        this.carregando = false
      }
    },
    async buscarDetalhe(id) {
      if (this.detalhes[id]) return this.detalhes[id]
      const dto = await talentoRacialService.buscarPorId(id)
      this.detalhes = { ...this.detalhes, [id]: dto }
      return dto
    },
    recarregar() {
      this.carregado = false
      this.detalhes = {}
      return this.carregarLista()
    },
  },
})

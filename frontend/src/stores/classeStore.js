import { defineStore } from 'pinia'
import classeService from '../services/classeService'

export const useClasseStore = defineStore('classe', {
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
        this.lista = await classeService.listar()
        this.carregado = true
      } catch (e) {
        this.erro = 'Não foi possível carregar o compêndio de classes.'
      } finally {
        this.carregando = false
      }
    },
    async buscarDetalhe(id) {
      if (this.detalhes[id]) return this.detalhes[id]
      const dto = await classeService.buscarPorId(id)
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

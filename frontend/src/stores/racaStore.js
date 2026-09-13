import { defineStore } from 'pinia'
import { racaService } from '../services/racaService'

// Cache manual (sem invalidação automática) da lista e dos detalhes de raça.
// Uma vez carregado, `carregarLista()` não bate na API de novo — quem
// precisar forçar uma atualização (ex.: depois de editar uma raça no futuro
// painel administrativo) chama `recarregar()`.
export const useRacaStore = defineStore('raca', {
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
        this.lista = await racaService.listar()
        this.carregado = true
      } catch (e) {
        this.erro = 'Não foi possível carregar o compêndio de raças.'
      } finally {
        this.carregando = false
      }
    },
    async buscarDetalhe(id) {
      if (this.detalhes[id]) return this.detalhes[id]
      const dto = await racaService.buscarPorId(id)
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

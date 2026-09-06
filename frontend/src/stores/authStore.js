import { defineStore } from 'pinia';
import http from '../services/http';

export const useAuthStore = defineStore('auth', {
  state: () => ({
    token: localStorage.getItem('tatanea_token') || null,
    usuario: JSON.parse(localStorage.getItem('tatanea_usuario') || 'null'),
  }),

  getters: {
    estaLogado: (state) => !!state.token,
  },

  actions: {
    _persistir(resposta) {
      this.token = resposta.token;
      this.usuario = {
        id: resposta.usuarioId,
        email: resposta.email,
        nome: resposta.nome,
      };
      localStorage.setItem('tatanea_token', this.token);
      localStorage.setItem('tatanea_usuario', JSON.stringify(this.usuario));
    },

    async registrar(email, senha, nome) {
      const { data } = await http.post('/auth/registrar', { email, senha, nome });
      this._persistir(data);
    },

    async login(email, senha) {
      const { data } = await http.post('/auth/login', { email, senha });
      this._persistir(data);
    },

    logout() {
      this.token = null;
      this.usuario = null;
      localStorage.removeItem('tatanea_token');
      localStorage.removeItem('tatanea_usuario');
    },
  },
});
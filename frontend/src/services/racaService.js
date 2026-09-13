import http from './http'

export const racaService = {
  listar() {
    return http.get('/racas').then(r => r.data)
  },
  buscarPorId(id) {
    return http.get(`/racas/${id}`).then(r => r.data)
  }
}

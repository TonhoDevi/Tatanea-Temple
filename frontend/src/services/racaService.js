import axios from 'axios'

const api = axios.create({ baseURL: '/api' })

export const racaService = {
  listar() {
    return api.get('/racas').then(r => r.data)
  },
  buscarPorId(id) {
    return api.get(`/racas/${id}`).then(r => r.data)
  }
}

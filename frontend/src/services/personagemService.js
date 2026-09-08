import http from './http';

export default {
    listar() {
        return http.get('/personagens').then((res) => res.data);
    },
    buscar(id) {
        return http.get(`/personagens/${id}`).then((res) => res.data);
    },
    criar(dto) {
        return http.post('/personagens', dto).then((res) => res.data);
    },
    atualizar(id, dto) {
        return http.put(`/personagens/${id}`, dto).then((res) => res.data);
    },
    remover(id) {
        return http.delete(`/personagens/${id}`);
    },
};
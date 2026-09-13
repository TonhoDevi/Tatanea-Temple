import http from './http';

export default {
    listar() {
        return http.get('/talentos').then((res) => res.data);
    },
    buscarPorId(id) {
        return http.get(`/talentos/${id}`).then((res) => res.data);
    },
};

import http from './http';

export default {
    listar() {
        return http.get('/talentos-raciais').then((res) => res.data);
    },
    buscarPorId(id) {
        return http.get(`/talentos-raciais/${id}`).then((res) => res.data);
    },
};

import http from './http';

export default {
    listar() {
        return http.get('/classes').then(res => res.data);
    },
    buscarPorId(id) {
        return http.get(`/classes/${id}`).then(res => res.data);
    },
};
import http from './http';

export default {
    listarEssencias() {
        return http.get('/alquimia/essencias').then((res) => res.data);
    },
    listarPocoes() {
        return http.get('/alquimia/pocoes').then((res) => res.data);
    },
    buscarPocaoPorId(id) {
        return http.get(`/alquimia/pocoes/${id}`).then((res) => res.data);
    },
};
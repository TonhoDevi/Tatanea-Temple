import axios from 'axios';

const api = axios.create({ baseURL: '/api/alquimia' });

export default {
    listarEssencias() {
        return api.get('/essencias').then((res) => res.data);
    },
    listarPocoes() {
        return api.get('/pocoes').then((res) => res.data);
    },
    buscarPocaoPorId(id) {
        return api.get(`/pocoes/${id}`).then((res) => res.data);
    },
};
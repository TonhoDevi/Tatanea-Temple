import axios from 'axios';

const api = axios.create({ baseURL: '/api/talentos-raciais' });

export default {
    listar() {
        return api.get('').then((res) => res.data);
    },
    buscarPorId(id) {
        return api.get(`/${id}`).then((res) => res.data);
    },
};

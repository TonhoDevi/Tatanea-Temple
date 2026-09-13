import axios from 'axios';

// Em dev, '/api' é resolvido pelo proxy do Vite (vite.config.js) até
// localhost:8080. Em produção não existe esse proxy, então o build da
// Vercel precisa da variável VITE_API_BASE_URL com a URL pública do backend
// (ex.: https://api.seudominio.com/api).
const baseURL = import.meta.env.VITE_API_BASE_URL || '/api';

const http = axios.create({ baseURL });

http.interceptors.request.use((config) => {
    const token = localStorage.getItem('tatanea_token');
    if (token) {
        config.headers.Authorization = `Bearer ${token}`;
    }
    return config;
});

http.interceptors.response.use(
    (response) => response,
    (error) => {
        if (error.response && error.response.status === 401) {
            localStorage.removeItem('tatanea_token');
            localStorage.removeItem('tatanea_usuario');
            if (window.location.pathname !== '/login') {
                window.location.href = '/login';
            }
        }
        return Promise.reject(error);
    }
);

export default http;
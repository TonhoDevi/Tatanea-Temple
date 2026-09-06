import { createApp } from 'vue'
import { createPinia } from 'pinia'
import router from './router/router-index.js'
import App from './App.vue'
import './assets/styles/tataneaInfo.css'
import './assets/styles/1-variables.css'
import './assets/styles/2-base.css'
import './assets/styles/ddt-characters.css'
import './assets/styles/race-selector.css'

const app = createApp(App)
app.use(createPinia())
app.use(router)
app.mount('#app')
# 🐉 Tatanea Temple (Templo de Tatânea)

![Tatanea Temple Banner](tatanea_temple_banner_1774924801338.png)

Uma plataforma definitiva para aventureiros! **Tatanea Temple** é um sistema web interativo e de alto desempenho para criação, gerenciamento e salvamento em nuvem de fichas de personagens para Dungeons & Dragons 5ª Edição e Mutantes & Malfeitores 3ª Edição, com foco total em conteúdo **Homebrew**.

![Badge](https://img.shields.io/badge/D%26D-5e-red?style=for-the-badge&logo=dungeons-and-dragons&logoColor=white)
![Badge](https://img.shields.io/badge/M%26M-3e-blue?style=for-the-badge)
![Badge](https://img.shields.io/badge/Supabase-Auth-green?style=for-the-badge&logo=supabase)
![Badge](https://img.shields.io/badge/JavaScript-ES6+-yellow?style=for-the-badge&logo=javascript)
![Badge](https://img.shields.io/badge/Status-Beta-orange?style=for-the-badge)

---

## ✨ Características Principais

### ⚔️ Fichas Interativas (D&D 5e & M&M 3e)
- **Cálculo Automático**: Modificadores, testes de resistência, perícias e CD de magia calculados em tempo real.
- **Sistema Multiclasse**: Suporte para acompanhamento de níveis e classes.
- **Gerenciamento de Combate**: Controle de PV (Atual, Máximo, Temp), CA, Iniciativa e Deslocamentos.
- **Magias e Habilidades**: Organizador de slots de magia (1-9) e lista de truques.

### 📚 Compêndio Homebrew de Tatânea
- **Raças e Classes**: Explore raças únicas e classes customizadas do cenário de Tatânea.
- **Talentos e Equipamentos**: Banco de dados completo de talentos raciais e itens mágicos.

### ☁️ Sincronização em Nuvem (Supabase)
- **Autenticação Segura**: Login social e e-mail via Supabase Auth.
- **Cloud Save**: Suas fichas são salvas automaticamente na nuvem, permitindo acesso de qualquer dispositivo.
- **Múltiplos Personagens**: Crie e gerencie infinitas fichas em um único painel.

### 🎨 Design Premium & UX
- **Interface Imersiva**: Tema medieval escuro com acentos dourados e carmesim.
- **Responsividade Total**: Experiência perfeita em Desktop, Tablet e Mobile.
- **Modo de Impressão**: Layout otimizado para transformar suas fichas digitais em PDF ou papel A4.

---

## 📸 Screenshots

````carousel
![Início do Templo](/assets/screenshots/foto1.png)
<!-- slide -->
![Ficha de Personagem](/assets/screenshots/foto2.png)
<!-- slide -->
![Lista de Personagens](/assets/screenshots/foto3.png)
````

---

## 🚀 Como Iniciar

### 🌐 Demo Online
O projeto está disponível em: [tatanea-temple.vercel.app](https://github.com/TonhoDevi/Tatanea-Temple) (Em breve)

### 💻 Executando Localmente
1. **Clone o repositório**:
   ```bash
   git clone https://github.com/TonhoDevi/Tatanea-Temple.git
   ```
2. **Abra o `index.html`**:
   Basta abrir o arquivo principal em qualquer navegador moderno ou usar uma extensão como **Live Server** no VS Code.

---

## 🛠️ Tecnologias Utilizadas

- **Frontend**: HTML5 Semântico, CSS3 (Grid & Flexbox), Vanilla JavaScript.
- **Backend-as-a-Service**: [Supabase](https://supabase.com/) (Database & Auth).
- **Fontes**: Pirata One, Cinzel, Crimson Text via Google Fonts.
- **Ícones**: Custom SVG e Emojis temáticos.

---

## 📁 Estrutura do Projeto

```text
Tatanea-Temple/
├── assets/             # Imagens, texturas e capturas de tela
├── css/                # Sistema de design modular (1-Variables, 2-Base...)
├── html/               # Páginas do sistema
│   ├── auth/           # Login e cadastro
│   ├── compendium/     # Enciclopédia de Tatânea
│   └── sheet/          # Fichas (D&D, M&M, Minhas Fichas)
├── js/                 # Lógica do sistema
│   ├── character/      # Motores de cálculo de fichas
│   ├── compendium/     # Dados e renderização de compêndios
│   └── shared/         # Supabase Auth, Cloud Save e Navbar
├── index.html          # Portal de entrada
└── LICENSE             # Licença MIT
```

---

## 🤝 Contribuindo

Sugestões e melhorias são sempre bem-vindas! Siga os passos:
1. Faça um **Fork** do projeto.
2. Crie uma **Branch** (`git checkout -b feature/NovaHabilidade`).
3. Dê **Commit** (`git commit -m 'Adiciona nova habilidade rúnica'`).
4. Dê **Push** no GitHub.
5. Abra um **Pull Request**.

---

## 👤 Autor

**TonhoDevi**
- GitHub: [@TonhoDevi](https://github.com/TonhoDevi)
- LinkedIn: [Antonio Henrique](www.linkedin.com/in/antonio-henrique-batista-do-nascimento-4025ab37a)

---

## 📜 Licença

Este projeto é open-source sob a licença **MIT**. Sinta-se livre para usar em sua mesa de RPG!

---

**🎲 Que seus dados sejam sempre críticos no Reino de Tatânea!**
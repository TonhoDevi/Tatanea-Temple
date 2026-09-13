# 🐉 Tatanea Temple (Templo de Tatânea)

**Tatanea Temple** é um compêndio homebrew e sistema de fichas para Dungeons & Dragons 5ª Edição, ambientado no cenário próprio de Tatânea. O projeto é dividido em uma API REST (Spring Boot) e uma aplicação web (Vue 3) que consome essa API.

![Badge](https://img.shields.io/badge/D%26D-5e-red?style=for-the-badge&logo=dungeons-and-dragons&logoColor=white)
![Badge](https://img.shields.io/badge/Java-21-orange?style=for-the-badge&logo=openjdk)
![Badge](https://img.shields.io/badge/Spring_Boot-4-6DB33F?style=for-the-badge&logo=springboot&logoColor=white)
![Badge](https://img.shields.io/badge/Vue-3-42b883?style=for-the-badge&logo=vue.js&logoColor=white)
![Badge](https://img.shields.io/badge/Status-Em%20desenvolvimento-orange?style=for-the-badge)

---

## ✨ Características Principais

### 📚 Compêndio Homebrew de Tatânea
- **Raças**: raças e sub-raças jogáveis, com atributos, deslocamento, tamanho, altura, peso, idade e habilidades especiais.
- **Classes**: classes e subclasses com progressão de nível, proficiências e características detalhadas, cada uma com página própria.
- **Talentos**: talentos comuns e talentos raciais, com pré-requisitos e bônus de atributo estruturados.
- **Alquimia**: itens, poções e venenos com efeito, custo e raridade.

### ⚔️ Ficha de Personagem
- Fichas completas por conta de usuário, com abas de Características, Habilidades, Ações, Magias, Mochila e Lore.
- **Rolador de ataques**: escolha normal/vantagem/desvantagem, com animação de rolagem em duas fases (acerto, depois dano) e destaque automático de acerto/erro crítico.
- **Lançador de dados** geral (d4 a d100) acessível pela navbar em qualquer página, com a mesma lógica de animação.

### 🔐 Contas de usuário
- Cadastro e login com autenticação stateless via JWT (senha com hash BCrypt).
- Cada personagem pertence a uma conta; rotas de personagem exigem login.

### 🎨 Identidade Visual
- Tema de templo na selva: dourado, terracota e verde-jade sobre fundo escuro.
- Tipografia Cinzel/Cinzel Decorative para títulos, Crimson Text para o corpo do texto.

---

## 🛠️ Tecnologias Utilizadas

**Backend** (`/backend`)
- Java 21 + Spring Boot 4 (Web, Data JPA, Security, Validation)
- PostgreSQL em produção / H2 em memória em desenvolvimento
- Flyway para versionamento de schema
- JWT (jjwt) para autenticação stateless
- springdoc-openapi (Swagger UI em `/swagger-ui.html`)

**Frontend** (`/frontend`)
- Vue 3 (`<script setup>`) + Vite
- Vue Router
- Pinia (estado de autenticação e do compêndio)
- Axios para consumo da API

---

## 📁 Estrutura do Projeto

```text
Tatanea-Temple/
├── backend/                          # API REST em Spring Boot
│   ├── src/main/java/com/tatanea/templeinfo/
│   │   ├── auth/                     # Cadastro, login, JWT, segurança
│   │   ├── raca/                     # Compêndio de Raças
│   │   ├── classe/                   # Compêndio de Classes
│   │   ├── talento/                  # Compêndio de Talentos comuns
│   │   ├── talentoracial/            # Compêndio de Talentos Raciais
│   │   ├── alquimia/                 # Compêndio de Alquimia
│   │   ├── personagem/               # Fichas de personagem
│   │   └── comum/                    # Tipos compartilhados (atributos, etc.)
│   └── src/main/resources/
│       ├── db/migration/             # Migrações Flyway (schema + seed)
│       ├── application.properties        # Perfil de desenvolvimento (H2)
│       └── application-prod.properties   # Perfil de produção (PostgreSQL)
├── frontend/                         # Aplicação Vue 3 + Vite
│   └── src/
│       ├── components/compendio/     # Listagens e detalhes dos compêndios
│       ├── components/ficha/         # Abas e componentes da ficha de personagem
│       ├── views/                    # Páginas (Home, Login, Registro, Personagens...)
│       ├── services/                 # Chamadas à API (Axios)
│       ├── stores/                   # Estado global (Pinia)
│       └── router/                   # Rotas da aplicação
├── scratch/                          # Scripts avulsos de apoio
├── LICENSE
└── README.md
```

---

## 🚀 Como Executar Localmente

### Pré-requisitos
- Java 21+ e Maven
- Node.js 18+ e npm

### Backend
```bash
cd backend
mvn spring-boot:run
```
Sobe em `http://localhost:8080`, com banco H2 em memória (schema e dados de exemplo recriados a cada start via Flyway) e Swagger UI em `/swagger-ui.html`.

### Frontend
```bash
cd frontend
npm install
npm run dev
```
Sobe em `http://localhost:5173` e já aponta para a API local em `http://localhost:8080`.

---

## ☁️ Implantação (em andamento)

Arquitetura de produção, com custo zero:
- **Frontend** hospedado na [Vercel](https://vercel.com/).
- **Backend** rodando em Docker numa VM "Always Free" da [Oracle Cloud](https://cloud.oracle.com/), atrás de um Caddy com HTTPS automático.
- **Banco de dados** PostgreSQL hospedado no [Supabase](https://supabase.com/).

Passo a passo completo em [`DEPLOY.md`](./DEPLOY.md). Nenhum ambiente de produção está no ar ainda — o projeto roda hoje apenas localmente.

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

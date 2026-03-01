# 🎲 Ficha de Personagem D&D 5e

Uma aplicação web interativa e responsiva para criação, gerenciamento e impressão de fichas de personagens de Dungeons & Dragons 5ª Edição.

![Badge](https://img.shields.io/badge/D%26D-5e-red)
![Badge](https://img.shields.io/badge/HTML-5-orange)
![Badge](https://img.shields.io/badge/CSS-3-blue)
![Badge](https://img.shields.io/badge/JavaScript-ES6-yellow)
![Badge](https://img.shields.io/badge/Mobile-Responsive-green)

---

## ✨ Características

### 🎯 Funcionalidades Principais
- ✅ **Criação completa de personagens** com todos os atributos do D&D 5e
- ✅ **Cálculo automático** de modificadores, testes de resistência e perícias
- ✅ **Sistema de proficiência e especialização** em perícias
- ✅ **Gerenciamento de magias** com CD e bônus de ataque
- ✅ **Gestão de ataques** personalizados
- ✅ **Salvamento automático** no navegador (LocalStorage)
- ✅ **Múltiplos personagens** - crie e alterne entre várias fichas
- ✅ **Modo de impressão** otimizado para papel A4
- ✅ **100% responsivo** - funciona perfeitamente em desktop, tablet e celular

### 🎨 Design Temático
- Interface com **tema medieval** em tons de preto, vermelho e dourado
- Formas geométricas customizadas (hexágonos, triângulos)
- Texturas e efeitos visuais imersivos
- Animações suaves e transições elegantes

### 📊 Sistema de Atributos
- 6 atributos principais (Força, Destreza, Constituição, Inteligência, Sabedoria, Carisma)
- Cálculo automático de modificadores
- Proficiência em testes de resistência com indicador visual
- Mudança de cor quando proficiente

### 🎯 Perícias Customizadas
22 perícias incluindo perícias homebrew:
- **Padrão D&D 5e**: Acrobacia, Arcanismo, Atletismo, etc.
- **Homebrew**: Briga, Brutalidade, Resiliência, Vigor

Sistema de 3 níveis:
- **Nenhum** (sem bônus)
- **Proficiente** (adiciona bônus de proficiência)
- **Especialista** (adiciona dobro do bônus)

### ⚔️ Combate e Recursos
- Classe de Armadura (CA)
- Iniciativa
- Pontos de Vida (máximo, atual, temporário)
- Dados de Vida
- Deslocamento (andar, nadar, voar, escalar)
- Percepção Passiva e Intuição Passiva

### 🔮 Sistema de Magia
- Seleção de atributo de conjuração
- Cálculo automático de CD de magia
- Bônus de ataque mágico
- Bônus adicional de magia
- Espaços de magia do nível 1 ao 9

---

## 🚀 Como Usar

### 💻 Desktop
1. Clone ou baixe este repositório
2. Abra o arquivo `index.html` em qualquer navegador moderno
3. Comece a criar seu personagem!

### 📱 Mobile
**Opção 1: Hospedagem Local**
1. Instale a extensão **Live Server** no VS Code
2. Clique com botão direito em `index.html`
3. Selecione "Open with Live Server"
4. No celular, acesse `http://SEU_IP:5500`

**Opção 2: Hospedagem Online**
- Faça deploy no [Netlify](https://netlify.com), [Vercel](https://vercel.com) ou [GitHub Pages](https://pages.github.com)

---

## 📁 Estrutura do Projeto
```
ficha-dnd/
│
├── css/
│   └── styles.css      # Estilos e tema visual
├── js/
│   └── script.js       # Lógica e funcionalidades
├── screenshots/
│   └── foto1.png
│   └── foto2.png       
│   └── foto3.png       # foto e imagens
├── index.html          # Estrutura HTML da ficha
├── LICENSE             # Lisença do uso do projeto
└── README.md           # Documentação (este arquivo)
```

---

## 🎨 Personalização de Cores

Todas as cores do projeto estão centralizadas em variáveis CSS no início do arquivo `styles.css`
Para mudar o tema visual, basta editar as variáveis!

---

## 💾 Armazenamento de Dados

Os personagens são salvos localmente no navegador usando **LocalStorage**:
- ✅ Salvamento automático a cada 2 segundos
- ✅ Dados persistem mesmo após fechar o navegador
- ✅ Suporte a múltiplos personagens
- ✅ Sistema de carregar/excluir personagens

**⚠️ Importante**: Os dados são armazenados apenas no navegador local. Para backup, recomenda-se:
- Exportar a ficha (Ctrl+P → Salvar como PDF)
- Fazer screenshots
- Anotar manualmente informações críticas

---

## 🖨️ Impressão

A ficha possui um layout otimizado para impressão:

1. Clique no botão **"🖨️ Imprimir Ficha"**
2. Configure a impressora para **A4**
3. Margens recomendadas: **10mm**
4. Imprima ou salve como PDF

O modo de impressão:
- Remove botões e controles
- Ajusta o layout para papel
- Otimiza fontes e espaçamentos
- Mantém todas as informações visíveis

---

## 🔧 Tecnologias Utilizadas

- **HTML5** - Estrutura semântica
- **CSS3** - Estilização e responsividade
  - CSS Grid & Flexbox
  - Custom Properties (variáveis CSS)
  - Media Queries
  - Clip-path para formas customizadas
- **JavaScript (ES6+)** - Lógica e interatividade
  - LocalStorage API
  - DOM Manipulation
  - Event Handlers
  - Arrow Functions

---

## 📱 Compatibilidade

### Navegadores Desktop
- ✅ Chrome 90+
- ✅ Firefox 88+
- ✅ Safari 14+
- ✅ Edge 90+

### Navegadores Mobile
- ✅ Chrome Mobile
- ✅ Safari iOS
- ✅ Firefox Mobile
- ✅ Samsung Internet

### Resoluções Suportadas
- 📱 Mobile: 320px - 480px
- 📱 Tablet: 481px - 768px
- 💻 Desktop: 769px+
- 🖥️ Large Desktop: 1400px+

---

## 🎯 Roadmap / Melhorias Futuras

- [ ] Exportar personagem em JSON
- [ ] Importar personagem de arquivo
- [ ] Tema claro/escuro alternável
- [ ] Mais temas visuais (fantasia, sci-fi, horror)
- [ ] Calculadora de XP
- [ ] Sistema de níveis automático
- [ ] Integração com D&D Beyond API
- [ ] Modo offline (PWA)
- [ ] Compartilhamento de fichas via link

---

## 🤝 Contribuindo

Contribuições são bem-vindas! Se você tem sugestões de melhorias:

1. Faça um Fork do projeto
2. Crie uma branch para sua feature (`git checkout -b feature/MinhaFeature`)
3. Commit suas mudanças (`git commit -m 'Adiciona nova feature'`)
4. Push para a branch (`git push origin feature/MinhaFeature`)
5. Abra um Pull Request

---

## 📝 Changelog

### v1.0.0 (2025)
- ✨ Versão inicial
- ✅ Sistema completo de atributos e perícias
- ✅ Gerenciamento de magias
- ✅ Salvamento local
- ✅ Layout responsivo
- ✅ Modo de impressão

---

## 📄 Licença

Este projeto está sob a licença **MIT**. Veja o arquivo `LICENSE` para mais detalhes.

---

## 👤 Autor

**Seu Nome**
- GitHub: [@TonhoDevi](https://github.com/TonhoDevi)
- LinkedIn: [Antonio-Henrique](www.linkedin.com/in/antonio-henrique-batista-do-nascimento-4025ab37a)

---

## 🙏 Agradecimentos

- **Wizards of the Coast** - por criar Dungeons & Dragons
- **Comunidade D&D Brasil** - pela inspiração
- **Meus companheiros de Aventura** - Pelas histórias vividas
- Fontes utilizadas: Pirata One, Cinzel, Crimson Text (Google Fonts)

---

## 📸 Screenshots

### Desktop
![Desktop View](/assets/screenshots/foto1.png)
![Desktop View](/assets/screenshots/foto2.png)
![Desktop View](/assets/screenshots/foto3.png)


---

## ⚔️ Que seus dados sejam sempre críticos! 🎲

---

**⭐ Se este projeto te ajudou, considere dar uma estrela no GitHub!**
```
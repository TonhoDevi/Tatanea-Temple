// ============================================
// DADOS DAS CLASSES — D&D 5e Homebrew
// Arquivo: js/compendium/data-classes.js
// ============================================

const CLASSES_DATA = [
    {
        id: 'ladino',
        nome: 'Ladino',
        subtitulo: 'Versão Épico',
        pagina: '/html/class/class-ladino.html',
        //imagem: 'img/classes/ladino.jpg',
        icone: '🗡️',
        cor: '#4a7a8c',        // cor temática para o card
        dadoDeVida: 'd6',
        atributoChave: 'Destreza',
        armadura: 'Armaduras leves',
        armas: 'Armas simples, bestas de mão, espadas longas, rapieiras, espadas curtas',
        ferramentas: 'Ferramentas de ladrão',
        resistencias: 'Destreza, Inteligência',
        pericias: 'Escolha quatro: Acrobacia, Atletismo, Atuação, Enganação, Furtividade, Intimidação, Intuição, Investigação, Percepção, Persuasão e Prestidigitação',
        descricao: 'Ladinos contam com perícia, furtividade e as vulnerabilidades dos inimigos para obter vantagem em qualquer situação. Mestres da astúcia, eles preferem um ataque preciso a uma barragem de força bruta.',
        papeis: ['Dano', 'Furtividade', 'Suporte', 'Exploração'],
        dificuldade: 'Intermediário',
        subclasses: [
            { nome: 'Assassino', icone: '💀', descricao: 'Arte da morte, veneno e disfarce' },
            { nome: 'Inquisidor', icone: '🔍', descricao: 'Detecção de mentiras e combate intuitivo' },
            { nome: 'Ladrão', icone: '🔑', descricao: 'Roubo, escalada e itens mágicos' },
            { nome: 'Saqueador', icone: '🏹', descricao: 'Sobrevivência, emboscadas e mobilidade' },
        ],
        habilidadesDestaque: ['Ataque Furtivo', 'Ação Ardilosa', 'Evasão', 'Golpe de Sorte'],
    },
    // Adicione mais classes aqui conforme forem criadas
    {
        id: 'caçador',
        nome: 'Caçador',
        subtitulo: 'Versão Épico',
        pagina: '/html/class/class-caçador.html',
        //imagem: 'img/classes/caçador.jpg',
        icone: '🏹',
        cor: '#4a8a5a',        // verde floresta
        dadoDeVida: 'd10',
        atributoChave: 'Sabedoria',
        armadura: 'Leves, Médias e Escudos',
        armas: 'Simples e Marciais',
        ferramentas: 'Nenhuma',
        resistencias: 'Inteligência, Sabedoria',
        pericias: 'Escolha três: Acrobacia, Arcana, Atletismo, Furtividade, História, Percepção, Investigação, Religião e Sobrevivência',
        descricao: 'Guerreiros da natureza que rastreiam suas presas com maestria. Combinam habilidades de combate com magia natural para proteger as fronteiras da civilização.',
        papeis: ['Dano', 'Controle', 'Exploração', 'Sobrevivência'],
        dificuldade: 'Média',
        subclasses: [
            { nome: 'Exterminador Profano', icone: '☠️', descricao: 'Magia negra, maldições e erradicação do mal' },
            { nome: 'Perseguidor do Horizonte', icone: '🌀', descricao: 'Portais planares e caça interdimensional' },
            { nome: 'Predador Primal', icone: '🐾', descricao: 'Instinto ancestral e caça bruta' },
        ],
        habilidadesDestaque: ['Marca do Caçador', 'Território de Caça', 'Conjuração', 'Matador de Inimigos'],
    },
];
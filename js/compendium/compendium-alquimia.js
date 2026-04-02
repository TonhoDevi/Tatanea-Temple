// ============================================================
// COMPÊNDIO DE ALQUIMIA — JS
// Arquivo: js/compendium/alquimia.js
// ============================================================

'use strict';

// ── Símbolos de Essência ──────────────────────────────────────
const ESSENCIAS = {
    'λ': { nome: 'Água', cor: '#4ab0e8', bg: 'rgba(74,176,232,.25)', elem: 'Água' },
    'Φ': { nome: 'Ar', cor: '#c8e0f8', bg: 'rgba(200,224,248,.15)', elem: 'Ar' },
    'Ω': { nome: 'Fogo', cor: '#e87040', bg: 'rgba(232,112,64,.25)', elem: 'Fogo' },
    'Σ': { nome: 'Terra', cor: '#b87840', bg: 'rgba(184,120,64,.25)', elem: 'Terra' },
    'ζ': { nome: 'Positiva', cor: '#4ecb7a', bg: 'rgba(78,203,122,.25)', elem: 'Luz' },
    'Ψ': { nome: 'Negativa', cor: '#a070e8', bg: 'rgba(160,112,232,.25)', elem: 'Sombra' },
};

// ── Dados das Poções ─────────────────────────────────────────
const POCOES = [
    {
        id: 'elixir-saude',
        nome: 'Elixir de Saúde',
        raridade: 'Comum',
        icone: '💚',
        formula: 'λ ζ',
        nucleo: '10 gotas de sangue de uma criatura não maligna e saudável.',
        descricao: 'Quando você bebe esta poção, ela cura qualquer doença comum que esteja afligindo você e remove as condições cego, surdo, paralisado e envenenado. O líquido vermelho claro tem pequenas bolhas de luz nele.',
        melhoria: 'A cada ζ adicional à mistura ela aumenta a duração em 6 segundos.',
    },
    {
        id: 'amortentia',
        nome: 'Amortentia',
        raridade: 'Incomum',
        icone: '🩷',
        formula: 'λ Ω ζ Ψ',
        nucleo: 'Coração de um mamífero.',
        descricao: 'Da próxima vez que você vir uma criatura dentro de 10 minutos após beber esse filtro, você fica enfeitiçado por essa criatura por 12 horas. Se a criatura for da espécie ou gênero que você normalmente é atraído, você a reconhece como seu amor verdadeiro enquanto estiver enfeitiçado. O líquido efervescente de coloração rosa contém uma bolha em formato de coração.',
        melhoria: 'A cada ζ Ψ adicional à mistura, ela dobra de duração.',
    },
    {
        id: 'forma-sancto',
        nome: 'Forma Sancto',
        raridade: 'Rara',
        icone: '🌫️',
        formula: 'Σ Φ Φ ζ ζ Ψ',
        nucleo: '100ml de Água parada a mais de 24h.',
        descricao: 'O óleo cinzento nebuloso pode cobrir uma criatura Média ou menor. Aplicar leva 10 minutos. A criatura afetada recebe o efeito da magia forma etérea por 8 horas.',
        melhoria: 'A cada ζ ζ Ψ adicional à mistura, ela dobra de duração.',
    },
    {
        id: 'oleo-precisao',
        nome: 'Óleo de Precisão',
        raridade: 'Incomum',
        icone: '⚔️',
        formula: 'Ω Φ Ω Ω',
        nucleo: '100g de minério de prata em pó.',
        descricao: 'Este óleo claro e gelatinoso cintila com minúsculos fragmentos de prata. O óleo cobre uma arma cortante ou perfurante ou até 5 munições. Por 1 hora, o item coberto será mágico e terá +1 de bônus nas jogadas de ataque e dano.',
        melhoria: 'A cada Ω Ω adicional à mistura, o bônus aumenta em +1.',
    },
    {
        id: 'oleo-escorregadio',
        nome: 'Óleo Escorregadio',
        raridade: 'Incomum',
        icone: '💧',
        formula: 'λ Σ λ Σ',
        nucleo: '1kg de Argila seca.',
        descricao: 'Unguento negro pegajoso que ao cobrir uma criatura Média ou menor concede os efeitos da magia movimentação livre por 8 horas. Alternativamente, pode ser derramado no chão cobrindo 3 metros quadrados com efeito de área escorregadia por 8 horas.',
        melhoria: 'A cada λ Σ adicional à mistura, ela dobra de duração.',
    },
    {
        id: 'loqui-animalibus',
        nome: 'Loqui Animalibus',
        raridade: 'Incomum',
        icone: '🐾',
        formula: 'Σ ζ Σ Φ',
        nucleo: 'Um pedaço de um animal que ainda esteja vivo.',
        descricao: 'Quando beber esta poção, você pode conjurar a mágica amizade animal por 24 horas, à vontade. Agitar este líquido turvo traz pedacinhos à vista: uma escama de peixe, uma língua de colibri, uma garra de gato ou pelo de esquilo.',
        melhoria: 'A cada Σ Φ adicional à mistura, ela dobra de duração.',
    },
    {
        id: 'constructio',
        nome: 'Constructio',
        raridade: 'Incomum',
        icone: '💪',
        formula: 'Ω Σ Σ ζ',
        nucleo: '15 mg de Proteína.',
        descricao: 'Quando beber esta poção, você ganha o efeito de "aumentar" da magia aumentar/reduzir por 1d4 horas (sem concentração). O vermelho no líquido expande constantemente em uma gota minúscula e contrai.',
        melhoria: 'A cada Σ Φ adicional, ela dobra de duração. A cada Ω Σ Σ ζ adicional, o efeito de aumentar dobra.',
    },
    {
        id: 'oculi-tertii',
        nome: 'Oculi Tertii',
        raridade: 'Rara',
        icone: '👁️',
        formula: 'Ω Φ Φ ζ Φ Ψ',
        nucleo: '15 mg de Proteína.',
        descricao: 'Quando beber esta poção, você ganha os benefícios da magia clarividência por 1 hora (sem concentração). Um globo ocular sacoleja dentro desse líquido amarelado, mas desaparece quando a poção é aberta.',
        melhoria: 'A cada ζ Φ Ψ adicional à mistura, ela dobra de duração.',
    },
    {
        id: 'pocao-cura',
        nome: 'Poção de Cura',
        raridade: 'Comum',
        icone: '❤️',
        formula: 'ζ ζ',
        nucleo: '1 maçã vermelha em perfeito estado.',
        descricao: 'Você recupera pontos de vida quando bebe esta poção igual a 1d4 +1. Qualquer que seja a potência, o líquido vermelho da poção cintila quando agitado.',
        melhoria: 'A cada ζ adicional à mistura, a cura aumenta em 1d4 + 1.',
    },
    {
        id: 'liliths-praestans',
        nome: 'Liliths Praestans Praesidium',
        raridade: 'Lendária',
        icone: '✨',
        formula: 'Σ Σ ζ ζ ζ ζ λ ζ λ ζ ζ ζ',
        nucleo: '10g de Éter.',
        descricao: 'Quando beber esta poção, você recupera todos os seus pontos de vida. Além disso, você também é curado de cegueira, surdez e qualquer doença que esteja o afetando. O líquido tem a cor vívida de sangue e brilha quando agitado.',
        melhoria: null,
    },
    {
        id: 'reformido',
        nome: 'Reformido',
        raridade: 'Incomum',
        icone: '🔻',
        formula: 'λ Φ Φ Ψ',
        nucleo: '150 g de Farinha.',
        descricao: 'Quando beber esta poção, você ganha o efeito de "reduzir" da magia aumentar/reduzir por 1d4 horas (sem concentração). O vermelho no líquido contrai constantemente em uma gota minúscula e expande.',
        melhoria: 'A cada Φ Ψ adicional, ela dobra de duração. A cada Ω Σ Σ ζ adicional, o efeito de diminuir dobra.',
    },
    {
        id: 'taciturnos-mors',
        nome: 'Taciturnos Mors',
        raridade: 'Comum',
        icone: '☠️',
        formula: 'Ψ Ψ',
        nucleo: '1 maçã vermelha em imperfeito estado.',
        descricao: 'Esta mistura parece, cheira e tem o gosto de uma poção de cura, mas é veneno mascarado por ilusão. Ao beber: 1d6 dano de veneno e teste de Constituição ou fica envenenado sofrendo 1d6 por turno.',
        melhoria: 'A cada Ψ adicional à mistura, o dano aumenta em 1d6.',
    },
    {
        id: 'araneolus-paws',
        nome: 'Araneolus Paws',
        raridade: 'Comum',
        icone: '🕷️',
        formula: 'Σ Ψ',
        nucleo: '1g de pelo de aranha.',
        descricao: 'Quando bebe esta poção, você ganha deslocamento de escalada igual ao de caminhada por 1 hora e vantagem em testes de Força (Atletismo) para escalar. A poção tem camadas marrom, prata e cinza que não se misturam.',
        melhoria: 'A cada Ψ adicional à mistura, ela dobra de duração.',
    },
    {
        id: 'gas-corpus',
        nome: 'Gas Corpus',
        raridade: 'Rara',
        icone: '🌁',
        formula: 'Σ Φ Φ Ψ λ Φ',
        nucleo: '1l de água fervida.',
        descricao: 'Quando beber esta poção, você ganha os efeitos da magia forma gasosa por 8 horas (sem concentração) ou até você terminar o efeito com uma ação bônus. O recipiente parece conter uma névoa que flui como água.',
        melhoria: 'A cada Ψ λ Φ adicional à mistura, ela dobra de duração.',
    },
    {
        id: 'gigas-fortitudo',
        nome: 'Gigas Fortitudo',
        raridade: 'Rara',
        icone: '🏋️',
        formula: 'Σ Ψ Ω Ψ Σ ζ',
        nucleo: '500g de Carne fresca.',
        descricao: 'Quando beber esta poção, seu valor de Força muda para 23 por 1 hora (não tem efeito se Força ≥ 23). O líquido transparente tem bolas de carne flutuando no topo.',
        melhoria: 'A cada Ψ Σ ζ adicional à mistura, o valor de Força alterado aumenta em 2.',
    },
    {
        id: 'heroism',
        nome: 'Heroism',
        raridade: 'Rara',
        icone: '🛡️',
        formula: 'Ω ζ ζ ζ Σ ζ',
        nucleo: '10 ml de água benta.',
        descricao: 'Por 1 hora, você ganha 10 pontos de vida temporários e está sob efeito da magia benção (sem concentração). Esta poção azul borbulha e fumega como se estivesse fervendo.',
        melhoria: 'A cada ζ Σ ζ adicional, ela dobra de duração. A cada ζ ζ Σ ζ adicional, os pontos de vida temporários aumentam em 10.',
    },
    {
        id: 'invisibilitas',
        nome: 'Invisibilitas',
        raridade: 'Muito Rara',
        icone: '👻',
        formula: 'Φ Φ Φ Φ ζ ζ Φ ζ',
        nucleo: '3,14 g de vidro em pó.',
        descricao: 'O recipiente aparenta estar vazio. Quando bebe, você fica invisível por 1 hora como invisibilidade maior (sem concentração).',
        melhoria: 'A cada ζ ζ Φ ζ adicional à mistura, ela dobra de duração.',
    },
    {
        id: 'invulnerabilis',
        nome: 'Invulnerabilis',
        raridade: 'Muito Rara',
        icone: '🔮',
        formula: 'Σ Σ Σ Σ λ Ω Σ Φ',
        nucleo: '3g de unhas, 6 fios de cabelo e 9 dentes de réptil.',
        descricao: 'Por 1 minuto após beber esta poção, você adquire resistência a todos os danos. O líquido xaroposo parece ferro derretido.',
        melhoria: 'A cada λ Ω Σ Φ adicional à mistura, ela aumenta a duração em 1 hora.',
    },
    {
        id: 'lectorem-mentis',
        nome: 'Lectorem Mentis',
        raridade: 'Rara',
        icone: '🧠',
        formula: 'Φ Ψ Σ Ψ λ Ψ',
        nucleo: 'Uma orelha cozida em 1L de água com 150g de açúcar.',
        descricao: 'Quando beber esta poção, você ganha os efeitos da magia detectar pensamentos por 1 hora (sem concentração). O líquido roxo denso tem uma nuvem ovóide rosa flutuando nele.',
        melhoria: 'A cada Ψ λ Ψ adicional à mistura, ela dobra de duração.',
    },
    {
        id: 'longivitas',
        nome: 'Longivitas',
        raridade: 'Muito Rara',
        icone: '⌛',
        formula: 'ζ Ψ ζ Ψ ζ ζ Ψ Ψ',
        nucleo: '1 L de Sangue de um humanóide fêmea virgem retirado enquanto ela estiver adormecida e sem ferimentos.',
        descricao: 'Quando beber esta poção, sua idade física é reduzida em 1d6+6 anos. Cada vez subsequente há 10% de chance cumulativa de envelhecer 1d6+6 anos. Suspensas no líquido âmbar estão criaturas mortas que desaparecem quando aberta.',
        melhoria: 'A cada ζ ζ Ψ Ψ adicional à mistura, a quantidade de anos dobra.',
    },
    {
        id: 'piscis-nasus',
        nome: 'Piscis Nasus',
        raridade: 'Incomum',
        icone: '🐟',
        formula: 'λ λ λ Φ',
        nucleo: 'Um peixe que morreu asfixiado.',
        descricao: 'Você desenvolve guelras e pode respirar embaixo d\'água por 24 horas. O fluido verde nebuloso cheira a maresia e possui uma bolha similar a uma água-viva.',
        melhoria: 'A cada λ Φ adicional à mistura, ela dobra de duração.',
    },
    {
        id: 'draconicum-spiritus',
        nome: 'Draconicum Spiritus',
        raridade: 'Incomum',
        icone: '🐉',
        formula: 'Ω Ω Ω Ω',
        nucleo: 'Uma escama de réptil.',
        descricao: 'Quando bebe esta poção, você pode usar ação bônus para exalar fogo em alvo a 9 metros (Destreza para metade). O efeito termina após 5 expirações ou 1 hora. O líquido laranja lampeja e fumaça vaza quando aberto.',
        melhoria: 'A cada Ω Ω adicional à mistura, o dano aumenta em 1d6.',
    },
    {
        id: 'accelerare',
        nome: 'Accelerare',
        raridade: 'Muito Rara',
        icone: '⚡',
        formula: 'Φ Φ Φ Φ Ψ Ψ Φ Ψ',
        nucleo: '3 asas de ave de rapina, 3 pés de lebre, 3 cabeças de beija-flor.',
        descricao: 'Quando beber esta poção, você ganha os efeitos da magia velocidade por 10 minutos (sem concentração). O fluido amarelo é matizado de preto e gira em torno de si.',
        melhoria: 'A cada Ψ Ψ Φ Ψ adicional à mistura, ela dobra de duração.',
    },
    {
        id: 'vitalis',
        nome: 'Vitalis',
        raridade: 'Muito Rara',
        icone: '🌟',
        formula: 'Σ Σ λ λ Ψ Ψ Σ Ψ',
        nucleo: '1 L de sangue de humanóide macho exausto no momento da coleta.',
        descricao: 'Remove exaustão e cura doenças ou venenos não mágicos. Pelas próximas 24 horas, você recupera o valor máximo de pontos de vida para cada Dado de Vida gasto. O líquido carmesim pulsa regularmente.',
        melhoria: 'A cada Ψ Ψ Σ Ψ adicional à mistura, ela dobra de duração.',
    },
    {
        id: 'pocao-voo',
        nome: 'Poção de Voo',
        raridade: 'Rara',
        icone: '🦅',
        formula: 'Φ Φ Φ Φ Φ Φ',
        nucleo: 'Um falcão adulto inteiro fêmea.',
        descricao: 'Quando beber esta poção, você ganha deslocamento de voo igual ao de caminhada por 24 horas e pode planar. Se no ar quando acabar e sem outro meio de sustentação, você cai.',
        melhoria: 'A cada Φ Φ Φ adicional à mistura, ela dobra de duração.',
    },
    {
        id: 'ambrosia',
        nome: 'Ambrosia',
        raridade: 'Muito Rara',
        icone: '💀',
        formula: 'Ψ Ψ Ψ Ψ Ψ Ψ Ψ Ψ',
        nucleo: '10 g de restos mortais da mãe da criatura, 10 L de sangue de humanóide que morreu em terror, o lado direito de dois corações de bode.',
        descricao: 'Esta poção negra e pútrida pode trazer os mortos de volta à vida com 1 ponto de vida (alma disposta e livre). Cura venenos e doenças normais da hora da morte. O alvo sofre –7 de penalidade reduzida por 1 a cada descanso longo.',
        melhoria: 'Com Ψ Ψ Ψ Ψ adicional, a criatura volta com vida máxima e sem penalidade.',
    },
    {
        id: 'garrafa-descanso',
        nome: 'Garrafa de Descanso Longo',
        raridade: 'Lendária',
        icone: '💤',
        formula: 'Σ Σ Ω Ω Ω Σ ζ ζ ζ ζ Ω Ω',
        nucleo: '100g de diamante em pó, 50g de esmeralda e 25g de ouro.',
        descricao: 'Criado pelo mago Mordekainer que levou a receita ao túmulo. A criatura ganha todos os benefícios de descanso longo, mas após 24h dorme por semanas iguais à quantidade de garrafas consumidas. Parece alcatrão que brilha como diamantes.',
        melhoria: null,
    },
    {
        id: 'leao-engarrafada',
        nome: 'Leão Engarrafada',
        raridade: 'Incomum',
        icone: '🦁',
        formula: 'Σ Σ Ψ Ψ',
        nucleo: '1L de sangue de leão.',
        descricao: '+1d4 em testes de Força e resistências, +2 ao dano com armas de Força e imunidade a medo por 24 horas. Sujeito a comportamentos de risco e agressão excessiva. Possui mecânica de vício com teste de Constituição.',
        melhoria: 'A cada Ψ Ψ adicional, ela dobra de duração. A cada Σ Σ Ψ Ψ adicional, o bônus de dano aumenta em +1.',
    },
    {
        id: 'felix-felicis',
        nome: 'Felix Felicis',
        raridade: 'Muito Rara',
        icone: '🍀',
        formula: 'ζ ζ ζ ζ ζ ζ ζ ζ',
        nucleo: '100g de obsidiana em pó peneirada.',
        descricao: 'Sorte Líquida por 1 hora: +2 em todos os d20, +10 em d100. Rolagens menores que 10 no d20 contam como 10; menores que 50 no d100 contam como 50.',
        melhoria: 'A cada ζ ζ ζ ζ adicional à mistura, ela dobra de duração.',
    },
    {
        id: 'trembolona',
        nome: 'Trembolona',
        raridade: 'Lendária',
        icone: '💉',
        formula: 'Σ Σ Σ Σ Σ Σ Σ Σ Σ Σ Σ Σ',
        nucleo: '100 L de semen de baleia coletado nas últimas 24h enquanto a baleia estava feliz.',
        descricao: 'Líquido de cor carmesim profunda com bolhas pretas sem parar. Aumenta seu valor de Força em 3, até o máximo de 28.',
        melhoria: null,
    },
    {
        id: 'newkama-hormone',
        nome: 'Newkama Hormone',
        raridade: 'Rara',
        icone: '🌸',
        formula: 'Ω Ω λ λ λ Ω λ Ω',
        nucleo: '10 mL de semen de humanóide durante sua puberdade coletado nas últimas 24h.',
        descricao: 'Líquido transparente com brilho prateado. Ao bebê-la, o usuário vivencia uma transformação temporária, mudando seu sexo biológico por 24 horas.',
        melhoria: 'A cada λ Ω λ Ω adicional à mistura, ela dobra de duração.',
    },
    {
        id: 'liliths-arcanus',
        nome: 'Liliths Arcanus',
        raridade: 'Rara',
        icone: '🔵',
        formula: 'Ω Ω λ Ω Ω ζ',
        nucleo: '5 folhas de papel de grimório.',
        descricao: 'Vários tons de azuis vibrantes e líquido viscoso. Role 1d4+1 — recupera espaços de magia com nível combinado igual ou menor que o resultado (5° nível ou menor).',
        melhoria: 'A cada λ Ω ζ adicional à mistura, a restauração aumenta em +1.',
    },
    {
        id: 'protecao-elemental',
        nome: 'Proteção Elemental',
        raridade: 'Incomum',
        icone: '🛡️',
        formula: 'λ Ω Σ Φ',
        nucleo: '5 folhas de papel de grimório.',
        descricao: 'Poção viscosa multicolorida com cheiro de Camomila. Quando beber, você ganha resistência a um tipo de dano (fogo, frio, elétrico, trovejante ou ácido) por 1 hora. O tipo é definido na fabricação.',
        melhoria: 'A cada λ Ω Σ Φ adicional à mistura, a poção garante uma resistência adicional.',
    },
    {
        id: 'granadas-explosivas',
        nome: 'Granadas Explosivas',
        raridade: 'Incomum',
        icone: '💣',
        formula: 'λ Φ Ω Ω',
        nucleo: '25g de Pólvora.',
        descricao: 'Frasco aerodinâmico com líquido instável e quente que treme freneticamente. Arremessado a até 18m: criaturas a 4,5m devem ter sucesso em Destreza ou sofrem 2d6 de dano (tipo escolhido na fabricação).',
        melhoria: 'A cada Ω Ω adicional à mistura, o dano aumenta em 1d6.',
    },
];

// ── Kit e Estação ─────────────────────────────────────────────
const KITS = [
    { raridade: 'Comum', classe: 'rar-c', bonus: 0, usos: 5, workers: 1 },
    { raridade: 'Incomum', classe: 'rar-i', bonus: 2, usos: 10, workers: 2 },
    { raridade: 'Raro', classe: 'rar-r', bonus: 4, usos: 20, workers: 3 },
    { raridade: 'Muito Raro', classe: 'rar-mr', bonus: 6, usos: 40, workers: 4 },
    { raridade: 'Épico', classe: 'rar-e', bonus: 8, usos: 80, workers: 5 },
];

const ESTACOES = [
    { raridade: 'Comum', classe: 'rar-c', bonus: 3, usos: 50, workers: 5 },
    { raridade: 'Incomum', classe: 'rar-i', bonus: 6, usos: 100, workers: 10 },
    { raridade: 'Raro', classe: 'rar-r', bonus: 9, usos: 200, workers: 15 },
    { raridade: 'Muito Raro', classe: 'rar-mr', bonus: 12, usos: 400, workers: 20 },
    { raridade: 'Épico', classe: 'rar-e', bonus: 15, usos: 800, workers: 25 },
];

// ── ESTADO ───────────────────────────────────────────────────
const STATE = {
    search: '',
    raridade: '',
    essencia: '',
    potion: null,
    modalTab: 'desc',
};

// ── UTILITÁRIOS ───────────────────────────────────────────────
function parseFormula(formulaStr) {
    return formulaStr.trim().split(/\s+/);
}

function buildEssChips(formulaStr) {
    const syms = parseFormula(formulaStr);
    return syms.map(s => {
        const ess = ESSENCIAS[s];
        if (!ess) return '';
        return `<span class="ess-chip" data-ess="${s}" title="${ess.nome} (${s})">${s}</span>`;
    }).join('');
}

function rarityColor(r) {
    const map = {
        'Comum': 'var(--rar-comum)',
        'Incomum': 'var(--rar-incomum)',
        'Rara': 'var(--rar-rara)',
        'Muito Rara': 'var(--rar-muito-rara)',
        'Lendária': 'var(--rar-lendaria)',
    };
    return map[r] || '#fff';
}

// ── FILTROS ───────────────────────────────────────────────────
function getFiltered() {
    let list = [...POCOES];
    const q = STATE.search.toLowerCase();

    if (q) {
        list = list.filter(p =>
            p.nome.toLowerCase().includes(q) ||
            p.descricao.toLowerCase().includes(q) ||
            p.formula.includes(q) ||
            (p.nucleo && p.nucleo.toLowerCase().includes(q)) ||
            (p.melhoria && p.melhoria.toLowerCase().includes(q))
        );
    }
    if (STATE.raridade) {
        list = list.filter(p => p.raridade === STATE.raridade);
    }
    if (STATE.essencia) {
        list = list.filter(p => parseFormula(p.formula).includes(STATE.essencia));
    }
    return list;
}

// ── RENDER GRID ───────────────────────────────────────────────
function render() {
    const grid = document.getElementById('potionsGrid');
    const count = document.getElementById('resultsCount');
    if (!grid) return;

    const lista = getFiltered();
    if (count) {
        count.innerHTML = `Mostrando <strong>${lista.length}</strong> de <strong>${POCOES.length}</strong> poções`;
    }

    grid.innerHTML = '';
    if (!lista.length) {
        grid.innerHTML = `<div class="alq-empty"><span class="alq-empty-icon">⚗️</span>Nenhuma poção encontrada.</div>`;
        return;
    }

    lista.forEach((p, i) => {
        const idx = POCOES.indexOf(p);
        const card = document.createElement('div');
        card.className = 'alq-card';
        card.dataset.rarity = p.raridade;
        card.style.animationDelay = `${Math.min(i * 0.035, 0.45)}s`;
        card.setAttribute('role', 'button');
        card.setAttribute('tabindex', '0');

        card.innerHTML = `
      <div class="card-header">
        <span class="card-icon">${p.icone}</span>
        <span class="card-rarity-badge" data-rarity="${p.raridade}">${p.raridade}</span>
      </div>
      <div class="card-body">
        <h3 class="card-name">${p.nome}</h3>
        <p class="card-desc">${p.descricao}</p>
        <div class="card-formula">${buildEssChips(p.formula)}</div>
        <div class="card-footer">
          <span class="card-nucleus-label">📦 Núcleo especial</span>
          <button class="card-btn">Ver Detalhes →</button>
        </div>
      </div>`;

        card.addEventListener('click', () => openModal(idx));
        card.addEventListener('keydown', e => {
            if (e.key === 'Enter' || e.key === ' ') { e.preventDefault(); openModal(idx); }
        });
        grid.appendChild(card);
    });
}

// ── MODAL ─────────────────────────────────────────────────────
function openModal(idx) {
    STATE.potion = idx;
    const p = POCOES[idx];
    const overlay = document.getElementById('potionModal');

    // Preenche
    document.getElementById('mIcon').textContent = p.icone;
    document.getElementById('mName').textContent = p.nome;

    const rarEl = document.getElementById('mRarity');
    rarEl.textContent = `Poção, ${p.raridade}`;
    rarEl.style.color = rarityColor(p.raridade);

    document.getElementById('mFormula').innerHTML = buildEssChips(p.formula);

    // quick stats
    const syms = parseFormula(p.formula);
    document.getElementById('mQsComps').textContent = syms.length;
    const cd = 8 + (syms.length * 2);
    document.getElementById('mQsCd').textContent = `CD ${cd}`;
    const rarDesafio = { 'Comum': 0, 'Incomum': 2, 'Rara': 4, 'Muito Rara': 6, 'Lendária': 10 };
    document.getElementById('mQsDesafio').textContent = rarDesafio[p.raridade] ?? 0;

    // Aba descrição
    document.getElementById('mDesc').textContent = p.descricao;

    // Aba fabrico
    document.getElementById('mNucleo').textContent = p.nucleo || '—';
    const melh = document.getElementById('mMelhoria');
    if (p.melhoria) {
        melh.closest('.alq-melhoria').style.display = '';
        melh.textContent = p.melhoria;
    } else {
        melh.closest('.alq-melhoria').style.display = 'none';
    }

    // Aba fórmula detalhada
    const essDetail = document.getElementById('mEssDetail');
    const unique = [...new Set(syms)];
    essDetail.innerHTML = unique.map(s => {
        const ess = ESSENCIAS[s];
        if (!ess) return '';
        const count = syms.filter(x => x === s).length;
        return `
      <div class="alq-detail-block" style="border-left-color:${ess.cor}">
        <div class="alq-detail-title" style="color:${ess.cor}">
          <span class="ess-chip" data-ess="${s}">${s}</span>
          &nbsp;${ess.nome} — ${ess.elem}
          &nbsp;<small style="font-weight:400;opacity:.7">${count}× usada</small>
        </div>
        <div class="alq-detail-text">Essência de ${ess.elem.toLowerCase()}. Símbolo: <strong>${s}</strong></div>
      </div>`;
    }).join('');

    openModalTab('desc');
    overlay.classList.add('active');
    document.body.style.overflow = 'hidden';
}

function closeModal() {
    document.getElementById('potionModal').classList.remove('active');
    document.body.style.overflow = '';
}

function openModalTab(tabId) {
    document.querySelectorAll('.modal-tab').forEach(b => b.classList.toggle('active', b.dataset.tab === tabId));
    document.querySelectorAll('.tab-pane').forEach(p => p.classList.toggle('active', p.id === `pane-${tabId}`));
}

// ── NAVEGAÇÃO PRINCIPAL ───────────────────────────────────────
function switchPanel(panelId) {
    document.querySelectorAll('.alq-nav-tab').forEach(b => b.classList.toggle('active', b.dataset.panel === panelId));
    document.querySelectorAll('.alq-panel').forEach(p => p.classList.toggle('active', p.id === `panel-${panelId}`));
}

// ── CALCULADORA ───────────────────────────────────────────────
function calcularCD() {
    const nComps = parseInt(document.getElementById('calcComps').value) || 0;
    const raridade = document.getElementById('calcRaridade').value;
    const ferramenta = document.getElementById('calcFerramenta').value;
    const estacao = document.getElementById('calcEstacao').value;
    const ajudantes = parseInt(document.getElementById('calcAjudantes').value) || 0;

    const rarDesafio = { 'Comum': 0, 'Incomum': 2, 'Rara': 4, 'Muito Rara': 6, 'Lendária': 10 };
    const bonusKit = { 'kit-c': 0, 'kit-i': 2, 'kit-r': 4, 'kit-mr': 6, 'kit-e': 8 };
    const bonusEst = { 'est-c': 3, 'est-i': 6, 'est-r': 9, 'est-mr': 12, 'est-e': 15, 'nenhum': 0 };

    const nd = rarDesafio[raridade] ?? 0;
    const cd = 8 + (nComps * 2) + nd;

    const bKit = bonusKit[ferramenta] ?? 0;
    const bEst = bonusEst[estacao] ?? 0;
    const bAjud = ajudantes;
    const bonusTotal = bKit + bEst + bAjud;
    const tempo = nComps; // horas

    const res = document.getElementById('calcResult');
    res.classList.add('show');

    document.getElementById('crCD').textContent = cd;
    document.getElementById('crBonus').textContent = `+${bonusTotal}`;
    document.getElementById('crTempo').textContent = `${tempo}h`;
    document.getElementById('crNote').textContent =
        `Para ter sucesso, você precisa de pelo menos ${cd - bonusTotal} no dado (antes do bônus). ` +
        `O material é consumido independente do resultado.`;
}

// ── PLANTAS / BIOMAS (painel regras) ─────────────────────────
const PLANTS_BY_BIOME = {
    'Ártico': ['Erva Azul (λ)', 'Hera de Drojo (Σ)', 'Amoreira de Ucre (ζ)', 'Folha de Wisp (Φ)', 'Papoula Branca (λζ) — Incomum', 'Flor de Anjo (Φζζ) — Muito Rara'],
    'Florestas': ['Crepúsculo Absinto (Ψ)', 'Hera de Drojo (Σ)', 'Folha de Ellond (Ω)', 'Folha de Kreet (λλ) — Rara', 'Erva Sanguínea (λΨ) — Incomum', 'Folha do Trovão (ΩΦ) — Incomum'],
    'Cavernas': ['Crepúsculo Absinto (Ψ)', 'Erva Azul (λ)', 'Raiz de Mandrágora (λΣ) — Incomum', 'Flor do Abismo (ΣΨ) — Incomum', 'Cogumelo do Crepúsculo (ζζ) — Rara', 'Bagas Brilhantes (ζΨΨ) — Muito Rara'],
    'Deserto': ['Hera de Drojo (Σ)', 'Folha de Ellond (Ω)', 'Amoreira de Ucre (ζ)', 'Efedra Seca (ΩΣ) — Incomum', 'Pétalas de Olina (ΩΨ) — Incomum', 'Cacto Albino (Ψζζ) — Muito Rara'],
    'Lagos & Rios': ['Crepúsculo Absinto (Ψ)', 'Erva Azul (λ)', 'Raiz de Mandrágora (Σ)', 'Seiva de Anis (λΩ) — Incomum', 'Folha de Kreet (ΣΣ) — Rara', 'Madeira Cromática (λζζ) — Muito Rara'],
    'Montanhas': ['Hera de Drojo (Σ)', 'Folha de Ellond (Ω)', 'Folha de Wisp (Φ)', 'Cebolinhas Cinzas (Ωζ) — Incomum', 'Brotos Voadores (ΣΦ) — Incomum', 'Goma Vermilion (ΩΨΨ) — Muito Rara'],
    'Pântanos': ['Crepúsculo Absinto (Ψ)', 'Erva Azul (λ)', 'Folha de Wisp (Φ)', 'Musgo Borbulhador (λΦ) — Incomum', 'Louro do Cire (ΦΦ) — Rara', 'Rosa de Pétalas Negras (ΣΨΨ) — Muito Rara'],
    'Planícies': ['Folha de Ellond (Ω)', 'Raiz de Mandrágora (Σ)', 'Amoreira de Ucre (ζ)', 'Grama Ensolarada (Σζ) — Incomum', 'Pólen de Flor Brasil (ζΨ) — Incomum', 'Língua de Dragão (ΩΩ) — Rara'],
    'Tundra': ['Erva Azul (λ)', 'Folha de Wisp (Φ)', 'Crepúsculo Absinto (Ψ)', 'Casca de Salgueiro Lutador (ΦΨ) — Incomum', 'Orvalho de Sabugosa (Φζ) — Incomum', 'Néctar Lunar (ΨΨ) — Rara'],
};

function renderBiomePicker() {
    const sel = document.getElementById('biomeSelect');
    const list = document.getElementById('biomeList');
    if (!sel || !list) return;

    sel.innerHTML = Object.keys(PLANTS_BY_BIOME).map(b =>
        `<option value="${b}">${b}</option>`
    ).join('');

    sel.addEventListener('change', () => {
        const plants = PLANTS_BY_BIOME[sel.value] || [];
        list.innerHTML = plants.map(pl => `
      <li style="padding:6px 0;border-bottom:1px solid rgba(78,203,122,.07);font-family:'Crimson Text',serif;font-size:.97rem;color:#d0e8c8;">
        🌿 ${pl}
      </li>`).join('');
    });

    sel.dispatchEvent(new Event('change'));
}

// ── CONTADORES DO HEADER ──────────────────────────────────────
function preencherContadores() {
    const counts = { Comum: 0, Incomum: 0, Rara: 0, 'Muito Rara': 0, Lendária: 0 };
    POCOES.forEach(p => { counts[p.raridade] = (counts[p.raridade] || 0) + 1; });

    const el = id => document.getElementById(id);
    if (el('statTotal')) el('statTotal').textContent = POCOES.length;
    if (el('statComum')) el('statComum').textContent = counts.Comum;
    if (el('statIncomum')) el('statIncomum').textContent = counts.Incomum;
    if (el('statRara')) el('statRara').textContent = counts.Rara;
    if (el('statMuitoRara')) el('statMuitoRara').textContent = counts['Muito Rara'];
    if (el('statLendaria')) el('statLendaria').textContent = counts.Lendária;
}

// ── RENDER KITS & ESTAÇÕES ────────────────────────────────────
function renderToolCards() {
    const kitsEl = document.getElementById('kitCards');
    const estEl = document.getElementById('estacaoCards');

    if (kitsEl) {
        kitsEl.innerHTML = KITS.map(k => `
      <div class="tool-card">
        <div>
          <div class="tool-card-name">
            <span class="rar-chip ${k.classe}">${k.raridade}</span>
          </div>
        </div>
        <div class="tool-card-stat">
          <span class="tool-card-stat-label">Bônus</span>
          <span class="tool-card-stat-val stat-bonus">+${k.bonus}</span>
        </div>
        <div class="tool-card-stat">
          <span class="tool-card-stat-label">Usos</span>
          <span class="tool-card-stat-val stat-usos">${k.usos}</span>
        </div>
        <div class="tool-card-stat">
          <span class="tool-card-stat-label">Pessoas</span>
          <span class="tool-card-stat-val stat-workers">${k.workers}</span>
        </div>
      </div>`).join('');
    }

    if (estEl) {
        estEl.innerHTML = ESTACOES.map(e => `
      <div class="tool-card">
        <div>
          <div class="tool-card-name">
            <span class="rar-chip ${e.classe}">${e.raridade}</span>
          </div>
        </div>
        <div class="tool-card-stat">
          <span class="tool-card-stat-label">Bônus</span>
          <span class="tool-card-stat-val stat-bonus">+${e.bonus}</span>
        </div>
        <div class="tool-card-stat">
          <span class="tool-card-stat-label">Usos</span>
          <span class="tool-card-stat-val stat-usos">${e.usos}</span>
        </div>
        <div class="tool-card-stat">
          <span class="tool-card-stat-label">Pessoas</span>
          <span class="tool-card-stat-val stat-workers">${e.workers}</span>
        </div>
      </div>`).join('');
    }
}

// ── BIND EVENTOS ──────────────────────────────────────────────
function bindEvents() {
    // Busca
    document.getElementById('searchInput')?.addEventListener('input', e => {
        STATE.search = e.target.value.trim();
        render();
    });

    // Raridade
    document.getElementById('rarFilter')?.addEventListener('change', e => {
        STATE.raridade = e.target.value;
        render();
    });

    // Botões de essência
    document.querySelectorAll('.alq-ess-btn').forEach(btn => {
        btn.addEventListener('click', () => {
            const val = btn.dataset.ess;
            if (STATE.essencia === val) {
                STATE.essencia = '';
                btn.classList.remove('active');
            } else {
                document.querySelectorAll('.alq-ess-btn').forEach(b => b.classList.remove('active'));
                STATE.essencia = val;
                btn.classList.add('active');
            }
            render();
        });
    });

    // Nav principal
    document.querySelectorAll('.alq-nav-tab').forEach(btn => {
        btn.addEventListener('click', () => switchPanel(btn.dataset.panel));
    });

    // Modal: abas
    document.querySelectorAll('.modal-tab').forEach(btn => {
        btn.addEventListener('click', () => openModalTab(btn.dataset.tab));
    });

    // Modal: fechar
    document.getElementById('modalClose')?.addEventListener('click', closeModal);
    document.getElementById('potionModal')?.addEventListener('click', e => {
        if (e.target === e.currentTarget) closeModal();
    });

    // ESC
    document.addEventListener('keydown', e => {
        if (e.key === 'Escape') closeModal();
    });

    // Calculadora
    document.getElementById('calcBtn')?.addEventListener('click', calcularCD);

    // Calcular ao ajustar ajudantes
    document.getElementById('calcFerramenta')?.addEventListener('change', () => {
        const fEl = document.getElementById('calcFerramenta');
        const aEl = document.getElementById('calcAjudantes');
        if (!fEl || !aEl) return;
        // Atualiza max de ajudantes baseado na ferramenta
        const limites = { 'kit-c': 1, 'kit-i': 2, 'kit-r': 3, 'kit-mr': 4, 'kit-e': 5 };
        const max = limites[fEl.value] ?? 5;
        aEl.max = max;
        if (parseInt(aEl.value) > max) aEl.value = max;
    });
}

// ── INIT ──────────────────────────────────────────────────────
document.addEventListener('DOMContentLoaded', () => {
    preencherContadores();
    render();
    bindEvents();
    renderBiomePicker();
    renderToolCards();
});
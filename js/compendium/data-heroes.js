// ============================================
// DADOS DOS HERÓIS — D&D 5e Homebrew
// Arquivo: js/compendium/data-heroes.js
// ============================================

const HEROES_DATA = [
    {
        id: 'valderon',
        nome: 'Valderon',
        alcunha: 'O Eterno Chama',
        imagem: '', // 'assets/heroes/valderon.jpg'
        icone: '🔥',
        categoria: 'lendario',
        nivel: '20',
        classe: 'Mago / Guerreiro',
        especie: 'Humano Transcendido',
        planoDeOrigem: 'Plano Primordial',
        tempo: 'Era dos Conflitos',
        historia: `Nascido nas cinzas de uma guerra esquecida, Valderon começou sua jornada como um simples estudante de artes arcanas em uma pequena cidade fronteiriça. Sua vida mudou para sempre quando uma explosão de energia planar destruiu seu lar, concedendo a ele acesso a poderes que transcendem a compreensão mortal.

Nos anos que se seguiram, Valderon percorreu os planos mais perigosos da existência, forjando sua vontade nas chamas de batalhas impossíveis e emergindo não como um mago comum, mas como um ser entre os mortais e os imortais. Seu domínio sobre as chamas primordiais é considerado único em toda a história registrada.

Hoje, Valderon carrega o peso de milênios de conhecimento em seus ombros, navegando entre o dever de proteger os planos e sua própria humanidade que se torna cada vez mais distante.`,
        versaoAtual: 'prime',
        versoes: [
            {
                id: 'origem',
                nome: 'Versão Origem',
                icone: '🌱',
                descricao: 'Valderon jovem, ainda antes do evento planar que transformou sua vida para sempre.',
                atributos: { FOR: 35, DEX: 55, CON: 40, INT: 72, SAB: 60, CAR: 50 },
                poderesStat: { POW: 35, MAG: 68, INF: 25, TEC: 60, RES: 38, DEF: 32 },
                poderesMaiores: [
                    {
                        nome: 'Chama Menor',
                        icone: '🔥',
                        descricao: 'Controle básico sobre pequenas chamas. Valderon pode invocar e manipular fogo em uma área de 3 metros ao redor de si, causando dano moderado a inimigos. Pode iluminar ambientes escuros por até 1 hora sem concentração.',
                    },
                    {
                        nome: 'Escudo Arcano',
                        icone: '🛡️',
                        descricao: 'Uma barreira mágica instável que absorve até 15 pontos de dano antes de se dissipar. Requer concentração para manter ativa e custa uma ação bônus para invocar.',
                    },
                ],
            },
            {
                id: 'pos-evento',
                nome: 'Pós-Evento Planar',
                icone: '⚡',
                descricao: 'Após a explosão planar que transformou Valderon, seus poderes cresceram exponencialmente além de qualquer previsão.',
                atributos: { FOR: 55, DEX: 70, CON: 60, INT: 88, SAB: 78, CAR: 65 },
                poderesStat: { POW: 72, MAG: 88, INF: 55, TEC: 80, RES: 65, DEF: 58 },
                poderesMaiores: [
                    {
                        nome: 'Chama Primordial',
                        icone: '🔥',
                        descricao: 'Invoca chamas direto do plano primordial do fogo. Causa dano massivo em área de 9 metros, ignorando resistências mundanas. Pode ser mantida por até 1 minuto com concentração total.',
                    },
                    {
                        nome: 'Transcendência Parcial',
                        icone: '✨',
                        descricao: 'Valderon pode, por breves momentos, transcender sua forma física, tornando-se imune a dano físico e capaz de passar por objetos sólidos. Dura apenas 1 rodada e deixa Valderon exausto.',
                    },
                    {
                        nome: 'Memória dos Planos',
                        icone: '🌌',
                        descricao: 'A exposição à energia planar conferiu a Valderon memórias de existências anteriores. Acessa conhecimentos arcanos obscuros sobre qualquer plano visitado, recebendo vantagem em testes de Arcanismo relacionados.',
                    },
                ],
            },
            {
                id: 'prime',
                nome: 'Prime',
                icone: '👑',
                descricao: 'A forma definitiva de Valderon — após séculos de aprimoramento, no absoluto auge de seu poder e sabedoria.',
                atributos: { FOR: 72, DEX: 82, CON: 75, INT: 96, SAB: 88, CAR: 80 },
                poderesStat: { POW: 90, MAG: 98, INF: 78, TEC: 92, RES: 85, DEF: 75 },
                poderesMaiores: [
                    {
                        nome: 'Chama Eterna',
                        icone: '🔥',
                        descricao: 'A versão definitiva do controle sobre o fogo. Valderon invoca uma tempestade de chamas primordiais cobrindo 30 metros, causando dano catastrófico. O fogo persiste por 10 minutos e não pode ser apagado por meios mundanos.',
                    },
                    {
                        nome: 'Transcendência Plena',
                        icone: '✨',
                        descricao: 'Valderon assume forma de pura energia planar por até 10 minutos. Imune a dano físico e mágico de nível inferior, pode voar a velocidade tripla e seus ataques causam dano planar que ignora todas as resistências.',
                    },
                    {
                        nome: 'Conhecimento Absoluto',
                        icone: '🌌',
                        descricao: 'Após séculos, Valderon acumulou conhecimento de praticamente todos os planos. Uma vez por descanso longo, acessa informação perfeita sobre qualquer entidade, lugar ou evento planar dos últimos 1.000 anos.',
                    },
                    {
                        nome: 'Legado Imortal',
                        icone: '💀',
                        descricao: 'Valderon transcendeu a mortalidade. Ao ser reduzido a 0 PV, pode gastar uma ação de lenda para se reconstituir em 1 rodada com metade dos PV máximos. Utilizável uma vez por encontro.',
                    },
                ],
            },
        ],
    },
    // Adicione mais heróis aqui
];

// ── Categorias ──────────────────────────────────────
const HERO_CATEGORIAS = {
    lendario: { label: '👑 Lendário', cor: '#c9a96e', bg: 'rgba(180,130,40,.18)', borda: 'rgba(200,160,60,.4)' },
    heroi: { label: '⚔️ Herói', cor: '#5fbd8e', bg: 'rgba(30,94,66,.18)', borda: 'rgba(46,140,80,.4)' },
    vilao: { label: '💀 Vilão', cor: '#e07090', bg: 'rgba(139,20,50,.18)', borda: 'rgba(180,40,80,.4)' },
    misterioso: { label: '🌑 Misterioso', cor: '#a070e8', bg: 'rgba(74,20,120,.18)', borda: 'rgba(120,60,180,.4)' },
    aliado: { label: '🤝 Aliado', cor: '#70c0e8', bg: 'rgba(20,80,140,.18)', borda: 'rgba(40,120,180,.4)' },
};
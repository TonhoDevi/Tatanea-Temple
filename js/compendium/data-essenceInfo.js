// ============================================
// DADOS DAS ESSÊNCIAS E BIOMAS — D&D 5e Homebrew
// Arquivo: js/compendium/data-essenceInfo.js
// ============================================

const ESSENCIAS = {
    'λ': { nome: 'Água', cor: '#4ab0e8', bg: 'rgba(74,176,232,.25)', elem: 'Água' },
    'Φ': { nome: 'Ar', cor: '#c8e0f8', bg: 'rgba(200,224,248,.15)', elem: 'Ar' },
    'Ω': { nome: 'Fogo', cor: '#e87040', bg: 'rgba(232,112,64,.25)', elem: 'Fogo' },
    'Σ': { nome: 'Terra', cor: '#b87840', bg: 'rgba(184,120,64,.25)', elem: 'Terra' },
    'ζ': { nome: 'Positiva', cor: '#4ecb7a', bg: 'rgba(78,203,122,.25)', elem: 'Luz' },
    'Ψ': { nome: 'Negativa', cor: '#a070e8', bg: 'rgba(160,112,232,.25)', elem: 'Sombra' },
    'ξ': { nome: 'Sintética', cor: '#00e5d4', bg: 'rgba(0,229,212,.20)', elem: 'Síntese' },
    'δ': { nome: 'Estática', cor: '#ffe84a', bg: 'rgba(255,232,74,.22)', elem: 'Eletricidade' },
};

const Essence_By_Biome = {
    'Ártico': [
        { nome: 'Líquen Pálido', essencia: 'λ', raridade: 'Comum', d100_min: 1, d100_max: 17 },
        { nome: 'Musgo das Neves', essencia: 'Φ', raridade: 'Comum', d100_min: 18, d100_max: 34 },
        { nome: 'Erva Azul', essencia: 'λ', raridade: 'Comum', d100_min: 35, d100_max: 51 },
        { nome: 'Hera de Drojo', essencia: 'Σ', raridade: 'Comum', d100_min: 52, d100_max: 68 },
        { nome: 'Papoula Branca', essencia: 'λ ζ', raridade: 'Incomum', d100_min: 69, d100_max: 78 },
        { nome: 'Raiz de Geada', essencia: 'λ Ω', raridade: 'Incomum', d100_min: 79, d100_max: 88 },
        { nome: 'Lótus Glacial', essencia: 'λ λ ζ', raridade: 'Rara', d100_min: 89, d100_max: 92 },
        { nome: 'Flor de Anjo', essencia: 'Φ ζ ζ', raridade: 'Rara', d100_min: 93, d100_max: 96 },
        { nome: 'Estrela de Prata', essencia: 'δ Φ Φ', raridade: 'Muito Rara', d100_min: 97, d100_max: 98 },
        { nome: 'Lágrima Invernal', essencia: 'λ λ ξ', raridade: 'Muito Rara', d100_min: 99, d100_max: 99 },
        { nome: 'Nevasca Eterna', essencia: 'ζ ζ ζ λ δ', raridade: 'Lendária', d100_min: 100, d100_max: 100 }
    ],
    'Florestas': [
        { nome: 'Folha de Ellond', essencia: 'Ω', raridade: 'Comum', d100_min: 1, d100_max: 15 },
        { nome: 'Hera de Drojo', essencia: 'Σ', raridade: 'Comum', d100_min: 16, d100_max: 30 },
        { nome: 'Crepúsculo Absinto', essencia: 'Ψ', raridade: 'Comum', d100_min: 31, d100_max: 45 },
        { nome: 'Casca de Carvalho', essencia: 'Σ', raridade: 'Comum', d100_min: 46, d100_max: 60 },
        { nome: 'Musgo Verde', essencia: 'λ', raridade: 'Comum', d100_min: 61, d100_max: 75 },
        { nome: 'Erva Sanguínea', essencia: 'λ Ψ', raridade: 'Incomum', d100_min: 76, d100_max: 80 },
        { nome: 'Folha do Trovão', essencia: 'Ω Φ', raridade: 'Incomum', d100_min: 81, d100_max: 85 },
        { nome: 'Orquídea Noturna', essencia: 'Ψ Ψ', raridade: 'Incomum', d100_min: 86, d100_max: 90 },
        { nome: 'Raiz Cantante', essencia: 'Φ ζ', raridade: 'Incomum', d100_min: 91, d100_max: 95 },
        { nome: 'Folha de Kreet', essencia: 'λ λ', raridade: 'Rara', d100_min: 96, d100_max: 99 },
        { nome: 'Yggdrasil Broto', essencia: 'ζ ζ ζ Σ Φ', raridade: 'Lendária', d100_min: 100, d100_max: 100 }
    ],
    'Cavernas': [
        { nome: 'Líquen Cavernoso', essencia: 'Σ', raridade: 'Comum', d100_min: 1, d100_max: 17 },
        { nome: 'Crepúsculo Absinto', essencia: 'Ψ', raridade: 'Comum', d100_min: 18, d100_max: 34 },
        { nome: 'Erva Azul', essencia: 'λ', raridade: 'Comum', d100_min: 35, d100_max: 51 },
        { nome: 'Fungo Brilhante', essencia: 'ζ', raridade: 'Comum', d100_min: 52, d100_max: 68 },
        { nome: 'Raiz de Mandrágora', essencia: 'λ Σ', raridade: 'Incomum', d100_min: 69, d100_max: 78 },
        { nome: 'Flor do Abismo', essencia: 'Σ Ψ', raridade: 'Incomum', d100_min: 79, d100_max: 88 },
        { nome: 'Cogumelo do Crepúsculo', essencia: 'ζ ζ', raridade: 'Rara', d100_min: 89, d100_max: 92 },
        { nome: 'Cristal de Sal', essencia: 'Σ λ ξ', raridade: 'Rara', d100_min: 93, d100_max: 96 },
        { nome: 'Bagas Brilhantes', essencia: 'ζ Ψ Ψ', raridade: 'Muito Rara', d100_min: 97, d100_max: 98 },
        { nome: 'Esporo Cego', essencia: 'Ψ Ψ ξ', raridade: 'Muito Rara', d100_min: 99, d100_max: 99 },
        { nome: 'Coração de Geo', essencia: 'Ψ Ψ Ψ Σ δ', raridade: 'Lendária', d100_min: 100, d100_max: 100 }
    ],
    'Deserto': [
        { nome: 'Cacto Pequeno', essencia: 'λ', raridade: 'Comum', d100_min: 1, d100_max: 17 },
        { nome: 'Folha de Ellond', essencia: 'Ω', raridade: 'Comum', d100_min: 18, d100_max: 34 },
        { nome: 'Hera de Drojo', essencia: 'Σ', raridade: 'Comum', d100_min: 35, d100_max: 51 },
        { nome: 'Erva Seca', essencia: 'Σ', raridade: 'Comum', d100_min: 52, d100_max: 68 },
        { nome: 'Efedra Seca', essencia: 'Ω Σ', raridade: 'Incomum', d100_min: 69, d100_max: 78 },
        { nome: 'Pétalas de Olina', essencia: 'Ω Ψ', raridade: 'Incomum', d100_min: 79, d100_max: 88 },
        { nome: 'Raiz do Sol', essencia: 'Ω Ω ζ', raridade: 'Rara', d100_min: 89, d100_max: 92 },
        { nome: 'Areia de Ouro', essencia: 'Σ δ', raridade: 'Rara', d100_min: 93, d100_max: 96 },
        { nome: 'Cacto Albino', essencia: 'Ψ ζ ζ', raridade: 'Muito Rara', d100_min: 97, d100_max: 98 },
        { nome: 'Rosa de Vidro', essencia: 'Ω Σ ξ', raridade: 'Muito Rara', d100_min: 99, d100_max: 99 },
        { nome: 'Miragem Pura', essencia: 'ζ ζ ζ Φ Ω', raridade: 'Lendária', d100_min: 100, d100_max: 100 }
    ],
    'Lagos & Rios': [
        { nome: 'Alga Comum', essencia: 'λ', raridade: 'Comum', d100_min: 1, d100_max: 15 },
        { nome: 'Erva Azul', essencia: 'λ', raridade: 'Comum', d100_min: 16, d100_max: 30 },
        { nome: 'Crepúsculo Absinto', essencia: 'Ψ', raridade: 'Comum', d100_min: 31, d100_max: 45 },
        { nome: 'Vitória-régia Menor', essencia: 'Σ', raridade: 'Comum', d100_min: 46, d100_max: 60 },
        { nome: 'Musgo Dourado', essencia: 'ζ', raridade: 'Comum', d100_min: 61, d100_max: 75 },
        { nome: 'Seiva de Anis', essencia: 'λ Ω', raridade: 'Incomum', d100_min: 76, d100_max: 80 },
        { nome: 'Musgo Torrado', essencia: 'λ Φ', raridade: 'Incomum', d100_min: 81, d100_max: 85 },
        { nome: 'Junco de Prata', essencia: 'λ ζ', raridade: 'Incomum', d100_min: 86, d100_max: 90 },
        { nome: 'Alga Brilhante', essencia: 'λ δ', raridade: 'Incomum', d100_min: 91, d100_max: 95 },
        { nome: 'Folha de Kreet', essencia: 'Σ Σ', raridade: 'Rara', d100_min: 96, d100_max: 99 },
        { nome: 'Lágrima do leviatã', essencia: 'Ψ Ψ Ψ λ ζ', raridade: 'Lendária', d100_min: 100, d100_max: 100 }
    ],
    'Montanhas': [
        { nome: 'Musgo de Pedra', essencia: 'Σ', raridade: 'Comum', d100_min: 1, d100_max: 17 },
        { nome: 'Hera de Drojo', essencia: 'Σ', raridade: 'Comum', d100_min: 18, d100_max: 34 },
        { nome: 'Folha de Ellond', essencia: 'Ω', raridade: 'Comum', d100_min: 35, d100_max: 51 },
        { nome: 'Folha de Wisp', essencia: 'Φ', raridade: 'Comum', d100_min: 52, d100_max: 68 },
        { nome: 'Cebolinhas Cinzas', essencia: 'Ω ζ', raridade: 'Incomum', d100_min: 69, d100_max: 78 },
        { nome: 'Brotos Voadores', essencia: 'Σ Φ', raridade: 'Incomum', d100_min: 79, d100_max: 88 },
        { nome: 'Fulgor da Cúpula', essencia: 'Ω Φ', raridade: 'Rara', d100_min: 89, d100_max: 92 },
        { nome: 'Pena de Rocha', 'essencia': 'Σ Σ Φ', raridade: 'Rara', d100_min: 93, d100_max: 96 },
        { nome: 'Goma Vermilion', essencia: 'Ω Ψ Ψ', raridade: 'Muito Rara', d100_min: 97, d100_max: 98 },
        { nome: 'Vento Congelado', essencia: 'Φ Φ δ', raridade: 'Muito Rara', d100_min: 99, d100_max: 99 },
        { nome: 'Sopro do Titã', essencia: 'ζ ζ ζ Σ Ω', raridade: 'Lendária', d100_min: 100, d100_max: 100 }
    ],
    'Pântanos': [
        { nome: 'Lama-erva', essencia: 'Σ', raridade: 'Comum', d100_min: 1, d100_max: 17 },
        { nome: 'Crepúsculo Absinto', essencia: 'Ψ', raridade: 'Comum', d100_min: 18, d100_max: 34 },
        { nome: 'Erva Azul', essencia: 'λ', raridade: 'Comum', d100_min: 35, d100_max: 51 },
        { nome: 'Erva Fétida', essencia: 'Ψ', raridade: 'Comum', d100_min: 52, d100_max: 68 },
        { nome: 'Musgo Borbulhador', essencia: 'λ Φ', raridade: 'Incomum', d100_min: 69, d100_max: 78 },
        { nome: 'Raiz Podre', essencia: 'Ψ Σ', raridade: 'Incomum', d100_min: 79, d100_max: 88 },
        { nome: 'Louro do Cire', essencia: 'Φ Φ', raridade: 'Rara', d100_min: 89, d100_max: 92 },
        { nome: 'Gota Venenosa', essencia: 'Ψ λ ξ', raridade: 'Rara', d100_min: 93, d100_max: 96 },
        { nome: 'Rosa de Pétalas Negras', essencia: 'Σ Ψ Ψ', raridade: 'Muito Rara', d100_min: 97, d100_max: 98 },
        { nome: 'Semente Fantasma', essencia: 'Ψ Ψ ξ', raridade: 'Muito Rara', d100_min: 99, d100_max: 99 },
        { nome: 'Essência da Podridão', essencia: 'Ψ Ψ Ψ Σ λ', raridade: 'Lendária', d100_min: 100, d100_max: 100 }
    ],
    'Planícies': [
        { nome: 'Grama Comum', essencia: 'Σ', raridade: 'Comum', d100_min: 1, d100_max: 15 },
        { nome: 'Folha de Ellond', essencia: 'Ω', raridade: 'Comum', d100_min: 16, d100_max: 30 },
        { nome: 'Raiz de Mandrágora', essencia: 'Σ', raridade: 'Comum', d100_min: 31, d100_max: 45 },
        { nome: 'Amoreira de Ucre', essencia: 'ζ', raridade: 'Comum', d100_min: 46, d100_max: 60 },
        { nome: 'Folha Brisa', essencia: 'Φ', raridade: 'Comum', d100_min: 61, d100_max: 75 },
        { nome: 'Grama Ensolarada', essencia: 'Σ ζ', raridade: 'Incomum', d100_min: 76, d100_max: 80 },
        { nome: 'Pólen de Flor Brasil', essencia: 'ζ Ψ', raridade: 'Incomum', d100_min: 81, d100_max: 85 },
        { nome: 'Semente Dourada', essencia: 'ζ Ω', raridade: 'Incomum', d100_min: 86, d100_max: 90 },
        { nome: 'Grama Estática', essencia: 'Σ δ', raridade: 'Incomum', d100_min: 91, d100_max: 95 },
        { nome: 'Língua de Dragão', essencia: 'Ω Ω', raridade: 'Rara', d100_min: 96, d100_max: 99 },
        { nome: 'Bênção de Tatania', essencia: 'ζ ζ ζ Σ Φ', raridade: 'Lendária', d100_min: 100, d100_max: 100 }
    ],
    'Tundra': [
        { nome: 'Mato Fralde', essencia: 'Σ', raridade: 'Comum', d100_min: 1, d100_max: 17 },
        { nome: 'Erva Azul', essencia: 'λ', raridade: 'Comum', d100_min: 18, d100_max: 34 },
        { nome: 'Folha de Wisp', essencia: 'Φ', raridade: 'Comum', d100_min: 35, d100_max: 51 },
        { nome: 'Crepúsculo Absinto', essencia: 'Ψ', raridade: 'Comum', d100_min: 52, d100_max: 68 },
        { nome: 'Casca de Salgueiro Lutador', essencia: 'Φ Ψ', raridade: 'Incomum', d100_min: 69, d100_max: 78 },
        { nome: 'Orvalho de Sabugosa', essencia: 'Φ ζ', raridade: 'Incomum', d100_min: 79, d100_max: 88 },
        { nome: 'Néctar Lunar', essencia: 'Ψ Ψ', raridade: 'Rara', d100_min: 89, d100_max: 92 },
        { nome: 'Lótus Fria', essencia: 'λ ζ Φ', raridade: 'Rara', d100_min: 93, d100_max: 96 },
        { nome: 'Cristal de Gelo Negro', essencia: 'λ λ Ψ', raridade: 'Muito Rara', d100_min: 97, d100_max: 98 },
        { nome: 'Uivo Sibilante', essencia: 'Φ Φ δ', raridade: 'Muito Rara', d100_min: 99, d100_max: 99 },
        { nome: 'Essência da Aurora', essencia: 'ζ ζ ζ Φ δ', raridade: 'Lendária', d100_min: 100, d100_max: 100 }
    ],
    'Ruínas Antigas': [
        { nome: 'Musgo de Cobre', essencia: 'Σ', raridade: 'Comum', d100_min: 1, d100_max: 25 },
        { nome: 'Erva Ferrugem', essencia: 'Ω', raridade: 'Comum', d100_min: 26, d100_max: 50 },
        { nome: 'Trepadeira de Fio', essencia: 'Σ δ', raridade: 'Incomum', d100_min: 51, d100_max: 65 },
        { nome: 'Fuligem Mística', essencia: 'Ψ Ω', raridade: 'Incomum', d100_min: 66, d100_max: 80 },
        { nome: 'Pó de Prisma', 'essencia': 'ζ ξ', raridade: 'Rara', d100_min: 81, d100_max: 85 },
        { nome: 'Rosa Arcano', essencia: 'Ψ ξ', raridade: 'Rara', d100_min: 86, d100_max: 90 },
        { nome: 'Raiz Pulsante', essencia: 'δ δ', raridade: 'Rara', d100_min: 91, d100_max: 94 },
        { nome: 'Quartzo Sombrio', essencia: 'Ψ Ψ Σ', raridade: 'Muito Rara', d100_min: 95, d100_max: 96 },
        { nome: 'Lírio Sintético', essencia: 'ξ ξ ζ', raridade: 'Muito Rara', d100_min: 97, d100_max: 98 },
        { nome: 'Engrenagem Viva', essencia: 'Σ δ ξ', raridade: 'Muito Rara', d100_min: 99, d100_max: 99 },
        { nome: 'Memória Ancestral', essencia: 'Ψ Ψ Ψ ξ δ', raridade: 'Lendária', d100_min: 100, d100_max: 100 }
    ],
    'Estepes Vulcânicas': [
        { nome: 'Cinza Fértil', essencia: 'Σ', raridade: 'Comum', d100_min: 1, d100_max: 25 },
        { nome: 'Grama de Brasa', essencia: 'Ω', raridade: 'Comum', d100_min: 26, d100_max: 50 },
        { nome: 'Musgo Basalto', essencia: 'Σ Ω', raridade: 'Incomum', d100_min: 51, d100_max: 65 },
        { nome: 'Pimenta do Diabo', essencia: 'Ω Ψ', raridade: 'Incomum', d100_min: 66, d100_max: 80 },
        { nome: 'Raiz Obsidiana', essencia: 'Σ Ψ', raridade: 'Rara', d100_min: 81, d100_max: 85 },
        { nome: 'Fulgor Magma', essencia: 'Ω Ω δ', raridade: 'Rara', d100_min: 86, d100_max: 90 },
        { nome: 'Pétala Ígnea', essencia: 'Ω ζ', raridade: 'Rara', d100_min: 91, d100_max: 94 },
        { nome: 'Lágrima de Fênix', essencia: 'Ω Ω ζ', raridade: 'Muito Rara', d100_min: 95, d100_max: 96 },
        { nome: 'Vapor Sangrento', essencia: 'Ω Ψ λ', raridade: 'Muito Rara', d100_min: 97, d100_max: 98 },
        { nome: 'Chama Fantasma', essencia: 'Ω Ψ Φ', raridade: 'Muito Rara', d100_min: 99, d100_max: 99 },
        { nome: 'Ira da Montanha', essencia: 'Ψ Ψ Ψ Ω Σ', raridade: 'Lendária', d100_min: 100, d100_max: 100 }
    ],
    'Subterrâneo': [
        { nome: 'Fungo da Escuridão', essencia: 'Ψ', raridade: 'Comum', d100_min: 1, d100_max: 25 },
        { nome: 'Líquen Pútrido', essencia: 'Σ', raridade: 'Comum', d100_min: 26, d100_max: 50 },
        { nome: 'Brotos Pestilentos', essencia: 'Ψ Ψ', raridade: 'Incomum', d100_min: 51, d100_max: 65 },
        { nome: 'Grama Cega', essencia: 'Ψ Σ', raridade: 'Incomum', d100_min: 66, d100_max: 80 },
        { nome: 'Rosa do Medo', essencia: 'Ψ Φ', raridade: 'Rara', d100_min: 81, d100_max: 85 },
        { nome: 'Coração Negro', essencia: 'Ψ Ψ ζ', raridade: 'Rara', d100_min: 86, d100_max: 90 },
        { nome: 'Lágrima de Desespero', essencia: 'Ψ λ', raridade: 'Rara', d100_min: 91, d100_max: 94 },
        { nome: 'Olho do Abismo', essencia: 'Ψ Ψ Φ', raridade: 'Muito Rara', d100_min: 95, d100_max: 96 },
        { nome: 'Essência de Múmia', 'essencia': 'Ψ Σ ξ', raridade: 'Muito Rara', d100_min: 97, d100_max: 98 },
        { nome: 'Fogo Frio', essencia: 'Ψ Ω δ', raridade: 'Muito Rara', d100_min: 99, d100_max: 99 },
        { nome: 'Alma Consumida', essencia: 'Ψ Ψ Ψ Ψ ξ', raridade: 'Lendária', d100_min: 100, d100_max: 100 }
    ]
};
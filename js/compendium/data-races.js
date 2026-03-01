// ========================================
// BANCO DE DADOS DE RAÇAS - D&D 5e Homebrew
// Arquivo: js/compendium/data-races.js
// Organizado por: Raças Globais, Tribais, Místicas, Sobrenaturais
// ========================================

const RACAS_DATA = [

  // ==========================================
  //           RAÇAS GLOBAIS
  // ==========================================

  // ---------- ANÕES ----------
  {
    nome: "Anão Rochoso",
    categoria: "global",
    tamanho: "medio",
    deslocamento: "7,5 m",
    //imagem: "assets/races/anao-rochoso.jpg",
    descricao: "Os Guardiões das Cordilheiras. Vivem em enormes fortalezas nas montanhas, mestres da engenharia subterrânea e da arquitetura. São o pilar da identidade anã.",
    tracos: [
      "Aumento de Constituição +2 (raça) +1 (sub-raça)",
      "Idade: jovens até 30 anos, vivem até 350 anos",
      "Tamanho: 1,20–1,50 m, ~175 kg — Médio",
      "Deslocamento: 7,5 m, sem redução com armadura pesada",
      "Treinamento em Combate: proficiência com machados de batalha, machadinhas, martelos leves e de guerra",
      "Proficiência com Ferramentas: ferramentas de ferreiro, suprimentos de cervejeiro ou ferramentas de pedreiro",
      "Especialização em Rochas: dobro de proficiência em testes de História sobre trabalho com pedra",
      "Resiliência Anã: vantagem contra venenos e dano de veneno",
      "Idiomas: Comum e Anão"
    ],
    habilidades: [
      {
        nome: "Visão Sísmica",
        descricao: "Você possui visão sísmica a até 9 metros."
      },
      {
        nome: "Corpo de Colosso",
        descricao: "Seu máximo de pontos de vida aumenta em 1. A cada nível, recebe vida adicional igual à metade do seu bônus de proficiência (mínimo 1)."
      },
      {
        nome: "Bastião Ancestral",
        descricao: "+1 de CA enquanto estiver usando armadura."
      },
      {
        nome: "Proteção Rúnica",
        descricao: "Vantagem em testes de resistência contra magias de nível igual ou inferior ao seu modificador de Constituição."
      },
      {
        nome: "Especialização em Artesanato",
        descricao: "Você possui especialização na perícia de ferramenta recebida pela característica de raça."
      }
    ]
  },

  {
    nome: "Anão Barba de Bronze",
    categoria: "global",
    tamanho: "medio",
    deslocamento: "9 m",
    //imagem: "assets/races/anao-barba-bronze.jpg",
    descricao: "Nascidos nas altas montanhas onde as tempestades são soberanas. Desenvolveram uma relação única com o poder dos céus, forjando com energia elétrica armazenada em elaborados condutores.",
    tracos: [
      "Aumento de Constituição +2 (raça) e Destreza +1 (sub-raça)",
      "Idade: jovens até 30 anos, vivem até 350 anos",
      "Tamanho: 1,20–1,50 m, ~175 kg — Médio",
      "Deslocamento: 9 m (Velocidade Energizada)",
      "Treinamento em Combate: proficiência com machados de batalha, machadinhas, martelos leves e de guerra",
      "Proficiência com Ferramentas: ferramentas de ferreiro, suprimentos de cervejeiro ou ferramentas de pedreiro",
      "Especialização em Rochas: dobro de proficiência em testes de História sobre trabalho com pedra",
      "Resiliência Anã: vantagem contra venenos e dano de veneno",
      "Idiomas: Comum e Anão"
    ],
    habilidades: [
      {
        nome: "Resistência Elétrica",
        descricao: "Você tem resistência a dano elétrico."
      },
      {
        nome: "Energético por Natureza",
        descricao: "Vantagem em testes para resistir à Exaustão. Ao terminar um descanso curto ou longo, recupera um nível de Exaustão adicional."
      },
      {
        nome: "Corpo Eletromagnético",
        descricao: "Vantagem em jogadas de ataque corpo a corpo contra criaturas feitas de metal ou usando armaduras de metal. Vantagem em testes de Força em qualquer interação com metal."
      },
      {
        nome: "Velocidade Energizada",
        descricao: "Seu deslocamento base de caminhada é de 9 metros."
      }
    ]
  },

  {
    nome: "Anão de Obsídea",
    categoria: "global",
    tamanho: "medio",
    deslocamento: "7,5 m",
    //imagem: "assets/races/anao-obsidea.jpg",
    descricao: "Forjados no coração de montanhas vulcânicas. Pele negra como carvão e olhos alaranjados como brasas vivas. Considerados os melhores ferreiros que já caminharam sobre o mundo.",
    tracos: [
      "Aumento de Constituição +2 (raça) e Força +1 (sub-raça)",
      "Idade: jovens até 30 anos, vivem até 350 anos",
      "Tamanho: 1,20–1,50 m, ~175 kg — Médio",
      "Deslocamento: 7,5 m",
      "Treinamento em Combate: proficiência com machados de batalha, machadinhas, martelos leves e de guerra",
      "Proficiência com Ferramentas: ferramentas de ferreiro (com redução de tempo à metade)",
      "Especialização em Rochas: dobro de proficiência em testes de História sobre trabalho com pedra",
      "Resiliência Anã: vantagem contra venenos e dano de veneno",
      "Idiomas: Comum e Anão"
    ],
    habilidades: [
      {
        nome: "Resistência Vulcânica",
        descricao: "Você tem resistência a dano de fogo."
      },
      {
        nome: "Armas da Forja Viva",
        descricao: "Uma vez por descanso curto ou longo, ao atingir um inimigo com arma corpo a corpo de metal, causa 1d8 de dano de fogo adicional (2d8 no 11º nível)."
      },
      {
        nome: "Teimosia de Pedra",
        descricao: "Você só morre após falhar em 4 testes de resistência contra a morte, em vez de 3."
      },
      {
        nome: "Forjador-Mestre",
        descricao: "Proficiência com ferramentas de ferreiro. Tempo de criação/reparo de metal reduzido à metade. Armas ou armaduras criadas por você recebem bônus em ataque/CA igual à metade do bônus de proficiência. Número de itens com bônus cresce por nível (1 no 1º, 3 no 2º, 6 no 3º, etc.)."
      }
    ]
  },

  // ---------- ELFOS ----------
  {
    nome: "Elfo Altivo",
    categoria: "global",
    tamanho: "medio",
    deslocamento: "9 m",
    //imagem: "assets/races/elfo-altivo.jpg",
    descricao: "Herdeiros de tradições arcanas milenares, dedicados ao conhecimento e à diplomacia. Orgulhosos, com mente disciplinada e magia refinada como extensão natural de sua vontade.",
    tracos: [
      "Aumento de Destreza +2 (raça) e Inteligência +1 (sub-raça)",
      "Idade: adultos aos ~70 anos, vivem até 500 anos",
      "Tamanho: 1,50–1,80 m — Médio",
      "Deslocamento: 9 m",
      "Sentidos Aguçados: proficiência em Percepção",
      "Ancestral Feérico: vantagem contra ser enfeitiçado, imunidade a sono mágico",
      "Transe: 4 horas de meditação equivalem a 8 horas de sono",
      "Treinamento Élfico: proficiência com espadas longas, curtas, arcos longos e curtos",
      "Idioma Adicional: fala, lê e escreve um idioma extra à escolha",
      "Idiomas: Comum e Élfico"
    ],
    habilidades: [
      {
        nome: "Magia Altiva",
        descricao: "Aprende dois truques de Mago. No 3º nível, aprende uma magia de 1º nível de Mago; no 5º nível, uma de 2º nível. Cada magia de nível pode ser conjurada uma vez por descanso longo sem gastar espaço."
      },
      {
        nome: "Mente Diplomática",
        descricao: "Vantagem no primeiro teste de Carisma ao interagir com uma criatura. Após o primeiro teste, a criatura só é afetada novamente após 24h."
      }
    ]
  },

  {
    nome: "Elfo Floral",
    categoria: "global",
    tamanho: "medio",
    deslocamento: "12 m",
    //imagem: "assets/races/elfo-floral.jpg",
    descricao: "Vivem entre ramos e raízes, conectados ao pulso da natureza. Ágeis como o vento e perigosos como predadores, combatem em harmonia com seus aliados.",
    tracos: [
      "Aumento de Destreza +2 (raça) e Sabedoria +1 (sub-raça)",
      "Idade: adultos aos ~70 anos, vivem até 500 anos",
      "Tamanho: 1,50–1,80 m — Médio",
      "Deslocamento: 12 m (Pés Ligeiros)",
      "Sentidos Aguçados: proficiência em Percepção",
      "Ancestral Feérico: vantagem contra ser enfeitiçado, imunidade a sono mágico",
      "Transe: 4 horas de meditação equivalem a 8 horas de sono",
      "Treinamento Élfico: proficiência com espadas longas, curtas, arcos longos e curtos",
      "Idiomas: Comum e Élfico"
    ],
    habilidades: [
      {
        nome: "Ataque de Primavera",
        descricao: "Ao realizar um ataque corpo a corpo, você não provoca ataques de oportunidade daquela criatura pelo resto do turno."
      },
      {
        nome: "Instinto de Matilha",
        descricao: "+1 na jogada de ataque para cada aliado a até 3 metros do alvo, até o máximo do bônus de proficiência. Aliados inconscientes ou incapacitados não contam."
      },
      {
        nome: "Magia Feérica",
        descricao: "Conjura Fogo das Fadas gratuitamente. No 3º nível: Crescer Espinhos. No 5º nível: Falar com Plantas. Cada magia recupera uso após descanso longo. Sabedoria é o atributo de conjuração."
      },
      {
        nome: "Máscara da Natureza",
        descricao: "+5 em testes de Furtividade em leve obscuridade por folhagem, chuva, neve, névoa ou fenômenos naturais."
      }
    ]
  },

  {
    nome: "Drow",
    categoria: "global",
    tamanho: "medio",
    deslocamento: "9 m",
    //imagem: "assets/races/drow.jpg",
    descricao: "Forjados nas profundezas do Subterrâneo. Caminham na tênue linha entre luz e trevas, mesclando astúcia e letalidade. Sua existência é marcada pela desconfiança e pelo instinto de sobrevivência.",
    tracos: [
      "Aumento de Destreza +2 (raça) e Carisma +1 (sub-raça)",
      "Idade: adultos aos ~70 anos, vivem até 500 anos",
      "Tamanho: 1,50–1,80 m — Médio",
      "Deslocamento: 9 m",
      "Sentidos Aguçados: proficiência em Percepção",
      "Ancestral Feérico: vantagem contra ser enfeitiçado, imunidade a sono mágico",
      "Transe: 4 horas de meditação equivalem a 8 horas de sono",
      "Treinamento Drow: proficiência com rapieiras, espadas curtas e bestas de mão",
      "Visão no Escuro Superior: 120 pés na penumbra como luz plena, escuridão como penumbra",
      "Fraqueza ao Divino: vulnerabilidade a dano Radiante",
      "Idiomas: Comum e Élfico"
    ],
    habilidades: [
      {
        nome: "Resistência Necrótica",
        descricao: "Você tem resistência a danos necróticos."
      },
      {
        nome: "Teleporte Sombrio",
        descricao: "Ação bônus: teleporta até 9m para ponto levemente obscurecido (não estando em fonte de luz). Ganha resistência a todos os danos até o início do próximo turno. Recupera uso após descanso longo."
      },
      {
        nome: "Lâmina do Pacto Sombrio",
        descricao: "Ao final de um descanso curto, gasta 1 pv para banhar uma arma cortante/perfurante no sangue. O primeiro ataque que acertar causa dano necrótico adicional igual a 1/10 do pv máximo da criatura (ignora resistências) e impede a criatura de recuperar pv até o início do próximo turno. Uma arma por vez."
      }
    ]
  },

  {
    nome: "Kor",
    categoria: "global",
    tamanho: "medio",
    deslocamento: "9 m",
    //imagem: "assets/races/kor.jpg",
    descricao: "Nascidos entre penhascos suspensos e ilhas flutuantes. Movem-se com graça de acrobatas e precisão de caçadores, usando cordas como extensão dos próprios braços.",
    tracos: [
      "Aumento de Destreza +2 (raça) +1 (sub-raça)",
      "Idade: adultos aos ~70 anos, vivem até 500 anos",
      "Tamanho: 1,50–1,80 m — Médio",
      "Deslocamento: 9 m",
      "Sentidos Aguçados: proficiência em Percepção",
      "Ancestral Feérico: vantagem contra ser enfeitiçado, imunidade a sono mágico",
      "Transe: 4 horas de meditação equivalem a 8 horas de sono",
      "Comunicação em libras",
      "Idiomas: Comum e Élfico"
    ],
    habilidades: [
      {
        nome: "Escalada Kor",
        descricao: "Proficiência nas perícias Atletismo e Acrobacia."
      },
      {
        nome: "Sorte Sobre o Destino",
        descricao: "Ao rolar 1 no d20 em ataque, teste ou resistência, pode rolar novamente e usar o novo resultado."
      },
      {
        nome: "Bravura",
        descricao: "Vantagem em testes para resistir a ser amedrontado."
      },
      {
        nome: "Mestres do Chicote",
        descricao: "Proficiência com chicote, cujo dado de dano passa a ser d8. Com o chicote em mãos: saltos 3x maiores e, com uma reação, pode fazer teste de Acrobacia para negar dano de queda no valor igual ao resultado do teste."
      }
    ]
  },

  // ---------- HUMANO ----------
  {
    nome: "Humano",
    categoria: "global",
    tamanho: "medio",
    deslocamento: "9 m",
    //imagem: "assets/races/humano.jpg",
    descricao: "A raça mais variada e adaptável. Não herdaram dons mágicos tão refinados quanto os elfos, nem a robustez dos anões, mas compensam com pura determinação e capacidade de aprender e inovar.",
    tracos: [
      "Aumento de Habilidade: quatro atributos à escolha aumentam em 1",
      "Idade: adultos no fim da adolescência, vivem menos de um século",
      "Tendência: nenhuma inclinação especial",
      "Tamanho: 1,50–1,80+ m — Médio",
      "Deslocamento: 9 m",
      "Determinação: +1 em um teste de resistência à escolha",
      "Idiomas: Comum e um idioma adicional à escolha"
    ],
    habilidades: [
      {
        nome: "Perícia",
        descricao: "Você ganha proficiência em duas perícias à sua escolha."
      },
      {
        nome: "Talento",
        descricao: "Você adquire um talento de sua escolha."
      }
    ]
  },

  // ---------- GNOMOS ----------
  {
    nome: "Gnomo Cabeça de Ponta",
    categoria: "global",
    tamanho: "pequeno",
    deslocamento: "6 m",
    //imagem: "assets/races/gnomo-cabeca-ponta.jpg",
    descricao: "Inventores incansáveis e estudiosos dedicados. Vivem cercados de pergaminhos e protótipos. Sua mente salta de ideia em ideia como uma faísca elétrica.",
    tracos: [
      "Aumento de Inteligência +2 (raça) +1 (sub-raça)",
      "Idade: maturidade semelhante aos humanos, vivem 350–500 anos",
      "Tamanho: 0,40–0,80 m, ~20 kg — Pequeno",
      "Deslocamento: 6 m",
      "Esperteza Gnômica: vantagem em resistências de Int, Sab e Car contra magia",
      "Idiomas: Comum e Gnômico"
    ],
    habilidades: [
      {
        nome: "Ilusionista Nato",
        descricao: "Conhece o truque Ilusão Menor. Inteligência é o atributo de conjuração."
      },
      {
        nome: "Curioso",
        descricao: "Proficiência em Investigação e vantagem em testes de Destreza (Investigação)."
      },
      {
        nome: "Sabido",
        descricao: "Proficiência em uma ferramenta de artesão à escolha. Sempre que usar essa ferramenta, adiciona 1d6 à rolagem."
      },
      {
        nome: "Epifania Caótica",
        descricao: "Ao iniciar um descanso longo, cria uma engenhoca que replica uma magia aleatória de até nível igual à metade do seu nível. Pode usá-la uma vez antes do próximo descanso longo. A engenhoca é pessoal e intransferível."
      },
      {
        nome: "Magia Gnômica",
        descricao: "Conhece um truque e uma magia de 1º nível de Mago (escola de Transmutação). Pode conjurar a magia uma vez por descanso longo. Inteligência é o atributo de conjuração."
      }
    ]
  },

  {
    nome: "Gnomo Olhos Fundos",
    categoria: "global",
    tamanho: "pequeno",
    deslocamento: "6 m",
    //imagem: "assets/races/gnomo-olhos-fundos.jpg",
    descricao: "Brincalhões por natureza, enxergam o mundo como um palco para truques e ilusões. Mestres de confundir inimigos e proteger os seus com sombras e luz mágica.",
    tracos: [
      "Aumento de Inteligência +2 (raça) e Destreza +1 (sub-raça)",
      "Idade: maturidade semelhante aos humanos, vivem 350–500 anos",
      "Tamanho: 0,40–0,80 m, ~20 kg — Pequeno",
      "Deslocamento: 6 m",
      "Esperteza Gnômica: vantagem em resistências de Int, Sab e Car contra magia",
      "Visão no Escuro Superior: 120 pés na penumbra como luz plena",
      "Camuflagem na Escuridão: vantagem em Furtividade em terrenos obscurecidos",
      "Idioma Adicional: Subterrâneo",
      "Idiomas: Comum e Gnômico"
    ],
    habilidades: [
      {
        nome: "Magia Gnômica",
        descricao: "Conhece um truque e uma magia de 1º nível de Mago (escola de Ilusão). Pode conjurar a magia uma vez por descanso longo. Inteligência é o atributo de conjuração."
      },
      {
        nome: "Pó de Pirlimpimpim",
        descricao: "Ao ser atingido por um ataque, como reação, lança pó mágico: reduz o dano pela metade e torna-se invisível até o início do próximo turno (ou até atacar/conjurar). Durante a invisibilidade, pode se mover sem provocar ataques de oportunidade. Usos iguais ao bônus de proficiência por descanso longo."
      }
    ]
  },

  {
    nome: "Gnomo Nariz Afiado",
    categoria: "global",
    tamanho: "pequeno",
    deslocamento: "6 m",
    //imagem: "assets/races/gnomo-nariz-afiado.jpg",
    descricao: "Marcados por uma aura de imprevisibilidade e travessura. Carregam a sorte consigo — mas essa sorte tem seu preço. Mestres em manipular o destino.",
    tracos: [
      "Aumento de Inteligência +2 (raça) e Carisma +1 (sub-raça)",
      "Idade: maturidade semelhante aos humanos, vivem 350–500 anos",
      "Tamanho: 0,40–0,80 m, ~20 kg — Pequeno",
      "Deslocamento: 6 m",
      "Esperteza Gnômica: vantagem em resistências de Int, Sab e Car contra magia",
      "Presença Afortunada: vantagem em resistências contra encantamento e medo",
      "Idiomas: Comum e Gnômico"
    ],
    habilidades: [
      {
        nome: "Sorte Inconstante",
        descricao: "Como reação, toca uma criatura e concede vantagem em uma rolagem à escolha. Se o resultado for maior que metade do valor máximo do dado, é tratado como máximo; se menor que metade, o resultado é dobrado. O alvo recebe 'marca de azar' por 1 hora: –1d4 em todas as rolagens de d20. Usos iguais ao bônus de proficiência por descanso longo."
      },
      {
        nome: "Magia da Sorte",
        descricao: "Conhece o truque Orientação. No 3º nível, pode conjurar Benção uma vez por descanso longo. Carisma é o atributo de conjuração."
      }
    ]
  },

  // ---------- HOBBIT ----------
  {
    nome: "Hobbit",
    categoria: "global",
    tamanho: "pequeno",
    deslocamento: "7,5 m",
    //imagem: "assets/races/hobbit.jpg",
    descricao: "Seres pequenos e alegres, amantes de boa refeição e conforto. Ágeis e habilidosos, com coragem surpreendente quando chamados à aventura.",
    tracos: [
      "Aumento de Destreza +2 e Carisma +1",
      "Idade: adultos aos 20 anos, vivem até 110 anos",
      "Tendência: geralmente leal e bom",
      "Tamanho: ~1 m, ~35 kg — Pequeno",
      "Deslocamento: 7,5 m",
      "Sortudo: ao rolar 1 natural em ataque/teste/resistência, pode rolar novamente",
      "Bravura: vantagem contra ser amedrontado",
      "Mente Estável: vantagem em resistências de Inteligência e contra ser enfeitiçado",
      "Agilidade Hobbit: pode se mover pelo espaço de criaturas maiores e se esconder atrás delas",
      "Idiomas: Comum e Hobbit"
    ],
    habilidades: [
      {
        nome: "Mãos Ágeis",
        descricao: "Proficiência em Prestidigitação e vantagem em testes de Destreza (Prestidigitação)."
      },
      {
        nome: "Rosto Inocente",
        descricao: "Proficiência em Persuasão e Atuação. Especialização em uma dessas perícias à escolha."
      }
    ]
  },

  // ---------- ORC ----------
  {
    nome: "Orc",
    categoria: "global",
    tamanho: "medio",
    deslocamento: "10,5 m",
    //imagem: "assets/races/orc.jpg",
    descricao: "Conhecidos por sua robustez e habilidades em combate. Sociedade estruturada em torno de líderes fortes e xamãs poderosos. Leais ao extremo com os seus, implacáveis com inimigos.",
    tracos: [
      "Aumento de Força +2 e Constituição +1",
      "Idade: adultos aos 14 anos, raramente vivem mais de 75 anos",
      "Tendência: inclinação ao caos; não fortemente ao bem",
      "Tamanho: 2,10–2,50 m, 240–330 kg — Médio",
      "Deslocamento: 10,5 m",
      "Ameaçador: proficiência em Intimidação",
      "Compleição Poderosa: conta como tamanho maior para carga, empurrar, erguer e agarrar",
      "Armas de Orcs: proficiência com machados grandes, martelos de guerra e marretas",
      "Avassalador: ao ter vantagem em corpo a corpo e acertar, causa dano extra igual ao bônus de proficiência",
      "Idiomas: Comum e Orc"
    ],
    habilidades: [
      {
        nome: "Frenesi Desenfreado",
        descricao: "Como reação ao ser atingido por ataque corpo a corpo, realiza um ataque corpo a corpo com arma com vantagem contra o atacante. Recupera uso após descanso curto ou longo."
      },
      {
        nome: "Ataques Selvagens",
        descricao: "Ao realizar um acerto crítico com arma corpo a corpo, rola um dos dados de dano da arma uma vez a mais e adiciona ao dano extra do crítico."
      }
    ]
  },

  // ---------- TRITÃO ----------
  {
    nome: "Tritão",
    categoria: "global",
    tamanho: "medio",
    deslocamento: "9 m / 12 m (natação)",
    //imagem: "assets/races/triton.jpg",
    descricao: "Guardiões dos oceanos. Existência tão antiga quanto as marés. Cultura reflexo do oceano: ora calma, ora violenta. Lealdade à tribo e ao lar inabalável.",
    tracos: [
      "Aumento de Força, Constituição e Carisma +1 cada",
      "Idade: maturidade aos 15 anos, vivem até 200 anos",
      "Alinhamento: tende ao leal e bom",
      "Tamanho: ~1,50 m — Médio",
      "Deslocamento: 9 m (caminhada), 12 m (natação)",
      "Anfíbio: pode respirar ar e água",
      "Ecolocalização: percebe criaturas em 9 m (fora d'água) e 300 m (na água); vantagem em Percepção por audição",
      "Guardiões das Profundezas: resistência a dano de frio; ignora penalidades de águas profundas",
      "Emissário do Mar: comunica-se com bestas aquáticas transmitindo ideias simples",
      "Idiomas: Comum e Primordial"
    ],
    habilidades: [
      {
        nome: "Frenesi da Corrente Sanguínea",
        descricao: "Ao atacar corpo a corpo criatura com menos da metade do pv, tem vantagem na jogada de ataque. Em um acerto, causa dano extra igual ao bônus de proficiência."
      },
      {
        nome: "Tinta do Mar Profundo",
        descricao: "Reação ao ser atacado: libera nuvem de tinta em 3 m ao redor. Área fica obscurecida por 1 minuto e o atacante tem desvantagem no ataque. Recupera uso após descanso curto ou longo."
      },
      {
        nome: "Choque da Enguia",
        descricao: "Resistência a dano elétrico. Como ação, choca criatura a até 3 m: teste de Constituição (CD 8 + proficiência + Car). Em falha, criatura fica paralisada por rodadas iguais ao bônus de proficiência. Repete o teste ao fim de cada turno. Usos iguais ao bônus de proficiência por descanso longo."
      }
    ]
  },

  // ==========================================
  //           RAÇAS TRIBAIS
  // ==========================================

  // ---------- AARAKOCRA ----------
  {
    nome: "Aarakocra",
    categoria: "tribal",
    tamanho: "medio",
    deslocamento: "4,5 m / 15 m (voo)",
    //imagem: "assets/races/aarakocra.jpg",
    descricao: "Uma raça aviária nobre e aérea. Habitam comunidades em penhascos e árvores altas. Valorizam liberdade, honra e cooperação. Guardiões dos céus.",
    tracos: [
      "Aumento de Destreza +2 e Sabedoria +1",
      "Idade: maturidade aos 3 anos, raramente vivem mais de 30 anos",
      "Tendência: maioria boa; entre leal (líderes) e caótico (aventureiros)",
      "Tamanho: ~1,5 m, 40–50 kg — Médio",
      "Deslocamento: 4,5 m (caminhada), 15 m (voo — sem armadura média/pesada)",
      "Treinamento: proficiência com arcos longos e curtos",
      "Idiomas: Comum e Auran"
    ],
    habilidades: [
      {
        nome: "Olhos de Águia",
        descricao: "Proficiência em Percepção com dobro do bônus. Enxerga normalmente até 4 km de distância."
      },
      {
        nome: "Viajante",
        descricao: "Quando voando sem exceder limite de peso, pode cobrir até 3.000 km em um único dia com magia secreta aarakocra."
      },
      {
        nome: "Esquiva",
        descricao: "Reação ao ser alvejado: levanta voo e move 4,5 m em qualquer direção sem provocar ataques de oportunidade, ganhando +5 de CA contra aquele ataque."
      }
    ]
  },

  // ---------- FERAIS ----------
  {
    nome: "Feral Cervídeo",
    categoria: "tribal",
    tamanho: "medio",
    deslocamento: "12 m",
    //imagem: "assets/races/feral-cervideo.jpg",
    descricao: "Humanoides elegantes com chifres e pernas fortes que lembram veados ou alces. Forte senso de comunidade e proteção. Habitam florestas densas.",
    tracos: [
      "Aumento de Destreza +1 (raça) +1 (sub-raça)",
      "Idade: adultos aos 18 anos, vivem até 100 anos",
      "Tamanho: 1,7–2,1 m — Médio",
      "Deslocamento: 12 m",
      "Visão no Escuro: 9 m na penumbra como luz plena",
      "Graça Natural: vantagem em Acrobacia; move em terreno difícil sem custo extra",
      "Reflexos Aguçados: vantagem em resistências contra armadilhas/magias de Destreza; +5 em Iniciativa",
      "Percepção Aguçada: proficiência em Percepção",
      "Idiomas: Comum e Silvestre"
    ],
    habilidades: [
      {
        nome: "Chifres Naturais",
        descricao: "Nunca está desarmado. Chifres causam 1d8 de dano perfurante e garantem vantagem em testes para empurrar criaturas."
      },
      {
        nome: "Fuga Instintiva",
        descricao: "Reação ao ser atingido por ataque corpo a corpo: move até metade do deslocamento sem provocar ataques de oportunidade."
      },
      {
        nome: "Presença Tranquilizadora",
        descricao: "Ação: força criaturas hostis em 6 m a fazerem teste de Sabedoria (CD 8 + proficiência + Sab) ou ficarem encantadas por 1 minuto. Uma vez por descanso longo."
      }
    ]
  },

  {
    nome: "Feral Felix",
    categoria: "tribal",
    tamanho: "medio",
    deslocamento: "13,5 m",
    //imagem: "assets/races/feral-felix.jpg",
    descricao: "Reflexos rápidos e movimentos silenciosos com forte conexão com os felinos. Caçadores inatos, mestres da furtividade e da agilidade.",
    tracos: [
      "Aumento de Destreza +1 (raça) +1 (sub-raça)",
      "Idade: amadurece e vive tempo equivalente aos humanos",
      "Tamanho: acima da média humana, mais magros — Médio",
      "Deslocamento: 9 m base + 4,5 m (Velocidade Superior)",
      "Visão no Escuro: 9 m na penumbra como luz plena",
      "Escalada: deslocamento de escalada de 6 m",
      "Habilidades Felinas: proficiência em Percepção e Furtividade",
      "Idiomas: Comum e Silvestre"
    ],
    habilidades: [
      {
        nome: "Agilidade Felina",
        descricao: "Pode dobrar seu deslocamento até o fim do turno. Após usar, não pode usar novamente até ficar parado por um turno."
      },
      {
        nome: "Garras de Gato",
        descricao: "Garras são armas naturais: 1d4 + modificador de Força de dano cortante. Permite escalar superfícies com deslocamento de 6 m."
      }
    ]
  },

  {
    nome: "Feral Loxodonte",
    categoria: "tribal",
    tamanho: "grande",
    deslocamento: "9 m",
    //imagem: "assets/races/feral-loxodonte.jpg",
    descricao: "Constituição pesada ligada aos elefantes. São a rocha de sua comunidade. Vivem cerca de 450 anos e valorizam muito o peso da sabedoria e experiência.",
    tracos: [
      "Aumento de Destreza +1 (raça) e Constituição +1 (sub-raça)",
      "Idade: adultos fisicamente como humanos, vivem ~450 anos; considerados jovens até 60",
      "Tamanho: 2,80–3,40 m, 336–482 kg — Grande",
      "Deslocamento: 9 m",
      "Visão no Escuro: 9 m na penumbra como luz plena",
      "Compleição Poderosa: conta como tamanho maior para carga, empurrar, erguer e agarrar",
      "Bravura Loxodonte: vantagem em resistências contra amedrontado",
      "Corpo de Colosso: pv máximo +1 por nível (metade do bônus de proficiência por nível, mínimo 1)",
      "Idiomas: Comum e Silvestre"
    ],
    habilidades: [
      {
        nome: "Olfato Aguçado",
        descricao: "Vantagem nos testes de Sabedoria (Percepção) e Inteligência (Investigação) que dependem do olfato."
      }
    ]
  },

  {
    nome: "Feral Marsupial",
    categoria: "tribal",
    tamanho: "medio",
    deslocamento: "9 m",
    //imagem: "assets/races/feral-marsupial.jpg",
    descricao: "Humanoides curiosos e resilientes com características de cangurus e coalas. Saltadores ágeis com forte conexão familiar.",
    tracos: [
      "Aumento de Destreza +1 (raça) e Constituição +1 (sub-raça)",
      "Idade: adultos aos 12 anos, vivem até 80 anos",
      "Tamanho: 1,4–1,7 m, corpo robusto — Médio",
      "Deslocamento: 9 m",
      "Visão no Escuro: 9 m na penumbra como luz plena",
      "Salto Poderoso: pula 3x a distância normal em altura e distância",
      "Bolsa Marsupial: armazena até 2 kg com resistência a condições ambientais",
      "Estabilidade em Combate: vantagem para evitar ser derrubado/empurrado",
      "Pulmões Resilientes: vantagem contra efeitos de sufocação/gases",
      "Idiomas: Comum e Silvestre"
    ],
    habilidades: [
      {
        nome: "Investida Saltadora",
        descricao: "Ao usar Correr e atacar corpo a corpo no mesmo turno, causa dano adicional igual ao bônus de proficiência."
      },
      {
        nome: "Resistência Natural",
        descricao: "Ao recuperar pv em descanso curto, rola 1d6 adicional e adiciona ao resultado."
      },
      {
        nome: "Aderência Ágil",
        descricao: "Vantagem em testes de Força ou Destreza para resistir a quedas ou se agarrar em superfícies."
      },
      {
        nome: "Instinto de Proteção",
        descricao: "Reação: quando aliado em 6 m for alvo de ataque, pode se mover até 4,5 m em sua direção."
      }
    ]
  },

  {
    nome: "Feral Mustelídeo",
    categoria: "tribal",
    tamanho: "pequeno",
    deslocamento: "9 m",
    //imagem: "assets/races/feral-mustelideo.jpg",
    descricao: "Humanoides ágeis e pequenos inspirados por lontras, furões e texugos. Inteligentes com habilidades de escavação e destreza em ambientes aquáticos e subterrâneos.",
    tracos: [
      "Aumento de Destreza +1 (raça) +1 (sub-raça)",
      "Idade: adultos aos 10 anos, vivem até 60 anos",
      "Tamanho: 1,2–1,5 m — Pequeno",
      "Deslocamento: 9 m",
      "Visão no Escuro: 9 m na penumbra como luz plena",
      "Furtividade Natural: vantagem em Furtividade; pode tentar se esconder mesmo levemente obscurecido",
      "Flexibilidade Sobrenatural: espreme por espaços de 30 cm sem penalidade",
      "Instinto Predador: vantagem em ataques contra criaturas ≤ seu tamanho com < 50% pv",
      "Adaptação Incansável: resistência a frio extremo; prende respiração por 10 minutos",
      "Idiomas: Comum e Silvestre"
    ],
    habilidades: [
      {
        nome: "Mordida Venenosa",
        descricao: "Mordida causa 1d6 de dano perfurante. O alvo faz teste de Constituição (CD 8 + proficiência + Con). Em falha: 1d4 de dano de veneno adicional e desvantagem no próximo ataque."
      },
      {
        nome: "Investida Ágil",
        descricao: "Uma vez por turno, ao fazer ataque corpo a corpo, pode usar ação bônus para mover 3 m sem provocar ataques de oportunidade."
      }
    ]
  },

  {
    nome: "Feral Sarubino",
    categoria: "tribal",
    tamanho: "medio",
    deslocamento: "9 m",
    //imagem: "assets/races/feral-sarubino.jpg",
    descricao: "Inteligência e agilidade dos primatas. Curiosos e energéticos, exploradores natos com grande carisma e adaptabilidade. Cauda preênsil incrivelmente versátil.",
    tracos: [
      "Aumento de Destreza +1 (raça) e Carisma +1 (sub-raça)",
      "Idade: adultos aos 12 anos, vivem ~150 anos",
      "Tendência: frequentemente caótico",
      "Tamanho: menores que humanos mas peso similar — Médio",
      "Deslocamento: 9 m",
      "Visão no Escuro: 9 m na penumbra como luz plena",
      "Escaladores Ágeis: deslocamento de escalada igual ao de caminhada; pode escalar tetos",
      "Estômago Vazio: consome o dobro de comida que criaturas do mesmo tamanho",
      "Sono Pesado: quem tentar acordá-lo faz teste de Carisma CD 15 (dano ou água o acorda automaticamente)",
      "Energia Primata: proficiência em Acrobacia ou Atletismo; usa pés e cauda como mãos",
      "Idiomas: Comum e Silvestre"
    ],
    habilidades: [
      {
        nome: "Quebra de Limites",
        descricao: "Reação: ao falhar em teste de Força, Destreza ou Constituição, pode refazer e usar o novo resultado. Recupera uso após descanso longo."
      },
      {
        nome: "Cauda",
        descricao: "Pode usar a cauda para: (1) interagir com objetos/ferramentas; (2) agarrar criatura de tamanho igual ou menor; (3) cumprir componentes somáticos. Se não usar a cauda no turno, ganha bônus de CA igual ao bônus de proficiência."
      }
    ]
  },

  {
    nome: "Feral Taurus",
    categoria: "tribal",
    tamanho: "medio",
    deslocamento: "9 m",
    //imagem: "assets/races/feral-taurus.jpg",
    descricao: "Ferais robustos que personificam a força e a determinação dos touros. Comunidades pautadas em hierarquia de força e proteção.",
    tracos: [
      "Aumento de Destreza +1 (raça) e Força +1 (sub-raça)",
      "Idade: adultos aos 17 anos, vivem até 150 anos",
      "Tamanho: acima de 2,10 m, ~235 kg — Médio",
      "Deslocamento: 9 m",
      "Visão no Escuro: 9 m na penumbra como luz plena",
      "Recordação Labiríntica: lembra-se perfeitamente de qualquer caminho já percorrido",
      "Idiomas: Comum e Silvestre"
    ],
    habilidades: [
      {
        nome: "Chifres",
        descricao: "Nunca está desarmado. Proficiência com chifres (arma corpo a corpo, 1d10 de dano perfurante). Vantagem em testes para empurrar criaturas (mas não para evitar ser empurrado)."
      },
      {
        nome: "Passos Pesados",
        descricao: "Ao mover mais de 3 m em linha reta, criaturas Médias ou menores em 1,5 m ao redor fazem teste de Destreza (CD 8 + proficiência + For) ou são derrubadas."
      },
      {
        nome: "Arremete com Chifres",
        descricao: "Ao usar Correr no turno, pode fazer ataque com chifres como ação bônus."
      },
      {
        nome: "Pancada com Chifres",
        descricao: "Ao usar Atacar com ataque corpo a corpo, pode tentar encontrão com os chifres como ação bônus (não pode derrubar com este encontrão)."
      }
    ]
  },

  {
    nome: "Feral Ursanor",
    categoria: "tribal",
    tamanho: "medio",
    deslocamento: "9 m",
    //imagem: "assets/races/feral-ursanor.jpg",
    descricao: "Combinam a força bruta dos ursos com a sabedoria da floresta. Protetores ferozes de seus lares e famílias, inspirando medo e respeito em igual medida.",
    tracos: [
      "Aumento de Destreza +1 (raça) e Força +1 (sub-raça)",
      "Idade: adultos aos 20 anos, vivem até 120 anos",
      "Tamanho: 2,1–2,5 m, 150–250 kg — Médio",
      "Deslocamento: 9 m",
      "Visão no Escuro: 9 m na penumbra como luz plena",
      "Resiliência Natural: resistência a frio; vantagem contra exaustão em ambientes gelados",
      "Resistência de Ursino: vantagem contra ser envenenado; resistência a dano de veneno",
      "Caminhante de Florestas: ignora terreno difícil natural (neve, lama, vegetação densa)",
      "Instinto de Sobrevivência: proficiência em Sobrevivência",
      "Faro Apurado: vantagem em Percepção por olfato e audição",
      "Idiomas: Comum e Silvestre"
    ],
    habilidades: [
      {
        nome: "Fúria do Predador",
        descricao: "Ao atingir inimigo com ataque corpo a corpo, pode ativar Fúria do Predador: causa dano extra igual ao bônus de proficiência até o fim do próximo turno. Usos iguais ao modificador de Constituição (mínimo 1) por descanso longo."
      },
      {
        nome: "Pancada Poderosa",
        descricao: "Ataques desarmados com garras causam 1d8 + modificador de Força de dano cortante."
      },
      {
        nome: "Hibernar",
        descricao: "Recupera o dobro de pv em descanso curto. Pode dormir profundamente por 24 horas para eliminar todos os níveis de exaustão acumulados."
      }
    ]
  },

  {
    nome: "Feral Wonideo",
    categoria: "tribal",
    tamanho: "medio",
    deslocamento: "9 m",
    //imagem: "assets/races/feral-wonideo.jpg",
    descricao: "Natureza social com traços de lobos e cães. Lealdade inabalável, vivem em matilhas unidas e confiam na força do grupo.",
    tracos: [
      "Aumento de Destreza +1 (raça) e Sabedoria +1 (sub-raça)",
      "Idade: adultos aos 15 anos, vivem até 90 anos",
      "Tamanho: altura e peso semelhantes aos humanos — Médio",
      "Deslocamento: 9 m",
      "Visão no Escuro: 9 m na penumbra como luz plena",
      "Faro Apurado: vantagem em Percepção e Investigação por olfato",
      "Lealdade Canina: vantagem em resistências contra amedrontado e encantado com aliado a 1,5 m",
      "Rastreador Natural: proficiência em Sobrevivência; rastreia criaturas pelo cheiro a 90 m",
      "Saltos Ágeis: dobra a distância de salto com corrida",
      "Comunicação Instintiva: comunicação limitada com cães, lobos e outros caninos",
      "Idiomas: Comum e Silvestre"
    ],
    habilidades: [
      {
        nome: "Instinto de Matilha",
        descricao: "Reação: quando aliado a 1,5 m faz ataque corpo a corpo contra criatura, pode realizar um ataque corpo a corpo contra a mesma criatura."
      },
      {
        nome: "Uivo Inspirador",
        descricao: "Ação: uivo que concede pv temporários iguais ao nível + modificador de Sabedoria a todos os aliados em 9 m que puderem ouvir. Recupera uso após descanso curto ou longo."
      },
      {
        nome: "Presa Selvagem",
        descricao: "Ataques desarmados com mandíbulas causam 1d6 + modificador de Força de dano perfurante."
      }
    ]
  },

  // ---------- DRACODILE ----------
  {
    nome: "Dracodile",
    categoria: "tribal",
    tamanho: "medio",
    deslocamento: "9 m",
    //imagem: "assets/races/dracodile.jpg",
    descricao: "Descendentes de Dracos. Predadores insaciáveis e ambiciosos com conexão inata à brutalidade. Um Dracodile nunca para de crescer (+0,5 m a cada 25 anos após maturidade).",
    tracos: [
      "Aumento de Força +2 e Constituição +1",
      "Idade: maturidade aos 10 anos; corpo não envelhece (mas cultura violenta reduz expectativa de vida)",
      "Tendência: geralmente mau e neutro; veem a maioria das criaturas como comida",
      "Tamanho: acima de 2,20 m, ~335 kg — Médio (cresce +0,5 m a cada 25 anos)",
      "Deslocamento: 9 m",
      "Armadura Natural: CA = 13 + modificador de Constituição sem armadura",
      "Conhecimento de Caçador: proficiência em duas perícias da lista: Adestrar Animais, Natureza, Percepção, Furtividade ou Sobrevivência",
      "Idiomas: Comum e Dracônico"
    ],
    habilidades: [
      {
        nome: "Sexto Sentido Predatório",
        descricao: "Ação: detecta criaturas em raio crescente (6 m no 1º, 18 m no 5º, 54 m no 11º, 1 km no 16º). Sabe a direção e se o ND é maior, igual ou menor que o nível. Funciona através de paredes finas. Usos iguais ao bônus de proficiência por descanso longo."
      },
      {
        nome: "Devorador Compulsivo",
        descricao: "Ação: devora criatura caída (morta há menos de 1 minuto, até uma categoria de tamanho menor). Recupera pv iguais ao ND da criatura + nível do personagem."
      },
      {
        nome: "Mandíbulas Famintas",
        descricao: "Ação bônus: ataque de mordida (1d6/2d6/4d6/6d6 de dano perfurante por nível) + pode agarrar o alvo + ganha pv temporários iguais ao nível. Se levar criatura a 0 pv, pode usar Devorador Compulsivo automaticamente. Usos iguais ao bônus de proficiência por descanso longo."
      }
    ]
  },

  // ---------- DRACONATO ----------
  {
    nome: "Draconato",
    categoria: "tribal",
    tamanho: "medio",
    deslocamento: "9 m",
    //imagem: "assets/races/draconato.jpg",
    descricao: "Descendentes diretos dos dragões. Cada um possui escamas de cor única refletindo sua linhagem. Portam habilidades naturais como sopro elemental e resistência a danos.",
    tracos: [
      "Aumento de Força +2 e Carisma +2",
      "Idade: maturidade aos 15 anos, vivem até 80 anos",
      "Tendência: tendem aos extremos (bem ou mal); a maioria é boa",
      "Tamanho: acima de 1,90 m, mais de 125 kg — Médio",
      "Deslocamento: 9 m",
      "Visão no Escuro: 9 m na penumbra como luz plena",
      "Resistência a Dano: ao tipo associado ao ancestral dracônico",
      "Idiomas: Comum e Dracônico"
    ],
    habilidades: [
      {
        nome: "Ancestral Dracônico",
        descricao: "Escolha o tipo de dragão ancestral (Azul, Branco, Bronze, Cobre, Latão, Negro, Ouro, Prata, Verde ou Vermelho) para determinar o tipo de dano e a forma da Arma de Sopro (linha ou cone)."
      },
      {
        nome: "Arma de Sopro",
        descricao: "Ação: exala energia destrutiva. CD = 8 + mod de Constituição ou Carisma + bônus de proficiência. Dano: 3d6 (6º: 7d6, 11º: 12d6, 16º: 18d6, 20º: 25d6). Metade do dano em sucesso. Usos iguais ao bônus de proficiência por descanso longo."
      }
    ]
  },

  // ---------- GENASI ----------
  {
    nome: "Genasi da Água",
    categoria: "tribal",
    tamanho: "medio",
    deslocamento: "9 m / 12 m (natação)",
    //imagem: "assets/races/genasi-agua.jpg",
    descricao: "Adaptáveis como o mar, podem ser calmos ou destrutivos. Pele azulada ou esverdeada, cabelos que se movem como água. Sentem profundo chamado por mares, rios e lagos.",
    tracos: [
      "Aumento de Constituição +2 (raça) e Sabedoria +1 (sub-raça)",
      "Idade: maturidade como humanos, vivem até 120 anos",
      "Tendência: neutros",
      "Tamanho: ~1,5–1,8 m — Médio",
      "Deslocamento: 9 m (caminhada), 12 m (natação)",
      "Anfíbio: pode respirar ar e água",
      "Imunidade a dano de Ácido e Frio",
      "Idiomas: Comum e Primordial (dialeto Aquan)"
    ],
    habilidades: [
      {
        nome: "Absorção de Energia",
        descricao: "Ação: recupera 2d6 pv (3d6 no 6º, 4d6 no 11º, 5d6 no 16º). Recupera uso após descanso curto ou longo."
      },
      {
        nome: "Magia Elemental",
        descricao: "Conhece o truque Moldar Água. No 3º nível: conjura Criar ou Destruir Água (2º nível) sem componentes materiais, uma vez por descanso curto/longo. Constituição é o atributo de conjuração."
      },
      {
        nome: "Escudo de Bolhas",
        descricao: "A partir do 3º nível, após descanso longo cria pv temporários iguais ao nível × bônus de proficiência. Pode consumir 20 L de água com uma ação para recarregar o escudo."
      },
      {
        nome: "Manifestação Elemental",
        descricao: "A partir do 5º nível, conjura Invocar Elemental (tipo Água) no nível do bônus de proficiência, sem concentração. Duração base de 1 hora, dobrada por nível acima do 3º. Uma vez por descanso longo."
      }
    ]
  },

  {
    nome: "Genasi do Ar",
    categoria: "tribal",
    tamanho: "medio",
    deslocamento: "9 m",
    //imagem: "assets/races/genasi-ar.jpg",
    descricao: "Personificação da liberdade e imprevisibilidade dos ventos. Nômades por natureza, aversão a confinamentos. Mente rápida como o vento e movimentos de ave de rapina.",
    tracos: [
      "Aumento de Constituição +2 (raça) e Destreza +1 (sub-raça)",
      "Idade: maturidade como humanos, vivem até 120 anos",
      "Tendência: neutros",
      "Tamanho: ~1,5–1,8 m — Médio",
      "Deslocamento: 9 m",
      "Fôlego Interminável: pode prender o fôlego indefinidamente",
      "Imunidade a dano Elétrico",
      "Idiomas: Comum e Primordial (dialeto Auran)"
    ],
    habilidades: [
      {
        nome: "Absorção de Energia",
        descricao: "Ação: recupera 2d6 pv (3d6 no 6º, 4d6 no 11º, 5d6 no 16º). Recupera uso após descanso curto ou longo."
      },
      {
        nome: "Queda Suave",
        descricao: "Enquanto cai e não estiver incapacitado, pode subtrair até 60 m de queda para cálculo de dano e mover 120 cm horizontalmente para cada 30 cm de queda."
      },
      {
        nome: "Misturar-se ao Vento",
        descricao: "Conhece o truque Lufada. No 3º nível: conjura Levitação sem componentes materiais, uma vez por descanso curto/longo. Constituição é o atributo de conjuração."
      },
      {
        nome: "Agilidade do Vento",
        descricao: "A partir do 3º nível, recebe bônus na CA contra ataques à distância e em resistências de Destreza, ambos iguais ao bônus de proficiência."
      },
      {
        nome: "Manifestação Elemental",
        descricao: "A partir do 5º nível, conjura Invocar Elemental (tipo Ar) no nível do bônus de proficiência, sem concentração. Uma vez por descanso longo."
      }
    ]
  },

  {
    nome: "Genasi do Fogo",
    categoria: "tribal",
    tamanho: "medio",
    deslocamento: "9 m",
    //imagem: "assets/races/genasi-fogo.jpg",
    descricao: "Personalidade intensa e volátil. Cabelos como chamas vivas, olhos que cintilam como brasas. Movidos por paixões fortes e pelo desejo de consumir e transformar.",
    tracos: [
      "Aumento de Constituição +2 (raça) e Inteligência +1 (sub-raça)",
      "Idade: maturidade como humanos, vivem até 120 anos",
      "Tendência: neutros",
      "Tamanho: ~1,5–1,8 m — Médio",
      "Deslocamento: 9 m",
      "Fogo Poderoso: causa dano extra de fogo igual à metade do nível (arredondado para baixo)",
      "Nascido no Fogo: imunidade a dano de Fogo",
      "Idiomas: Comum e Primordial (dialeto Ignan)"
    ],
    habilidades: [
      {
        nome: "Absorção de Energia",
        descricao: "Ação: recupera 2d6 pv (3d6 no 6º, 4d6 no 11º, 5d6 no 16º). Recupera uso após descanso curto ou longo."
      },
      {
        nome: "Alcançar as Chamas",
        descricao: "Conhece o truque Criar Chamas. No 3º nível: conjura Mãos Flamejantes (1º nível) sem componentes materiais, uma vez por descanso curto/longo. Constituição é o atributo de conjuração."
      },
      {
        nome: "Chama Convergente",
        descricao: "A partir do 3º nível, ao acertar um ataque, pode fazer o ataque explodir em chamas: dano adicional de fogo = (bônus de proficiência – 1)d8. Criaturas em 1,5 m do alvo também sofrem o dano. Usos iguais ao bônus de proficiência por descanso longo."
      },
      {
        nome: "Manifestação Elemental",
        descricao: "A partir do 5º nível, conjura Invocar Elemental (tipo Fogo) no nível do bônus de proficiência, sem concentração. Uma vez por descanso longo."
      }
    ]
  },

  {
    nome: "Genasi da Terra",
    categoria: "tribal",
    tamanho: "medio",
    deslocamento: "9 m",
    //imagem: "assets/races/genasi-terra.jpg",
    descricao: "Resistentes e inabaláveis como a montanha. Pele como pedra com rachaduras que brilham como geodos. Aliados incrivelmente leais ou inimigos teimosos.",
    tracos: [
      "Aumento de Constituição +2 (raça) e Força +1 (sub-raça)",
      "Idade: maturidade como humanos, vivem até 120 anos",
      "Tendência: neutros",
      "Tamanho: ~1,5–1,8 m — Médio",
      "Deslocamento: 9 m + 9 m (escavação)",
      "Caminhada Terrestre: ignora terreno difícil de terra/pedra; deslocamento de escavação de 9 m",
      "Visão Sísmica: 6 m",
      "Imunidade a dano de Concussão",
      "Idiomas: Comum e Primordial (dialeto Terran)"
    ],
    habilidades: [
      {
        nome: "Absorção de Energia",
        descricao: "Ação: recupera 2d6 pv (3d6 no 6º, 4d6 no 11º, 5d6 no 16º). Recupera uso após descanso curto ou longo."
      },
      {
        nome: "Desmoronar Rochas",
        descricao: "Conhece o truque Orientação. No 3º nível: conjura Onda Trovejante sem componentes materiais, uma vez por descanso curto/longo. Constituição é o atributo de conjuração."
      },
      {
        nome: "Corpo Resiliente",
        descricao: "Reduz todo dano Cortante, Perfurante e Contundente em um valor igual ao bônus de proficiência. Aplica-se antes de qualquer resistência."
      },
      {
        nome: "Manifestação Elemental",
        descricao: "A partir do 5º nível, conjura Invocar Elemental (tipo Terra) no nível do bônus de proficiência, sem concentração. Uma vez por descanso longo."
      }
    ]
  },

  // ---------- GITH ----------
  {
    nome: "Githzerai",
    categoria: "tribal",
    tamanho: "medio",
    deslocamento: "9 m",
    //imagem: "assets/races/githzerai.jpg",
    descricao: "Monges e filósofos da raça Gith. Encontraram paz e disciplina no caos do Limbo. Buscam iluminação e mestria de corpos e mentes. Uma fortaleza de calma e concentração.",
    tracos: [
      "Aumento de Constituição +2 (raça) e Sabedoria +1 (sub-raça)",
      "Idade: adultos aos 14 anos, vivem ~120 anos",
      "Tendência: frequentemente neutro e bom",
      "Tamanho: ~1,85 m, ~85 kg — Médio",
      "Deslocamento: 9 m",
      "Proficiências: armaduras leves e médias, espadas curtas, longas e de duas mãos",
      "Rejeitar Escravidão: vantagem em resistências contra ser enfeitiçado ou imobilizado",
      "Transe: 4 horas de meditação equivalem a 8 horas de sono",
      "Bravura: vantagem em resistências contra ser amedrontado",
      "Aura Suave: visão às cegas em 1,5 m (enquanto não incapacitado e sem concentração)",
      "Intuição pela Calma: conhece o truque Orientação",
      "Ajuste Psíquico: Sabedoria é o atributo de conjuração para magias psíquicas",
      "Idiomas: Comum e Gith"
    ],
    habilidades: [
      {
        nome: "Poder Psíquico",
        descricao: "Conhece o truque Mão Mágica (sempre invisível). Considerada Psiônica."
      },
      {
        nome: "Mente Fortalecida pelo Transe",
        descricao: "Após descanso longo, escolhe: Aura de Calma (pv temporários = nível + mod Sab) ou Foco Psíquico (vantagem em resistências de Sabedoria até o próximo descanso longo)."
      },
      {
        nome: "Defesa Psíquica",
        descricao: "Reação: quando criatura em 9 m realiza ataque, causa desvantagem na jogada. Usos iguais ao bônus de proficiência por descanso longo."
      }
    ]
  },

  {
    nome: "Githyanki",
    categoria: "tribal",
    tamanho: "medio",
    deslocamento: "9 m",
    //imagem: "assets/races/githyanki.jpg",
    descricao: "Guerreiros ferozes forjados pela escravidão e pela sede de poder. Dominam os planos com frota astral. A mente é tão potente quanto a espada.",
    tracos: [
      "Aumento de Constituição +2 (raça) e Carisma +1 (sub-raça)",
      "Idade: adultos aos 14 anos, vivem ~120 anos",
      "Tendência: frequentemente neutro puro; indivíduos malignos são comuns",
      "Tamanho: ~1,85 m, ~85 kg — Médio",
      "Deslocamento: 9 m",
      "Proficiências: armaduras leves e médias, espadas curtas, longas e de duas mãos",
      "Rejeitar Escravidão: vantagem em resistências contra ser enfeitiçado ou imobilizado",
      "Ameaçador: proficiência em Intimidação",
      "Resistência pela Raiva: conhece o truque Resistência",
      "Ajuste Psíquico: Carisma é o atributo de conjuração para magias psíquicas",
      "Idiomas: Comum e Gith"
    ],
    habilidades: [
      {
        nome: "Poder Psíquico",
        descricao: "Conhece o truque Mão Mágica (sempre invisível). Considerada Psiônica."
      },
      {
        nome: "Êxtase do Conquistador",
        descricao: "Ao realizar acerto crítico, recebe +1 em jogadas de acerto até o fim do combate."
      },
      {
        nome: "Fúria do Conquistador",
        descricao: "Uma vez por turno, após ver o resultado de ataque/resistência/perícia mas antes do mestre declarar sucesso/falha, pode adicionar dado extra: 1d4 se não estiver com pv máximo; +1d4 se ≤ 50% pv; +1d8 se com 1 pv."
      },
      {
        nome: "Resiliência pela Raiva",
        descricao: "Ao ser reduzido a 0 pv (sem morte instantânea), pode fazer resistência: 1d12 + mod Constituição + nível. Se total > dano recebido que o zerou, fica com 1 pv."
      }
    ]
  },

  // ---------- GOLIATH ----------
  {
    nome: "Goliath",
    categoria: "tribal",
    tamanho: "grande",
    deslocamento: "10,5 m",
    //imagem: "assets/races/goliath.jpg",
    descricao: "Raça montanhosa robusta de clãs que valorizam resistência, competição e determinação. Reverenciam as montanhas como guias espirituais.",
    tracos: [
      "Aumento de Força +2 e Constituição +1",
      "Idade: expectativa de vida compatível com humanos",
      "Tendência: inclinação à ordem e à neutralidade",
      "Tamanho: 2,60–3,30 m, 350–670 kg — Grande",
      "Deslocamento: 10,5 m",
      "Compleição Poderosa: conta como tamanho maior para carga, empurrar, erguer e agarrar",
      "Atleta Natural: proficiência em Atletismo",
      "Resistência Implacável: uma vez por descanso longo, ao ser reduzido a 0 pv (sem morte instant.), fica com 1 pv",
      "Corpo de Colosso Supremo: pv máximo +2; por nível, +bônus de proficiência em pv",
      "Nascido nas Montanhas: aclimatado a altas altitudes; resistência a dano de frio",
      "Idiomas: Comum e Gigante"
    ],
    habilidades: [
      {
        nome: "Resistência da Pedra",
        descricao: "Reação ao sofrer dano: rola 1d12 + modificador de Constituição e reduz o dano por esse valor. Usos iguais ao bônus de proficiência por descanso curto ou longo."
      }
    ]
  },

  // ---------- THRI-KREEN ----------
  {
    nome: "Thri-Kreen",
    categoria: "tribal",
    tamanho: "medio",
    deslocamento: "12 m",
    //imagem: "assets/races/thri-kreen.jpg",
    descricao: "Criaturas insetoides pragmáticas e diretas. Comunicação telepática entre iguais. Aversão inata à água. Exoesqueleto que age como armadura natural e múltiplos braços.",
    tracos: [
      "Aumento de Destreza +2 e Sabedoria +1",
      "Idade: adultos entre 3–4 anos após eclosão; maioria vive até 25 anos",
      "Tendência: leal; desconfortáveis com padrões sociais rígidos; raramente estritamente bons ou maus",
      "Tamanho: ~2,1–2,7 m, 90–110 kg — Médio",
      "Deslocamento: 12 m (caminhada), 9 m (escalada). Afunda em líquidos; sem natação",
      "Visão no Escuro Incomum: 18 m na penumbra como luz brilhante",
      "Estômago do Catador: imune a venenos e doenças por comer/beber",
      "Torpor: não dorme; 6 horas inativo/consciente em descanso longo; 4 L de água/semana",
      "Treinamento: proficiência com adagas, lanças, piques e glaives",
      "Telepatia Entre os Iguais: sente e comunica-se com iguais em 100 m",
      "Salto em Pé: 9 m em distância, 4,5 m em altura",
      "Idiomas: lê/escreve Comum; fala/lê/escreve Thri-Kreen"
    ],
    habilidades: [
      {
        nome: "Carapaça Camaleônica",
        descricao: "Ação bônus: muda cor/textura da carapaça para se camuflar. Vantagem em testes de Furtividade até o início do próximo turno."
      },
      {
        nome: "Exoesqueleto",
        descricao: "CA = 13 + modificador de Destreza sem armadura."
      },
      {
        nome: "Múltiplos Membros",
        descricao: "No início de cada turno, escolhe: Postura Defensiva (bônus na CA e em resistências/testes de Destreza = bônus de proficiência) ou Postura Ofensiva (dano extra em ataques corpo a corpo = bônus de proficiência; bônus em resistências/testes de Força = bônus de proficiência)."
      }
    ]
  },

  // ==========================================
  //           RAÇAS MÍSTICAS
  // ==========================================

  // ---------- AASIMAR ----------
  {
    nome: "Aasimar (Desprendido)",
    categoria: "mistica",
    tamanho: "medio",
    deslocamento: "9 m",
    //imagem: "assets/races/aasimar-desprendido.jpg",
    descricao: "Livre das responsabilidades do bem e do mal. Não se importa com a dualidade celestial, vivendo com um grande senso de liberdade. Sub-raça revelada ao atingir o 3º nível.",
    tracos: [
      "Aumento de Carisma +2 e Força +2",
      "Idade: amadurece como humanos, vive até 160 anos",
      "Alinhamento: maioria é boa; exilados podem ser neutros ou malignos",
      "Tamanho: semelhante aos humanos — Médio",
      "Deslocamento: 9 m",
      "Visão no Escuro Incomum: 18 m na penumbra como luz plena",
      "Resistência Celestial: resistência a dano Radiante e Trovejante; vulnerabilidade a Necrótico",
      "Bênção do Divino: conhece os truques Orientação e Resistência (Carisma é o atributo)",
      "Asas de Anjo: deslocamento de voo de 9 m",
      "Liberdade Incondicional: imunidade à condição Enfeitiçado",
      "Idiomas: Comum e Celestial"
    ],
    habilidades: [
      {
        nome: "Alma Radiante",
        descricao: "Ação: libera energia divina (olhos reluzem, asas incorpóreas surgem). Dura 1 minuto ou até encerrar com ação bônus. Uma vez por turno, causa dano extra radiante igual ao nível ao causar dano com ataque ou magia. Uma vez por descanso longo."
      }
    ]
  },

  {
    nome: "Aasimar (Enfurecido)",
    categoria: "mistica",
    tamanho: "medio",
    deslocamento: "9 m",
    //imagem: "assets/races/aasimar-enfurecido.jpg",
    descricao: "Perdeu a piedade em sua cruzada contra o mal. Canaliza poder divino de forma explosiva e brutal. Demoli inimigos usando a ira para inspirar medo. Sub-raça revelada ao 3º nível.",
    tracos: [
      "Aumento de Carisma +2 e Força +2",
      "Idade: amadurece como humanos, vive até 160 anos",
      "Tamanho: semelhante aos humanos — Médio",
      "Deslocamento: 9 m",
      "Visão no Escuro Incomum: 18 m na penumbra como luz plena",
      "Resistência Celestial: resistência a dano Radiante e Trovejante; vulnerabilidade a Necrótico",
      "Bênção do Divino: conhece os truques Orientação e Resistência",
      "Resistência do Enfurecido: vantagem em testes para resistir a ser amedrontado",
      "Idiomas: Comum e Celestial"
    ],
    habilidades: [
      {
        nome: "Demolidor de Covardes",
        descricao: "Ao atingir criatura Amedrontada, sua CA é reduzida em –1. Todos os pontos perdidos retornam após descanso curto."
      },
      {
        nome: "Manto Trovejante",
        descricao: "Ação bônus: olhos relampejam, asas trovejantes surgem. Criaturas em 9 m que puderem ver você fazem teste de Carisma (CD 8 + proficiência + Car) ou ficam Amedrontadas até o fim do próximo turno. Dura 1 minuto. Uma vez por turno, causa dano trovejante extra igual ao nível + bônus de CA igual ao bônus de proficiência. Uma vez por descanso longo."
      }
    ]
  },

  {
    nome: "Aasimar (Piedoso)",
    categoria: "mistica",
    tamanho: "medio",
    deslocamento: "9 m",
    //imagem: "assets/races/aasimar-piedoso.jpg",
    descricao: "Dedica sua vida a ter piedade dos outros. Protetor dos fracos e curador dos feridos. Um farol de esperança e fonte de poder vital. Sub-raça revelada ao 3º nível.",
    tracos: [
      "Aumento de Carisma +2 e Força +2",
      "Idade: amadurece como humanos, vive até 160 anos",
      "Tamanho: semelhante aos humanos — Médio",
      "Deslocamento: 9 m",
      "Visão no Escuro Incomum: 18 m na penumbra como luz plena",
      "Resistência Celestial: resistência a dano Radiante e Trovejante; vulnerabilidade a Necrótico",
      "Bênção do Divino: conhece os truques Orientação e Resistência",
      "Imune a doenças",
      "Idiomas: Comum e Celestial"
    ],
    habilidades: [
      {
        nome: "Palavra Curativa",
        descricao: "Ação bônus: conjura Palavra Curativa no nível igual ao bônus de proficiência. Carisma é o atributo de conjuração. Uma vez por descanso longo."
      },
      {
        nome: "Salvar os Caídos",
        descricao: "Criaturas à sua escolha em 3 m têm vantagem em resistências a veneno e testes de resistência à morte."
      },
      {
        nome: "Benção Radiante",
        descricao: "Ação: irradia luz reconfortante (intensa em 3 m, penumbra em +3 m). No fim de cada turno, você e criaturas à sua escolha em 3 m recuperam pv iguais ao nível. Dura 1 minuto. Uma vez por descanso longo."
      }
    ]
  },

  // ---------- FIRBOLG ----------
  {
    nome: "Firbolg",
    categoria: "mistica",
    tamanho: "medio",
    deslocamento: "9 m",
    //imagem: "assets/races/firbolg.jpg",
    descricao: "Manifestação física do poder primordial da natureza. Nascidos do coração das florestas. A última linha de defesa contra aqueles que corrompem o mundo natural.",
    tracos: [
      "Aumento de Sabedoria +2 e Constituição +2",
      "Idade: adultos aos 20 anos, podem viver até 1.500 anos",
      "Alinhamento: tipicamente neutro; o maligno é raro e inimigo da espécie",
      "Tamanho: 2,10–2,40 m, 150–210 kg — Médio",
      "Deslocamento: 9 m",
      "Compleição Poderosa: conta como tamanho maior para carga, empurrar, erguer e agarrar",
      "Fala de Besta e Folha: comunica-se de forma limitada com animais e plantas; vantagem em testes de Carisma com eles",
      "Idiomas: Comum, Élfico, Silvestre e Gigante"
    ],
    habilidades: [
      {
        nome: "Pele de Gaia",
        descricao: "Reação ao sofrer dano Ácido, Elétrico, Fogo, Gélido ou Trovejante: recebe resistência àquele tipo. Como parte da reação, pode realizar um ataque mágico à distância em alvo a 9 m (usa Sabedoria), causando dano igual ao dano que teria tomado. Uma vez por descanso curto ou longo."
      },
      {
        nome: "Toque de Fartura",
        descricao: "Ação bônus: toca criatura voluntária. Por 1 minuto: pv temporários = 3× o nível, bônus em testes de Força/resistências de Força = bônus de proficiência, e aumenta uma categoria de tamanho. Não funciona em construtos ou mortos-vivos. 5% de chance de se tornar permanente em animais. Uma vez por descanso longo."
      },
      {
        nome: "Colheita Mística",
        descricao: "Ação: conjura uma árvore em ponto visível a 9 m. A árvore tem 15 m de altura, raio de 3 m e produz 1d4/1d6/1d8/2d10/3d12 frutos por nível. Ação bônus: criatura toca a árvore e recebe fruto que recupera 10% da vida máxima, sacia e aplica Restauração Menor. Após os frutos acabarem, 5% de chance de permanecer (dá novos frutos a cada 3 meses); caso contrário murcha em 24 h."
      }
    ]
  },

  // ---------- GHOUL ----------
  {
    nome: "Ghoul",
    categoria: "mistica",
    tamanho: "medio",
    deslocamento: "9 m",
    //imagem: "assets/races/ghoul.jpg",
    descricao: "Não nasceram, foram forjados no desespero. Fusão de uma raça à beira da extinção com a essência da necromancia. Predadores espectrais que habitam as sombras em busca de saciar sua sede.",
    tracos: [
      "Aumento de Destreza +3 e Constituição +1",
      "Idade: maturidade aos 4 anos; vivem até 42 anos (quando a necromancia falha e o corpo se destrói)",
      "Alinhamento: maioria caótica e maligna",
      "Tamanho: mesmo porte que humanos — Médio",
      "Deslocamento: 9 m",
      "Visão no Escuro Superior: 36 metros",
      "Salto Aprimorado: distância de salto triplicada",
      "Resistência Necrótica: resistência a dano necrótico",
      "Essência Necrótica: imune a doenças e à condição Envenenado; não precisa comer/beber (mas precisa consumir sangue)",
      "Aranha Macabra: pode subir em superfícies verticais e tetos sem testes",
      "Garras do Desespero: ataques desarmados com garras causam dano cortante + 1d4 adicional",
      "Caçador do Medo: causa 1d4 de dano necrótico extra contra criaturas Amedrontadas",
      "Idiomas: Comum e um idioma à escolha"
    ],
    habilidades: [
      {
        nome: "Ferrão do Pavor",
        descricao: "Ação bônus: ataque com ferrão da cauda (1d8 de dano perfurante). O alvo faz teste de Sabedoria (CD 8 + proficiência + Con). Em falha: Amedrontado por 1 minuto (repete o teste ao fim de cada turno). Usos iguais ao bônus de proficiência por descanso longo."
      },
      {
        nome: "Sede de Sangue",
        descricao: "Ao causar dano com ataque corpo a corpo em criatura que não seja morto-vivo, construto ou planta, recupera pv iguais ao bônus de proficiência."
      }
    ]
  },

  // ---------- TIEFLINGS ----------
  {
    nome: "Tiefling (Diabo da Mente)",
    categoria: "mistica",
    tamanho: "medio",
    deslocamento: "9 m",
    //imagem: "assets/races/tiefling-mente.jpg",
    descricao: "Prole do Pacto Infernal marcada pela herança do Diabo da Mente. Especialistas em conexões telepáticas e leitura de intenções. Linhagem voltada ao controle psíquico.",
    tracos: [
      "Aumento de Carisma +3 e Inteligência +1",
      "Idade: amadurece como humanos, vive alguns anos a mais",
      "Tendência: natureza independente inclina à tendência caótica",
      "Tamanho: porte humano — Médio",
      "Deslocamento: 9 m",
      "Visão no Escuro Superior: 36 metros",
      "Resistência Infernal: resistência a dano de Fogo e Necrótico; vulnerabilidade a Radiante",
      "Resistência à Magia: vantagem em resistências contra magias de Inteligência, Sabedoria e Carisma",
      "Idiomas: Comum e Infernal"
    ],
    habilidades: [
      {
        nome: "Telepatia",
        descricao: "Ação bônus: escolhe criatura visível em 9 m. Vocês podem falar telepaticamente a até 1 km por nível. Ambos devem conhecer o idioma usado."
      },
      {
        nome: "Intuição Avançada",
        descricao: "Em testes de Intuição para detectar mentiras, é considerado proficiente e adiciona o dobro do bônus de proficiência."
      },
      {
        nome: "Leitura Mental",
        descricao: "A partir do 5º nível: conjura Detectar Pensamentos uma vez por descanso longo sem gastar espaço de magia. Carisma é o atributo de conjuração."
      }
    ]
  },

  {
    nome: "Tiefling (Diabo do Corpo)",
    categoria: "mistica",
    tamanho: "medio",
    deslocamento: "9 m",
    //imagem: "assets/races/tiefling-corpo.jpg",
    descricao: "Linhagem do Diabo do Corpo. Poder físico explosivo combinado com chamas infernais que transformam dor em força devastadora.",
    tracos: [
      "Aumento de Carisma +3 e Inteligência +1",
      "Idade: amadurece como humanos, vive alguns anos a mais",
      "Tendência: natureza independente inclina à tendência caótica",
      "Tamanho: porte humano — Médio",
      "Deslocamento: 9 m",
      "Visão no Escuro Superior: 36 metros",
      "Resistência Infernal: resistência a dano de Fogo e Necrótico; vulnerabilidade a Radiante",
      "Resistência à Magia: vantagem em resistências contra magias de Int, Sab e Car",
      "Idiomas: Comum e Infernal"
    ],
    habilidades: [
      {
        nome: "Chamas do Sangue",
        descricao: "Ao ser atingido por ataque corpo a corpo, pode liberar explosão de chamas em 3 m: dano de fogo igual ao nível. Cura-se em todo o dano causado. Recupera uso após descanso curto ou longo."
      },
      {
        nome: "Proeza Física",
        descricao: "Proficiência em Atletismo (especialização se já for proficiente)."
      },
      {
        nome: "Toque Infernal",
        descricao: "A partir do 5º nível: conjura Infligir Ferimentos (nível 2) uma vez por descanso longo sem gastar espaço. Carisma é o atributo de conjuração."
      }
    ]
  },

  {
    nome: "Tiefling (Diabo da Alma)",
    categoria: "mistica",
    tamanho: "medio",
    deslocamento: "9 m",
    //imagem: "assets/races/tiefling-alma.jpg",
    descricao: "Linhagem do Diabo da Alma. Mestres de encantamentos que controlam mentes e corações. Presença sedutora que atrai e desconcerta todos ao redor.",
    tracos: [
      "Aumento de Carisma +3 e Inteligência +1",
      "Idade: amadurece como humanos, vive alguns anos a mais",
      "Tendência: natureza independente inclina à tendência caótica",
      "Tamanho: porte humano — Médio",
      "Deslocamento: 9 m",
      "Visão no Escuro Superior: 36 metros",
      "Resistência Infernal: resistência a dano de Fogo e Necrótico; vulnerabilidade a Radiante",
      "Resistência à Magia: vantagem em resistências contra magias de Int, Sab e Car",
      "Idiomas: Comum e Infernal"
    ],
    habilidades: [
      {
        nome: "Favor do Encantador",
        descricao: "Criaturas encantadas por suas magias de Encantamento recebem bônus à escolha (CA, ataque ou resistências) igual à metade do bônus de proficiência. Dura enquanto o encantamento permanecer."
      },
      {
        nome: "Aura de Tentação",
        descricao: "Proficiência em Persuasão e Enganação (especialização em uma delas se já for proficiente)."
      },
      {
        nome: "Beijo Infernal",
        descricao: "A partir do 5º nível: conjura Enfeitiçar Pessoa (nível 2) uma vez por descanso longo sem gastar espaço. Em falha na resistência, pode causar 2d6 de dano psíquico adicional. Carisma é o atributo de conjuração."
      }
    ]
  },

  // ---------- SALADINS ----------
  {
    nome: "Saladins",
    categoria: "mistica",
    tamanho: "medio",
    deslocamento: "9 m",
    //imagem: "assets/races/saladins.jpg",
    descricao: "Originários de asteroides onde o Éter funciona como atmosfera densa. Curiosidade insaciável por tudo que é sólido. Suas histórias são tatuagens naturais que servem como brasões de linhagem.",
    tracos: [
      "Aumento de Inteligência +2 e Destreza +1",
      "Idade: adultos aos 20 anos, vivem até 250 anos",
      "Tamanho: ~1,8 m — Médio",
      "Deslocamento: 9 m + 9 m (escalada)",
      "Anatomia de Escalador: deslocamento de escalada 9 m; micro ventosas para paredes/tetos com mãos livres; vantagem em Atletismo para saltos",
      "Sexto Sentido Etéreo: proficiência em Arcanismo; com magia na cauda, sente outras magias em 18 m",
      "Resistência ao Éter: resistência a dano de Força",
      "Idiomas: Comum e Celestial"
    ],
    habilidades: [
      {
        nome: "Cauda de Conjunção",
        descricao: "Pode realizar componentes somáticos e verbais de magias usando apenas a cauda. Se cortada, regenera em 1d4 semanas."
      },
      {
        nome: "Mãos Mágicas Invisíveis",
        descricao: "Enquanto tiver magia armazenada na cauda, pode conjurar Mãos Mágicas como magia invisível. Alcance: 9m + 3m por nível da magia; carga: 2^nível em kg."
      },
      {
        nome: "Bateria e Sobrecarga de Éter",
        descricao: "Ao final de descanso longo, armazena um espaço de magia na cauda. Pode usá-lo para conjurar uma magia ou 'queimá-lo' para bônus em Ataque de Magia / CD de Resistência igual ao nível do espaço consumido."
      },
      {
        nome: "Imunidade de Ressonância",
        descricao: "Com magia armazenada na cauda, ganha imunidade a qualquer magia da mesma escola da armazenada, desde que a magia agressora seja de nível igual ou inferior."
      }
    ]
  },

  // ---------- VALDEKEANO ----------
  {
    nome: "Valdekeano",
    categoria: "mistica",
    tamanho: "medio",
    deslocamento: "9 m",
    //imagem: "assets/races/valdekeano.jpg",
    descricao: "Humanoides de intelecto brilhante e perigosa ambição. Fome extraordinária por conhecimento e arrogância ainda maior. Acreditam na própria superioridade sobre outras raças e deuses.",
    tracos: [
      "Aumento de Inteligência +3 e Sabedoria +1",
      "Idade: adultos aos 40 anos, vivem 250–300 anos",
      "Alinhamento: maioria leal e neutro; poucos malignos",
      "Tamanho: 1,80–2,00 m, menos de 60 kg — Médio",
      "Deslocamento: 9 m",
      "Astúcia Valdekeana: vantagem em resistências contra magias de Int, Sab e Car",
      "Mente Endurecida: resistência a dano psíquico (imunidade no 5º nível)",
      "Memória Perfeita: lembra-se de qualquer evento passado com detalhes perfeitos",
      "Precisão Incansável: proficiência em uma perícia e uma ferramenta à escolha; adiciona 1d4 a testes com elas",
      "Idiomas: Comum e quatro idiomas adicionais à escolha"
    ],
    habilidades: [
      {
        nome: "Telepatia",
        descricao: "Comunica-se telepaticamente com criaturas em 9 m (deve compartilhar idioma). Criaturas sem telepatia podem receber e responder, mas não iniciar."
      },
      {
        nome: "Troca de Memória",
        descricao: "Pode mostrar memórias a outras criaturas com um toque. Se não voluntário, faz teste de Carisma (CD 12 + mod Int do alvo). O alvo pode ver e memorizar completamente as memórias compartilhadas."
      },
      {
        nome: "Magia Profunda",
        descricao: "Conhece Mind Sliver. No 3º nível: Sussurros Dissonantes. No 5º nível: Detectar Pensamentos. Pode usar cada uma (nível 1+) um número de vezes igual ao bônus de proficiência por descanso longo. Sem componentes. Inteligência, Sabedoria ou Carisma (à escolha na criação) é o atributo de conjuração."
      }
    ]
  },

  // ==========================================
  //           RAÇAS SOBRENATURAIS
  // ==========================================

  // ---------- SILVESTRE ----------
  {
    nome: "Silvestre",
    categoria: "sobrenatural",
    tamanho: "medio",
    deslocamento: "12 m",
    //imagem: "assets/races/silvestre.jpg",
    descricao: "Mistura intrigante de humano e besta. Capazes de se transformar em predadores selvagens sob influência de uma maldição. A lua cheia é tanto dom quanto maldição.",
    tracos: [
      "Aumento de Força +2 e Destreza +2",
      "Idade: adultos aos 10 anos, raramente vivem mais de 70 anos",
      "Alinhamento: tende à neutralidade; amor por liberdade pode inclinar ao caótico",
      "Tamanho: acima de 1,90 m, mais de 125 kg — Médio",
      "Deslocamento: 12 m",
      "Ameaçador: proficiência em Intimidação",
      "Sentidos Aguçados: proficiência em Percepção; vantagem por olfato e audição",
      "Compleição Poderosa: conta como tamanho maior para carga, empurrar, erguer e agarrar",
      "Visão no Escuro Incomum: 18 m na penumbra como luz brilhante",
      "Idiomas: Comum e Silvestre"
    ],
    habilidades: [
      {
        nome: "Besta Fera",
        descricao: "A partir do 3º nível. Ação bônus: assume aparência bestial por 1 minuto (ou até morrer / cair a 0 pv / ser atingido por crítico com arma de prata). Efeitos: pv máximo temporariamente aumentado em 2 × (proficiência + nível); cresce uma categoria de tamanho; bônus em CA e ataques/dano corpo a corpo = metade do bônus de proficiência; desvantagem em testes de Inteligência; resistência a dano não mágico (exceto prata). Uma vez por descanso curto ou longo."
      },
      {
        nome: "Terror da Lua Cheia",
        descricao: "Em noite de lua cheia, ao entrar em contato com a luz da lua, transforma-se na Besta Fera até o fim da noite (ou 0 pv / crítico de prata). Torna-se extremamente agressivo e territorialista, incapaz de distinguir amigos de inimigos."
      }
    ]
  },

  // ---------- TRANSMORFO ----------
  {
    nome: "Transmorfo",
    categoria: "sobrenatural",
    tamanho: "medio",
    deslocamento: "9 m",
    //imagem: "assets/races/transmorfo.jpg",
    descricao: "Criaturas nascidas amaldiçoadas, nascidas de muitas formas. Ao nascer, assume a aparência da primeira pessoa vista, perdendo para sempre a chance de conhecer seu próprio rosto.",
    tracos: [
      "Aumento de Carisma +2 e Destreza ou Inteligência +2 (à escolha)",
      "Idade: envelhecem ligeiramente mais rápido que humanos; vivem ~um século",
      "Alinhamento: odeiam ser obrigados; muitos tendem à neutralidade pragmática; poucos abraçam o mal",
      "Tamanho: 1,50–1,80 m, constituição delgada — Médio",
      "Deslocamento: 9 m",
      "Mente Ardilosa: proficiência em Enganação",
      "Idiomas: Comum e mais um idioma à escolha"
    ],
    habilidades: [
      {
        nome: "Sussurro do Abismo",
        descricao: "Ação: sussurra desorientação a humanoide visível em 9 m. CD = 8 + proficiência + Car. Para cada ponto que o ND da criatura for menor que o nível do personagem, a CD aumenta em 1. Em falha: criatura cai no sono. Acordada por dano ou por alguém gastando uma ação para sacudi-la. Imune por 24 h após resistir ou ser acordada de forma não natural."
      },
      {
        nome: "Mudar Aparência",
        descricao: "Ação: transforma-se na aparência de qualquer humanoide tocado. Galeria de Ecos armazena 3× o nível em aparências. Pode armazenar nova aparência ao tocar um humanoide (substituindo uma existente). Roupas e equipamentos não mudam. Vantagem em Enganação para evitar detecção."
      },
      {
        nome: "Invasor de Consciência",
        descricao: "Ação: ao tocar humanoide dormindo, faz teste de Intuição. Em sucesso, aprende personalidade, comportamento, maneirismos e pensamento recente da criatura. Recebe dado bônus (1d4/1d6/1d8/1d12 com resultado 10–15/16–20/21–25/26–30) em testes de Enganação, Persuasão ou Atuação para se passar por ela."
      }
    ]
  },

  // ---------- OZZUS ----------
  {
    nome: "Ozzus",
    categoria: "sobrenatural",
    tamanho: "medio",
    deslocamento: "9 m",
    //imagem: "assets/races/ozzus.jpg",
    descricao: "Humanoides extraordinários de slimes adaptáveis com corpos amorfos. Pele lisa e reluzente em tons metálicos. Nascidos de metamorfoses mágicas que afetaram slimes muito antigos.",
    tracos: [
      "Aumento de Destreza +2 e Constituição +2",
      "Idade: não envelhecem fisicamente; dissolvem-se após ~1.000 anos de desgaste mental",
      "Tendência: neutros ou caóticos; priorizam liberdade e adaptabilidade",
      "Tamanho: ~1,8 m, ~60 kg — Médio",
      "Deslocamento: 9 m",
      "Aderência: vantagem em Atletismo para agarrar; pode escalar superfícies e tetos sem testes",
      "Corpo Gosmento: extensão de membros até 3× a altura natural (atinge alvos em 4,5 m); vantagem para resistir a Impedido; imune a Agarrado",
      "Deslizar Escorregadio: pode se comprimir por espaços de 5 cm (sem armadura média/pesada)",
      "Forma Adaptável: ação bônus para criar ferramentas simples (cordas, ganchos, chaves improvisadas)",
      "Resistência à Queda: reduz dano de queda pela metade (se consciente)",
      "Visão no Escuro Incomum: 18 m na penumbra como luz brilhante",
      "Sintonia Alquímica: proficiência com ferramentas de alquimista + dobro do bônus em identificação de substâncias/venenos/poções",
      "Idiomas: Comum"
    ],
    habilidades: [
      {
        nome: "Rebote Flexível",
        descricao: "Reação ao ser atingido por ataque corpo a corpo: reduz o dano em 1d6 + modificador de Constituição e pode se mover até 3 m sem provocar ataques de oportunidade."
      }
    ]
  },

  // ---------- WARFORGED ----------
  {
    nome: "Warforged (Servo)",
    categoria: "sobrenatural",
    tamanho: "medio",
    deslocamento: "9 m",
    //imagem: "assets/races/warforged-servo.jpg",
    descricao: "Construto vivo criado para versatilidade e suporte. Especializado em auxiliar aliados e realizar tarefas específicas com precisão incomparável.",
    tracos: [
      "Aumento de Constituição +2 e duas habilidades à escolha +1 cada",
      "Idade: 10–20 anos; sem sinais de deterioração por idade",
      "Alinhamento: tendem à lei e neutralidade",
      "Tamanho: 2 m, 300 kg — Médio",
      "Construto Vivo: imune a envenenamento e doenças não mágicas; resistência a veneno; não precisa de comida/água/sono/ar; recupera metade dos pv de magias de cura",
      "Descanso do Insone: não dorme; obtém benefícios de descanso longo em 8 h de atividade leve",
      "Anatomia Artificial: não recupera pv automaticamente em descanso longo; usa Kit de Reparo de Warforged. Proficiente com o kit (incluído na criação)",
      "Proteção Integrada: CA determinada pelo modo defensivo escolhido após descanso longo",
      "Idiomas: Comum e dois idiomas adicionais à escolha"
    ],
    habilidades: [
      {
        nome: "Design Especializado",
        descricao: "Proficiência em uma perícia, uma ferramenta (kit de erbalismo, ferramentas de ferreiro, instrumento musical, etc.) e um idioma adicional."
      },
      {
        nome: "Mestre da Assistência",
        descricao: "Ao usar a ação de Ajudar, a criatura beneficiada ganha bônus adicional igual ao bônus de proficiência na rolagem de ataque ou teste de habilidade."
      },
      {
        nome: "Ferramentas Integradas",
        descricao: "Escolhe uma ferramenta com proficiência. Pode usá-la sem precisar segurá-la (integrada ao corpo). Dobra o bônus de proficiência com essa ferramenta."
      },
      {
        nome: "Modo de Serviço",
        descricao: "Em descanso curto, pode realizar tarefa utilitária (consertar equipamentos, cozinhar, preparar armadilha) sem perder os benefícios do descanso."
      }
    ]
  },

  {
    nome: "Warforged (Colosso)",
    categoria: "sobrenatural",
    tamanho: "medio",
    deslocamento: "9 m",
    //imagem: "assets/races/warforged-colosso.jpg",
    descricao: "Construto vivo construído para resistência e poder bruto. Quase inamovível, avança incansavelmente para batalha onde outros cairiam.",
    tracos: [
      "Aumento de Constituição +2 e Força +2",
      "Tamanho: 2 m, 300 kg — Médio",
      "Construto Vivo: imune a envenenamento e doenças não mágicas; resistência a veneno; sem necessidades biológicas; recupera metade dos pv de cura",
      "Descanso do Insone: não dorme; 8 h de atividade leve = descanso longo",
      "Anatomia Artificial: não recupera pv automaticamente; usa Kit de Reparo",
      "Proteção Integrada: CA definida pelo modo defensivo",
      "Corpo de Colosso: pv máximo +1; por nível + metade do bônus de proficiência (mínimo 1)",
      "Corpo Pesado: vantagem para evitar ser empurrado, derrubado ou deslocado; reduz dano de queda pela metade",
      "Construção Poderosa: conta como tamanho maior para capacidade de carga",
      "Idiomas: Comum"
    ],
    habilidades: [
      {
        nome: "Construção Sólida",
        descricao: "No início de cada turno (com pelo menos 1 pv), ganha pv temporários iguais ao bônus de proficiência."
      },
      {
        nome: "Corpo Resiliente",
        descricao: "Reduz todo dano Cortante, Perfurante e Contundente em um valor igual ao bônus de proficiência. Aplica-se antes de qualquer resistência."
      }
    ]
  },

  {
    nome: "Warforged (Sentinela)",
    categoria: "sobrenatural",
    tamanho: "medio",
    deslocamento: "9 m",
    //imagem: "assets/races/warforged-sentinela.jpg",
    descricao: "Construto vivo otimizado para vigilância e proteção ativa de aliados. Escudo integrado que funciona tanto como defesa quanto como arma.",
    tracos: [
      "Aumento de Constituição +2 e Destreza +2",
      "Tamanho: 2 m, 300 kg — Médio",
      "Construto Vivo: imune a envenenamento e doenças não mágicas; resistência a veneno; sem necessidades biológicas; recupera metade dos pv de cura",
      "Descanso do Insone: não dorme; 8 h de atividade leve = descanso longo",
      "Anatomia Artificial: não recupera pv automaticamente; usa Kit de Reparo",
      "Proteção Integrada: CA definida pelo modo defensivo",
      "Vigilância: vantagem em Percepção para detecção de perigos",
      "Idiomas: Comum"
    ],
    habilidades: [
      {
        nome: "Escudo Integrado",
        descricao: "Ação bônus: integra escudo especial a uma das mãos. Concede +1 adicional à CA além do bônus normal de escudo. Pode usá-lo como arma (1d6 de dano contundente). Ao atingir uma criatura de tamanho igual ou menor, pode empurrá-la 1,5 m."
      },
      {
        nome: "Proteção Instintiva",
        descricao: "Uma vez por descanso curto: reação para interpor o escudo entre aliado em 1,5 m e um ataque sofrido, concedendo +2 de CA contra aquele ataque."
      }
    ]
  }

];

// ========================================
// UTILITÁRIO: filtrar por categoria
// ========================================
function getRacasPorCategoria(categoria) {
  return RACAS_DATA.filter(r => r.categoria === categoria);
}
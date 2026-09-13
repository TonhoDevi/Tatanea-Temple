<template>
  <ClassePaginaLayout :classe="classe">
    <div class="dc-section">
      <div class="dc-section-title-row">
        <h2 class="dc-section-title">Descrição</h2>
        <span class="dc-title-line"></span>
      </div>
      <div class="dc-descricao-colunas">
        <div class="dc-descricao-bloco" v-for="(bloco, bi) in descricaoBlocos" :key="bi">
          <h3 v-if="bloco.titulo" class="dc-subtitulo">{{ bloco.titulo }}</h3>
          <p v-for="(par, pi) in bloco.paragrafos" :key="pi" class="dc-texto-corpo">{{ par }}</p>
        </div>
      </div>
    </div>

    <div class="dc-section">
      <div class="dc-section-title-row">
        <h2 class="dc-section-title">Progressão — O Ladino</h2>
        <span class="dc-title-line"></span>
      </div>
      <div class="dc-tabela-wrap">
        <table class="dc-tabela-niveis">
          <thead>
            <tr>
              <th>Nível</th>
              <th>Características</th>
              <th class="dc-th-centro">Ataque Furtivo</th>
            </tr>
          </thead>
          <tbody>
            <tr v-for="n in niveis" :key="n.nivel">
              <td class="dc-tabela-nivel">{{ n.nivel }}º</td>
              <td class="dc-tabela-carac">{{ n.caracteristicas }}</td>
              <td class="dc-tabela-bonus">{{ n.ataqueFurtivo }}</td>
            </tr>
          </tbody>
        </table>
      </div>
    </div>

    <div class="dc-section">
      <div class="dc-section-title-row">
        <h2 class="dc-section-title">Fundamentos da Classe</h2>
        <span class="dc-title-line"></span>
      </div>
      <p class="dc-fundamentos-nota">Regras comuns a toda classe — não são exclusivas do Ladino.</p>

      <div class="dc-vida-card">
        <div class="dc-vida-dado">
          <span class="dc-categoria-corner dc-categoria-corner-tl"></span>
          <span class="dc-categoria-corner dc-categoria-corner-tr"></span>
          <span class="dc-categoria-corner dc-categoria-corner-bl"></span>
          <span class="dc-categoria-corner dc-categoria-corner-br"></span>
          <span class="dc-categoria-bracket dc-categoria-bracket-tl"></span>
          <span class="dc-categoria-bracket dc-categoria-bracket-tr"></span>
          <span class="dc-categoria-bracket dc-categoria-bracket-bl"></span>
          <span class="dc-categoria-bracket dc-categoria-bracket-br"></span>
          <span class="dc-vida-dado-valor">
            <span class="dc-vida-dado-prefixo">{{ vida.prefixo }}</span><span class="dc-vida-dado-numero">{{ vida.numero }}</span>
          </span>
          <span class="dc-vida-dado-label">Dado de Vida</span>
        </div>
        <div class="dc-vida-stats">
          <div class="dc-vida-stat">
            <span class="dc-vida-stat-label">PV no 1º Nível</span>
            <span class="dc-vida-stat-valor">{{ vida.nivel1 }}</span>
          </div>
          <div class="dc-vida-stat">
            <span class="dc-vida-stat-label">PV por Nível Adicional</span>
            <span class="dc-vida-stat-valor">{{ vida.niveisSuperiores }}</span>
          </div>
        </div>
        <div class="dc-vida-icone">
          <IconeVida />
        </div>
      </div>

      <div class="dc-prof-lista">
        <div class="dc-prof-linha dc-prof-linha-com-icone" v-for="p in proficiencias" :key="p.titulo">
          <div class="dc-prof-linha-conteudo">
            <span class="dc-prof-titulo">{{ p.titulo }}<span v-if="p.nota" class="dc-prof-nota"> · {{ p.nota }}</span></span>
            <div v-if="p.estilo === 'selos'" class="dc-atributo-selos">
              <div class="dc-atributo-selo" v-for="item in p.itens" :key="item">
                <span class="dc-atributo-selo-corner dc-atributo-selo-corner-tl"></span>
                <span class="dc-atributo-selo-corner dc-atributo-selo-corner-tr"></span>
                <span class="dc-atributo-selo-corner dc-atributo-selo-corner-bl"></span>
                <span class="dc-atributo-selo-corner dc-atributo-selo-corner-br"></span>
                <span class="dc-atributo-sigla">{{ item.slice(0, 3).toUpperCase() }}</span>
                <span class="dc-atributo-nome">{{ item }}</span>
              </div>
            </div>
            <div v-else class="dc-chip-row">
              <span class="dc-chip" v-for="item in p.itens" :key="item">{{ item }}</span>
            </div>
          </div>
          <div class="dc-prof-icone">
            <component :is="p.icone" />
          </div>
        </div>

        <div class="dc-prof-linha dc-prof-linha-com-icone">
          <div class="dc-prof-linha-conteudo">
            <span class="dc-prof-titulo">Proficiências de Equipamento</span>
            <div class="dc-prof-subgrupos">
              <div class="dc-prof-subgrupo" v-for="pe in proficienciasEquipamento" :key="pe.titulo">
                <span class="dc-prof-subtitulo">{{ pe.titulo }}</span>
                <div class="dc-chip-row">
                  <span class="dc-chip" v-for="item in pe.itens" :key="item">{{ item }}</span>
                </div>
              </div>
            </div>
          </div>
          <div class="dc-prof-icone">
            <IconeProficienciaEquipamento />
          </div>
        </div>
      </div>

      <div class="dc-equip-card">
        <div class="dc-equip-conteudo">
          <span class="dc-equip-titulo">Equipamento</span>
          <p class="dc-equip-intro">{{ equipamento.intro }}</p>
          <div class="dc-equip-lista">
            <div class="dc-equip-item" v-for="(it, ii) in equipamento.itens" :key="ii">
              <template v-for="(op, oi) in it.opcoes" :key="oi">
                <span v-if="oi > 0" class="dc-equip-ou">ou</span>
                <span class="dc-chip">{{ op }}</span>
              </template>
            </div>
          </div>
        </div>
        <div class="dc-equip-icone">
          <IconeEquipamento />
        </div>
      </div>

      <div class="dc-fundamentos-grid">
        <div class="dc-fundamento dc-fundamento-largo dc-fundamento-com-icone">
          <div class="dc-fundamento-conteudo">
            <span class="dc-fundamento-titulo">{{ incrementoHabilidade.titulo }}</span>
            <p class="dc-fundamento-corpo">{{ incrementoHabilidade.corpo }}</p>
          </div>
          <div class="dc-fundamento-icone">
            <IconeIncremento />
          </div>
        </div>

        <div class="dc-fundamento dc-fundamento-largo dc-fundamento-com-icone">
          <div class="dc-fundamento-conteudo">
            <span class="dc-fundamento-titulo">{{ talento.titulo }}</span>
            <p class="dc-fundamento-corpo">{{ talento.corpo }}</p>
            <div class="dc-niveis-corrente">
              <div class="dc-niveis-corrente-no" v-for="(n, i) in talento.niveis" :key="n">
                <span class="dc-niveis-corrente-cordao" v-if="i > 0"></span>
                <span class="dc-niveis-corrente-circulo">{{ n }}º</span>
              </div>
            </div>
          </div>
          <div class="dc-fundamento-icone">
            <IconeTalento />
          </div>
        </div>

        <div class="dc-fundamento dc-fundamento-largo dc-fundamento-com-icone">
          <div class="dc-fundamento-conteudo">
            <span class="dc-fundamento-titulo">{{ subclasseEscolha.titulo }}</span>
            <p class="dc-fundamento-corpo">{{ subclasseEscolha.corpo }}</p>
            <div class="dc-subclasse-opcoes">
              <div class="dc-subclasse-opcao" v-for="op in subclasseEscolha.opcoes" :key="op.nome">
                <span class="dc-atributo-selo-corner dc-atributo-selo-corner-tl"></span>
                <span class="dc-atributo-selo-corner dc-atributo-selo-corner-tr"></span>
                <span class="dc-atributo-selo-corner dc-atributo-selo-corner-bl"></span>
                <span class="dc-atributo-selo-corner dc-atributo-selo-corner-br"></span>
                <span class="dc-subclasse-opcao-icone">{{ op.icone }}</span>
                <span class="dc-subclasse-opcao-nome">{{ op.nome }}</span>
              </div>
            </div>
          </div>
          <div class="dc-fundamento-icone">
            <IconeSubclasse />
          </div>
        </div>
      </div>
    </div>

    <div class="dc-section">
      <div class="dc-section-title-row">
        <h2 class="dc-section-title">Características da Classe</h2>
        <span class="dc-title-line"></span>
      </div>
      <div class="dc-hab-lista">
        <div class="dc-hab-item" v-for="(c, i) in caracteristicas" :key="i">
          <button class="dc-hab-cabecalho" @click="alternarCaracteristica(i)">
            <span class="dc-hab-seta">{{ caracteristicasAbertas[i] === false ? '▸' : '▾' }}</span>
            <span class="dc-hab-nivel">Nv. {{ c.nivel }}</span>
            <span class="dc-hab-nome">{{ c.titulo }}</span>
          </button>
          <template v-if="caracteristicasAbertas[i] !== false">
            <p v-if="c.corpo" class="dc-hab-descricao" v-html="c.corpo"></p>
            <div v-if="c.tabela" class="dc-hab-tabela">
              <div class="dc-tabela-wrap">
                <table class="dc-tabela-niveis">
                  <thead>
                    <tr>
                      <th>{{ c.tabela.colunaA }}</th>
                      <th>{{ c.tabela.colunaB }}</th>
                    </tr>
                  </thead>
                  <tbody>
                    <tr v-for="linha in c.tabela.linhas" :key="linha.a">
                      <td class="dc-tabela-carac">{{ linha.a }}</td>
                      <td class="dc-tabela-carac" v-html="linha.b"></td>
                    </tr>
                  </tbody>
                </table>
              </div>
            </div>
            <p v-if="c.notaFinal" class="dc-hab-descricao" v-html="c.notaFinal"></p>
          </template>
        </div>
      </div>
    </div>

    <div class="dc-section">
      <div class="dc-section-title-row">
        <h2 class="dc-section-title">Subclasses</h2>
        <span class="dc-title-line"></span>
      </div>

      <div class="dc-subclasse" v-for="(s, si) in subclasses" :key="s.nome">
        <div class="dc-subclasse-cabecalho">
          <div class="dc-subclasse-icone-moldura">
            <span class="dc-atributo-selo-corner dc-atributo-selo-corner-tl"></span>
            <span class="dc-atributo-selo-corner dc-atributo-selo-corner-tr"></span>
            <span class="dc-atributo-selo-corner dc-atributo-selo-corner-bl"></span>
            <span class="dc-atributo-selo-corner dc-atributo-selo-corner-br"></span>
            <span class="dc-subclasse-icone">{{ s.icone }}</span>
          </div>
          <h3 class="dc-subclasse-nome">{{ s.nome }}</h3>
        </div>

        <p class="dc-texto-corpo">{{ s.introTexto }}</p>

        <div class="dc-hab-lista">
          <div class="dc-hab-item" v-for="(c, ci) in s.caracteristicas" :key="ci">
            <button class="dc-hab-cabecalho" @click="alternarSubclasse(chaveSub(si, ci))">
              <span class="dc-hab-seta">{{ subclasseAbertas[chaveSub(si, ci)] === false ? '▸' : '▾' }}</span>
              <span class="dc-hab-nivel">Nv. {{ c.nivel }}</span>
              <span class="dc-hab-nome">{{ c.titulo }}</span>
            </button>
            <p v-if="subclasseAbertas[chaveSub(si, ci)] !== false" class="dc-hab-descricao" v-html="c.corpo"></p>
          </div>
        </div>
      </div>
    </div>
  </ClassePaginaLayout>
</template>

<script setup>
import { markRaw, ref } from 'vue';
import ClassePaginaLayout from './ClassePaginaLayout.vue';
import IconeVida from './icones/IconeVida.vue';
import IconeResistencia from './icones/IconeResistencia.vue';
import IconePericias from './icones/IconePericias.vue';
import IconeIncremento from './icones/IconeIncremento.vue';
import IconeTalento from './icones/IconeTalento.vue';
import IconeEquipamento from './icones/IconeEquipamento.vue';
import IconeProficienciaEquipamento from './icones/IconeProficienciaEquipamento.vue';
import IconeSubclasse from './icones/IconeSubclasse.vue';

const classe = {
  nome: 'Ladino',
  subtitulo: 'Nas sombras, a astúcia é mais afiada que qualquer lâmina, e a oportunidade sorri para aqueles que sabem quando atacar.',
  icone: '🗡️',
  cor: '#4a7a8c',
  dadoDeVida: 'd6',
  dificuldade: 'Intermediário',
  papeis: ['Dano', 'Furtividade', 'Suporte', 'Exploração'],
};

const descricaoBlocos = [
  {
    titulo: null,
    paragrafos: [
      'Sinalizando para seus companheiros esperarem, um pequenino caminha lentamente pelo corredor da masmorra. Ele pressiona seu ouvido junto à porta, então puxa um conjunto de ferramentas e destrava a tranca em um piscar de olhos. Em seguida, ele desaparece entre as sombras quando seu amigo guerreiro avança para chutar a porta e abri-la.',
      'Uma humana se esconde entre as sombras de um beco enquanto seu cúmplice se prepara para a parte dela na emboscada. Quando o seu alvo — um notório traficante de escravos — passa em frente ao beco, o cúmplice solta um grito, o traficante vem investigar e a lâmina do assassino corta seu pescoço antes que ele possa fazer qualquer barulho.',
      'Suprimindo uma risada, uma gnoma mexe seus dedos e magicamente levanta o molho de chaves da cintura do guarda. Em um momento, as chaves estão em sua mão, a porta da cela está aberta e ela e seus companheiros estão livres para fazer sua escapatória.',
      'Ladinos contam com sua perícia, furtividade e as vulnerabilidades de seus inimigos para obter vantagem em qualquer situação. Eles possuem uma habilidade especial para encontrar a solução para praticamente qualquer problema, demonstrando desenvoltura e versatilidade, a pedra angular de qualquer grupo de aventureiros de sucesso.',
    ],
  },
  {
    titulo: 'Perícia e Precisão',
    paragrafos: [
      'Ladinos devotam tanto esforço no domínio de uma variedade de perícias tanto quanto no aperfeiçoamento de suas habilidades em combate, concedendo a eles uma vasta especialização de que poucos outros personagens podem alcançar. Muitos ladinos focam na furtividade e enganação, enquanto outros refinam suas perícias para ajudá-los em um ambiente de masmorra, como escalar, encontrar e desarmar armadilhas e abrir fechaduras.',
      'Quando o assunto é combate, ladinos priorizam astúcia ao invés de força bruta. Um ladino preferirá fazer um ataque preciso, colocando-o exatamente onde o golpe machucará mais o alvo, do que derrubar um oponente com uma barragem de ataques. Ladinos possuem uma habilidade quase sobrenatural de evitar o perigo e alguns poucos aprendem truques de magia para incrementar suas outras habilidades.',
    ],
  },
  {
    titulo: 'Uma Vida Sombria',
    paragrafos: [
      'Todo vilarejo e cidade possui sua cota de ladinos. A maioria deles vive de acordo com as piores estereótipos da classe, ganhando a vida como assaltantes, assassinos, batedores de carteira e vigaristas. Frequentemente, esses canalhas são organizados em guildas de ladrões ou famílias do crime. Muitos ladinos operam independentemente, mas mesmo eles, às vezes, recrutam aprendizes para ajudá-los em seus golpes e empreitadas. Alguns poucos ladinos levam uma vida honesta como chaveiros, investigadores ou exterminadores, trabalho que pode ser perigoso em um mundo onde ratos gigantes — e lobisomens — assombram os esgotos.',
      'Como aventureiros, ladinos caem nos dois lados da lei. Alguns são criminosos endurecidos que decidem procurar sua sorte em tesouros, enquanto outros tomam uma vida de aventuras para escapar da lei. Alguns aprenderam e aperfeiçoaram suas perícias com o propósito de infiltrar em ruínas antigas e criptas escondidas em busca de tesouros.',
    ],
  },
];

const vida = {
  prefixo: 'd',
  numero: '6',
  nivel1: '6 + seu bônus de Salvaguarda de Constituição + 1',
  niveisSuperiores: '6 + seu bônus de Salvaguarda de Constituição por nível de ladino após o 1°',
};

const proficiencias = [
  { titulo: 'Testes de Resistência', itens: ['Destreza', 'Inteligência'], estilo: 'selos', icone: markRaw(IconeResistencia) },
  {
    titulo: 'Perícias',
    nota: 'escolha quatro',
    itens: ['Acrobacia', 'Atletismo', 'Atuação', 'Enganação', 'Furtividade', 'Intimidação', 'Intuição', 'Investigação', 'Percepção', 'Persuasão', 'Prestidigitação'],
    icone: markRaw(IconePericias),
  },
];

const proficienciasEquipamento = [
  { titulo: 'Armadura', itens: ['Armaduras leves'] },
  { titulo: 'Armas', itens: ['Armas simples', 'Bestas de mão', 'Espadas longas', 'Rapieiras', 'Espadas curtas'] },
  { titulo: 'Ferramentas', itens: ['Ferramentas de ladrão'] },
];

const equipamento = {
  intro: 'Você começa com o seguinte equipamento, além do equipamento concedido pelo seu antecedente:',
  itens: [
    { opcoes: ['Uma rapieira', 'Uma espada longa'] },
    { opcoes: ['Um arco curto e uma aljava com 20 flechas', 'Uma espada curta'] },
    { opcoes: ['Um pacote de assaltante', 'Um pacote de aventureiro', 'Um pacote de explorador'] },
    { opcoes: ['Armadura de couro, duas adagas e ferramentas de ladrão'] },
  ],
};

const incrementoHabilidade = {
  titulo: 'Incremento no Valor de Habilidade',
  corpo: 'A cada nível, você pode aumentar um valor de habilidade, à sua escolha, em 1. Como padrão você não pode aumentar um valor de habilidade acima de 20, esse limite aumenta para 26 assim que o personagem alcançar o 10° nível.',
};

const talento = {
  titulo: 'Talento',
  corpo: 'Você recebe um talento adicional nos níveis:',
  niveis: [1, 5, 10, 15, 20],
};

const niveis = [
  { nivel: 1, ataqueFurtivo: '1d6', caracteristicas: 'Especialização, Ataque Furtivo, Talento' },
  { nivel: 2, ataqueFurtivo: '2d6', caracteristicas: 'Ação Ardilosa' },
  { nivel: 3, ataqueFurtivo: '3d6', caracteristicas: 'Arquétipo de Ladino' },
  { nivel: 4, ataqueFurtivo: '4d6', caracteristicas: '-' },
  { nivel: 5, ataqueFurtivo: '5d6', caracteristicas: 'Esquiva Sobrenatural, Talento' },
  { nivel: 6, ataqueFurtivo: '7d6', caracteristicas: 'Especialização (adicional)' },
  { nivel: 7, ataqueFurtivo: '8d6', caracteristicas: 'Evasão' },
  { nivel: 8, ataqueFurtivo: '9d6', caracteristicas: '-' },
  { nivel: 9, ataqueFurtivo: '10d6', caracteristicas: 'Característica de Arquétipo, Talento Confiável' },
  { nivel: 10, ataqueFurtivo: '12d6', caracteristicas: 'Talento' },
  { nivel: 11, ataqueFurtivo: '13d6', caracteristicas: 'Sentido Cego' },
  { nivel: 12, ataqueFurtivo: '14d6', caracteristicas: '-' },
  { nivel: 13, ataqueFurtivo: '15d6', caracteristicas: 'Característica de Arquétipo, Golpe Fantasma' },
  { nivel: 14, ataqueFurtivo: '16d6', caracteristicas: '-' },
  { nivel: 15, ataqueFurtivo: '17d6', caracteristicas: 'Mente Escorregadia, Talento' },
  { nivel: 16, ataqueFurtivo: '19d6', caracteristicas: '-' },
  { nivel: 17, ataqueFurtivo: '20d6', caracteristicas: 'Característica de Arquétipo' },
  { nivel: 18, ataqueFurtivo: '21d6', caracteristicas: 'Elusivo' },
  { nivel: 19, ataqueFurtivo: '22d6', caracteristicas: 'Lendário' },
  { nivel: 20, ataqueFurtivo: '25d6', caracteristicas: 'Golpe de Sorte, Talento' },
];

const caracteristicas = [
  {
    nivel: 1,
    titulo: 'Especialização',
    corpo: `No 1º nível, você escolhe duas de suas perícias que seja proficiente, ou uma perícia que seja proficiente e ferramentas de ladrão. Seu bônus de proficiência é dobrado em qualquer teste de habilidade que fizer com elas.
No 6º nível, você pode escolher outras duas de suas proficiências (em perícias ou ferramentas de ladrão) para ganhar esse benefício.`,
  },
  {
    nivel: 1,
    titulo: 'Ataque Furtivo',
    corpo: `A partir do 1º nível, você sabe como atacar sutilmente e explorar a distração de seus inimigos. Uma vez por turno, você pode adicionar 1d6 nas jogadas de dano contra qualquer criatura que acertar, desde que tenha <span class="dc-termo">vantagem</span> nas jogadas de ataque. O ataque deve ser com uma arma de acuidade ou à distância.
Você não precisa ter <span class="dc-termo">vantagem</span> nas jogadas de ataque se outro inimigo do seu alvo estiver a 1,5 metro de distância dele, desde que este inimigo não esteja incapacitado e você não tenha <span class="dc-termo">desvantagem</span> nas jogadas de ataque.
A quantidade de dano extra aumenta conforme você ganha níveis nesta classe, como mostrado na coluna <span class="dc-termo">Ataque Furtivo</span> da tabela O Ladino.`,
  },
  {
    nivel: 2,
    titulo: 'Ação Ardilosa',
    corpo: 'A partir do 2º nível, seu pensamento rápido e agilidade faz você se mover e agir rapidamente. Você pode usar uma <span class="dc-termo">ação bônus</span> durante cada um de seus turnos em combate. Esta ação pode ser usada somente para <span class="dc-termo">ação de Disparada</span>, <span class="dc-termo">Desengajar</span> ou Esconder.',
  },
  {
    nivel: 5,
    titulo: 'Esquiva Sobrenatural',
    corpo: 'A partir do 5º nível, quando um inimigo que você possa ver o acerta com um ataque, você pode usar sua reação para reduzir pela metade o dano sofrido.',
  },
  {
    nivel: 7,
    titulo: 'Evasão',
    corpo: 'A partir do 7º nível, você pode esquivar-se agilmente de certos efeitos em área, como o sopro flamejante de um dragão vermelho ou uma magia tempestade de gelo. Quando você for alvo de um efeito que exige um teste de resistência de <span class="dc-termo">Destreza</span> para sofrer metade do dano, você não sofre dano algum se passar, e somente metade do dano se falhar.',
  },
  {
    nivel: 9,
    titulo: 'Talento Confiável',
    corpo: 'No 9º nível, você refinou suas perícias beirando à perfeição. Toda vez que você fizer um teste de habilidade no qual possa adicionar seu bônus de proficiência, você trata um resultado no d20 de 9 ou menor como um 10.',
  },
  {
    nivel: 11,
    titulo: 'Sentido Cego',
    corpo: 'No 11º nível, se você for capaz de ouvir, você está ciente da localização de qualquer criatura escondida ou invisível a até 9 metros de você.',
  },
  {
    nivel: 13,
    titulo: 'Golpe Fantasma',
    corpo: `A partir do 13º nível, você aprende a atacar com precisão quase sobrenatural, explorando fraquezas antes que seu alvo perceba o perigo.
Quando você realiza um <span class="dc-termo">ataque furtivo</span>, pode escolher transformar esse ataque em um <span class="dc-termo">Golpe Fantasma</span>. Este golpe causa metade do dano, mas ignora qualquer tipo de resistência ou imunidade ao dano do ataque. Além disso, o alvo sofre um efeito debilitante que dura até o início do seu próximo turno. Escolha um dos seguintes efeitos:`,
    tabela: {
      colunaA: 'Efeito',
      colunaB: 'Resultado',
      linhas: [
        { a: 'Desarme', b: 'A criatura é forçada a soltar um objeto que esteja segurando.' },
        { a: 'Abalado', b: 'A criatura tem <span class="dc-termo">desvantagem</span> em ataques contra você até o início do seu próximo turno.' },
        { a: 'Paralisado', b: 'A velocidade de <span class="dc-termo">deslocamento</span> da criatura é reduzida pela metade até o início do seu próximo turno.' },
      ],
    },
    notaFinal: 'Você pode usar o <span class="dc-termo">Golpe Fantasma</span> um número de vezes igual ao seu bônus de proficiência, recuperando todos os usos após um <span class="dc-termo">descanso longo</span>.',
  },
  {
    nivel: 15,
    titulo: 'Mente Escorregadia',
    corpo: 'No 15º nível, você adquire uma grande força de vontade, adquirindo proficiência nos testes de resistência de <span class="dc-termo">Sabedoria</span>.',
  },
  {
    nivel: 18,
    titulo: 'Elusivo',
    corpo: 'A partir do 18º nível, você se torna tão sagaz que raramente alguém encosta a mão em você. Nenhuma jogada de ataque tem <span class="dc-termo">vantagem</span> contra você, desde que você não esteja incapacitado.',
  },
  {
    nivel: 19,
    titulo: 'Lendário',
    corpo: 'Ao atingir o 19°, você pode escolher um <span class="dc-termo">talento</span> épico.',
  },
  {
    nivel: 20,
    titulo: 'Golpe de Sorte',
    corpo: `No 20º nível, você adquire um dom incrível para ter sucesso nos momentos em que mais precisa. Se um ataque seu falhar contra um alvo ao seu alcance, você pode transformar essa falha em um acerto. Ou se falhar em um teste qualquer, você pode tratar a jogada desse mesmo teste como 20 natural.
Uma vez que você use essa característica, você não pode fazê-lo de novo até terminar um <span class="dc-termo">descanso curto</span> ou <span class="dc-termo">descanso longo</span>.`,
  },
];

const subclasses = [
  {
    nome: 'Assassino',
    icone: '💀',
    introTexto: 'Você concentra seu treinamento na sombria arte da morte. Aqueles que seguem essa arquétipo são diversos: assassinos contratados, espiões, caçadores de recompensas e até mesmo sacerdotes especialmente ungidos, treinados para exterminar os inimigos de sua divindade. Furtividade, veneno e disfarce ajudam você a eliminar seus inimigos com eficiência mortal.',
    caracteristicas: [
      { nivel: 3, titulo: 'Proficiências Extras', corpo: 'Quando você escolhe esse arquétipo no 3º nível, você ganha proficiência com o kit de disfarce e o kit de envenenador.' },
      { nivel: 3, titulo: 'Assassinar', corpo: 'A partir do 3º nível, você é mais mortal quando pega seus inimigos de surpresa. Você tem <span class="dc-termo">vantagem</span> em rolagens de ataque contra qualquer criatura que ainda não tenha tido um turno no combate. Além disso, qualquer acerto que você conseguir contra uma criatura que esteja surpresa é um acerto crítico.' },
      { nivel: 9, titulo: 'Expertise em Infiltração', corpo: 'A partir do 9º nível, você consegue criar falsas identidades sem falhas. Você deve passar sete dias e gastar 25 peças de ouro para estabelecer a história, profissão e afiliações de uma identidade. Você não pode estabelecer uma identidade que pertença a outra pessoa. Por exemplo, você pode adquirir roupas apropriadas, cartas de apresentação e certificações com aparência oficial para se estabelecer como membro de uma casa comercial de uma cidade remota, assim pode se inserir na companhia de outros mercadores ricos. Depois disso, se você adotar a nova identidade como disfarce, outras criaturas acreditam que você é aquela pessoa até que tenham um motivo óbvio para duvidar disso.' },
      { nivel: 13, titulo: 'Impostor', corpo: `No 13º nível, você ganha a habilidade de imitar sem erro o discurso, escrita e comportamento de outra pessoa. Você deve passar pelo menos três horas estudando esses três componentes do comportamento da pessoa, ouvindo seu discurso, examinando a caligrafia e observando os maneirismos.
Sua fraude é indiscernível para o observador casual. Se uma criatura cautelosa suspeitar de algo errado, você tem <span class="dc-termo">vantagem</span> em qualquer teste de Carisma (Enganação) que você fizer para evitar detecção.` },
      { nivel: 17, titulo: 'Golpe Mortal', corpo: 'A partir do 17º nível, você se torna um mestre da morte instantânea. Quando você ataca e acerta uma criatura que está surpresa, ela deve fazer um teste de resistência de <span class="dc-termo">Constituição</span> (CD 8 + seu modificador de <span class="dc-termo">Destreza</span> + seu bônus de proficiência). Em caso de falha, dobre o dano do seu ataque contra a criatura.' },
    ],
  },
  {
    nome: 'Inquisidor',
    icone: '🔍',
    introTexto: 'Como um Inquisidor arquetípico, você se destaca em descobrir segredos e desvendar mistérios. Você confia no seu olhar afiado para detalhes, mas também na sua habilidade refinada de ler as palavras e ações de outras criaturas para determinar sua verdadeira intenção. Você é habilidoso em derrotar criaturas que se escondem e se alimentam de pessoas comuns, e sua maestria em conhecimento e olhar aguçado o tornam bem equipado para expor e acabar com males ocultos.',
    caracteristicas: [
      { nivel: 3, titulo: 'Ouvido para Mentiras', corpo: 'Quando você escolhe este arquétipo no 3º nível, você desenvolve um ouvido aguçado para detectar mentiras. Sempre que fizer um teste de <span class="dc-termo">Sabedoria</span> (Intuição) para determinar se uma criatura está mentindo, considere uma rolagem de 7 ou menos no d20 como sendo um 8.' },
      { nivel: 3, titulo: 'Olhar para o Detalhe', corpo: 'A partir do 3º nível, você pode usar uma <span class="dc-termo">ação</span> livre para fazer um teste de <span class="dc-termo">Sabedoria</span> (Percepção) para detectar uma criatura ou objeto escondido ou fazer um teste de <span class="dc-termo">Inteligência</span> (Investigação) para descobrir ou decifrar pistas.' },
      { nivel: 3, titulo: 'Combate Intuitivo', corpo: `No 3º nível, você ganha a habilidade de decifrar as táticas de um oponente e desenvolver um contra-ataque para elas. Como uma <span class="dc-termo">ação bônus</span>, você faz um teste de <span class="dc-termo">Sabedoria</span> (Intuição) contra uma criatura que você possa ver e que não esteja incapacitada, contestado pelo teste de <span class="dc-termo">Carisma</span> (Enganação) do alvo. Se você tiver sucesso, pode usar seu <span class="dc-termo">Ataque Furtivo</span> contra esse alvo mesmo se não tiver <span class="dc-termo">vantagem</span> no teste de ataque, mas não se tiver <span class="dc-termo">desvantagem</span> nele.
Este benefício dura 1 minuto ou até você usar com sucesso esta característica contra um alvo diferente.` },
      { nivel: 9, titulo: 'Olhar para a Fraqueza', corpo: 'No 9º nível, criaturas sobre o efeito de seu <span class="dc-termo">combate intuitivo</span> tem sua fraqueza desmascarada e pontos fracos expostos. Quando você atingir uma criatura com seu <span class="dc-termo">ataque furtivo</span> enquanto sua característica <span class="dc-termo">Combate Intuitivo</span> estiver a afetando, ela fica vulnerável fazendo com que seu próximo <span class="dc-termo">ataque furtivo</span> cause 3d6 de dano extra contra ela.' },
      { nivel: 13, titulo: 'Olhar Inabalável', corpo: 'No 13º nível, seus sentidos são quase impossíveis de enganar. Você sempre sente a presença de ilusões, metamorfos não em sua forma original e outras magias destinadas a enganar os sentidos a até 30 pés de você, desde que você não esteja cego ou surdo. Você percebe que um efeito está tentando enganá-lo, mas não obtém intuição sobre o que está escondido ou sua verdadeira natureza.' },
      { nivel: 17, titulo: 'Expor Feridas', corpo: `No 17º nível, você aprende a explorar as fraquezas de uma criatura ao estudar cuidadosamente suas táticas e movimentos. Enquanto sua característica <span class="dc-termo">Combate Intuitivo</span> se aplica a uma criatura, você pode abrir uma de suas feridas e fazer com que a criatura fique enfraquecida dando ela vulnerabilidade para o próximo dano que você causar.
Você pode utilizar essa habilidade uma vez a cada <span class="dc-termo">descanso longo</span>.
Se você atingir uma criatura com um acerto crítico essa habilidade funciona automaticamente.` },
    ],
  },
  {
    nome: 'Ladrão',
    icone: '🗝️',
    introTexto: 'Você aprimora suas habilidades nas artes do roubo. Ladrões, bandidos, carteiristas e outros criminosos normalmente seguem este arquétipo, mas também o fazem os ladrões que preferem se pensar como caçadores de tesouros profissionais, exploradores, aventureiros e investigadores. Além de melhorar sua agilidade e furtividade, você aprende habilidades úteis para adentrar em ruínas antigas, ler idiomas desconhecidos e usar itens mágicos que normalmente não poderia empregar.',
    caracteristicas: [
      { nivel: 3, titulo: 'Mãos Rápidas', corpo: 'A partir do 3º nível, você pode usar a <span class="dc-termo">ação bônus</span> concedida pela sua <span class="dc-termo">Ação Astuta</span> para fazer um teste de <span class="dc-termo">Destreza</span> (Prestidigitação), usar suas ferramentas de ladrão para desarmar uma armadilha ou abrir uma fechadura, ou realizar a <span class="dc-termo">ação</span> Usar um Objeto.' },
      { nivel: 3, titulo: 'Habilidade de Escalada', corpo: `Quando você escolhe este arquétipo no 3º nível, você ganha a habilidade de escalar mais rápido do que o normal; escalar não custa movimento extra.
Além disso, quando você faz um salto em corrida, a distância que você cobre aumenta em um número de pés igual a 5 vezes o seu modificador de <span class="dc-termo">Destreza</span>.` },
      { nivel: 9, titulo: 'Furtividade Suprema', corpo: 'A partir do 9º nível, você tem <span class="dc-termo">vantagem</span> em um teste de <span class="dc-termo">Destreza</span> (Furtividade) se se mover a não mais que metade da sua velocidade no mesmo turno. Você possui <span class="dc-termo">vantagem</span> em testes de <span class="dc-termo">Destreza</span> para desviar de armadilhas ou meios de seguranças.' },
      { nivel: 13, titulo: 'Usar Dispositivo Mágico', corpo: 'No 13º nível, você aprendeu o suficiente sobre o funcionamento da magia para poder improvisar o uso de itens mesmo quando eles não são destinados a você. Você ignora todos os requisitos de classe, raça e nível no uso de itens mágicos e pode sincronizar com ilimitados itens mágicos.' },
      { nivel: 17, titulo: 'Reflexos de Ladrão', corpo: 'Quando você atinge o 17º nível, você se tornou habilidoso em preparar emboscadas e escapar rapidamente do perigo. Você pode realizar dois turnos durante a primeira rodada de qualquer combate. Você realiza seu primeiro turno na sua <span class="dc-termo">iniciativa</span> normal e seu segundo turno na sua <span class="dc-termo">iniciativa</span> menos 10. Você não pode usar essa habilidade quando está surpreso.' },
    ],
  },
  {
    nome: 'Saqueador',
    icone: '🌲',
    introTexto: 'Você é habilidoso em furtividade e sobrevivência longe das ruas de uma cidade, permitindo que você avance na frente de seus companheiros durante expedições. Ladinos que abraçam este arquétipo são hábeis na natureza selvagem e entre bárbaros e rangers, e muitos Escoteiros servem como os olhos e ouvidos de bandos de guerra. Emboscador, espião, caçador de recompensas — estes são apenas alguns dos papéis que os Escoteiros assumem enquanto percorrem o mundo.',
    caracteristicas: [
      { nivel: 3, titulo: 'Lutador de Escaramuça', corpo: 'A partir do 3º nível, é difícil te prender durante uma luta. Você pode se mover até metade de sua velocidade como reação quando um inimigo encerra seu turno a 5 pés de você. Este movimento não provoca ataques de oportunidade.' },
      { nivel: 3, titulo: 'Sobrevivente', corpo: 'Quando você escolhe este arquétipo no 3º nível, você ganha proficiência nas habilidades de Natureza e Sobrevivência se ainda não tiver. Seu bônus de proficiência é dobrado para qualquer teste de habilidade que use qualquer uma dessas proficiências.' },
      { nivel: 9, titulo: 'Mobilidade Superior', corpo: 'No 9º nível, sua velocidade de caminhada aumenta em 20 pés. Se você tiver uma velocidade de escalada ou natação, esse aumento se aplica a essa velocidade também.' },
      { nivel: 13, titulo: 'Mestre da Emboscada', corpo: `A partir do 13º nível, você se destaca em liderar emboscadas e agir primeiro em um combate.
Você tem <span class="dc-termo">vantagem</span> em rolagens de <span class="dc-termo">iniciativa</span>. Além disso, a primeira criatura que você atingir durante o primeiro round de um combate se torna mais fácil de ser atingida por você e outros; rolagens de ataque contra esse alvo têm <span class="dc-termo">vantagem</span> até o início de seu próximo turno.` },
      { nivel: 17, titulo: 'Ataque Súbito', corpo: 'A partir do 17º nível, você pode atacar com uma velocidade mortal. Se você realizar a <span class="dc-termo">ação de Ataque</span> em seu turno, pode fazer um ataque adicional como <span class="dc-termo">ação bônus</span>. Este ataque pode se beneficiar do seu <span class="dc-termo">Ataque Furtivo</span> mesmo se você já o tiver usado neste turno, mas você não pode usar seu <span class="dc-termo">Ataque Furtivo</span> contra o mesmo alvo mais de uma vez em um turno.' },
    ],
  },
];

// Escolha de subclasse — todo personagem escolhe uma subclasse em algum
// nível, independente da classe; por isso fica junto dos outros pontos
// fixos em Fundamentos da Classe, não na lista de características do
// Ladino. As opções vêm do próprio array `subclasses`, pra não duplicar
// nome/ícone em dois lugares.
const subclasseEscolha = {
  titulo: 'Arquétipo de Ladino',
  corpo: 'No 3º nível, você escolhe um arquétipo que se esforçará para se equiparar através de exercícios de suas habilidades de ladino. Sua escolha garante a você características no 3º nível e de novo no 9º, 13º e 17º nível.',
  opcoes: subclasses.map((s) => ({ nome: s.nome, icone: s.icone })),
};

function chaveSub(si, ci) {
  return `${si}-${ci}`;
}

// Toda característica e subclasse nasce aberta (ausência de chave = aberto);
// o usuário fecha só as que não quer ver, em vez de precisar abrir uma por uma.
const caracteristicasAbertas = ref({});
const subclasseAbertas = ref({});

function alternarCaracteristica(chave) {
  const abertoAtual = caracteristicasAbertas.value[chave] !== false;
  caracteristicasAbertas.value = { ...caracteristicasAbertas.value, [chave]: !abertoAtual };
}

function alternarSubclasse(chave) {
  const abertoAtual = subclasseAbertas.value[chave] !== false;
  subclasseAbertas.value = { ...subclasseAbertas.value, [chave]: !abertoAtual };
}
</script>

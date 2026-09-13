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
        <h2 class="dc-section-title">Progressão — O Guerreiro</h2>
        <span class="dc-title-line"></span>
      </div>
      <div class="dc-tabela-wrap">
        <table class="dc-tabela-niveis">
          <thead>
            <tr>
              <th>Nível</th>
              <th>Características</th>
            </tr>
          </thead>
          <tbody>
            <tr v-for="n in niveis" :key="n.nivel">
              <td class="dc-tabela-nivel">{{ n.nivel }}º</td>
              <td class="dc-tabela-carac">{{ n.caracteristicas }}</td>
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
      <p class="dc-fundamentos-nota">Regras comuns a toda classe — não são exclusivas do Guerreiro.</p>

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
            <template v-if="subclasseAbertas[chaveSub(si, ci)] !== false">
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
  nome: 'Guerreiro',
  subtitulo: 'Versão Épico',
  icone: '⚔️',
  cor: '#6a6a6a',
  dadoDeVida: 'd10',
  dificuldade: 'Fácil',
  papeis: ['Dano', 'Tanque'],
};

const descricaoBlocos = [
  {
    titulo: null,
    paragrafos: [
      'Um humano com uma armadura de batalha chacoalhante segura seu escudo à sua frente enquanto corre em direção às massas de goblins. Um elfo atrás dela, vestido com armadura de couro batido, atinge os goblins com flechas enquanto eles são disparados de seu arco refinado. O meio-orc próximo grita ordens, ajudando os dois combatentes a coordenarem melhor seus ataques para a melhor vantagem.',
      'Um anão em cota de malha interpõe seu escudo entre a clava do ogro e seu companheiro, quebrando o golpe mortal de lado. Seu companheiro, um meio-elfo em armadura de escamas, roda duas cimitarras num turbilhão ofuscante enquanto circula o ogro, procurando por um ponto cego em suas defesas.',
      'Um gladiador luta por esporte em uma arena, um mestre com seu tridente e rede, treinado para derrubar seus inimigos e movê-los pela arena para o prazer da multidão — e sua própria vantagem tática. A espada de seu oponente flameja com luz azul um instante antes dela mandar um relâmpago para batê-lo.',
      'Todos esses heróis são guerreiros, talvez a mais diversificada classe de personagens em Dungeons & Dragons. Cavaleiros em missão, senhores conquistadores, campeões reais, infantaria de elite, mercenários endurecidos e reis bandidos — como guerreiros, todos eles compartilham uma maestria sem igual com armas e armaduras, e um vasto conhecimento de perícias em combate. E eles estão bem familiarizados com a morte, tanto distribuindo-a quanto encarando-a de perto.',
    ],
  },
  {
    titulo: 'Bem Arredondado',
    paragrafos: [
      'Guerreiros aprendem o básico de todos os estilos de combate. Todo guerreiro sabe brandir um machado, se defender com uma espada longa, usar uma espada larga ou rapieira, um arco ou uma rede. Da mesma forma, um guerreiro é habilidoso com escudos e qualquer tipo de armadura. Além deste grau básico de familiaridade, cada guerreiro se especializa em certo estilo de combate. Alguns se concentram em arquearia, alguns em lutar com duas armas ao mesmo tempo e alguns em aumentar suas habilidades marciais com magia. Esta combinação de capacidade ampla e uma vasta especialização faz dos guerreiros combatentes superiores em campos de batalha e em masmorras.',
    ],
  },
  {
    titulo: 'Treinado para Perigo',
    paragrafos: [
      'Nem todo membro da guarda da cidade, da milícia da vila ou do exército da rainha é um guerreiro. A maioria dessas tropas são soldados relativamente treinados com apenas o mais básico conhecimento marcial. Soldados veteranos, oficiais militares, guarda-costas treinados, cavaleiros dedicados e figuras similares são guerreiros.',
      'Alguns guerreiros sentem a atração de usar seu treinamento como aventureiros. As masmorras de cavernas, os túmulos de mortos-vivos, as salvas de monstros, templos malignos e reinos de senhores cruéis são ambientes perigosos onde estão incluídas habilidades de combate, significando uma questão de vida ou morte. É em especial comum para guerreiros que eram soldados, mercenários, guarda-costas e campeões tornarem-se aventureiros.',
    ],
  },
];

const vida = {
  prefixo: 'd',
  numero: '10',
  nivel1: '10 + seu bônus de Salvaguarda de Constituição + 1',
  niveisSuperiores: '10 + seu bônus de Salvaguarda de Constituição por nível de guerreiro após o 1°',
};

const proficiencias = [
  { titulo: 'Testes de Resistência', itens: ['Força', 'Destreza'], estilo: 'selos', icone: markRaw(IconeResistencia) },
  {
    titulo: 'Perícias',
    nota: 'escolha duas',
    itens: ['Acrobacia', 'Adestrar Animais', 'Atletismo', 'História', 'Intuição', 'Intimidação', 'Percepção', 'Sobrevivência'],
    icone: markRaw(IconePericias),
  },
];

const proficienciasEquipamento = [
  { titulo: 'Armadura', itens: ['Todas as armaduras', 'Escudos'] },
  { titulo: 'Armas', itens: ['Armas simples', 'Armas marciais'] },
  { titulo: 'Ferramentas', itens: ['Nenhuma'] },
];

const equipamento = {
  intro: 'Você começa com o seguinte equipamento, além do equipamento concedido pelo seu antecedente:',
  itens: [
    { opcoes: ['Cota de malha', 'Gibão de peles, um arco longo e 20 flechas'] },
    { opcoes: ['Uma arma marcial e um escudo', 'Duas armas marciais'] },
    { opcoes: ['Uma besta leve e 20 virotes', 'Dois machados de arremesso'] },
    { opcoes: ['Um pacote de aventureiro', 'Um pacote de explorador'] },
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
  { nivel: 1, caracteristicas: 'Estilo de Luta, Retomar o Fôlego, Talento' },
  { nivel: 2, caracteristicas: 'Surto de Ação (1 uso)' },
  { nivel: 3, caracteristicas: 'Arquétipo Marcial' },
  { nivel: 4, caracteristicas: '-' },
  { nivel: 5, caracteristicas: 'Ataque Extra (1), Talento' },
  { nivel: 6, caracteristicas: '-' },
  { nivel: 7, caracteristicas: 'Característica de Arquétipo, Inabalável' },
  { nivel: 8, caracteristicas: '-' },
  { nivel: 9, caracteristicas: 'Indomável (1 uso)' },
  { nivel: 10, caracteristicas: 'Característica de Arquétipo, Talento' },
  { nivel: 11, caracteristicas: 'Ataque Extra (2)' },
  { nivel: 12, caracteristicas: '-' },
  { nivel: 13, caracteristicas: 'Indomável (2 usos), Retomar o Fôlego (2 usos), Sentido Aguçado' },
  { nivel: 14, caracteristicas: '-' },
  { nivel: 15, caracteristicas: 'Característica de Arquétipo, Talento' },
  { nivel: 16, caracteristicas: '-' },
  { nivel: 17, caracteristicas: 'Surto de Ação (2 usos), Indomável (3 usos), Retomar o Fôlego (3 usos)' },
  { nivel: 18, caracteristicas: 'Característica de Arquétipo' },
  { nivel: 19, caracteristicas: 'Lendário' },
  { nivel: 20, caracteristicas: 'Ataque Extra (3), Talento' },
];

const caracteristicas = [
  {
    nivel: 1,
    titulo: 'Estilo de Luta',
    corpo: 'Você adota um estilo de combate particular que será sua especialidade. Escolha uma das opções a seguir. Você não pode escolher o mesmo Estilo de Combate mais de uma vez, mesmo se puder escolher de novo.',
    tabela: {
      colunaA: 'Estilo',
      colunaB: 'Efeito',
      linhas: [
        { a: 'Arquearia', b: 'Você ganha +2 de bônus nas jogadas de ataque realizadas com uma arma de ataque à distância.' },
        { a: 'Combate com Armas Grandes', b: 'Quando você rolar um 1 ou um 2 num dado de dano de um ataque com arma corpo-a-corpo que você esteja empunhando com duas mãos, você pode rolar o dado novamente e usar a nova rolagem, mesmo que resulte em 1 ou 2. A arma deve ter a propriedade duas mãos ou versátil para ganhar esse benefício.' },
        { a: 'Combate com Duas Armas', b: 'Quando você estiver engajado em uma luta com duas armas, você pode adicionar o seu modificador de habilidade na jogada de dano de seu segundo ataque.' },
        { a: 'Defesa', b: 'Enquanto estiver usando armadura, você ganha +1 de bônus em sua CA.' },
        { a: 'Duelismo', b: 'Quando você empunhar uma arma de ataque corpo-a-corpo em uma mão e nenhuma outra arma, você ganha +2 de bônus nas jogadas de dano com essa arma.' },
        { a: 'Proteção', b: 'Você oferece o bônus de seu escudo a todos os aliados a até 1,5 metro de você.' },
      ],
    },
  },
  {
    nivel: 1,
    titulo: 'Retomar o Fôlego',
    corpo: `Você possui uma reserva de estamina e pode usá-la para recuperar seu vigor e energia no meio do combate. Você pode usar uma <span class="dc-termo">ação bônus</span> para recuperar uma quantidade de pontos de vida igual a (1d10 vezes metade do seu nível arredondado para baixo). Além disso, você recupera 1 ponto de exaustão.
Uma vez que você use essa característica, você precisa terminar um <span class="dc-termo">descanso curto</span> ou <span class="dc-termo">descanso longo</span> para usá-la de novo.
Você pode usar esta característica duas vezes entre descansos curtos ou longos quando chegar no 13° nível e três vezes entre descansos curtos ou longos quando chegar no 17° nível.`,
  },
  {
    nivel: 2,
    titulo: 'Surto de Ação',
    corpo: `A partir do 2° nível, você pode forçar o seu limite para além do normal por um momento. Durante o seu turno, você pode realizar uma <span class="dc-termo">ação</span> adicional juntamente com sua <span class="dc-termo">ação</span> e possível <span class="dc-termo">ação bônus</span>. Após utilizar essa habilidade você recebe um ponto de exaustão.
Uma vez que você use essa característica, você precisa terminar um <span class="dc-termo">descanso longo</span> para usá-la de novo.
A partir do 17° nível, você pode usá-la duas vezes antes do descanso.`,
  },
  {
    nivel: 5,
    titulo: 'Ataque Extra',
    corpo: 'A partir do 5° nível, você pode atacar duas vezes, ao invés de uma, quando usar a <span class="dc-termo">ação de ataque</span> durante seu turno. O número de ataques aumenta para três quando você alcançar o 11° nível de guerreiro e para quatro quando alcançar o 20° nível de guerreiro.',
  },
  {
    nivel: 7,
    titulo: 'Inabalável',
    corpo: 'No 7° nível, você ganha <span class="dc-termo">vantagem</span> em testes de resistência para resistir a ser enfeitiçado ou amedrontado.',
  },
  {
    nivel: 9,
    titulo: 'Indomável',
    corpo: `A partir do 9° nível, você pode adicionar 1d10 a um teste de resistência que falhou. Se o fizer, você não pode usar essa característica de novo antes de terminar um <span class="dc-termo">descanso curto</span> ou <span class="dc-termo">descanso longo</span>.
Você pode usar esta característica duas vezes entre descansos curtos ou longos quando chegar no 13° nível e três vezes entre descansos curtos ou longos quando chegar no 17° nível.`,
  },
  {
    nivel: 13,
    titulo: 'Sentido Aguçado',
    corpo: 'No 13° nível, você ganha <span class="dc-termo">vantagem</span> em suas jogadas de <span class="dc-termo">iniciativa</span> e não pode ser surpreendido a menos que esteja incapacitado.',
  },
  {
    nivel: 19,
    titulo: 'Lendário',
    corpo: 'Ao atingir o 19°, você pode escolher um <span class="dc-termo">talento</span> épico.',
  },
];

const subclasses = [
  {
    nome: 'Mestre da Arquearia',
    icone: '🏹',
    introTexto: 'Um Arqueiro Arcano é um estudioso de um método único de arquearia élfica que entrelaça magia nos ataques para produzir efeitos sobrenaturais. Eles são alguns dos guerreiros mais elite entre os elfos. Ficam de guarda nas fronteiras dos domínios élficos, mantendo um olhar atento para invasores e usando flechas impregnadas com magia para derrotar monstros e invasores antes que alcancem os assentamentos élficos. Ao longo dos séculos, as técnicas desses arqueiros elfos foram aprendidas por membros de outras raças que também podem equilibrar aptidão arcana com arquearia.',
    caracteristicas: [
      {
        nivel: 3,
        titulo: 'Conhecimento do Arqueiro Arcano',
        corpo: 'Ao atingir o 3° nível, você aprende teoria mágica ou alguns segredos da natureza, típicos para praticantes dessa tradição marcial élfica. Você escolhe proficiência em Arcana ou Natureza e aprende o truque Prestidigitação ou Druidismo.',
      },
      {
        nivel: 3,
        titulo: 'Disparo Arcano',
        corpo: 'Ao alcançar o 3° nível, você aprende a liberar efeitos mágicos especiais com alguns de seus disparos. Quando obtém essa habilidade, aprende duas opções de Disparo Arcano de sua escolha (veja a tabela abaixo).\nUma vez por turno, quando dispara uma flecha de um arco curto ou longo como parte da <span class="dc-termo">ação de ataque</span>, você pode aplicar uma das opções de Disparo Arcano a essa flecha. Você tem duas utilizações dessa habilidade e recupera todas as utilizações gastas dela ao terminar um <span class="dc-termo">descanso curto</span> ou <span class="dc-termo">descanso longo</span>.',
        tabela: {
          colunaA: 'Opção de Disparo Arcano',
          colunaB: 'Efeito',
          linhas: [
            { a: 'Flecha Banidora', b: 'Você utiliza magia de abjuração para tentar banir temporariamente seu alvo para um local inofensivo no Feywild. A criatura atingida pela flecha também deve ter sucesso em um teste de resistência de <span class="dc-termo">Carisma</span> ou ser banida. Enquanto banida dessa maneira, sua <span class="dc-termo">deslocamento</span> é 0 e fica incapacitada. Ao final de seu próximo turno, o alvo reaparece no espaço que deixou ou no espaço desocupado mais próximo, caso esse espaço esteja ocupado. Após alcançar o 18° nível nesta classe, um alvo também sofre 2d6 de dano de força quando a flecha o atinge.' },
            { a: 'Flecha Encantadora', b: 'Sua magia de encantamento faz com que essa flecha temporariamente enfeite seu alvo. A criatura atingida pela flecha sofre 2d6 de dano psíquico adicional, e escolha um de seus aliados dentro de 9 metros do alvo. O alvo deve ter sucesso em um teste de resistência de <span class="dc-termo">Sabedoria</span>, ou ficará encantado pelo aliado escolhido até o início do seu próximo turno. Este efeito termina antecipadamente se o aliado escolhido atacar o alvo encantado, causar dano a ele ou forçá-lo a fazer um teste de resistência. O dano psíquico aumenta para 4d6 ao alcançar o 18° nível nesta classe.' },
            { a: 'Flecha Explosiva', b: 'Você imbui sua flecha com energia de força retirada da escola de evocação. A flecha detona após seu ataque. Imediatamente após a flecha atingir uma criatura, o alvo e todas as outras criaturas dentro de 3 metros dele sofrem 2d6 de dano de força cada. O dano de força aumenta para 4d6 ao alcançar o 18° nível nesta classe.' },
            { a: 'Flecha Enfraquecedora', b: 'Você tece magia necromântica em sua flecha. A criatura atingida pela flecha sofre 2d6 de dano necrótico adicional. O alvo também deve ter sucesso em um teste de resistência de <span class="dc-termo">Constituição</span>, ou o dano causado por seus ataques com arma é reduzido pela metade até o início de seu próximo turno. O dano necrótico aumenta para 4d6 ao alcançar o 18° nível nesta classe.' },
            { a: 'Flecha Agarradora', b: 'Quando essa flecha atinge seu alvo, magia de conjuração cria espinhos venenosos e agarradores que envolvem o alvo. A criatura atingida pela flecha sofre 2d6 de dano de veneno adicional, sua <span class="dc-termo">deslocamento</span> é reduzido em 3 metros e sofre 2d6 de dano cortante pela primeira vez em cada turno que se mover 30 centímetros ou mais sem se teletransportar. O alvo ou qualquer criatura que consiga alcançá-lo pode usar sua <span class="dc-termo">ação</span> para remover os espinhos com um teste bem-sucedido de <span class="dc-termo">Força</span> (Atletismo) contra sua CD de resistência de Disparo Arcano. Caso contrário, os espinhos duram 1 minuto ou até você usar essa opção novamente. O dano de veneno e o dano cortante aumentam para 4d6 cada ao alcançar o 18° nível nesta classe.' },
            { a: 'Flecha Perfurante', b: 'Você usa magia de transmutação para dar a sua flecha uma qualidade etérea. Quando você usa essa opção, não faz um teste de ataque. Em vez disso, a flecha dispara para frente em uma linha, que tem 30 centímetros de largura e 9 metros de comprimento, antes de desaparecer. A flecha passa sem causar dano através de objetos, ignorando cobertura. Cada criatura naquela linha deve fazer um teste de resistência de <span class="dc-termo">Destreza</span>. Em um teste falho, uma criatura sofre dano como se tivesse sido atingida pela flecha, além de 1d6 de dano perfurante adicional. Em um teste bem-sucedido, uma criatura sofre metade desse dano. O dano perfurante aumenta para 2d6 ao alcançar o 18° nível nesta classe.' },
            { a: 'Flecha Procuradora', b: 'Usando magia de adivinhação, você concede à sua flecha a habilidade de buscar seu alvo, permitindo que a flecha curve e mude seu caminho em busca de sua presa. Quando você usa essa opção, não faz um teste de ataque. Em vez disso, escolha uma criatura que você tenha visto nos últimos minutos. A flecha voa em direção a essa criatura, movendo-se ao redor de obstáculos, ignorando coberturas três-quartos e meia-cobertura. Se o alvo estiver dentro do alcance da arma e houver um caminho grande o suficiente para a flecha viajar até o alvo, ele deve fazer um teste de resistência de <span class="dc-termo">Destreza</span>. Em um teste falho, sofre dano como se tivesse sido atingido pela flecha, mais 1d6 de dano de força adicional, e você aprende a localização atual do alvo. Em um teste bem-sucedido, sofre metade desse dano, e você não aprende sua localização. O dano de força aumenta para 2d6 ao alcançar o 18° nível nesta classe.' },
            { a: 'Flecha Sombria', b: 'Você entrelaça magia de ilusão em sua flecha, ocultando a visão de seu inimigo com sombras. A criatura atingida pela flecha sofre 2d6 de dano psíquico adicional e deve ter sucesso em um teste de resistência de <span class="dc-termo">Sabedoria</span> ou não conseguirá ver nada além de 1,5 metro de distância até o início de seu próximo turno. O dano psíquico aumenta para 4d6 ao alcançar o 18° nível nesta classe.' },
          ],
        },
        notaFinal: 'Você ganha uma opção de Disparo Arcano adicional de sua escolha quando alcança certos níveis nesta classe: 7°, 10°, 15° e 18° nível. Cada opção também melhora quando você se torna um lutador de 18° nível.',
      },
      {
        nivel: 7,
        titulo: 'Flecha Mágica',
        corpo: 'Ao alcançar o 7° nível, você ganha a habilidade de infundir flechas com magia. Sempre que dispara uma flecha não mágica de um arco curto ou longo, você pode torná-la mágica para superar resistência e imunidade a ataques e dano não mágicos. A magia desaparece da flecha imediatamente após atingir ou errar seu alvo.',
      },
      {
        nivel: 7,
        titulo: 'Disparo Curvo',
        corpo: 'Também no 7° nível, quando errar um alvo com uma flecha mágica, você pode usar uma <span class="dc-termo">ação bônus</span> para rolar novamente o ataque contra um alvo diferente dentro de 18 metros do alvo original.',
      },
      {
        nivel: 15,
        titulo: 'Tiro Sempre Pronto',
        corpo: 'Ao alcançar o 15° nível, sua arquearia mágica está disponível sempre que a batalha começa. Se você rolar <span class="dc-termo">iniciativa</span> e não tiver usos de <span class="dc-termo">Disparo Arcano</span> restantes, você recupera um uso dela.',
      },
    ],
  },
  {
    nome: 'Mestre das Runas',
    icone: '🗿',
    introTexto: 'Os Mestres das Runas aprimoraram sua destreza marcial usando o poder sobrenatural das runas, uma prática antiga que teve origem entre gigantes. Os cortadores de runas podem ser encontrados em qualquer família de gigantes, e você provavelmente aprendeu seus métodos de primeira ou segunda mão com um artesão místico desse tipo. Seja encontrando o trabalho do gigante esculpido em uma colina ou caverna, aprendendo sobre as runas de um sábio gigante ou encontrando o próprio gigante, você estudou a arte de gigante e aprendeu como aplicar runas mágicas para fortalecer seu equipamento.',
    caracteristicas: [
      {
        nivel: 3,
        titulo: 'Proficiências Adicionais',
        corpo: 'Ao escolher esta especialização no 3° nível, você ganha proficiência com ferramentas de ferreiro e aprende a falar, ler e escrever Gigante.',
      },
      {
        nivel: 3,
        titulo: 'Entalhador de Runas',
        corpo: 'Começando no 3° nível, você pode usar runas mágicas para aprimorar seu equipamento. Você aprende duas runas de sua escolha, dentre as runas descritas abaixo, e cada vez que ganha um nível nesta classe, pode substituir uma runa que conhece por outra deste recurso. Quando alcança determinados níveis nesta classe, você aprende runas adicionais, como mostrado na tabela a seguir.',
        tabela: {
          colunaA: 'Nível do Guerreiro',
          colunaB: 'Número de Runas',
          linhas: [
            { a: '3º', b: '2' },
            { a: '7º', b: '3' },
            { a: '10º', b: '4' },
            { a: '15º', b: '5' },
          ],
        },
        notaFinal: `Sempre que você completa um <span class="dc-termo">descanso longo</span>, você pode tocar em um número de objetos igual ao número de runas que você conhece, e inscrever uma runa diferente em cada um dos objetos. Para ser elegível, o objeto deve ser uma arma, uma peça de armadura, um escudo, uma joia ou algo mais que você possa vestir ou segurar em uma mão. Sua runa permanece em um objeto até completar um <span class="dc-termo">descanso longo</span>, e um objeto pode conter apenas uma das suas runas por vez.
Se uma runa tiver um pré-requisito de nível, você deve ter pelo menos esse nível nesta classe para aprender a runa. Se uma runa requerer um teste de resistência, seu CD de resistência de Magia de Runa é igual a 8 + seu bônus de proficiência + seu modificador de <span class="dc-termo">Constituição</span>.`,
      },
      {
        nivel: 3,
        titulo: 'Runas Disponíveis',
        corpo: 'As runas a seguir estão disponíveis para você quando aprende uma runa com sua <span class="dc-termo">Entalhador de Runas</span>.',
        tabela: {
          colunaA: 'Runa',
          colunaB: 'Efeito',
          linhas: [
            { a: 'Runa das Nuvens', b: 'Esta runa imita a magia enganadora usada por alguns gigantes das nuvens. Enquanto estiver usando ou carregando um objeto com esta runa, você tem <span class="dc-termo">vantagem</span> em testes de <span class="dc-termo">Destreza</span> (Prestidigitação) e testes de <span class="dc-termo">Carisma</span> (Enganação). Além disso, quando você ou uma criatura que possa ver a até 9 metros de você é atingida por um ataque, você pode usar sua reação para invocar a runa e escolher uma criatura diferente a até 9 metros de você, que não seja o atacante. A criatura escolhida se torna o alvo do ataque, utilizando o mesmo resultado do dado de ataque. Essa magia pode transferir os efeitos do ataque, independentemente do alcance do ataque. Uma vez que você invoque esta runa, não poderá fazê-lo novamente até completar um <span class="dc-termo">descanso curto</span> ou <span class="dc-termo">descanso longo</span>.' },
            { a: 'Runa do Fogo', b: 'A magia desta runa canaliza a mestria artesanal de grandes ferreiros. Enquanto estiver usando ou carregando um objeto com esta runa, seu bônus de proficiência é dobrado para qualquer teste de habilidade que use sua proficiência com uma ferramenta. Além disso, quando você acerta uma criatura com um ataque usando uma arma, você pode invocar a runa para invocar correntes de fogo: o alvo sofre um dano extra de 2d6 de fogo, e deve ter sucesso em um teste de resistência de <span class="dc-termo">Força</span> ou ficar restrito por 1 minuto. Enquanto estiver restrito pelas correntes, o alvo sofre 2d6 de dano de fogo no início de cada turno dele. O alvo pode repetir o teste de resistência no final de cada um dos seus turnos, dissipando as correntes em caso de sucesso. Uma vez que você invoque esta runa, não poderá fazê-lo novamente até completar um <span class="dc-termo">descanso curto</span> ou <span class="dc-termo">descanso longo</span>.' },
            { a: 'Runa da Geada', b: 'A magia desta runa evoca o poder daqueles que sobrevivem nos terrenos gelados, como os gigantes da geada. Enquanto estiver usando ou carregando um objeto com esta runa, você tem <span class="dc-termo">vantagem</span> em testes de <span class="dc-termo">Sabedoria</span> (Trato com Animais) e testes de <span class="dc-termo">Carisma</span> (Intimidação). Além disso, você pode invocar a runa como uma <span class="dc-termo">ação bônus</span> para aumentar sua resistência. Por 10 minutos, você ganha um bônus de +2 em todos os testes de habilidade e resistências que usem <span class="dc-termo">Força</span> ou <span class="dc-termo">Constituição</span>. Uma vez que você invoque esta runa, não poderá fazê-lo novamente até completar um <span class="dc-termo">descanso curto</span> ou <span class="dc-termo">descanso longo</span>.' },
            { a: 'Runa da Pedra', b: 'A magia desta runa canaliza a sagacidade associada aos gigantes da pedra. Enquanto estiver usando ou carregando um objeto com esta runa, você tem <span class="dc-termo">vantagem</span> em testes de <span class="dc-termo">Sabedoria</span> (Percepção) e tem visão no escuro com um alcance de 36 metros. Além disso, quando uma criatura que você possa ver termina o turno dela a até 9 metros de você, você pode usar sua reação para invocar a runa e forçar a criatura a fazer um teste de resistência de <span class="dc-termo">Sabedoria</span>. A menos que passe no teste, a criatura fica enfeitiçada por você por 1 minuto. Enquanto estiver enfeitiçada dessa forma, a criatura tem uma <span class="dc-termo">deslocamento</span> de 0 e está incapacitada, mergulhando em um estupor onírico. A criatura repete o teste de resistência no final de cada um dos seus turnos, encerrando o efeito em caso de sucesso. Uma vez que você invoque esta runa, não poderá fazê-lo novamente até completar um <span class="dc-termo">descanso curto</span> ou <span class="dc-termo">descanso longo</span>.' },
            { a: 'Runa da Colina (7° nível ou superior)', b: 'A magia desta runa concede uma resistência reminiscente dos gigantes das colinas. Enquanto estiver usando ou carregando um objeto que contenha esta runa, você tem <span class="dc-termo">vantagem</span> em testes de resistência contra envenenamento e possui resistência contra dano de veneno. Além disso, você pode invocar a runa como uma <span class="dc-termo">ação bônus</span>, ganhando resistência a dano concussivo, perfurante e cortante por 1 minuto. Uma vez que você invoque esta runa, não poderá fazê-lo novamente até completar um <span class="dc-termo">descanso curto</span> ou <span class="dc-termo">descanso longo</span>.' },
            { a: 'Runa da Tempestade (7° nível ou superior)', b: 'Usando esta runa, você pode vislumbrar o futuro como um vidente gigante da tempestade. Enquanto estiver usando ou carregando um objeto com esta runa, você tem <span class="dc-termo">vantagem</span> em testes de <span class="dc-termo">Inteligência</span> (Arcanismo) e não pode ser surpreendido desde que não esteja incapacitado. Além disso, você pode invocar a runa como uma <span class="dc-termo">ação bônus</span> para entrar em um estado profético por 1 minuto ou até ficar incapacitado. Até que o estado termine, quando você ou outra criatura que você possa ver a até 18 metros de você fizer um teste de ataque, um teste de resistência ou um teste de habilidade, você pode usar sua reação para causar que o teste tenha <span class="dc-termo">vantagem</span> ou <span class="dc-termo">desvantagem</span>. Uma vez que você invoque esta runa, não poderá fazê-lo novamente até completar um <span class="dc-termo">descanso curto</span> ou <span class="dc-termo">descanso longo</span>.' },
          ],
        },
      },
      {
        nivel: 3,
        titulo: 'Força Gigante',
        corpo: `Ao alcançar o 3° nível, você aprendeu como se impregnar com o poder dos gigantes. Como uma <span class="dc-termo">ação bônus</span>, você magicamente ganha os seguintes benefícios, que duram por 1 minuto:
<ul><li>Você cresce em uma categoria de tamanho. Se não houver espaço para crescer, seu tamanho não muda.</li><li>Seu alcance aumenta em 1,5 metro.</li><li>Você tem <span class="dc-termo">vantagem</span> em testes de <span class="dc-termo">Força</span> e em salvaguardas de <span class="dc-termo">Força</span>.</li><li>Uma vez em cada um dos seus turnos, um dos seus ataques com uma arma ou um golpe desarmado pode causar 1d6 de dano extra a um alvo atingido.</li></ul>
Você pode usar esta habilidade um número de vezes igual ao seu bônus de proficiência, e recupera todos os usos gastos quando termina um <span class="dc-termo">descanso longo</span>.`,
      },
      {
        nivel: 7,
        titulo: 'Escudo Rúnico',
        corpo: 'Ao alcançar o 7° nível, você aprende a invocar sua magia rúnica para proteger seus aliados. Quando outra criatura que você possa ver a até 18 metros de você é atingida por uma rolagem de ataque, você pode usar sua reação para fazer o atacante rolar o d20 novamente e usar o novo resultado.\nVocê pode usar esta habilidade um número de vezes igual ao seu bônus de proficiência, e recupera todos os usos gastos quando termina um <span class="dc-termo">descanso longo</span>.',
      },
      {
        nivel: 10,
        titulo: 'Grande Estatura',
        corpo: 'Ao alcançar o 10° nível, a magia das suas runas o altera permanentemente. Quando você adquire esta característica, role 3d4. Você cresce um número de polegadas em altura igual ao resultado.\nAlém disso, o dano extra que você causa com sua habilidade de <span class="dc-termo">Força Gigante</span> aumenta para 2d6.',
      },
      {
        nivel: 15,
        titulo: 'Mestre das Runas',
        corpo: 'Ao alcançar o 15° nível, você pode invocar cada runa que você conhece da sua habilidade <span class="dc-termo">Entalhador de Runas</span> duas vezes, em vez de uma, e recupera todos os usos gastos quando termina um <span class="dc-termo">descanso curto</span> ou <span class="dc-termo">descanso longo</span>.',
      },
      {
        nivel: 18,
        titulo: 'Colosso Rúnico',
        corpo: 'Ao alcançar o 18° nível, você aprende a amplificar sua transformação alimentada por runas. Como resultado, o dano extra que você causa com a habilidade <span class="dc-termo">Força Gigante</span> aumenta para 3d6. Além disso, quando você usa essa habilidade, seu tamanho pode aumentar mais uma categoria de tamanho, e enquanto estiver nesse tamanho, seu alcance aumenta em 4,5 metros.',
      },
    ],
  },
  {
    nome: 'Mestre da Lâmina',
    icone: '🤺',
    introTexto: 'O arquétipo do Mestre da Lâmina é um estilo de vida onde o Guerreiro foca em um caminho e o segue como sua religião, utilizando apenas um tipo de arma mas focando em aprimorá-la ao extremo beirando a perfeição. Para aqueles que veneram as lâminas e entendem o seu significado, seguir o caminho do espadachim é compartilhar corpo, mente e alma, colocando a espada como parte de seu corpo e adaptando-a a si mesmo para acompanhar o fluxo de sua lâmina. Esses guerreiros aprendem a usar seus corpos para melhorar as performances de suas lâminas além de absorver de suas companheiras a mentalidade de seu sentido de vida. Muitos guerreiros que adotam esse estilo de vida se vinculam a uma única lâmina, sendo fiéis a ela como se fossem parceiras, e se esforçam para trazer o melhor que possuem para ela.',
    caracteristicas: [
      {
        nivel: 3,
        titulo: 'Posturas dos 7 Caminhos da Lâmina',
        corpo: `Ao chegar no 3° nível você aprendeu as posturas de base do caminho da espada. No seu turno, desde que você esteja usando armas corpo-a-corpo que causem dano Cortante, você pode com uma <span class="dc-termo">ação bônus</span> entrar em uma das 7 formas de postura. Enquanto você estiver nessa forma você adquire certos benefícios que duram até o começo do seu próximo turno. Em alguns momentos durante as posturas você terá que medir suas capacidades com a espada, essa capacidade é representada por seu Dado de Experiência 2d4. Esse dado tem sua quantidade incrementada para 4d4 quando você atinge o 7° nível, 6d4 no 10° nível e 8d4 no 15° nível. Você pode utilizar essa habilidade um número de vezes igual ao valor de proficiência. Você recupera todos os usos dessa habilidade após um <span class="dc-termo">descanso curto</span> ou <span class="dc-termo">descanso longo</span>.
<strong>Lâmina do Fogo.</strong> Ao entrar em uma postura agressiva e de movimentos bruscos com a espada, você adiciona a rolagem de seu Dado de Experiência a suas jogadas de dano com sua lâmina.
<strong>Lâmina da Rocha.</strong> Ao entrar em uma postura de base forte e de movimentos repentinos com a espada, você adiciona a metade de uma rolagem de seu Dado de Experiência arredondado para baixo a sua CA. Você deve realizar a rolagem separadamente para cada ataque sofrido.
<strong>Lâmina Precisa.</strong> Ao entrar em uma postura de movimentos velozes e precisão aumentada você adiciona a rolagem de seu Dado de Experiência em suas jogadas de ataque com sua lâmina.
<strong>Lâmina da Água.</strong> Ao entrar em uma postura suave e de movimentos amorfos com a espada, você pode escolher que seus ataques não causam dano, mas ao invés disso podem causar um dos seguintes efeitos a sua escolha:
<ul><li>A criatura tem sua visão perturbada e o próximo ataque que ela realiza tem <span class="dc-termo">desvantagem</span>.</li><li>A criatura é arremessada 3 metros para longe de você.</li><li>A criatura tem suas pernas alvejadas e tem seu <span class="dc-termo">deslocamento</span> de caminhada reduzido em 4,5 metros.</li><li>A criatura tem seus sentidos perturbados e tem <span class="dc-termo">desvantagem</span> em testes de habilidade de <span class="dc-termo">Sabedoria</span>.</li><li>A criatura tem seus nervos alvejados e não pode realizar reações até o final do turno dela.</li></ul>
Você pode escolher um efeito diferente para cada ataque.
<strong>Lâmina do Relâmpago.</strong> Ao entrar em uma postura de saque e precisão com a espada, você adiciona a rolagem de seu Dado de Experiência ao seu <span class="dc-termo">deslocamento</span> durante esse turno. O bônus é igual a (5 x Dado de Experiência) pés. Durante esse turno toda vez que você realizar a <span class="dc-termo">ação de Disparada</span>, você pode realizar um ataque corpo-a-corpo como parte da <span class="dc-termo">ação</span>. Nesse ataque você recebe um bônus na jogada de dano igual a (1d4 para cada 1,5 metro percorrido em linha reta até o alvo).
<strong>Lâmina dos Ventos.</strong> Ao entrar em uma postura de movimentos circulares e graciosos, você pode, ao invés de realizar um dos seus ataques, girar sua lâmina fazendo com que todas as criaturas que estiverem ao seu redor dentro do alcance de sua lâmina tenham que ser bem-sucedidas em um teste de resistência de <span class="dc-termo">Destreza</span> CD (8 + seu bônus de Proficiência + seu modificador de <span class="dc-termo">Força</span> ou <span class="dc-termo">Destreza</span> + qualquer bônus de acerto da arma) ou sofram um dano igual a (seu modificador de <span class="dc-termo">Força</span> ou <span class="dc-termo">Destreza</span> + a rolagem de seu Dado de Experiência + qualquer bônus de dano da arma). Em um sucesso uma criatura sofre metade do dano.
<strong>Lâmina da Névoa.</strong> Ao entrar em uma postura de movimentos sutis e singulares você se torna difícil de enxergar. Você adiciona a rolagem de seu Dado de Experiência a qualquer teste de resistência que tenha você como alvo, e criaturas que dependem da visão têm <span class="dc-termo">desvantagem</span> em ataques contra você.`,
      },
      {
        nivel: 7,
        titulo: 'Um com a Lâmina',
        corpo: 'Ao atingir o 7° nível, você entende suas lâminas como parte de seu corpo e as ama como ama a si mesmo. Você não pode ser desarmado de suas lâminas enquanto estiver com pelo menos 1 ponto de vida ou estiver incapacitado. Além disso sua margem de crítico quando você atinge uma criatura com um ataque corpo-a-corpo com uma arma que cause dano Cortante é 19-20.',
      },
      {
        nivel: 10,
        titulo: 'Consciência da Lâmina',
        corpo: 'No 10° nível você possui plena confiança em suas habilidades de espadachim. Enquanto estiver acompanhado de pelo menos uma arma corpo-a-corpo que cause dano Cortante, você possui imunidade à condição Amedrontado e Enfeitiçado. Além disso você também ganha proficiência na perícia de Intimidação (<span class="dc-termo">Carisma</span>). Se você já for proficiente nessa perícia, você dobra o valor de proficiência. Você não pode aumentar o valor se já possuir algum efeito que aumenta o bônus, como a Especialização do Ladino. Além disso sua margem de crítico quando você atinge uma criatura com um ataque corpo-a-corpo com uma arma que cause dano Cortante é 18-20.',
      },
      {
        nivel: 15,
        titulo: 'Um com o Propósito da Lâmina',
        corpo: 'Ao chegar no 15° nível você entendeu com alma e corpo qual o significado e propósito de uma lâmina: matar. Sempre que você causar um acerto crítico ou matar uma criatura com armas corpo-a-corpo que causem dano Cortante você é preenchido pelo sentimento de satisfação e prazer, recebendo uma quantidade de pontos de vida temporários iguais a (3 x seu nível de Guerreiro). Além disso, quando você atinge um ataque crítico com uma arma corpo-a-corpo que cause dano da arma, você pode rolar um dos dados de dano da arma mais uma vez e adicioná-lo ao dano extra causado pelo acerto crítico. Além disso sua margem de crítico quando você atinge uma criatura com um ataque corpo-a-corpo com uma arma que cause dano Cortante é 17-20.',
      },
      {
        nivel: 18,
        titulo: 'Eterno Aprendiz',
        corpo: `Ao atingir o 18° nível você entendeu a corrente crescente de conhecimento com a arte da espada e a busca em todo instante mesmo em combate. Enquanto estiver empunhando apenas armas corpo-a-corpo que causem dano Cortante, você ganha os seguintes benefícios:
<ul><li>Sempre que uma criatura errar um ataque contra você, você adiciona 1 de bônus de CA contra essa criatura. Você perde todos os bônus se a criatura atingir você com um ataque crítico ou se você não vê-la por 1 hora ou mais.</li><li>Sempre que você acertar um ataque contra uma criatura, você diminui em 1 a CA dessa criatura contra você. Se a CA da criatura chegar a 0, todos seus ataques contra ela contam como crítico. Você perde todos os bônus se a criatura atingir você com um ataque crítico ou se você não vê-la por 1 hora ou mais.</li><li>Sempre que você acertar um acerto crítico você ganha 1 uso extra de suas <span class="dc-termo">Posturas dos 7 Caminhos da Lâmina</span>. Usos extras podem ser usados até no máximo 1 minuto após adquiridos ou são perdidos.</li><li>O dano de seus ataques críticos não pode ser diminuído de nenhuma maneira.</li></ul>`,
      },
    ],
  },
];

// Escolha de subclasse — todo personagem escolhe uma subclasse em algum
// nível, independente da classe; por isso fica junto dos outros pontos
// fixos em Fundamentos da Classe, não na lista de características do
// Guerreiro. As opções vêm do próprio array `subclasses`, pra não duplicar
// nome/ícone em dois lugares.
const subclasseEscolha = {
  titulo: 'Arquétipo Marcial',
  corpo: 'No 3° nível, você escolhe um arquétipo marcial e se esforça para seguir as técnicas e estilos de combate dele. Sua escolha lhe concede características no 3° nível e novamente no 7°, 10°, 15° e 18° nível.',
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

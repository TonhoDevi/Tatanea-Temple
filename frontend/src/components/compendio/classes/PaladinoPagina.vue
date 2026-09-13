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
        <h2 class="dc-section-title">Progressão — O Paladino</h2>
        <span class="dc-title-line"></span>
      </div>
      <div class="dc-tabela-wrap">
        <table class="dc-tabela-niveis">
          <thead>
            <tr>
              <th rowspan="2">Nível</th>
              <th rowspan="2">Características</th>
              <th rowspan="2" class="dc-th-centro">Magias Conhecidas</th>
              <th colspan="5" class="dc-th-centro">Espaços de Magia por Nível</th>
            </tr>
            <tr>
              <th class="dc-th-centro">1º</th>
              <th class="dc-th-centro">2º</th>
              <th class="dc-th-centro">3º</th>
              <th class="dc-th-centro">4º</th>
              <th class="dc-th-centro">5º</th>
            </tr>
          </thead>
          <tbody>
            <tr v-for="n in niveis" :key="n.nivel">
              <td class="dc-tabela-nivel">{{ n.nivel }}º</td>
              <td class="dc-tabela-carac">{{ n.caracteristicas }}</td>
              <td class="dc-tabela-bonus">{{ n.magiasConhecidas }}</td>
              <td v-for="(esp, ei) in n.espacos" :key="ei" class="dc-tabela-bonus">{{ esp }}</td>
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
      <p class="dc-fundamentos-nota">Regras comuns a toda classe — não são exclusivas do Paladino.</p>

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
            <p class="dc-fundamento-corpo" v-html="subclasseEscolha.corpo"></p>
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
        <h2 class="dc-section-title">Conjuração</h2>
        <span class="dc-title-line"></span>
      </div>
      <div class="dc-conjuracao-par">
        <div class="dc-fundamento dc-fundamento-retangular">
          <span class="dc-fundamento-corner dc-fundamento-corner-tl"></span>
          <span class="dc-fundamento-corner dc-fundamento-corner-tr"></span>
          <span class="dc-fundamento-corner dc-fundamento-corner-bl"></span>
          <span class="dc-fundamento-corner dc-fundamento-corner-br"></span>
          <div class="dc-conjuracao-tipo-linha">
            <span class="dc-conjuracao-tipo-prefixo">O Paladino é</span>
            <div class="dc-conjuracao-tipo">
              <span class="dc-atributo-selo-corner dc-atributo-selo-corner-tl"></span>
              <span class="dc-atributo-selo-corner dc-atributo-selo-corner-tr"></span>
              <span class="dc-atributo-selo-corner dc-atributo-selo-corner-bl"></span>
              <span class="dc-atributo-selo-corner dc-atributo-selo-corner-br"></span>
              <span class="dc-conjuracao-tipo-texto">{{ conjuracaoTipo }}</span>
            </div>
          </div>
          <p class="dc-fundamento-corpo">{{ conjuracaoTexto }}</p>
        </div>

        <div class="dc-fundamento dc-fundamento-retangular">
          <span class="dc-fundamento-corner dc-fundamento-corner-tl"></span>
          <span class="dc-fundamento-corner dc-fundamento-corner-tr"></span>
          <span class="dc-fundamento-corner dc-fundamento-corner-bl"></span>
          <span class="dc-fundamento-corner dc-fundamento-corner-br"></span>
          <p class="dc-fundamento-corpo">{{ fonteMagia }}</p>
          <div class="dc-chip-row dc-chip-row-centro">
            <span
              class="dc-chip dc-chip-tipo-magia"
              :class="{ 'dc-chip-tipo-magia-ativo': t === tipoMagiaPaladino, 'dc-chip-tipo-magia-inativo': t !== tipoMagiaPaladino }"
              v-for="t in tiposDeMagia"
              :key="t"
            >{{ t.toUpperCase() }}</span>
          </div>

          <span class="dc-atributo-magia-rotulo">O Atributo de Conjuração do Paladino</span>
          <div class="dc-atributo-magia-linha">
            <span class="dc-hr-line"></span>
            <span class="dc-atributo-magia-nome">{{ atributoConjuracao.nome }}</span>
            <span class="dc-hr-line"></span>
          </div>

          <div class="dc-vida-stats">
            <div class="dc-vida-stat">
              <span class="dc-vida-stat-label">Bônus com Magia</span>
              <span class="dc-vida-stat-valor"><strong>{{ atributoConjuracao.bonus[0] }}</strong> + <strong>{{ atributoConjuracao.bonus[1] }}</strong></span>
            </div>
            <div class="dc-vida-stat">
              <span class="dc-vida-stat-label">CD de Magia</span>
              <span class="dc-vida-stat-valor">{{ atributoConjuracao.cd[0] }} + <strong>{{ atributoConjuracao.cd[1] }}</strong> + <strong>{{ atributoConjuracao.cd[2] }}</strong></span>
            </div>
          </div>
          <p class="dc-formula-nota">{{ atributoConjuracao.nota }}</p>
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

        <ul class="dc-principios" v-if="s.principios">
          <li v-for="(p, pi) in s.principios" :key="pi">{{ p }}</li>
        </ul>

        <div class="dc-magias-tabela">
          <span class="dc-magias-titulo">Magias do Juramento</span>
          <div class="dc-tabela-wrap">
            <table class="dc-tabela-niveis">
              <thead>
                <tr>
                  <th>Nível do Paladino</th>
                  <th>Magias</th>
                </tr>
              </thead>
              <tbody>
                <tr v-for="m in s.magias" :key="m.nivel">
                  <td class="dc-tabela-nivel">{{ m.nivel }}</td>
                  <td class="dc-tabela-carac">{{ m.magia }}</td>
                </tr>
              </tbody>
            </table>
          </div>
        </div>

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
  nome: 'Paladino',
  subtitulo: 'Um juramento sagrado transforma um guerreiro devotado em um campeão abençoado, e é esse laço — não a espada — que o torna imbatível.',
  icone: '⚜️',
  cor: '#c9a24a',
  dadoDeVida: 'd10',
  dificuldade: 'Intermediário',
  papeis: ['Dano', 'Tanque', 'Suporte', 'Cura'],
};

const descricaoBlocos = [
  {
    titulo: null,
    paragrafos: [
      'Vestido em uma armadura de placas que reluz a luz do sol, a despeito da poeira e sujeira de uma longa viagem, um humano larga sua espada e escudo e coloca suas mãos em um homem fatalmente ferido. Radiação divina brilha de suas mãos, o ferimento do homem se fecha e seus olhos se arregalam com espanto.',
      'Um anão se esgueira por detrás de um afloramento, seu manto negro o torna praticamente invisível durante a noite, e observa uma banda de guerra orc celebrando sua recente vitória. Silenciosamente, ele espreita em meio a eles e sussurra seu juramento e dois orcs morrem antes mesmo de perceberem que ele estava ali.',
      'Com um cabelo prateado que brilha com um raio de luz que parece iluminar apenas ele, um elfo gargalha com exultação. Sua lança golpeia num piscar, como o dos seus olhos, perfurando de novo e de novo em um gigante se contorcendo, até que finalmente sua luz supera a escuridão dele.',
      'Seja lá quais forem suas origens e suas missões, paladinos são unidos pelos seus juramentos de se imporem contra as forças do mal. Quer seja jurado ante o altar de um deus com um sacerdote como testemunha, quer seja em uma clareira sagrada diante dos espíritos da natureza e seres feéricos, ou em um momento de desespero e aflição com os mortos como únicas testemunhas, o juramento de um paladino é um laço poderoso. Ele é uma fonte de poder que transforma um guerreiro devotado em um campeão abençoado.',
    ],
  },
  {
    titulo: 'A Causa da Justiça',
    paragrafos: [
      'Um paladino jura defender a justiça e integridade, se manter com as coisas boas do mundo contra a invasão das trevas e caçar as forças do mal onde quer que ela se esconda. Diferentes paladinos se focam em vários aspectos da causa da justiça, mas todos estão sujeitos aos juramentos que lhes concede poder para fazer seu trabalho sagrado. Embora muitos paladinos sejam devotos de deuses do bem, o poder de um paladino vem tanto do comprometimento com a justiça per si, quanto de um deus. Os paladinos treinam por anos para aprender as perícias de combate, dominando uma variedade de armas e armaduras. Mesmo assim, suas perícias marciais são secundárias ao poder mágico que ele empunha: o poder de curar os doentes e feridos, de destruir os cruéis e os mortos-vivos e de proteger os inocentes e aqueles que se unirem a ele na luta pela justiça.',
    ],
  },
  {
    titulo: 'Além da Vida Mundana',
    paragrafos: [
      'Praticamente por definição, a vida de um paladino é uma vida de aventura. A menos que um ferimento permanente o tenha impedido de se aventurar por um tempo, cada paladino vive nas linhas de frente da batalha cósmica contra o mal. Guerreiros são raros o suficiente nas fileiras de milícias e exércitos do mundo, mas ainda menos pessoas podem reivindicar a verdadeira vocação de um paladino. Quando eles recebem o chamado, esses guerreiros deixam suas antigas ocupações e se armam para lutar contra o mal.',
      'Algumas vezes, seus juramentos os levam a servir à coroa como líderes de grupos de elite de cavaleiros, mas até entre esses, sua lealdade primária é com a causa da justiça, não com a coroa ou país. Paladinos aventureiros levam seus trabalhos a sério. A investigação de uma ruína antiga ou de uma cripta empoeirada pode ser uma missão guiada por um propósito maior que a aquisição de tesouro. O mal espreita nas masmorras e florestas primitivas e, até mesmo, a menor vitória contra ele pode inclinar a balança cósmica para longe do esquecimento.',
    ],
  },
];

const vida = {
  prefixo: 'd',
  numero: '10',
  nivel1: '10 + seu bônus de Salvaguarda de Constituição',
  niveisSuperiores: '1d10 (ou 5) + seu bônus de Salvaguarda de Constituição por nível de paladino após o 1º',
};

const proficiencias = [
  { titulo: 'Testes de Resistência', itens: ['Sabedoria', 'Carisma'], estilo: 'selos', icone: markRaw(IconeResistencia) },
  {
    titulo: 'Perícias',
    nota: 'escolha duas',
    itens: ['Atletismo', 'Intuição', 'Intimidação', 'Medicina', 'Persuasão', 'Religião'],
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
    { opcoes: ['Uma arma marcial e um escudo', 'Duas armas marciais'] },
    { opcoes: ['Cinco azagaias', 'Qualquer arma simples corpo-a-corpo'] },
    { opcoes: ['Um pacote de sacerdote', 'Um pacote de aventureiro'] },
    { opcoes: ['Cota de malha e um símbolo sagrado'] },
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

const SEM = '—';

const niveis = [
  { nivel: 1, magiasConhecidas: SEM, espacos: [SEM, SEM, SEM, SEM, SEM], caracteristicas: 'Sentido Divino, Cura Pelas Mãos, Talento' },
  { nivel: 2, magiasConhecidas: 2, espacos: [2, SEM, SEM, SEM, SEM], caracteristicas: 'Estilo de Luta, Conjuração, Destruição Divina' },
  { nivel: 3, magiasConhecidas: 3, espacos: [3, SEM, SEM, SEM, SEM], caracteristicas: 'Saúde Divina, Juramento Sagrado' },
  { nivel: 4, magiasConhecidas: 3, espacos: [3, SEM, SEM, SEM, SEM], caracteristicas: '-' },
  { nivel: 5, magiasConhecidas: 4, espacos: [4, 2, SEM, SEM, SEM], caracteristicas: 'Ataque Extra, Talento' },
  { nivel: 6, magiasConhecidas: 4, espacos: [4, 2, SEM, SEM, SEM], caracteristicas: 'Aura de Proteção' },
  { nivel: 7, magiasConhecidas: 5, espacos: [4, 3, SEM, SEM, SEM], caracteristicas: 'Característica de Juramento' },
  { nivel: 8, magiasConhecidas: 5, espacos: [4, 3, SEM, SEM, SEM], caracteristicas: '-' },
  { nivel: 9, magiasConhecidas: 6, espacos: [4, 3, 2, SEM, SEM], caracteristicas: '-' },
  { nivel: 10, magiasConhecidas: 6, espacos: [4, 3, 2, SEM, SEM], caracteristicas: 'Aura de Coragem, Talento' },
  { nivel: 11, magiasConhecidas: 7, espacos: [4, 3, 3, SEM, SEM], caracteristicas: 'Destruição Divina Aprimorada' },
  { nivel: 12, magiasConhecidas: 7, espacos: [4, 3, 3, SEM, SEM], caracteristicas: '-' },
  { nivel: 13, magiasConhecidas: 8, espacos: [4, 3, 3, 1, SEM], caracteristicas: '-' },
  { nivel: 14, magiasConhecidas: 8, espacos: [4, 3, 3, 1, SEM], caracteristicas: 'Toque Purificador' },
  { nivel: 15, magiasConhecidas: 9, espacos: [4, 3, 3, 2, SEM], caracteristicas: 'Característica de Juramento, Talento' },
  { nivel: 16, magiasConhecidas: 9, espacos: [4, 3, 3, 2, SEM], caracteristicas: '-' },
  { nivel: 17, magiasConhecidas: 10, espacos: [4, 3, 3, 2, 1], caracteristicas: '-' },
  { nivel: 18, magiasConhecidas: 10, espacos: [4, 3, 3, 2, 1], caracteristicas: '-' },
  { nivel: 19, magiasConhecidas: 11, espacos: [4, 3, 3, 2, 2], caracteristicas: 'Lendário' },
  { nivel: 20, magiasConhecidas: 11, espacos: [4, 3, 3, 2, 2], caracteristicas: 'Característica de Juramento, Talento' },
];

const conjuracaoTipo = 'Meio Conjurador';

const conjuracaoTexto =
  'Você prepara sua lista de magias entre as disponíveis na lista de magias de paladino. Você seleciona um número de magias igual ao seu modificador de Carisma mais metade do seu nível de paladino, arredondado para baixo (no mínimo uma magia) — a coluna Magias Conhecidas na tabela O Paladino mostra o total de magias que você pode ter preparadas em cada nível. Essas magias devem ser de níveis para os quais você tenha espaços de magia. Ao conjurar uma magia preparada, ela não é removida da sua lista, podendo ser conjurada novamente enquanto você tiver espaços disponíveis. Ao adquirir um novo nível nesta classe, você também pode substituir uma magia que conhece por outra da lista de magias de paladino, desde que a nova magia seja de um nível para o qual você tenha espaços de magia.';

const tiposDeMagia = ['Natural', 'Divina', 'Arcana'];
const tipoMagiaPaladino = 'Divina';

const fonteMagia =
  'O Paladino extrai sua magia através de meditação e oração, sendo capaz de utilizar a magia divina.';

const atributoConjuracao = {
  nome: 'Carisma',
  bonus: ['Carisma', 'Proficiência'],
  cd: ['8', 'Proficiência', 'Carisma'],
  nota: 'Os valores de Carisma e Proficiência usados são os bônus respectivos.',
};

const caracteristicas = [
  {
    nivel: 1,
    titulo: 'Sentido Divino',
    corpo: 'Você possui uma percepção sobrenatural que detecta a presença de forças poderosas do bem e do mal. Sempre que um celestial, corruptor ou morto-vivo estiver a até 18 metros de você, você instintivamente sente sua presença: um mal poderoso é registrado como um odor nocivo, enquanto um bem poderoso ressoa como uma melodia celestial em seus ouvidos. No entanto, essa percepção não revela a localização exata da criatura, apenas que ela está dentro desse raio. Com uma <span class="dc-termo">ação bônus</span>, você pode focar sua percepção para detectar a localização exata de tais criaturas até o final do seu próximo turno. Ao fazer isso, você descobre também o tipo (celestial, corruptor ou morto-vivo), mas não sua identidade específica. Além disso, você detecta passivamente a presença de qualquer lugar ou objeto consagrado ou conspurcado dentro do mesmo raio. Essa percepção ocorre naturalmente sem limite de uso, mas pode ser obscurecida por barreiras mágicas ou efeitos que ocultem presenças sobrenaturais.',
  },
  {
    nivel: 1,
    titulo: 'Cura Pelas Mãos',
    corpo: 'Seu toque abençoado pode curar os ferimentos. Você tem uma reserva de poder curativo que se enche quando você realiza um <span class="dc-termo">descanso longo</span>. Com essa reserva, você pode restaurar um número total de pontos de vida igual ao seu nível de paladino x 5. Com uma <span class="dc-termo">ação bônus</span>, você pode tocar uma criatura e sugar o poder da sua reserva para restaurar um número de pontos de vida da criatura, até o máximo de pontos restantes na reserva. Alternativamente, você pode gastar 5 pontos de cura da sua reserva de cura para curar o alvo de uma doença ou neutralizar um veneno que o esteja afetando. Você pode curar múltiplas doenças e neutralizar múltiplos venenos com um único uso de Cura pelas Mãos, gastando pontos de vida separadamente para cada um. Essa característica não gera nenhum efeito em mortos-vivos e constructos.',
  },
  {
    nivel: 2,
    titulo: 'Estilo de Luta',
    corpo: 'No 2° nível, você adota um estilo de combate particular que será sua especialidade. Escolha uma das opções a seguir. Você não pode escolher o mesmo Estilo de Combate mais de uma vez, mesmo se puder escolher de novo.',
    tabela: {
      colunaA: 'Estilo',
      colunaB: 'Efeito',
      linhas: [
        { a: 'Combate com Armas Grandes', b: 'Quando você rolar um 1 ou um 2 num dado de dano de um ataque com arma corpo-a-corpo que você esteja empunhando com duas mãos, você pode rolar o dado novamente e usar a nova rolagem, mesmo que resulte em 1 ou 2. A arma deve ter a propriedade de duas mãos ou versátil para ganhar esse benefício.' },
        { a: 'Defesa', b: 'Enquanto estiver usando armadura, você ganha +1 de bônus em sua CA.' },
        { a: 'Duelismo', b: 'Quando você empunhar uma arma de ataque corpo-a-corpo em uma mão e nenhuma outra arma, você ganha +2 de bônus nas jogadas de dano com essa arma.' },
        { a: 'Proteção', b: 'Você oferece o bônus de seu escudo a todos os aliados a até 1,5m de você.' },
      ],
    },
  },
  {
    nivel: 2,
    titulo: 'Destruição Divina',
    corpo: 'A partir do 2° nível, quando você atingir uma criatura com um ataque corpo-a-corpo com arma, você pode gastar um espaço de magia de qualquer classe para causar dano radiante no alvo, além do dano normal da arma. O dano extra é de 2d8 para um espaço de magia de 1° nível, mais 1d8 para cada espaço de magia acima do 1°, até o máximo de 5d8. O dano aumenta em 2d8 se o alvo for um corruptor ou um morto-vivo. O dado de dano se altera dependendo do alinhamento de alvo, se tornando d10 se o alvo for mal e 1d6 se o alvo for bom.',
  },
  {
    nivel: 3,
    titulo: 'Saúde Divina',
    corpo: 'No 3° nível, a magia divina flui através de você tornando você imune a doenças.',
  },
  {
    nivel: 5,
    titulo: 'Ataque Extra',
    corpo: 'A partir do 5° nível, você pode atacar duas vezes, ao invés de uma, sempre que você realizar a <span class="dc-termo">ação de Ataque</span> no seu turno.',
  },
  {
    nivel: 6,
    titulo: 'Aura de Proteção',
    corpo: 'A partir do 6° nível, sempre que você ou uma criatura amigável a até 3 metros de você tiver que fazer um teste de resistência, aquela criatura ganha um bônus no seu teste de proteção igual a seu modificador de <span class="dc-termo">Carisma</span> (com um bônus mínimo de +1). Você deve estar consciente para garantir esse bônus. No 18° nível, o alcance dessa aura aumenta para 9 metros.',
  },
  {
    nivel: 10,
    titulo: 'Aura de Coragem',
    corpo: 'Começando no 10° nível, você e as criaturas amigáveis dentro de um raio de 3 metros de você não podem ser amedrontadas enquanto você estiver consciente. No 18° nível, o alcance dessa aura aumenta para 9 metros.',
  },
  {
    nivel: 11,
    titulo: 'Destruição Divina Aprimorada',
    corpo: 'No 11° nível, você fica tão infundido com o poder da justiça que todos os seus ataques corpo-a-corpo com arma carregam poder divino neles. Sempre que você atingir uma criatura com um ataque corpo-a-corpo, a criatura sofre 1d8 de dano radiante extra. Se você também usar sua <span class="dc-termo">Destruição Divina</span> em um ataque, você adiciona esse dano ao dano extra da sua <span class="dc-termo">Destruição Divina</span>.',
  },
  {
    nivel: 14,
    titulo: 'Toque Purificador',
    corpo: 'A partir do 14° nível, você pode usar sua <span class="dc-termo">ação</span> para terminar uma magia em si mesmo ou em uma criatura voluntária que você tocar. Você pode usar essa característica um número de vezes igual a seu modificador de <span class="dc-termo">Carisma</span> (mínimo uma vez). Você recupera os usos gastos quando termina um <span class="dc-termo">descanso longo</span>.',
  },
  {
    nivel: 19,
    titulo: 'Lendário',
    corpo: 'Ao atingir o 19°, você pode escolher um <span class="dc-termo">talento</span> épico.',
  },
];

const subclasses = [
  {
    nome: 'Juramento da Dissolução',
    icone: '⛔',
    introTexto: 'Os paladinos que fazem o Juramento da Dissolução dedicam suas vidas a erradicar o abuso da magia e caçar aqueles que corrompem o equilíbrio arcano. Eles são o pesadelo dos magos, pois suas habilidades anulam feitiços, destroem encantamentos e interrompem conjuradores antes que possam tecer suas magias. Alguns seguidores deste juramento lutam para manter a magia sob controle, enquanto outros desejam erradicá-la por completo.',
    principios: [
      'Purificação da Corrupção: Magia não deve ser usada de maneira irresponsável. Seu dever é impedir aqueles que abusam desse poder.',
      'Disciplina Absoluta: Sua mente deve ser um escudo contra influências mágicas.',
      'Neutralização Sobre Destruição: Nem toda magia é má, mas aqueles que a usam de forma errada devem ser detidos.',
      'Caça aos Transgressores: Feiticeiros, bruxos e magos que ultrapassam limites devem ser confrontados.',
    ],
    magias: [
      { nivel: '3º', magia: 'Absorver Elementos, Detectar Magia' },
      { nivel: '5º', magia: 'Cegueira/Surdez, Passo Nebuloso' },
      { nivel: '9º', magia: 'Contramágica, Dissipar Magia' },
      { nivel: '13º', magia: 'Olho Arcano, Banimento' },
      { nivel: '17º', magia: 'Modificar Memória, Antivida Cúpula' },
    ],
    caracteristicas: [
      {
        nivel: 3,
        titulo: 'Canalizar Divindade',
        corpo: 'Ao fazer este juramento no 3º nível, você obtém as seguintes duas opções de Divindade do Canal.',
        tabela: {
          colunaA: 'Opção',
          colunaB: 'Efeito',
          linhas: [
            { a: 'Ruína Arcana', b: 'Como uma ação, você pode forçar uma criatura que você possa ver a até 9 metros a fazer um teste de resistência de Constituição contra seu CD de magia. Em uma falha, ela não pode conjurar magias ou manter concentração até o fim do seu próximo turno.' },
            { a: 'Magia Divina', b: 'Como uma ação, você emana uma aura de estabilidade mágica em um raio de 3 metros por 1 minuto. Enquanto durar, aliados dentro da área ganham <span class="dc-termo">vantagem</span> em testes de resistência para manter a concentração em magias. Além disso, quando um aliado dentro da aura conjurar uma magia, você pode usar sua reação para conceder a ele um bônus igual ao seu bônus de proficiência no CD da magia ou em um teste de ataque mágico.' },
          ],
        },
      },
      { nivel: 7, titulo: 'Aura de Proteção', corpo: 'Começando no 7º nível, uma magia antiga repousa tão fortemente sobre você que forma uma proteção mística. Você e criaturas amigáveis a até 3 metros de você têm resistência a dano de magias. No 18º nível, o alcance desta aura aumenta para 9 metros.' },
      { nivel: 15, titulo: 'Sentinela Imortal', corpo: 'A partir do 15º nível, quando você for reduzido a 0 pontos de vida, você pode escolher cair para 1 ponto de vida. Alternativamente, quando você estiver sujeito a um efeito que o mataria instantaneamente, você pode optar por negar esse efeito. Depois de usar esta habilidade, você não poderá usá-la novamente até terminar um <span class="dc-termo">descanso longo</span>. Além disso, você não sofre nenhuma das desvantagens da velhice e não pode envelhecer magicamente.' },
      {
        nivel: 20,
        titulo: 'Campeão da Dissolução',
        corpo: `Por 1 minuto, você se torna a manifestação viva da antimagia. Como uma <span class="dc-termo">ação</span>, você ganha os seguintes benefícios:
<ul><li>Criaturas a sua escolha a até 3 metros de você recebem imunidade contra dano mágico de magia de nível 5 ou inferior.</li><li>Qualquer criatura a sua escolha que conjurar uma magia dentro de 9 metros de você deve fazer um teste de resistência de <span class="dc-termo">Sabedoria</span> contra sua CD de magia. Se falhar, a magia é perdida sem efeito.</li><li>Você pode usar Dissipar Magia sem gastar espaços como <span class="dc-termo">ação bônus</span>.</li></ul>`,
        notaFinal: 'Depois de usar essa habilidade, você precisa terminar um <span class="dc-termo">descanso longo</span> antes de usá-la novamente.',
      },
    ],
  },
  {
    nome: 'Juramento da Bastilha',
    icone: '🏰',
    introTexto: 'Os paladinos que fazem o Juramento da Bastilha são escudos vivos, muralhas inquebráveis erguidas entre seus aliados e o perigo. Seu poder não vem da fúria ou da agressão, mas da determinação absoluta de proteger aqueles que confiam neles. Para esses guerreiros sagrados, cada golpe bloqueado é uma vitória, cada vida preservada é um triunfo, e cada inimigo que falha em romper suas defesas é a prova de que a verdadeira força reside na resiliência.',
    principios: [
      'Pilar Inquebrável: Nada te fará cair antes dos seus aliados. Você permanecerá firme, custe o que custar.',
      'Sacrifício Valoroso: Seu corpo e sua fé são a barreira contra o caos e a destruição.',
      'Resistência Ofensiva: O melhor ataque é uma defesa que os inimigos não conseguem superar.',
    ],
    magias: [
      { nivel: '3º', magia: 'Escudo da Fé, Onda Trovejante' },
      { nivel: '5º', magia: 'Proteção contra Energia, Imobilizar Pessoa' },
      { nivel: '9º', magia: 'Espíritos Guardiões, Parede de Vento' },
      { nivel: '13º', magia: 'Banimento, Pele de Pedra' },
      { nivel: '17º', magia: 'Muralha de Força, Guardião da Fé' },
    ],
    caracteristicas: [
      {
        nivel: 3,
        titulo: 'Canalizar Divindade',
        corpo: 'Ao assumir este juramento, você recebe duas opções para Canalizar Divindade:',
        tabela: {
          colunaA: 'Opção',
          colunaB: 'Efeito',
          linhas: [
            { a: 'Tremor de Bastilha', b: 'Quando você atinge uma criatura com sua <span class="dc-termo">Destruição Divina</span>, pode usar sua Canalizar Divindade para amplificar seu golpe com o poder de sua determinação protetora. O ataque causa um dano extra igual ao seu nível de paladino, e a criatura atingida é empurrada 4,5 metros para longe. Se essa criatura tiver causado dano a você ou a um aliado no último turno, a força da retaliação é ainda maior: ela é arremessada 9 metros para longe, cai no chão (ficando caída) e sofre um dano extra igual ao modificador do seu <span class="dc-termo">Carisma</span>.' },
            { a: 'Explosão de Escudos', b: 'Com uma <span class="dc-termo">ação bônus</span>, você pode erguer uma barreira de energia protetora ao seu redor, concedendo pontos de vida temporários a você e seus aliados próximos. Todos os aliados em um raio de 3 metros recebem pontos de vida temporários iguais a 1d4 para cada nível de paladino. Essa energia protetora dura por 1 minuto ou até ser dissipada pelo dano.' },
          ],
        },
      },
      { nivel: 7, titulo: 'Fortaleza Mística', corpo: 'Começando no 7º nível, sua presença inspira resistência e segurança. Você e aliados em um raio de 3 metros recebem um bônus de CA igual ao seu modificador de <span class="dc-termo">Carisma</span> (mínimo +1). No nível 18, o alcance dessa aura aumenta para 9 metros.' },
      { nivel: 15, titulo: 'Fortaleza Encarnada', corpo: 'A partir do 15° nível, a energia que lhe protege também traz força, fazendo com que a fortaleza não apenas resista mas também revide com força implacável. Enquanto você ou seus aliados possuírem pontos de vida temporários, seus ataques corpo a corpo e à distância causam dano extra igual ao seu modificador de <span class="dc-termo">Carisma</span> (no mínimo +1). Caso um aliado perca seus pontos de vida temporários, ele mantém esse bônus de dano por mais 1 turno, aproveitando o impulso final da proteção.' },
      {
        nivel: 20,
        titulo: 'Cidadela Ambulante',
        corpo: `No 20° nível, você se torna uma verdadeira cidadela ambulante. Como uma <span class="dc-termo">ação</span>, você ativa esta forma sagrada por 1 minuto, recebendo os seguintes benefícios:
<ul><li>Você e todos os aliados num raio de 9 metros recebem pontos de vida temporários iguais ao dobro do seu nível de paladino.</li><li>Sua Classe de Armadura e a de todos os aliados nesse raio aumenta em +2.</li><li>Você e seus aliados dentro do alcance têm <span class="dc-termo">vantagem</span> em testes de resistência e testes de habilidade de <span class="dc-termo">Força</span>.</li><li>Inimigos que falharem em testes de resistência de <span class="dc-termo">Força</span> contra você são derrubados no chão.</li><li>Sempre que um inimigo atacar um aliado próximo a você, você pode usar sua reação para realizar um ataque corpo a corpo contra ele.</li></ul>`,
        notaFinal: 'Após usar essa habilidade, você precisa de um <span class="dc-termo">descanso longo</span> para reutilizá-la.',
      },
    ],
  },
  {
    nome: 'Juramento da Glória',
    icone: '🏆',
    introTexto: 'O Juramento da Glória é abraçado por paladinos que acreditam que eles e seus companheiros estão destinados a alcançar a glória por meio de atos heroicos. Eles treinam diligentemente e encorajam seus companheiros para estarem prontos quando o destino chamar.',
    principios: [
      'Ações valem mais que palavras: busque ser reconhecido por feitos gloriosos, não por palavras.',
      'Desafios são apenas testes: enfrente dificuldades com coragem e encoraje seus aliados a enfrentá-las junto com você.',
      'Aprimore o corpo: assim como a pedra bruta, seu corpo deve ser trabalhado para que seu potencial seja realizado.',
      'Discipline a alma: você deve mobilizar a disciplina para superar falhas dentro de si mesmo que ameaçam ofuscar a glória sua e de seus amigos.',
    ],
    magias: [
      { nivel: '3º', magia: 'Raio Guiador, Heroísmo' },
      { nivel: '5º', magia: 'Aprimorar Habilidade, Arma Mágica' },
      { nivel: '9º', magia: 'Velocidade, Proteção Contra Energia' },
      { nivel: '13º', magia: 'Compulsão, Movimentação Livre' },
      { nivel: '17º', magia: 'Comunhão, Coluna de Chamas' },
    ],
    caracteristicas: [
      {
        nivel: 3,
        titulo: 'Canalizar Divindade',
        corpo: 'Ao fazer este juramento no 3º nível, você ganha duas opções de canalizar divindade.',
        tabela: {
          colunaA: 'Opção',
          colunaB: 'Efeito',
          linhas: [
            { a: 'Atleta Inigualável', b: 'Como <span class="dc-termo">ação bônus</span>, você pode usar sua Divindade do Canal para aumentar sua capacidade atlética. Pelos próximos 10 minutos, você tem <span class="dc-termo">vantagem</span> em testes de <span class="dc-termo">Força</span> (Atletismo) e <span class="dc-termo">Destreza</span> (Acrobacia); você pode carregar, empurrar, puxar e erguer o dobro do peso normalmente, aumentando o dano de ataques corpo-a-corpo baseados em força em um valor igual ao seu bônus de proficiência; e a distância de seus saltos longos e altos aumenta em 3 metros (esse alcance extra consome movimento normalmente).' },
            { a: 'Golpe Inspirador', b: 'Imediatamente após causar dano a uma criatura com sua habilidade <span class="dc-termo">Golpe Divino</span>, você pode usar sua Divindade do Canal como <span class="dc-termo">ação bônus</span> e distribuir pontos de vida temporários para criaturas à sua escolha a até 9 metros de você, podendo incluir você mesmo. O total de pontos de vida temporários equivale a (1d4 + 1) para cada nível nesta classe, divididos entre as criaturas escolhidas como preferir.' },
          ],
        },
      },
      { nivel: 7, titulo: 'Aura da Presteza', corpo: 'No 7º nível, a glória que você carrega inspira aqueles ao seu redor e resplandece no campo de batalha. Sempre que você ou um aliado a até 3 metros de você acertar um golpe crítico ou reduzir um inimigo a 0 pontos de vida, todos os aliados dentro da aura recebem um brilho radiante até o início do seu próximo turno. Enquanto estiverem brilhando, eles causam dano radiante extra igual ao seu modificador de <span class="dc-termo">Carisma</span> (mínimo 1) no próximo ataque bem-sucedido. No 18º nível, o raio dessa aura aumenta para 9 metros.' },
      { nivel: 15, titulo: 'Defesa Gloriosa', corpo: 'Ao atingir o 15º nível, você pode transformar uma defesa em um ataque repentino. Quando você ou outra criatura que você possa ver a até 3 metros de você é atingida por um ataque, você pode usar sua reação para conceder um bônus à CA do alvo contra esse ataque, potencialmente fazendo-o errar. O bônus equivale ao seu modificador de <span class="dc-termo">Carisma</span> (mínimo de +1). Se o ataque errar, você pode fazer um ataque com arma contra o atacante como parte dessa reação, desde que o atacante esteja dentro do alcance da sua arma. Você pode usar esse recurso um número de vezes igual ao seu modificador de <span class="dc-termo">Carisma</span> (mínimo de uma vez) e recupera todos os usos gastos ao terminar um <span class="dc-termo">descanso longo</span>.' },
      {
        nivel: 20,
        titulo: 'Lenda Viva',
        corpo: `No 20º nível, você pode potencializar a si mesmo com as lendas — sejam verdadeiras ou exageradas — de seus grandes feitos. Como <span class="dc-termo">ação bônus</span>, você ganha os seguintes benefícios por 1 minuto:
<ul><li>Você é abençoado com uma presença sobrenatural, obtendo <span class="dc-termo">vantagem</span> em todos os testes de <span class="dc-termo">Carisma</span>.</li><li>Uma vez a cada um de seus turnos, quando fizer um ataque com arma e errar, você pode fazer com que esse ataque acerte.</li><li>Se falhar em um teste de resistência, você pode usar sua reação para fazer outro teste. Você deve usar o novo resultado.</li></ul>`,
        notaFinal: 'Depois de usar este recurso, você não pode usá-lo novamente até terminar um <span class="dc-termo">descanso longo</span>, a menos que gaste um espaço de magia de 5º nível para usá-lo novamente.',
      },
    ],
  },
  {
    nome: 'Juramento da Redenção',
    icone: '🕊️',
    introTexto: 'O Juramento da Redenção coloca um paladino em um caminho difícil, exigindo que um guerreiro sagrado use a violência apenas como último recurso. Paladinos que se dedicam a este juramento acreditam que qualquer pessoa pode ser redimida e que o caminho da benevolência e justiça é algo que qualquer um pode seguir. Esses paladinos enfrentam criaturas malignas na esperança de trazê-las para a luz, e os paladinos as eliminam apenas quando tal ato claramente salvará outras vidas. Os paladinos que seguem esse caminho são conhecidos como redentores.',
    principios: [
      'Paz: a violência é uma arma de último recurso. A diplomacia e o entendimento são os caminhos para uma paz duradoura.',
      'Inocência: todas as pessoas começam a vida em um estado inocente, e é o ambiente delas ou a influência de forças sombrias que as conduzem ao mal. Ao dar o exemplo correto e trabalhar para curar as feridas de um mundo profundamente falho, você pode colocar qualquer um em um caminho justo.',
      'Paciência: a mudança leva tempo. Aqueles que percorreram o caminho do mal devem ser lembrados para mantê-los honestos e verdadeiros. Depois de plantar a semente da retidão em uma criatura, você deve trabalhar dia após dia para permitir que ela sobreviva e então floresça.',
      'Sabedoria: seu coração e mente devem permanecer claros, pois eventualmente você será forçado a admitir a derrota. Embora toda criatura possa ser redimida, algumas estão tão profundamente no caminho do mal que você não tem escolha senão encerrar suas vidas pelo bem maior. Qualquer ação desse tipo deve ser cuidadosamente ponderada e as consequências plenamente compreendidas, mas uma vez que você tenha tomado a decisão, siga em frente sabendo que seu caminho é justo.',
    ],
    magias: [
      { nivel: '3º', magia: 'Santuário, Sono' },
      { nivel: '5º', magia: 'Emoções Calmas, Imobilizar Pessoa' },
      { nivel: '9º', magia: 'Cancelamento, Padrão Hipnótico' },
      { nivel: '13º', magia: 'Esfera Resiliente de Otiluke, Pele de Pedra' },
      { nivel: '17º', magia: 'Aprisionar Monstro, Parede de Força' },
    ],
    caracteristicas: [
      {
        nivel: 3,
        titulo: 'Canalizar Divindade',
        corpo: 'Ao fazer este juramento no 3º nível, você obtém duas opções de Canalizar Divindade.',
        tabela: {
          colunaA: 'Opção',
          colunaB: 'Efeito',
          linhas: [
            { a: 'Emissário da Paz', b: 'Você pode usar sua Divindade do Canal para aumentar sua presença com poder divino. Como <span class="dc-termo">ação bônus</span>, você concede a si mesmo um bônus de +5 em testes de <span class="dc-termo">Carisma</span> (Persuasão) pelos próximos 10 minutos.' },
            { a: 'Repudiar a Violência', b: 'Você pode usar sua Divindade do Canal para repudiar aqueles que usam violência. Imediatamente após um atacante a até 9 metros de você causar dano com um ataque a uma criatura que não seja você, você pode usar sua reação para forçar o atacante a fazer um teste de resistência de <span class="dc-termo">Sabedoria</span>. Em caso de falha, o atacante sofre dano radiante igual ao dano que acabou de causar. Em caso de sucesso, ele sofre metade desse dano.' },
          ],
        },
      },
      { nivel: 7, titulo: 'Aura do Guardião', corpo: 'Ao atingir o 7º nível, você pode proteger seus aliados do dano à custa de sua própria saúde. Quando uma criatura a até 3 metros de você sofre dano, você pode usar sua reação para magicamente tomar esse dano, em vez de a criatura sofrê-lo. Esse recurso não transfere nenhum outro efeito que possa acompanhar o dano. No 18º nível, o alcance desta aura aumenta para 9 metros.' },
      { nivel: 15, titulo: 'Espírito Protetor', corpo: 'Ao atingir o 15º nível, uma presença sagrada cura suas feridas em combate. Você recupera pontos de vida iguais a 1d6 + metade do seu nível de paladino se terminar seu turno em combate com menos da metade de seus pontos de vida e não estiver incapacitado.' },
      {
        nivel: 20,
        titulo: 'Emissário da Redenção',
        corpo: `Ao atingir o 20º nível, você se torna um avatar da paz, o que lhe concede os seguintes benefícios. Usando sua <span class="dc-termo">ação bônus</span>, você passa por uma transformação. Por 1 minuto, você obtém os seguintes benefícios:
<ul><li>Você tem resistência a todo dano causado por outras criaturas (seus ataques, magias e outros efeitos).</li><li>Sempre que uma criatura lhe causar dano, ela sofrerá dano radiante igual à metade do dano que lhe causou.</li></ul>`,
        notaFinal: 'Depois de usar esta habilidade, você não pode usá-la novamente até terminar um <span class="dc-termo">descanso longo</span>.',
      },
    ],
  },
  {
    nome: 'Juramento da Vingança',
    icone: '⚔️',
    introTexto: 'O Juramento da Vingança é um compromisso solene de punir aqueles que cometeram um pecado grave. Quando forças malignas massacram aldeões indefesos, quando um povo inteiro se volta contra a vontade dos deuses, quando uma guilda de ladrões se torna muito violenta e poderosa, quando um dragão devasta o campo — em momentos assim, paladinos se erguem e juram um Juramento de Vingança para corrigir o que deu errado. Para esses paladinos — às vezes chamados de vingadores ou cavaleiros sombrios —, sua própria pureza não é tão importante quanto entregar justiça.',
    principios: [
      'Combater o Mal Maior: diante da escolha entre lutar contra meus inimigos jurados ou combater um mal menor, eu escolho o mal maior.',
      'Sem Misericórdia para os Perversos: inimigos comuns podem receber minha misericórdia, mas meus inimigos jurados não.',
      'Por Qualquer Meio Necessário: minhas dúvidas não podem impedir a exterminação dos meus inimigos.',
      'Restituição: se meus inimigos causam ruína no mundo, é porque falhei em impedi-los. Eu devo ajudar aqueles prejudicados por suas más ações.',
    ],
    magias: [
      { nivel: '3º', magia: 'Maldição, Marca do Caçador' },
      { nivel: '5º', magia: 'Imobilizar Pessoa, Passo Nebuloso' },
      { nivel: '9º', magia: 'Acelerar, Proteção contra Energia' },
      { nivel: '13º', magia: 'Banimento, Porta Dimensional' },
      { nivel: '17º', magia: 'Parar Monstro, Observar' },
    ],
    caracteristicas: [
      {
        nivel: 3,
        titulo: 'Canalizar Divindade',
        corpo: 'Ao fazer este juramento no 3º nível, você obtém duas opções de Canalizar Divindade.',
        tabela: {
          colunaA: 'Opção',
          colunaB: 'Efeito',
          linhas: [
            { a: 'Repudiar Inimigo', b: 'Como <span class="dc-termo">ação</span>, você apresenta seu símbolo sagrado e profere uma prece de denúncia, usando sua Canalizar Divindade. Escolha uma criatura a até 18 metros de você que você possa ver. Essa criatura deve fazer um teste de resistência de <span class="dc-termo">Sabedoria</span>, a menos que seja imune a ficar amedrontada. Criaturas corruptoras e mortas-vivas têm <span class="dc-termo">desvantagem</span> nesse teste de resistência. Em caso de falha, a criatura fica amedrontada por 1 minuto ou até sofrer qualquer dano — enquanto estiver amedrontada, sua velocidade é 0 e ela não pode se beneficiar de nenhum bônus à sua velocidade. Em caso de sucesso, a velocidade da criatura é reduzida pela metade por 1 minuto ou até sofrer qualquer dano.' },
            { a: 'Voto de Inimizade', b: 'Como <span class="dc-termo">ação bônus</span>, você pode proferir um voto de inimizade contra uma criatura que você possa ver a até 3 metros de você, usando sua Divindade do Canal. Você tem <span class="dc-termo">vantagem</span> em jogadas de ataque contra a criatura por 1 minuto ou até que ela caia a 0 pontos de vida ou fique inconsciente.' },
          ],
        },
      },
      { nivel: 7, titulo: 'Vingador Implacável', corpo: 'Aos 7º nível, seu foco sobrenatural ajuda a fechar a retirada de um inimigo. Quando você atingir uma criatura com um ataque de oportunidade, você pode se mover até metade da sua velocidade imediatamente após o ataque e como parte da mesma reação. Este movimento não provoca ataques de oportunidade.' },
      { nivel: 15, titulo: 'Alma da Vingança', corpo: 'Ao atingir o 15º nível, a autoridade com que você profere seu <span class="dc-termo">Voto de Inimizade</span> lhe concede maior poder sobre seu inimigo. Quando uma criatura sob o efeito do seu <span class="dc-termo">Voto de Inimizade</span> faz um ataque, você pode usar sua reação para fazer um ataque com arma corpo a corpo contra essa criatura se estiver dentro do alcance.' },
      {
        nivel: 20,
        titulo: 'Anjo da Vingança',
        corpo: `No 20º nível, você pode assumir a forma de um vingador angelical. Usando sua <span class="dc-termo">ação bônus</span>, você passa por uma transformação. Por 1 hora, você ganha os seguintes benefícios:
<ul><li>Asas brotam das suas costas e lhe concedem uma velocidade de voo de 18 metros.</li><li>Você emana uma aura de ameaça em um raio de 9 metros. Da primeira vez que qualquer criatura inimiga entra na aura ou começa seu turno lá durante um combate, a criatura deve ser bem-sucedida em um teste de resistência de <span class="dc-termo">Sabedoria</span> ou ficará amedrontada por 1 minuto ou até sofrer qualquer dano.</li><li>Jogadas de ataque contra a criatura amedrontada têm <span class="dc-termo">vantagem</span>.</li></ul>`,
        notaFinal: 'Depois de usar este recurso, você não pode usá-lo novamente até terminar um <span class="dc-termo">descanso longo</span>.',
      },
    ],
  },
];

// Escolha de subclasse — todo personagem escolhe uma subclasse em algum
// nível, independente da classe; por isso fica junto dos outros pontos
// fixos em Fundamentos da Classe, não na lista de características do
// Paladino. As opções vêm do próprio array `subclasses`, pra não duplicar
// nome/ícone em dois lugares.
const subclasseEscolha = {
  titulo: 'Juramento Sagrado',
  corpo: `Quando você alcança o 3° nível, você faz um juramento que torna você um paladino para sempre. Você escolhe uma das subclasses de Paladino detalhada na sessão de subclasses. Sua escolha lhe confere características no 3° nível e novamente no 7°, 15° e 20° nível — entre elas, as magias de juramento e a característica Canalizar Divindade.
Cada juramento possui uma lista de magias associada a ele; uma vez que você tenha acesso a uma magia de juramento, você sempre a terá preparada, e ela não conta no número de magias que você pode preparar por dia.
Seu juramento também permite canalizar energia divina para abastecer efeitos mágicos. Você deve terminar um <span class="dc-termo">descanso curto</span> ou <span class="dc-termo">descanso longo</span> para poder usar sua Canalizar Divindade novamente.`,
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

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
        <h2 class="dc-section-title">Progressão — O Clérigo</h2>
        <span class="dc-title-line"></span>
      </div>
      <div class="dc-tabela-wrap">
        <table class="dc-tabela-niveis">
          <thead>
            <tr>
              <th rowspan="2">Nível</th>
              <th rowspan="2">Características</th>
              <th rowspan="2" class="dc-th-centro">Truques Conhecidos</th>
              <th colspan="9" class="dc-th-centro">Espaços de Magia por Nível</th>
            </tr>
            <tr>
              <th class="dc-th-centro">1º</th>
              <th class="dc-th-centro">2º</th>
              <th class="dc-th-centro">3º</th>
              <th class="dc-th-centro">4º</th>
              <th class="dc-th-centro">5º</th>
              <th class="dc-th-centro">6º</th>
              <th class="dc-th-centro">7º</th>
              <th class="dc-th-centro">8º</th>
              <th class="dc-th-centro">9º</th>
            </tr>
          </thead>
          <tbody>
            <tr v-for="n in niveis" :key="n.nivel">
              <td class="dc-tabela-nivel">{{ n.nivel }}º</td>
              <td class="dc-tabela-carac">{{ n.caracteristicas }}</td>
              <td class="dc-tabela-bonus">{{ n.truquesConhecidos }}</td>
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
      <p class="dc-fundamentos-nota">Regras comuns a toda classe — não são exclusivas do Clérigo.</p>

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
            <span class="dc-conjuracao-tipo-prefixo">O Clérigo é</span>
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
              :class="{ 'dc-chip-tipo-magia-ativo': t === tipoMagiaClerigo, 'dc-chip-tipo-magia-inativo': t !== tipoMagiaClerigo }"
              v-for="t in tiposDeMagia"
              :key="t"
            >{{ t.toUpperCase() }}</span>
          </div>

          <span class="dc-atributo-magia-rotulo">O Atributo de Conjuração do Clérigo</span>
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

        <div class="dc-magias-tabela">
          <span class="dc-magias-titulo">Magias por Nível</span>
          <div class="dc-tabela-wrap">
            <table class="dc-tabela-niveis">
              <thead>
                <tr>
                  <th>Nível do Clérigo</th>
                  <th>Magia</th>
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
  nome: 'Clérigo',
  subtitulo: 'Versão Épico',
  icone: '☀️',
  cor: '#d4c05a',
  dadoDeVida: 'd8',
  dificuldade: 'Média',
  papeis: ['Cura', 'Suporte'],
};

const descricaoBlocos = [
  {
    titulo: null,
    paragrafos: [
      'Com os braços e os olhos erguidos ao sol e uma oração nos lábios, um elfo começa a brilhar com uma luz interior que se derrama para curar seus companheiros de batalha feridos.',
      'Entoando uma canção de glória, um anão balança seu machado em amplos arcos para abrir caminho através das fileiras de orcs alinhados contra ele, gritando louvores aos deuses a cada golpe de inimigo abatido.',
      'Evocando uma maldição sobre as forças dos mortos-vivos, uma humana ergue seu símbolo sagrado enquanto a luz jorra dele para afastar os zumbis que aglomeram seus companheiros.',
      'Clérigos são intermediários entre o mundo mortal e os planos distantes dos deuses. Tão variados quanto os deuses que servem, clérigos se esforçam para ser a própria mão de seus deuses. Não é apenas um sacerdote comum, mas alguém investido de poder divino.',
    ],
  },
  {
    titulo: 'Curadores e Guerreiros',
    paragrafos: [
      'Magia divina, como o nome sugere, é o poder dos deuses, fluindo deles para o mundo. Clérigos são canalizadores desse poder, manifestando-o através de efeitos miraculosos. Os deuses não conferem esse poder a todos que o procuram, mas apenas àqueles escolhidos para cumprir um alto chamado.',
      'Aproveitar o poder divino não depende de estudo ou treinamento. Um clérigo pode aprender ritos formulaicos e orações antigas, mas a habilidade de usar magias divinas depende de devoção e de uma intuição profunda da vontade da divindade.',
      'Clérigos combinam o poder mágico de curar e inspirar seus aliados com magias que ferem e debilitam seus inimigos. Eles podem provocar terror e medo, espalhar pragas ou veneno, e até lançar fogo divino para consumir seus inimigos. Para aqueles malfeitores que merecem uma maça na têmpora, clérigos dependem de seu treinamento de combate para enfrentá-los corpo-a-corpo com o poder dos deuses de seu lado.',
    ],
  },
  {
    titulo: 'Agentes Divinos',
    paragrafos: [
      'Nem todo acólito ou oficiante de um templo ou santuário é um clérigo. Alguns sacerdotes são chamados para uma vida simples de serviço no templo, realizando as vontades de seus deuses através de oração e sacrifício, não por magia e força de armas. Em algumas cidades, o clero equivale a um cargo político, visto como um trampolim para uma autoridade superior e não envolvendo nenhuma comunhão com um deus. Verdadeiros clérigos são raros na maioria das hierarquias.',
      'Quando um clérigo assume uma vida de aventureiro, geralmente é porque seu deus exige isso. Perseguir as metas dos deuses, muitas vezes, envolve enfrentar perigos além dos muros da civilização, destruindo o mal ou buscando relíquias sagradas em tumbas antigas. Espera-se, também, que muitos clérigos protejam os adoradores de seus deuses, o que pode significar lutar contra orcs violentos, negociar a paz entre nações em guerra ou vedar um portal que permitiria que um príncipe demoníaco entrasse no mundo.',
      'A maioria dos clérigos aventureiros mantém alguma conexão com templos estabelecidos e ordens de seus credos. Um templo pode pedir ajuda de um clérigo ou um sumo sacerdote pode estar em posição de exigi-la.',
    ],
  },
];

const vida = {
  prefixo: 'd',
  numero: '8',
  nivel1: '8 + seu bônus de Salvaguarda de Constituição + 1',
  niveisSuperiores: '8 + seu bônus de Salvaguarda de Constituição por nível de clérigo após o 1°',
};

const proficiencias = [
  { titulo: 'Testes de Resistência', itens: ['Sabedoria', 'Carisma'], estilo: 'selos', icone: markRaw(IconeResistencia) },
  {
    titulo: 'Perícias',
    nota: 'escolha duas',
    itens: ['História', 'Intuição', 'Medicina', 'Persuasão', 'Religião'],
    icone: markRaw(IconePericias),
  },
];

const proficienciasEquipamento = [
  { titulo: 'Armadura', itens: ['Armaduras leves', 'Armaduras médias', 'Escudos'] },
  { titulo: 'Armas', itens: ['Todas as armas simples'] },
  { titulo: 'Ferramentas', itens: ['Nenhuma'] },
];

const equipamento = {
  intro: 'Você começa com o seguinte equipamento, além do equipamento concedido pelo seu antecedente:',
  itens: [
    { opcoes: ['Uma maça', 'Um martelo de guerra (se for proficiente)'] },
    { opcoes: ['Brunea', 'Armadura de couro', 'Cota de malha (se for proficiente)'] },
    { opcoes: ['Uma besta leve e 20 virotes', 'Qualquer arma simples'] },
    { opcoes: ['Um pacote de sacerdote', 'Um pacote de aventureiro'] },
    { opcoes: ['Um escudo e um símbolo sagrado'] },
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
  { nivel: 1, truquesConhecidos: 2, espacos: [2, SEM, SEM, SEM, SEM, SEM, SEM, SEM, SEM], caracteristicas: 'Conjuração, Domínio Divino, Talento' },
  { nivel: 2, truquesConhecidos: 2, espacos: [3, SEM, SEM, SEM, SEM, SEM, SEM, SEM, SEM], caracteristicas: 'Canalizar Divindade (1/descanso), Presença do Profeta' },
  { nivel: 3, truquesConhecidos: 2, espacos: [4, 2, SEM, SEM, SEM, SEM, SEM, SEM, SEM], caracteristicas: '-' },
  { nivel: 4, truquesConhecidos: 3, espacos: [4, 3, SEM, SEM, SEM, SEM, SEM, SEM, SEM], caracteristicas: '-' },
  { nivel: 5, truquesConhecidos: 3, espacos: [4, 3, 2, SEM, SEM, SEM, SEM, SEM, SEM], caracteristicas: 'Intervenção Divina (1/descanso), Característica de Domínio, Talento' },
  { nivel: 6, truquesConhecidos: 3, espacos: [4, 3, 3, SEM, SEM, SEM, SEM, SEM, SEM], caracteristicas: 'Canalizar Divindade (2/descanso)' },
  { nivel: 7, truquesConhecidos: 3, espacos: [4, 3, 3, 1, SEM, SEM, SEM, SEM, SEM], caracteristicas: '-' },
  { nivel: 8, truquesConhecidos: 3, espacos: [4, 3, 3, 2, SEM, SEM, SEM, SEM, SEM], caracteristicas: 'Característica de Domínio' },
  { nivel: 9, truquesConhecidos: 4, espacos: [4, 3, 3, 3, 1, SEM, SEM, SEM, SEM], caracteristicas: '-' },
  { nivel: 10, truquesConhecidos: 4, espacos: [4, 3, 3, 3, 2, SEM, SEM, SEM, SEM], caracteristicas: 'Protegido pelo Divino (1/descanso), Talento' },
  { nivel: 11, truquesConhecidos: 4, espacos: [4, 3, 3, 3, 2, 1, SEM, SEM, SEM], caracteristicas: '-' },
  { nivel: 12, truquesConhecidos: 4, espacos: [4, 3, 3, 3, 2, 1, SEM, SEM, SEM], caracteristicas: '-' },
  { nivel: 13, truquesConhecidos: 5, espacos: [4, 3, 3, 3, 2, 1, 1, SEM, SEM], caracteristicas: '-' },
  { nivel: 14, truquesConhecidos: 5, espacos: [4, 3, 3, 3, 2, 1, 1, SEM, SEM], caracteristicas: 'Ressurreição Sagrada, Protegido pelo Divino (2/descanso)' },
  { nivel: 15, truquesConhecidos: 5, espacos: [4, 3, 3, 3, 2, 1, 1, 1, SEM], caracteristicas: 'Talento' },
  { nivel: 16, truquesConhecidos: 5, espacos: [4, 3, 3, 3, 2, 1, 1, 1, SEM], caracteristicas: '-' },
  { nivel: 17, truquesConhecidos: 5, espacos: [4, 3, 3, 3, 2, 1, 1, 1, 1], caracteristicas: 'Característica de Domínio' },
  { nivel: 18, truquesConhecidos: 5, espacos: [4, 3, 3, 3, 3, 1, 1, 1, 1], caracteristicas: 'Canalizar Divindade (3/descanso), Manifestação Divina, Protegido pelo Divino (3/descanso)' },
  { nivel: 19, truquesConhecidos: 5, espacos: [4, 3, 3, 3, 3, 2, 1, 1, 1], caracteristicas: 'Lendário' },
  { nivel: 20, truquesConhecidos: 5, espacos: [4, 3, 3, 3, 3, 2, 2, 1, 1], caracteristicas: 'Intervenção Divina (3/descanso), Talento' },
];

const conjuracaoTipo = 'Conjurador Completo';

const conjuracaoTexto =
  'Você prepara a lista de magias disponíveis selecionando-as da lista de magias de clérigo. Você seleciona um número de magias igual ao seu modificador de Sabedoria + seu nível de clérigo (mínimo de uma magia). Essas magias devem ser de níveis para os quais você possua espaços de magia. Você pode modificar sua lista de magias preparadas quando termina um descanso longo, gastando no mínimo 1 minuto por nível de magia preparada em preces e meditação. Você também pode conjurar qualquer magia de clérigo que conheça como um ritual, se ela possuir o descritor ritual, e usar um símbolo sagrado como foco de conjuração das suas magias de clérigo.';

const tiposDeMagia = ['Natural', 'Divina', 'Arcana'];
const tipoMagiaClerigo = 'Divina';

const fonteMagia =
  'O Clérigo extrai seu poder diretamente de sua devoção e da vontade de sua divindade, sendo capaz de utilizar a magia divina.';

const atributoConjuracao = {
  nome: 'Sabedoria',
  bonus: ['Sabedoria', 'Proficiência'],
  cd: ['8', 'Proficiência', 'Sabedoria'],
  nota: 'Os valores de Sabedoria e Proficiência usados são os bônus respectivos.',
};

const caracteristicas = [
  {
    nivel: 2,
    titulo: 'Canalizar Divindade',
    corpo: `No 2° nível, você se torna capaz de canalizar energia diretamente de sua divindade, utilizando-a como combustível para efeitos mágicos. Você começa com dois efeitos: Presença do Profeta e um efeito determinado pelo seu domínio. Alguns domínios conferem efeitos adicionais conforme você avança de nível, como consta na descrição de cada domínio.
Quando você usar seu Canalizar Divindade, você escolhe qual efeito quer criar. Você precisa terminar um <span class="dc-termo">descanso curto</span> ou <span class="dc-termo">descanso longo</span> para usar a característica de novo.
Alguns efeitos requerem teste de resistência. Quando você usar um desses efeitos, o CD é igual ao das suas magias de clérigo.
A partir do 6° nível, você pode Canalizar Divindade duas vezes entre descansos e a partir do 18° nível, três vezes. Você recupera os usos dessa característica quando termina um <span class="dc-termo">descanso curto</span> ou <span class="dc-termo">descanso longo</span>.
<strong>Presença do Profeta.</strong> Usando uma <span class="dc-termo">ação bônus</span>, você levanta seu símbolo sagrado e murmura uma prece derramando unção ao terreno ao seu redor. Toda área ao seu redor em um raio igual a 4,5 metros se torna santificada e todas as criaturas aliadas dentro da área recebem um bônus em suas jogadas de d20 igual à metade da sua proficiência (arredondado para baixo) enquanto criaturas inimigas possuem uma penalidade de mesmo valor. A área permanece por uma quantidade de horas igual à metade do seu nível.
A área aumenta de raio à medida que você ganha níveis nesta classe, aumentando em uma quantidade de metros igual a (1,5 vezes seu bônus de proficiência).
Se você repetir 42 vezes essa habilidade no mesmo local o efeito se torna permanente. Você só pode ter um número de áreas santificadas permanentemente igual ao seu bônus de proficiência. Ao santificar uma nova área a mais antiga é perdida.`,
  },
  {
    nivel: 5,
    titulo: 'Intervenção Divina',
    corpo: `A partir do 5° nível, você pode canalizar o puro poder de sua fé. Você se torna um condutor da vontade divina, transcendendo os limites mortais da magia. Como uma <span class="dc-termo">ação</span>, você pode invocar um milagre do seu deus, permitindo que conjure qualquer magia da lista de Clérigo de um nível superior ao mais alto que você pode conjurar.
A magia é lançada como parte dessa mesma <span class="dc-termo">ação</span>, ignorando seu tempo normal de conjuração. Se a magia exigir um teste de resistência, uma jogada de ataque ou um teste de habilidade, sua CD ou o teste recebe um bônus igual ao seu bônus de proficiência.
Uma vez que você utiliza essa habilidade, você não pode usá-la novamente até completar um <span class="dc-termo">descanso longo</span>. Entretanto, para restaurá-la, você deve passar 7 dias inteiros em orações e cultos ininterruptos, dedicando-se inteiramente ao seu deus.
Caso ainda não tenha restaurado essa habilidade e já tenha passado pelo menos um <span class="dc-termo">descanso longo</span> desde a última vez que a utilizou, você pode tentar invocar o milagre novamente. Para isso, faça um teste de Religião (CD 25) como uma <span class="dc-termo">ação</span>. Se for bem-sucedido, você pode usar esta habilidade imediatamente como parte da mesma <span class="dc-termo">ação</span>.
Ao atingir o 20° nível nessa classe você pode utilizar essa habilidade 3 vezes antes de precisar restaurar os usos. Além disso, você pode utilizar essa habilidade um número ilimitado de vezes a cada <span class="dc-termo">descanso longo</span>, porém o valor do teste de Religião aumenta em +5 a cada teste bem-sucedido. Os valores voltam ao seu padrão após os 7 dias de orações e cultos.`,
  },
  {
    nivel: 10,
    titulo: 'Protegido pelo Divino',
    corpo: 'No 10° nível, o poder divino encobre seu corpo protegendo-o do mal. Na primeira vez que você falhar em um teste de resistência contra algum efeito mágico ou magia, você passa automaticamente como se tivesse tirado um 20 no dado. Você ganha um uso adicional dessa habilidade no 14° nível, e novamente no 18° nível. Você recupera todos os usos dessa habilidade após um <span class="dc-termo">descanso longo</span>.',
  },
  {
    nivel: 14,
    titulo: 'Ressurreição Sagrada',
    corpo: 'No 14° nível, você pode com uma <span class="dc-termo">ação</span> fazer uma criatura retornar à vida, desde que a criatura não esteja morta a mais de 3 dias. A criatura aparece com metade de seus pontos de vida máximos, não sofre penalidades por morte ou ressurreição e ganha <span class="dc-termo">vantagem</span> em todos os testes de resistência por 1 hora após ser trazida de volta. Essa habilidade não pode ser usada em uma mesma criatura mais de uma vez por semana. Você pode até mesmo reviver a si mesmo, desde que sua alma não esteja aprisionada ou destruída.',
  },
  {
    nivel: 18,
    titulo: 'Manifestação Divina',
    corpo: `Ao alcançar o 18° nível, você atinge o ápice da sua conexão com sua divindade, sua própria existência se torna uma extensão da vontade dela. Você pode manter uma magia que normalmente exigiria concentração sem precisar se concentrar nela.
Além disso, você recebe duas <span class="dc-termo">ação bônus</span> por turno, podendo usá-las normalmente para qualquer <span class="dc-termo">ação bônus</span> que possua.`,
  },
  {
    nivel: 19,
    titulo: 'Lendário',
    corpo: 'Ao atingir o 19°, você pode escolher um <span class="dc-termo">talento</span> épico.',
  },
];

const subclasses = [
  {
    nome: 'Domínio Arcano',
    icone: '🔮',
    introTexto: 'A magia é uma energia que permeia o multiverso, alimentando tanto a destruição quanto a criação. Os deuses do domínio da Arcana conhecem intimamente os segredos e o potencial da magia. Para alguns desses deuses, o conhecimento mágico é uma grande responsabilidade que vem com uma compreensão especial da natureza da realidade. Outros deuses da Arcana veem a magia como um poder puro, a ser usado conforme seu portador julgar apropriado. Os deuses deste domínio são frequentemente associados ao conhecimento, pois o aprendizado e o poder arcano costumam andar de mãos dadas.',
    magias: [
      { nivel: '1º', magia: 'Detectar Magia, Míssil Mágico' },
      { nivel: '3º', magia: 'Nublar, Aura Mágica de Nystul' },
      { nivel: '5º', magia: 'Contramágica, Círculo Mágico' },
      { nivel: '7º', magia: 'Olho Arcano, Baú Secreto de Leomund' },
      { nivel: '9º', magia: 'Aprisionamento Planar, Telecinese' },
    ],
    caracteristicas: [
      {
        nivel: 1,
        titulo: 'Iniciado Arcano',
        corpo: 'Ao escolher este domínio no 1° nível, você ganha proficiência na habilidade de Arcana e aprende dois truques à sua escolha da lista de magias de mago. Para você, esses truques contam como truques de clérigo.',
      },
      {
        nivel: 2,
        titulo: 'Canalizar Divindade: Associação Arcana',
        corpo: 'A partir do 2° nível, você pode usar sua Canalização Divina para aprender magias instantaneamente. Quando você for alvo de uma magia que tenha apenas você como alvo, você pode com uma reação tentar entender a magia e absorvê-la. Realize um teste de Arcana CD igual a 8 + nível da magia. Se você passar, a magia será cancelada e se a magia for de um nível que você possa conjurar você irá adicioná-la permanentemente a sua lista de magias conhecidas.',
      },
      {
        nivel: 5,
        titulo: 'Terreno Abençoado Pelo Rei dos Sábios',
        corpo: 'No 5° nível, criaturas aliadas dentro da <span class="dc-termo">Presença do Profeta</span> têm <span class="dc-termo">vantagem</span> em testes de resistência contra magias de uma escola de magia. Você escolhe a escola ao conjurar a habilidade.',
      },
      {
        nivel: 6,
        titulo: 'Quebrador de Feitiços',
        corpo: 'A partir do 6° nível, ao conjurar uma magia que tenha uma criatura como alvo, você pode juntamente com o efeito da magia terminar o efeito de outra magia que já esteja afetando o alvo. O nível do feitiço que você termina deve ser igual ou menor ao nível do espaço de feitiço que você usou.',
      },
      {
        nivel: 8,
        titulo: 'Poder Mágico',
        corpo: 'A partir do 8° nível, você adiciona seu modificador de <span class="dc-termo">Sabedoria</span> ao dano que causa com qualquer truque.',
      },
      {
        nivel: 17,
        titulo: 'Mestre Arcano',
        corpo: 'No 17° nível, quando uma criatura conjurar uma magia a até 18 metros de você, você pode com uma reação soltar uma magia que tenha tempo de conjuração de uma <span class="dc-termo">ação</span> e tenha um nível igual ou menor à magia conjurada pela criatura. Você pode utilizar essa habilidade três vezes a cada <span class="dc-termo">descanso longo</span>.',
      },
    ],
  },
  {
    nome: 'Domínio da Guerra',
    icone: '⚔️',
    introTexto: 'A guerra se manifesta de várias maneiras. Pode transformar pessoas comuns em heróis. Pode ser desesperadora e horrível, com atos de crueldade e covardia ofuscando outros momentos de excelência e coragem. Em qualquer caso, as entidades da guerra observam os guerreiros e os recompensam por suas grandes façanhas. Os clérigos dessas entidades se destacam na batalha, inspirando outros a lutar pela boa causa ou oferecendo atos de violência como orações.',
    magias: [
      { nivel: '1º', magia: 'Auxílio Divino, Escudo da Fé' },
      { nivel: '3º', magia: 'Arma Mágica, Arma Espiritual' },
      { nivel: '5º', magia: 'Manto do Cruzado, Espíritos Guardiões' },
      { nivel: '7º', magia: 'Pele de Pedra, Bradação Guerreira de Renan' },
      { nivel: '9º', magia: 'Coluna de Chamas, Destruição Banidora' },
    ],
    caracteristicas: [
      {
        nivel: 1,
        titulo: 'Bônus de Proficiência',
        corpo: 'Ao atingir o 1° nível, você ganha proficiência com armas marciais e armaduras pesadas.',
      },
      {
        nivel: 1,
        titulo: 'Sacerdote de Guerra',
        corpo: `A partir do 1° nível, seu deus lhe envia rajadas de inspiração enquanto você está envolvido em batalha. Quando você usa a <span class="dc-termo">ação de ataque</span>, pode realizar um ataque com arma como uma <span class="dc-termo">ação bônus</span>.
Você pode usar esta habilidade um número de vezes igual ao seu bônus de proficiência. Recupera todos os usos gastos quando termina um <span class="dc-termo">descanso curto</span> ou <span class="dc-termo">descanso longo</span>.`,
      },
      {
        nivel: 2,
        titulo: 'Canalizar Divindade: Golpe Guiado',
        corpo: 'Começando no 2° nível, você pode usar sua Canalização Divina para atacar com precisão sobrenatural. Quando fizer uma jogada de ataque, pode usar sua Canalização Divina para ganhar um bônus de +10 na jogada e o alvo do ataque perde qualquer resistência que tenha aos tipos de danos causados pelo ataque por 8 horas. Você faz essa escolha depois de ver o resultado do dado, mas antes do Mestre dizer se o ataque acerta ou erra.',
      },
      {
        nivel: 5,
        titulo: 'Terreno Abençoado Pelo Lorde das Guerras',
        corpo: 'No 5° nível, criaturas aliadas dentro da <span class="dc-termo">Presença do Profeta</span> têm um bônus em sua CA igual à metade do seu bônus de proficiência, arredondado para baixo.',
      },
      {
        nivel: 6,
        titulo: 'Canalizar Divindade: Bênção do Deus da Guerra',
        corpo: 'No 6° nível, você recebe uma infusão de força em meio à violência. Enquanto você estiver engajado em combate, você recupera 5 de vida no começo de cada turno, desde que possua pelo menos 1 ponto de vida.',
      },
      {
        nivel: 8,
        titulo: 'Golpe Divino',
        corpo: 'No 8° nível, você ganha a habilidade de infundir seus golpes de arma com energia divina. Uma vez em cada um dos seus turnos, quando acerta uma criatura com um ataque de arma, pode fazer com que o ataque cause um dano extra de 1d8 do mesmo tipo causado pela arma no alvo. Quando alcança o 14° nível, o dano extra aumenta para 2d8.',
      },
      {
        nivel: 17,
        titulo: 'Avatar da Batalha',
        corpo: 'No 17° nível, ao sofrer dano, você pode com uma reação ganhar resistência a um dos tipos de dano que você tenha sofrido. Essa resistência dura até o próximo <span class="dc-termo">descanso longo</span>. Se você já possui resistência ao tipo de dano escolhido, você recebe imunidade. Você pode utilizar essa habilidade três vezes a cada <span class="dc-termo">descanso longo</span>.',
      },
    ],
  },
  {
    nome: 'Domínio da Morte',
    icone: '💀',
    introTexto: 'O Domínio da Morte está preocupado com as forças que causam a morte, assim como com a energia negativa que dá origem a criaturas não mortas. Divindades como patronas de necromantes, cavaleiros da morte, liches, senhores das múmias e vampiros. Deuses do domínio da morte também incorporam o assassinato, a dor, doença ou veneno e o submundo.',
    magias: [
      { nivel: '1º', magia: 'Perdição, Infligir Ferimentos' },
      { nivel: '3º', magia: 'Cegueira/Surdez, Raio do Enfraquecimento' },
      { nivel: '5º', magia: 'Rogar Maldição, Toque Vampírico' },
      { nivel: '7º', magia: 'Malogro, Proteção contra a Morte' },
      { nivel: '9º', magia: 'Praga, Névoa da Morte' },
    ],
    caracteristicas: [
      {
        nivel: 1,
        titulo: 'Proficiência Adicional',
        corpo: 'Ao escolher este domínio no 1° nível, você ganha proficiência com armas marciais e armadura pesada.',
      },
      {
        nivel: 1,
        titulo: 'Vigia do Crepúsculo',
        corpo: `No 1° nível, você ganha proficiência em testes de resistência de <span class="dc-termo">Constituição</span>. Você e todos os aliados a até 3 metros de você adicionam seu bônus de proficiência em testes de resistência contra a morte. Isso aumenta para 9 metros no 17° nível.
Além disso, você aprende o truque Estabilizar.`,
      },
      {
        nivel: 2,
        titulo: 'Canalizar Divindade: Toque da Morte',
        corpo: 'Começando no 2° nível, você pode usar sua Canalização Divina para destruir a força vital de outra criatura por toque. Quando atingir uma criatura com um ataque corpo-a-corpo, você pode usar a Canalização Divina para fraquejar a criatura, amaldiçoando-a até o final da próxima rodada. Da próxima vez que você ou um aliado atingir a criatura amaldiçoada com um ataque, a criatura tem vulnerabilidade a todos os danos desse ataque, e então a maldição termina.',
      },
      {
        nivel: 5,
        titulo: 'Terreno Abençoado Pelo Guardião da Morte',
        corpo: 'No 5° nível, criaturas inimigas que iniciarem seu turno ou entrarem pela primeira vez neste turno dentro da <span class="dc-termo">Presença do Profeta</span> têm todo seu dano de tipo Cortante, Concussão ou Perfurante diminuído em um valor igual ao seu nível de clérigo.',
      },
      {
        nivel: 6,
        titulo: 'Domínio Sobre o Obscuro',
        corpo: 'Começando no 6° nível, sua capacidade de canalizar energia negativa se torna mais potente. O dano necrótico causado por seus feitiços de clérigo e opções de Canalização Divina ignora resistência e imunidade a dano necrótico. Além disso, sua vida máxima não pode ser diminuída de nenhuma forma.',
      },
      {
        nivel: 8,
        titulo: 'Golpe Divino',
        corpo: 'No 8° nível, você ganha a habilidade de infundir seus ataques com energia necrótica. Uma vez em cada um dos seus turnos, quando atingir uma criatura com um ataque, pode fazer com que o ataque cause um dano extra igual ao nível de desafio da criatura alvo.',
      },
      {
        nivel: 17,
        titulo: 'Visão do Fim',
        corpo: `Começando no 17° nível, com uma <span class="dc-termo">ação</span> você pode amaldiçoar uma criatura com a sombra da morte. Com uma <span class="dc-termo">ação</span> você escolhe uma criatura a até 18 metros de você e se concentra nela (como se estivesse se concentrando em uma magia) e preenche sua alma com energia de morte. A criatura sofre os seguintes efeitos:
<ul><li>A criatura não mais pode recuperar pontos de vida.</li><li>A criatura causa metade do dano em ataques que se baseiam em <span class="dc-termo">Força</span> e <span class="dc-termo">Destreza</span>.</li><li>A criatura não mais pode se concentrar em magias.</li><li>A criatura possui vulnerabilidade a dano necrótico.</li><li>A criatura possui <span class="dc-termo">desvantagem</span> em testes de resistência de <span class="dc-termo">Constituição</span>.</li></ul>
Uma criatura pode realizar um teste de resistência de <span class="dc-termo">Sabedoria</span> no final de cada turno, finalizando o efeito em um sucesso. Você pode utilizar essa habilidade três vezes a cada <span class="dc-termo">descanso longo</span>.`,
      },
    ],
  },
  {
    nome: 'Domínio da Ordem',
    icone: '⚖️',
    introTexto: 'O Domínio da Ordem representa disciplina, assim como a devoção às leis que regem uma sociedade, uma instituição ou uma filosofia. Os clérigos da Ordem meditam sobre lógica e justiça enquanto servem aos seus deuses. Os clérigos da Ordem acreditam que leis bem elaboradas estabelecem hierarquias legítimas, e aqueles selecionados pela lei para liderar devem ser obedecidos. Aqueles que obedecem devem fazê-lo da melhor maneira possível, e os que lideram falham em proteger a lei devem ser substituídos. Dessa forma, a lei tece uma teia de obrigações que criam ordem e segurança em um multiverso caótico.',
    magias: [
      { nivel: '1º', magia: 'Comando, Heroísmo' },
      { nivel: '3º', magia: 'Imobilizar Pessoa, Silvery Barbs' },
      { nivel: '5º', magia: 'Palavra Curativa em Massa, Lentidão' },
      { nivel: '7º', magia: 'Compulsão, Localizar Criatura' },
      { nivel: '9º', magia: 'Comunhão, Dominar Pessoa' },
    ],
    caracteristicas: [
      {
        nivel: 1,
        titulo: 'Proficiências Adicionais',
        corpo: 'Ao escolher este domínio no 1° nível, você ganha proficiência com armaduras pesadas. Você também ganha proficiência na perícia de Intimidação ou Persuasão (à sua escolha).',
      },
      {
        nivel: 1,
        titulo: 'Voz da Autoridade',
        corpo: `A partir do 1° nível, você pode invocar o poder da lei para incentivar um aliado a atacar. Se lançar um feitiço com uma magia de 1° nível ou superior e escolher um aliado como alvo, esse aliado pode usar sua reação imediatamente após o feitiço para realizar um ataque com arma contra uma criatura à sua escolha que você possa ver.
Se o feitiço tiver como alvo mais de um aliado, você escolhe o aliado que pode fazer o ataque.`,
      },
      {
        nivel: 2,
        titulo: 'Canalizar Divindade: Demanda da Ordem',
        corpo: 'A partir do 2° nível, você pode usar sua Canalização Divina para exercer uma presença intimidante sobre outros. Como uma <span class="dc-termo">ação</span>, você apresenta seu símbolo sagrado e cada criatura à sua escolha que possa ver ou ouvir você dentro de 9 metros de você deve ser bem-sucedida em um teste de resistência de <span class="dc-termo">Sabedoria</span> ou ficará paralisada por você até o final do seu próximo turno ou até que a criatura paralisada sofra qualquer dano.',
      },
      {
        nivel: 5,
        titulo: 'Terreno Abençoado Por Aquele que Tudo Comanda',
        corpo: 'No 5° nível, criaturas inimigas que tentarem realizar uma <span class="dc-termo">ação bônus</span> dentro da <span class="dc-termo">Presença do Profeta</span> devem realizar um teste de resistência de <span class="dc-termo">Inteligência</span>, perdendo a <span class="dc-termo">ação bônus</span> em um fracasso.',
      },
      {
        nivel: 6,
        titulo: 'Encarnação da Lei',
        corpo: `No 6° nível, você se torna notavelmente hábil em canalizar energia mágica para compelir outros. Se lançar um feitiço da escola de encantamento usando um espaço de magia de 1° nível ou superior, pode mudar o tempo de conjuração do feitiço para 1 <span class="dc-termo">ação bônus</span> para esta conjuração, desde que o tempo de conjuração do feitiço seja normalmente 1 <span class="dc-termo">ação</span>.
Você pode usar essa habilidade um número de vezes igual ao seu modificador de <span class="dc-termo">Sabedoria</span> (mínimo de uma vez) e recupera todos os usos gastos quando termina um <span class="dc-termo">descanso longo</span>.`,
      },
      {
        nivel: 8,
        titulo: 'Golpe Divino',
        corpo: 'No 8° nível, você ganha a habilidade de infundir seus golpes de arma com energia divina. Uma vez em cada um dos seus turnos, quando acerta uma criatura com um ataque de arma, pode fazer com que o ataque cause um dano extra de 1d8 de dano psíquico ao alvo. Quando alcança o 14° nível, o dano extra aumenta para 2d8.',
      },
      {
        nivel: 17,
        titulo: 'Ordem Absoluta',
        corpo: 'A partir do 17° nível, quando uma criatura que você pode ver realizar uma jogada de d20, você pode com sua reação definir o valor dessa jogada. Você pode utilizar essa habilidade três vezes a cada <span class="dc-termo">descanso longo</span>.',
      },
    ],
  },
  {
    nome: 'Domínio da Vida',
    icone: '💚',
    introTexto: 'O Domínio da Vida se concentra na energia positiva vibrante — uma das forças fundamentais do universo — que sustenta toda vida. Os deuses da vida promovem vitalidade e saúde ao curar os doentes e feridos, cuidar daqueles em necessidade e afastar as forças da morte e da não-morte. Quase qualquer divindade não maligna pode reivindicar influência sobre este domínio.',
    magias: [
      { nivel: '1º', magia: 'Bênção, Cura Ferimentos' },
      { nivel: '3º', magia: 'Restauração Menor, Espírito Curativo' },
      { nivel: '5º', magia: 'Sinal de Esperança, Revivificar' },
      { nivel: '7º', magia: 'Proteção contra a Morte, Aura de Vida' },
      { nivel: '9º', magia: 'Cura Total em Massa, Ressurreição' },
    ],
    caracteristicas: [
      {
        nivel: 1,
        titulo: 'Proficiência Adicional',
        corpo: 'Ao escolher este domínio no 1° nível, você ganha proficiência com armaduras pesadas.',
      },
      {
        nivel: 1,
        titulo: 'Discípulo da Vida',
        corpo: 'Também a partir do 1° nível, seus feitiços de cura são mais eficazes. Sempre que usar um feitiço de 1° nível ou superior para restaurar pontos de vida a uma criatura, a criatura recupera pontos de vida adicionais iguais a duas vezes o seu nível. Além disso, suas curas que excedem o máximo de vida de uma criatura são transformadas em pontos de vida temporários.',
      },
      {
        nivel: 2,
        titulo: 'Canalizar Divindade: Preservar a Vida',
        corpo: 'Começando no 2° nível, você pode usar sua Canalização Divina para curar os gravemente feridos. Como uma <span class="dc-termo">ação</span>, você pode usar seu Canalizar Divindade para tocar uma criatura a até 1,5 metro de você. O alvo recupera pontos de vida equivalentes a 1d8 por nível de personagem e, além disso, remove um nível de exaustão.',
      },
      {
        nivel: 5,
        titulo: 'Terreno Abençoado Pelo Deus da Criação',
        corpo: 'No 5° nível, criaturas aliadas dentro da <span class="dc-termo">Presença do Profeta</span> recebem no começo de cada turno um valor de pontos de vida temporários igual a 1d8 + metade do seu nível de clérigo (arredondado para baixo).',
      },
      {
        nivel: 6,
        titulo: 'Purificador',
        corpo: 'A partir do 6° nível, suas magias podem quebrar o controle que o medo e o mal exercem sobre seus aliados. Sempre que você lançar um feitiço cujo alvo seja um aliado, você também poderá encerrar a condição encantado ou amedrontado daquele aliado. Além disso, sempre que um aliado tiver pontos de vida temporários concedidos por você, esse aliado terá <span class="dc-termo">vantagem</span> nos testes de resistência de <span class="dc-termo">Inteligência</span>, <span class="dc-termo">Sabedoria</span> e <span class="dc-termo">Carisma</span>.',
      },
      {
        nivel: 8,
        titulo: 'Golpe Divino',
        corpo: 'A partir do 8° nível, você adiciona seu modificador de <span class="dc-termo">Sabedoria</span> ao dano que causa com qualquer truque de clérigo.',
      },
      {
        nivel: 17,
        titulo: 'Sentinela da Vida',
        corpo: `Começando no 17° nível, quando uma criatura cair a 0 pontos de vida a até 18 metros de você, você pode com uma reação realizar uma <span class="dc-termo">ação</span> inteira. Você pode realizar reações mesmo com 0 de vida, desde que não esteja morto.
Além disso, quando você curar uma criatura que esteja com 0 pontos de vida, a quantidade de pontos de vida que ela receberia será triplicada.`,
      },
    ],
  },
];

// Escolha de subclasse — todo personagem escolhe uma subclasse em algum
// nível, independente da classe; por isso fica junto dos outros pontos
// fixos em Fundamentos da Classe, não na lista de características do
// Clérigo. As opções vêm do próprio array `subclasses`, pra não duplicar
// nome/ícone em dois lugares.
const subclasseEscolha = {
  titulo: 'Domínio Divino',
  corpo: 'No 1° nível, você escolhe um domínio relacionado à sua divindade. Sua escolha concede magias de domínio e outras características no 1° nível, e novamente no 2°, 5°, 8° e 17° níveis.',
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

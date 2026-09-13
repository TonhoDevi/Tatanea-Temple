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
        <h2 class="dc-section-title">Progressão — O Mago</h2>
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
      <p class="dc-fundamentos-nota">Regras comuns a toda classe — não são exclusivas do Mago.</p>

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
            <span class="dc-conjuracao-tipo-prefixo">O Mago é</span>
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
              :class="{ 'dc-chip-tipo-magia-ativo': t === tipoMagiaMago, 'dc-chip-tipo-magia-inativo': t !== tipoMagiaMago }"
              v-for="t in tiposDeMagia"
              :key="t"
            >{{ t.toUpperCase() }}</span>
          </div>

          <span class="dc-atributo-magia-rotulo">O Atributo de Conjuração do Mago</span>
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
  nome: 'Mago',
  subtitulo: 'Versão Épico',
  icone: '📖',
  cor: '#4a5a8c',
  dadoDeVida: 'd6',
  dificuldade: 'Difícil',
  papeis: ['Dano', 'Controle'],
};

const descricaoBlocos = [
  {
    titulo: null,
    paragrafos: [
      'Vestida com uma túnica prata que denota seu posto, uma elfa fecha seus olhos para se distanciar das distrações do campo de batalha e entoa o seu canto sereno. Dedos se agitam à sua frente, ela completa sua magia e lança uma pequena centelha de fogo em direção dos inimigos, explodindo em chamas o incêndio que engolfa os soldados.',
      'Verificando mais de uma vez o seu trabalho, um humano inscreve um círculo mágico com giz no chão de pedra, então espalha pó de ferro ao longo de cada linha e curva graciosas. Quando o círculo está completo, ele murmura um longo encantamento. Um buraco se abre no espaço dentro do círculo, trazendo um cheiro de enxofre de outro plano bem distante.',
      'Agachado no chão em um cruzamento da masmorra, um gnomo joga um punhado de pequenos ossos com símbolos místicos escritos, murmurando algumas palavras de poder sobre eles. Ele fecha os olhos para receber as visões mais claramente, acena com a cabeça lentamente, então abre os olhos e aponta para baixo, indicando a passagem à sua esquerda.',
      'Os magos são usuários de magia soberanos, unidos e definidos como uma classe pelas magias que conjuram. Usufruindo de uma trama sutil de magia que permeia o cosmos, os magos conjuram magias explosivas de fogo, arcos de relâmpagos, enganos sutis e controle de mentes de força bruta. Sua magia invoca monstros de outros planos de existência, vislumbra o futuro ou transforma inimigos mortos em zumbis. Suas magias mais poderosas podem transformar uma substância em outra, evocar meteoros que caem do céu ou abrir portais para outros mundos.',
    ],
  },
  {
    titulo: 'Estudiosos do Arcanismo',
    paragrafos: [
      'Selvagem e enigmático, variado nas formas e funções, o poder da magia atrai estudiosos que buscam dominar seus mistérios. Alguns aspiram ser como deuses, moldando a realidade à sua vontade. Embora conjurar uma magia básica requeira meramente a pronúncia de algumas palavras estranhas, gestos fugazes, e às vezes um punhado ou um grupo de materiais exóticos, esses materiais mal denotam a experiência alcançada após anos de aprendizagem e incontáveis horas de estudo. Magos vivem e morrem por suas magias. Todo o resto é secundário. Eles aprendem novas magias à medida que eles experimentam e crescem em experiência. Também podem aprender magias de outros magos, de tomos antigos e escrituras, e de criaturas anciãs (como as fadas) que são imersas em magia.',
    ],
  },
  {
    titulo: 'O Fascínio do Conhecimento',
    paragrafos: [
      'O dia a dia de um mago não é nada comum. O mais próximo de uma vida normal que um mago pode conseguir é ser um sábio ou professor em uma biblioteca ou universidade, ensinando aos outros os segredos do multiverso. Outros magos vendem seus serviços como videntes, trabalham com as forças militares, ou buscam uma vida de crimes ou dominação. Mas o fascínio pelo conhecimento e poder atrai até mesmo os magos mais reservados para longe da segurança de seus laboratórios e bibliotecas, e os envia para ruínas e cidades perdidas. A maioria deles acredita que os magos de civilizações antigas conheciam segredos que se perderam pelas eras. Descobrir esses segredos pode abrir caminhos para um poder maior do que qualquer magia conhecida na presente época.',
    ],
  },
];

const vida = {
  prefixo: 'd',
  numero: '6',
  nivel1: '6 + seu bônus de Salvaguarda de Constituição + 1',
  niveisSuperiores: '6 + seu bônus de Salvaguarda de Constituição por nível de mago após o 1°',
};

const proficiencias = [
  { titulo: 'Testes de Resistência', itens: ['Inteligência', 'Sabedoria'], estilo: 'selos', icone: markRaw(IconeResistencia) },
  {
    titulo: 'Perícias',
    nota: 'escolha duas',
    itens: ['Arcana', 'História', 'Intuição', 'Intimidação', 'Investigação', 'Medicina'],
    icone: markRaw(IconePericias),
  },
];

const proficienciasEquipamento = [
  { titulo: 'Armadura', itens: ['Nenhuma'] },
  { titulo: 'Armas', itens: ['Adaga', 'Bastão'] },
  { titulo: 'Ferramentas', itens: ['Nenhuma'] },
];

const equipamento = {
  intro: 'Você começa com o seguinte equipamento, além do equipamento concedido pelo seu antecedente:',
  itens: [
    { opcoes: ['Uma adaga', 'Um bastão'] },
    { opcoes: ['Vestes de estudioso', 'Roupas comuns'] },
    { opcoes: ['Um pacote de estudioso', 'Um pacote de explorador'] },
    { opcoes: ['Grimório e foco arcano'] },
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
  { nivel: 1, truquesConhecidos: 3, espacos: [2, SEM, SEM, SEM, SEM, SEM, SEM, SEM, SEM], caracteristicas: 'Grimório, Recuperação Arcana, Talento' },
  { nivel: 2, truquesConhecidos: 3, espacos: [3, SEM, SEM, SEM, SEM, SEM, SEM, SEM, SEM], caracteristicas: 'Tradição Arcana, Escola Preferida' },
  { nivel: 3, truquesConhecidos: 4, espacos: [4, 2, SEM, SEM, SEM, SEM, SEM, SEM, SEM], caracteristicas: '-' },
  { nivel: 4, truquesConhecidos: 4, espacos: [4, 3, SEM, SEM, SEM, SEM, SEM, SEM, SEM], caracteristicas: '-' },
  { nivel: 5, truquesConhecidos: 5, espacos: [4, 3, 2, SEM, SEM, SEM, SEM, SEM, SEM], caracteristicas: 'Talento' },
  { nivel: 6, truquesConhecidos: 5, espacos: [4, 3, 3, SEM, SEM, SEM, SEM, SEM, SEM], caracteristicas: 'Tradição Arcana' },
  { nivel: 7, truquesConhecidos: 6, espacos: [4, 3, 3, 1, SEM, SEM, SEM, SEM, SEM], caracteristicas: '-' },
  { nivel: 8, truquesConhecidos: 6, espacos: [4, 3, 3, 2, SEM, SEM, SEM, SEM, SEM], caracteristicas: '-' },
  { nivel: 9, truquesConhecidos: 7, espacos: [4, 3, 3, 3, 1, SEM, SEM, SEM, SEM], caracteristicas: '-' },
  { nivel: 10, truquesConhecidos: 7, espacos: [4, 3, 3, 3, 2, SEM, SEM, SEM, SEM], caracteristicas: 'Tradição Arcana, Talento' },
  { nivel: 11, truquesConhecidos: 8, espacos: [4, 3, 3, 3, 2, 1, SEM, SEM, SEM], caracteristicas: '-' },
  { nivel: 12, truquesConhecidos: 8, espacos: [4, 3, 3, 3, 2, 1, SEM, SEM, SEM], caracteristicas: '-' },
  { nivel: 13, truquesConhecidos: 9, espacos: [4, 3, 3, 3, 2, 1, 1, SEM, SEM], caracteristicas: '-' },
  { nivel: 14, truquesConhecidos: 9, espacos: [4, 3, 3, 3, 2, 1, 1, SEM, SEM], caracteristicas: 'Tradição Arcana' },
  { nivel: 15, truquesConhecidos: 10, espacos: [4, 3, 3, 3, 2, 1, 1, 1, SEM], caracteristicas: 'Talento' },
  { nivel: 16, truquesConhecidos: 10, espacos: [4, 3, 3, 3, 2, 1, 1, 1, SEM], caracteristicas: '-' },
  { nivel: 17, truquesConhecidos: 11, espacos: [4, 3, 3, 3, 2, 1, 1, 1, 1], caracteristicas: '-' },
  { nivel: 18, truquesConhecidos: 11, espacos: [4, 3, 3, 3, 3, 1, 1, 1, 1], caracteristicas: 'Dominar Magia' },
  { nivel: 19, truquesConhecidos: 12, espacos: [4, 3, 3, 3, 3, 2, 1, 1, 1], caracteristicas: 'Lendário' },
  { nivel: 20, truquesConhecidos: 12, espacos: [4, 3, 3, 3, 3, 2, 2, 1, 1], caracteristicas: 'Assinatura Mágica, Talento' },
];

const conjuracaoTipo = 'Conjurador Completo';

const conjuracaoTexto =
  'Você conhece três truques, à sua escolha, da lista de magias de mago. Você aprende truques adicionais conforme avança de nível nessa classe. Você pode conjurar qualquer magia que esteja em seu grimório, desde que tenha o grimório à sua disposição e possua espaços de magia do nível adequado para a magia escolhida — se você não tiver seu grimório à disposição, só poderá conjurar truques que não necessitam do grimório para serem conjurados. Você também pode conjurar qualquer magia de mago que conheça como um ritual, se ela possuir o descritor ritual, e usar um foco arcano como foco de conjuração das suas magias de mago.';

const tiposDeMagia = ['Natural', 'Divina', 'Arcana'];
const tipoMagiaMago = 'Arcana';

const fonteMagia =
  'O Mago extrai seu poder através de estudo rigoroso e da memorização de fórmulas arcanas, sendo capaz de utilizar a magia arcana.';

const atributoConjuracao = {
  nome: 'Inteligência',
  bonus: ['Inteligência', 'Proficiência'],
  cd: ['8', 'Proficiência', 'Inteligência'],
  nota: 'Os valores de Inteligência e Proficiência usados são os bônus respectivos.',
};

const caracteristicas = [
  {
    nivel: 1,
    titulo: 'Grimório',
    corpo: `No 1° nível, você possui um grimório contendo seis magias de mago de 1° nível, à sua escolha. Um grimório não contém truques.
As magias que você pode adicionar em seu grimório, à medida que sobe de nível, refletem suas próprias pesquisas arcanas, conduzidas à sua maneira, bem como as suas descobertas sobre a natureza do multiverso. Você pode encontrar outras magias durante suas aventuras, como um feitiço escrito em um pergaminho que estava no baú de um mago maligno, por exemplo, ou em um tomo empoeirado de uma biblioteca antiga.
<strong>Copiar uma Magia para o Grimório.</strong> Quando você encontrar uma magia de mago de 1° nível ou superior, você pode adicioná-la em seu grimório, desde que seja de um nível que você possua espaços de magia, além de dispor de tempo para decifrá-la e copiá-la. A magia copiada deve ser de um nível de magia que o mago possa preparar. Copiar uma magia para seu grimório envolve reproduzir suas formas básicas e os sons e gestos exigidos, para então transcrevê-la em seu grimório com sua própria notação. Para cada nível da magia a ser copiada, gasta-se 2 horas e 50 po. O custo representa os componentes materiais que você gasta para experimentar a magia até dominá-la, bem como as finas tintas utilizadas para escrevê-la. Uma vez gasto o tempo e o dinheiro, você pode preparar a magia copiada como suas outras magias.
<strong>Substituir o Grimório.</strong> Você pode copiar uma magia de seu grimório em outro livro — por exemplo, se você quiser fazer uma cópia reserva de seu grimório. O processo é igual ao de copiar uma nova magia em seu grimório, só que mais rápido e fácil, pois você entende suas próprias notações e sabe como conjurar a magia. Você precisa gastar somente 1 hora e 10 po para cada nível de magia copiada. Se perder seu grimório, você pode usar o mesmo procedimento para transcrever suas magias preparadas em um novo grimório. Preencher o restante do grimório exigirá que você encontre novas magias, como normalmente se faz. Por essa razão, muitos magos mantêm seus grimórios reservas em lugares seguros.
<strong>Usar o Grimório.</strong> Para conjurar suas magias, é essencial ter seu grimório em mãos, pois ele contém todo o conhecimento necessário para canalizar e executar seus feitiços. Sem ele, sua capacidade mágica fica severamente limitada, permitindo-lhe conjurar apenas truques, que são magias simples e instintivas. Seu grimório não é apenas um livro, mas uma extensão do seu próprio entendimento arcano, repleto de anotações personalizadas e diagramas que guiam a manipulação das energias mágicas. Por isso, protegê-lo e manter cópias de segurança é uma prática comum entre magos prudentes.
<strong>A Aparência do Grimório.</strong> Seu grimório é uma compilação de magias, com sua própria decoração e anotações de rodapé. Pode ser um livro de couro simples e funcional, recebido como presente de seu mestre, ou um tomo finamente encadernado com bordas douradas que você encontrou em uma antiga biblioteca, ou mesmo um conjunto de folhas soltas amontoadas após você perder seu grimório anterior em um acidente.`,
  },
  {
    nivel: 1,
    titulo: 'Recuperação Arcana',
    corpo: 'Você aprendeu como recuperar um pouco de sua energia mágica estudando seu grimório. Uma vez por dia, quando você terminar um <span class="dc-termo">descanso curto</span>, você pode escolher espaços de magia gastos para recuperá-los. Os espaços gastos a serem recuperados podem ser de qualquer combinação de níveis de magia, desde que sejam iguais ou inferiores à metade do seu nível de mago (arredondado para cima) e nenhum deles seja de 6° nível ou superior. Por exemplo, se você é um mago de 4° nível, você pode recuperar até 2 espaços de magia gastos. Você pode recuperar o espaço de uma magia de 2° nível ou os espaços de duas magias de 1° nível.',
  },
  {
    nivel: 2,
    titulo: 'Escola Preferida',
    corpo: 'Quando você alcançar o 2° nível, você se torna especialista em uma das escolas de feitiços. Escolha entre abjuração, conjuração, adivinhação, encantamento, evocação, ilusão, necromancia ou transmutação. Você ganha os seguintes benefícios em relação à escola escolhida:\nVocê pode adicionar o dobro do seu bônus de proficiência em qualquer teste de <span class="dc-termo">Inteligência</span> relacionado à escola escolhida.\nVocê ganha um bônus igual à metade do seu bônus de proficiência (arredondado para baixo) em seu CD de salvamento de feitiços e no modificador de ataque de feitiços da escola escolhida ao usar feitiços dessa escola.',
  },
  {
    nivel: 18,
    titulo: 'Dominar Magia',
    corpo: 'No 18° nível, você alcança tamanha maestria em determinadas magias que pode conjurá-las à vontade. Você escolhe uma magia de mago de 1° nível e uma magia de mago de 2° nível de seu grimório. Você as conjura em seu nível mínimo, sem gastar espaços de magia quando as tiver preparadas. Caso queira, você pode conjurá-las com um espaço de nível superior, porém gastará espaços de magia, como normalmente se faz.',
  },
  {
    nivel: 19,
    titulo: 'Lendário',
    corpo: 'Ao atingir o 19°, você pode escolher um <span class="dc-termo">talento</span> épico.',
  },
  {
    nivel: 20,
    titulo: 'Assinatura Mágica',
    corpo: 'Quando alcançar o 20° nível, você adquire domínio completo de duas poderosas magias e pode conjurá-las sem muito esforço. Escolha duas magias de mago de 3° nível em seu grimório como sua assinatura mágica. Você sempre tem essas magias preparadas e elas não contam como magias preparadas em sua lista, além de você poder conjurar cada uma das magias escolhidas, como magias de 3° nível, sem gastar nenhum espaço de magia. Se você quiser conjurar essas magias com espaços de níveis superiores, a magia gastará espaços de magia, como normalmente se faz.',
  },
];

const subclasses = [
  {
    nome: 'Escola da Abjuração',
    icone: '🛡️',
    introTexto: 'A Escola de Abjuração enfatiza a magia que bloqueia, bane ou protege. Detratores desta escola dizem que sua tradição trata-se de negação, anulação, mais do que de afirmação positiva. No entanto, você entende que encerrar efeitos nocivos, proteger os fracos e banir influências malignas está longe de ser um vazio filosófico. É uma vocação orgulhosa e respeitada. Chamados de abjuradores, os membros desta escola são procurados quando espíritos malignos requerem exorcismo, quando locais importantes precisam ser protegidos contra espionagem mágica e quando portais para outros planos de existência precisam ser fechados.',
    caracteristicas: [
      {
        nivel: 2,
        titulo: 'Sábio da Abjuração',
        corpo: 'Começando quando você seleciona esta escola no 2° nível, o ouro e o tempo que você precisa gastar para copiar um feitiço de abjuração no seu grimório são reduzidos pela metade.',
      },
      {
        nivel: 2,
        titulo: 'Barreira Arcana',
        corpo: 'Começando no 2° nível, você pode tecer magia ao seu redor para proteção. Quando conjura um feitiço de abjuração de 1° nível ou superior, pode usar simultaneamente um fio da magia do feitiço para criar uma barreira mágica em você que dura até você terminar um <span class="dc-termo">descanso longo</span>. A barreira tem pontos de vida iguais ao dobro do seu nível de mago + o seu modificador de <span class="dc-termo">Inteligência</span>. Sempre que sofre dano, a barreira sofre o dano no lugar. Se isso reduzir a barreira a 0 pontos de vida, você sofre qualquer dano restante.\nEnquanto a barreira tiver 0 pontos de vida, ela não pode absorver dano, mas sua magia permanece. Sempre que conjurar um feitiço de abjuração de 1° nível ou superior, a barreira recupera um número de pontos de vida igual ao dobro do nível do feitiço. Depois de criar a barreira, não pode criá-la novamente até terminar um <span class="dc-termo">descanso longo</span>.',
      },
      {
        nivel: 6,
        titulo: 'Barreira Projetada',
        corpo: 'Começando no 6° nível, quando uma criatura que você pode ver a até 9 metros de você sofre dano, você pode usar sua reação para fazer com que sua <span class="dc-termo">Barreira Arcana</span> absorva esse dano. Se isso reduzir a barreira a 0 pontos de vida, a criatura protegida sofre qualquer dano restante.',
      },
      {
        nivel: 10,
        titulo: 'Abjuração Aprimorada',
        corpo: 'Começando no 10° nível, ao conjurar um feitiço de abjuração que exige que você faça um teste de habilidade como parte do lançamento do feitiço (como em Contramágica e Dissipar Magia), você adiciona seu bônus de proficiência a esse teste de habilidade.',
      },
      {
        nivel: 14,
        titulo: 'Resistência a Feitiços',
        corpo: 'Começando no 14° nível, você tem <span class="dc-termo">vantagem</span> em testes de resistência contra feitiços. Além disso, você tem resistência contra o dano de feitiços.',
      },
    ],
  },
  {
    nome: 'Escola de Adivinhação',
    icone: '🔮',
    introTexto: 'O conselho de um adivinho é procurado tanto por realezas quanto por pessoas comuns, pois todos buscam uma compreensão mais clara do passado, presente e futuro. Como um adivinho, você se esforça para romper os véus do espaço, tempo e consciência para poder ver claramente. Você trabalha para dominar feitiços de discernimento, visão remota, conhecimento sobrenatural e previsão.',
    caracteristicas: [
      {
        nivel: 2,
        titulo: 'Sábio da Adivinhação',
        corpo: 'Começando quando você escolhe esta escola no 2° nível, o ouro e o tempo que você precisa gastar para copiar um feitiço de Adivinhação no seu grimório são reduzidos pela metade.',
      },
      {
        nivel: 2,
        titulo: 'Presságio',
        corpo: 'Começando no 2° nível, quando você escolhe esta escola, vislumbres do futuro começam a pressionar sua consciência. Quando você termina um <span class="dc-termo">descanso longo</span>, role dois d20s e registre os números rolados. Você pode substituir qualquer jogada de ataque, teste de resistência ou teste de habilidade feita por você ou por uma criatura que você possa ver por um desses valores previstos. Você deve escolher fazer isso antes da jogada e só pode substituir uma jogada dessa maneira uma vez por turno.\nCada valor previsto só pode ser usado uma vez. Quando você termina um <span class="dc-termo">descanso longo</span>, perde quaisquer valores previstos não utilizados.',
      },
      {
        nivel: 6,
        titulo: 'Leitura Profunda',
        corpo: 'Sua maestria em adivinhação permite que você penetre nas mentes e memórias dos outros, revelando segredos e informações ocultas. A partir do 6° nível, você ganha a capacidade de sondar as mentes de outras criaturas para acessar informações importantes sobre o passado, o presente e o futuro delas. Quando você entra em contato com uma criatura (por toque, ou enquanto está dentro de 9 metros dela), você pode gastar 1 ação para tentar acessar fragmentos de suas memórias ou pensamentos, fazendo uma das ações a seguir:',
        tabela: {
          colunaA: 'Ação',
          colunaB: 'Efeito',
          linhas: [
            { a: 'Visão do Passado', b: 'Você pode olhar para a memória de uma criatura e revelar eventos significativos de seu passado, especialmente os que podem fornecer pistas ou informações úteis. Você aprende até três fatos importantes que a criatura vivenciou em um período específico de sua vida, geralmente relacionado a momentos críticos como perdas, decisões importantes ou traumas.' },
            { a: 'Sondagem do Presente', b: 'Você pode acessar os pensamentos e sentimentos atuais de uma criatura, sondando sua mente para aprender suas intenções, emoções e planos imediatos. Isso pode revelar o que a criatura está tentando ocultar ou o que ela realmente pensa em relação a uma situação atual. Você aprende até três informações sobre o estado mental e emocional da criatura. Ela não tem consciência de que você está acessando seus pensamentos, mas pode sentir um desconforto, caso você pressione muito.' },
            { a: 'Visão do Futuro', b: 'Você pode tentar projetar o futuro imediato de uma criatura, acessando possibilidades e potenciais que podem ocorrer com base nas escolhas que ela está prestes a fazer. Você pode aprender uma ou mais possíveis consequências das ações dessa criatura nos próximos dias, semanas ou até mesmo horas. Você pode usar essa habilidade um número de vezes igual ao seu bônus de proficiência, recuperando os usos após um <span class="dc-termo">descanso longo</span>.' },
          ],
        },
      },
      {
        nivel: 10,
        titulo: 'O Terceiro Olho',
        corpo: 'Começando no 10° nível, você pode usar sua <span class="dc-termo">ação</span> para aumentar seus poderes de percepção. Quando fizer isso, escolha um dos seguintes benefícios, que dura até você ficar incapacitado ou terminar um <span class="dc-termo">descanso curto</span> ou <span class="dc-termo">descanso longo</span>. Você não pode usar essa característica novamente até terminar um <span class="dc-termo">descanso curto</span> ou <span class="dc-termo">descanso longo</span>.',
        tabela: {
          colunaA: 'Benefício',
          colunaB: 'Efeito',
          linhas: [
            { a: 'Visão no Escuro', b: 'Você ganha visão no escuro em um alcance de 18 metros.' },
            { a: 'Visão Etérea', b: 'Você pode ver no Plano Etéreo em um alcance de 18 metros.' },
            { a: 'Compreensão Maior', b: 'Você pode ler qualquer idioma.' },
            { a: 'Ver Invisibilidade', b: 'Você pode ver criaturas e objetos invisíveis a até 3 metros de você que estejam à vista.' },
            { a: 'Ver Verdadeira Forma', b: 'Você pode ver através de qualquer ilusão ou magia que altere a forma de uma criatura.' },
          ],
        },
      },
      {
        nivel: 14,
        titulo: 'Presságio Maior',
        corpo: 'Começando no 14° nível, as visões em seus sonhos se intensificam e pintam uma imagem mais precisa em sua mente do que está por vir. Você rola cinco d20s para sua característica de <span class="dc-termo">Presságio</span>, em vez de dois.',
      },
    ],
  },
  {
    nome: 'Escola da Conjuração',
    icone: '🌀',
    introTexto: 'Como conjurador, você favorece feitiços que produzem objetos e criaturas do nada. Você pode conjurar nuvens de névoa letal ou invocar criaturas de outro lugar para lutar em seu nome. Conforme sua maestria cresce, você aprende feitiços de transporte e pode se teleportar por grandes distâncias, até mesmo para outros planos de existência, em um instante.',
    caracteristicas: [
      {
        nivel: 2,
        titulo: 'Sábio da Conjuração',
        corpo: 'Começando quando você escolhe esta escola no 2° nível, o ouro e o tempo que você precisa gastar para copiar um feitiço de Conjuração no seu grimório são reduzidos pela metade.',
      },
      {
        nivel: 2,
        titulo: 'Conjuração Menor',
        corpo: 'Começando no 2° nível quando escolhe esta escola, você pode usar sua <span class="dc-termo">ação</span> para conjurar um objeto inanimado na sua mão ou no chão em um espaço desocupado que você pode ver dentro de 3 metros de você. Este objeto não pode ser maior que 1 metro de lado e pesar mais do que 5 kg, e sua forma deve ser a de um objeto não mágico que você tenha visto. O objeto é visivelmente mágico, irradiando uma luz fraca por até 1,5 metro. O objeto desaparece após 1 hora, quando você usa esta habilidade novamente ou se ele receber ou causar qualquer dano.',
      },
      {
        nivel: 6,
        titulo: 'Conjuração Focalizada',
        corpo: 'Começando no 6° nível, enquanto estiver concentrado em um feitiço de conjuração, sua concentração não pode ser quebrada como resultado de sofrer dano.',
      },
      {
        nivel: 10,
        titulo: 'Esconderijo Benigno',
        corpo: 'Começando no 10° nível, você cria uma semi plano somente seu; o semi plano é um espaço de vazio com atmosfera respirável de uma área (seu bônus de proficiência)³ metros. Você pode com sua <span class="dc-termo">ação</span> mandar um objeto que não esteja sendo carregado por outra criatura ou uma criatura voluntária para esse plano ou uma criatura voluntária. Com uma <span class="dc-termo">ação bônus</span> você pode conjurar a criatura ou objeto para até 3 metros de onde você está, se você entrar no plano, ele o manterá por até 12 horas, após isso você será jogado para fora no ponto livre mais próximo de onde você estava antes de entrar. Você pode sair antes utilizando uma <span class="dc-termo">ação</span> para voltar para o mesmo local.',
      },
      {
        nivel: 14,
        titulo: 'Invocações Duradouras',
        corpo: 'Começando no 14° nível, qualquer criatura que você invocar ou criar com um feitiço de conjuração tem a máxima vida possível. E possuem um bônus em sua CA e jogadas de ataque igual ao seu bônus de proficiência.',
      },
    ],
  },
  {
    nome: 'Escola do Encantamento',
    icone: '💫',
    introTexto: 'Como membro da Escola de Encantamento, você aprimorou sua habilidade de encantar e fascinar outras pessoas e monstros por meios mágicos. Alguns encantadores são pacificadores que enfeitiçam os violentos para que abaixem as armas e encantam os cruéis para que mostrem misericórdia. Outros são tiranos que prendem à força os relutantes em seu serviço. A maioria dos encantadores está em algum ponto entre esses extremos.',
    caracteristicas: [
      {
        nivel: 2,
        titulo: 'Sábio do Encantamento',
        corpo: 'Começando quando você seleciona esta escola no 2° nível, o ouro e o tempo que você deve gastar para copiar um feitiço de Encantamento no seu grimório são reduzidos pela metade.',
      },
      {
        nivel: 2,
        titulo: 'Olhar Hipnótico',
        corpo: 'Começando no 2° nível quando você escolhe esta escola, suas palavras suaves e seu olhar encantado podem magicamente enfeitiçar outra criatura. Como uma <span class="dc-termo">ação</span>, escolha uma criatura que você possa ver a até 1,5 metro de você. Se o alvo puder vê-lo ou ouvi-lo, ele deve ter sucesso em um teste de resistência de <span class="dc-termo">Sabedoria</span> contra o seu valor de CD de magia do mago ou será enfeitiçado por você até o final do seu próximo turno. A velocidade da criatura enfeitiçada é reduzida a 0, e ela fica incapacitada e visivelmente atordoada.\nEm turnos subsequentes, você pode usar sua <span class="dc-termo">ação</span> para manter esse efeito, estendendo sua duração até o final do seu próximo turno. No entanto, o efeito termina se você se mover a mais de 1,5 metro da criatura, se a criatura não puder vê-lo ou ouvi-lo ou se a criatura sofrer dano.\nUma vez que o efeito termine, ou se a criatura obtiver sucesso no seu teste de resistência inicial contra esse efeito, você não pode usar esta habilidade nessa criatura novamente até terminar um <span class="dc-termo">descanso longo</span>.',
      },
      {
        nivel: 6,
        titulo: 'Encanto Instintivo',
        corpo: 'A partir do 6° nível, quando uma criatura que você pode ver a até 9 metros de você fizer um teste de ataque contra você, você pode usar sua reação para desviar o ataque, desde que outra criatura esteja dentro do alcance do ataque. O atacante deve fazer um teste de resistência de <span class="dc-termo">Sabedoria</span> contra o seu valor de CD de magia do mago. Em caso de falha no teste, o atacante deve atacar a criatura mais próxima dele, excluindo você e ele próprio. Se houver várias criaturas próximas, o atacante escolhe qual atacar. Em caso de sucesso no teste, você não pode usar esta habilidade no atacante novamente até terminar um <span class="dc-termo">descanso longo</span>.\nVocê deve optar por usar esta habilidade antes de saber se o ataque acertou ou errou. Criaturas que não podem ser enfeitiçadas são imunes a esse efeito.',
      },
      {
        nivel: 10,
        titulo: 'Dividir Encantamento',
        corpo: 'A partir do 10° nível, ao lançar um feitiço de encantamento de 1° nível ou superior que tenha apenas uma criatura como alvo, você pode fazê-lo ter um número de alvos igual ao seu nível.',
      },
      {
        nivel: 14,
        titulo: 'Alterar Memórias',
        corpo: 'No 14° nível, você ganha a habilidade de fazer uma criatura não perceber sua influência mágica sobre ela. Ao lançar um feitiço de encantamento para enfeitiçar uma ou mais criaturas, você pode alterar o entendimento de uma criatura para que ela permaneça inconsciente de estar enfeitiçada.\nAlém disso, uma vez antes do feitiço expirar, você pode usar sua <span class="dc-termo">ação</span> para tentar fazer a criatura escolhida esquecer parte do tempo que passou enfeitiçada. A criatura deve ter sucesso em um teste de resistência de <span class="dc-termo">Inteligência</span> contra o seu valor de CD de magia do mago ou perder uma quantidade de horas de suas memórias igual a 1 + o seu modificador de <span class="dc-termo">Carisma</span> (mínimo de 1). Você pode fazer a criatura esquecer menos tempo, e o tempo esquecido não pode exceder a duração do seu feitiço de encantamento.',
      },
    ],
  },
  {
    nome: 'Escola da Evocação',
    icone: '🔥',
    introTexto: 'Você concentra seus estudos em magia que cria efeitos elementais poderosos, como frio intenso, chamas abrasadoras, trovão retumbante, relâmpagos estalantes e ácido corrosivo. Alguns evocadores encontram emprego em forças militares, atuando como artilharia para devastar exércitos inimigos de longe. Outros usam seu poder espetacular para proteger os fracos, enquanto alguns buscam ganho próprio como bandidos, aventureiros ou aspirantes a tiranos.',
    caracteristicas: [
      {
        nivel: 2,
        titulo: 'Sábio da Evocação',
        corpo: 'A partir do momento em que você seleciona esta escola no 2° nível, o ouro e o tempo que você deve gastar para copiar um feitiço de Evocação em seu grimório são reduzidos pela metade.',
      },
      {
        nivel: 2,
        titulo: 'Modelar Feitiços',
        corpo: 'A partir do 2° nível, você pode criar bolsões de relativa segurança dentro dos efeitos de seus feitiços de evocação. Quando você conjura um feitiço de evocação que afeta outras criaturas que você pode ver, você pode escolher um número delas igual a 1 + o nível do feitiço. As criaturas escolhidas têm sucesso automático em seus testes de resistência e não sofrem dano se normalmente sofreriam metade do dano em um sucesso de resistência.',
      },
      {
        nivel: 6,
        titulo: 'Impacto Devastador',
        corpo: 'A partir do 6° nível, se você conjurar uma magia de Evocação de 1° nível ou superior que cause dano, pode adicionar seu modificador de <span class="dc-termo">Inteligência</span> ao dano de um dos alvos atingidos. Além disso, sempre que rolar 1 em um dado de dano de magias de Evocação, você pode refazê-lo, mas deve usar o novo resultado.',
      },
      {
        nivel: 10,
        titulo: 'Evocação Aprimorada',
        corpo: 'A partir do 10° nível, sua magia é tão poderosa que pode desestabilizar completamente seus alvos. Sempre que uma criatura falhar em um teste de resistência contra uma magia de Evocação que você conjurar por 10 ou mais, ou quando você acertar um ataque mágico com um resultado que supere a CA do alvo em 10 ou mais, ela ficará Atordoada até o final do turno dela.',
      },
      {
        nivel: 14,
        titulo: 'Canalização Extrema',
        corpo: 'A partir do 14° nível, você pode aumentar o poder de seus feitiços mais simples. Quando você conjurar um feitiço de mago do 1° ao 5° nível que cause dano, pode causar o dano máximo com esse feitiço. Na primeira vez que você fizer isso, você não sofrerá nenhum efeito adverso. Se você usar esta habilidade novamente antes de terminar um <span class="dc-termo">descanso longo</span>, você sofrerá 1d4 de dano necrótico para cada nível do feitiço, imediatamente após conjurá-lo. Cada vez que você usar esta habilidade novamente antes de terminar um <span class="dc-termo">descanso longo</span>, o dano necrótico por nível do feitiço aumenta em 1d4.',
      },
    ],
  },
  {
    nome: 'Escola de Ilusão',
    icone: '🎭',
    introTexto: 'Você concentra seus estudos em magia que deslumbra os sentidos, confunde a mente e engana até mesmo os mais sábios. Sua magia é sutil, mas as ilusões criadas por sua mente perspicaz fazem o impossível parecer real. Alguns ilusionistas — incluindo muitos magos gnomos — são trapaceiros benignos que usam seus feitiços para entreter. Outros são mestres mais sinistros da decepção, usando suas ilusões para assustar e enganar outros para seu ganho pessoal.',
    caracteristicas: [
      {
        nivel: 2,
        titulo: 'Sábio da Ilusão',
        corpo: 'A partir do momento em que você seleciona esta escola no 2° nível, o ouro e o tempo que você deve gastar para copiar um feitiço de Ilusão em seu grimório são reduzidos pela metade.',
      },
      {
        nivel: 2,
        titulo: 'Ilusionista',
        corpo: 'Quando você escolhe esta escola no 2° nível, você aprende a magia Imagem Silenciosa. Você pode conjurar ela mesmo sem um grimório em mãos e não consome espaços de magia para conjurá-la.',
      },
      {
        nivel: 6,
        titulo: 'Ilusões Sutis',
        corpo: 'A partir do 6° nível, você não precisa de nenhum tipo de componente para conjurar uma magia de ilusão, e desde que você não esteja incapacitado, seu grimório pode permanecer invisível a todo momento.',
      },
      {
        nivel: 10,
        titulo: 'Autoilusão',
        corpo: 'A partir do 10° nível, você pode criar uma duplicata ilusória de si mesmo como uma reação instantânea, quase instintiva, ao perigo. Quando uma criatura faz um ataque contra você, você pode usar sua reação para interpor a duplicata ilusória entre o atacante e você. O ataque automaticamente erra contra você e, em seguida, a ilusão se dissipa. Depois de usar este recurso, você não pode usá-lo novamente até terminar um <span class="dc-termo">descanso curto</span> ou <span class="dc-termo">descanso longo</span>, ou até conjurar uma magia de ilusão de 2° nível ou superior.',
      },
      {
        nivel: 14,
        titulo: 'Miragem Sombria',
        corpo: 'A partir do 14° nível, você domina a arte de moldar ilusões em grande escala, criando cenários inteiros que obedecem à sua vontade. Você aprende a magia Miragem e pode conjurá-la sem gastar espaços de magia uma vez por <span class="dc-termo">descanso longo</span>.\nAlém disso, sempre que você conjurar Miragem, você pode fazê-lo como uma <span class="dc-termo">ação</span> em vez de 10 minutos. Enquanto a magia estiver ativa, você pode gastar uma <span class="dc-termo">ação bônus</span> para modificar qualquer parte da ilusão dentro do seu alcance, mudando sua aparência, forma, textura ou até mesmo deslocando objetos e estruturas ilusórias como desejar.',
      },
    ],
  },
  {
    nome: 'Escola de Necromancia',
    icone: '💀',
    introTexto: 'A Escola de Necromancia explora as forças cósmicas da vida, da morte e da não-vida. Ao concentrar seus estudos nessa tradição, você aprende a manipular a energia que anima todos os seres vivos. Conforme progride, você aprende a drenar a energia vital de uma criatura, à medida que sua magia destrói seu corpo, transformando essa energia vital em poder mágico que você pode manipular. A maioria das pessoas vê necromantes como ameaçadores, ou até mesmo vilões. Nem todos os necromantes são malignos, mas as forças que manipulam são consideradas tabu por muitas sociedades.',
    caracteristicas: [
      {
        nivel: 2,
        titulo: 'Sábio em Necromancia',
        corpo: 'A partir do momento em que você seleciona esta escola no 2° nível, o ouro e o tempo que você deve gastar para copiar um feitiço de Necromancia em seu grimório são reduzidos pela metade.',
      },
      {
        nivel: 2,
        titulo: 'Colheita Sombria',
        corpo: 'No 2° nível, quando você mata uma criatura, você pode consumir espaços de magia para capturar sua alma. A quantidade total de espaços de magia consumidos deve ser igual ao nível de desafio da criatura. Por exemplo, se a criatura tiver um ND de 3, você deve gastar espaços de magia de 3° nível ou superior, ou uma combinação de espaços de magia que somem esse valor. Após consumir os espaços de magia, você captura a alma da criatura, que fica presa a você. Como uma <span class="dc-termo">ação</span>, você pode libertar a alma da criatura e transformá-la em um morto-vivo sob seu controle. Isso cria uma versão zumbificada da criatura que mantém seus pontos de vida e habilidades como eram em vida, mas agora está sob seu comando. Você pode comandá-la com uma <span class="dc-termo">ação bônus</span> a cada turno, e ela segue suas ordens da maneira mais direta possível. A criatura permanece sob seu controle por um número de minutos igual ao ND da criatura multiplicado pelo seu bônus de proficiência. Após esse período, a alma da criatura é aprisionada novamente em seu grimório; você pode aprisionar uma criatura mais cedo a qualquer momento utilizando uma reação. Você pode conjurar a criatura novamente com uma <span class="dc-termo">ação</span> até um número de vezes igual ao seu bônus de proficiência, após todos os usos a criatura virá pó e é destruída. Você pode ter no máximo um número de mortos-vivos sob seu controle simultaneamente igual ao seu bônus de proficiência. Caso você mate uma nova criatura e capture sua alma enquanto já tiver o número máximo de mortos-vivos, você deverá liberar um dos já controla para fazer lugar.',
      },
      {
        nivel: 6,
        titulo: 'Servos Mortos-Vivos',
        corpo: 'No 6° nível, você adiciona o feitiço Animar Mortos ao seu grimório, se ele ainda não estiver lá. Ao lançar Animar Mortos, você pode mirar em um corpo ou pilha adicional de ossos, criando outro zumbi ou esqueleto, conforme apropriado. Sempre que você cria um morto-vivo usando um feitiço de necromancia, ele tem benefícios adicionais:\n<ul><li>O máximo de pontos de vida da criatura aumenta em uma quantia igual ao seu nível de mago.</li><li>A criatura adiciona o seu bônus de proficiência dela aos seus rolagens de dano de arma.</li></ul>',
      },
      {
        nivel: 10,
        titulo: 'Acostumado à Não-Vida',
        corpo: 'A partir do 10° nível, você tem resistência a dano necrótico e seu máximo de pontos de vida não pode ser reduzido. Você passou tanto tempo lidando com mortos-vivos e as forças que os animam que se acostumou a alguns de seus piores efeitos. Além disso, sua expectativa de vida é reduzida; a cada 10 anos que se passam, seu corpo envelhece apenas 1 ano.',
      },
      {
        nivel: 14,
        titulo: 'Onda de Dor',
        corpo: 'Como uma <span class="dc-termo">ação</span>, você pode forçar uma criatura dentro de 6 metros de você a fazer um teste de resistência de <span class="dc-termo">Constituição</span> contra sua CD de salvamento de magia. Se a criatura falhar, sua vida é reduzida em 1/4 do valor total dos pontos de vida máximos da criatura. Se essa redução de vida levar a criatura até 0 pontos de vida, você pode capturar sua alma sob seu controle, como descrito em sua habilidade <span class="dc-termo">Colheita Sombria</span>, e uma criatura capturada dessa forma recebe todos os bônus de sua habilidade de Servos Morto-vivos. Se a criatura passar no teste de resistência, ela não sofrerá redução de vida máxima. Após usar essa habilidade em uma criatura, você não poderá usá-la novamente na mesma criatura até que termine um <span class="dc-termo">descanso longo</span>.',
      },
    ],
  },
  {
    nome: 'Escola de Transmutação',
    icone: '⚗️',
    introTexto: 'Você é um estudante de feitiços que modificam energia e matéria. Para você, o mundo não é algo fixo, mas eminente mutável, e você se delicia em ser um agente da mudança. Você manipula a matéria-prima da criação e aprende a alterar tanto formas físicas quanto qualidades mentais. Sua magia lhe dá ferramentas para se tornar um forjador na forja da realidade. Alguns transmutadores são inventores e brincalhões, transformando pessoas em sapos e convertendo cobre em prata para diversão e lucro ocasional. Outros dedicam-se seriamente aos estudos mágicos, buscando o poder dos deuses para criar e destruir mundos.',
    caracteristicas: [
      {
        nivel: 2,
        titulo: 'Sábio em Transmutação',
        corpo: 'A partir do momento em que você seleciona esta escola no 2° nível, o ouro e o tempo que você deve gastar para copiar um feitiço de Transmutação em seu grimório são reduzidos pela metade.',
      },
      {
        nivel: 2,
        titulo: 'Modelagem Arcana',
        corpo: 'Começando no momento em que você seleciona esta escola, você desenvolveu um controle refinado sobre a matéria, permitindo que você molde e transforme objetos à vontade. Como uma <span class="dc-termo">ação</span>, você pode tocar um objeto não mágico, de até 1 metro cúbico, e alterar sua forma sem modificar seu volume ou composição. Você pode reverter o objeto à sua forma original com outra <span class="dc-termo">ação</span>.',
      },
      {
        nivel: 6,
        titulo: 'Pedra Filosofal',
        corpo: 'Sua maestria em transfiguração permite criar pedras exóticas capazes de alterar sua própria forma ou a de outros. Com 10 minutos você pode criar uma quantidade de pedras igual ao seu bônus de proficiência que dão certos efeitos para aqueles que as seguram. Você pode escolher uma quantidade de efeitos que ficarão ativos ao mesmo tempo igual ao seu bônus de proficiência.',
        tabela: {
          colunaA: 'Efeito',
          colunaB: 'Benefício',
          linhas: [
            { a: 'Adrenalina Regenerativa', b: 'A criatura recupera 2 pontos de vida no início de cada um de seus turnos desde que ela esteja em combate.' },
            { a: 'Braços Poderosos', b: 'A criatura pode usar suas mãos para atacar com grande força, seu golpe corpo-a-corpo tem um bônus de +2 além de seus testes de força.' },
            { a: 'Camuflagem Orgânica', b: 'A pele da criatura se adapta ao ambiente, concedendo <span class="dc-termo">vantagem</span> em testes de <span class="dc-termo">Destreza</span> (Furtividade).' },
            { a: 'Carapaça Protetora', b: 'A pele da criatura se torna mais resistente, aumentando sua Classe de Armadura em +3, desde que não esteja usando escudo.' },
            { a: 'Cheiro Calmante', b: 'A criatura emite uma aura que acalma os outros ao seu redor. Criaturas têm <span class="dc-termo">desvantagem</span> em testes de Intimidação contra você.' },
            { a: 'Chicote da Cauda', b: 'Se a criatura possuir uma cauda, pode usá-la como um ataque de reação quando um inimigo errar um ataque corpo a corpo, causando 1d8 de dano contundente e reduzindo o <span class="dc-termo">deslocamento</span> da criatura em 3 metros.' },
            { a: 'Corpo Duro', b: 'Seus músculos se enrijecem, concedendo resistência a dano cortante e perfurante.' },
            { a: 'Densidade Controlada', b: 'Você pode tornar a criatura mais leve ou mais densa. Se ficar mais leve, ela tem <span class="dc-termo">deslocamento</span> aumentado em 3 metros e <span class="dc-termo">vantagem</span> em testes de Atletismo para saltar. Se ficar mais densa, ela recebe +1 na Classe de Armadura e <span class="dc-termo">vantagem</span> em testes de resistência de <span class="dc-termo">Constituição</span>.' },
            { a: 'Essência Etérea', b: 'A criatura pode passar através de superfícies sólidas de até 3 metros de espessura durante sua ação de movimento, como se fosse etérea.' },
            { a: 'Esqueleto Endurecido', b: 'A criatura tem resistência a dano de contusão e diminui em -10 o dano de qualquer ataque corpo a corpo que receba.' },
            { a: 'Fisiologia Alterada', b: 'A criatura pode respirar embaixo d\'água e ganha visão no escuro de 18 metros (se já possuir, sua visão no escuro dobra).' },
            { a: 'Fortitude Incansável', b: 'A criatura recebe <span class="dc-termo">vantagem</span> em testes de resistência contra venenos e doenças, além de ganhar imunidade à exaustão.' },
            { a: 'Gânglios Nervosos Acelerados', b: 'A criatura recebe um bônus de +5 em sua <span class="dc-termo">Iniciativa</span> e pode realizar um teste de resistência de <span class="dc-termo">Destreza</span> para evitar ser surpreendida.' },
            { a: 'Garras Afiadas', b: 'A criatura recebe garras naturais que causam 2d6 de dano cortante e têm a propriedade leve.' },
            { a: 'Gravidade Invertida', b: 'Você pode alterar a gravidade ao redor da criatura, permitindo que ela ande no teto ou flutue por até 30 metros de altura durante 1 minuto.' },
            { a: 'Mobilidade Aprimorada', b: 'A criatura ganha <span class="dc-termo">deslocamento</span> de voo, escalada ou natação igual à metade de seu <span class="dc-termo">deslocamento</span> base.' },
            { a: 'Mordida Voraz', b: 'A criatura pode morder como um ataque desarmado, causando 1d10 de dano perfurante, e recupera pontos de vida iguais ao dano causado, uma vez por turno.' },
            { a: 'Olhos de Aranha', b: 'A criatura pode enxergar em um raio de 18 metros através de superfícies transparentes, como vidro, e pode ver através de neblina ou escuridão mágica.' },
            { a: 'Olhos de Falcão', b: 'A criatura enxerga a três vezes a distância normal e tem <span class="dc-termo">vantagem</span> em testes de <span class="dc-termo">Sabedoria</span> (Percepção) que dependam da visão.' },
            { a: 'Pulso Energético', b: 'A criatura pode liberar um pequeno pulso de energia arcana ao fazer um ataque corpo a corpo, causando 1d6 de dano elétrico adicional no ataque.' },
            { a: 'Reflexo Rápido', b: 'A criatura pode usar sua reação para diminuir 1d6 de dano sofrido de um ataque.' },
            { a: 'Reflexos Aprimorados', b: 'A criatura ganha +2 na Classe de Armadura e <span class="dc-termo">vantagem</span> em testes de <span class="dc-termo">Destreza</span> (Reflexos) para evitar armadilhas ou ataques à distância.' },
            { a: 'Recomposição Regenerativa', b: 'A criatura ganha 1d6 pontos de vida temporários no início de cada turno.' },
            { a: 'Resistência Adaptativa', b: 'A criatura ganha resistência a um tipo de dano à sua escolha entre ácido, frio, elétrico, fogo, trovejante, necrótico ou radiante.' },
            { a: 'Superforça', b: 'A criatura recebe <span class="dc-termo">vantagem</span> em testes de Atletismo para levantar ou carregar objetos pesados e um bônus de +2 em dano com ataques corpo a corpo.' },
            { a: 'Teias ou Ventosas', b: 'A criatura pode andar em superfícies verticais ou tetos, sem precisar de testes.' },
            { a: 'Visão Psíquica', b: 'A criatura pode detectar criaturas invisíveis até 18 metros de distância.' },
            { a: 'Força de Vontade Imbatível', b: 'A criatura ganha <span class="dc-termo">vantagem</span> em testes de resistência contra efeitos que a fariam perder o controle, como medo ou encantamento.' },
            { a: 'Estabilidade Corporal', b: 'A criatura recebe imunidade a efeitos que a empurrariam, derrubariam ou restringiriam.' },
          ],
        },
        notaFinal: 'Você pode trocar o efeito de uma pedra que esteja até 9 metros de você sempre que conjurar uma magia de transmutação de 1° nível.',
      },
      {
        nivel: 10,
        titulo: 'Reciclagem Residual',
        corpo: 'A partir do 10° nível, conjurar magias de transmutação se torna tão natural para você que é capaz de aproveitar e reutilizar o excesso de energia arcana. Quando você conjurar uma magia de transmutação de mago de 2° nível ou superior usando um espaço de magia, você recupera um espaço de magia gasto. O espaço recuperado deve ser pelo menos um nível abaixo da magia que você conjurou e não pode ser superior ao 5° nível.',
      },
      {
        nivel: 14,
        titulo: 'Mestre Transmutador',
        corpo: 'A partir do 14° nível, você domina os segredos da transmutação a ponto de torná-la permanente e contínua com um ritual especial. Sempre que conjurar uma magia de transmutação de 5° nível ou inferior, você pode gastar 10 minutos extras durante a conjuração para aprimorá-la. Se o fizer, essa magia não requer concentração e sua duração se torna infinita. No entanto, você só pode manter um número dessas magias ativas igual ao seu modificador de <span class="dc-termo">Inteligência</span>. Se tentar aprimorar uma nova magia além desse limite, a magia aprimorada mais antiga se dissipa imediatamente. Além disso, você pode conjurar truques simultaneamente com qualquer magia de transmutação que esteja conjurando.',
      },
    ],
  },
];

// Escolha de subclasse — todo personagem escolhe uma subclasse em algum
// nível, independente da classe; por isso fica junto dos outros pontos
// fixos em Fundamentos da Classe, não na lista de características do
// Mago. As opções vêm do próprio array `subclasses`, pra não duplicar
// nome/ícone em dois lugares.
const subclasseEscolha = {
  titulo: 'Tradição Arcana',
  corpo: 'Quando alcança o 2° nível, você pode escolher uma Tradição Arcana, moldando sua prática de magia em uma das escolas. Sua escolha lhe concede características no 2° nível e novamente no 6°, 10° e 14° nível.',
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

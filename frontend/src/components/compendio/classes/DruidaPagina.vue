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
        <h2 class="dc-section-title">Progressão — O Druida</h2>
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
      <p class="dc-fundamentos-nota">Regras comuns a toda classe — não são exclusivas do Druida.</p>

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
                <span class="dc-prof-subtitulo">{{ pe.titulo }}<span v-if="pe.nota" class="dc-prof-nota"> · {{ pe.nota }}</span></span>
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
            <span class="dc-conjuracao-tipo-prefixo">O Druida é</span>
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
              :class="{ 'dc-chip-tipo-magia-ativo': t === tipoMagiaDruida, 'dc-chip-tipo-magia-inativo': t !== tipoMagiaDruida }"
              v-for="t in tiposDeMagia"
              :key="t"
            >{{ t.toUpperCase() }}</span>
          </div>

          <span class="dc-atributo-magia-rotulo">O Atributo de Conjuração do Druida</span>
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
  nome: 'Druida',
  subtitulo: 'Versão Épico',
  icone: '🍃',
  cor: '#2f7a3a',
  dadoDeVida: 'd6',
  dificuldade: 'Difícil',
  papeis: ['Suporte', 'Controle'],
};

const descricaoBlocos = [
  {
    titulo: null,
    paragrafos: [
      'Segurando uma vara nodosa feita em forma de um alto crescente de azevinho, um elfo convoca a fúria da tempestade e chama feixes arrebatadores de relâmpagos para golpear os orcs empunhando tochas que ameaçam a floresta.',
      'Agachado sob a relva em um alto penhasco na forma de um leopardo, um humano espreita fora da caverna de um gigante. Ele retorna lentamente para uma forma humana, em seguida lança feitiços e magicamente avisa os membros de sua tribo da abordagem de monstros.',
      'Brandindo uma lâmina feita de pura chama, um meio-elfo investe em uma massa de soldados esqueletos, irrompendo as influências mágicas antinaturais que deram às criaturas horrendas suas míseras vidas.',
      'Sejam chamando as forças elementares da natureza ou emulando as criaturas do mundo animal, druidas são uma encarnação da resistência, astúcia e fúria da natureza. Eles não reinvindicam maestria sobre a natureza. Ao invés disso, eles se veem como extensões da vontade indomável da natureza.',
    ],
  },
  {
    titulo: 'Poder da Natureza',
    paragrafos: [
      'Druidas reverenciam a natureza acima de tudo, ganhando suas magias e outros poderes mágicos seja da força da natureza em si ou de uma deidade da natureza. Muitos druidas buscam uma espiritualidade mística de união transcendente com a natureza ao invés de devoção a uma entidade divina, enquanto outros servem aos deuses da natureza selvagem, animais ou forças elementais. As antigas tradições druídicas às vezes são chamadas de Antiga Fé, em contraste à adoração dos deuses em templos e santuários.',
      'Magias de druida são orientadas à natureza e animais — o poder das presas e garras, do sol e da lua, do fogo e da tempestade. Druidas também ganham a habilidade de tomar formas animais e alguns druidas fazem um estudo particular desta prática, até o ponto de preferirem formas animais a suas formas naturais.',
    ],
  },
  {
    titulo: 'Preservar o Equilíbrio',
    paragrafos: [
      'Para druidas, a natureza existe em um equilíbrio precário. Os quatro elementos que compõem o mundo — ar, terra, fogo e água — devem permanecer em equilíbrio. Se um elemento ganhasse poder sobre os outros, o mundo poderia ser destruído, arrastado para um dos planos elementais e dividido em seus componentes elementares. Assim, druidas se opõem aos cultos do Mal Elemental e outros que promovem um elemento à exclusão dos outros.',
      'Druidas também são preocupados com o delicado balanço ecológico que sustenta a vida de plantas e animais e a necessidade de pessoas civilizadas viverem em harmonia com a natureza, não em oposição a ela. Druidas aceitam o que é cruel na natureza e odeiam o que é antinatural, incluindo aberrações (como tesoureiros e flagelomantais) e mortos-vivos (como zumbis e vampiros). Druidas às vezes conduzem ataques contra tais criaturas, especialmente quando os monstros invadem o território do druida.',
      'Druidas frequentemente são encontrados guardando lugares sagrados ou vigiando regiões de natureza intocada. Mas quando um perigo significante surge, ameaçando o balanço natural ou a terra que guardam, os druidas tomam um papel mais ativo em combater a ameaça, como aventureiros.',
    ],
  },
];

const vida = {
  prefixo: 'd',
  numero: '6',
  nivel1: '6 + seu bônus de Salvaguarda de Constituição + 1',
  niveisSuperiores: '6 + seu bônus de Salvaguarda de Constituição por nível de druida após o 1°',
};

const proficiencias = [
  { titulo: 'Testes de Resistência', itens: ['Inteligência', 'Sabedoria'], estilo: 'selos', icone: markRaw(IconeResistencia) },
  {
    titulo: 'Perícias',
    nota: 'escolha duas',
    itens: ['Arcana', 'Adestrar Animais', 'Intuição', 'Medicina', 'Natureza', 'Percepção', 'Religião', 'Sobrevivência'],
    icone: markRaw(IconePericias),
  },
];

const proficienciasEquipamento = [
  { titulo: 'Armadura', itens: ['Armaduras leves', 'Armaduras médias', 'Escudos'], nota: 'nunca feitos de metal' },
  { titulo: 'Armas', itens: ['Clavas', 'Adagas', 'Dardos', 'Azagaias', 'Maças', 'Bordões', 'Cimitarras', 'Foices', 'Fundas', 'Lanças'] },
  { titulo: 'Ferramentas', itens: ['Kit de herbalismo'] },
];

const equipamento = {
  intro: 'Você começa com o seguinte equipamento, além do equipamento concedido pelo seu antecedente:',
  itens: [
    { opcoes: ['Um escudo de madeira', 'Qualquer arma simples'] },
    { opcoes: ['Uma cimitarra', 'Qualquer arma corpo-a-corpo simples'] },
    { opcoes: ['Um pacote de estudioso', 'Um pacote de explorador'] },
    { opcoes: ['Armadura de couro, um pacote de aventureiro e um foco druídico'] },
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
  { nivel: 1, truquesConhecidos: 2, espacos: [2, SEM, SEM, SEM, SEM, SEM, SEM, SEM, SEM], caracteristicas: 'Druídico, Conjuração, Talento' },
  { nivel: 2, truquesConhecidos: 2, espacos: [3, SEM, SEM, SEM, SEM, SEM, SEM, SEM, SEM], caracteristicas: 'Forma Selvagem, Círculo Druídico' },
  { nivel: 3, truquesConhecidos: 2, espacos: [4, 2, SEM, SEM, SEM, SEM, SEM, SEM, SEM], caracteristicas: '-' },
  { nivel: 4, truquesConhecidos: 3, espacos: [4, 3, SEM, SEM, SEM, SEM, SEM, SEM, SEM], caracteristicas: 'Forma Selvagem (aprimorada)' },
  { nivel: 5, truquesConhecidos: 3, espacos: [4, 3, 2, SEM, SEM, SEM, SEM, SEM, SEM], caracteristicas: 'Talento' },
  { nivel: 6, truquesConhecidos: 3, espacos: [4, 3, 3, SEM, SEM, SEM, SEM, SEM, SEM], caracteristicas: 'Característica de Círculo' },
  { nivel: 7, truquesConhecidos: 3, espacos: [4, 3, 3, 1, SEM, SEM, SEM, SEM, SEM], caracteristicas: '-' },
  { nivel: 8, truquesConhecidos: 3, espacos: [4, 3, 3, 2, SEM, SEM, SEM, SEM, SEM], caracteristicas: 'Forma Selvagem (aprimorada)' },
  { nivel: 9, truquesConhecidos: 4, espacos: [4, 3, 3, 3, 1, SEM, SEM, SEM, SEM], caracteristicas: 'Poder Fortalecido' },
  { nivel: 10, truquesConhecidos: 4, espacos: [4, 3, 3, 3, 2, SEM, SEM, SEM, SEM], caracteristicas: 'Característica de Círculo, Talento' },
  { nivel: 11, truquesConhecidos: 4, espacos: [4, 3, 3, 3, 2, 1, SEM, SEM, SEM], caracteristicas: '-' },
  { nivel: 12, truquesConhecidos: 4, espacos: [4, 3, 3, 3, 2, 1, SEM, SEM, SEM], caracteristicas: '-' },
  { nivel: 13, truquesConhecidos: 5, espacos: [4, 3, 3, 3, 2, 1, 1, SEM, SEM], caracteristicas: '-' },
  { nivel: 14, truquesConhecidos: 5, espacos: [4, 3, 3, 3, 2, 1, 1, SEM, SEM], caracteristicas: 'Característica de Círculo, Corpo Atemporal' },
  { nivel: 15, truquesConhecidos: 5, espacos: [4, 3, 3, 3, 2, 1, 1, 1, SEM], caracteristicas: 'Talento' },
  { nivel: 16, truquesConhecidos: 5, espacos: [4, 3, 3, 3, 2, 1, 1, 1, SEM], caracteristicas: '-' },
  { nivel: 17, truquesConhecidos: 5, espacos: [4, 3, 3, 3, 2, 1, 1, 1, 1], caracteristicas: '-' },
  { nivel: 18, truquesConhecidos: 5, espacos: [4, 3, 3, 3, 3, 1, 1, 1, 1], caracteristicas: 'Magias da Besta' },
  { nivel: 19, truquesConhecidos: 5, espacos: [4, 3, 3, 3, 3, 2, 1, 1, 1], caracteristicas: 'Lendário' },
  { nivel: 20, truquesConhecidos: 5, espacos: [4, 3, 3, 3, 3, 2, 2, 1, 1], caracteristicas: 'Arquidruida, Talento' },
];

const conjuracaoTipo = 'Conjurador Completo';

const conjuracaoTexto =
  'Você prepara a lista de magias disponíveis selecionando-as da lista de magias de druida. Você seleciona um número de magias igual ao seu modificador de Sabedoria + seu nível de druida (mínimo de uma magia). Essas magias devem ser de níveis para os quais você possua espaços de magia. Você pode modificar sua lista de magias preparadas quando termina um descanso longo, gastando no mínimo 1 minuto por nível de magia preparada em preces e meditação. Você também pode conjurar qualquer magia de druida que conheça como um ritual, se ela possuir o descritor ritual, e usar um foco druídico como foco de conjuração das suas magias de druida.';

const tiposDeMagia = ['Natural', 'Divina', 'Arcana'];
const tipoMagiaDruida = 'Natural';

const fonteMagia =
  'O Druida extrai sua magia da essência divina da própria natureza, sendo capaz de utilizar a magia natural.';

const atributoConjuracao = {
  nome: 'Sabedoria',
  bonus: ['Sabedoria', 'Proficiência'],
  cd: ['8', 'Proficiência', 'Sabedoria'],
  nota: 'Os valores de Sabedoria e Proficiência usados são os bônus respectivos.',
};

const caracteristicas = [
  {
    nivel: 1,
    titulo: 'Druídico',
    corpo: 'Você conhece o Druídico, o idioma secreto dos druidas. Você pode falar esse idioma e usá-lo para deixar mensagens escondidas. Você e outros que conhecem esse idioma automaticamente veem tais mensagens. Outros perceberão a presença da mensagem se passarem num teste de <span class="dc-termo">Sabedoria</span> (Percepção) CD 15, mas não conseguirão decifrá-lo sem magia.',
  },
  {
    nivel: 2,
    titulo: 'Forma Selvagem',
    corpo: `A partir do 2° nível, você pode usar sua <span class="dc-termo">ação</span> para assumir magicamente a forma de uma besta que você já tenha visto antes. Você pode usar essa característica duas vezes. Você recupera os usos quando termina um <span class="dc-termo">descanso curto</span> ou <span class="dc-termo">descanso longo</span>.
Seu nível de druida determina as bestas em que você pode se transformar. Você pode se transformar em criaturas de até ¼ do seu nível de desafio.
Você pode continuar na forma de besta por um número de horas igual à metade do seu nível de druida (arredondado para baixo). Então, você volta a sua forma original, a não ser que você gaste outro uso dessa característica.
Você pode reverter a sua forma normal prematuramente usando uma <span class="dc-termo">ação bônus</span> no seu turno. Você reverte automaticamente se cair inconsciente, cair a 0 pontos de vida ou morrer.
Enquanto estiver transformado, as seguintes regras se aplicam:
<ul><li>Suas estatísticas de jogo são substituídas pelas estatísticas da besta, mas você mantém sua tendência, personalidade e valores de <span class="dc-termo">Inteligência</span>, <span class="dc-termo">Sabedoria</span> e <span class="dc-termo">Carisma</span>. Você também mantém suas proficiências em todas as suas perícias e testes de resistência, além de receber as proficiências da criatura. Se a criatura possuir a mesma proficiência que você e o bônus no bloco de estatística dela for maior que o seu, você usará o bônus da criatura no lugar do seu. Se a criatura possuir qualquer ação lendária ou de covil, você não pode usá-las.</li><li>Quando você se transforma, você assume os pontos de vida e Dados de Vida da criatura. Quando você reverte a sua forma normal, você retorna ao número de pontos de vida que tinha antes de se transformar. Porém, se você reverter como resultado de ter caído a 0 pontos de vida, todo dano excedente será transferido para a sua forma normal. Por exemplo, se você sofrer 10 pontos de dano em forma animal e tiver apenas 1 ponto de vida restante, você reverte e sofre 9 de dano. Contanto que o dano excedente não reduza você a 0 pontos de vida, você não cairá inconsciente.</li><li>Você não pode conjurar magias e sua capacidade de fala ou de realizar qualquer ação que requeira mãos são limitadas pelas capacidades da forma da besta que você assumiu. Transformar-se não interrompe sua concentração em uma magia que você já tenha conjurado, no entanto, nem previne você de realizar ações que são parte da conjuração, como convocar relâmpagos que você já tenha conjurado.</li><li>Você mantém os benefícios de todas as características de classe, raça ou outras fontes, e pode usá-las caso a nova forma seja fisicamente capaz de fazê-lo. No entanto, você não pode usar qualquer dos seus sentidos especiais, como visão no escuro, a não ser que a sua nova forma também tenha esse sentido.</li><li>Você pode escolher se o seu equipamento cai no chão no seu espaço, é assimilado à sua nova forma ou é usado por ela. Equipamentos vestidos e carregados funcionam normalmente, mas o Mestre decide qual equipamento é viável para a nova forma vestir ou usar, baseado na forma e tamanho da criatura. O seu equipamento não muda de forma ou tamanho para se adaptar à nova forma, e qualquer equipamento que a nova forma não possa vestir deve, ou cair no chão ou ser assimilado por ela. Equipamentos assimilados não terão efeito até você deixar a forma.</li></ul>`,
  },
  {
    nivel: 9,
    titulo: 'Poder Fortalecido',
    corpo: 'Quando você atinge o 9° nível você pode utilizar sua forma animal até três vezes a cada <span class="dc-termo">descanso curto</span> ao invés de 2.',
  },
  {
    nivel: 14,
    titulo: 'Corpo Atemporal',
    corpo: 'Começando no 14° nível, a magia primordial que você controla faz com que você envelheça mais lentamente. A cada 25 anos que passarem, seu corpo envelhece apenas 1.',
  },
  {
    nivel: 18,
    titulo: 'Magias da Besta',
    corpo: 'A partir do 18° nível, você pode conjurar muitas das suas magias em qualquer forma que assumir usando a <span class="dc-termo">Forma Selvagem</span>. Você pode realizar os componentes somáticos e verbais de uma magia de druida na forma de besta, mas você não é capaz de prover os componentes materiais.',
  },
  {
    nivel: 19,
    titulo: 'Lendário',
    corpo: 'Ao atingir o 19°, você pode escolher um <span class="dc-termo">talento</span> épico.',
  },
  {
    nivel: 20,
    titulo: 'Arquidruida',
    corpo: 'No 20° nível, você pode usar sua <span class="dc-termo">Forma Selvagem</span> um número ilimitado de vezes.\nAlém disso, você pode ignorar os componentes verbais e somáticos das suas magias de druida, assim como qualquer componente material que não tenha custo e não seja consumido pela magia. Você recebe esse benefício tanto na sua forma normal, quanto na forma de besta da sua <span class="dc-termo">Forma Selvagem</span>.',
  },
];

const subclasses = [
  {
    nome: 'Círculo das Estrelas',
    icone: '⭐',
    introTexto: 'O Círculo das Estrelas permite que os druidas utilizem o poder da luz das estrelas. Esses druidas rastreiam padrões celestiais desde tempos imemoriais, descobrindo segredos escondidos entre as constelações. Muitos druidas desse círculo mantêm registros das constelações e dos efeitos das estrelas no mundo. Alguns grupos documentam essas observações em sítios megalíticos, que servem como bibliotecas enigmáticas de conhecimento. Esses repositórios podem se manifestar na forma de círculos de pedra, pirâmides, petróglifos e templos subterrâneos; qualquer construção durável o suficiente para proteger o conhecimento sagrado do círculo, mesmo diante de grandes cataclismos.',
    caracteristicas: [
      {
        nivel: 2,
        titulo: 'Mapa Estelar',
        corpo: `No 2° nível, você criou um mapa estelar como parte de seus estudos celestiais. É um objeto minúsculo e pode servir como foco de conjuração para seus feitiços de druida. Você determina sua forma rolando na tabela de Mapa Estelar ou escolhendo uma.
Ao segurar este mapa, você obtém os seguintes benefícios:
<ul><li>Você aprende o truque Orientação.</li><li>Você prepara o feitiço Sentença de Guia. Ele é considerado um feitiço de druida para você e não conta como um dos feitiços que você pode ter preparado.</li><li>Você pode conjurar Sentença de Guia sem gastar um espaço de feitiço. Pode fazer isso um número de vezes igual ao seu bônus de proficiência e recupera todos os usos gastos quando termina um <span class="dc-termo">descanso longo</span>.</li></ul>
Se você perder o mapa, pode realizar uma cerimônia de 1 hora para criar magicamente um substituto. Esta cerimônia pode ser realizada durante um <span class="dc-termo">descanso curto</span> ou <span class="dc-termo">descanso longo</span> e destrói o mapa anterior.`,
      },
      {
        nivel: 2,
        titulo: 'Forma Estrelada',
        corpo: 'No 2° nível, você adquire a habilidade de usar o poder das constelações para alterar sua forma. Como uma <span class="dc-termo">ação bônus</span>, você pode gastar um uso de sua característica <span class="dc-termo">Forma Selvagem</span> para assumir uma forma estelar, em vez de se transformar em uma besta.\nEnquanto estiver em sua forma estelar, você mantém suas estatísticas do jogo, mas seu corpo se torna luminoso; suas articulações brilham como estrelas e linhas brilhantes as conectam como um mapa estelar. Essa forma emite luz brilhante em um raio de 3 metros e luz fraca por mais 3 metros adicionais. A forma dura por 10 minutos. Ela termina antecipadamente se você a dispensar (ação não necessária), ficar incapacitado, morrer ou usar essa característica novamente.\nSempre que assumir sua forma estelar, escolha uma das seguintes constelações para brilhar em seu corpo; sua escolha lhe concede certos benefícios enquanto estiver na forma:',
        tabela: {
          colunaA: 'Constelação',
          colunaB: 'Benefício',
          linhas: [
            { a: 'Arqueiro', b: 'Uma constelação de um arqueiro aparece em você. Quando ativar essa forma e como uma <span class="dc-termo">ação bônus</span> em seus turnos subsequentes enquanto ela durar, você pode fazer um ataque de magia à distância, lançando uma flecha luminosa que mira uma criatura a até 18 metros de você. Em um acerto, o ataque causa dano radiante igual a 1d8 + seu modificador de <span class="dc-termo">Sabedoria</span>.' },
            { a: 'Cálice', b: 'Uma constelação de um cálice de vida aparece em você. Sempre que conjurar um feitiço usando um espaço de feitiço que restaura pontos de vida a uma criatura, você ou outra criatura a até 9 metros de você podem recuperar pontos de vida iguais a 1d8 + seu modificador de <span class="dc-termo">Sabedoria</span>.' },
            { a: 'Dragão', b: 'Uma constelação de um sábio dragão aparece em você. Quando fizer um teste de <span class="dc-termo">Inteligência</span> ou <span class="dc-termo">Sabedoria</span>, ou uma jogada de salvaguarda de <span class="dc-termo">Constituição</span> para manter a concentração em um feitiço, você pode tratar o resultado de 9 ou menos no d20 como um 10.' },
          ],
        },
      },
      {
        nivel: 6,
        titulo: 'Presságio Cósmico',
        corpo: 'Quando alcançar o 6° nível, você aprende a usar seu mapa estelar para adivinhar a vontade dos cosmos. Sempre que terminar um <span class="dc-termo">descanso longo</span>, você pode consultar seu <span class="dc-termo">Mapa Estelar</span> para presságios. Quando o fizer, role um dado. Até terminar seu próximo <span class="dc-termo">descanso longo</span>, você ganha acesso a uma reação especial com base em se rolou um número par ou ímpar no dado:',
        tabela: {
          colunaA: 'Resultado',
          colunaB: 'Efeito',
          linhas: [
            { a: 'Favorável (par)', b: 'Sempre que uma criatura que você possa ver a até 9 metros de você estiver prestes a fazer um teste de ataque, uma salvaguarda ou um teste de habilidade, você pode usar sua reação para rolar um d6 e adicionar o número rolado ao total.' },
            { a: 'Desfavorável (ímpar)', b: 'Sempre que uma criatura que você possa ver a até 9 metros de você estiver prestes a fazer um teste de ataque, uma salvaguarda ou um teste de habilidade, você pode usar sua reação para rolar um d6 e subtrair o número rolado do total.' },
          ],
        },
        notaFinal: 'Você pode usar essa reação um número de vezes igual ao seu bônus de proficiência, e recupera todos os usos gastos quando termina um <span class="dc-termo">descanso longo</span>.',
      },
      {
        nivel: 10,
        titulo: 'Constelações Cintilantes',
        corpo: 'Ao atingir o 10° nível, as constelações de sua <span class="dc-termo">Forma Estrelada</span> melhoram. O 1d8 do Arqueiro e do Cálice se torna 2d8, e enquanto o Dragão estiver ativo, você tem uma velocidade de voo de 6 metros e pode planar.\nAlém disso, no início de cada um de seus turnos enquanto estiver em sua <span class="dc-termo">Forma Estrelada</span>, você pode mudar qual constelação brilha em seu corpo.',
      },
      {
        nivel: 14,
        titulo: 'Repleto de Estrelas',
        corpo: 'No 14° nível, enquanto estiver em sua <span class="dc-termo">Forma Estrelada</span>, você se torna parcialmente incorpóreo, concedendo a você resistência a dano de concussão, perfuração e cortante.',
      },
    ],
  },
  {
    nome: 'Círculo da Lua',
    icone: '🌙',
    introTexto: 'Os druidas do Círculo da Lua são guardiões ferozes das áreas selvagens. Sua ordem se reúne sob a lua cheia para compartilhar notícias e alertas. Eles assombram as partes mais profundas da natureza, onde podem passar semanas sem cruzar caminho com outra criatura humanoide, muito menos com outro druida. Trocáveis como a lua, um druida deste círculo pode vagar como grande felino uma noite, planar sobre as copas das árvores como uma águia no dia seguinte e, em forma de urso, abrir caminho pela vegetação para afugentar um monstro invasor. A natureza selvagem está no sangue do druida.',
    caracteristicas: [
      {
        nivel: 2,
        titulo: 'Forma Selvagem em Combate',
        corpo: 'Ao escolher este círculo no 2° nível, você ganha a habilidade de usar a <span class="dc-termo">Forma Selvagem</span> durante o seu turno como uma <span class="dc-termo">ação bônus</span>, em vez de uma <span class="dc-termo">ação</span>.\nAlém disso, enquanto estiver transformado pela <span class="dc-termo">Forma Selvagem</span>, você pode usar uma <span class="dc-termo">ação bônus</span> para gastar um espaço de magia para recuperar pontos de vida de 1d8 por nível do espaço de magia gasto.',
      },
      {
        nivel: 2,
        titulo: 'Formas do Círculo',
        corpo: 'Os ritos do seu círculo concedem a você a habilidade de se transformar em formas animais mais perigosas. A partir do 2° nível, você pode usar a sua <span class="dc-termo">Forma Selvagem</span> para se transformar em uma besta com um desafio com um valor tão alto quanto 1. Você ignora a coluna "Máx. CR" da tabela de Formas de Besta, mas deve obedecer às outras limitações ali.\nA partir do 6° nível, você pode se transformar em uma besta com um desafio igual ao seu nível de druida dividido por 2, arredondado para baixo.',
      },
      {
        nivel: 6,
        titulo: 'Ataque Primal',
        corpo: 'A partir do 6° nível, seus ataques em forma de besta são considerados mágicos para superar resistências e imunidades a ataques e danos não mágicos. Além disso, todas as suas formas animais vêm com o máximo de pontos de vida possível.',
      },
      {
        nivel: 10,
        titulo: 'Forma Selvagem Elemental',
        corpo: 'No 10° nível, você pode gastar dois usos da <span class="dc-termo">Forma Selvagem</span> ao mesmo tempo para se transformar em um elemental da terra, um elemental do ar, um elemental do fogo ou um elemental da água.',
      },
      {
        nivel: 14,
        titulo: 'Mil Formas',
        corpo: 'Ao atingir o 14° nível, você aprendeu a usar a natureza em sua forma mais bruta, agora você é capaz de se transformar em fadas em sua forma animal.',
      },
    ],
  },
  {
    nome: 'Círculo das Ondas',
    icone: '🌊',
    introTexto: 'O Círculo das Ondas é um caminho druídico entrelaçado às águas do mundo, um vínculo profundo com os mares, rios e os mistérios aquáticos. Os membros deste círculo abraçam a fluidez e a vitalidade das correntes, buscando a harmonia com as marés e a sabedoria dos oceanos. Comungando com as águas e seus habitantes, esses druidas tornam-se guardiões dos segredos das profundezas, capazes de canalizar as energias aquáticas para curar, proteger e até mesmo moldar as próprias águas conforme sua vontade. Para eles, cada gota de água é um elo sagrado com a essência da vida, e seu compromisso é preservar e equilibrar os tesouros aquáticos do mundo natural.',
    caracteristicas: [
      {
        nivel: 2,
        titulo: 'Magia de Círculo',
        corpo: 'Suas viagens e conexão com os mares concederam a você a capacidade de lançar certos feitiços. Depois de obter acesso a um feitiço de círculo, você sempre o tem preparado e não conta no número de feitiços que você pode preparar a cada dia. Se ganhar acesso a uma magia que não aparece na lista de magias de druida, a magia, no entanto, será uma magia de druida para você.',
        tabela: {
          colunaA: 'Nível do Druida',
          colunaB: 'Magias',
          linhas: [
            { a: '3º', b: 'Criar e Destruir Água, Tromba D\'Água' },
            { a: '5º', b: 'Muralha de Água, Maremoto' },
            { a: '7º', b: 'Esfera Aquosa, Controlar a Água' },
            { a: '9º', b: 'Redemoinho, Presas D\'Água, Dragão dos Mares' },
          ],
        },
      },
      {
        nivel: 2,
        titulo: 'Um com o Mar',
        corpo: 'Quando você escolhe este círculo no 2° nível, você ignora as limitações para criaturas com velocidade de natação, mas apenas pode se transformar em criaturas que possuam velocidade de natação, e o Nível de Desafio máximo para seu recurso <span class="dc-termo">Forma Selvagem</span> é 1, desde que a besta tenha uma velocidade de natação inata. Caso contrário, você deve obedecer às outras regras da <span class="dc-termo">Forma Selvagem</span>. No 6° nível, o Nível de Desafio máximo aumenta para 2, desde que a besta tenha uma velocidade de natação inata.',
      },
      {
        nivel: 2,
        titulo: 'Um Coração Amigo',
        corpo: `Quando você escolhe este círculo no 2° nível, você pode, ao custo de um uso de sua <span class="dc-termo">Forma Selvagem</span>, invocar um espírito elemental de água que aparece ao seu lado. O elemental faz parte da sua alma e obedece aos seus comandos. Com uma <span class="dc-termo">ação</span> você pode invocar o elemental em um ponto até 3 metros e como parte dessa mesma <span class="dc-termo">ação</span>, comandar o Espírito Elemental. Você deve utilizar sua <span class="dc-termo">ação</span> nos turnos subsequentes para comandar o Espírito Elemental. O elemental desaparecer após um número de horas igual à metade do seu nível de druida (arredondado para baixo) ou até você utilizando uma <span class="dc-termo">ação</span> para o recolher. Você deve se concentrar para manter o elemental como se estivesse se concentrando em uma magia. Você pode escolher o tamanho do Espírito Elemental ao invocá-lo, com o tamanho máximo sendo médio. A categoria de tamanho máximo aumenta em um a cada dois níveis de Druida após o segundo.
O Espírito Elemental possui as seguintes estatísticas:
<ul><li><strong>Classe de Armadura:</strong> 13 + Metade do seu nível de Druida arredondado para baixo (Armadura Natural)</li><li><strong>Pontos de Vida:</strong> 10 para cada nível de Druida</li><li><strong>Velocidade:</strong> 9 metros de natação, 3 metros (+3 metros para cada nível de Druida)</li><li><strong>Resistência a dano:</strong> ácido e concussão</li><li><strong>Imunidade a dano:</strong> veneno e gélido</li><li><strong>Imunidade a condição:</strong> exaustão, agarrado, impedido, assustado, paralisado, petrificado, envenenado, inconsciente</li><li><strong>Sentidos:</strong> visão no escuro 18 metros, Percepção passiva 10</li><li><strong>Linguagens:</strong> Primordial, entende as línguas que você fala</li><li><strong>Bônus de Proficiência:</strong> igual ao seu bônus</li></ul>
<strong>Forma Amorfa.</strong> O elemental pode se mover por um espaço tão estreito quanto 2,5 centímetros de largura sem apertar.
<strong>Berço de Água (6° Nível).</strong> O Espírito Elemental cura a si mesmo ou uma criatura à sua escolha dele em 1,5 metro de distância em 1d6 + seu Bônus de Proficiência no final do seu turno se ele permanecer submerso em água.
<strong>Monstro de Cerco (14° Nível).</strong> O Espírito Elemental dá o dobro de dano contra estruturas. Além de contar como uma criatura de duas categorias de tamanho maior para definir o quanto ele pode carregar ou mover.
<strong>Comandar as Águas (10° nível).</strong> O Espírito Elemental comanda um corpo de água que pode ver de até 9 metros quadrados, assim como no efeito da magia Controlar a Água.
<strong>Ações:</strong>
<strong>Ataques Múltiplos.</strong> O elemental faz um número de ataques igual ao seu nível de druida dividido por 4, arredondado para baixo (no mínimo 1). Ou realiza uma ação especial se possuir.
<strong>Golpe de Água.</strong> Ataque em uma área que ela possa ver até 9 metros de 1,5 metro de diâmetro. Todas as criaturas na área devem realizar um teste de <span class="dc-termo">Destreza</span> CD 14 ou sofrem (1d8 + FOR + metade do seu nível de druida) de dano de concussão. Uma criatura sofre metade do dano se passar.`,
      },
      {
        nivel: 6,
        titulo: 'Espírito Gentil',
        corpo: 'A partir do 6° nível, enquanto você estiver com seu espírito invocado, você pode respirar na água. Além disso, a magia Criar e Destruir Água se torna mais poderosa para você. A magia, ao invés de seus efeitos normais, agora cria 50 litros de água e não pode mais destruir. Além de que, se conjurada em níveis superiores a quantidade de litros conjurada é potencialmente aumentada a cada dois níveis de conjuração. Exemplo: se conjurada como magia de 2° ou 3° nível a quantidade de litros aumenta para 50² litros. Além disso, você pode com uma <span class="dc-termo">ação bônus</span> ao custo de 50 litros de água, criar um líquido com propriedade curandeiras e curar uma criatura ferida que você possa ver até 1,5 metro de você. Essa criatura recupera 1 ponto de vida.',
      },
      {
        nivel: 10,
        titulo: 'Mente Amorfa',
        corpo: 'Quando você atinge o 10° nível, você ganha a capacidade de invocar e comandar o <span class="dc-termo">Espírito Elemental</span> com <span class="dc-termo">ação bônus</span>. Controlar o Espírito Elemental não necessita mais de concentração.',
      },
      {
        nivel: 14,
        titulo: 'Berço da Criação',
        corpo: `No 14° nível, enquanto você ou seu Espírito Elemental estiverem submersos em água vocês recebem os seguintes benefícios:
<ul><li>Seus movimentos não provocam ataques de oportunidade.</li><li>Você é imune às condições exausto, agarrado, impedido, assustado, paralisado, petrificado, envenenado, inconsciente.</li><li>O ataque e habilidades do Espírito Elemental, além das suas magias de círculo, dobram de alcance e dano.</li><li>O Espírito Elemental recebe resistência a todos os danos menos Ígneo e Força.</li><li>Os modificadores de <span class="dc-termo">Força</span>, <span class="dc-termo">Destreza</span> e <span class="dc-termo">Constituição</span> do Espírito Elemental se tornam iguais ao seu modificador de <span class="dc-termo">Carisma</span>.</li></ul>
O elemental só pode se beneficiar desses benefícios por no máximo 1 minuto contínuo, por invocação.`,
      },
    ],
  },
  {
    nome: 'Círculo dos Sonhos',
    icone: '💤',
    introTexto: 'O Círculo dos Sonhos é tecido pelos druidas provenientes de regiões profundamente ligadas ao Feywild e seus reinos oníricos. A guarda destes druidas sobre o mundo natural estabelece uma aliança natural com seres feéricos aliados ao bem. Eles buscam preencher o mundo com maravilhas oníricas. Sua magia cura feridas e traz alegria aos corações desalentados, e os reinos que protegem são lugares reluzentes e frutíferos, onde sonho e realidade se misturam e onde os cansados podem encontrar descanso.',
    caracteristicas: [
      {
        nivel: 2,
        titulo: 'Bálsamo da Corte de Verão',
        corpo: 'Ao atingir o 2° nível, você é imbuído com as bênçãos da Corte de Verão. Você se torna uma fonte de energia que oferece alívio para ferimentos. Você tem um reservatório de energia feérica representado por um número de d6s igual ao seu nível de druida.\nComo uma <span class="dc-termo">ação bônus</span>, você pode escolher um aliado que você possa ver dentro de 36 metros de você e gastar um número desses dados igual à metade do seu nível de druida ou menos. Role os dados gastos e some os valores. O alvo recupera um número de pontos de vida igual ao total. O alvo também ganha 1 ponto de vida temporário por dado gasto.\nVocê recupera os dados gastos quando termina um <span class="dc-termo">descanso longo</span>.',
      },
      {
        nivel: 6,
        titulo: 'Lar da Luz da Lua e das Sombras',
        corpo: 'Ao alcançar o 6° nível, seu lar pode ser onde quer que você esteja. Durante um <span class="dc-termo">descanso curto</span> ou <span class="dc-termo">descanso longo</span>, você pode invocar o poder sombrio da Corte do Anoitecer para ajudar a proteger seu repouso. No início do descanso, você toca um ponto no espaço, e uma esfera mágica invisível com raio de 9 metros aparece, centrada naquele ponto. Cobertura total bloqueia a esfera.\nEnquanto estiver dentro da esfera, você e seus aliados ganham um bônus de +5 em testes de <span class="dc-termo">Destreza</span> (Furtividade) e <span class="dc-termo">Sabedoria</span> (Percepção), e qualquer luz de chamas abertas na esfera (fogueira, tochas ou similar) não é visível do lado de fora dela.\nA esfera desaparece no final do descanso ou quando você sair dela.',
      },
      {
        nivel: 10,
        titulo: 'Caminhos Ocultos',
        corpo: 'A partir do 10° nível, você pode usar os caminhos mágicos ocultos que alguns seres feéricos usam para atravessar o espaço num piscar de olhos. Como uma <span class="dc-termo">ação bônus</span> no seu turno, você pode se teleportar até 18 metros para um espaço desocupado que você possa ver. Alternativamente, você pode usar sua <span class="dc-termo">ação</span> para teleportar uma criatura disposta que você toca até 9 metros para um espaço desocupado que você possa ver.\nVocê pode usar esta habilidade um número de vezes igual ao seu bônus de proficiência. Recupera todos os usos gastos quando termina um <span class="dc-termo">descanso curto</span> ou <span class="dc-termo">descanso longo</span>.',
      },
      {
        nivel: 14,
        titulo: 'Caminhante nos Sonhos',
        corpo: 'No 14° nível, a magia do Feywild concede a você a habilidade de viajar mental ou fisicamente através dos planos dos sonhos.\nQuando termina um <span class="dc-termo">descanso curto</span>, você pode conjurar um dos seguintes feitiços, sem gastar um espaço de feitiço ou requerer componentes materiais: Sonho (com você como o mensageiro), Observar, ou Círculo de Teletransporte.\nO uso de Círculo de Teletransporte é especial. Em vez de abrir um portal para um círculo de teletransporte permanente, ele abre um portal para o último local onde você terminou um <span class="dc-termo">descanso longo</span> em seu plano de existência atual. Se você não tiver feito um <span class="dc-termo">descanso longo</span> em seu plano atual, o feitiço falha, mas não é desperdiçado.\nDepois de usar esta característica, você não pode usá-la novamente até terminar um <span class="dc-termo">descanso longo</span>.',
      },
    ],
  },
  {
    nome: 'Círculo da Terra',
    icone: '🪨',
    introTexto: 'O Círculo da Terra é composto por místicos e sábios que protegem conhecimentos ancestrais e rituais através de uma vasta tradição oral. Esses druidas se reúnem em círculos sagrados de árvores ou pedras eretas para sussurrar segredos primais no Druida. Os membros mais sábios do círculo presidem como os sacerdotes principais de comunidades que aderem à Antiga Fé e servem como conselheiros dos governantes dessas pessoas. Como membro desse círculo, sua magia é influenciada pela terra onde você foi iniciado nos ritos misteriosos do círculo.',
    caracteristicas: [
      {
        nivel: 2,
        titulo: 'Truque Adicional',
        corpo: 'Quando você escolhe esse círculo no 2° nível, você aprende um truque de druida adicional, à sua escolha.',
      },
      {
        nivel: 2,
        titulo: 'Recuperação Natural',
        corpo: 'A partir do 2° nível, você pode recuperar parte da sua energia mágica parando para fazer uma meditação e comunhão com a natureza. Durante um <span class="dc-termo">descanso curto</span>, você escolhe espaços de magia gastos para recuperar. O espaço de magia pode ter um nível combinado igual ou menor que metade do seu nível de druida (arredondado para baixo), e nenhum dos espaços pode ser de magia de 6° nível ou superior. Você não pode usar essa característica novamente até terminar um <span class="dc-termo">descanso longo</span>.\nPor exemplo, quando você for um druida de 4° nível, você pode recuperar até dois níveis em espaços de magia. Você pode recuperar, tanto uma magia de 2° nível, quanto duas magias de 1° nível.',
      },
      {
        nivel: 3,
        titulo: 'Magias de Círculo',
        corpo: 'Sua conexão mística com a terra infunde você com a habilidade de conjurar certas magias. No 3°, 5°, 7° e 9° nível, você ganha acesso a magias de círculo ligadas ao terreno em que você se tornou druida. Escolha o terreno — ártico, costa, deserto, floresta, montanha, pântano, planície ou subterrâneo — e consulte a lista de magias associadas.\nUma vez que você tenha acesso a uma magia de círculo, você sempre poderá prepará-la e ela não conta no número de magias que você pode preparar a cada dia. Se você tiver acesso a uma magia de druida que não aparece na lista de magias de druida, a magia, no entanto, será uma magia de druida para você.',
        tabela: {
          colunaA: 'Terreno',
          colunaB: 'Magias (3º · 5º · 7º · 9º)',
          linhas: [
            { a: 'Ártico', b: '3º: Imobilizar Pessoa, Crescer Espinho · 5º: Nevasca, Lentidão · 7º: Movimentação Livre, Tempestade de Gelo · 9º: Comunhão com a Natureza, Cone de Frio' },
            { a: 'Costa', b: '3º: Passo Nebuloso, Reflexos · 5º: Andar na Água, Respirar Água · 7º: Movimentação Livre, Controlar a Água · 9º: Vidência, Conjurar Elemental' },
            { a: 'Deserto', b: '3º: Nublar, Silêncio · 5º: Criar Alimentos, Proteção contra Energia · 7º: Praga, Terreno Alucinógeno · 9º: Muralha de Pedra, Praga de Insetos' },
            { a: 'Floresta', b: '3º: Patas de Aranha, Pele de Árvore · 5º: Convocar Relâmpagos, Crescer Plantas · 7º: Adivinhação, Movimentação Livre · 9º: Comunhão com a Natureza, Passo de Árvore' },
            { a: 'Montanha', b: '3º: Crescer Espinho, Patas de Aranha · 5º: Mesclar-se às Rochas, Relâmpago · 7º: Moldar Rochas, Pele de Pedra · 9º: Criar Passagem, Muralha de Pedra' },
            { a: 'Pântano', b: '3º: Escuridão, Flecha Ácida · 5º: Andar na Água, Névoa Fétida · 7º: Localizar Criatura, Movimentação Livre · 9º: Vidência, Praga de Insetos' },
            { a: 'Planície', b: '3º: Invisibilidade, Passos sem Pegadas · 5º: Luz do Dia, Velocidade · 7º: Adivinhação, Movimentação Livre · 9º: Praga de Insetos, Sonho' },
            { a: 'Subterrâneo', b: '3º: Patas de Aranha, Teia · 5º: Forma Gasosa, Névoa Fétida · 7º: Invisibilidade Maior, Moldar Rochas · 9º: Praga de Insetos, Névoa Mortal' },
          ],
        },
      },
      {
        nivel: 6,
        titulo: 'Caminho da Floresta',
        corpo: 'A partir do 6° nível, mover-se através de terreno difícil não-mágico não te custará nenhum movimento extra. Você também pode passar através de plantas não-mágicas sem ser atrasado por elas e sem sofrer dano delas se elas tiverem espinhos, espinhas ou perigos similares. Além disso, você tem imunidade contra plantas criadas magicamente ou manipuladas para impedir movimentação, como as criadas pela magia constrição. Além disso você jamais pode se perder enquanto estiver no plano material ou em faeria.',
      },
      {
        nivel: 6,
        titulo: 'Especialista',
        corpo: 'A partir do 6° nível, você recebe uma magia que define sua marca e características. Escolha uma das seguintes opções, você pode conjurar essas magias à vontade sem necessidade de componentes materiais. Escolha entre:\n<ul><li>Moldar Rochas</li><li>Vinhas Esmagadoras</li><li>Guardião da Natureza</li><li>Controlar a Água</li></ul>',
      },
      {
        nivel: 10,
        titulo: 'Proteção Natural',
        corpo: 'Quando você atingir o 10° nível, você não pode ser enfeitiçado, amedrontado ou impedido e você se torna imune a venenos e doenças, além de resistência a dano de ácido e perfurante.',
      },
      {
        nivel: 14,
        titulo: 'Santuário Natural',
        corpo: 'A partir do 14° nível, a terra o abençoa como um santuário para sua criação. Enquanto você estiver no plano Material, Faeria ou em algum dos planos elementais, você sempre estará sob o efeito da magia Santuário. Se você for alvo da magia dissipar magia, o santuário desaparece e retorna no começo do seu próximo turno.',
      },
    ],
  },
];

// Escolha de subclasse — todo personagem escolhe uma subclasse em algum
// nível, independente da classe; por isso fica junto dos outros pontos
// fixos em Fundamentos da Classe, não na lista de características do
// Druida. As opções vêm do próprio array `subclasses`, pra não duplicar
// nome/ícone em dois lugares.
const subclasseEscolha = {
  titulo: 'Círculo Druídico',
  corpo: 'No 2° nível, você escolhe se identificar com um círculo de druidas. Sua escolha lhe concede características no 2° nível e novamente no 6°, 10° e 14° nível.',
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

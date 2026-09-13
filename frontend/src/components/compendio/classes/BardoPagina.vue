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
        <h2 class="dc-section-title">Progressão — O Bardo</h2>
        <span class="dc-title-line"></span>
      </div>
      <div class="dc-tabela-wrap">
        <table class="dc-tabela-niveis">
          <thead>
            <tr>
              <th rowspan="2">Nível</th>
              <th rowspan="2">Características</th>
              <th rowspan="2" class="dc-th-centro">Magias Conhecidas</th>
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
              <td class="dc-tabela-bonus">{{ n.magiasConhecidas }}</td>
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
      <p class="dc-fundamentos-nota">Regras comuns a toda classe — não são exclusivas do Bardo.</p>

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
            <span class="dc-conjuracao-tipo-prefixo">O Bardo é</span>
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
              :class="{ 'dc-chip-tipo-magia-ativo': t === tipoMagiaBardo, 'dc-chip-tipo-magia-inativo': t !== tipoMagiaBardo }"
              v-for="t in tiposDeMagia"
              :key="t"
            >{{ t.toUpperCase() }}</span>
          </div>

          <span class="dc-atributo-magia-rotulo">O Atributo de Conjuração do Bardo</span>
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
  nome: 'Bardo',
  subtitulo: 'Versão Épico',
  icone: '🎻',
  cor: '#8c4a7a',
  dadoDeVida: 'd8',
  dificuldade: 'Difícil',
  papeis: ['Suporte', 'Utilidade'],
};

const descricaoBlocos = [
  {
    titulo: null,
    paragrafos: [
      'Cantarolando enquanto passa os dedos sobre um monumento antigo em uma ruína há muito esquecida, uma meio-elfa em couros rústicos sente o conhecimento brotar em sua mente, conjurado pela magia de sua canção — o conhecimento do povo que construiu o monumento e da saga mítica que ele retrata.',
      'Um severo guerreiro humano bate sua espada ritmicamente contra sua cota de escamas, marcando o compasso para seu canto de guerra e exortando seus companheiros à bravura e ao heroísmo. A magia de sua canção os fortalece e os encoraja.',
      'Rindo enquanto afina sua cítara, uma gnomo tece sua magia sutil sobre os nobres reunidos, garantindo que as palavras de seus companheiros sejam bem recebidas.',
      'Seja erudito, escaldo ou vigarista, um bardo tece magia através de palavras e música para inspirar aliados, desmoralizar inimigos, manipular mentes, criar ilusões e até mesmo curar feridas.',
    ],
  },
  {
    titulo: 'Música e Magia',
    paragrafos: [
      'Nos mundos de D&D, palavras e música não são apenas vibrações de ar, mas vocalizações com poder próprio. O bardo é um mestre de canções, discursos e magia que eles contêm. Bardos dizem que o multiverso foi falado à existência, que as palavras dos deuses deram-lhe forma, e que os ecos dessas Palavras Primordiais da Criação ainda ressoam através do cosmos. A música dos bardos é uma tentativa de alcançar e controlar essas palavras, falá-las ou cantá-las novamente sutilmente, para influenciar o mundo ao redor deles.',
      'A maior força de um bardo é a versatilidade. Muitos bardos preferem se manter fora do combate, usando sua magia para inspirar seus aliados e dificultar seus inimigos à distância. Mas bardos são capazes de se defender em combate corpo-a-corpo, se necessário, usando sua magia para fortalecer suas espadas e armaduras. Suas magias se inclinam para charme e ilusões ao invés de magias de evocação imediatamente destrutivas. Eles possuem um vasto conhecimento sobre muitas coisas, e uma aptidão natural que permite que eles façam quase tudo bem. Os bardos se tornam mestres dos talentos que escolhem aperfeiçoar, de performance musical à conhecimento esotérico.',
    ],
  },
  {
    titulo: 'Aprendendo com Experiência',
    paragrafos: [
      'Bardos verdadeiros não são comuns no mundo. Nem todo menestrel cantando em uma taberna ou bobo fazendo piadas em uma corte real é um bardo. Descobrir a magia escondida na música requer trabalho árduo e estudo, algum treinamento formal. E bardos verdadeiros muitas vezes ficam separados de seus talentos musicais ou educação, de modo que eles podem testemunhar a vida e os acontecimentos de primeira mão. Essa educação direta e prática dá a um bardo uma perspectiva única sobre o mundo, e um talento para levar consigo companheiros de aventura onde quer que vá.',
      'Bardos amam acompanhar heróis (e vilões) para testemunhar seus feitos em primeira mão. Um bardo que pode contar uma história empolgante baseada em eventos reais tem muito mais probabilidade de atrair a atenção de uma plateia. Depois de sobreviver a alguns perigos replicando essa história, um bardo torna-se um aventureiro talentoso também. O bardo aprende a usar uma variedade de armas e magias, e atinge excelência em defender a si mesmo, auxiliando seus companheiros, e vencendo ou distraindo seus inimigos.',
    ],
  },
];

const vida = {
  prefixo: 'd',
  numero: '8',
  nivel1: '8 + seu bônus de Salvaguarda de Constituição + 1',
  niveisSuperiores: '8 + seu bônus de Salvaguarda de Constituição por nível de bardo após o 1°',
};

const proficiencias = [
  { titulo: 'Testes de Resistência', itens: ['Destreza', 'Carisma'], estilo: 'selos', icone: markRaw(IconeResistencia) },
  {
    titulo: 'Perícias',
    nota: 'escolha três quaisquer',
    itens: [
      'Acrobacia', 'Arcana', 'Atletismo', 'Atuação', 'Enganação', 'Furtividade',
      'História', 'Intimidação', 'Intuição', 'Investigação', 'Adestrar Animais',
      'Medicina', 'Natureza', 'Percepção', 'Persuasão', 'Prestidigitação', 'Religião', 'Sobrevivência',
    ],
    icone: markRaw(IconePericias),
  },
];

const proficienciasEquipamento = [
  { titulo: 'Armadura', itens: ['Armaduras leves'] },
  { titulo: 'Armas', itens: ['Armas simples', 'Bestas de mão', 'Espadas longas', 'Rapieiras', 'Espadas curtas'] },
  { titulo: 'Ferramentas', itens: ['Três instrumentos musicais, à sua escolha'] },
];

const equipamento = {
  intro: 'Você começa com o seguinte equipamento, além do equipamento concedido pelo seu antecedente:',
  itens: [
    { opcoes: ['Uma rapieira', 'Uma espada longa', 'Qualquer arma simples'] },
    { opcoes: ['Um pacote de diplomata', 'Um pacote de artista'] },
    { opcoes: ['Um alaúde', 'Qualquer outro instrumento musical'] },
    { opcoes: ['Armadura de couro e uma adaga'] },
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
  { nivel: 1, magiasConhecidas: 4, truquesConhecidos: 2, espacos: [2, SEM, SEM, SEM, SEM, SEM, SEM, SEM, SEM], caracteristicas: 'Conjuração, Inspiração de Bardo (d6), Talento' },
  { nivel: 2, magiasConhecidas: 5, truquesConhecidos: 2, espacos: [3, SEM, SEM, SEM, SEM, SEM, SEM, SEM, SEM], caracteristicas: 'Versatilidade, Canção de Descanso (d6)' },
  { nivel: 3, magiasConhecidas: 6, truquesConhecidos: 2, espacos: [4, 2, SEM, SEM, SEM, SEM, SEM, SEM, SEM], caracteristicas: 'Colégio de Bardo, Aptidão' },
  { nivel: 4, magiasConhecidas: 7, truquesConhecidos: 3, espacos: [4, 3, SEM, SEM, SEM, SEM, SEM, SEM, SEM], caracteristicas: '-' },
  { nivel: 5, magiasConhecidas: 8, truquesConhecidos: 3, espacos: [4, 3, 2, SEM, SEM, SEM, SEM, SEM, SEM], caracteristicas: 'Inspiração de Bardo (d8), Fonte de Inspiração, Talento' },
  { nivel: 6, magiasConhecidas: 9, truquesConhecidos: 3, espacos: [4, 3, 3, SEM, SEM, SEM, SEM, SEM, SEM], caracteristicas: 'Característica de Colégio, Canção de Proteção' },
  { nivel: 7, magiasConhecidas: 10, truquesConhecidos: 3, espacos: [4, 3, 3, 1, SEM, SEM, SEM, SEM, SEM], caracteristicas: '-' },
  { nivel: 8, magiasConhecidas: 11, truquesConhecidos: 3, espacos: [4, 3, 3, 2, SEM, SEM, SEM, SEM, SEM], caracteristicas: '-' },
  { nivel: 9, magiasConhecidas: 12, truquesConhecidos: 4, espacos: [4, 3, 3, 3, 1, SEM, SEM, SEM, SEM], caracteristicas: 'Canção de Descanso (d8)' },
  { nivel: 10, magiasConhecidas: 14, truquesConhecidos: 4, espacos: [4, 3, 3, 3, 2, SEM, SEM, SEM, SEM], caracteristicas: 'Inspiração de Bardo (d10), Aptidão (adicional), Segredos Mágicos, Talento' },
  { nivel: 11, magiasConhecidas: 15, truquesConhecidos: 4, espacos: [4, 3, 3, 3, 2, 1, SEM, SEM, SEM], caracteristicas: '-' },
  { nivel: 12, magiasConhecidas: 15, truquesConhecidos: 4, espacos: [4, 3, 3, 3, 2, 1, SEM, SEM, SEM], caracteristicas: '-' },
  { nivel: 13, magiasConhecidas: 16, truquesConhecidos: 5, espacos: [4, 3, 3, 3, 2, 1, 1, SEM, SEM], caracteristicas: 'Canção de Descanso (d10)' },
  { nivel: 14, magiasConhecidas: 18, truquesConhecidos: 5, espacos: [4, 3, 3, 3, 2, 1, 1, SEM, SEM], caracteristicas: 'Característica de Colégio, Segredos Mágicos (adicional)' },
  { nivel: 15, magiasConhecidas: 19, truquesConhecidos: 5, espacos: [4, 3, 3, 3, 2, 1, 1, 1, SEM], caracteristicas: 'Inspiração de Bardo (d12), Talento' },
  { nivel: 16, magiasConhecidas: 19, truquesConhecidos: 5, espacos: [4, 3, 3, 3, 2, 1, 1, 1, SEM], caracteristicas: '-' },
  { nivel: 17, magiasConhecidas: 20, truquesConhecidos: 5, espacos: [4, 3, 3, 3, 2, 1, 1, 1, 1], caracteristicas: 'Canção de Descanso (d12)' },
  { nivel: 18, magiasConhecidas: 22, truquesConhecidos: 5, espacos: [4, 3, 3, 3, 3, 1, 1, 1, 1], caracteristicas: 'Segredos Mágicos (adicional)' },
  { nivel: 19, magiasConhecidas: 22, truquesConhecidos: 5, espacos: [4, 3, 3, 3, 3, 2, 1, 1, 1], caracteristicas: 'Lendário' },
  { nivel: 20, magiasConhecidas: 22, truquesConhecidos: 5, espacos: [4, 3, 3, 3, 3, 2, 2, 1, 1], caracteristicas: 'Inspiração Superior, Talento' },
];

const conjuracaoTipo = 'Conjurador Completo';

const conjuracaoTexto =
  'Você conhece dois truques, à sua escolha, da lista de magias de bardo. Você aprende truques adicionais conforme avança de nível, como mostrado na coluna Truques Conhecidos da tabela O Bardo. Você também conhece quatro magias de 1° nível, à sua escolha, da lista de magias de bardo. A coluna Magias Conhecidas mostra quando você aprende mais magias de bardo, sempre de um nível ao qual você tenha acesso. Além disso, quando você adquire um nível nessa classe, você pode escolher uma das magias de bardo que conhece e substituí-la por outra magia da lista de magias de bardo, que também deve ser de um nível ao qual você tenha espaços de magia. Você também pode conjurar qualquer magia de bardo que conheça como um ritual, se ela possuir o descritor ritual, e usar um instrumento musical como foco de conjuração das suas magias de bardo.';

const tiposDeMagia = ['Natural', 'Divina', 'Arcana'];
const tipoMagiaBardo = 'Arcana';

const fonteMagia =
  'O Bardo atribui sua fonte de magia ao poder inerente das palavras e da música, sendo capaz de utilizar a magia arcana.';

const atributoConjuracao = {
  nome: 'Carisma',
  bonus: ['Carisma', 'Proficiência'],
  cd: ['8', 'Proficiência', 'Carisma'],
  nota: 'Os valores de Carisma e Proficiência usados são os bônus respectivos.',
};

const caracteristicas = [
  {
    nivel: 1,
    titulo: 'Inspiração de Bardo',
    corpo: `Você pode inspirar os outros através de palavras animadoras ou música. Para tanto, você usa uma <span class="dc-termo">ação bônus</span> no seu turno para escolher uma outra criatura, que não seja você mesmo, a até 18 metros de você que possa ouvi-lo. Essa criatura ganha um dado de Inspiração de Bardo, um d6.
Uma vez, nos próximos 10 minutos, a criatura poderá rolar o dado e adicionar o valor rolado a um teste de habilidade, jogada de ataque ou teste de resistência que ela fizer. A criatura pode esperar até rolar o d20 antes de decidir usar o dado de Inspiração de Bardo, mas deve decidir antes do Mestre dizer se a rolagem foi bem ou mal sucedida. Quando o dado de Inspiração de Bardo for rolado, ele é gasto. Uma criatura pode ter apenas um dado de Inspiração de Bardo por vez.
Você pode usar essa característica um número de vezes igual ao seu bônus de proficiência. Você recupera todos os usos quando termina um <span class="dc-termo">descanso longo</span>.
Seu dado de Inspiração de Bardo muda quando você atinge certos níveis na classe. O dado se torna um d8 no 5° nível, um d10 no 10° nível e um d12 no 15° nível.`,
  },
  {
    nivel: 2,
    titulo: 'Versatilidade',
    corpo: 'A partir do 2° nível, você pode adicionar metade do seu bônus de proficiência, arredondado para baixo, em qualquer teste de habilidade que você fizer que ainda não possua seu bônus de proficiência.',
  },
  {
    nivel: 2,
    titulo: 'Canção de Descanso',
    corpo: `A partir do 2° nível, você pode usar música ou oração calmantes para ajudar a revitalizar seus aliados feridos durante um <span class="dc-termo">descanso curto</span>. Se você ou qualquer criatura amigável que puder ouvir sua atuação recuperar pontos de vida no fim do <span class="dc-termo">descanso curto</span> ao gastar um ou mais Dados de Vida, cada uma dessas criaturas recupera um número de pontos de vida adicionais igual a uma quantidade de d6 igual a metade do seu bônus de proficiência, arredondado para baixo.
Os pontos de vida adicionais aumentam quando você alcança determinados níveis na classe: para d8 no 9° nível, para d10 no 13° nível e para d12 no 17° nível.`,
  },
  {
    nivel: 3,
    titulo: 'Aptidão',
    corpo: `No 3° nível, escolha duas das perícias em que você é proficiente. Seu bônus de proficiência é dobrado em qualquer teste de habilidade que você fizer que utilize qualquer das perícias escolhidas.
No 10° nível, você escolhe mais duas perícias em que é proficiente para ganhar esse benefício.`,
  },
  {
    nivel: 5,
    titulo: 'Fonte de Inspiração',
    corpo: 'Começando no momento em que você atinge o 5° nível, você recupera todas as utilizações gastas da sua Inspiração de Bardo quando você termina um <span class="dc-termo">descanso curto</span> ou <span class="dc-termo">descanso longo</span>.',
  },
  {
    nivel: 6,
    titulo: 'Canção de Proteção',
    corpo: 'No 6° nível, você adquire a habilidade de usar notas musicais ou palavras de poder para interromper efeito de influência mental. Com uma <span class="dc-termo">ação bônus</span>, você pode começar uma atuação que dura até o fim do seu próximo turno. Durante esse tempo, você e qualquer criatura amigável a até 9 metros ficam imunes à condição enfeitiçado e amedrontado. Uma criatura deve ser capaz de ouvir você para receber esse benefício. A atuação termina prematuramente se você for incapacitado ou silenciado ou se terminá-la voluntariamente (não requer ação).',
  },
  {
    nivel: 10,
    titulo: 'Segredos Mágicos',
    corpo: 'No 10° nível, você usurpou conhecimento mágico de um vasto espectro de disciplinas. Escolha duas magias de qualquer classe, incluindo essa. A magia que você escolher deve ser de um nível que você possa conjurar, como mostrado na tabela O Bardo, ou um truque. As magias escolhidas contam como magias de bardo para você e já estão incluídas no número da coluna Magias Conhecidas da tabela O Bardo. Você aprende duas magias adicionais de qualquer classe no 14° nível e novamente no 18° nível.',
  },
  {
    nivel: 19,
    titulo: 'Lendário',
    corpo: 'Ao atingir o 19°, você pode escolher um <span class="dc-termo">talento</span> épico.',
  },
  {
    nivel: 20,
    titulo: 'Inspiração Superior',
    corpo: 'No 20° nível, um único uso de uma Inspiração de Bardo pode afetar qualquer número de criaturas em até 72 metros.\nAlém disso, você recupera um uso de inspiração de bardo sempre que você ou um aliado em sua visão tire um acerto crítico em uma rolagem de d20.',
  },
];

const subclasses = [
  {
    nome: 'Faculdade de Eloquência',
    icone: '🎭',
    introTexto: 'Os aderentes do Colégio de Eloquência dominam a arte da oratória. A persuasão é considerada como uma arte alta, e um argumento bem fundamentado e bem falado muitas vezes se mostra mais poderoso do que a verdade objetiva. Esses bardos empunham uma mistura de lógica e jogo de palavras teatral, conquistando céticos e detratores com argumentos lógicos e arrancando coragem para apelar para as emoções de todo o público.',
    caracteristicas: [
      {
        nivel: 3,
        titulo: 'Língua de Prata',
        corpo: 'Começando no 3° nível, você é um mestre em dizer a coisa certa no momento certo. Quando você faz um teste de <span class="dc-termo">Carisma</span> (Persuasão) ou <span class="dc-termo">Carisma</span> (Enganação), você pode tratar um resultado de d20 de 9 ou inferior como um 10.',
      },
      {
        nivel: 3,
        titulo: 'Palavras Inquietantes',
        corpo: 'Também no 3° nível, você pode grifar palavras atadas com magia que perturbam uma criatura e fazer com que ela duvide de si mesma. Como uma <span class="dc-termo">ação bônus</span>, você pode gastar um uso de sua Inspiração de Bardo e escolher uma criatura que você pode ver dentro de 18 metros de você. Role o dado de Inspiração de Bardo. A criatura deve subtrair o número rolado no próximo teste de resistência que faz antes do início do seu próximo turno.',
      },
      {
        nivel: 6,
        titulo: 'Inspiração sem Falha',
        corpo: 'No 6° nível suas palavras inspiradoras são tão persuasivas que os outros se sentem motivados a ter sucesso. Quando uma criatura usar um dos seus dados de Inspiração de Bardo em sua verificação de habilidade, jogada de ataque ou teste de resistência e o teste falhar, a criatura pode manter o dado de Inspiração de Bardo.',
      },
      {
        nivel: 6,
        titulo: 'Discurso Universal',
        corpo: `Também no 6° nível, você ganhou a capacidade de tornar sua fala inteligível para qualquer criatura. Como uma <span class="dc-termo">ação</span>, escolha uma ou mais criaturas dentro de 18 metros de você, até um número igual ao seu modificador de <span class="dc-termo">Carisma</span> (mínimo de uma criatura). As criaturas escolhidas podem magicamente entender você, independentemente do idioma que você fala, por 1 hora.
Depois de usar esse recurso, você não pode usá-lo novamente até terminar um <span class="dc-termo">descanso longo</span>, a menos que você gaste um espaço de magia para usá-lo novamente.`,
      },
      {
        nivel: 14,
        titulo: 'Inspiração Infecciosa',
        corpo: 'No 14° nível, quando você inspira alguém com sucesso, o poder de sua eloquência agora pode se espalhar para outra pessoa. Quando uma criatura a menos de 18 metros de você adiciona um dos seus dados de Inspiração de Bardo à sua verificação de habilidade, jogada de ataque ou teste de resistência e o teste é bem-sucedido, você pode usar sua reação para incentivar uma criatura diferente (além de você) que pode ouvi-lo a menos de 18 metros de você, dando-lhe um dado de Inspiração de Bardo sem gastar qualquer um dos seus usos de Inspiração de Bardo.',
      },
    ],
  },
  {
    nome: 'Faculdade de Espíritos',
    icone: '👻',
    introTexto: 'Bardos do Colégio dos Espíritos buscam contos com poder inerente — sejam elas lendas, histórias ou ficções — e trazem seus assuntos à vida. Usando armadilhas ocultas, esses bardos evocam encarnações espirituais de forças poderosas para mudar o mundo mais uma vez. Tais espíritos são caprichosos, porém, e o que uma convocação de bardo invoca nem sempre está totalmente sob seu controle.',
    caracteristicas: [
      {
        nivel: 3,
        titulo: 'Sussurros Orientadores',
        corpo: 'No 3° nível, você pode alcançar espíritos para guiar você e os outros. Você aprende o truque Orientação, que não conta contra o número de truques de bardo que você conhece. Para você, ele tem um alcance de 18 metros quando você o lança.',
      },
      {
        nivel: 3,
        titulo: 'Foco Espiritual',
        corpo: `No 3° nível, você emprega ferramentas que o ajudam na canalização de espíritos, sejam figuras históricas ou arquétipos fictícios. Você pode usar os seguintes objetos como um foco de conjuração para suas magias de bardo: uma vela de cristal, uma bola de cristal, um crânio, uma placa de espírito ou um baralho tarokka.
Começando no 6° nível, quando você conjura uma magia de bardo que causa dano ou restaura pontos de vida através do Foco Espiritual, role um d6, e você ganha um bônus na jogada de dano ou de cura igual ao número rolado.`,
      },
      {
        nivel: 3,
        titulo: 'Contos do Além',
        corpo: `No 3° nível, você alcança os espíritos que contam suas histórias através de você. Enquanto você está segurando seu <span class="dc-termo">Foco Espiritual</span>, você pode usar uma <span class="dc-termo">ação bônus</span> para gastar um uso de sua Inspiração de Bardo e rolar na tabela Contos Espirituais usando seu dado de Inspiração de Bardo para determinar a história que os espíritos o direcionam a contar. Você mantém o conto em mente até que ele conceda o efeito ou você termine um <span class="dc-termo">descanso curto</span> ou <span class="dc-termo">descanso longo</span>.
Você pode escolher uma criatura que você pode ver dentro de 9 metros de você (isso pode ser você) para ser o alvo do efeito do conto. Uma vez que você faça isso, você não pode conceder o efeito do conto novamente até que você o role novamente.
Você pode reter apenas um desses contos em mente de cada vez, e rolar novamente na tabela dos Contos Espirituais termina imediatamente o efeito do conto anterior.
Se o conto exigir um teste de resistência, o CD é igual ao seu CD de magia.`,
        tabela: {
          colunaA: 'Dado',
          colunaB: 'Conto Falado Através de Você',
          linhas: [
            { a: '1', b: 'Conto do Animal Inteligente. Para os próximos 10 minutos, sempre que o alvo faz um teste de <span class="dc-termo">Inteligência</span>, <span class="dc-termo">Sabedoria</span> ou <span class="dc-termo">Carisma</span>, ele pode rolar o dado de <span class="dc-termo">Contos Espirituais</span> extra imediatamente após rolar o d20 e adicionar o número do dado extra ao teste.' },
            { a: '2', b: 'Conto do Renomado Duelista. Você faz um ataque corpo-a-corpo contra o alvo. Em um golpe, o alvo recebe dano de força extra igual a dois rolos de seu dado de Inspiração de Bardo + seu modificador de <span class="dc-termo">Carisma</span>.' },
            { a: '3', b: 'Conto dos Amados Amigos. O alvo e outra criatura de sua escolha que ele pode ver dentro de 1,5 metro dele ganham pontos de vida temporários iguais a um rolo do seu dado de Inspiração de Bardo + seu modificador de <span class="dc-termo">Carisma</span>.' },
            { a: '4', b: 'Conto do Fugitivo. O alvo pode imediatamente usar sua reação para se teletransportar até 9 metros para um espaço desocupado que ele pode ver. Ao se teletransportar, ele pode escolher um número de criaturas que pode ver dentro de 9 metros dele até seu modificador de <span class="dc-termo">Carisma</span> (mínimo de 0) para usar imediatamente a mesma reação.' },
            { a: '5', b: 'Conto do Vingador. Por 1 minuto, qualquer criatura que atingir o alvo com um ataque corpo-a-corpo recebe dano de força igual a um rolo do seu dado de Inspiração de Bardo.' },
            { a: '6', b: 'Conto do Viajante. O alvo ganha pontos de vida temporários iguais a um lançamento do seu dado de Inspiração de Bardo + seu nível de personagem. Enquanto tiver esses pontos de vida temporários, o <span class="dc-termo">deslocamento</span> de caminhada do alvo aumenta em 3 metros e ele ganha um bônus de +1 na CA.' },
            { a: '7', b: 'Conto do Beguiler. O alvo deve ter sucesso em um teste de resistência de <span class="dc-termo">Sabedoria</span> ou receber dano psíquico igual a dois rolos de seu dado de Inspiração de Bardo, e o alvo fica incapacitado até o final de seu próximo turno.' },
            { a: '8', b: 'Conto do Fantasma. O alvo torna-se invisível até o final de seu próximo turno ou até atingir uma criatura com um ataque. Se atingir uma criatura com um ataque durante essa invisibilidade, a criatura atingida sofre dano necrótico igual a um rolo de seu dado de Inspiração de Bardo e fica com medo do alvo até o final do próximo turno dela.' },
            { a: '9', b: 'Conto do Bruto. Cada criatura da escolha do alvo que possa ver dentro de 9 metros deve fazer um teste de resistência de <span class="dc-termo">Força</span>. Em uma falha, uma criatura recebe dano de trovão igual a três rolos de seu dado de Inspiração de Bardo e é derrubada. Uma criatura que passar no teste sofre metade do dano e não é derrubada.' },
            { a: '10', b: 'Conto do Dragão. O alvo vomita fogo da boca em um cone de 9 metros. Cada criatura nessa área deve fazer um teste de resistência de <span class="dc-termo">Destreza</span>, sofrendo dano de fogo igual a quatro rolos de seu dado de Inspiração de Bardo em uma falha, ou metade do dano em um sucesso.' },
            { a: '11', b: 'Conto do Anjo. O alvo recupera pontos de vida iguais a dois rolos do seu dado de Inspiração de Bardo + seu modificador de <span class="dc-termo">Carisma</span>, e você termina uma condição da seguinte lista que afeta o alvo: cego, ensurdecido, paralisado, petrificado ou envenenado.' },
            { a: '12', b: 'Conto do Servo Mental. Você convoca uma fábula incompreensível de um ser de outro mundo. O alvo deve ter sucesso em um teste de resistência de <span class="dc-termo">Inteligência</span> ou receber dano psíquico igual a três rolos de seu dado de Inspiração de Bardo e ficar atordoado até o final de seu próximo turno.' },
          ],
        },
      },
      {
        nivel: 6,
        titulo: 'Sessão do Espírito',
        corpo: `No 6° nível, os espíritos fornecem intuições sobrenaturais. Você pode conduzir um ritual de uma hora canalizando espíritos (o que pode ser feito durante um <span class="dc-termo">descanso curto</span> ou <span class="dc-termo">descanso longo</span>) usando seu <span class="dc-termo">Foco Espiritual</span>. Você pode conduzir o ritual com um número de criaturas dispostas igual ao seu bônus de proficiência (incluindo você mesmo). No final do ritual, você aprende temporariamente um feitiço de sua escolha a partir de qualquer classe.
O feitiço que você escolher deve ser de um nível igual ao número de criaturas que conduziram o ritual ou menos, deve ser de um nível que você pode conjurar, e deve ser da escola de Adivinhação ou Necromancia. O feitiço escolhido conta como um feitiço de bardo para você, mas não conta contra o número de feitiços de bardo que você conhece.
Uma vez que você realize o ritual, você não pode fazê-lo novamente até começar um <span class="dc-termo">descanso longo</span>, e você sabe o feitiço escolhido até começar um <span class="dc-termo">descanso longo</span>.`,
      },
      {
        nivel: 14,
        titulo: 'Conexão Mística',
        corpo: 'No 14° nível, agora você tem a capacidade de direcionar os espíritos de <span class="dc-termo">Contos do Além</span> para certos contos. Sempre que você rolar na tabela de <span class="dc-termo">Contos Espirituais</span>, você pode rolar o dado duas vezes e escolher qual dos dois efeitos doar. Se você rolar o mesmo número em ambos os dados, você pode ignorar o número e escolher qualquer efeito na tabela.',
      },
    ],
  },
  {
    nome: 'Faculdade de Fábulas',
    icone: '🃏',
    introTexto: 'Bardos do Colégio de Fábulas sabem algo sobre a maioria das coisas, coletando pedaços de conhecimento de fontes tão diversas como tomos acadêmicos e contos camponeses. Seja cantando baladas folclóricas em tabernas ou elaboradas composições em tribunais reais, esses bardos usam seus dons para manter o público encantado. Quando os aplausos morrem, os membros da audiência podem se ver questionando tudo o que tinham como verdade, desde sua fé no sacerdócio do templo local até sua lealdade ao rei. A lealdade desses bardos está na busca da beleza ou da verdade, não em fidelidade a um monarca ou aos princípios de uma divindade. Um nobre que mantém tal bardo como um arauto ou conselheiro sabe que o bardo preferiria ser honesto do que político.',
    caracteristicas: [
      {
        nivel: 3,
        titulo: 'Proficiências de Bônus',
        corpo: 'Quando você se junta ao Colégio de Fábulas no 3° nível, você ganha proficiência com três habilidades de sua escolha.',
      },
      {
        nivel: 3,
        titulo: 'Cortar Palavras',
        corpo: 'Também no 3° nível, você aprende a usar sua inteligência para distrair, confundir e, de outra forma, minar a confiança e a competência dos outros. Quando uma criatura que você pode ver a menos de 18 metros de você faz uma jogada de ataque, um teste de habilidade ou uma jogada de dano, você pode usar sua reação para gastar um dos seus usos de Inspiração de Bardo, rolando um dado de Inspiração de Bardo e subtraindo o número rolado da jogada da criatura. Você pode optar por usar esse recurso depois de ver a criatura fazer sua rolagem, mas antes que o Mestre determine se o teste ou a jogada de ataque é bem-sucedida ou falha, ou antes que o dano seja aplicado. A criatura é imune se não conseguir ouvi-lo ou se for imune a ficar encantada.',
      },
      {
        nivel: 6,
        titulo: 'Segredos Mágicos Adicionais',
        corpo: 'No 6° nível, você aprende dois feitiços e três truques a partir de qualquer classe. Uma magia que você escolher deve ser de um nível que você pode conjurar, como mostrado na tabela O Bardo. As magias escolhidas contam como feitiços de bardo para você, mas não contam contra o número de feitiços de bardo que você conhece.',
      },
      {
        nivel: 14,
        titulo: 'Habilidade sem Limites',
        corpo: 'A partir do 14° nível, quando você faz um teste de habilidade, você pode gastar um uso de sua Inspiração de Bardo. Role um dado de Inspiração de Bardo e adicione o número rolado à sua verificação de habilidade. Você pode optar por fazê-lo depois de ver o resultado da verificação de habilidade, mas antes que o Mestre lhe diga se você teve sucesso ou falhou.',
      },
    ],
  },
  {
    nome: 'Faculdade de Glamour',
    icone: '🌸',
    introTexto: 'O Colégio de Glamour é o lar de bardos que dominaram seu ofício no reino vibrante do Feywild ou sob a tutela de alguém que morava lá. Tutorado por sátiros, eladrin e outras fadas, esses bardos aprendem a usar sua magia para deleitar e cativar os outros. Os bardos desta faculdade são vistos com uma mistura de admiração e medo. Suas performances são material de lenda. Esses bardos são tão eloquentes que um discurso ou música que um deles executa pode fazer com que captores libertem o bardo ileso, ou acalmar um dragão furioso em complacência. A mesma magia que lhes permite reprimir animais também pode dobrar mentes.',
    caracteristicas: [
      {
        nivel: 3,
        titulo: 'Manto da Inspiração',
        corpo: `Quando você se junta ao Colégio de Glamour no 3° nível, você ganha a capacidade de tecer uma música de magia feérica que imbui seus aliados com vigor e velocidade.
Como uma <span class="dc-termo">ação bônus</span>, você pode gastar um uso da sua Inspiração de Bardo para conceder a si mesmo uma aparência maravilhosa. Quando você fizer isso, escolha um número de criaturas que você pode ver e que podem vê-lo dentro de 18 metros de você, até um número igual ao seu modificador de <span class="dc-termo">Carisma</span> (mínimo de um). Cada uma delas ganha 10 pontos de vida temporários. Quando uma criatura ganha esses pontos de vida temporários, ela pode usar imediatamente sua reação para realizar uma <span class="dc-termo">ação de Disparada</span>, sem provocar ataques de oportunidade.
O número de pontos de vida temporários aumenta quando você atinge certos níveis nesta classe, aumentando para 15 no 5° nível, 20 no 10° nível, 25 no 15° nível e 50 no 20° nível.`,
      },
      {
        nivel: 3,
        titulo: 'Desempenho Entupiante',
        corpo: `A partir do 3° nível, você pode carregar seu desempenho com magia sedutora e feérica.
Se você se apresentar por pelo menos 1 minuto, você pode usar um dado de Inspiração de Bardo para inspirar admiração em seu público cantando, recitando um poema ou dançando. No final da performance, escolha um número de humanoides dentro de 18 metros de você que assistiram e ouviram tudo, até um número igual ao seu modificador de <span class="dc-termo">Carisma</span> (mínimo de um). Cada alvo deve ter sucesso em um teste de resistência de <span class="dc-termo">Sabedoria</span> contra o seu CD de magia ou ficar encantado por você. Enquanto encantado dessa maneira, ele fala brilhantemente de você para qualquer um que fale com ele, e impede qualquer um que se oponha a você, evitando a violência, a menos que já estivesse inclinado a lutar em seu nome. Este efeito termina em um alvo após 1 hora, se ele tomar algum dano, se você atacá-lo, ou se ele testemunhar você atacando ou danificando qualquer um de seus aliados.
Se um alvo for bem-sucedido em seu teste de resistência, ele não tem nenhuma dica de que você tentou encantá-lo.
Depois de usar esse recurso, você não poderá usá-lo novamente até terminar um <span class="dc-termo">descanso curto</span> ou <span class="dc-termo">descanso longo</span>.`,
      },
      {
        nivel: 6,
        titulo: 'Manto de Majestade',
        corpo: `No 6° nível, você ganha a capacidade de se encobrir em uma magia feérica que faz com que os outros queiram servi-lo. Como uma <span class="dc-termo">ação bônus</span>, você lança Comando, sem gastar um espaço de magia, e assume a aparência de beleza sobrenatural por 1 minuto ou até que sua concentração termine (como se você estivesse se concentrando em uma magia). Durante esse tempo, você pode lançar Comando como uma <span class="dc-termo">ação bônus</span> em cada um dos seus turnos, sem gastar um espaço de magia.
Qualquer criatura encantada por você falha automaticamente em seu teste de resistência contra o Comando que você lançou com este recurso.
Depois de usar esse recurso, você não poderá usá-lo novamente até terminar um <span class="dc-termo">descanso longo</span>.`,
      },
      {
        nivel: 14,
        titulo: 'Majestade Inquebrável',
        corpo: `No 14° nível, sua aparência ganha permanentemente um aspecto sobrenatural que faz você parecer mais adorável e feroz.
Além disso, como uma <span class="dc-termo">ação bônus</span>, você pode assumir uma presença magicamente majestosa por 1 minuto ou até que você esteja incapacitado. Durante a duração, sempre que qualquer criatura tentar atacá-lo pela primeira vez em um turno, o atacante deve fazer um teste de resistência de <span class="dc-termo">Carisma</span> contra seu CD de magia. Em uma falha, ele não pode atacá-lo neste turno, e deve escolher um novo alvo para seu ataque ou o ataque é desperdiçado. Em um sucesso, ele pode atacá-lo neste turno, mas tem <span class="dc-termo">desvantagem</span> em qualquer teste de resistência que fizer contra suas magias em seu próximo turno.
Uma vez que você assuma essa presença majestosa, você não pode fazê-lo novamente até terminar um <span class="dc-termo">descanso curto</span> ou <span class="dc-termo">descanso longo</span>.`,
      },
    ],
  },
  {
    nome: 'Faculdade de Sussurros',
    icone: '🗡️',
    introTexto: 'A maioria das pessoas está feliz em receber um bardo em seu meio. Bardos do Colégio de Sussurros usam isso a seu favor. Eles parecem ser como qualquer outro bardo, compartilhando notícias, cantando músicas e contando histórias para o público que reúnem. Na verdade, o Colégio de Sussurros ensina aos seus alunos que eles são lobos entre as ovelhas. Esses bardos usam seu conhecimento e magia para descobrir segredos e transformá-los contra os outros através de extorsão e ameaças. Muitos outros bardos odeiam o Colégio dos Sussurros, vendo-o como um parasita que usa a reputação dos bardos para adquirir riqueza e poder. Por esta razão, esses bardos raramente revelam sua verdadeira natureza, a menos que precisem.',
    caracteristicas: [
      {
        nivel: 3,
        titulo: 'Lâminas Psíquicas',
        corpo: `Quando você se junta ao Colégio dos Sussurros no 3° nível, você ganha a capacidade de tornar seus ataques de armas magicamente tóxicos para a mente de uma criatura.
Quando você acertar uma criatura com um ataque de arma, você pode gastar um uso de sua Inspiração de Bardo para causar 2d6 de dano psíquico adicional a esse alvo. Você pode fazer isso apenas uma vez por turno.
O dano psíquico aumenta quando você atinge certos níveis nesta classe, aumentando para 3d6 no 5° nível, 5d6 no 10° nível e 8d6 no 15° nível.`,
      },
      {
        nivel: 3,
        titulo: 'As Palavras de Terror',
        corpo: `No 3° nível, você aprende a infundir palavras inocentes com uma magia insidiosa que pode inspirar terror.
Se você falar com um humanoide sozinho por pelo menos 1 minuto, você pode tentar semear a paranoia e o medo em sua mente. No final da conversa, o alvo deve ter sucesso em um teste de resistência de <span class="dc-termo">Sabedoria</span> contra o seu CD de magia ou ficar com medo de você ou de outra criatura de sua escolha. O alvo fica amedrontado desta forma por 1 hora, até que seja atacado ou danificado, ou até que testemunhe seus aliados sendo atacados ou danificados.
Se o alvo for bem-sucedido em seu teste de resistência, ele não tem nenhuma dica de que você tentou assustá-lo. Depois de usar esse recurso, você não poderá usá-lo novamente até terminar um <span class="dc-termo">descanso curto</span> ou <span class="dc-termo">descanso longo</span>.`,
      },
      {
        nivel: 6,
        titulo: 'Manto de Sussurros',
        corpo: `No 6° nível, você ganha a capacidade de adotar a persona de um humanoide. Quando um humanoide morre a menos de 9 metros de você, você pode magicamente capturar sua sombra usando sua reação. Você mantém essa sombra até usá-la ou até terminar um <span class="dc-termo">descanso longo</span>.
Você pode usar a sombra como uma <span class="dc-termo">ação</span>. Quando você faz isso, ela desaparece, transformando-se magicamente em um disfarce que aparece em você. Agora você se parece com a pessoa morta, mas saudável e viva. Este disfarce dura 1 hora ou até que você termine como uma <span class="dc-termo">ação bônus</span>.
Enquanto você está no disfarce, você ganha acesso a todas as informações que o humanoide compartilharia livremente com um conhecido casual. Essas informações incluem detalhes gerais sobre seu histórico e vida pessoal, mas não incluem segredos. A informação é suficiente para que você possa se passar pela pessoa baseando-se em suas memórias.
Outra criatura pode ver através desse disfarce, tendo sucesso em um teste de <span class="dc-termo">Sabedoria</span> (Intuição) contestado por seu teste de <span class="dc-termo">Carisma</span> (Enganação). Você ganha um bônus de +5 no seu teste.
Depois de capturar uma sombra com esse recurso, você não pode capturar outra até terminar um <span class="dc-termo">descanso curto</span> ou <span class="dc-termo">descanso longo</span>.`,
      },
      {
        nivel: 14,
        titulo: 'Jogos de Contos da Sombra',
        corpo: `No 14° nível, você ganha a capacidade de tecer magia negra em suas palavras e tocar nos medos mais profundos de uma criatura.
Como <span class="dc-termo">ação</span>, você magicamente sussurra uma frase que apenas uma criatura de sua escolha a menos de 9 metros pode ouvir. O alvo deve fazer um teste de resistência de <span class="dc-termo">Sabedoria</span> contra o seu CD de magia. Ele é automaticamente bem-sucedido se não compartilhar um idioma com você ou não puder ouvi-lo. Em um sucesso, seu sussurro soa como uma murmuração ininteligível e não tem efeito.
Se o alvo falhar em seu teste de resistência, ele fica encantado por você pelas próximas 8 horas ou até que você ou seus aliados o ataquem ou causem dano a ele. Ele interpreta os sussurros como uma descrição de seu segredo mais mortificante. Enquanto você não ganha conhecimento real desse segredo, o alvo está convencido de que você sabe disso. Enquanto encantado desta forma, a criatura obedece aos seus comandos por medo de que você revele seu segredo. Ela não arriscará sua vida por você ou lutará por você, a menos que já estivesse inclinada a fazê-lo. Ela lhe concede favores e presentes que ofereceria a um amigo próximo.
Quando o efeito termina, a criatura não tem compreensão de por que ela o manteve em tal medo.
Depois de usar esse recurso, você não pode usá-lo novamente até terminar um <span class="dc-termo">descanso longo</span>.`,
      },
    ],
  },
];

// Escolha de subclasse — todo personagem escolhe uma subclasse em algum
// nível, independente da classe; por isso fica junto dos outros pontos
// fixos em Fundamentos da Classe, não na lista de características do
// Bardo. As opções vêm do próprio array `subclasses`, pra não duplicar
// nome/ícone em dois lugares.
const subclasseEscolha = {
  titulo: 'Colégio de Bardo',
  corpo: 'No 3° nível, você investiga as técnicas avançadas de um colégio de bardo, à sua escolha. Sua escolha lhe concede características no 3° nível e novamente no 6° e 14° níveis.',
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

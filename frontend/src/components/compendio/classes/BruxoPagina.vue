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
        <h2 class="dc-section-title">Progressão — O Bruxo</h2>
        <span class="dc-title-line"></span>
      </div>
      <div class="dc-tabela-wrap">
        <table class="dc-tabela-niveis">
          <thead>
            <tr>
              <th>Nível</th>
              <th>Características</th>
              <th class="dc-th-centro">Magias Conhecidas</th>
              <th class="dc-th-centro">Truques Conhecidos</th>
              <th class="dc-th-centro">Invocações Conhecidas</th>
              <th class="dc-th-centro">Espaços de Magia</th>
              <th class="dc-th-centro">Nível de Magia</th>
            </tr>
          </thead>
          <tbody>
            <tr v-for="n in niveis" :key="n.nivel">
              <td class="dc-tabela-nivel">{{ n.nivel }}º</td>
              <td class="dc-tabela-carac">{{ n.caracteristicas }}</td>
              <td class="dc-tabela-bonus">{{ n.magiasConhecidas }}</td>
              <td class="dc-tabela-bonus">{{ n.truquesConhecidos }}</td>
              <td class="dc-tabela-bonus">{{ n.invocacoesConhecidas }}</td>
              <td class="dc-tabela-bonus">{{ n.espacosDeMagia }}</td>
              <td class="dc-tabela-bonus">{{ n.nivelDeMagia }}</td>
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
      <p class="dc-fundamentos-nota">Regras comuns a toda classe — não são exclusivas do Bruxo.</p>

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
            <span class="dc-conjuracao-tipo-prefixo">O Bruxo é</span>
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
              :class="{ 'dc-chip-tipo-magia-ativo': t === tipoMagiaBruxo, 'dc-chip-tipo-magia-inativo': t !== tipoMagiaBruxo }"
              v-for="t in tiposDeMagia"
              :key="t"
            >{{ t.toUpperCase() }}</span>
          </div>

          <span class="dc-atributo-magia-rotulo">O Atributo de Conjuração do Bruxo</span>
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

        <div class="dc-magias-tabela" v-if="s.magias && s.magias.length">
          <span class="dc-magias-titulo">Magias por Nível</span>
          <div class="dc-tabela-wrap">
            <table class="dc-tabela-niveis">
              <thead>
                <tr>
                  <th>Nível do Bruxo</th>
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
  nome: 'Bruxo',
  subtitulo: 'Versão Épico',
  icone: '👁️',
  cor: '#4a3a6a',
  dadoDeVida: 'd8',
  dificuldade: 'Média',
  papeis: ['Dano', 'Utilidade'],
};

const descricaoBlocos = [
  {
    titulo: null,
    paragrafos: [
      'Com um pseudodragão encarapitado em seu ombro, um jovem elfo vestido com uma robe dourada sorri calorosamente, tecendo um encanto mágico em suas palavras melífluas e dobrando os guardas do palácio à sua vontade.',
      'Enquanto chamas primaveris saltam de seus dedos, um velho humano sussurra o nome secreto de seu patrono demoníaco, infundindo sua magia com poder sinistro.',
      'Deslocando seus olhos entre um tomo esfarrapado e a estranha alineação das estrelas suspensas, um tiefling de chifres selvagens entoa o ritual místico que irá abrir um portal para um mundo distante.',
      'Bruxos são buscadores de conhecimentos que residem em no tecido do multiverso. Através de pactos feitos com misteriosas entidades de poder supernatural, bruxos destravam efeitos mágicos tanto sutis quanto espetaculares.',
    ],
  },
  {
    titulo: 'Vendendo suas Almas',
    paragrafos: [
      'Um bruxo é definido por um pacto com uma entidade transcendental. Às vezes o relacionamento entre bruxo e patrono é semelhante à do clérigo e uma divindade, apesar de as entidades que servem de patronos de bruxos não serem deuses. Um bruxo pode liderar um culto dedicado a um príncipe demoníaco, um arquidiabo, ou uma entidade totalmente alienígena — entidades não tipicamente servidas por clérigos. Outras vezes, o relacionamento é como o de mestre e aprendiz; o bruxo aprende e cresce em poder, ao custo de serviços ocasionais executados em nome do patrono.',
      'A magia atribuída a um bruxo varia de pequenas mas duradouras alterações (como a habilidade de ver no escuro ou de ler qualquer idioma) a acesso a magias poderosas.',
    ],
  },
  {
    titulo: 'Estudantes Instigantes',
    paragrafos: [
      'Bruxos são impulsionados por uma sede insaciável por conhecimento e poder, que os obriga a fazer seus pactos e molda suas vidas. Essas histórias de bruxos vinculando entidades extraplanares são amplamente conhecidas. Mas muitos bruxos servem patronos que não são demônios nem archiéis. Às vezes um viajante no deserto vai encontrar uma torre estranha, encontra um jovem bibliotecário eremita, e faz um pacto com uma entidade única. E às vezes, enquanto vasculha tomos de conhecimento proibido, uma mente brilhante mas desviada é iluminada por realidades além do mundo material e ao reino de que existe além — e faz um pacto com tal poder.',
      'Uma vez que um pacto foi feito, a sede de um bruxo por conhecimento e poder não pode ser saciado com simples estudo e pesquisa. Ninguém faz um pacto com tal poder poderoso sem pretender usar o poder assim obtido. Melhor, então, para encontrar aquele poder em situações ativas repletas de oportunidades.',
      'A maioria dos bruxos acredita que seu pacto permitirá que eles realizem grandes feitos, como banir um demônio ou matar um tirano. Como tal, muitos bruxos estão preparados para enfrentar perigos, embora os mantenha na vanguarda de suas mentes: um bruxo geralmente não quer uma luta justa contra o mal. Muitos preferem permanecer à distância durante a batalha, aliviando seus inimigos com maldições e poderosas explosões de poder enquanto seu patrono muda a realidade ao seu redor.',
    ],
  },
];

const vida = {
  prefixo: 'd',
  numero: '8',
  nivel1: '8 + seu bônus de Salvaguarda de Constituição + 1',
  niveisSuperiores: '8 + seu bônus de Salvaguarda de Constituição por nível de bruxo após o 1°',
};

const proficiencias = [
  { titulo: 'Testes de Resistência', itens: ['Sabedoria', 'Carisma'], estilo: 'selos', icone: markRaw(IconeResistencia) },
  {
    titulo: 'Perícias',
    nota: 'escolha duas',
    itens: ['Arcana', 'Enganação', 'História', 'Intimidação', 'Investigação', 'Natureza', 'Religião'],
    icone: markRaw(IconePericias),
  },
];

const proficienciasEquipamento = [
  { titulo: 'Armadura', itens: ['Armaduras leves'] },
  { titulo: 'Armas', itens: ['Armas simples'] },
  { titulo: 'Ferramentas', itens: ['Nenhuma'] },
];

const equipamento = {
  intro: 'Você começa com o seguinte equipamento, além do equipamento concedido pelo seu antecedente:',
  itens: [
    { opcoes: ['Uma besta leve e 20 virotes', 'Qualquer arma simples'] },
    { opcoes: ['Uma bolsa de componentes', 'Um foco arcano'] },
    { opcoes: ['Um pacote de estudioso', 'Um pacote de explorador'] },
    { opcoes: ['Armadura de couro, qualquer arma simples e duas adagas'] },
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
  { nivel: 1, magiasConhecidas: 2, truquesConhecidos: 2, invocacoesConhecidas: '—', espacosDeMagia: 1, nivelDeMagia: '1º', caracteristicas: 'Patrono Transcendental, Magia de Pacto, Talento' },
  { nivel: 2, magiasConhecidas: 3, truquesConhecidos: 2, invocacoesConhecidas: 2, espacosDeMagia: 2, nivelDeMagia: '1º', caracteristicas: 'Invocações Místicas' },
  { nivel: 3, magiasConhecidas: 4, truquesConhecidos: 2, invocacoesConhecidas: 2, espacosDeMagia: 2, nivelDeMagia: '2º', caracteristicas: 'Dádiva do Pacto' },
  { nivel: 4, magiasConhecidas: 5, truquesConhecidos: 3, invocacoesConhecidas: 2, espacosDeMagia: 2, nivelDeMagia: '2º', caracteristicas: '-' },
  { nivel: 5, magiasConhecidas: 6, truquesConhecidos: 3, invocacoesConhecidas: 3, espacosDeMagia: 2, nivelDeMagia: '3º', caracteristicas: 'Talento' },
  { nivel: 6, magiasConhecidas: 7, truquesConhecidos: 3, invocacoesConhecidas: 3, espacosDeMagia: 3, nivelDeMagia: '3º', caracteristicas: 'Característica de Patrono' },
  { nivel: 7, magiasConhecidas: 8, truquesConhecidos: 3, invocacoesConhecidas: 3, espacosDeMagia: 3, nivelDeMagia: '4º', caracteristicas: '-' },
  { nivel: 8, magiasConhecidas: 9, truquesConhecidos: 3, invocacoesConhecidas: 4, espacosDeMagia: 3, nivelDeMagia: '4º', caracteristicas: '-' },
  { nivel: 9, magiasConhecidas: 10, truquesConhecidos: 4, invocacoesConhecidas: 4, espacosDeMagia: 3, nivelDeMagia: '5º', caracteristicas: '-' },
  { nivel: 10, magiasConhecidas: 11, truquesConhecidos: 4, invocacoesConhecidas: 4, espacosDeMagia: 4, nivelDeMagia: '5º', caracteristicas: 'Característica de Patrono, Talento' },
  { nivel: 11, magiasConhecidas: 12, truquesConhecidos: 4, invocacoesConhecidas: 5, espacosDeMagia: 4, nivelDeMagia: '5º', caracteristicas: 'Arcana Mística (6° nível)' },
  { nivel: 12, magiasConhecidas: 13, truquesConhecidos: 4, invocacoesConhecidas: 5, espacosDeMagia: 4, nivelDeMagia: '5º', caracteristicas: '-' },
  { nivel: 13, magiasConhecidas: 14, truquesConhecidos: 5, invocacoesConhecidas: 5, espacosDeMagia: 4, nivelDeMagia: '5º', caracteristicas: 'Arcana Mística (7° nível)' },
  { nivel: 14, magiasConhecidas: 15, truquesConhecidos: 5, invocacoesConhecidas: 6, espacosDeMagia: 5, nivelDeMagia: '5º', caracteristicas: 'Característica de Patrono' },
  { nivel: 15, magiasConhecidas: 16, truquesConhecidos: 5, invocacoesConhecidas: 6, espacosDeMagia: 5, nivelDeMagia: '5º', caracteristicas: 'Arcana Mística (8° nível), Talento' },
  { nivel: 16, magiasConhecidas: 17, truquesConhecidos: 5, invocacoesConhecidas: 6, espacosDeMagia: 5, nivelDeMagia: '5º', caracteristicas: '-' },
  { nivel: 17, magiasConhecidas: 18, truquesConhecidos: 5, invocacoesConhecidas: 7, espacosDeMagia: 5, nivelDeMagia: '5º', caracteristicas: 'Arcana Mística (9° nível)' },
  { nivel: 18, magiasConhecidas: 19, truquesConhecidos: 5, invocacoesConhecidas: 7, espacosDeMagia: 6, nivelDeMagia: '5º', caracteristicas: '-' },
  { nivel: 19, magiasConhecidas: 20, truquesConhecidos: 5, invocacoesConhecidas: 7, espacosDeMagia: 6, nivelDeMagia: '5º', caracteristicas: 'Lendário' },
  { nivel: 20, magiasConhecidas: 21, truquesConhecidos: 5, invocacoesConhecidas: 8, espacosDeMagia: 6, nivelDeMagia: '5º', caracteristicas: 'Mestre Místico, Talento' },
];

const conjuracaoTipo = 'Conjurador de Pacto';

const conjuracaoTexto =
  'Você conhece duas magias de 1° nível, à sua escolha, da lista de magias de bruxo. A coluna Magias Conhecidas na tabela O Bruxo mostra quando você aprende magias adicionais de bruxo, sempre de um nível ao qual você tenha acesso. Todos os seus espaços de magia de bruxo são do mesmo nível, mostrado na coluna Nível de Magia da tabela O Bruxo, e você recupera todos os espaços de magia gastos ao terminar um descanso curto ou longo. Além disso, quando você adquire um nível nessa classe, você pode escolher uma magia de bruxo que conhece e substituí-la por outra magia da lista de magias de bruxo, que também deve ser de um nível ao qual você tenha acesso. Você também pode conjurar qualquer magia de bruxo que conheça como um ritual, se ela possuir o descritor ritual, e usar um foco arcano como foco de conjuração das suas magias de bruxo.';

const tiposDeMagia = ['Natural', 'Divina', 'Arcana'];
const tipoMagiaBruxo = 'Arcana';

const fonteMagia =
  'O Bruxo extrai sua magia de um pacto firmado com uma entidade transcendental, sendo capaz de utilizar a magia arcana concedida por seu patrono.';

const atributoConjuracao = {
  nome: 'Carisma',
  bonus: ['Carisma', 'Proficiência'],
  cd: ['8', 'Proficiência', 'Carisma'],
  nota: 'Os valores de Carisma e Proficiência usados são os bônus respectivos.',
};

const caracteristicas = [
  {
    nivel: 1,
    titulo: 'Magia de Pacto',
    corpo: 'A tabela O Bruxo mostra quantos espaços de magia você possui. A tabela também mostra qual o nível desses espaços; todos os seus espaços de magia são do mesmo nível. Para conjurar uma magia de bruxo de 1° nível ou superior, você deve gastar um espaço de magia. Você recobra todos os espaços de magia gastos quando completa um <span class="dc-termo">descanso curto</span> ou <span class="dc-termo">descanso longo</span>.',
  },
  {
    nivel: 2,
    titulo: 'Invocações Místicas',
    corpo: 'No 2° nível, você adquire duas invocações místicas, à sua escolha. Suas opções de invocação estão detalhadas na tabela abaixo. Quando você atinge certos níveis nessa classe, você adquire novas invocações à sua escolha, como mostrado na coluna Invocações Conhecidas da tabela O Bruxo.\nAlém disso, quando você adquirir um novo nível nessa classe, você pode escolher uma invocação que você conheça e substituí-la por outra invocação que você possa aprender nesse nível. Se uma invocação tiver pré-requisitos, você precisa atendê-los para aprendê-la.',
    tabela: {
      colunaA: 'Invocação (Pré-requisito)',
      colunaB: 'Efeito',
      linhas: [
        { a: 'Armadura das Sombras', b: 'Você pode conjurar Armadura Arcana em si mesmo, à vontade, sem precisar gastar um espaço de magia ou componentes materiais.' },
        { a: 'Idioma Bestial', b: 'Você pode conjurar Falar Com Animais, à vontade, sem precisar gastar um espaço de magia.' },
        { a: 'Influência Enganadora', b: 'Você ganha proficiência nas perícias Enganação e Persuasão.' },
        { a: 'Máscara das Muitas Faces', b: 'Você pode conjurar Disfarçar, à vontade, sem precisar gastar um espaço de magia.' },
        { a: 'Mente Eldrítica', b: 'Você tem <span class="dc-termo">vantagem</span> em testes de resistência de <span class="dc-termo">Constituição</span> que você fizer para manter sua concentração.' },
        { a: 'Olhos do Guardião das Runas', b: 'Você pode ler todas as escritas. Você compreende qualquer símbolo ou palavra escrita, desde que tenham um significado linguístico.' },
        { a: 'Pacto da Corrente (Pacto da Corrente)', b: 'Você aprende a magia Convocar Familiar e pode lançá-la como um ritual, sem gastar um espaço de magia. Essa magia não conta no número de magias que você conhece. Quando você conjurar essa magia, você pode escolher uma das formas convencionais para o seu familiar ou uma das seguintes formas especiais: diabrete, pseudodragão, quasit ou sprite. Além disso, quando você realiza a <span class="dc-termo">ação de ataque</span>, você pode renunciar a um dos seus ataques para permitir que seu familiar realize um ataque com sua reação.' },
        { a: 'Pacto da Lâmina (Pacto da Lâmina)', b: 'Você pode usar sua <span class="dc-termo">ação</span> para criar uma arma de pacto em sua mão vazia. Você escolhe a forma que essa arma corpo-a-corpo tem a cada vez que você a cria. Você é proficiente com ela enquanto a empunhar. Essa arma conta como sendo mágica com os propósitos de ultrapassar resistência e imunidade a ataques e danos não-mágicos. Sua arma de pacto desaparece se ela estiver a mais de 1,5 metro de você por 1 minuto ou mais. Ela também desaparece se você usar essa característica novamente, se você dissipar a arma (não requer ação) ou se você morrer.' },
        { a: 'Pacto do Talismã (Pacto do Talismã)', b: 'Seu patrono lhe dá um amuleto, um talismã que pode ajudar o usuário quando a necessidade for grande. Quando o usuário falha em um teste de habilidade, ele pode adicionar um d4 ao teste, potencialmente transformando o teste em um sucesso. Este benefício pode ser usado um número de vezes igual ao seu bônus de proficiência, e todos os usos são restaurados quando você termina um <span class="dc-termo">descanso longo</span>. Se você perder o talismã, você pode realizar uma cerimônia de 1 hora para receber uma substituição de seu patrono. O talismã se transforma em cinzas quando você morre.' },
        { a: 'Pacto do Tomo (Pacto do Tomo)', b: 'Entrelaçando fios de sombra, você conjura um livro em sua mão ao final de um <span class="dc-termo">descanso curto</span> ou <span class="dc-termo">descanso longo</span>. Esse Livro das Sombras contém magia eldrítica que apenas você pode acessar. Quando o livro aparece, escolha três truques e duas magias de nível 1 que tenham o descritor de Ritual, de qualquer lista de magias de classe, que você ainda não conheça — elas funcionam como magias de bruxo para você enquanto o livro estiver com você. Você pode adicionar outras magias de ritual ao livro durante suas aventuras, se o nível da magia for igual ou inferior à metade do seu nível de bruxo (arredondado para baixo); a transcrição custa 2 horas e 50 po por nível da magia. Você pode usar o livro como Foco de Conjuração.' },
        { a: 'Visão Mística', b: 'Você pode conjurar Detectar Magia, à vontade, sem precisar gastar um espaço de magia.' },
        { a: 'Visões nas Brumas', b: 'Você pode conjurar Imagem Silenciosa, à vontade, sem precisar gastar um espaço de magia ou componentes materiais.' },
        { a: 'Arma de Pacto Melhorada (Nível 2, Pacto da Lâmina)', b: 'Sua arma de pacto ganha um bônus de +1 em testes de ataque e danos, desde que não seja uma arma mágica que já tenha um bônus para esses testes.' },
        { a: 'Ensinamento dos Primeiros (Nível 2, repetível)', b: 'Você recebeu conhecimento de uma entidade antiga do multiverso, permitindo que você ganhe um talento de Origem de sua escolha. Você pode adquirir essa invocação mais de uma vez, escolhendo um talento de Origem diferente a cada vez.' },
        { a: 'Harpão Místico (Nível 2, um truque de Bruxo que cause dano, repetível)', b: 'Escolha um dos truques de Bruxo que você conhece e que exige uma rolagem de ataque. Uma vez em cada um dos seus turnos quando atingir uma criatura com esse truque, você pode deslocar essa criatura em uma linha reta 3 metros em sua direção.' },
        { a: 'Lança Mística (Nível 2, um truque de Bruxo que cause dano, repetível)', b: 'Escolha um dos truques de Bruxo que você conhece, que cause dano e tenha alcance de 3 metros ou mais. Quando você conjura esse truque, seu alcance aumenta em um número de metros igual a 9 vezes o seu nível de Bruxo.' },
        { a: 'Lança da Letargia (Nível 2, um truque de Bruxo que cause dano, repetível)', b: 'Escolha um dos truques de Bruxo que você conhece e que cause dano. Uma vez em cada um dos seus turnos quando atingir uma criatura com esse truque, você pode reduzir o <span class="dc-termo">deslocamento</span> dessa criatura em 3 metros até o final do seu próximo turno.' },
        { a: 'Ladrão dos Cinco Destinos (Nível 2)', b: 'Você pode conjurar Perdição sem gastar um espaço de magia de bruxo. Você não pode fazer isso novamente até terminar um <span class="dc-termo">descanso longo</span>.' },
        { a: 'Dádiva dos Sempiternos (Nível 2, Pacto da Corrente)', b: 'Sempre que recuperar pontos de vida enquanto o seu familiar estiver a menos de 30 metros de alcance, trate todos os dados rolados para determinar os pontos de vida que recupera como tendo obtido seu valor máximo.' },
        { a: 'Rajada Agonizante (Nível 2, um truque de Bruxo que cause dano, repetível)', b: 'Escolha um dos truques de Bruxo que você conhece e que cause dano. Você pode adicionar seu modificador de <span class="dc-termo">Carisma</span> às rolagens de dano dessa magia.' },
        { a: 'Rajada Repulsiva (Nível 2, um truque de Bruxo que cause dano, repetível)', b: 'Escolha um dos truques de Bruxo que você conhece e que exige uma rolagem de ataque. Quando você acertar uma criatura Grande ou menor com esse truque, você pode empurrar a criatura até 3 metros diretamente para longe de você.' },
        { a: 'Retribuição do Talismã (Nível 2, Pacto do Talismã)', b: 'Quando o usuário do seu talismã é atingido por um atacante que você pode ver a até 9 metros de você, você pode usar sua reação para causar dano psíquico ao atacante igual ao seu modificador de <span class="dc-termo">Carisma</span> e empurrá-lo a até 3 metros de distância do usuário do talismã.' },
        { a: 'Salto de Outro Mundo (Nível 2)', b: 'Você pode conjurar Salto em si mesmo, à vontade, sem precisar gastar um espaço de magia ou componentes materiais.' },
        { a: 'Vigor Abissal (Nível 2)', b: 'Você pode conjurar Vitalidade Falsa em si mesmo, à vontade, como uma magia de 1° nível, sem precisar gastar um espaço de magia ou componentes materiais. Você recebe automaticamente o valor máximo de pontos de vida temporários no dado.' },
        { a: 'Visão Diabólica (Nível 2)', b: 'Você pode ver normalmente em Penumbra e Escuridão — tanto mágica quanto não-mágica — a até 36 metros de você.' },
        { a: 'Dádivas das Profundezas (Nível 5)', b: 'Você pode respirar debaixo da água e ganha um <span class="dc-termo">deslocamento</span> de natação igual ao seu <span class="dc-termo">deslocamento</span> de caminhada. Também pode conjurar respirar na água uma vez sem gastar um espaço de magia, recuperando a capacidade ao terminar um <span class="dc-termo">descanso longo</span>.' },
        { a: 'Destruição Mística (Nível 5, Pacto da Lâmina)', b: 'Uma vez por turno, quando você atinge uma criatura com sua arma do pacto, você pode gastar um espaço de magia de bruxo para causar dano de energia adicional de 1d8 ao alvo, além de mais 1d8 por nível do espaço de magia, e pode derrubar o oponente se ele for Enorme ou menor.' },
        { a: 'Encharcar a Mente (Nível 5)', b: 'Você pode conjurar Lentidão, uma vez, sem gastar um espaço de magia. Você recupera a capacidade de fazê-lo quando terminar um <span class="dc-termo">descanso longo</span>.' },
        { a: 'Escriba Distante (Nível 5, Pacto do Tomo)', b: 'Uma nova página aparece em seu Livro das Sombras. Com sua permissão, uma criatura pode usar sua ação para escrever seu nome em tal página (até um número de nomes igual ao seu bônus de proficiência). Você pode então conjurar Enviar Mensagem para essa criatura sem gastar espaço de magia nem componentes materiais.' },
        { a: 'Investimento do Mestre das Correntes (Nível 5, Pacto da Corrente)', b: 'Quando você conjurar Convocar Familiar, você infunde o familiar com uma parcela de seu poder místico: velocidade de voo ou natação de 12 metros, ação bônus de Ataque Rápido, dano necrótico ou radiante em vez do normal, sua CD de magia para os testes de resistência do familiar, e você pode conceder Resistência ao dano que ele sofrer com sua reação.' },
        { a: 'Lâmina Sedenta (Nível 5, Pacto da Lâmina)', b: 'Você pode atacar com sua arma do pacto duas vezes, ao invés de apenas uma, quando você usa a <span class="dc-termo">ação de ataque</span> no seu turno.' },
        { a: 'Maldição Enlouquecedora (Nível 5, Pacto da Lâmina; magia Bruxaria ou outra habilidade que amaldiçoe um alvo)', b: 'Como uma <span class="dc-termo">ação bônus</span>, você causa dano psíquico ao alvo amaldiçoado por Bruxaria (ou por Maldição da Lâmina ou Sinal de Mal Agouro) e a cada criatura de sua escolha a até 1,5 metro dele, igual ao seu modificador de <span class="dc-termo">Carisma</span> (mínimo de 1 dano). O alvo deve estar a até 9 metros de alcance.' },
        { a: 'Manto de Moscas (Nível 5)', b: 'Como <span class="dc-termo">ação bônus</span>, cerca-se com uma aura mágica de moscas em 1,5 metro de alcance. Concede <span class="dc-termo">vantagem</span> em Intimidação mas <span class="dc-termo">desvantagem</span> em outros testes de <span class="dc-termo">Carisma</span>, e causa dano de veneno igual ao seu modificador de <span class="dc-termo">Carisma</span> a criaturas que comecem o turno na aura.' },
        { a: 'Mestre das Infindáveis Formas (Nível 5)', b: 'Você pode conjurar Alterar, à vontade, sem precisar gastar um espaço de magia.' },
        { a: 'Olhar de Duas Mentes (Nível 5)', b: 'Você pode usar uma <span class="dc-termo">ação bônus</span> para tocar uma criatura disposta e perceber através de seus sentidos até o final do seu próximo turno, mantendo a conexão em turnos subsequentes com outra <span class="dc-termo">ação bônus</span>.' },
        { a: 'Passo Ascendente (Nível 5)', b: 'Você pode conjurar Levitação em si mesmo, à vontade, sem precisar gastar um espaço de magia ou componentes materiais.' },
        { a: 'Servidão Imortal (Nível 5)', b: 'Você pode conjurar Animar Mortos, uma vez, sem gastar um espaço de magia. Você recupera a capacidade de fazê-lo quando terminar um <span class="dc-termo">descanso longo</span>.' },
        { a: 'Sinal de Mau Agouro (Nível 5)', b: 'Você pode conjurar Rogar Maldição, uma vez, sem gastar um espaço de magia de bruxo. Você recupera a capacidade de fazê-lo quando terminar um <span class="dc-termo">descanso longo</span>.' },
        { a: 'Túmulo de Levistus (Nível 5)', b: 'Como reação quando você recebe dano, você se enterra em gelo, ganhando 10 pontos de vida temporários por nível de bruxo, mas ficando com vulnerabilidade a dano de fogo, <span class="dc-termo">deslocamento</span> reduzido a 0 e incapacitado até o gelo derreter no início do seu próximo turno.' },
        { a: 'Um Com as Sombras (Nível 5)', b: 'Enquanto você estiver em uma área de Penumbra ou Escuridão, você pode conjurar Invisibilidade em si mesmo sem gastar um espaço de magia.' },
        { a: 'Escultor de Carne (Nível 7)', b: 'Você pode conjurar Metamorfose, uma vez, sem gastar um espaço de magia de bruxo. Você recupera a capacidade de fazê-lo quando terminar um <span class="dc-termo">descanso longo</span>.' },
        { a: 'Fuga do Trapaceiro (Nível 7)', b: 'Você pode conjurar Movimentação Livre em si mesmo, uma vez, sem gastar um espaço de magia. Você recupera a capacidade de fazê-lo quando terminar um <span class="dc-termo">descanso longo</span>.' },
        { a: 'Maldição Incansável (Nível 7; magia Bruxaria ou outra habilidade que amaldiçoe um alvo)', b: 'Como uma <span class="dc-termo">ação bônus</span>, você pode se teleportar magicamente para um espaço desocupado que você possa ver a até 1,5 metro do alvo amaldiçoado por Bruxaria (ou por Maldição da Lâmina ou Sinal de Mal Agouro).' },
        { a: 'Olhar Fantasmagórico (Nível 7)', b: 'Como <span class="dc-termo">ação</span>, você ganha a capacidade de ver através de objetos sólidos até um alcance de 9 metros por 10 minutos, adquirindo visão no escuro caso ainda não a possua.' },
        { a: 'Palavra Terrível (Nível 7)', b: 'Você pode conjurar Confusão, uma vez, sem gastar um espaço de magia de bruxo. Você recupera a capacidade de fazê-lo quando terminar um <span class="dc-termo">descanso longo</span>.' },
        { a: 'Proteção do Talismã (Nível 7, Pacto do Talismã)', b: 'Quando o portador de seu talismã falha em um teste de resistência, ele pode adicionar um d4 ao teste, um número de vezes igual ao seu bônus de proficiência, restaurado ao terminar um <span class="dc-termo">descanso longo</span>.' },
        { a: 'Sussurros Sedutores (Nível 7)', b: 'Você pode conjurar Compulsão, uma vez, sem gastar um espaço de magia de bruxo. Você recupera a capacidade de fazê-lo quando terminar um <span class="dc-termo">descanso longo</span>.' },
        { a: 'Sussurros da Sepultura (Nível 7)', b: 'Você pode conjurar Falar Com Os Mortos, à vontade, sem precisar gastar um espaço de magia.' },
        { a: 'Benção dos Protetores (Nível 9, Pacto do Tomo)', b: 'Uma nova página aparece em seu Livro das Sombras. Quando qualquer criatura cujo nome consta na página tiver seus pontos de vida reduzidos a 0, mas não estiver morta, ela magicamente volta a ter 1 ponto de vida em vez disso. Só pode ser desencadeada uma vez até você finalizar um <span class="dc-termo">descanso longo</span>.' },
        { a: 'Correntes de Carceri (Nível 9, Pacto da Corrente)', b: 'Você pode conjurar Imobilizar Monstro, à vontade — tendo como alvo um celestial, corruptor, elemental ou fada — sem precisar gastar um espaço de magia ou componentes materiais, uma vez por criatura até um <span class="dc-termo">descanso longo</span>.' },
        { a: 'Lacaios do Caos (Nível 9)', b: 'Você pode conjurar Conjurar Elemental, uma vez, sem gastar um espaço de magia de bruxo. Você recupera a capacidade de fazê-lo quando terminar um <span class="dc-termo">descanso longo</span>.' },
        { a: 'Sorvedor de Vidas (Nível 9, Pacto da Lâmina)', b: 'Quando você atinge uma criatura com sua arma do pacto, ela sofre 1d6 de dano necrótico, radiante ou psíquico adicional (sua escolha). Uma vez por turno você também pode gastar um Dado de Vida para recuperar pontos de vida iguais ao resultado mais seu modificador de <span class="dc-termo">Constituição</span>.' },
        { a: 'Vínculo do Talismã (Nível 9, Pacto do Talismã)', b: 'Enquanto outra criatura estiver usando seu talismã, você pode usar sua ação para se teletransportar para um espaço desocupado próximo a ela (e vice-versa), um número de vezes igual ao seu bônus de proficiência, restaurado ao terminar um <span class="dc-termo">descanso longo</span>.' },
        { a: 'Visões de Reinos Distantes (Nível 9)', b: 'Você pode conjurar Olho Arcano, à vontade, sem precisar gastar um espaço de magia.' },
        { a: 'Lâmina Devoradora (Nível 12, invocação mística Lâmina Sedenta)', b: 'O Ataque Extra da sua invocação da Lâmina Sedenta confere dois ataques extras em vez de um.' },
        { a: 'Visão de Bruxa (Nível 15)', b: 'Você tem Visão Verdadeira com um alcance de 90 metros.' },
      ],
    },
  },
  {
    nivel: 3,
    titulo: 'Dádiva do Pacto',
    corpo: 'No 3° nível, seu patrono transcendental lhe confere um dom por seus leais serviços. Você adquire uma das características a seguir, à sua escolha.',
    tabela: {
      colunaA: 'Pacto',
      colunaB: 'Efeito',
      linhas: [
        { a: 'Pacto da Corrente', b: 'Você aprende a magia Convocar Familiar e pode conjurá-la como um ritual. Essa magia não conta no número de magias que você conhece. Quando você conjurar essa magia, você pode escolher uma das formas convencionais para o seu familiar ou uma das seguintes formas especiais: diabrete, pseudodragão, quasit ou sprite. Além disso, quando você realiza a <span class="dc-termo">ação de ataque</span>, você pode renunciar a um dos seus ataques para permitir que seu familiar realize um ataque com sua reação.' },
        { a: 'Pacto da Lâmina', b: 'Você pode usar sua <span class="dc-termo">ação</span> para criar uma arma de pacto em sua mão vazia. Você escolhe a forma que essa arma corpo-a-corpo tem a cada vez que você a cria (veja as opções de arma no capítulo 5). Você é proficiente com ela enquanto a empunhar. Essa arma conta como sendo mágica com os propósitos de ultrapassar resistência e imunidade a ataques e danos não-mágicos.\nSua arma de pacto desaparece se ela estiver a mais de 1,5 metro de você por 1 minuto ou mais. Ela também desaparece se você usar essa característica novamente, se você dissipar a arma (não requer ação) ou se você morrer.\nVocê pode transformar uma arma mágica em sua arma de pacto ao realizar um ritual especial enquanto empunha a arma. Você precisa de 1 hora para concluir o ritual, que pode ser realizado durante um <span class="dc-termo">descanso curto</span>. Você pode dissipar a arma, guardando-a em um espaço extradimensional, e ela reaparece toda vez que você criar sua arma de pacto. A arma deixa de ser sua arma de pacto se você realizar um ritual de 1 hora com outra arma diferente ou se você realizar um ritual de 1 hora para romper seu elo com ela. A arma aparece aos seus pés se ela estiver no espaço extradimensional quando o elo for quebrado.' },
        { a: 'Pacto do Tomo', b: 'Seu patrono lhe dá um grimório chamado Livro das Sombras. Quando você adquire essa característica, escolha três truques da lista de magias de qualquer classe. Enquanto o livro estiver com você, você poderá conjurar esses truques à vontade. Eles não contam no número de truques que você conhece. Esses truques são considerados magias de bruxo para você e não precisam ser da mesma lista de magia.\nSe você perder seu Livro das Sombras, você pode realizar uma cerimônia de 1 hora para receber o substituto do seu patrono. Essa cerimônia pode ser realizada durante um <span class="dc-termo">descanso curto</span> ou <span class="dc-termo">descanso longo</span> e destrói o livro anterior. O livro se torna cinzas quando você morre.' },
      ],
    },
  },
  {
    nivel: 11,
    titulo: 'Arcana Mística',
    corpo: 'No 11° nível, seu patrono confere a você um segredo mágico conhecido como arcana. Escolha uma magia de 6° nível da lista de magias de bruxo como sua arcana.\nVocê pode conjurar essa magia arcana uma vez sem gastar um espaço de magia. Você deve terminar um <span class="dc-termo">descanso longo</span> antes de poder fazer isso novamente.\nEm níveis altos, você adquire mais magias de bruxo de sua escolha que podem ser conjuradas dessa forma: uma magia de 7° nível no 13° nível, uma magia de 8° nível no 15° nível e uma magia de 9° nível no 17° nível. Você recupera todos os usos de sua Arcana Mística quando você termina um <span class="dc-termo">descanso longo</span>.',
  },
  {
    nivel: 19,
    titulo: 'Lendário',
    corpo: 'Ao atingir o 19°, você pode escolher um <span class="dc-termo">talento</span> épico.',
  },
  {
    nivel: 20,
    titulo: 'Mestre Místico',
    corpo: 'No 20° nível, você se torna uma reserva poderosa de magia. Todas suas magias de pacto são conjuradas como se estivesse utilizando um espaço de magia de 6° nível.\nAlém disso, sempre que você rolar a <span class="dc-termo">iniciativa</span>, você recebe a magia do seu patrono. Role 1d4 para definir a quantidade de espaços de magia extras que você possuirá durante esse combate.',
  },
];

const subclasses = [
  {
    nome: 'Alien',
    icone: '👁️',
    introTexto: 'Seu patrono é uma entidade misteriosa cuja natureza é totalmente estranha ao tecido da realidade. Pode vir do Reino Far, o espaço além da realidade, ou pode ser um dos deuses mais velhos conhecidos apenas nas lendas. Seus motivos são incompreensíveis para os mortais, e seu conhecimento é tão imenso e antigo que até mesmo as maiores bibliotecas empalidecem em comparação com os vastos segredos que ele guarda. O Grande Ido pode não estar ciente de sua existência ou totalmente indiferente a você, mas os segredos que você aprendeu permitem que você extraia sua magia dele.',
    magias: [
      { nivel: '1º', magia: 'Sussurros Dissonantes, Riso Histérico de Tasha' },
      { nivel: '3º', magia: 'Detectar Pensamentos, Força Fantasmagórica' },
      { nivel: '5º', magia: 'Vidência, Enviar Mensagem' },
      { nivel: '7º', magia: 'Dominar Besta, Tentáculos Negros de Evard' },
      { nivel: '9º', magia: 'Dominar Pessoa, Telecinese' },
    ],
    caracteristicas: [
      {
        nivel: 1,
        titulo: 'O Despertar da Mente',
        corpo: 'Começando no 1° nível, seu conhecimento alienígena lhe dá a capacidade de tocar as mentes de outras criaturas. Você pode falar telepaticamente com qualquer criatura que você pode ver dentro de 9 metros de você. Você não precisa compartilhar uma linguagem com a criatura para que ela entenda suas declarações telepáticas, mas a criatura deve ser capaz de entender pelo menos um idioma.',
      },
      {
        nivel: 6,
        titulo: 'Símbolo de Entropia',
        corpo: 'No 6° nível, você aprende magicamente a se afastar do ataque e transformar o ataque fracassado de um inimigo em boa sorte para si mesmo. Quando uma criatura faz um ataque contra você, você pode usar sua reação para impor <span class="dc-termo">desvantagem</span> nesse teste. Se o ataque falhar, seu próximo ataque contra a criatura tem <span class="dc-termo">vantagem</span> se você conseguir antes do final do próximo turno.\nVocê pode utilizar essa habilidade um número de vezes igual ao seu bônus de proficiência. Você recupera todos os usos após terminar um <span class="dc-termo">descanso curto</span> ou <span class="dc-termo">descanso longo</span>.',
      },
      {
        nivel: 10,
        titulo: 'Escudo do Pensamento',
        corpo: 'A partir do 10° nível, seus pensamentos não podem ser lidos por telepatia ou outros meios, a menos que você permita. Você também tem resistência a danos psíquicos, e sempre que uma criatura causa dano psíquico a você, essa criatura toma a mesma quantidade de dano que você.',
      },
      {
        nivel: 14,
        titulo: 'Criar Escravo',
        corpo: 'No 14° nível, você ganha a capacidade de infectar a mente de um humanoide com a magia alienígena de seu patrono. Você pode usar sua <span class="dc-termo">ação</span> para tocar um humanoide incapacitado. Essa criatura fica encantada por você até que um feitiço Remover Maldição seja lançado sobre ele, a condição encantada seja removida dele, ou você use esse recurso novamente.\nVocê pode se comunicar telepaticamente com a criatura encantada, desde que vocês dois estejam no mesmo plano de existência.',
      },
    ],
  },
  {
    nome: 'Arch Fada',
    icone: '🧚',
    introTexto: 'Seu patrono é um senhor ou dama da fada, uma criatura de lenda que guarda segredos que foram esquecidos antes que as raças mortais nascessem. As motivações deste ser são muitas vezes inescrutáveis e às vezes caprichosas, e podem envolver uma luta por um maior poder mágico ou o assentamento de rancores antigos.',
    magias: [
      { nivel: '1º', magia: 'Fogo das Fadas, Sono' },
      { nivel: '3º', magia: 'Acalmar Emoções, Força Fantasmagórica' },
      { nivel: '5º', magia: 'Piscar, Ampliar Plantas' },
      { nivel: '7º', magia: 'Dominar Besta, Maior Invisibilidade' },
      { nivel: '9º', magia: 'Dominar Pessoa, Similaridade' },
    ],
    caracteristicas: [
      {
        nivel: 1,
        titulo: 'Presença de Fada',
        corpo: 'Começando no 1° nível, seu patrono concede a você a capacidade de projetar a presença sedutora e temível da fada. Como uma <span class="dc-termo">ação</span>, você pode fazer com que cada criatura em um cubo de 3 metros originário de você faça um teste de resistência de <span class="dc-termo">Sabedoria</span> contra o seu CD de feitiço. As criaturas que falham em seus testes de resistência estão todas encantadas ou assustadas com você (sua escolha) até o final do seu próximo turno.\nDepois de usar esse recurso, você não pode usá-lo novamente até terminar um <span class="dc-termo">descanso curto</span> ou <span class="dc-termo">descanso longo</span>.',
      },
      {
        nivel: 6,
        titulo: 'Escapada Mística',
        corpo: 'Começando no 6° nível, você pode desaparecer em um sopro de névoa em resposta a danos. Quando você sofre danos, você pode usar sua reação para ficar invisível e se teletransportar até 18 metros para um espaço desocupado que você pode ver. Você permanece invisível até o início do seu próximo turno ou até que você ataque ou conjure um feitiço.\nVocê pode utilizar essa habilidade um número de vezes igual ao seu bônus de proficiência. Você recupera todos os usos após terminar um <span class="dc-termo">descanso curto</span> ou <span class="dc-termo">descanso longo</span>.',
      },
      {
        nivel: 10,
        titulo: 'Defesas Sedutoras',
        corpo: 'Começando no 10° nível, seu patrono ensina como transformar a magia que afeta a mente de seus inimigos contra eles. Você está imune a ficar encantado, e quando outra criatura tenta encantá-lo, você pode usar sua reação para tentar transformar o charme de volta nessa criatura. A criatura deve ter sucesso em um teste de resistência de <span class="dc-termo">Sabedoria</span> contra o seu CD de feitiço ou fica encantada por você por 1 minuto ou até que a criatura tome qualquer dano.',
      },
      {
        nivel: 14,
        titulo: 'Delírio Escuro',
        corpo: 'Começando no 14° nível, você pode mergulhar uma criatura em um reino ilusório. Como <span class="dc-termo">ação</span>, escolha uma criatura que você pode ver a 18 metros de distância. Ela deve fazer um teste de resistência de <span class="dc-termo">Sabedoria</span> contra o seu CD de feitiço. Em uma falha, ela fica encantada e assustada por você (sua escolha) por 1 minuto ou até que sua concentração seja quebrada (como se você estivesse se concentrando em um feitiço). Este efeito termina cedo se a criatura tomar qualquer dano.\nAté que essa ilusão termine, a criatura pensa que está perdida em um reino enevoado, cuja aparência você escolhe. A criatura pode ver e ouvir apenas a si mesma, você e a ilusão.\nVocê deve terminar um <span class="dc-termo">descanso curto</span> ou <span class="dc-termo">descanso longo</span> antes de poder usar esse recurso novamente.',
      },
    ],
  },
  {
    nome: 'O Diabo',
    icone: '😈',
    introTexto: 'Você fez um pacto com um Diabo, um ser cujos objetivos são maus, mesmo que você se esforce contra esses objetivos. Esses seres desejam a corrupção ou a destruição de todas as coisas, incluindo você. Demônios poderosos o suficiente para forjar um pacto incluem senhores demônios.',
    magias: [
      { nivel: '1º', magia: 'Mãos Flamejantes, Comando' },
      { nivel: '3º', magia: 'Cegueira/Surdez, Força Fantasmagórica' },
      { nivel: '5º', magia: 'Bola de Fogo, Nuvem Fétida' },
      { nivel: '7º', magia: 'Escudo de Fogo, Parede de Fogo' },
      { nivel: '9º', magia: 'Coluna de Chamas, Consagrar' },
    ],
    caracteristicas: [
      {
        nivel: 1,
        titulo: 'A Bênção do Sinistro',
        corpo: 'Começando no 1° nível, quando você reduz uma criatura hostil a 0 pontos de vida, você ganha pontos de vida temporários iguais ao seu modificador de <span class="dc-termo">Carisma</span> + seu nível de bruxo (mínimo de 1).',
      },
      {
        nivel: 6,
        titulo: 'Sorte do Maligno',
        corpo: 'A partir do 6° nível, você pode chamar seu patrono para alterar o destino a seu favor. Quando você faz um teste de habilidade ou um teste de resistência, você pode usar esse recurso para adicionar um d10 ao seu teste. Você pode fazer isso depois de ver o resultado inicial, mas antes de qualquer um dos efeitos do teste ocorrer.\nVocê pode utilizar essa habilidade um número de vezes igual ao seu bônus de proficiência. Você recupera todos os usos após terminar um <span class="dc-termo">descanso curto</span> ou <span class="dc-termo">descanso longo</span>.',
      },
      {
        nivel: 10,
        titulo: 'Resiliência Demoníaca',
        corpo: 'Começando no 10° nível, você pode escolher um tipo de dano quando terminar um <span class="dc-termo">descanso curto</span> ou <span class="dc-termo">descanso longo</span>. Você ganha resistência a esse tipo de dano até escolher um diferente com esse recurso. Danos de armas mágicas ou armas de prata ignoram essa resistência.',
      },
      {
        nivel: 14,
        titulo: 'Vislumbre do Abismo',
        corpo: 'A partir do 14° nível, quando você atinge uma criatura com um ataque, você pode usar esse recurso para transportar instantaneamente o alvo através das camadas do inferno. A criatura desaparece e atravessa uma paisagem de pesadelo.\nNo final do seu próximo turno, o alvo retorna ao espaço ocupado anteriormente ou ao espaço desocupado mais próximo. Se o alvo não é um diabo, ele recebe 12d12 + 36 de dano psíquico, pois se recupera de sua experiência horrível. O alvo então sofre penalidade de -5 em todas as suas rolagens de d20. A penalidade diminui em 1 a cada turno, desaparecendo quando chegar a 0.\nDepois de usar esse recurso, você não poderá usá-lo novamente até terminar um <span class="dc-termo">descanso longo</span>.',
      },
    ],
  },
  {
    nome: 'O Hexblade',
    icone: '🗡️',
    introTexto: 'Você fez seu pacto com uma entidade misteriosa — uma força que se manifesta em armas mágicas sencientes esculpidas pelo material da sombra. A poderosa espada Blackrazor é a mais notável dessas armas, que foram espalhadas pelo multiverso ao longo dos tempos. A força sombria por trás dessas armas pode oferecer poder aos bruxos que formam pactos com ela. Muitos bruxos Hexblade criam armas que imitam as formadas no Shadowfell. Outros renunciam a esses braços, contentes em tecer a magia negra desse plano em sua conjuração.',
    magias: [
      { nivel: '1º', magia: 'Escudo, Destruição Colérica' },
      { nivel: '3º', magia: 'Nublar, Marca da Punição' },
      { nivel: '5º', magia: 'Piscar, Arma Elemental' },
      { nivel: '7º', magia: 'Assassino Fantasmagórico, Destruição Estontenante' },
      { nivel: '9º', magia: 'Destruição Banidora, Cone de Frio' },
    ],
    caracteristicas: [
      {
        nivel: 1,
        titulo: 'A Maldição de Hexblade',
        corpo: `Começando no 1° nível, você ganha a capacidade de colocar uma maldição funesta em alguém. Como uma <span class="dc-termo">ação bônus</span>, escolha uma criatura que você pode ver dentro de 9 metros de você. O alvo é amaldiçoado por 1 minuto. A maldição termina cedo se o alvo morrer, você morrer ou se estiver incapacitado. Até que a maldição termine, você ganha os seguintes benefícios:
<ul><li>Você ganha um bônus em rolos de dano contra o alvo amaldiçoado. O bônus é igual ao seu bônus de proficiência.</li><li>Qualquer jogada de ataque que você fizer contra o alvo amaldiçoado é um golpe crítico em um rolo de 19 ou 20 no d20.</li><li>Se o alvo amaldiçoado morrer, você recupera pontos de vida iguais ao seu nível de bruxo + seu modificador de <span class="dc-termo">Carisma</span> (mínimo de 1 ponto de vida).</li></ul>
Você não pode usar esse recurso novamente até terminar um <span class="dc-termo">descanso curto</span> ou <span class="dc-termo">descanso longo</span>.`,
      },
      {
        nivel: 1,
        titulo: 'Guerreiro Hex',
        corpo: 'No 1° nível, você adquire o treinamento necessário para efetivamente se armar para a batalha. Você ganha proficiência com armaduras médias, escudos e armas marciais.\nA influência do seu patrono também permite que você canalize misticamente sua vontade através de uma arma em particular. Sempre que você terminar um <span class="dc-termo">descanso longo</span>, você pode tocar uma arma com a qual você é proficiente e que não tem a propriedade de duas mãos. Quando você ataca com essa arma, você pode usar seu modificador de <span class="dc-termo">Carisma</span>, em vez de <span class="dc-termo">Força</span> ou <span class="dc-termo">Destreza</span>, para o ataque e rolos de dano. Este benefício dura até terminar um <span class="dc-termo">descanso longo</span>. Se você mais tarde ganhar o recurso Pacto da Lâmina, esse benefício se estende a todas as armas do pacto que você conjurar com esse recurso, não importa o tipo de arma.',
      },
      {
        nivel: 6,
        titulo: 'Armadura de Hexes',
        corpo: 'No 6° nível, seu hexblade fica mais poderoso. Se o alvo amaldiçoado pela <span class="dc-termo">Maldição de Hexblade</span> atingir você com um teste de ataque, você pode usar sua reação para rolar um d6. Em um 4 ou superior, o ataque erra contra você, independentemente do seu teste.',
      },
      {
        nivel: 10,
        titulo: 'Fome Hex',
        corpo: 'No 10° nível, seu hex se torna maior. Você agora pode marcar uma quantidade de criaturas igual ao seu bônus de proficiência ao invés de apenas uma.',
      },
      {
        nivel: 14,
        titulo: 'O Mestre dos Hexes',
        corpo: 'A partir do 14° nível, você sempre sabe onde suas criaturas marcadas estão. Além disso, você sempre possui <span class="dc-termo">vantagem</span> em jogadas de ataque contra inimigos marcados e eles possuem <span class="dc-termo">desvantagem</span> contra você.',
      },
    ],
  },
  {
    nome: 'O Viajante da Noite',
    icone: '🌒',
    introTexto: 'O Viajante da Noite é uma Antiga que vaga pelos céus de Grisa todas as noites após o crepúsculo. Ela é conhecida por observar os atos nefastos realizados na calada da noite, que nunca passam despercebidos por ela. Essas ações são registradas em sua memória, que remonta tão longe quanto o comprimento de seus cabelos brancos pálidos. Um dia, elas serão usadas como julgamento contra os malfeitores. Zan\'ya pune aqueles que considera destrutivos ao equilíbrio de Grisa com uma mistura de maldições e pragas. Dizem que seu sopro é a origem dos calafrios noturnos. Aqueles que fazem pactos com Zan\'ya geralmente aderem ao vigilantismo, especialmente em relação a atividades noturnas.',
    magias: [
      { nivel: '1º', magia: 'Perdição, Convocar Familiar' },
      { nivel: '3º', magia: 'Prisão de Gelo de Binding, Força Fantasmagórica' },
      { nivel: '5º', magia: 'Rogar Maldição, Nevasca' },
      { nivel: '7º', magia: 'Tempestade de Gelo, Terreno Alucinógeno' },
      { nivel: '9º', magia: 'Dissipar Bem e Mal, Imobilizar Monstro' },
    ],
    caracteristicas: [
      {
        nivel: 1,
        titulo: 'Armadilha Glacial',
        corpo: 'A partir do 1° nível, quando você causa dano a uma criatura você cria um espinho de gelo no local da criatura. Se a criatura terminar seu turno acima do espinho ele explode causando uma quantidade de dano de gelo igual ao seu bônus de proficiência.',
      },
      {
        nivel: 6,
        titulo: 'Cobertura Noturna',
        corpo: 'A partir do 6° nível, você pode criar sua própria porção de noite para anular a visão de outros. Quando atingir uma criatura com um ataque e causar dano a ela, você pode fazer com que uma nuvem de escuridão negra se estenda em um raio de 4,5 metros ao redor do alvo. Essa área torna-se fortemente obscurecida e é considerada como escuridão mágica. A nuvem sombria dura até o final do seu próximo turno, quando então se dissipa.\nVocê pode usar este recurso um número de vezes igual ao seu modificador de <span class="dc-termo">Carisma</span> (mínimo de 1) e recupera todos os usos após um <span class="dc-termo">descanso longo</span>.',
      },
      {
        nivel: 10,
        titulo: 'Justiça Zero',
        corpo: 'A partir do 10° nível, seus ataques cortam com precisão gélida, atingindo apropriadamente o coração dos malfeitores. Você ganha resistência a dano de frio.\nAlém disso, quando atingir uma criatura com um ataque e causar dano a ela, você pode substituir o tipo de dano por dano de frio. Uma vez por turno, quando causar dano de frio a uma criatura com um ataque, você pode adicionar seu bônus de proficiência à rolagem de dano.',
      },
      {
        nivel: 14,
        titulo: 'Projeção de Visão',
        corpo: `A partir do 14° nível, você pode projetar sua consciência e testemunhar eventos a uma grande distância, como a observadora Zan'ya. Como uma <span class="dc-termo">ação</span>, você pode projetar seu espírito para fora de seu corpo. O corpo que você deixa para trás fica inconsciente e em um estado de animação suspensa.
Seu espírito pode permanecer fora de seu corpo por até 1 hora ou até que você encerre este recurso como uma <span class="dc-termo">ação bônus</span>. Quando a projeção termina, seu espírito retorna ao corpo ou o corpo se teletransporta magicamente para o espaço ocupado pelo espírito (à sua escolha).
Enquanto projeta seu espírito, você ganha os seguintes benefícios:
<ul><li>Seu espírito e corpo ganham resistência a dano cortante, perfurante e contundente.</li><li>Seu espírito é invisível.</li><li>Você pode conjurar a magia adivinhação. Se conjurar dessa forma, não são necessários componentes materiais.</li><li>Você tem uma velocidade de voo igual à sua velocidade de caminhada e pode flutuar. Você pode se mover através de criaturas e objetos como se fossem terreno difícil, mas sofre 1d10 de dano de força se terminar seu turno dentro de uma criatura ou objeto.</li></ul>
Depois de usar este recurso, você não pode usá-lo novamente até terminar um <span class="dc-termo">descanso longo</span>.`,
      },
    ],
  },
];

// Escolha de subclasse — todo personagem escolhe uma subclasse em algum
// nível, independente da classe; por isso fica junto dos outros pontos
// fixos em Fundamentos da Classe, não na lista de características do
// Bruxo. As opções vêm do próprio array `subclasses`, pra não duplicar
// nome/ícone em dois lugares.
const subclasseEscolha = {
  titulo: 'Patrono Transcendental',
  corpo: 'No 1° nível, você conclui uma barganha com um ser transcendental, à sua escolha. Sua escolha lhe confere características no 1° nível e novamente no 6°, 10° e 14° nível.',
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

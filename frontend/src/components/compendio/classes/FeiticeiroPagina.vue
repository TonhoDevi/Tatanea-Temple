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
        <h2 class="dc-section-title">Progressão — O Feiticeiro</h2>
        <span class="dc-title-line"></span>
      </div>
      <div class="dc-tabela-wrap">
        <table class="dc-tabela-niveis">
          <thead>
            <tr>
              <th>Nível</th>
              <th>Características</th>
              <th class="dc-th-centro">Truques Conhecidos</th>
              <th class="dc-th-centro">Magias Conhecidas</th>
              <th class="dc-th-centro">Nível de Magia</th>
              <th class="dc-th-centro">Pontos de Magia</th>
            </tr>
          </thead>
          <tbody>
            <tr v-for="n in niveis" :key="n.nivel">
              <td class="dc-tabela-nivel">{{ n.nivel }}º</td>
              <td class="dc-tabela-carac">{{ n.caracteristicas }}</td>
              <td class="dc-tabela-bonus">{{ n.truquesConhecidos }}</td>
              <td class="dc-tabela-bonus">{{ n.magiasConhecidas }}</td>
              <td class="dc-tabela-bonus">{{ n.nivelDeMagia }}</td>
              <td class="dc-tabela-bonus">{{ n.pontosDeMagia }}</td>
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
      <p class="dc-fundamentos-nota">Regras comuns a toda classe — não são exclusivas do Feiticeiro.</p>

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
            <span class="dc-conjuracao-tipo-prefixo">O Feiticeiro é</span>
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
              :class="{ 'dc-chip-tipo-magia-ativo': t === tipoMagiaFeiticeiro, 'dc-chip-tipo-magia-inativo': t !== tipoMagiaFeiticeiro }"
              v-for="t in tiposDeMagia"
              :key="t"
            >{{ t.toUpperCase() }}</span>
          </div>

          <span class="dc-atributo-magia-rotulo">O Atributo de Conjuração do Feiticeiro</span>
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
                  <th>Nível do Feiticeiro</th>
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
  nome: 'Feiticeiro',
  subtitulo: 'Versão Épico',
  icone: '✨',
  cor: '#8c4a8c',
  dadoDeVida: 'd6',
  dificuldade: 'Difícil',
  papeis: ['Dano', 'Controle'],
};

const descricaoBlocos = [
  {
    titulo: null,
    paragrafos: [
      'Com olhos brilhando dourado, uma humana estica suas mãos e libera o fogo dracônico que queima em suas veias. À medida que um inferno consome seus oponentes, asas de couro surgem nas suas costas e ela ergue-se ao ar.',
      'Os longos cabelos balançam com a conjuração do vento, um meio elfo abre seus braços totalmente e joga a cabeça para trás. Erguendo-o momentaneamente do chão, uma onda de magia surge sobre ele, por meio dele e, fora dele, uma poderosa explosão de relâmpago. Esgueirando-se atrás de uma estalagmite, uma halfling aponta seu dedo em um troglodita em investida. Uma explosão de chamas é liberada através do seu dedo e atinge a criatura. Ela toma cobertura atrás da formação rochosa com um sorriso, sem saber que sua magia selvagem deixou sua pele com um brilho azulado.',
      'Os feiticeiros carregam um patrimônio mágico conferido a eles por uma linhagem exótica, alguma influência de outro mundo ou exposição a forças cósmicas desconhecidas. Não é possível estudar feitiçaria como se aprende um idioma, assim como não se aprende a viver uma vida lendária. Ninguém escolhe a feitiçaria: os poderes escolhem o feiticeiro.',
    ],
  },
  {
    titulo: 'Magia Bruta',
    paragrafos: [
      'A magia é parte de todo feiticeiro, inundando corpo, mente e espírito com um poder latente que espera para ser dominado. Alguns feiticeiros carregam magia que emerge de uma antiga linhagem infundida com a magia dos dragões. Outros carregam uma magia bruta, incontrolável dentro de si, uma tormenta caótica que se manifesta de formas inexplicáveis. A aparência dos poderes de feitiçaria são vastamente imprevisíveis. Algumas linhagens dracônicas produzem apenas um feiticeiro por geração, porém, em outras linhas de descendência, todos os indivíduos serão feiticeiros. A maior parte do tempo, os talentos de feitiçaria aparecem aparentemente ao acaso. Alguns feiticeiros não conseguem determinar a origem do seu poder, enquanto outros o relacionam com estranhos eventos de suas vidas. O toque de um corruptor, a bênção de uma dríade no nascimento de um bebê ou experimentar a água de uma fonte misteriosa podem conceder o dom da feitiçaria. Também é possível adquirir esse dom de uma divindade da magia, da exposição às forças elementais dos Planos Interiores ou do caos alucinante do Limbo ou ao vislumbrar o funcionamento interno da realidade.',
      'Ao aprender a explorar e canalizar sua própria magia inata, eles descobrem novas e incríveis formas de liberar esse poder.',
    ],
  },
  {
    titulo: 'Poderes Inexplicáveis',
    paragrafos: [
      'Os feiticeiros são raros no mundo e é incomum encontrar um feiticeiro que não esteja envolvido na vida de aventuras de alguma forma. Pessoas com poder mágico fluindo em suas veias descobrem cedo que o poder não gosta de ficar quieto. A magia de um feiticeiro gosta de ser exercida e tem uma tendência de fluir de maneiras imprevisíveis se não for chamada. Muitas vezes, os feiticeiros têm motivações obscuras ou quixotescas que os levam a aventuras. Alguns buscam uma maior compreensão da força mágica que os infunde ou a resposta do mistério de sua origem. Outros esperam encontrar uma forma de se livrar dele ou de liberar seu potencial máximo.',
    ],
  },
];

const vida = {
  prefixo: 'd',
  numero: '6',
  nivel1: '6 + seu bônus de Salvaguarda de Constituição + 1',
  niveisSuperiores: '6 + seu bônus de Salvaguarda de Constituição por nível de feiticeiro após o 1°',
};

const proficiencias = [
  { titulo: 'Testes de Resistência', itens: ['Constituição', 'Carisma'], estilo: 'selos', icone: markRaw(IconeResistencia) },
  {
    titulo: 'Perícias',
    nota: 'escolha duas',
    itens: ['Arcana', 'Enganação', 'Intuição', 'Intimidação', 'Persuasão', 'Religião'],
    icone: markRaw(IconePericias),
  },
];

const proficienciasEquipamento = [
  { titulo: 'Armadura', itens: ['Nenhuma'] },
  { titulo: 'Armas', itens: ['Adaga', 'Bordão'] },
  { titulo: 'Ferramentas', itens: ['Nenhuma'] },
];

const equipamento = {
  intro: 'Você começa com o seguinte equipamento, além do equipamento concedido pelo seu antecedente:',
  itens: [
    { opcoes: ['Um bordão', 'Duas adagas'] },
    { opcoes: ['Foco arcano (cristal)', 'Mochila de aventureiro'] },
    { opcoes: ['28 PE'] },
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
  { nivel: 1, truquesConhecidos: 2, magiasConhecidas: 2, nivelDeMagia: '1º', pontosDeMagia: 6, caracteristicas: 'Conjurando com Pontos de Magia, Origem de Feitiçaria, Talento' },
  { nivel: 2, truquesConhecidos: 2, magiasConhecidas: 3, nivelDeMagia: '1º', pontosDeMagia: 9, caracteristicas: '-' },
  { nivel: 3, truquesConhecidos: 2, magiasConhecidas: 4, nivelDeMagia: '2º', pontosDeMagia: 24, caracteristicas: 'Metamágica' },
  { nivel: 4, truquesConhecidos: 2, magiasConhecidas: 5, nivelDeMagia: '2º', pontosDeMagia: 30, caracteristicas: '-' },
  { nivel: 5, truquesConhecidos: 3, magiasConhecidas: 6, nivelDeMagia: '3º', pontosDeMagia: 40, caracteristicas: 'Maestria Arcana, Talento' },
  { nivel: 6, truquesConhecidos: 3, magiasConhecidas: 7, nivelDeMagia: '3º', pontosDeMagia: 51, caracteristicas: 'Origem de Feitiçaria' },
  { nivel: 7, truquesConhecidos: 3, magiasConhecidas: 8, nivelDeMagia: '4º', pontosDeMagia: 66, caracteristicas: '-' },
  { nivel: 8, truquesConhecidos: 3, magiasConhecidas: 9, nivelDeMagia: '4º', pontosDeMagia: 81, caracteristicas: '-' },
  { nivel: 9, truquesConhecidos: 4, magiasConhecidas: 10, nivelDeMagia: '5º', pontosDeMagia: 117, caracteristicas: '-' },
  { nivel: 10, truquesConhecidos: 4, magiasConhecidas: 11, nivelDeMagia: '5º', pontosDeMagia: 138, caracteristicas: 'Talento' },
  { nivel: 11, truquesConhecidos: 4, magiasConhecidas: 12, nivelDeMagia: '5º', pontosDeMagia: 150, caracteristicas: 'Arcano Supremo' },
  { nivel: 12, truquesConhecidos: 4, magiasConhecidas: 13, nivelDeMagia: '5º', pontosDeMagia: 150, caracteristicas: '-' },
  { nivel: 13, truquesConhecidos: 5, magiasConhecidas: 15, nivelDeMagia: '5º', pontosDeMagia: 175, caracteristicas: 'Arcano Supremo' },
  { nivel: 14, truquesConhecidos: 5, magiasConhecidas: 17, nivelDeMagia: '5º', pontosDeMagia: 175, caracteristicas: 'Origem de Feitiçaria' },
  { nivel: 15, truquesConhecidos: 5, magiasConhecidas: 19, nivelDeMagia: '5º', pontosDeMagia: 200, caracteristicas: 'Arcano Supremo, Talento' },
  { nivel: 16, truquesConhecidos: 5, magiasConhecidas: 21, nivelDeMagia: '5º', pontosDeMagia: 200, caracteristicas: '-' },
  { nivel: 17, truquesConhecidos: 6, magiasConhecidas: 23, nivelDeMagia: '5º', pontosDeMagia: 225, caracteristicas: 'Arcano Supremo' },
  { nivel: 18, truquesConhecidos: 6, magiasConhecidas: 25, nivelDeMagia: '5º', pontosDeMagia: 225, caracteristicas: 'Origem de Feitiçaria' },
  { nivel: 19, truquesConhecidos: 6, magiasConhecidas: 27, nivelDeMagia: '5º', pontosDeMagia: 250, caracteristicas: 'Lendário' },
  { nivel: 20, truquesConhecidos: 7, magiasConhecidas: 30, nivelDeMagia: '6º', pontosDeMagia: 250, caracteristicas: 'Restauração Mística, Talento' },
];

const conjuracaoTipo = 'Conjurador Completo';

const conjuracaoTexto =
  'Você conhece duas magias de 1° nível, à sua escolha, da lista de magias de feiticeiro. A coluna Magias Conhecidas na tabela O Feiticeiro mostra quando você aprende magias adicionais de feiticeiro, sempre de um nível ao qual você tenha acesso. Além disso, quando você adquire um nível nessa classe, você pode escolher uma magia de feiticeiro que conhece e substituí-la por outra magia da lista de magias de feiticeiro, que também deve ser de um nível ao qual você tenha acesso. Você também pode conjurar qualquer magia de feiticeiro que conheça como um ritual, se ela possuir o descritor ritual, e usar um foco arcano como foco de conjuração das suas magias de feiticeiro.';

const tiposDeMagia = ['Natural', 'Divina', 'Arcana'];
const tipoMagiaFeiticeiro = 'Arcana';

const fonteMagia =
  'O Feiticeiro extrai sua magia de um evento em seu passado ou na vida de um parente ou ancestral, que deixou uma marca indelével nele, infundindo-o com magia arcana bruta.';

const atributoConjuracao = {
  nome: 'Carisma',
  bonus: ['Carisma', 'Proficiência'],
  cd: ['8', 'Proficiência', 'Carisma'],
  nota: 'Os valores de Carisma e Proficiência usados são os bônus respectivos.',
};

const caracteristicas = [
  {
    nivel: 1,
    titulo: 'Conjurando com Pontos de Magia',
    corpo: 'Você possui 4 pontos de magia. À medida que avança de nível nesta classe, você recebe mais pontos como mostrado na coluna Pontos de Magia da tabela O Feiticeiro. Esses pontos são usados para conjurar magias e ativar suas habilidades de classe. Cada magia possui um custo de pontos de acordo com seu nível. Se você tiver pontos suficientes para conjurá-la, pode gastar os pontos necessários e subtrair o valor correspondente de sua reserva.',
    tabela: {
      colunaA: 'Nível de Magia',
      colunaB: 'Custo por Ponto de Magia',
      linhas: [
        { a: '1º', b: '2' },
        { a: '2º', b: '4' },
        { a: '3º', b: '7' },
        { a: '4º', b: '10' },
        { a: '5º', b: '14' },
        { a: '6º', b: '25' },
      ],
    },
    notaFinal: 'Além disso, algumas habilidades também consomem pontos de magia. Por exemplo, a magia Mísseis Mágicos possui um custo de 2 pontos. Se você conjurá-la juntamente com o efeito de Metamagia Magia Acelerada, precisará gastar 3 pontos ao invés de 2, conforme descrito na habilidade. Você recupera todos os seus pontos de magia ao final de um <span class="dc-termo">descanso longo</span>.',
  },
  {
    nivel: 3,
    titulo: 'Metamágica',
    corpo: 'No 3° nível, você adquire a habilidade de distorcer suas magias para se adequarem às suas necessidades. Você ganha duas das seguintes opções de Metamagia, à sua escolha. Você adquire outra no 10° e 17° nível. Você não pode utilizar o mesmo efeito de Metamagia duas vezes na mesma magia, a menos que ela diga o contrário.',
    tabela: {
      colunaA: 'Opção',
      colunaB: 'Efeito',
      linhas: [
        { a: 'Magia Acelerada', b: 'Quando você conjurar uma magia que tenha um tempo de conjuração de 1 <span class="dc-termo">ação</span>, você pode gastar uma quantidade de Pontos de Magia igual ao nível da magia para mudar o tempo de conjuração para 1 <span class="dc-termo">ação bônus</span> para essa magia (1 ponto de feitiçaria se a magia for um truque).' },
        { a: 'Magia Aumentada', b: 'Quando você conjurar uma magia que obriga uma criatura a realizar um teste de resistência contra o seu efeito, você pode gastar 3 Pontos de Magia para dar <span class="dc-termo">desvantagem</span> a um alvo da magia no primeiro teste de resistência feito contra ela. Você pode usar Magia Aumentada mesmo que você já tenha usado essa opção de Metamagia durante a conjuração da magia.' },
        { a: 'Magia Cuidadosa', b: 'Quando você conjurar uma magia que obriga outras criaturas a realizarem um teste de resistência, você pode proteger algumas dessas criaturas da força total da magia. Para tanto, você pode gastar uma quantidade de Pontos de Magia igual ao nível da magia (1 ponto de feitiçaria se a magia for um truque) e escolher um número dessas criaturas até o seu modificador de <span class="dc-termo">Carisma</span> (mínimo de uma criatura). Uma criatura escolhida sofre metade do dano se falhar e nenhum dano se passar no teste da magia.' },
        { a: 'Magia Distante', b: 'Quando você conjurar uma magia que tenha distância de 1,5 metro ou maior, você pode gastar Pontos de Magia para aumentar o alcance da magia em 9 metros a cada ponto gasto. Quando você conjurar uma magia com alcance de toque, você pode gastar 1 ponto de feitiçaria para mudar o alcance da magia para 9 metros.' },
        { a: 'Magia Duplicada', b: 'Quando você conjurar uma magia que seja incapaz de ter mais de uma criatura como alvo no nível atual dela e não possua alcance pessoal, você pode gastar um número de Pontos de Magia igual ao nível da magia para ter uma segunda criatura, no alcance da magia, como alvo (1 ponto de feitiçaria se a magia for um truque).' },
        { a: 'Magia Estendida', b: 'Quando você conjurar uma magia que tenha duração de 1 minuto ou maior, você pode gastar 1 ponto de feitiçaria para dobrar sua duração, até uma duração máxima de 24 horas.' },
        { a: 'Magia Maximizada', b: 'Quando você rola dano para uma magia de duração instantânea, você pode gastar um número de Pontos de Magia igual ao nível da magia +1 para causar dano máximo a um alvo da magia.' },
        { a: 'Magia Potencializada', b: 'Quando você rola o dano de uma magia que você esteja se concentrando, você pode gastar 1 ponto de feitiçaria para jogar novamente os dados de dano da magia, podendo escolher qual rolagem usar. Você pode usar Magia Potencializada mesmo que você já tenha usado essa opção de Metamagia durante a conjuração da magia.' },
        { a: 'Magia Sutil', b: 'Quando você conjurar uma magia, você pode gastar 1 ponto de feitiçaria para fazê-lo sem qualquer componente somático ou verbal.' },
        { a: 'Magia Transmutada', b: 'Quando você conjurar uma magia que requer um teste de resistência, você pode gastar uma quantidade de Pontos de Magia igual ao nível da magia, para alterar o teste de resistência necessário. A mudança só pode ser entre <span class="dc-termo">Inteligência</span>, <span class="dc-termo">Sabedoria</span> ou <span class="dc-termo">Carisma</span>, ou entre <span class="dc-termo">Força</span>, <span class="dc-termo">Destreza</span> e <span class="dc-termo">Constituição</span>. Você pode usar Magia Transmutada mesmo que você já tenha usado essa opção de Metamagia durante a conjuração da magia.' },
      ],
    },
  },
  {
    nivel: 5,
    titulo: 'Maestria Arcana',
    corpo: 'A partir do 5° nível, você desenvolve uma conexão única com uma magia específica, aprimorando sua conjuração de maneira inata. Escolha uma magia de 1° nível que você conheça: essa magia agora possui permanentemente um efeito de metamagia que você conhece, o custo desse efeito é aumentado em 1 ponto de feitiçaria, independentemente do custo normal da Metamagia. Você pode aplicar outros efeitos de Metamagia à magia normalmente, pagando seus custos habituais. No 9° nível, escolha mais uma magia de até 2° nível. No 11° nível, escolha mais uma magia de até 3° nível.\nAs magias escolhidas por essa característica são permanentes e não podem ser trocadas ao subir de nível. Se você aprender novas opções de Metamagia, poderá aplicá-las normalmente às suas Magias Favoritas ao conjurá-las.',
  },
  {
    nivel: 11,
    titulo: 'Arcano Supremo',
    corpo: 'A partir do 11° nível, você obtém acesso a magias de imenso poder, transcendendo os limites comuns de um feiticeiro. Você aprende uma magia de 6° nível da lista de magias de Feiticeiro. Você pode conjurar essa magia uma vez, sem gastar Pontos de Magia, e recupera a capacidade de usá-la ao finalizar um <span class="dc-termo">descanso longo</span>. Para efeitos de Metamagia, essa magia é considerada como tendo um custo fixo de 20 Pontos de Magia.\nNo 13° nível, você aprende uma magia de 7° nível da lista de magias de Feiticeiro. No 15° nível, você aprende uma magia de 8° nível, e no 17° nível, você aprende uma magia de 9° nível. Cada uma dessas magias segue as mesmas regras da magia adquirida ao 11° nível.\nAs magias escolhidas por essa característica são permanentes e não podem ser substituídas ao subir de nível.',
  },
  {
    nivel: 19,
    titulo: 'Lendário',
    corpo: 'Ao atingir o 19°, você pode escolher um <span class="dc-termo">talento</span> épico.',
  },
  {
    nivel: 20,
    titulo: 'Restauração Mística',
    corpo: 'No 20° nível, você recupera 40 Pontos de Magia gastos sempre que você terminar um <span class="dc-termo">descanso curto</span>.\nAlém disso, seu controle sobre a funcionalidade do arcano se torna gigantesco. Sempre que você soltar uma magia, você pode aplicar 2 efeitos de Metamagia ao mesmo tempo ao custo de apenas uma.',
  },
];

const subclasses = [
  {
    nome: 'Feiticeiro Aberrante',
    icone: '🧠',
    introTexto: 'Como Feiticeiro da Mente Aberrante, você decide como adquiriu seus poderes. Você nasceu com eles? Ou um evento posterior na vida deixou você brilhando com consciência psíquica? Como Feiticeiro da Mente Aberrante, sua mente foi envolvida por uma influência alienígena, concedendo-lhe poderes psíquicos. Você agora pode tocar outras mentes com esse poder e alterar o mundo ao seu redor, controlando a energia mágica do multiverso. Essa energia emanará de você como um farol de esperança para outros? Ou será uma fonte de terror para aqueles que sentirem o golpe da sua mente e testemunharem as estranhas manifestações do seu poder?',
    magias: [
      { nivel: '1º', magia: 'Detectar Magia, Sussurros Dissonantes' },
      { nivel: '3º', magia: 'Coroa da Loucura, Acalmar Emoções' },
      { nivel: '5º', magia: 'Dissipar Magia, Padrão Hipnótico' },
      { nivel: '7º', magia: 'Confusão, Raulothim\'s Psychic Lance' },
      { nivel: '9º', magia: 'Ligação Telepática de Rary, Modificar Memória' },
    ],
    caracteristicas: [
      {
        nivel: 1,
        titulo: 'Fala Telepática',
        corpo: 'A partir do 1° nível, você pode formar uma conexão telepática entre sua mente e a de outra pessoa. Como <span class="dc-termo">ação bônus</span>, escolha uma criatura que você possa ver a até uma quantidade de metros igual a (4,5 x o seu nível) de você. Você e a criatura escolhida podem falar telepaticamente um com o outro enquanto estiverem a uma distância em milhas igual à metade do seu nível. Para se entenderem, cada um deve falar mentalmente em um idioma que o outro conheça. Além disso, qualquer teste de Enganação feito pela criatura ligada pela sua fala Telepática contra você será feito com <span class="dc-termo">desvantagem</span>. A conexão telepática termina se você estiver incapacitado, morrer ou usar essa habilidade para se conectar com uma criatura diferente.',
      },
      {
        nivel: 1,
        titulo: 'Natureza Extraplanar',
        corpo: 'No 1° nível, você ganha proficiência em Intimidação se ainda não a tiver, caso contrário você dobra seu bônus de proficiência. Você também ganha o truque Mind Sliver. Isso não conta para os truques conhecidos em sua lista de magias de feiticeiro. Você é considerado uma aberração com o propósito de determinar efeitos de feitiços e pode acabar atraindo atenção indesejada na sociedade civilizada.',
      },
      {
        nivel: 6,
        titulo: 'Revelação na Carne',
        corpo: `Começando no 6° nível, você pode liberar a verdade aberrante escondida dentro de você. Como <span class="dc-termo">ação bônus</span>, você pode gastar 5 Pontos de Magia para magicamente transformar seu corpo por 10 minutos. Seu corpo se transforma em sua verdadeira forma recebendo os seguintes benefícios:
<ul><li>Você pode ver qualquer criatura invisível a até 18 metros de você, desde que não esteja atrás de cobertura total.</li><li>Você causa um dano psíquico extra igual ao seu nível de feiticeiro sempre que causar dano a uma criatura afetada pela sua <span class="dc-termo">Fala Telepática</span>. Uma criatura só pode sofrer esse dano uma vez por turno.</li><li>Você ganha uma velocidade de voo igual à sua velocidade de caminhada e pode planar.</li><li>Você ganha uma velocidade de natação igual a duas vezes sua velocidade de caminhada e pode respirar debaixo d'água.</li><li>Você pode se mover por espaços tão estreitos quanto 2,5 centímetros sem precisar se espremer, e pode gastar 1,5 metro de movimento para escapar de restrições não mágicas ou de estar agarrado.</li></ul>`,
      },
      {
        nivel: 6,
        titulo: 'Molestador Mental',
        corpo: 'A partir do 6°, seu poder mental cresceu ao ponto de poder sobrepujar as defesas psíquicas de outras criaturas. Você pode assediar a mente de uma criatura e analisar seus pensamentos, memórias e mais profundos desejos. Você ganha resistência a dano psíquico e sua <span class="dc-termo">Fala Telepática</span> agora também é capaz de replicar os efeitos da magia Detectar Pensamentos.',
      },
      {
        nivel: 14,
        titulo: 'Resistência Alienígena',
        corpo: 'A partir do 14° nível, você ganha imunidade a dano psíquico e possui um bônus em suas jogadas de teste de Resistência igual a 1d4.',
      },
      {
        nivel: 14,
        titulo: 'Liberdade Aberrante',
        corpo: `A partir do 14° nível, sua revelação da carne se torna um libertador de seu poder alienígena. Enquanto transformado você recebe os seguintes benefícios:
<ul><li>Você pode formar uma ligação de sua <span class="dc-termo">Fala Telepática</span> com um número ilimitado de criaturas no alcance.</li><li>Criaturas afetadas por sua <span class="dc-termo">Fala Telepática</span> possuem uma penalidade em seus testes de concentração igual ao seu modificador de <span class="dc-termo">Carisma</span>.</li></ul>`,
      },
      {
        nivel: 18,
        titulo: 'Perturbação Mental',
        corpo: 'No 18° nível, você pode liberar seu poder aberrante como uma anomalia de ondas cerebrais. Quando uma criatura que estiver sobre sua ligação telepática estiver prestes a conjurar uma magia, realizar um ataque ou utilizar uma habilidade, você pode utilizar sua reação para assaltar a mente dela com seu poder psíquico.\nA criatura deve ser bem sucedida em um teste de resistência de <span class="dc-termo">Inteligência</span> de CD igual ao seu CD de magia ou será impedida de realizar a ação que desencadeou a habilidade e perderá a ação. Se uma criatura falhar por 10 ou mais em seu teste, ela também ficará atordoada até o final do turno dela.',
      },
    ],
  },
  {
    nome: 'Feiticeiro da Calamidade',
    icone: '💥',
    introTexto: 'Quando ocorrem cataclismos, sejam eles mágicos, artificiais ou naturais, uma enorme quantidade de energia é consumida e gasta, geralmente de forma devastadora e espetacular demonstração de poder destrutivo. Ocasionalmente, algumas dessas energias destrutivas corre mal e é armazenada, ou presa, dentro de um indivíduo. Feiticeiros Calamitosos ganham influência sobre os poderes destrutivos que impactaram sua origem, e é conhecido por causar estragos e destruição. Seja qual for as circunstâncias da origem, esses feiticeiros carregam consequências deste evento calamitoso com eles, tendo moldado fundamentalmente quem eles se tornaram.',
    caracteristicas: [
      {
        nivel: 1,
        titulo: 'Magia de Calamidade',
        corpo: `Você sofreu uma origem cataclísmica que o marcou para sempre. Após esse evento, descobriu-se o controle de um poder devastador: os Feitiços Calamitosos. Esses feitiços incluem quaisquer magias de Feiticeiro de Nível 1 ou superior que causem dano direto a uma ou mais criaturas e tenham duração "Instantânea".
<ul><li><strong>Preparações Gratuitas.</strong> Escolha dois Feitiços Calamitosos de um nível que você possa preparar. Esses feitiços estarão sempre preparados para você. Além disso, você pode escolher o feitiço calamitoso adicional nos níveis 5°, 7° e 9° desta classe. Sempre que ganhar um nível como Feiticeiro, você pode substituir um de seus feitiços calamitosos escolhidos por outro elegível.</li><li><strong>Tipo de Dano Calamitoso.</strong> Escolha um tipo de dano entre: Ácido, Frio, Fogo, Raio, Necrótico, Veneno ou Trovão. Sempre que lançar um Feitiço Calamitoso, você pode alterar o tipo de dano do feitiço para o tipo escolhido.</li><li><strong>Explosão Calamitosa.</strong> Você domina a devastação de suas magias, canalizando o poder destrutivo de sua origem. Qualquer Feitiço Calamitoso lançado por você, que cause dano do tipo calamitoso escolhido, tem seu impacto amplificado. Sempre que você lançar um Feitiço Calamitoso e causar o valor máximo em qualquer dado de dano da magia, você pode rolar um dado adicional do mesmo tipo e somá-lo ao total de dano causado. Esse efeito pode ocorrer apenas uma vez por rolagem.</li></ul>`,
      },
      {
        nivel: 6,
        titulo: 'Aura de Catástrofe',
        corpo: 'A partir do 6° nível, a devastação de seus Feitiços Calamitosos provoca um horror instintivo em todos que testemunham seu poder. Sempre que uma criatura sofrer dano pela primeira vez de um Feitiço Calamitoso lançado por você, ela deve realizar um teste de resistência de <span class="dc-termo">Sabedoria</span> contra a sua CD de Magia. Em uma falha no teste a criatura fica Assustada por 1 minuto. Enquanto estiver assustada dessa forma, a criatura pode repetir o teste de resistência no final de cada um dos turnos dela, encerrando o efeito em caso de sucesso.\nSe uma criatura morrer como resultado do dano de um Feitiço Calamitoso lançado por você, todas as criaturas a até 9 metros do local da morte devem fazer um novo teste de resistência de <span class="dc-termo">Sabedoria</span> contra a sua CD de Magia, desta vez com <span class="dc-termo">desvantagem</span>. Em caso de falha, elas ficam Assustadas pelo restante da duração original.',
      },
      {
        nivel: 14,
        titulo: 'Terror Devastador',
        corpo: 'Seu domínio sobre o medo e a destruição amplifica o sofrimento daqueles que sucumbem ao terror que você provoca. A partir do 14° nível, suas magias se tornam ainda mais letais contra criaturas aterrorizadas. Sempre que uma criatura Assustada sofrer dano de um Feitiço Calamitoso lançado por você, ela sofre dano extra igual ao seu nível de Feiticeiro. O dano extra é do mesmo tipo que o dano principal da magia.',
      },
      {
        nivel: 18,
        titulo: 'Avatar da Calamidade',
        corpo: `No auge de seu poder, você se torna a própria personificação da destruição cataclísmica. A partir do 18° nível, suas magias calamitosas alcançam um novo patamar de devastação, concedendo a você os seguintes benefícios:
<ul><li><strong>Imunidade à Destruição.</strong> Você se torna completamente imune a qualquer dano causado por suas magias calamitosas, refletindo seu domínio absoluto sobre essas energias destrutivas.</li><li><strong>Poder Expandido.</strong> As áreas de efeito de suas magias calamitosas dobram de tamanho em todas as dimensões. Para magias com alvos específicos, o alcance delas é dobrado.</li><li><strong>Fardo do Terror.</strong> Sempre que uma criatura sofrer dano de um Feitiço Calamitoso lançado por você, ela recebe uma penalidade de 1d4 em sua próxima jogada de d20.</li></ul>`,
      },
    ],
  },
  {
    nome: 'Feiticeiro do Caos',
    icone: '🎲',
    introTexto: 'Sua magia inata vem das forças selvagens do caos que subjazem à ordem da criação. Você pode ter suportado exposição a alguma forma de magia crua, talvez através de um portal planar que leva ao Limbo, aos Planos Elementais ou ao misterioso Plano Astral. Talvez você tenha sido abençoado por uma poderosa criatura feérica ou marcado por um demônio. Ou sua magia pode ser uma anomalia do seu nascimento, sem causa ou razão aparente. De qualquer forma que tenha surgido, essa magia caótica borbulha dentro de você, aguardando por uma saída.',
    caracteristicas: [
      {
        nivel: 1,
        titulo: 'Surto de Magia Selvagem',
        corpo: 'Ao escolher essa origem no 1° nível, sua conjuração pode liberar surtos de magia indomável. Uma vez por turno, você rola um d20 imediatamente após conjurar uma magia de feiticeiro de 1° nível ou superior. Se rolar 1, consulte a tabela de Surto de Magia Selvagem para criar um efeito mágico. Se o efeito for uma magia, será muito selvagem para ser afetado por sua Metamagia. Caso a magia normalmente exija concentração, não exigirá nesta situação; a magia dura a duração completa.',
        tabela: {
          colunaA: 'D100',
          colunaB: 'Efeito',
          linhas: [
            { a: '01', b: 'Role nesta tabela no início de cada um dos seus turnos durante o próximo minuto, ignorando este resultado em rolagens subsequentes.' },
            { a: '02', b: 'Durante o próximo minuto, você pode ver qualquer criatura invisível se tiver linha de visão para ela.' },
            { a: '03', b: 'Um modron escolhido e controlado pelo Mestre aparece em um espaço desocupado dentro de 1,5 metro de você, depois desaparece após 1 minuto.' },
            { a: '04', b: 'Você conjura Bola de Fogo como um feitiço de 3° nível centrado em si mesmo.' },
            { a: '05', b: 'Você conjura Míssil Mágico como um feitiço de 5° nível.' },
            { a: '06', b: 'Role um d10. Sua altura muda por um número de centímetros igual ao resultado. Se for ímpar, você encolhe. Se for par, você cresce.' },
            { a: '07', b: 'Você conjura Confusão centrada em si mesmo.' },
            { a: '08', b: 'Durante o próximo minuto, você recupera 5 pontos de vida no início de cada um dos seus turnos.' },
            { a: '09', b: 'Você cresce uma longa barba feita de penas que permanece até você espirrar, momento em que as penas explodem do seu rosto.' },
            { a: '10', b: 'Você conjura Escorregadio centrado em si mesmo.' },
            { a: '11', b: 'Criaturas têm <span class="dc-termo">desvantagem</span> em testes de resistência contra o próximo feitiço que você conjurar no próximo minuto que envolva um teste de resistência.' },
            { a: '12', b: 'Sua pele se torna uma tonalidade vibrante de azul. Um feitiço Remover Maldição pode encerrar esse efeito.' },
            { a: '13', b: 'Um olho aparece na sua testa durante o próximo minuto. Durante esse tempo, você tem <span class="dc-termo">vantagem</span> em testes de <span class="dc-termo">Sabedoria</span> (Percepção) que dependam da visão.' },
            { a: '14', b: 'Durante o próximo minuto, todos os seus feitiços com tempo de conjuração de 1 <span class="dc-termo">ação</span> têm um tempo de conjuração de 1 <span class="dc-termo">ação bônus</span>.' },
            { a: '15', b: 'Você se teleporta até 18 metros para um espaço desocupado de sua escolha que você possa ver.' },
            { a: '16', b: 'Você é transportado para o Plano Astral até o final do seu próximo turno, após o qual você retorna ao espaço que ocupava anteriormente ou ao espaço desocupado mais próximo se estiver ocupado.' },
            { a: '17', b: 'Maximiza o dano do próximo feitiço de dano que você conjurar durante o próximo minuto.' },
            { a: '18', b: 'Role um d10. Sua idade muda por um número de anos igual ao resultado. Se for ímpar, você fica mais jovem (mínimo 1 ano). Se for par, você fica mais velho.' },
            { a: '19', b: '1d6 flumphs controlados pelo Mestre aparecem em espaços desocupados dentro de 18 metros de você e têm medo de você. Eles desaparecem após 1 minuto.' },
            { a: '20', b: 'Você recupera 2d10 pontos de vida.' },
            { a: '21', b: 'Você conjura Esfera Flamejante centrada em si mesmo.' },
            { a: '22', b: 'Você se teleporta para até 6 metros para um espaço desocupado de sua escolha que possa ver.' },
            { a: '23', b: 'Você invoca um espectro do passado que assombra você pelos próximos 10 minutos. Ele é inofensivo, mas murmura verdades desconfortáveis.' },
            { a: '24', b: 'Você ganha resistência a todo dano pelo próximo minuto.' },
            { a: '25', b: 'Um brilho dourado emana de você em um raio de 9 metros pelo próximo minuto. Qualquer criatura que terminar seu turno nesse raio fica cegada até o final do próximo turno dela.' },
            { a: '26', b: 'Você conjura Espada Espiritual como um feitiço de 3° nível.' },
            { a: '27', b: 'Você conjura Teleporte de Curta Distância.' },
            { a: '28', b: 'Durante o próximo minuto, qualquer objeto não mágico que você segurar brilha como uma tocha.' },
            { a: '29', b: 'Você conjura Imagem Espelhada.' },
            { a: '30', b: 'Você conjura Moscas da Nuvem Fétida centrada em si mesmo.' },
            { a: '31', b: 'Durante o próximo minuto, você pode gastar sua <span class="dc-termo">ação</span> para emitir um raio de luz flamejante de suas mãos. A linha tem 9 metros de comprimento e 1,5 metro de largura e causa 4d6 de dano de fogo a cada criatura na área (<span class="dc-termo">Destreza</span> CD 15 reduz à metade).' },
            { a: '32', b: 'Você conjura Nuvem de Nevoeiro centrada em si mesmo.' },
            { a: '33', b: 'Durante o próximo minuto, você pode gastar sua <span class="dc-termo">ação</span> para se teletransportar para até 6 metros.' },
            { a: '34', b: 'Criaturas ao seu redor dentro de 3 metros sofrem 1d10 de dano de relâmpago.' },
            { a: '35', b: 'Você fica invisível por 1 minuto ou até atacar ou conjurar uma magia.' },
            { a: '36', b: 'Se você morrer nos próximos 10 minutos, você reaparece instantaneamente no último local seguro onde esteve nas últimas 24 horas.' },
            { a: '37', b: 'Uma entidade etérea aparece brevemente e lhe dá um conselho misterioso antes de desaparecer.' },
            { a: '38', b: 'Durante o próximo minuto, qualquer criatura que encostar em você sofre 1d6 de dano de eletricidade.' },
            { a: '39', b: 'Você conjura Onda Trovejante.' },
            { a: '40', b: 'Você cresce asas espectrais e ganha um deslocamento de voo de 9 metros pelo próximo minuto.' },
            { a: '41', b: 'Você conjura Metamorfose sobre si mesmo, transformando-se em uma criatura de ND 1 ou inferior por 1 hora.' },
            { a: '42', b: 'Durante o próximo minuto, sua pele brilha com um tom metálico, concedendo +2 na sua Classe de Armadura.' },
            { a: '43', b: 'Você se torna imune a dano psíquico e efeitos de encantamento e medo pelos próximos 10 minutos.' },
            { a: '44', b: 'Você conjura Tempestade de Gelo centrada em si mesmo.' },
            { a: '45', b: 'Você recupera todos os pontos de magia gastos.' },
            { a: '46', b: 'Você conjura Mãos Flamejantes como um feitiço de 3° nível.' },
            { a: '47', b: 'Você pode se mover pelo próximo minuto sem provocar ataques de oportunidade.' },
            { a: '48', b: 'Uma onda de magia selvagem faz com que todas as criaturas a até 9 metros de você troquem de posição aleatoriamente.' },
            { a: '49', b: 'Você conjura Rajada Mística como se fosse um bruxo de nível 5.' },
            { a: '50', b: 'Durante o próximo minuto, sempre que você for atingido por um ataque, uma explosão de energia mágica causa 1d6 de dano de força ao atacante.' },
            { a: '51', b: 'Você se torna incapaz de mentir pelos próximos 10 minutos.' },
            { a: '52', b: 'Você cresce garras afiadas que duram 1 minuto. Elas contam como armas naturais e causam 1d8 de dano cortante.' },
            { a: '53', b: 'Durante o próximo minuto, sua voz ecoa sobrenaturalmente, tornando qualquer mentira que você contar automaticamente detectável.' },
            { a: '54', b: 'Você conjura Muralha de Fogo como um feitiço de 4° nível.' },
            { a: '55', b: 'Você se teleporta 9 metros para um espaço desocupado à sua escolha.' },
            { a: '56', b: 'Durante o próximo minuto, qualquer criatura que tentar conjurar uma magia a até 3 metros de você deve fazer um teste de resistência de <span class="dc-termo">Constituição</span> (CD 15) ou falhar na conjuração.' },
            { a: '57', b: 'Você conjura Teleporte como um feitiço de 7° nível, mas o destino é aleatório.' },
            { a: '58', b: 'Sua pele se torna resistente, concedendo resistência a dano cortante, perfurante e contundente por 1 minuto.' },
            { a: '59', b: 'Você conjura Praga de Insetos centrada em si mesmo.' },
            { a: '60', b: 'Você recupera metade dos seus pontos de vida perdidos.' },
            { a: '61', b: 'Você encolhe, ficando Pequeno pelo próximo minuto. Suas armas e equipamentos diminuem proporcionalmente.' },
            { a: '62', b: 'Você cresce, tornando-se uma criatura Grande pelo próximo minuto. Suas armas e equipamentos aumentam proporcionalmente.' },
            { a: '63', b: 'Você conjura Medo como um feitiço de 3° nível.' },
            { a: '64', b: 'Você fica invisível por 1 minuto ou até atacar ou conjurar uma magia.' },
            { a: '65', b: 'Você invoca uma criatura aleatória de ND 2 que fica sob seu controle por 1 minuto.' },
            { a: '66', b: 'Você emite um pulso de energia que empurra todas as criaturas e objetos a até 3 metros de você 3 metros para trás.' },
            { a: '67', b: 'Você conjura Luz do Dia centrada em si mesmo.' },
            { a: '68', b: 'Você conjura Criar Alimentos e Água instantaneamente.' },
            { a: '69', b: 'Durante o próximo minuto, sua velocidade de movimento dobra.' },
            { a: '70', b: 'Você cresce um par de asas etéreas que permitem que você voe com deslocamento de 18 metros por 1 minuto.' },
            { a: '71', b: 'Você se teleporta para um plano aleatório por 1d4 rodadas antes de reaparecer no mesmo local.' },
            { a: '72', b: 'Você conjura Arma Espiritual na sua frente, com a forma de um símbolo aleatório.' },
            { a: '73', b: 'Você conjura Cone de Frio como um feitiço de 5° nível.' },
            { a: '74', b: 'Durante o próximo minuto, qualquer dano que você sofrer é reduzido pela metade.' },
            { a: '75', b: 'Você se torna vulnerável a dano de um tipo aleatório (exceto necrótico e psíquico) pelo próximo minuto.' },
            { a: '76', b: 'Você ganha resistência a um tipo de dano aleatório (exceto necrótico e psíquico) pelo próximo minuto.' },
            { a: '77', b: 'Você brilha intensamente em uma luz dourada por 1 minuto, iluminando até 9 metros ao seu redor.' },
            { a: '78', b: 'Você conjura Enxame de Meteoros como um feitiço de 9° nível, mas o alvo é determinado aleatoriamente.' },
            { a: '79', b: 'Você perde a capacidade de falar por 1 hora, mas pode se comunicar telepaticamente com qualquer criatura a até 9 metros.' },
            { a: '80', b: 'Você conjura Reviver Mortos em um cadáver aleatório a até 9 metros de você.' },
            { a: '81', b: 'Você fica incapaz de mentir por 1 hora.' },
            { a: '82', b: 'Você se teleporta para um espaço desocupado a até 18 metros de distância.' },
            { a: '83', b: 'Você conjura Névoa Obscurecente centrada em si mesmo.' },
            { a: '84', b: 'Você recebe 3d12 de vida temporária.' },
            { a: '85', b: 'Você sente uma fome insaciável e precisa comer algo dentro de 1 minuto ou ficará Envenenado por 1 hora.' },
            { a: '86', b: 'Você emite uma onda de choque sônica. Todas as criaturas a até 3 metros de você devem fazer um teste de resistência de <span class="dc-termo">Constituição</span> CD 15 ou ficar Surdas por 1 hora.' },
            { a: '87', b: 'Você conjura Raio Solar como um feitiço de 7° nível.' },
            { a: '88', b: 'Durante 1 minuto, você pode enxergar através de objetos sólidos como se fossem translúcidos.' },
            { a: '89', b: 'Você cria uma explosão de chamas ao seu redor. Todas as criaturas a até 3 metros de você devem fazer um teste de resistência de <span class="dc-termo">Destreza</span> CD 15 ou sofrer 4d6 de dano ígneo.' },
            { a: '90', b: 'Você se torna resistente a dano mágico por 1 minuto.' },
            { a: '91', b: 'Você conjura Forma Etérea em si mesmo por 1 minuto.' },
            { a: '92', b: 'Durante o próximo minuto, você vê todas as criaturas invisíveis a até 9 metros de você.' },
            { a: '93', b: 'Você perde a capacidade de enxergar cores por 1 hora.' },
            { a: '94', b: 'Você é envolto por uma barreira de força invisível por 1 minuto, tornando-se imune a ataques físicos.' },
            { a: '95', b: 'Você conjura Tempestade de Gelo como um feitiço de 4° nível.' },
            { a: '96', b: 'Você cresce garras afiadas e recebe um ataque desarmado que causa 2d6 de dano cortante por 1 minuto.' },
            { a: '97', b: 'Você conjura Mãos Flamejantes como um feitiço de 1° nível.' },
            { a: '98', b: 'Durante 1 minuto, você pode se mover através de objetos sólidos como se estivesse usando o feitiço Passagem Fantasmagórica.' },
            { a: '99', b: 'Você recupera todos os Pontos de Magia gastos.' },
            { a: '100', b: 'Você conjura Desejo imediatamente, sem custo, mas o efeito ocorre de maneira inesperada.' },
          ],
        },
      },
      {
        nivel: 1,
        titulo: 'Marés do Caos',
        corpo: 'A partir do 1° nível, você pode manipular as forças do acaso e do caos para obter <span class="dc-termo">vantagem</span> em um teste de ataque, habilidade ou resistência. Após usá-lo, é necessário completar um <span class="dc-termo">descanso longo</span> antes de poder usar esse recurso novamente. Antes de recuperar o uso desse recurso, você role na tabela de Surto de Magia Selvagem imediatamente após conjurar uma magia de feiticeiro de 1° nível ou superior. Então, você recupera o uso desse recurso.',
      },
      {
        nivel: 6,
        titulo: 'Torce Sorte',
        corpo: 'A partir do 6° nível, você tem a habilidade de torcer o destino usando sua magia selvagem. Quando outra criatura que você pode ver faz um teste de ataque, habilidade ou resistência, você pode usar sua reação e gastar 3 Pontos de Magia para rolar 1d4 e aplicar o número rolado como bônus ou penalidade (à sua escolha) no resultado do teste da criatura. Você pode fazer isso depois que a criatura rolar, mas antes de quaisquer efeitos do resultado acontecerem.',
      },
      {
        nivel: 14,
        titulo: 'Caos Controlado',
        corpo: 'Ao atingir o 14° nível, você ganha um mínimo de controle sobre os surtos de sua magia selvagem. Sempre que rolar na tabela de Surto de Magia Selvagem, você pode rolar duas vezes e usar qualquer um dos números.',
      },
      {
        nivel: 18,
        titulo: 'Bombardeio de Feitiços',
        corpo: 'A partir do 18° nível, a energia prejudicial de seus feitiços se intensifica. Você pode, com uma <span class="dc-termo">ação bônus</span>, gastar 4 Pontos de Magia para conjurar uma magia aleatória da sua lista de magia conhecidas. A magia é conjurada junto com a sua <span class="dc-termo">ação bônus</span>.',
      },
    ],
  },
  {
    nome: 'Feiticeiro Draconiano',
    icone: '🐉',
    introTexto: 'Sua magia inata vem da magia dracônica que se misturou ao seu sangue ou ao de seus ancestrais. Frequentemente, feiticeiros com essa origem traçam sua descendência até um poderoso feiticeiro de tempos antigos que fez um pacto com um dragão ou que pode até ter afirmado ter um dragão como progenitor. Algumas dessas linhagens sanguíneas são bem estabelecidas no mundo, mas a maioria é obscura. Qualquer feiticeiro pode ser o primeiro de uma nova linhagem, como resultado de um pacto ou outra circunstância excepcional.',
    caracteristicas: [
      {
        nivel: 1,
        titulo: 'Linhagem Dracônica',
        corpo: 'Ao 1° nível, você escolhe um tipo de dragão como seu ancestral. O tipo de dano associado a cada dragão é utilizado por características que você ganha mais tarde.',
        tabela: {
          colunaA: 'Dragão',
          colunaB: 'Dano / Deslocamento / Magia Associada',
          linhas: [
            { a: 'Negro', b: 'Dano Ácido · Deslocamento de natação · Magia: Flecha Ácida de Melf.' },
            { a: 'Azul', b: 'Dano de Relâmpago · Deslocamento de escalada · Magia: Repreensão Infernal (dano de raio).' },
            { a: 'Latão', b: 'Dano de Fogo · Deslocamento de escalada · Magia: Esquentar Metal.' },
            { a: 'Bronze', b: 'Dano de Relâmpago · Deslocamento de natação · Magia: Onda Trovejante (dano de raio).' },
            { a: 'Cobre', b: 'Dano Ácido · Deslocamento de escalada · Magia: Tasha\'s Caustic Brew.' },
            { a: 'Ouro', b: 'Dano de Fogo · Deslocamento de natação · Magia: Raio Ardente.' },
            { a: 'Verde', b: 'Dano de Veneno · Deslocamento de natação · Magia: Raio de Doença.' },
            { a: 'Vermelho', b: 'Dano de Fogo · Deslocamento de escalada · Magia: Queimadura de Aganazzar.' },
            { a: 'Prata', b: 'Dano de Gelo · Deslocamento de natação · Magia: Armadura de Agathys.' },
            { a: 'Branco', b: 'Dano de Gelo · Deslocamento de natação · Magia: Faca de Gelo.' },
            { a: 'Ametista', b: 'Dano de Força · Deslocamento de escavação · Magia: Arma Espiritual.' },
            { a: 'Cristal', b: 'Dano Radiante · Deslocamento de escalada · Magia: Raio Lunar.' },
            { a: 'Esmeralda', b: 'Dano Psíquico · Deslocamento de natação · Magia: Espinho Mental.' },
            { a: 'Safira', b: 'Dano de Trovão · Deslocamento de escalada · Magia: Despedaçar.' },
            { a: 'Topázio', b: 'Dano Necrótico · Deslocamento de escavação · Magia: Infligir Ferimentos.' },
          ],
        },
        notaFinal: 'Você pode falar, ler e escrever Dracônico. Você ganha a velocidade de movimento do tipo de dragão escolhido, igual à sua velocidade de caminhada. No 3° nível, você aprende o feitiço associado à sua linhagem, o qual não conta contra o número de feitiços conhecidos de feiticeiro. Esses Feitiços sempre são conjurados no maior nível possível que você conhece, mas você consumirá apenas 4 Pontos de Magia para conjurá-los.',
      },
      {
        nivel: 1,
        titulo: 'Resiliência Dracônica',
        corpo: 'À medida que a magia flui pelo seu corpo, ela faz com que características físicas de seus ancestrais dragões emerjam. Ao 1° nível, você recebe resistência ao tipo de dano de seu ancestral dracônico. Além disso, partes de sua pele são cobertas por uma fina camada de escamas parecidas com as de um dragão. Quando você não está usando armadura, sua CA é igual a 11 + seu modificador de <span class="dc-termo">Destreza</span> + modificador de <span class="dc-termo">Carisma</span>.',
      },
      {
        nivel: 6,
        titulo: 'Afinidade Dracônica',
        corpo: 'Ao alcançar o 6° nível, você aprende o feitiço associado à sua linhagem, o qual não conta contra o número de feitiços conhecidos de feiticeiro. Esses Feitiços sempre causam efeitos de como se tivessem sido conjurados um nível acima de sua conjuração.',
      },
      {
        nivel: 6,
        titulo: 'Ascensão Semi-perfeita',
        corpo: `No 6° nível você convoca o poder ancestral de seus antepassados dragões, manifestando uma forma semi-dracônica que exibe a força de seu legado. Ao ativar essa habilidade, você recebe os seguintes benefícios por 1 minuto:
<ul><li>Asas Dracônicas: Suas costas se expandem com poderosas asas de dragão, permitindo que você voe com uma velocidade igual à sua velocidade de caminhada. Você pode voar por uma quantidade de turnos igual ao seu nível de feiticeiro, ou até que sua concentração seja interrompida.</li><li>Aura Dracônica: Você recebe um bônus em suas jogadas de intimidação igual a 1d10.</li><li>Aumento de Dano Dracônico: As magias que causam dano do tipo associado à sua linhagem dracônica (como fogo, raio, ácido, etc.) agora causam dano adicional igual ao seu nível de feiticeiro. Esse bônus é aplicado a todas as magias de afinidade dracônica.</li><li>Poderes Aumentados: Suas magias que pedem uma jogada de ataque ou um teste de resistência que causam dano do seu tipo de dano da linha Dracônica, possuem um bônus em sua jogada ou teste de resistência igual à metade do seu bônus de proficiência arredondado para baixo.</li><li>Pontos de Vida Temporários: Você ganha pontos de vida temporários igual ao dobro do seu nível de feiticeiro. Esses pontos de vida temporários são perdidos no final da duração da habilidade ou se forem reduzidos a zero. Você recupera o uso dessa habilidade a cada <span class="dc-termo">descanso longo</span>.</li></ul>`,
      },
      {
        nivel: 14,
        titulo: 'Ascensão Perfeita',
        corpo: `No 14° nível, a conexão com seu sangue dramático alcançou seu ápice. O poder do dragão agora flui de maneira dominante em seu corpo, tornando-o resistente como um verdadeiro descendente de dragões. Você se torna imune ao tipo de dano associado ao seu ancestral dracônico. Sua magia se torna mais poderosa e imprevisível. Você ignora resistências ao tipo de dano da sua linhagem. Se uma criatura a até 18 metros de distância for imune a esse tipo de dano, você pode, como ação bônus, anular essa imunidade até o final de seu turno. Além disso, você agora a duração de sua forma é até você decidir desligá-la. Enquanto transformado você recebe os novos seguintes benefícios.
<ul><li>Regeneração. Você regenera 5 de vida no começo de cada um dos seus turnos se você possuir pelo menos 1 ponto de vida e seus pontos de vida estiverem abaixo da metade de seus pontos de vida máximos.</li><li>Magia Guiadora. Você adiciona seu bônus de <span class="dc-termo">Carisma</span> em seus testes de habilidade.</li><li>Agilidade Dracônica. A sua velocidade de movimento aumenta em 6 metros.</li></ul>
Para transformá-la novamente após desligá-la, será necessário gastar 25 Pontos de Magia.`,
      },
      {
        nivel: 18,
        titulo: 'Sangue do Dragão Eterno',
        corpo: `Ao 18° nível, a essência dracônica dentro de você atinge seu ápice, tornando-o imponente e praticamente indomável. Seu corpo é tão resistente quanto as escamas de um grande dragão, sua mente não pode ser dobrada, e sua presença inspira tanto temor quanto reverência. Você recebe os seguintes benefícios permanentes:
<ul><li>Resistência Dracônica Suprema. Você se torna imune a efeitos de medo e encantamento. Nenhuma criatura pode manipular sua mente ou subjugar sua vontade.</li><li>Olhar da Tirania. Como uma ação bônus, você pode fixar seu olhar em uma criatura a até 18 metros. Ela deve fazer um teste de resistência de <span class="dc-termo">Sabedoria</span> contra sua CD de magia. Em uma falha, ela fica amedrontada por 1 minuto e sofre <span class="dc-termo">desvantagem</span> em testes e ataques contra você. A criatura pode repetir o teste no final de cada turno para encerrar o efeito.</li><li>Escamas Anti-Magia. Você recebe resistência a dano mágico e imunidade a magias de 3° nível ou inferior, a menos que deseje ser afetado.</li><li>Resistência Lendária. Na primeira vez quando você falhar em um teste de resistência, você passa automaticamente no teste, você recupera essa habilidade a cada <span class="dc-termo">descanso longo</span>.</li></ul>`,
      },
    ],
  },
  {
    nome: 'Feiticeiro do Gênio',
    icone: '🧞',
    introTexto: 'Os feiticeiros dessa linhagem são abençoados pelo poder dos gênios elementais. Sua magia reflete a natureza grandiosa e volátil dessas criaturas, permitindo que manipulem os elementos de maneira única. Ao escolher essa origem, sua magia se alinha a um dos quatro tipos de gênios: Dao, Djinni, Efreeti ou Marid. Você pode alterar sua afinidade ao final de um descanso longo. Você recebe resistência ao tipo de dano associado ao seu gênio: veneno para Dao, trovão para Djinni, fogo para Efreeti e frio para Marid. Além disso, você pode conjurar cada uma das magias da Tabela de Magias do Gênio (Comum) sem gastar espaços de magia uma vez por descanso longo desde que esteja com a afinidade do gênio da magia. Essas magias não podem ser afetadas por Metamagia. Essas habilidades melhoram conforme seu bônus de proficiência, tornando-se ainda mais poderosas à medida que você cresce em nível.',
    caracteristicas: [
      {
        nivel: 1,
        titulo: 'Afinidade com o Gênio',
        corpo: 'No 1° nível, sua essência elemental modifica seu corpo e habilidades. Você pode gastar um ponto de feitiçaria como <span class="dc-termo">ação bônus</span> para alterar sua Afinidade Elemental para outra opção disponível.',
      },
      {
        nivel: 1,
        titulo: 'Magias de Gênio',
        corpo: 'Cada tipo de gênio concede um conjunto próprio de magias, que você pode conjurar uma vez por dia sem gastar Pontos de Magia enquanto tiver a afinidade correspondente.',
        tabela: {
          colunaA: 'Nível',
          colunaB: 'Comum / Dao / Djinni / Efreeti / Marid',
          linhas: [
            { a: '1º', b: 'Comum: Absorver Elementos · Dao: Tremor de Terra · Djinni: Queda Suave · Efreeti: Mãos Flamejantes · Marid: Névoa Obscurecente' },
            { a: '3º', b: 'Comum: Favor da Fortuna · Dao: Abraço Terrestre de Maximilian · Djinni: Despedaçar · Efreeti: Esquentar Metal · Marid: Passo Nebuloso' },
            { a: '5º', b: 'Comum: Piscar · Dao: Erupção de Terra · Djinni: Forma Gasosa · Efreeti: Bola de Fogo · Marid: Maremoto' },
            { a: '7º', b: 'Comum: Invocar Elemental · Dao: Pele de Pedra · Djinni: Invisibilidade Maior · Efreeti: Escudo de Fogo · Marid: Esfera Aquosa' },
            { a: '9º', b: 'Comum: Criação · Dao: Muralha de Pedra · Djinni: Controlar os Ventos · Efreeti: Coluna de Chamas · Marid: Cone de Frio' },
            { a: '17º', b: 'Comum: Desejo · Dao: — · Djinni: — · Efreeti: — · Marid: —' },
          ],
        },
      },
      {
        nivel: 6,
        titulo: 'Bênção Primordial',
        corpo: 'No 6° nível, você começa a receber um poder aprimorado conforme a afinidade do seu gênio. Dependendo da sua afinidade com um tipo de gênio, você ganha um dos seguintes benefícios:',
        tabela: {
          colunaA: 'Gênio',
          colunaB: 'Benefício',
          linhas: [
            { a: 'Dao', b: 'Sua Classe de Armadura aumenta em um valor igual ao seu bônus de proficiência.' },
            { a: 'Djinni', b: 'Sua velocidade de movimento aumenta em um valor igual a 1,5 vezes seu bônus de proficiência. Além disso, você pode usar sua ação bônus para Desengajar ou Esquivar.' },
            { a: 'Efreeti', b: 'Quando uma criatura atinge você com um ataque corpo a corpo, ela sofre dano de fogo igual ao seu bônus de proficiência.' },
            { a: 'Marid', b: 'Você ganha uma velocidade de natação igual à sua velocidade de movimento, e pode respirar debaixo d\'água sem sofrer penalidades.' },
          ],
        },
      },
      {
        nivel: 14,
        titulo: 'Gênio Todo-Poderoso',
        corpo: 'No 14° nível, você desperta o poder completo dos gênios e, por um breve período, adquire todas as habilidades desses seres elementais. Como <span class="dc-termo">ação bônus</span>, você pode entrar em um estado de transição elemental por 1 minuto. Durante esse tempo, você ganha todos os benefícios das magias da <span class="dc-termo">Bênção Primordial</span>. Além disso, você pode conjurar a magia Fabricar como uma <span class="dc-termo">ação</span>, sem a necessidade de materiais. Você pode usar essa habilidade uma vez por <span class="dc-termo">descanso longo</span>.',
      },
      {
        nivel: 18,
        titulo: 'Desejo Supremo',
        corpo: 'A partir do 18° nível, seu poder atinge seu auge, permitindo que você manifeste a vontade dos próprios gênios. Quando você conjurar a magia Desejo, pode fazer até três desejos diferentes ao invés de apenas um, contanto que sejam feitos dentro do mesmo lançamento da magia.\nAlém disso, sua conexão com a essência elemental se torna tão poderosa que você não pode perder a concentração em magias da Tabela de Magias do Gênio ao sofrer dano. Você ainda precisa se concentrar normalmente para mantê-las ativas, mas ataques e ferimentos não interrompem sua magia.',
      },
    ],
  },
  {
    nome: 'Feiticeiro de Sangue Feérico',
    icone: '🧚',
    introTexto: 'A magia do Reino das Fadas corre em suas veias, seja por um ancestral que se uniu a uma fada, um pacto selado antes do seu nascimento ou até mesmo um capricho de uma entidade feérica poderosa que decidiu abençoá-lo (ou amaldiçoá-lo) com seus dons. Sua magia reflete a imprevisibilidade e o encanto das fadas, permitindo-lhe manipular a sorte, a ilusão e o próprio tecido da realidade com um toque de travessura.',
    caracteristicas: [
      {
        nivel: 1,
        titulo: 'Magia Feérica',
        corpo: 'No 1° nível, você é envolvido pelo brilho e pela magia das fadas. Você aprende a língua Silvestre, e sua magia é acompanhada por efeitos sutis como brilho cintilante, risadas etéreas ou o aroma de flores. Além disso, quando lança uma magia de Encantamento ou Ilusão em uma criatura, ela não percebe que foi afetada por sua magia mesmo após o efeito acabar, a menos que uma testemunha revele ou a própria criatura tenha provas concretas da manipulação.',
      },
      {
        nivel: 6,
        titulo: 'Toque Confuso',
        corpo: 'No 6° nível, sua influência feérica desorienta aqueles que resistem aos seus encantos. Quando uma criatura passa no teste de resistência contra uma magia de Encantamento ou Ilusão que você lançou, ela fica confusa por um instante, hesitando em suas ações. Até o final de seu próximo turno, essa criatura tem <span class="dc-termo">desvantagem</span> na próxima jogada de ataque, teste de habilidade ou teste de resistência que realizar.',
      },
      {
        nivel: 6,
        titulo: 'Passos Feéricos',
        corpo: 'No 6° nível, você ganha a habilidade de se mover rapidamente pelo campo de batalha com a ajuda da magia feérica. Como uma <span class="dc-termo">ação bônus</span>, você pode se teletransportar até 12 metros para um ponto desocupado que você possa ver. Durante o processo de teletransporte, criaturas que estiverem a até 3 metros de você devem realizar um teste de <span class="dc-termo">Carisma</span> contra a sua CD de Magia. Se falharem, ficam atordoadas até o início do seu próximo turno.\nAlém disso, criaturas com um nível de desafio menor que a metade do seu nível de Feiticeiro caem no sono se falharem no teste de resistência. Elas permanecem adormecidas até o início do seu próximo turno, a menos que sejam despertadas por dano ou outro efeito.\nVocê pode usar essa habilidade um número de vezes igual ao seu bônus de proficiência, recuperando os usos após um <span class="dc-termo">descanso longo</span>.',
      },
      {
        nivel: 14,
        titulo: 'Forma Etérea',
        corpo: 'A partir do 14° nível, seu corpo começa a se fundir com a essência das fadas. Você se torna parcialmente etéreo, permitindo que sua forma se dissolva em brisas e luzes dançantes.\nComo uma <span class="dc-termo">ação bônus</span>, você pode gastar um ponto de feitiçaria para ficar parcialmente intangível até o início do seu próximo turno, recebendo resistência a dano contundente, cortante e perfurante de ataques não mágicos. Além disso, durante esse período, você pode atravessar espaços ocupados por outras criaturas como se fosse o vulto cintilante.',
      },
      {
        nivel: 18,
        titulo: 'Domínio das Fadas',
        corpo: `No 18° nível, você se torna uma manifestação viva do poder feérico, moldando o mundo ao seu capricho. Como uma <span class="dc-termo">ação bônus</span>, você pode abrir um domínio feérico em um raio de 64 metros ao seu redor, um espaço onde a própria realidade é maleável como o sonho. Esse efeito dura 1 minuto e concede os seguintes benefícios:
<ul><li>Distorção da Realidade: Você pode usar uma ação bônus no seu turno para alterar levemente o terreno dentro dessa área, fazendo crescer vegetação, criando névoa densa, distorcendo distâncias ou formando barreiras ilusórias que confundem os sentidos. Criaturas inimigas tratam o terreno como difícil e têm <span class="dc-termo">desvantagem</span> em testes de <span class="dc-termo">Sabedoria</span> (Percepção) para notar o que ocorre além de 6 metros.</li><li>Passagem Feérica: Você pode se teleportar livremente para qualquer ponto desocupado dentro da área ao custo de metade do seu deslocamento. Além disso, uma vez por rodada, quando um inimigo realizar um ataque contra você, você pode usar sua reação para desaparecer e reaparecer em outro ponto dentro dessa área, potencialmente evitando o golpe.</li><li>Capricho Feérico: No início do turno de qualquer criatura hostil dentro da área, ela deve fazer um teste de resistência de <span class="dc-termo">Sabedoria</span> contra sua CD de magia. Se falhar, fica atordoada até o início do próximo turno. Criaturas imunes à condição enfeitiçado não são afetadas por esse efeito.</li><li>Ilusões Inescapáveis: Dentro da área, suas magias de ilusão se tornam quase impossíveis de resistir. O teste de resistência contra elas aumenta em +5.</li></ul>
Durante esse efeito, sua aparência muda para algo verdadeiramente feérico: seus olhos brilham com luz etérea, seu corpo parece cintilar entre o visível e o invisível, e ao seu redor, borboletas de luz, névoas coloridas e brilhos oníricos permeiam o ar. Você pode terminar essa manifestação como uma <span class="dc-termo">ação bônus</span> antes do tempo acabar. Uma vez que ativar essa habilidade, você não pode usá-la novamente até completar um <span class="dc-termo">descanso longo</span>.`,
      },
    ],
  },
  {
    nome: 'Feiticeiro Estelar',
    icone: '⭐',
    introTexto: 'Seu poder vem das profundezas do cosmos, vinculado às forças invisíveis que regem o universo. A gravidade, o espaço e o tempo se dobram ao seu comando, tornando você um arauto do equilíbrio cósmico. Suas habilidades desafiam as leis da física e permitem que você influencie o ambiente ao seu redor com pura força estelar.',
    magias: [
      { nivel: '1º', magia: 'Onda Trovejante, Queda Suave' },
      { nivel: '3º', magia: 'Passo Nebuloso, Levitação' },
      { nivel: '5º', magia: 'Pulse Wave, Velocidade' },
      { nivel: '7º', magia: 'Gravity Sinkhole, Porta Dimensional' },
      { nivel: '9º', magia: 'Muralha de Força, Telecinésia' },
    ],
    caracteristicas: [
      {
        nivel: 1,
        titulo: 'Manipular Gravidade',
        corpo: 'A energia gravitacional ao seu redor se manifesta como mãos invisíveis que lhe obedecem com precisão telecinética. Você aprende o truque Mãos Mágicas, e ele não conta no limite de truques conhecidos. Para você, as mãos são invisíveis e podem levantar um peso equivalente a 5 kg × seu nível de feiticeiro × seu bônus de proficiência.\nAlém disso, você pode manipular pequenos objetos à distância de forma mais precisa, permitindo que use suas Mãos Mágicas para interagir com dispositivos complexos, abrir fechaduras destrancadas ou puxar alavancas sem precisar de contato direto.',
      },
      {
        nivel: 1,
        titulo: 'Pulso Gravitacional',
        corpo: 'Como uma <span class="dc-termo">ação bônus</span>, você pode escolher uma criatura ou objeto que possa ver a até 9 metros e puxá-lo ou empurrá-lo 1,5 metro em qualquer direção. Criaturas podem fazer um teste de <span class="dc-termo">Força</span> contra sua CD de magia para resistir.',
      },
      {
        nivel: 6,
        titulo: 'Clarividência Estelar',
        corpo: 'Ao atingir o 6° nível, seu vínculo com os cosmos lhe concede breves vislumbres do futuro. No início do seu turno, olhar um instante à frente no tempo. Até o final do seu turno, você tem <span class="dc-termo">vantagem</span> em todas as jogadas de ataque, testes de resistência e testes de habilidade. Além disso, ataques contra você têm <span class="dc-termo">desvantagem</span>.\nVocê pode usar essa habilidade um número de vezes igual ao seu bônus de proficiência por <span class="dc-termo">descanso longo</span>.',
      },
      {
        nivel: 6,
        titulo: 'Distorção Gravitacional',
        corpo: 'No 6° nível, você aprende a manipular a gravidade ao seu redor para afetar aliados e inimigos. Como <span class="dc-termo">ação bônus</span>, você pode escolher um número de criaturas até o seu modificador de <span class="dc-termo">Carisma</span> (mínimo 1) dentro de 9 metros e aplicar um dos seguintes efeitos:',
        tabela: {
          colunaA: 'Efeito',
          colunaB: 'Descrição',
          linhas: [
            { a: 'Aumentar a Gravidade', b: 'Criaturas afetadas devem fazer um teste de resistência de <span class="dc-termo">Força</span> contra sua CD de magia. Se falharem, ficam caídas e têm <span class="dc-termo">desvantagem</span> em testes de <span class="dc-termo">Força</span> e <span class="dc-termo">Destreza</span> até o final do seu próximo turno. Além disso, se estiverem no ar, caem imediatamente e sofrem 1d6 de dano para cada 3 metros caídos.' },
            { a: 'Diminuir a Gravidade', b: 'Criaturas afetadas ganham deslocamento de voo igual ao deslocamento base até o final do seu próximo turno. Além disso, seu próximo teste de resistência de <span class="dc-termo">Destreza</span> contra magias ou efeitos será realizado com <span class="dc-termo">vantagem</span>. Se já tiverem deslocamento de voo, ele é dobrado.' },
          ],
        },
        notaFinal: 'Você pode usar essa habilidade um número de vezes igual ao seu bônus de proficiência por <span class="dc-termo">descanso longo</span>.',
      },
      {
        nivel: 14,
        titulo: 'Escudo Estelar',
        corpo: 'No 14° nível, seu corpo se adapta ao vácuo do espaço, permitindo que você crie barreiras automáticas de proteção sempre que estiver sob ameaça. Sempre que sofrer dano de um ataque ou magia, você pode usar sua reação para criar uma barreira invisível que reduz o dano recebido em 3d8 + seu modificador de <span class="dc-termo">Carisma</span>. A <span class="dc-termo">Barreira Cósmica</span> pode ser usada um número de vezes igual ao seu bônus de proficiência por <span class="dc-termo">descanso longo</span>.',
      },
      {
        nivel: 18,
        titulo: 'Vontade Celestial',
        corpo: `Ao atingir o 18° nível, você atinge o ápice do controle gravitacional, podendo manipular objetos e criaturas com força esmagadora.
<ul><li>Ação Estelar: Você ganha uma ação adicional a cada turno, mas ela só pode ser usada para conjurar a magia Telecinésia. Enquanto essa habilidade estiver ativa, os seguintes efeitos adicionais se aplicam:</li><li>O peso máximo que você pode mover com Telecinésia aumenta para 10.000 kg.</li><li>Você pode afetar um número de criaturas igual ao seu modificador de <span class="dc-termo">Carisma</span> simultaneamente.</li><li>Criaturas jogadas contra uma superfície ou entre si sofrem o dobro do dano normal.</li></ul>
Essa habilidade dura 1 minuto e pode ser usada uma vez por <span class="dc-termo">descanso longo</span>.`,
      },
    ],
  },
  {
    nome: 'Feiticeiro de Clockwork',
    icone: '⚙️',
    introTexto: 'A força cósmica da ordem impregnou você com magia. Essa energia surge de Mechanus ou de um plano semelhante, um plano de existência moldado inteiramente pela eficiência de um relógio. Você, ou alguém de sua linhagem, pode ter se envolvido nas maquinações dos modrons, os seres ordenados que habitam Mechanus. Talvez seu ancestral tenha até mesmo participado da Grande Marcha Modron. Qualquer que seja a origem dentro de você, o poder da ordem pode parecer estranho para os outros, mas para você, é parte do vasto e glorioso sistema.',
    magias: [
      { nivel: '1º', magia: 'Alarme, Proteção contra o Bem e o Mal' },
      { nivel: '3º', magia: 'Auxílio, Restauração Menor' },
      { nivel: '5º', magia: 'Dissipar Magia, Proteção contra Energia' },
      { nivel: '7º', magia: 'Liberdade de Movimento, Invocação de Constructo' },
      { nivel: '9º', magia: 'Restauração Maior, Parede de Força' },
    ],
    caracteristicas: [
      {
        nivel: 1,
        titulo: 'Restaurar Equilíbrio',
        corpo: 'A partir do 1° nível, sua ligação com o plano da ordem absoluta permite equalizar momentos caóticos. Quando uma criatura que você pode ver a até 18 metros de você está prestes a rolar um d20 com <span class="dc-termo">vantagem</span> ou <span class="dc-termo">desvantagem</span>, você pode usar sua reação para impedir que a rolagem seja afetada por <span class="dc-termo">vantagem</span> e <span class="dc-termo">desvantagem</span>.\nVocê pode usar esse recurso um número de vezes igual ao seu bônus de proficiência, e recupera todos os usos gastos quando termina um <span class="dc-termo">descanso longo</span>.',
      },
      {
        nivel: 6,
        titulo: 'Baluarte da Lei',
        corpo: 'A partir do 6° nível, você pode acessar a grande equação da existência para imbuir uma criatura com um escudo cintilante de ordem. Como uma <span class="dc-termo">ação</span>, você pode gastar de 1 a 5 Pontos de Magia para criar uma proteção mágica ao seu redor ou em outra criatura que você possa ver a até 9 metros de você.\nA proteção dura até você terminar um <span class="dc-termo">descanso longo</span> ou até usar esse recurso novamente. A proteção é representada por um número de d8s igual ao número de Pontos de Magia gastos para criá-la. Quando a criatura protegida sofre dano, ela pode gastar um número desses dados, rolá-los e reduzir o dano total pelo valor rolado nos dados.',
      },
      {
        nivel: 14,
        titulo: 'Transe da Ordem',
        corpo: 'A partir do 14° nível, você ganha a habilidade de alinhar sua consciência aos cálculos infinitos de Mechanus. Como uma <span class="dc-termo">ação bônus</span>, você pode entrar nesse estado por 1 minuto. Durante a duração, rolagens de ataque contra você não se beneficiam de <span class="dc-termo">vantagem</span>, e sempre que você fizer uma rolagem de ataque, teste de habilidade ou salvaguarda, você pode considerar o resultado de 9 ou menos no d20 como 10. Depois de usar essa <span class="dc-termo">ação bônus</span>, você não pode usá-la novamente até terminar um <span class="dc-termo">descanso longo</span>, a menos que gaste 15 Pontos de Magia para usá-la novamente.',
      },
      {
        nivel: 18,
        titulo: 'Cavalaria de Cronograma',
        corpo: `No 18° nível, você convoca espíritos da ordem para expurgar o desordenado ao seu redor. Como uma <span class="dc-termo">ação</span>, você invoca os espíritos em um cubo de 9 metros ao seu redor. Os espíritos se parecem com modrons ou outros constructos de sua escolha. Eles são intangíveis e invulneráveis, e criam os seguintes efeitos dentro do cubo antes de desaparecerem:
<ul><li>Os espíritos restauram até 100 pontos de vida, divididos como você escolher entre qualquer número de criaturas de sua escolha no cubo.</li><li>Qualquer objeto danificado completamente no cubo é reparado instantaneamente.</li><li>Qualquer magia de 6° nível ou inferior termina em criaturas e objetos de sua escolha no cubo.</li></ul>
Depois de usar essa ação, você não pode usá-la novamente até terminar um <span class="dc-termo">descanso longo</span>, a menos que gaste 25 Pontos de Magia para usá-la novamente.`,
      },
    ],
  },
  {
    nome: 'Feiticeiro da Entidade dos Mares',
    icone: '🐙',
    introTexto: 'O poder primordial do oceano pulsa em suas veias, uma herança direta de uma antiga e temível entidade marinha. Seja por um pacto ancestral ou por uma bênção do próprio Kraken, você é marcado pela força indomável das profundezas. Sua magia não é apenas conjuração — ela é a fúria das tempestades, o terror das marés e a eletricidade bruta das trovoadas.',
    magias: [
      { nivel: '1º', magia: 'Braços de Hadar, Faca de Gelo' },
      { nivel: '3º', magia: 'Despedaçar, Tromba D\'água de Kaileo' },
      { nivel: '5º', magia: 'Convocar Relâmpago, Maremoto' },
      { nivel: '7º', magia: 'Controlar a Água, Tentáculos Negros de Evard' },
      { nivel: '9º', magia: 'Redemoinho, Presas D\'água de Kaileo' },
    ],
    caracteristicas: [
      {
        nivel: 1,
        titulo: 'Herança do Abismo',
        corpo: 'No 1° nível, você recebe a bênção das profundezas. Você pode respirar debaixo d\'água e ganha deslocamento de natação igual ao seu deslocamento normal. Além disso, você não sofre penalidades por estar em grandes profundezas, ignorando os efeitos da pressão e da escuridão abissal. Seu corpo também se adapta ao frio intenso, concedendo-lhe resistência a dano gélido.',
      },
      {
        nivel: 1,
        titulo: 'Fúria das Profundezas',
        corpo: 'A ira do Kraken flui através de sua magia, amplificando os efeitos de seus ataques elementais. Sempre que você causar dano elétrico, trovejante ou gélido a uma criatura, ela sofre um efeito adicional. Se a criatura estiver submersa em água, ela sofre todos esses efeitos simultaneamente.',
        tabela: {
          colunaA: 'Dano',
          colunaB: 'Efeito',
          linhas: [
            { a: 'Elétrico', b: 'A criatura não pode realizar reações até o final do seu próximo turno.' },
            { a: 'Trovejante', b: 'A criatura é empurrada 3 metros para trás.' },
            { a: 'Gélido', b: 'A criatura tem seu deslocamento reduzido pela metade até o final do seu próximo turno.' },
          ],
        },
      },
      {
        nivel: 6,
        titulo: 'Benção do Obscuro',
        corpo: `A partir do 6° nível, você pode invocar a verdadeira essência do Kraken para transformar seu corpo temporariamente, manifestando tentáculos espectrais que emergem de suas costas e ombros.
Como uma <span class="dc-termo">ação bônus</span>, você pode ativar essa habilidade, fazendo surgir um número de tentáculos igual ao seu bônus de proficiência. Esses tentáculos duram 1 minuto e conferem os seguintes benefícios enquanto estiverem ativos:
<ul><li>Fortaleza Abissal: Para cada tentáculo que você possuir, sua Classe de Armadura aumenta em +1.</li><li>Mobilidade Tentacular: Seu deslocamento aumenta em 3 metros para cada tentáculo que possuir, e você pode ignorar terrenos difíceis criados por água ou lama. Além disso, você pode se agarrar a superfícies e tetos sem precisar das mãos.</li><li>Canalização Arcana: No início de cada um dos seus turnos, você pode consumir um tentáculo para conjurar um truque da sua lista de feitiços como uma ação extra.</li></ul>
Uma vez que você ative essa habilidade, não pode usá-la novamente até completar um <span class="dc-termo">descanso curto</span> ou <span class="dc-termo">descanso longo</span>.`,
      },
      {
        nivel: 14,
        titulo: 'Olho da Tempestade',
        corpo: 'Começando no 14° nível, a energia do Kraken fortalece sua resiliência e destruição. Você recebe resistência a dano elétrico, trovejante, e quando você lançar uma magia que cause dano elétrico ou trovejante, você pode fazer com que uma das criaturas sofra dano extra igual ao seu nível.\nAlém disso, você pode consumir dois tentáculos de sua habilidade <span class="dc-termo">Benção do Obscuro</span> para rolar 1d10 em um teste de resistência falho, potencialmente fazendo ser bem sucedido.',
      },
      {
        nivel: 18,
        titulo: 'Fúria do Leviatã',
        corpo: `No 18° nível, você pode invocar a tempestade mais devastadora das profundezas, chamando a ira do Kraken em uma cataclísmica manifestação. Como <span class="dc-termo">ação</span>, você pode conjurar uma tempestade maciça com um raio de 3 quilômetros ao seu redor. A tempestade dura 1 minuto e causa os seguintes efeitos:
<ul><li>Chuva de Raios: A cada início de turno, 1d4 criaturas a sua escolha dentro da área devem fazer um teste de resistência de <span class="dc-termo">Destreza</span> (CD igual a 8 + seu modificador de <span class="dc-termo">Carisma</span> + sua proficiência) ou sofrerão 10d6 de dano elétrico em uma falha, ou metade desse dano em um sucesso.</li><li>Impedir Concentração: Criaturas dentro da área da tempestade têm <span class="dc-termo">desvantagem</span> em testes de resistência para manter a concentração em magias. Além disso, qualquer criatura que sofra dano da tempestade perde automaticamente a concentração.</li><li>Alagamento: A chuva torrencial inunda a área com água que sobe rapidamente, criando um terreno perigoso e intransponível. A cada turno, 1d4 criaturas a sua escolha dentro da área de efeito devem realizar um teste de <span class="dc-termo">Força</span> (CD igual a 8 + seu modificador de <span class="dc-termo">Carisma</span> + sua proficiência) para evitar ser arrastada para uma direção aleatória, caindo ou sendo levada pelo aumento do nível da água.</li><li>Destruição Terrível: A tempestade causa danos estruturais massivos. Edifícios, árvores e outras construções na área de efeito são destruídos. Criaturas que estiverem em terreno instável podem ser afligidas com dano adicional de 4d6 de dano de contusão ao serem derrubadas ou esmagadas.</li><li>Poder Ancestral: Suas magias de dano elétrico, gélido e trovejante ignoram resistência e tratam imunidade como resistência.</li></ul>
Você pode usar essa habilidade uma vez por <span class="dc-termo">descanso longo</span>.`,
      },
    ],
  },
];

// Escolha de subclasse — todo personagem escolhe uma subclasse em algum
// nível, independente da classe; por isso fica junto dos outros pontos
// fixos em Fundamentos da Classe, não na lista de características do
// Feiticeiro. As opções vêm do próprio array `subclasses`, pra não
// duplicar nome/ícone em dois lugares.
const subclasseEscolha = {
  titulo: 'Origem de Feitiçaria',
  corpo: 'Escolha uma origem de feitiçaria, que descreve a fonte do seu poder mágico inato. Sua escolha lhe confere características quando você a escolhe, no 1° nível, e novamente no 6°, 14° e 18° nível.',
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

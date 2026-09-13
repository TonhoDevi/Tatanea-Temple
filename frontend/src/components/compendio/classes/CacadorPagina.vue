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
        <h2 class="dc-section-title">Progressão — O Caçador</h2>
        <span class="dc-title-line"></span>
      </div>
      <div class="dc-tabela-wrap">
        <table class="dc-tabela-niveis">
          <thead>
            <tr>
              <th rowspan="2">Nível</th>
              <th rowspan="2">Características</th>
              <th rowspan="2" class="dc-th-centro">Marca do Caçador</th>
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
              <td class="dc-tabela-bonus">{{ n.danoMarca }}</td>
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
      <p class="dc-fundamentos-nota">Regras comuns a toda classe — não são exclusivas do Caçador.</p>

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
            <span class="dc-conjuracao-tipo-prefixo">O Caçador é</span>
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
              :class="{ 'dc-chip-tipo-magia-ativo': t === tipoMagiaCacador, 'dc-chip-tipo-magia-inativo': t !== tipoMagiaCacador }"
              v-for="t in tiposDeMagia"
              :key="t"
            >{{ t.toUpperCase() }}</span>
          </div>

          <span class="dc-atributo-magia-rotulo">O Atributo de Conjuração do Caçador</span>
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
                  <th>Nível do Caçador</th>
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
  nome: 'Caçador',
  subtitulo: 'Versão Épico',
  icone: '🏹',
  cor: '#4a8a5a',
  dadoDeVida: 'd10',
  dificuldade: 'Média',
  papeis: ['Dano', 'Controle', 'Exploração', 'Sobrevivência'],
};

const descricaoBlocos = [
  {
    titulo: null,
    paragrafos: [
      'Longe do burburinho das cidades e vilas, passadas as sebes que abrigam as fazendas mais distantes dos terrores da natureza selvagem, em meio as árvores densas de florestas sem trilhas e através de planícies vastas e desertas, os caçadores mantém sua vigília interminável.',
      'Guerreiros da natureza, diversos e variados em seus talentos e especializações, todos os caçadores compartilham uma característica de ter uma conexão profunda com a natureza. Os caçadores dominam várias armas para atacar ameaças à sua terra natal de perto e de longe. Eles aprendem a rastrear suas presas como um predador faz, movendo-se furtivamente através da natureza e escondendo-se na selva ou na grama.',
      'Graças a sua familiaridade com a natureza, os caçadores também adquirem a capacidade de conjurar magias que aproveitam o poder da natureza, como fazem os druidas. Seus feitiços, como suas habilidades em combate, enfatizam velocidade, furtividade e a caçada. Os talentos e habilidades de um caçador são aprimorados com uma experiência de combate mortal lutando contra ameaças nas fronteiras da civilização.',
    ],
  },
  {
    titulo: 'Caçadores Ferozes e Versáteis',
    paragrafos: [
      'Caçadores são guerreiros ágeis e hábeis que usam seu conhecimento das terras selvagens para rastrear e caçar seus inimigos. Seja espreitando através da floresta no rastro de intrusos malignos, se aliando com um companheiro animal, ou focando suas habilidades de combate em criaturas aberrantes, os caçadores podem ser letais em suas táticas.',
      'Independente dos métodos que os caçadores empreguem, os adversários considerarem enfrentá-los o mais difícil desafio que eles provavelmente enfrentarão, desde que eles permaneçam no terreno natural de um caçador. Mas os caçadores também podem adaptar suas habilidades para lutar em cidades e masmorras, fazendo deles valiosas figuras em muitos partidos de aventureiros.',
    ],
  },
  {
    titulo: 'Protetores Independentes',
    paragrafos: [
      'Embora um caçador possa fazer uma vida como um rastreador ou caçador, o verdadeiro chamado de um caçador é defender as partes exteriores da civilização das incursões de monstros e hordas humanoides que pressionam das terras selvagens. Em algumas regiões, os caçadores se reúnem em ordens secretas ou se juntam a círculos de druidas.',
      'Muitos caçadores, porém, são independentes quase ao ponto de serem reclusos, conhecendo apenas suas famílias ou mestres que os ensinaram suas formas. Um caçador pode escolher aventurar-se por várias razões. Proteger as fronteiras muitas vezes significa encontrar e derrotar bandidos, orcs, trolls, gigantes e piores criaturas. Mas alguns caçadores encontram-se assistindo às rotas de comércio. Todos esses esforços caem dentro do domínio natural do caçador.',
    ],
  },
];

const vida = {
  prefixo: 'd',
  numero: '10',
  nivel1: '10 + seu bônus de Salvaguarda de Constituição + 1',
  niveisSuperiores: '10 + seu bônus de Salvaguarda de Constituição por nível de caçador após o 1°',
};

const proficiencias = [
  { titulo: 'Testes de Resistência', itens: ['Inteligência', 'Sabedoria'], estilo: 'selos', icone: markRaw(IconeResistencia) },
  {
    titulo: 'Perícias',
    nota: 'escolha três',
    itens: ['Acrobacia', 'Arcana', 'Atletismo', 'Furtividade', 'História', 'Percepção', 'Investigação', 'Religião', 'Sobrevivência'],
    icone: markRaw(IconePericias),
  },
];

const proficienciasEquipamento = [
  { titulo: 'Armadura', itens: ['Armaduras leves', 'Armaduras médias', 'Escudos'] },
  { titulo: 'Armas', itens: ['Armas simples', 'Armas marciais'] },
  { titulo: 'Ferramentas', itens: ['Nenhuma'] },
];

const equipamento = {
  intro: 'Você começa com o seguinte equipamento, além do equipamento concedido pelo seu antecedente:',
  itens: [
    { opcoes: ['Brunea', 'Armadura de couro'] },
    { opcoes: ['Duas espadas curtas', 'Duas armas simples corpo-a-corpo'] },
    { opcoes: ['Um pacote de explorador', 'Um pacote de aventureiro'] },
    { opcoes: ['Um arco longo e uma aljava com 20 flechas'] },
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
  { nivel: 1, danoMarca: '1d4', magiasConhecidas: SEM, espacos: [SEM, SEM, SEM, SEM, SEM], caracteristicas: 'Marca do Caçador, Território de Caça, Talento' },
  { nivel: 2, danoMarca: '1d4', magiasConhecidas: 2, espacos: [2, SEM, SEM, SEM, SEM], caracteristicas: 'Estilo de Luta, Conjuração' },
  { nivel: 3, danoMarca: '1d4', magiasConhecidas: 3, espacos: [3, SEM, SEM, SEM, SEM], caracteristicas: 'Conclave de Caçador' },
  { nivel: 4, danoMarca: '1d4', magiasConhecidas: 3, espacos: [3, SEM, SEM, SEM, SEM], caracteristicas: '-' },
  { nivel: 5, danoMarca: '1d6', magiasConhecidas: 4, espacos: [4, 2, SEM, SEM, SEM], caracteristicas: 'Ataque Extra, Talento' },
  { nivel: 6, danoMarca: '1d6', magiasConhecidas: 4, espacos: [4, 2, SEM, SEM, SEM], caracteristicas: 'Desaparecer' },
  { nivel: 7, danoMarca: '1d6', magiasConhecidas: 5, espacos: [4, 3, SEM, SEM, SEM], caracteristicas: 'Característica de Conclave' },
  { nivel: 8, danoMarca: '1d6', magiasConhecidas: 5, espacos: [4, 3, SEM, SEM, SEM], caracteristicas: 'Pés Rápidos' },
  { nivel: 9, danoMarca: '1d8', magiasConhecidas: 6, espacos: [4, 3, 2, SEM, SEM], caracteristicas: '-' },
  { nivel: 10, danoMarca: '1d8', magiasConhecidas: 6, espacos: [4, 3, 2, SEM, SEM], caracteristicas: 'Augmentação Corporal, Talento' },
  { nivel: 11, danoMarca: '1d8', magiasConhecidas: 7, espacos: [4, 3, 3, SEM, SEM], caracteristicas: 'Característica de Conclave' },
  { nivel: 12, danoMarca: '1d8', magiasConhecidas: 7, espacos: [4, 3, 3, SEM, SEM], caracteristicas: '-' },
  { nivel: 13, danoMarca: '1d10', magiasConhecidas: 8, espacos: [4, 3, 3, 1, SEM], caracteristicas: 'Marca do Caçador Ampliada' },
  { nivel: 14, danoMarca: '1d10', magiasConhecidas: 8, espacos: [4, 3, 3, 1, SEM], caracteristicas: 'Alma Endurecida' },
  { nivel: 15, danoMarca: '1d10', magiasConhecidas: 9, espacos: [4, 3, 3, 2, SEM], caracteristicas: 'Característica de Conclave, Talento' },
  { nivel: 16, danoMarca: '1d10', magiasConhecidas: 9, espacos: [4, 3, 3, 2, SEM], caracteristicas: '-' },
  { nivel: 17, danoMarca: '1d12', magiasConhecidas: 10, espacos: [4, 3, 3, 2, 1], caracteristicas: '-' },
  { nivel: 18, danoMarca: '1d12', magiasConhecidas: 10, espacos: [4, 3, 3, 2, 1], caracteristicas: 'Perspicácia na Caça, Característica de Conclave' },
  { nivel: 19, danoMarca: '1d12', magiasConhecidas: 11, espacos: [4, 3, 3, 2, 2], caracteristicas: 'Lendário' },
  { nivel: 20, danoMarca: '1d12', magiasConhecidas: 11, espacos: [4, 3, 3, 2, 2], caracteristicas: 'Matador de Inimigos, Talento' },
];

const conjuracaoTipo = 'Meio Conjurador';

const conjuracaoTexto =
  'Você conhece duas magias de 1° nível, à sua escolha, da lista de magias de caçador. A cada nível, você pode aprender magias adicionais, sempre de um nível ao qual você tenha acesso — a coluna Magias Conhecidas na tabela O Caçador mostra quando isso acontece. Ao subir de nível, você também pode trocar uma magia que conhece por outra da lista de magias de caçador, desde que a nova magia seja de um nível para o qual você tenha espaços de magia.';

const tiposDeMagia = ['Natural', 'Divina', 'Arcana'];
const tipoMagiaCacador = 'Natural';

const fonteMagia =
  'O Caçador atribui sua fonte de magia diretamente da natureza, sendo capaz de utilizar a magia natural.';

const atributoConjuracao = {
  nome: 'Sabedoria',
  bonus: ['Sabedoria', 'Proficiência'],
  cd: ['8', 'Proficiência', 'Sabedoria'],
  nota: 'Os valores de Sabedoria e Proficiência usados são os bônus respectivos.',
};

const caracteristicas = [
  {
    nivel: 1,
    titulo: 'Marca do Caçador',
    corpo: `Começando no 1º nível, você pode focar seus sentidos em uma criatura, marcando-a misticamente como sua presa. Como uma <span class="dc-termo">ação bônus</span>, você pode marcar uma criatura que você possa ver em um raio de 27 metros de você. Alternativamente, você pode marcar uma criatura estudando seus rastros por pelo menos 1 minuto. O alvo é marcado enquanto está no mesmo plano de existência que você e não está protegido de magias de adivinhação. A marca também desaparece se você terminar um <span class="dc-termo">descanso curto</span> ou <span class="dc-termo">descanso longo</span>, ficar inconsciente ou usar este recurso novamente para atingir outra criatura.
Enquanto uma criatura estiver marcada, você ganha os seguintes benefícios:
<ul><li>Você tem <span class="dc-termo">vantagem</span> em qualquer teste de <span class="dc-termo">Sabedoria</span> (Percepção) ou <span class="dc-termo">Sabedoria</span> (Sobrevivência) para encontrar o alvo.</li><li>Uma vez por turno, quando você acerta o alvo com um ataque com arma, você causa dano adicional conforme mostrado na coluna Dano de <span class="dc-termo">Marca do Caçador</span> na tabela O Caçador.</li></ul>
Você pode usar esse recurso um número de vezes igual ao seu modificador de <span class="dc-termo">Sabedoria</span> (no mínimo uma vez) e você recupera todos usos gastos quando você termina um <span class="dc-termo">descanso curto</span> ou <span class="dc-termo">descanso longo</span>.`,
  },
  {
    nivel: 1,
    titulo: 'Território de Caça',
    corpo: `Você está particularmente familiarizado com um tipo de ambiente e é adepto das habilidades exclusivas da região. Escolha um tipo de terreno preferido:`,
    tabela: {
      colunaA: 'Terreno',
      colunaB: 'Benefício',
      linhas: [
        { a: 'Costa', b: 'Nadar não custa mais movimento extra. Você também pode prender a respiração três vezes mais do que normalmente pode.' },
        { a: 'Deserto', b: 'Você está naturalmente adaptado a climas quentes. Você também ganha resistência contra danos de fogo.' },
        { a: 'Floresta', b: 'Você possui <span class="dc-termo">vantagem</span> em todos os testes de percepção.' },
        { a: 'Pastagem', b: 'Sua velocidade aumenta em 3 metros.' },
        { a: 'Montanha', b: 'Escalar não custa mais movimento extra. Além disso, você está naturalmente adaptado a grandes altitudes.' },
        { a: 'Pântano', b: 'Você ganha resistência a dano venenoso e tem <span class="dc-termo">vantagem</span> em testes de resistência contra doenças.' },
        { a: 'Tundra', b: 'Você está naturalmente adaptado a climas frios. Você também ganha resistência contra danos de frio.' },
        { a: 'Subterrâneo', b: 'Você aprende Sub-comum. Se você não tem visão no escuro, você a ganha com um alcance de 9 metros. Se você tem visão no escuro, você ganha visão às cegas com um alcance de 1,5 metro.' },
        { a: 'Urbano', b: 'Você ganha proficiência em Investigação e seu bônus de proficiência é duplicado para qualquer teste de habilidade que você fizer com essa habilidade. Você também aprende a falar, ler e escrever uma linguagem humanoide de sua escolha.' },
      ],
    },
    notaFinal: 'Você escolhe um tipo de terreno favorito adicional no 6º nível, no 10º nível e 14º nível.',
  },
  {
    nivel: 2,
    titulo: 'Estilo de Luta',
    corpo: 'No 2° nível, você adota um estilo de combate particular que será sua especialidade. Escolha uma das opções a seguir. Você não pode escolher o mesmo Estilo de Combate mais de uma vez, mesmo se puder escolher de novo.',
    tabela: {
      colunaA: 'Estilo',
      colunaB: 'Efeito',
      linhas: [
        { a: 'Arquearia', b: 'Você ganha +2 de bônus nas jogadas de ataque realizadas com uma arma de ataque à distância.' },
        { a: 'Combate com Duas Armas', b: 'Quando você estiver engajado em uma luta com duas armas, você pode adicionar o seu modificador de habilidade na jogada de dano do seu segundo ataque.' },
        { a: 'Defesa', b: 'Enquanto estiver usando armadura, você ganha +1 de bônus em sua CA.' },
        { a: 'Duelista', b: 'Quando você empunhar uma arma de ataque corpo-a-corpo em uma mão e nenhuma outra arma, você ganha +2 de bônus nas jogadas de dano com essa arma.' },
      ],
    },
  },
  {
    nivel: 5,
    titulo: 'Ataque Extra',
    corpo: 'A partir do 5° nível, você pode atacar duas vezes, ao invés de uma, sempre que você realizar a <span class="dc-termo">ação de Ataque</span> no seu turno.',
  },
  {
    nivel: 6,
    titulo: 'Desaparecer',
    corpo: 'A partir do 6º nível, sua velocidade e furtividade em combate tornam difícil de definir. Você pode realizar a <span class="dc-termo">ação Ocultar</span> como uma <span class="dc-termo">ação bônus</span> e você não pode ser rastreado por meios não mágicos, a menos que você decida deixar um rastro. Além disso, se você estiver escondido ao rolar a <span class="dc-termo">iniciativa</span>, fazer um ataque durante a primeira rodada de combate não revele sua localização se você cumprir as condições necessárias para se esconder.',
  },
  {
    nivel: 8,
    titulo: 'Pés Rápidos',
    corpo: 'Começando no 8° nível, você pode usar a <span class="dc-termo">ação de Disparada</span> como uma <span class="dc-termo">ação bônus</span> no seu turno.',
  },
  {
    nivel: 10,
    titulo: 'Augmentação Corporal',
    corpo: 'Começando no 10º nível, a magia infunde seu corpo para reforçar permanentemente sua resiliência. Sua velocidade aumenta em 5 pés, e você tem um bônus em testes de resistência de <span class="dc-termo">Força</span>, <span class="dc-termo">Destreza</span> e <span class="dc-termo">Constituição</span> igual ao seu dado de dano de <span class="dc-termo">marca do caçador</span>.',
  },
  {
    nivel: 13,
    titulo: 'Marca do Caçador Ampliada',
    corpo: 'A partir do 13º nível, sua conexão com a presa se aprofunda: com um único uso da sua <span class="dc-termo">Marca do Caçador</span>, você pode marcar uma quantidade de criaturas ao mesmo tempo igual ao seu bônus de <span class="dc-termo">Sabedoria</span>.',
  },
  {
    nivel: 14,
    titulo: 'Alma Endurecida',
    corpo: 'Começando no 14° nível, você se torna imune a condições amedrontado e tem <span class="dc-termo">vantagem</span> em testes de resistência contra magias de encantamento.',
  },
  {
    nivel: 18,
    titulo: 'Perspicácia na Caça',
    corpo: 'No 18° nível, você desenvolve uma mentalidade predatória intranspassável, permitindo-lhe canalizar o poder da magia para sua proteção contra suas presas. Você recebe resistência a todos os danos causados pelo seu alvo da <span class="dc-termo">Marca do Caçador</span>.',
  },
  {
    nivel: 19,
    titulo: 'Lendário',
    corpo: 'Ao atingir o 19°, você pode escolher um <span class="dc-termo">talento</span> épico.',
  },
  {
    nivel: 20,
    titulo: 'Matador de Inimigos',
    corpo: 'No 20° nível, você se torna um caçador incomparável. Uma vez em cada um dos seus turnos, você pode adicionar seu modificador de <span class="dc-termo">Sabedoria</span> na jogada de ataque e jogada de dano de um ataque que você fizer. Você pode escolher usar essa característica antes ou depois da rolagem, mas antes de qualquer efeito da jogada ser aplicado.',
  },
];

const subclasses = [
  {
    nome: 'Exterminador Profano',
    icone: '☠️',
    introTexto: 'Os Exterminadores Profanos são uma irmandade enigmática dedicada a erradicar o mal através do uso da magia negra. Estes caçadores sombrios empregam conhecimentos proibidos para rastrear e extinguir criaturas profanas, desfazendo suas existências corrompidas em uma busca implacável pela purificação do mundo. No entanto, seu compromisso com a erradicação do mal não vem sem custos, e cada Exterminador carrega o peso sombrio do sacrifício pessoal enquanto se aventuram nas profundezas das trevas para proteger a existência de todos.',
    magias: [
      { nivel: '3º', magia: 'Bruxaria' },
      { nivel: '5º', magia: 'Raio do Enfraquecimento' },
      { nivel: '9º', magia: 'Rogar Maldição' },
      { nivel: '13º', magia: 'Sombra de Trastorno' },
      { nivel: '17º', magia: 'Praga' },
    ],
    caracteristicas: [
      { nivel: 3, titulo: 'Magia do Exterminador Profano', corpo: 'Ao atingir o 3º nível, você aprende uma magia adicional ao alcançar determinados níveis nesta classe, como indicado na tabela de Magias do Exterminador Profano. A magia conta como uma magia de caçador para você, mas não conta no número de magias de caçador que você conhece.' },
      { nivel: 3, titulo: 'Guerreiro Profano', corpo: `No 3º nível, você ganha a habilidade de canalizar essência vital para amaldiçoar e manipular criaturas por meio de magia negra. Quando você estiver com uma criatura marcada com sua <span class="dc-termo">Marca do Caçador</span> você pode nos turnos subsequentes infligir uma maldição no alvo. Se uma maldição pedir por uma jogada de ataque ou teste de resistência, o seu bônus e CD serão iguais ao de sua habilidade de conjuração.
Você pode utilizar uma maldição um número de vezes igual ao seu bônus de proficiência e recupera todos os usos após um <span class="dc-termo">descanso curto</span> ou <span class="dc-termo">descanso longo</span>.` },
      { nivel: 3, titulo: 'Artes Obscuras', corpo: `No 3° nível, suas pesquisas e esforços fizeram você aprender três maldições diferentes que permitem enfraquecer suas presas.
<strong>Maldição de Ansiedade.</strong> Com uma <span class="dc-termo">ação bônus</span>, você intensifica o medo no corpo da criatura, tornando-a suscetível a influências fortes. Até o começo do seu próximo turno, todas as criaturas têm <span class="dc-termo">vantagem</span> em testes de <span class="dc-termo">Carisma</span> (Intimidação) direcionados à criatura alvo.
<strong>Maldição de Prisão.</strong> Com uma <span class="dc-termo">ação bônus</span>, você tenta infligir uma onda letárgica que fraqueja as pernas do alvo. O alvo deve ter sucesso em um teste de resistência de <span class="dc-termo">Força</span> ou terá sua velocidade reduzida a 0 e não pode usar reações até o começo do seu próximo turno.
<strong>Maldição de Escuridão.</strong> Com uma <span class="dc-termo">ação bônus</span>, você obscurece a visão da criatura com sombras de morte. O alvo deve ser bem sucedido em um teste de resistência de <span class="dc-termo">Constituição</span> ou ficar cego até o início do seu próximo turno.` },
      { nivel: 7, titulo: 'Assombração Impiedosa', corpo: `No 7º nível, seu desenvolvimento e descobertas lhe garantiram mais três maldições em seu repertório de artes negras.
<strong>Maldição de Agonia.</strong> Com uma <span class="dc-termo">ação bônus</span>, você amaldiçoa a criatura com uma doença profunda que sensibiliza suas defesas. A criatura tem <span class="dc-termo">desvantagem</span> em testes de habilidade de <span class="dc-termo">Força</span> e <span class="dc-termo">Destreza</span> e sofre 1d8 de dano necrótico sempre que for atingida por um ataque até o começo do seu próximo turno.
<strong>Maldição de Feridas.</strong> Com uma <span class="dc-termo">ação bônus</span>, você pode tentar infligir uma praga na carne da sua presa. O alvo deve ser bem sucedido em um teste de resistência de <span class="dc-termo">Constituição</span> ou não poderá se curar até o início do seu próximo turno.
<strong>Maldição de Estalo.</strong> Com uma reação, você lança um som terrível em forma de gritos diretamente para a mente da criatura. Quando a criatura tentar realizar uma jogada de d20 você pode utilizar essa maldição para diminuir o resultado em um valor igual ao seu dado de dano de caçador.
Além disso, você se torna mais acostumado com as armas que criaturas horrendas usam. Você recebe resistência a dano de veneno e <span class="dc-termo">vantagem</span> em teste de resistência contra ser envenenado.` },
      { nivel: 11, titulo: 'Caçador de Horrores', corpo: `No 11º nível, suas experiências com os horrores desse mundo garantiram a você a potência e as habilidades necessárias para sobreviver a elas, fazendo com que você aprenda mais 3 maldições.
<strong>Maldição de Fraqueza.</strong> Com uma reação, você aflige a criatura com uma paralisia a deixando vulnerável brevemente. Quando a criatura sofrer um ataque ou magia, você pode usar sua reação para tentar paralisar. A criatura deve ser bem sucedida em um teste de resistência de <span class="dc-termo">Sabedoria</span> ou irá ficar sobre a condição paralisada durante a realização do ataque ou magia que desencadeou a maldição.
<strong>Maldição da Transfusão.</strong> Com uma <span class="dc-termo">ação bônus</span>, você pode rasgar a vitalidade da criatura e utilizar essa fagulha de energia a seu favor. A criatura deve ser bem sucedida em um teste de resistência de <span class="dc-termo">Constituição</span> ou sofrerá uma quantidade de dano de Force igual ao seu dado de dano de caçador mais o seu nível. Ou metade em um sucesso. Você pode curar uma criatura a até 9m de você em uma quantidade de pontos de vida igual ao dano causado.
<strong>Maldição de Dilacerar Magia.</strong> Com uma reação, você pode tentar perturbar a mente da criatura derrubando sua concentração. Se a criatura estiver conjurando ou mantendo uma magia, você pode obrigar ela a realizar um teste de resistência de <span class="dc-termo">Inteligência</span>. Em uma falha a magia conjurada ou mantida é perdida.
Além disso, você se torna mais próximo ao profano se tornando mais resistente às artes negras. Você recebe resistência a dano Necrótico e seu máximo de pontos de vida não pode ser diminuído de nenhuma forma.` },
      { nivel: 15, titulo: 'Senhor das Maldições', corpo: `No 15º nível, suas maldições atingiram o máximo de seu crescimento fazendo com que você tenha acesso as mais poderosas das maldições.
<strong>Maldição do Reflexo Frágil.</strong> Com uma <span class="dc-termo">ação bônus</span>, você aflige a criatura com uma sensação de prisão e agonia. A criatura amaldiçoada vê seu corpo amarrado por magia negra diminuindo seus reflexos. Até o início do seu próximo turno, seus testes de resistência de <span class="dc-termo">Força</span>, <span class="dc-termo">Destreza</span> e a sua CA são diminuídos em um valor igual a uma rolagem de seu dado de dano de caçador.
<strong>Maldição da Atração Desenfreada.</strong> Com uma <span class="dc-termo">ação bônus</span>, você pode amaldiçoar a criatura com uma compulsão por destruição. Ela deve ser bem sucedida em um teste de resistência de <span class="dc-termo">Sabedoria</span> ou será atraída por alvos aliados, atacando-os no seu próximo turno.
<strong>Maldição do Tormento Desenfreado.</strong> Com uma <span class="dc-termo">ação bônus</span>, você inflige dor na pele da criatura que a faz agonizar em destruição. A criatura deve ser bem sucedida em um teste de resistência de <span class="dc-termo">Sabedoria</span> ou sofrerá um dano Psíquico igual a três vezes o seu dado de dano de caçador mais o seu nível e ficará amedrontada por você até o final do seu próximo turno. Uma criatura sofre metade em um sucesso e nenhum efeito.
Além disso, você tem <span class="dc-termo">vantagem</span> em qualquer teste de resistência que envolva magia de necromancia.` },
    ],
  },
  {
    nome: 'Perseguidor do Horizonte',
    icone: '🌀',
    introTexto: 'Os Perseguidores do Horizonte protegem o mundo contra ameaças que se originam de outros planos ou que buscam devastar o reino mortal com magia de outros mundos. Eles procuram por portais planares e os vigiam, aventurando-se nos Planos Interiores e nos Planos Exteriores conforme necessário para enfrentar seus inimigos. Esses rangers também são aliados a qualquer força no multiverso — especialmente dragões benevolentes, seres feéricos e elementais — que trabalhem para preservar a vida e a ordem dos planos.',
    magias: [
      { nivel: '3º', magia: 'Proteção contra o Bem e o Mal' },
      { nivel: '5º', magia: 'Passo Nebuloso' },
      { nivel: '9º', magia: 'Clarividência' },
      { nivel: '13º', magia: 'Banimento' },
      { nivel: '17º', magia: 'Vidência' },
    ],
    caracteristicas: [
      { nivel: 3, titulo: 'Magia do Andarilho do Horizonte', corpo: 'Ao atingir o 3º nível, você aprende uma magia adicional ao alcançar determinados níveis nesta classe, como indicado na tabela de Magias do Andarilho do Horizonte. A magia conta como uma magia de caçador para você, mas não conta no número de magias de caçador que você conhece.' },
      { nivel: 3, titulo: 'Viajante Espectral', corpo: 'No 3º nível, você acumulou conhecimento dos muitos planos no multiverso, sempre contribuindo com orientações de lugares distantes. Você ganha proficiência em sua escolha entre História, Arcana ou Natureza. Se você já possui proficiência, você ganha especialização na habilidade escolhida. Além disso, sempre que fizer um teste de resistência de <span class="dc-termo">Inteligência</span>, você pode adicionar seu modificador de <span class="dc-termo">Sabedoria</span> ao resultado (mínimo de +1).' },
      { nivel: 3, titulo: 'Caçador Extraplanar', corpo: 'No 3º nível, você ganha a habilidade de detectar magicamente a presença de portais planares e criaturas extraplanares. Como <span class="dc-termo">ação</span>, você detecta a distância e direção para o portal planar mais próximo dentro de 1,6 km de você. Além disso, você detecta a distância e direção para a criatura fey, celestial, abissal, elemental ou aberrante mais próxima dentro de 1,6 km de você que tenha sido convocada por um feitiço de 3º nível ou superior. Você pode usar essa habilidade um número de vezes igual ao bônus de proficiência, recuperando todos os usos em um <span class="dc-termo">descanso longo</span>.' },
      { nivel: 3, titulo: 'Destruição Planar', corpo: 'No 3º nível, você aprende a canalizar a energia do multiverso para aprimorar seus ataques contra sua presa. Contra o alvo de sua <span class="dc-termo">marca do caçador</span>, você pode escolher aprimorar seu golpe causando 1d8 de dano extra e transformar todo o dano causado em dano de Force. Você pode utilizar essa habilidade uma quantidade de vezes igual ao seu bônus de proficiência a cada <span class="dc-termo">descanso longo</span>. Quando atinge o 11º nível nesta classe, o dano extra aumenta para 2d8.' },
      { nivel: 7, titulo: 'Foco Infinito', corpo: 'No 7º nível, você consegue ver as pequenas fissuras do espaço que nascem graças a magia que existe dentro de qualquer indivíduo. No começo do seu turno uma criatura inimiga aleatória se torna fragilizada em um ponto à sua volta. Role 1d8 para saber qual diagonal ou lateral o indivíduo está fragilizado. Se você atacar uma criatura em seu ponto fragilizado ela sofre automaticamente os efeitos de sua <span class="dc-termo">Destruição Planar</span>.' },
      { nivel: 11, titulo: 'Caçada Dimensional', corpo: `No 11º nível, sua determinação para perseguir sua presa se torna imparável não importa onde estejam. Você pode marcar criaturas independente da distância com sua <span class="dc-termo">Marca do Caçador</span> desde que ela esteja no mesmo plano que você e você a tenha conhecido pessoalmente pelo menos uma vez. Você pode com uma <span class="dc-termo">ação bônus</span> teletransportar a até 9m de distância do seu alvo marcado pela sua <span class="dc-termo">Marca do Caçador</span> desde que ele esteja no mesmo plano que você.
Além disso, após você teletransportar dessa forma, você recebe <span class="dc-termo">vantagem</span> em suas jogadas de ataque contra o seu alvo marcado neste turno.` },
      { nivel: 15, titulo: 'Conhecimento Planar', corpo: `No 15º nível, sua habilidade de perseguir suas presas se tornam infinitas quebrando até barreiras interdimensionais. Você ganha os seguintes benefícios:
<ul><li>Com seu <span class="dc-termo">Foco Infinito</span> você pode marcar uma criatura com sua <span class="dc-termo">Marca do Caçador</span> mesmo que ela esteja em qualquer lugar do multiverso, desde que você a conheça. Você sempre sabe em que plano ela está.</li><li>Com sua <span class="dc-termo">Caçada Dimensional</span> você pode teletransportar para o seu alvo independente de seu plano atual. Você ganha uma visão do local antes de teletransportar, podendo agora escolher qualquer lugar até 500 pés do alvo.</li><li>Quando uma criatura marcada por sua <span class="dc-termo">Marca do Caçador</span> que esteja a até 9m de você tentar ir para mais de 9m de distância de você, você pode com uma reação forçar a criatura a realizar um teste de resistência de <span class="dc-termo">Sabedoria</span> ou será teletransportada para um local a até 9m de você. O local deve ser uma superfície desocupada.</li><li>Quando uma criatura marcada por sua <span class="dc-termo">Marca do Caçador</span> acertar um ataque contra você, você pode com uma reação teletransportar para um local a até 9m delas fazendo com que o ataque erre automaticamente.</li></ul>` },
    ],
  },
  {
    nome: 'Predador Primal',
    icone: '🐾',
    introTexto: 'Os Predadores Primais mantém viva uma tradição ancestral há muito esquecida pela história escrita. Vivendo distantes da sociedade moderna, esses caçadores preservam um código de honra enraizado na natureza, sentindo-se deslocados em um mundo que valoriza a inovação sobre a sabedoria antiga. Desconfiados da tecnologia, eles formam vilas junto a bárbaros e druidas, onde a conexão com a natureza é venerada. Seu dogma de vida reside na busca e no deleite da caça, uma essência fundamental que permeia suas existências, moldando cada passo e decisão.',
    magias: [
      { nivel: '3º', magia: 'Golpe de Zephyr' },
      { nivel: '5º', magia: 'Aprimorar Habilidade' },
      { nivel: '9º', magia: 'Velocidade' },
      { nivel: '13º', magia: 'Movimentação Livre' },
      { nivel: '17º', magia: 'Fortalecimento de Perícia' },
    ],
    caracteristicas: [
      { nivel: 3, titulo: 'Magia do Predador Primal', corpo: 'Ao atingir o 3º nível, você aprende uma magia adicional ao alcançar determinados níveis nesta classe, como indicado na tabela de Magias do Predador Primal. A magia conta como uma magia de caçador para você, mas não conta no número de magias de caçador que você conhece.' },
      { nivel: 3, titulo: 'Caça Bruta', corpo: `Começando no 3º nível, você possui a experiência de combate e tenacidade de perseguir suas presas até que seus espíritos quebrem. Enquanto você marcar uma criatura com sua <span class="dc-termo">Marca do Caçador</span> você recebe os seguintes benefícios enquanto estiver em sua perseguição:
<ul><li>Sua velocidade de caminhada aumenta em 10 pés.</li><li>Você tem <span class="dc-termo">vantagem</span> em testes de resistência de <span class="dc-termo">Destreza</span> e teste de habilidade de Atletismo e Acrobacia, contra efeitos que possa ver, como armadilhas, obstáculos e magias. Para obter esse benefício, você não pode estar cego, surdo ou incapacitado.</li><li>Você recebe <span class="dc-termo">deslocamento</span> de escalada e natação igual ao seu <span class="dc-termo">deslocamento</span> de caminhada.</li><li>Você ganha um bônus em sua Classe de Armadura igual ao seu bônus de proficiência contra sua criatura marcada.</li></ul>` },
      { nivel: 7, titulo: 'Caçador Incessável', corpo: `No 7º nível, seus instintos e condicionamento para a caçada se tornam potentes o alertando do perigo e garantindo que você possa reagir a qualquer situação. Enquanto você marcar uma criatura com sua <span class="dc-termo">Marca do Caçador</span> você recebe os seguintes benefícios enquanto estiver em sua perseguição:
<ul><li>Sua velocidade de caminhada aumenta em 10 pés.</li><li>Quando você acertar um ataque contra a criatura marcada a velocidade de movimento dela diminui em 5 pés.</li><li>Você se torna imune a condição exausto.</li><li>A margem de críticos contra a criatura marcada se torna 19-20.</li></ul>
Além disso, seus instintos estão tão afiados que você tem <span class="dc-termo">vantagem</span> em testes de <span class="dc-termo">iniciativa</span> e se você estiver surpreendido no início do combate e não estiver incapacitado, você pode agir normalmente em seu primeiro turno.` },
      { nivel: 11, titulo: 'Enfraquecer Presa', corpo: 'Começando no 11º nível, você aprende a expor e explorar as fraquezas de suas presas que estrangulam para tentar fugir de sua frenesi sanguinária. Sempre que você acertar uma criatura marcada com um acerto crítico a criatura também sofre 1 ponto de exaustão.' },
      { nivel: 15, titulo: 'Superioridade Tática', corpo: 'A partir do 15º nível, suas técnicas de cerco e de execução estão lapidadas garantindo sua superioridade a qualquer criatura que você deseja predar. Você possui <span class="dc-termo">vantagem</span> em qualquer jogada de d20 contra a criatura marcada por sua <span class="dc-termo">Marca do Caçador</span>. Além disso, sua margem de crítico contra a criatura marcada se torna 18-20.' },
    ],
  },
];

// Escolha de subclasse — todo personagem escolhe uma subclasse em algum
// nível, independente da classe; por isso fica junto dos outros pontos
// fixos em Fundamentos da Classe, não na lista de características do
// Caçador. As opções vêm do próprio array `subclasses`, pra não duplicar
// nome/ícone em dois lugares.
const subclasseEscolha = {
  titulo: 'Conclave de Caçador',
  corpo: 'No 3° nível, você escolhe emular os ideais de treinamento de um conclave de caçador. Sua escolha lhe concede características no 3° nível e novamente no 7°, 11°, 15° e 18° nível.',
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

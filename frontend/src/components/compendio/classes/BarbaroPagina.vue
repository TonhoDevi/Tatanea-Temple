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
        <h2 class="dc-section-title">Progressão — O Bárbaro</h2>
        <span class="dc-title-line"></span>
      </div>
      <div class="dc-tabela-wrap">
        <table class="dc-tabela-niveis">
          <thead>
            <tr>
              <th>Nível</th>
              <th>Características</th>
              <th class="dc-th-centro">Fúrias</th>
              <th class="dc-th-centro">Dano de Fúria</th>
            </tr>
          </thead>
          <tbody>
            <tr v-for="n in niveis" :key="n.nivel">
              <td class="dc-tabela-nivel">{{ n.nivel }}º</td>
              <td class="dc-tabela-carac">{{ n.caracteristicas }}</td>
              <td class="dc-tabela-bonus">{{ n.furias }}</td>
              <td class="dc-tabela-bonus">{{ n.danoFuria }}</td>
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
      <p class="dc-fundamentos-nota">Regras comuns a toda classe — não são exclusivas do Bárbaro.</p>

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
  nome: 'Bárbaro',
  subtitulo: 'A fúria selvagem que queima no coração de um guerreiro é a chama que ilumina seu caminho através das trevas da batalha.',
  icone: '🪓',
  cor: '#8c4a3a',
  dadoDeVida: 'd12',
  dificuldade: 'Fácil',
  papeis: ['Dano', 'Tanque', 'Resistência'],
};

const descricaoBlocos = [
  {
    titulo: null,
    paragrafos: [
      'Um alto humano, coberto em peles e empunhando um machado, avança pela nevasca. Ele ri ao se lançar contra o gigante do gelo que ousou derrubar o alce de seu clã.',
      'Uma meio-orc ruge para o hobgoblin mais próximo, que ousa tentar derrotá-la em combate corpo-a-corpo. Ela o derruba de sua sela, ao fazê-lo tropeçar em meio aos seus companheiros, antes de esmagar seu crânio.',
      'Espumando pela boca, um anão arremessa seu elmo na cara de um drow, vira-se para cravar sua cotoveleira blindada no estômago de outro.',
      'Seja qual for sua procedência, bárbaros são unidos pela sua fúria: uma ferocidade desenfreada, persistente e indiscriminada. Mais do que uma mera emoção, sua raiva é a ferocidade de um predador acuado, o ataque implacável de uma tempestade, a agitação violenta do mar.',
      'Para alguns bárbaros, a fúria surge da comunhão com espíritos animais ferozes. Outros extraem de um reservatório fervilhante de raiva de um mundo cheio de dor. Para cada bárbaro, a fúria é o poder que não apenas alimenta o frenesi de batalha, mas também os reflexos incríveis, a resiliência e as façanhas de força.',
      'Como animais, seus instintos são aguçados, sua fisicalidade é primordial e sua raiva é feroz. Bárbaros se sentem desconfortáveis quando cercados por paredes e multidões. Eles prosperam nas terras selvagens de suas terras natais: a tundra, a selva ou a pradaria onde suas tribos vivem e caçam.',
      'Bárbaros atingem seu potencial em meio ao caos de um combate. Eles podem entrar em estado de fúria onde a raiva assume o controle, dando-lhes força e resiliência sobre-humanas. Um bárbaro pode recorrer a esse reservatório de fúria apenas algumas vezes sem descansar, mas essas poucas fúrias são geralmente suficientes para derrotar qualquer ameaça que surja.',
    ],
  },
  {
    titulo: 'Instinto Primitivo',
    paragrafos: [
      'As pessoas das vilas e cidades se orgulham de como a vida os separa das bestas selvagens, como se a negação da própria natureza fosse um símbolo de superioridade. Para um bárbaro, porém, a civilização não é virtude, mas sinal de fraqueza. Os fortes adotam a natureza selvagem.',
    ],
  },
  {
    titulo: 'Uma Vida de Perigos',
    paragrafos: [
      'Nem todo membro das tribos consideradas "bárbaras" pela sociedade civilizada tem a classe de personagem bárbaro. Um verdadeiro bárbaro entre esses povos é tão incomum quanto um guerreiro hábil em uma cidade, e ele ou ela desempenha um papel semelhante como protetor do povo e líder em tempos de guerra. A vida nas terras selvagens do mundo está repleta de perigos: tribos rivais, clima letal e monstros aterrorizantes. Bárbaros lançam-se sem medo contra tais perigos para que seu povo não precise fazê-lo.',
      'Sua coragem diante do perigo torna bárbaros perfeitamente adequados para aventuras. Vagar é muitas vezes o modo de vida de suas tribos nativas, e a vida sem raízes de um aventureiro é pouco dificultosa para um bárbaro. Algumas tribos têm poucos contatos com estabelecimentos civilizados, mas membros dessas tribos podem ser guias valiosos e ajuda adequada para aventureiros que estão viajando pela natureza selvagem ou pela terra dos bárbaros. Alguns bárbaros, no entanto, estão à vontade na natureza selvagem, mas anseiam pela emoção da civilização.',
    ],
  },
];

const vida = {
  prefixo: 'd',
  numero: '12',
  nivel1: '12 + seu bônus de Salvaguarda de Constituição + 1',
  niveisSuperiores: '12 + seu bônus de Salvaguarda de Constituição por nível de bárbaro após o 1°',
};

const proficiencias = [
  { titulo: 'Testes de Resistência', itens: ['Força', 'Constituição'], estilo: 'selos', icone: markRaw(IconeResistencia) },
  {
    titulo: 'Perícias',
    nota: 'escolha duas',
    itens: ['Adestrar Animais', 'Atletismo', 'Intimidação', 'Natureza', 'Percepção', 'Sobrevivência'],
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
    { opcoes: ['Um machado grande', 'Qualquer arma marcial corpo-a-corpo'] },
    { opcoes: ['Dois machados de mão', 'Qualquer arma simples'] },
    { opcoes: ['Um pacote de aventureiro e quatro azagaias'] },
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
  { nivel: 1, furias: 2, danoFuria: '1d4', caracteristicas: 'Fúria, Defesa sem Armadura, Talento' },
  { nivel: 2, furias: 2, danoFuria: '1d4', caracteristicas: 'Ataque Descuidado, Sentido de Perigo' },
  { nivel: 3, furias: 3, danoFuria: '1d4', caracteristicas: 'Caminho Primitivo' },
  { nivel: 4, furias: 3, danoFuria: '1d4', caracteristicas: '-' },
  { nivel: 5, furias: 3, danoFuria: '1d6', caracteristicas: 'Ataque Extra, Movimento Rápido, Talento' },
  { nivel: 6, furias: 4, danoFuria: '1d6', caracteristicas: 'Característica de Caminho' },
  { nivel: 7, furias: 4, danoFuria: '1d6', caracteristicas: 'Instinto Selvagem' },
  { nivel: 8, furias: 4, danoFuria: '1d6', caracteristicas: '-' },
  { nivel: 9, furias: 4, danoFuria: '1d8', caracteristicas: 'Crítico Brutal (1 dado)' },
  { nivel: 10, furias: 4, danoFuria: '1d8', caracteristicas: 'Característica de Caminho, Talento' },
  { nivel: 11, furias: 4, danoFuria: '1d8', caracteristicas: 'Fúria Implacável' },
  { nivel: 12, furias: 5, danoFuria: '1d8', caracteristicas: '-' },
  { nivel: 13, furias: 5, danoFuria: '1d10', caracteristicas: 'Crítico Brutal (2 dados)' },
  { nivel: 14, furias: 5, danoFuria: '1d10', caracteristicas: 'Característica de Caminho' },
  { nivel: 15, furias: 5, danoFuria: '1d10', caracteristicas: 'Fúria Persistente, Talento' },
  { nivel: 16, furias: 5, danoFuria: '1d10', caracteristicas: '-' },
  { nivel: 17, furias: 6, danoFuria: '1d12', caracteristicas: 'Crítico Brutal (3 dados)' },
  { nivel: 18, furias: 6, danoFuria: '1d12', caracteristicas: 'Força Indomável' },
  { nivel: 19, furias: 6, danoFuria: '1d12', caracteristicas: 'Lendário' },
  { nivel: 20, furias: 'Ilimitado', danoFuria: '1d12', caracteristicas: 'Campeão Primitivo, Talento' },
];

const caracteristicas = [
  {
    nivel: 1,
    titulo: 'Fúria',
    corpo: `Em batalha, você luta com uma ferocidade primitiva. No seu turno, você pode entrar em fúria com uma <span class="dc-termo">ação bônus</span>.
Enquanto estiver em fúria, você recebe os seguintes benefícios se você não estiver vestindo uma armadura pesada:
<ul><li>Você tem <span class="dc-termo">vantagem</span> em testes de Força e testes de resistência de Força.</li><li>Você tem <span class="dc-termo">vantagem</span> em testes de Constituição e testes de resistência de Constituição.</li><li>Quando você desferir um ataque com arma corpo-a-corpo usando Força, você recebe um bônus nas jogadas de dano que aumenta à medida que você adquire níveis de bárbaro, como mostrado na coluna Dano de Fúria na tabela O Bárbaro.</li><li>Você possui resistência contra dano de concussão, cortante e perfurante.</li></ul>
Se você for capaz de conjurar magias, você não poderá conjurá-las ou se concentrar nelas enquanto estiver em fúria.
Sua fúria dura por 1 minuto. Ela termina prematuramente se você cair inconsciente ou se seu turno acabar e você não tiver atacado nenhuma criatura hostil desde seu último turno ou tiver sofrido dano neste período. Você também pode terminar sua fúria no seu turno com uma <span class="dc-termo">ação bônus</span>.
Quando você tiver usado a quantidade de fúrias mostrada para o seu nível de bárbaro na coluna Fúrias da tabela O Bárbaro, você precisará terminar um <span class="dc-termo">descanso longo</span> antes de poder entrar em fúria novamente.`,
  },
  {
    nivel: 1,
    titulo: 'Defesa sem Armadura',
    corpo: 'Quando você não estiver vestindo qualquer armadura, sua Classe de Armadura será 10 + seu modificador de <span class="dc-termo">Destreza</span> + seu modificador de <span class="dc-termo">Constituição</span>. Você pode usar um escudo e continuar a receber esse benefício.',
  },
  {
    nivel: 2,
    titulo: 'Ataque Descuidado',
    corpo: 'A partir do 2° nível, você pode desistir de toda preocupação com sua defesa para atacar com desespero feroz. Quando você fizer uma <span class="dc-termo">ação de ataque</span> no seu turno, você pode decidir atacar descuidadamente. Você pode escolher um valor de até no máximo igual ao seu bônus de proficiência e diminuir a sua CA uma quantidade igual a esse valor e aumentar o acerto de seus ataques neste turno igual a esse valor.',
  },
  {
    nivel: 2,
    titulo: 'Sentido de Perigo',
    corpo: 'No 2° nível, você adquire um sentido sobrenatural de quando as coisas próximas não estão como deveriam, concedendo a você uma chance maior quando estiver evitando perigos. Você possui <span class="dc-termo">vantagem</span> em testes de resistência de <span class="dc-termo">Destreza</span> contra efeitos que você possa ver, como armadilhas e magias. Para receber esse benefício você não pode estar cego, surdo ou incapacitado.',
  },
  {
    nivel: 5,
    titulo: 'Ataque Extra',
    corpo: 'A partir do 5° nível, você pode atacar duas vezes, ao invés de uma, sempre que você realizar a <span class="dc-termo">ação de Ataque</span> no seu turno.',
  },
  {
    nivel: 5,
    titulo: 'Movimento Rápido',
    corpo: 'Começando no 5° nível, seu <span class="dc-termo">deslocamento</span> aumenta em 3 metros enquanto você não estiver vestindo uma armadura pesada.',
  },
  {
    nivel: 7,
    titulo: 'Instinto Selvagem',
    corpo: `No 7° nível, seu instinto está tão apurado que você recebe <span class="dc-termo">vantagem</span> nas jogadas de <span class="dc-termo">iniciativa</span>.
Além disso, se você estiver surpreso no começo de um combate e não estiver incapacitado, você pode agir normalmente no seu primeiro turno, mas apenas se você entrar em fúria antes de realizar qualquer outra coisa neste turno.`,
  },
  {
    nivel: 9,
    titulo: 'Crítico Brutal',
    corpo: `A partir do 9° nível, você pode rolar um dado de dano de arma adicional quando estiver determinando o dano extra de um acerto crítico com uma arma corpo-a-corpo. Além disso sua margem de crítico com ataques que utilizem força se tornam 19-20.
Isso aumenta para dois dados adicionais e a margem de crítico se torna 18-20 no 13° nível e três dados adicionais com margem 17-20 no 17° nível.`,
  },
  {
    nivel: 11,
    titulo: 'Fúria Implacável',
    corpo: `A partir do 11° nível, sua fúria pode manter você lutando independente da gravidade dos seus ferimentos. Se você cair para 0 pontos de vida enquanto estiver em fúria e não morrer, você pode realizar um teste de resistência de <span class="dc-termo">Constituição</span> CD 5. Se você for bem sucedido, você volta para 1 ponto de vida ao invés disso.
Cada vez que você utilizar essa característica após a primeira, a CD aumenta em 1. Assim que você terminar um <span class="dc-termo">descanso curto</span> ou <span class="dc-termo">descanso longo</span> a CD volta para 5.`,
  },
  {
    nivel: 15,
    titulo: 'Fúria Persistente',
    corpo: 'A partir do 15° nível, sua fúria é tão brutal que ela só termina prematuramente se você cair inconsciente ou se você decidir terminá-la.',
  },
  {
    nivel: 18,
    titulo: 'Força Indomável',
    corpo: 'A partir do 18° nível, se o total de um teste de Força seu for menor que o seu valor de Força, você pode usar esse valor no lugar do resultado.',
  },
  {
    nivel: 19,
    titulo: 'Lendário',
    corpo: 'Ao atingir o 19°, você pode escolher um <span class="dc-termo">talento</span> épico.',
  },
  {
    nivel: 20,
    titulo: 'Campeão Primitivo',
    corpo: `No 20° nível, você incorpora os poderes da natureza. Seus valores de <span class="dc-termo">Força</span> e <span class="dc-termo">Constituição</span> aumentam em 4. Seu máximo para esses valores agora é 30.
Além disso, seu máximo de pontos de vida é dobrado.`,
  },
];

const subclasses = [
  {
    nome: 'Caminho do Berserker',
    icone: '🩸',
    introTexto: 'Para alguns bárbaros, a raiva é um meio para atingir um fim — esse fim é a violência. O Caminho do Berserker é um caminho de fúria desenfreada, escorregadio de sangue. Ao entrar na fúria do berserker, você vibra no caos da batalha, sem se importar com sua própria saúde ou bem-estar.',
    caracteristicas: [
      {
        nivel: 3,
        titulo: 'Frenesi',
        corpo: `Começando quando você escolhe esse caminho no 3° nível, sua fúria se torna incontrolavelmente violenta. Quando você realiza uma jogada de ataque corpo-a-corpo enquanto em fúria, você realiza um ataque adicional. Além disso, se você levar uma criatura a 0 de vida, você pode imediatamente andar até o seu máximo de <span class="dc-termo">deslocamento</span> para o mais próximo inimigo e realizar um novo ataque.
Quando sua fúria começar, você sofre um nível de exaustão (conforme descrito no apêndice PH-A). Enquanto em fúria você não recebe nenhum efeito de nível de exaustão.
Além disso, você recupera uma quantidade de pontos de exaustão igual ao seu bônus de proficiência ao final de cada <span class="dc-termo">descanso longo</span>.`,
      },
      {
        nivel: 3,
        titulo: 'Postura Intimidadora',
        corpo: 'Quando você alcança o 3° nível, sua estatura física o ajuda a intimidar os outros. Sempre que você fizer um teste de <span class="dc-termo">Carisma</span> (Intimidação), você ganha um bônus no teste igual ao seu modificador de <span class="dc-termo">Constituição</span> (mínimo de +1). Você também ganha proficiência na perícia de Intimidação. Se você já é proficiente em Intimidação, você adiciona o dobro do seu bônus de proficiência aos testes que fizer com ela.',
      },
      {
        nivel: 6,
        titulo: 'Raiva Estúpida',
        corpo: 'A partir do 6° nível, você não pode ser Encantado ou Amedrontado enquanto está em Fúria. Se você estiver Encantado ou Amedrontado quando você entra em fúria, o efeito é suspenso enquanto durar a fúria.\nAlém disso, enquanto em fúria seus ataques corpo-a-corpo recebem um bônus na jogada de dano igual a (seu nível de exaustão vezes seu bônus de proficiência).',
      },
      {
        nivel: 6,
        titulo: 'Bêbado em Adrenalina',
        corpo: 'A partir do 6° nível, enquanto em fúria seu salto em distância e altura é triplicado, você recebe <span class="dc-termo">deslocamento</span> de escalada e de natação igual ao seu <span class="dc-termo">deslocamento</span> de caminhada e você causa o dobro de dano contra objetos.',
      },
      {
        nivel: 10,
        titulo: 'Presença Intimidante',
        corpo: 'A partir do 10° nível, quando você entra em fúria, seu rugido de guerra faz tremer a alma de seus inimigos. Todas as criaturas à sua escolha a até 18m de você devem ser bem sucedidas em um teste de resistência de <span class="dc-termo">Sabedoria</span> (CD igual a 8 + seu bônus de proficiência + seu modificador de <span class="dc-termo">Constituição</span>) ou ficarem Amedrontadas. Nos turnos subsequentes, uma criatura afetada pode repetir o teste terminando o efeito em um sucesso, tornando-a imune a esse efeito até você inicie outra fúria.',
      },
      {
        nivel: 10,
        titulo: 'Inumano',
        corpo: 'A partir do 10° nível, enquanto em fúria seus músculos se tornam extremamente potentes. Você pode adicionar seu dado de fúria aos testes de Atletismo e Acrobacia. Além disso, você conta como uma categoria de tamanho maior para definir o seu valor máximo de carga e de levantar ou puxar.',
      },
      {
        nivel: 14,
        titulo: 'Retaliação',
        corpo: 'A partir do 14° nível, quando você sofre dano de uma criatura que está em seu alcance de corpo-a-corpo, você pode usar sua reação para realizar uma <span class="dc-termo">ação de ataque</span> corpo-a-corpo com arma contra aquela criatura.',
      },
    ],
  },
  {
    nome: 'Caminho do Guerreiro Totêmico',
    icone: '🐻',
    introTexto: 'Seu é o caminho que busca sintonia com o mundo natural, dando a você afinidade com as bestas. Bárbaros que seguem este caminho caminham lado a lado com os espíritos da natureza, invocando seu poder para transformar-se em feras ferozes.',
    caracteristicas: [
      {
        nivel: 3,
        titulo: 'Elo Espiritual',
        corpo: 'No 3° nível, ao escolher esse caminho, você ganha a habilidade de lançar as magias Sentido da Besta e Falar com Animais, mas apenas como rituais.',
      },
      {
        nivel: 3,
        titulo: 'Totem Espiritual',
        corpo: `No 3° nível, ao escolher esse caminho, você escolhe um totem espiritual e ganha sua característica. Você precisa fabricar ou adquirir um objeto que será seu totem — um amuleto ou acessório similar — que incorpore couro, penas, unhas, dentes ou ossos do seu totem animal. A seu critério, você também ganha atributos físicos que lembram o seu totem espiritual. Por exemplo, se você escolher um urso como totem espiritual, você pode ter pelos em maior volume e pele mais grossa, ou se seu totem espiritual for uma águia, seus olhos tornam-se amarelos e marcantes.
Seu totem espiritual pode ser um animal relacionado aos listados aqui e mais apropriados à sua terra natal. Escolha um dos seguintes totens:`,
        tabela: {
          colunaA: 'Totem',
          colunaB: 'Benefício',
          linhas: [
            { a: 'Urso', b: 'Enquanto estiver em fúria, você tem resistência a todos os tipos de dano, exceto dano psíquico. O espírito do urso faz você resistente o suficiente para permanecer de pé sobre qualquer castigo.' },
            { a: 'Águia', b: 'Enquanto estiver em fúria e não estiver usando armadura pesada, outras criaturas têm <span class="dc-termo">desvantagem</span> para fazer ataques de oportunidade contra você, e você pode usar a ação Corrida como <span class="dc-termo">ação bônus</span> no seu turno. O espírito da águia faz de você o predador que alcança a briga com facilidade.' },
            { a: 'Lobo', b: 'Enquanto estiver em fúria, seus aliados têm <span class="dc-termo">vantagem</span> nas jogadas de ataque corpo-a-corpo contra qualquer criatura hostil a 1,5 metros de você. O espírito do lobo faz de você o líder dos caçadores.' },
          ],
        },
      },
      {
        nivel: 6,
        titulo: 'Aspecto da Besta',
        corpo: 'No 6° nível, você ganha um benefício mágico baseado no totem espiritual de sua escolha. Você pode escolher o mesmo totem espiritual que escolheu no 3° nível ou um diferente.',
        tabela: {
          colunaA: 'Totem',
          colunaB: 'Benefício',
          linhas: [
            { a: 'Urso', b: 'Você ganha o poder do urso. Sua capacidade de carga (incluindo a carga máxima e máximo que pode-se erguer) é dobrada, e você tem <span class="dc-termo">vantagem</span> nos testes de <span class="dc-termo">Força</span> feitos para empurrar, puxar, erguer e quebrar objetos.' },
            { a: 'Águia', b: 'Você ganha a visão aguçada da águia. Você pode ver até 1,5 quilômetros de distância sem dificuldade, podendo diferenciar os menores detalhes como se estivesse olhando para algo a não mais do que 30 metros de você. Além disso, penumbra não impõe <span class="dc-termo">desvantagem</span> nos seus testes de <span class="dc-termo">Sabedoria</span> (Percepção).' },
            { a: 'Lobo', b: 'Você ganha as sensibilidades de caça do lobo. Você pode rastrear outras criaturas enquanto estiver viajando em ritmo acelerado, e você pode mover-se furtivamente enquanto viajar em ritmo normal (veja o capítulo 8 para regras de ritmo de viagem).' },
          ],
        },
      },
      {
        nivel: 10,
        titulo: 'Andarilho Espiritual',
        corpo: 'No 10° nível, você pode lançar a magia comunhão com a natureza, mas apenas como ritual. Quando o fizer a versão espiritual de um dos animais que você escolheu como seu <span class="dc-termo">Totem Espiritual</span> ou <span class="dc-termo">Aspecto da Besta</span> aparece para você para transmitir a informação que você procura.',
      },
      {
        nivel: 14,
        titulo: 'Apoteose Totêmica',
        corpo: 'No 14° nível, você ganha um benefício mágico baseado no totem espiritual de sua escolha. Você pode escolher o mesmo selecionado anteriormente ou um diferente.',
        tabela: {
          colunaA: 'Totem',
          colunaB: 'Benefício',
          linhas: [
            { a: 'Urso', b: 'Enquanto estiver em fúria, qualquer criatura hostil a 1,5 metros de você sofre <span class="dc-termo">desvantagem</span> nas jogadas de ataque contra alvos que não sejam você ou outro personagem com essa característica. Um inimigo é imune a esse efeito se ele não puder ver ou ouvir você ou se ele não puder ser amedrontado.' },
            { a: 'Águia', b: 'Enquanto estiver em fúria, você tem um <span class="dc-termo">deslocamento</span> de voo igual ao seu <span class="dc-termo">deslocamento</span> atual. Esse benefício funciona apenas por pequenos períodos, e você cai no ar se nada mais manter você flutuando.' },
            { a: 'Lobo', b: 'Enquanto estiver em fúria, você ganha uma <span class="dc-termo">ação bônus</span> no seu turno para derrubar uma criatura grande ou menor quando a atingir com um ataque com uma arma corpo a corpo.' },
          ],
        },
      },
    ],
  },
  {
    nome: 'Caminho do Corrupto',
    icone: '😈',
    introTexto: 'Bárbaros que seguem o Caminho do Corrupto foram marcados por forças profanas. Sangue demoníaco corre em suas veias, concedendo poder terrível em troca de dor constante. Estes guerreiros absorveram a essência de criaturas corruptas, dominando-as através de pura força de vontade e transformando maldição em poder.',
    caracteristicas: [
      {
        nivel: 3,
        titulo: 'Resistência Demoníaca',
        corpo: 'A partir do 3° nível você ganha resistência a dano de fogo.',
      },
      {
        nivel: 3,
        titulo: 'Receptáculo de Ódio',
        corpo: 'A partir do 3° nível você foi imbuído por sangue de uma criatura profana e ela tentou dominar seu corpo, mas a sua fúria e determinação se provou mais poderosa que a criatura e você conseguiu absorvê-la e roubar dela certas habilidades. Em contrapartida, graças à resistência do corrupto em não ser absorvido, toda vez que você entra em fúria você perde 1d12 de vida para cada nível de personagem, no final do seu turno. Escolha a natureza da criatura absorvida por você, escolha uma entre:',
        tabela: {
          colunaA: 'Entidade',
          colunaB: 'Benefício',
          linhas: [
            { a: 'O Titã Blindado', b: 'Ao escolher essa opção, você ganha +3 de vida máxima e a cada nível você recebe um bônus de vida igual à metade do seu dano de fúria arredondado para baixo. Durante a fúria a sua fisionomia se altera lhe transformando em uma criatura poderosa e encouraçada. Durante a transformação você ganha um bônus na CA igual ao seu dano de fúria e seu tamanho aumenta como no efeito da magia aumentar/reduzir. Após a fúria acabar você volta a sua forma original.' },
            { a: 'O Inquisitor Terrível', b: 'Você ganha um bônus em testes com <span class="dc-termo">Carisma</span> (Intimidação) e em outra perícia à sua escolha, podendo ser novamente intimidação, igual ao seu dano de fúria de bárbaro. Você não pode ser amedrontado de nenhuma maneira e ganha proficiência em testes de resistência de <span class="dc-termo">Carisma</span>. Durante sua fúria você se transforma em uma forma poderosa e intimidadora de uma criatura corrupta. Durante esse tempo você pode usar sua <span class="dc-termo">ação bônus</span> para tentar amedrontar seu adversário. Escolha um alvo a até 3 metros e faça um teste de intimidação resistido por um teste de resistência de <span class="dc-termo">Sabedoria</span> do alvo. Se o alvo não passar ela toma dano psíquico igual ao dobro do seu dano de fúria e fica amedrontado até o final do próximo turno.' },
            { a: 'O Espírito Vingativo', b: 'Durante a fúria você se transforma em uma criatura corrupta que emana uma aura de violência e raiva. Toda vez que você for alvo de um ataque corpo-a-corpo você pode imediatamente usar sua reação para realizar um ataque corpo-a-corpo contra o atacante. Nesse ataque o seu dano de fúria é triplicado. Se sua criatura tiver causado dano no último turno o seu <span class="dc-termo">Ataque Descuidado</span> pode ser usado no primeiro e segundo ataque contra essa criatura.' },
          ],
        },
      },
      {
        nivel: 6,
        titulo: 'Vínculo Obscuro',
        corpo: 'A partir do 6° nível você pode absorver uma arma corpo-a-corpo ou criar uma utilizando seu sangue impuro. Ao realizar um ritual de sangue de 8h de duração você leva 3d8 de dano necrótico e a arma é vinculada ao seu corpo fazendo com que ela seja agora parte de você. Durante sua fúria você altera a fisionomia do seu corpo, de acordo com a arma absorvida. Seus ataques desarmados dão um bônus igual ao dado de dano da arma. Seus ataques desarmados contam como ataques desarmados mágicos com o propósito de ultrapassar a resistência ou imunidade a ataques e danos não-mágicos. Para trocar de arma você deve realizar um novo ritual com sua nova arma. A arma antiga é expurgada do seu corpo e é destruída se não for mágica.',
      },
      {
        nivel: 6,
        titulo: 'Tributo Ao Sangue',
        corpo: 'A partir do 6° nível sempre que você acertar um ataque desarmado enquanto estiver em fúria em uma criatura que não seja um morto-vivo ou construto você recupera uma quantidade de pontos de vida igual ao seu dano de fúria. A partir do 10° nível quando você estiver com menos da metade do seu máximo de pontos de vida a cura é dobrada.',
      },
      {
        nivel: 10,
        titulo: 'Despertar Dos Vassalos',
        corpo: 'A partir do 10° nível quando estiver em fúria você pode usar sua <span class="dc-termo">ação</span> para dar um enorme rugido demoníaco ordenando que corruptores venham dos planos inferiores servir a seus comandos. Role um d10. O valor é o número de nível de desafio máximo que a soma de todos os níveis de desafio dos corruptores que você invocou pode ter. Como padrão você não pode invocar um corrupto com nível de desafio maior que 4. Os corruptores aparecem em espaços desocupados a até 36 metros de você que você possa ver a sua escolha. Os corruptores jogam imediatamente após o seu turno e obedecem às suas ordens cegamente enquanto você estiver em fúria. Se sua fúria acabar os corruptores se tornam hostis a você. Após usar essa habilidade você não pode usar novamente até realizar um <span class="dc-termo">descanso longo</span>.',
      },
      {
        nivel: 14,
        titulo: 'Gênesis',
        corpo: 'A partir do 14° nível a sua fúria se torna um ímpeto com o poder de um verdadeiro senhor das trevas. O corruptor dentro de você agora o vê como alguém superior e não ousa mais tentar tomar o seu corpo. Você não toma mais dano no começo do turno e também escolhe uma característica superior que você irá absorver. Escolha uma característica que você irá possuir ao entrar em fúria, escolha uma entre:',
        tabela: {
          colunaA: 'Característica',
          colunaB: 'Efeito',
          linhas: [
            { a: 'Impenetrável', b: 'O sangue que corre em suas veias agora é quente e grosso como magma fervente deixando que seu corpo seja uma fortaleza contra a mais poderosa das magias. Você possui <span class="dc-termo">vantagem</span> nos testes de resistência contra magias e outros efeitos mágicos além de resistência a todos os tipos de dano.' },
            { a: 'Aniquilador', b: 'Enquanto estiver em fúria você pode juntar energia caótica de sua ira em sua arma na forma de uma aura vermelha. O seu próximo ataque com a arma profanada irá dar dano extra igual a 4d12 do mesmo tipo de dano de fúria. Você pode usar essa habilidade 4 vezes. Você recupera todos os usos dessa característica após realizar um <span class="dc-termo">descanso longo</span>.' },
            { a: 'Impiedoso', b: 'Durante sua fúria duas asas enormes de couro vermelho e robusto crescem em suas costas, trazendo o caos e a perdição a seus inimigos. Durante esse tempo você recebe <span class="dc-termo">deslocamento</span> de voo igual a duas vezes seu modificador de <span class="dc-termo">Força</span> (atletismo). Você não recebe ataques de oportunidade e se você cair até 30 metros você não leva dano de queda. Se a queda for de 12 metros ou mais você pode usar sua <span class="dc-termo">ação</span> para quando cair bater contra o chão com toda sua fúria e todas as criaturas a até 6 metros de você devem realizar um teste de resistência de <span class="dc-termo">Destreza</span> de CD igual a (8 + seu modificador de <span class="dc-termo">Constituição</span> + sua proficiência). Em uma falha uma criatura recebe um número de d12\'s iguais a duas vezes seu modificador de <span class="dc-termo">Constituição</span>. Em um sucesso uma criatura toma metade desse dano.' },
            { a: 'Devorador', b: 'Enquanto estiver em fúria a fome que corre em seu ser é insaciável e brutal. Você pode usar sua <span class="dc-termo">ação</span> para rugir e devorar a alma dos caídos. Você recebe pontos temporários igual a 5 vezes cada criatura viva pequena ou maior diferente de você a até 9 metros que não esteja com seu máximo de pontos de vida. Se uma criatura morta a pelo menos 1 hora estiver no alcance você recebe 15 pontos de vida temporários a mais para cada uma delas. Você só pode usar essa habilidade uma vez a cada <span class="dc-termo">descanso longo</span>.' },
            { a: 'Imparável', b: 'A energia corruptora em seu corpo se tornou tão poderosa que você se torna imparável mesmo em frente a mazelas enormes. Enquanto você estiver em fúria você recupera 25 de vida no começo de cada turno e sua vida máxima não pode ser diminuída de nenhuma maneira.' },
          ],
        },
      },
    ],
  },
];

// Escolha de subclasse — todo personagem escolhe uma subclasse em algum
// nível, independente da classe; por isso fica junto dos outros pontos
// fixos em Fundamentos da Classe, não na lista de características do
// Bárbaro. As opções vêm do próprio array `subclasses`, pra não duplicar
// nome/ícone em dois lugares.
const subclasseEscolha = {
  titulo: 'Caminho Primitivo',
  corpo: 'No 3° nível, você escolhe um caminho que molda a natureza da sua fúria. Sua escolha lhe concederá características no 3° nível e novamente no 6°, 10° e 14° níveis.',
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

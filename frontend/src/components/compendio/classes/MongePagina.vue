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
        <h2 class="dc-section-title">Progressão — O Monge</h2>
        <span class="dc-title-line"></span>
      </div>
      <div class="dc-tabela-wrap">
        <table class="dc-tabela-niveis">
          <thead>
            <tr>
              <th>Nível</th>
              <th>Características</th>
              <th class="dc-th-centro">Artes Marciais</th>
              <th class="dc-th-centro">Movimento sem Armadura</th>
              <th class="dc-th-centro">Pontos de Ki</th>
            </tr>
          </thead>
          <tbody>
            <tr v-for="n in niveis" :key="n.nivel">
              <td class="dc-tabela-nivel">{{ n.nivel }}º</td>
              <td class="dc-tabela-carac">{{ n.caracteristicas }}</td>
              <td class="dc-tabela-bonus">{{ n.artesMarciais }}</td>
              <td class="dc-tabela-bonus">{{ n.movimento }}</td>
              <td class="dc-tabela-bonus">{{ n.pontosDeKi }}</td>
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
      <p class="dc-fundamentos-nota">Regras comuns a toda classe — não são exclusivas do Monge.</p>

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

        <div class="dc-magias-tabela" v-if="s.magias && s.magias.length">
          <span class="dc-magias-titulo">Magias por Nível</span>
          <div class="dc-tabela-wrap">
            <table class="dc-tabela-niveis">
              <thead>
                <tr>
                  <th>Nível do Monge</th>
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
  nome: 'Monge',
  subtitulo: 'Versão Épico',
  icone: '🥋',
  cor: '#4a8c6a',
  dadoDeVida: 'd8',
  dificuldade: 'Difícil',
  papeis: ['Dano', 'Mobilidade'],
};

const descricaoBlocos = [
  {
    titulo: null,
    paragrafos: [
      'Suas mãos movem-se em um borrão enquanto você desvia um ataque, depois outro, usando a força do atacante contra ele. Você dá um passo para trás e toma ar enquanto o vento afia seu movimento, finalmente o movendo próximo o suficiente para dar uma série rápida de golpes em seu oponente.',
      'Uma halfling cai da fachada de um prédio, dando uma cambalhota no ar enquanto cai, pousando gentilmente e rolando em uma bola antes de se levantar novamente. A flecha que teria a trespassado voa acima dela, arremessada de volta a ela pela força sobrenatural da halfling.',
      'Tocando suavemente na sobrancelha de um humano, um elfo murmura uma prece, mandando um brilho de energia sagrada pelas mãos que cura os mais terríveis ferimentos do humano.',
      'Independente de suas capacidades, os monges são unidos pela habilidade de canalizar magicamente a energia que flui nos seus corpos. Seja essa energia um elemento de misticismo, o ki, é reconhecido por muitas outras tradições filosóficas e marciais, os monges usam essa energia por dentro de si próprios para criar efeitos mágicos e ultrapassar suas capacidades físicas. Alguns de seus ataques especiais podem obstruir o fluxo de ki em seus oponentes. Usando essa energia, monges canalizam uma velocidade e força incomparáveis em seus golpes sem armas.',
    ],
  },
  {
    titulo: 'O Poder do Ki',
    paragrafos: [
      'Monges fazem um cuidadoso estudo de uma energia mágica que muitas tradições monásticas chamam de ki. Essa energia é um elemento do mágico que abastece tanto a magia quanto a vida. Monges controlam esse poder dentro deles permitindo que eles realizem efeitos mágicos e ultrapassem as capacidades físicas dos seus corpos. Alguns de seus ataques especiais podem obstruir o fluxo do ki em seus oponentes. Usando essa energia, monges canalizam uma velocidade e força incomparáveis em seus golpes sem armas. Conforme eles ganham experiência, seus treinamentos nas artes marciais e sua maestria no ki os concedem mais poder sobre seus corpos e corpos de seus inimigos.',
    ],
  },
  {
    titulo: 'Treinamento e Ascese',
    paragrafos: [
      'Pequenos monastérios murados pontilham as paisagens dos mundos de D&D, minúsculos refúgios da pressa da vida comum, onde o tempo parece congelado. Os monges que vivem lá procuram realização pessoal através da contemplação e rigoroso treinamento. Muitos entram no monastério ainda crianças, mandadas para viver lá quando seus pais morreram, quando a comida não era suficiente para sustentá-los, ou em retorno a alguma bondade que o monastério fez pela família.',
      'Alguns monges vivem isoladamente de seus arredores, isolados de qualquer coisa que possa impedir seu progresso espiritual. Outros se juram isoladamente, emergindo apenas para servir de espiões ou assassinos sob o comando de seus líderes, um potentado nobre ou qualquer outro poder mortal ou divino.',
      'A maioria dos monges não evita seus vizinhos, fazendo visitas frequentes a vilas e cidades próximas e trocando seus serviços por comida e outros bens. Como guerreiros versáteis, monges geralmente se veem protegendo seus vizinhos de monstros e tiranos.',
      'Para um monge, tornar-se aventureiro significa deixar um estilo de vida estruturado e comunitário e tornar-se um errante. Isso pode ser uma transição difícil e os monges não a fazem facilmente. Aqueles que deixam seus claustros levam seu trabalho a sério, aproximando suas aventuras como testes pessoais de seu desenvolvimento físico e espiritual. Como regra geral, monges não se importam com riquezas materiais e são levados pela vontade de realizar uma missão maior que a simples matança de monstros e pilhagem de tesouros deles.',
    ],
  },
];

const vida = {
  prefixo: 'd',
  numero: '10',
  nivel1: '10 + seu bônus de Salvaguarda de Constituição + 1',
  niveisSuperiores: '10 + seu bônus de Salvaguarda de Constituição por nível de monge após o 1°',
};

const proficiencias = [
  { titulo: 'Testes de Resistência', itens: ['Destreza', 'Sabedoria'], estilo: 'selos', icone: markRaw(IconeResistencia) },
  {
    titulo: 'Perícias',
    nota: 'escolha duas',
    itens: ['Acrobacia', 'Atletismo', 'Furtividade', 'História', 'Intuição', 'Religião'],
    icone: markRaw(IconePericias),
  },
];

const proficienciasEquipamento = [
  { titulo: 'Armadura', itens: ['Nenhuma'] },
  { titulo: 'Armas', itens: ['Armas simples', 'Espadas curtas'] },
  { titulo: 'Ferramentas', itens: ['Escolha um tipo de ferramenta de artesão ou um instrumento musical'] },
];

const equipamento = {
  intro: 'Você começa com o seguinte equipamento, além do equipamento concedido pelo seu antecedente:',
  itens: [
    { opcoes: ['Uma espada curta', 'Qualquer arma simples'] },
    { opcoes: ['Um pacote de explorador', 'Um pacote de aventureiro'] },
    { opcoes: ['10 dardos'] },
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
  { nivel: 1, artesMarciais: '1d4', movimento: SEM, pontosDeKi: SEM, caracteristicas: 'Defesa sem Armadura, Artes Marciais, Talento' },
  { nivel: 2, artesMarciais: '1d4', movimento: '+4,5m', pontosDeKi: 4, caracteristicas: 'Ki, Movimento sem Armadura' },
  { nivel: 3, artesMarciais: '1d4', movimento: '+6m', pontosDeKi: 6, caracteristicas: 'Tradição Monástica, Defletir Ataques' },
  { nivel: 4, artesMarciais: '1d4', movimento: '+7,5m', pontosDeKi: 8, caracteristicas: 'Descanso Sereno, Queda Lenta' },
  { nivel: 5, artesMarciais: '1d6', movimento: '+9m', pontosDeKi: 10, caracteristicas: 'Ataque Extra, Força Espiritual, Talento' },
  { nivel: 6, artesMarciais: '1d6', movimento: '+10,5m', pontosDeKi: 12, caracteristicas: 'Golpes de Ki, Característica de Tradição' },
  { nivel: 7, artesMarciais: '1d6', movimento: '+12m', pontosDeKi: 14, caracteristicas: 'Evasão' },
  { nivel: 8, artesMarciais: '1d6', movimento: '+13,5m', pontosDeKi: 16, caracteristicas: '-' },
  { nivel: 9, artesMarciais: '1d8', movimento: '+15m', pontosDeKi: 18, caracteristicas: 'Alma de Diamante' },
  { nivel: 10, artesMarciais: '1d8', movimento: '+16,5m', pontosDeKi: 20, caracteristicas: 'Pureza Corporal, Talento' },
  { nivel: 11, artesMarciais: '1d8', movimento: '+18m', pontosDeKi: 22, caracteristicas: 'Característica de Tradição' },
  { nivel: 12, artesMarciais: '1d8', movimento: '+19,5m', pontosDeKi: 24, caracteristicas: 'Resiliência' },
  { nivel: 13, artesMarciais: '1d10', movimento: '+21m', pontosDeKi: 26, caracteristicas: 'Idiomas do Sol e da Lua, Técnicas de Ki Aprimoradas' },
  { nivel: 14, artesMarciais: '1d10', movimento: '+22,5m', pontosDeKi: 28, caracteristicas: 'Mente Tranquila' },
  { nivel: 15, artesMarciais: '1d10', movimento: '+24m', pontosDeKi: 30, caracteristicas: 'Corpo Atemporal, Talento' },
  { nivel: 16, artesMarciais: '1d10', movimento: '+25,5m', pontosDeKi: 32, caracteristicas: 'Ressonância de Ki' },
  { nivel: 17, artesMarciais: '1d12', movimento: '+27m', pontosDeKi: 34, caracteristicas: 'Característica de Tradição' },
  { nivel: 18, artesMarciais: '1d12', movimento: '+28,5m', pontosDeKi: 36, caracteristicas: 'Corpo Vazio' },
  { nivel: 19, artesMarciais: '1d12', movimento: '+30m', pontosDeKi: 38, caracteristicas: 'Lendário' },
  { nivel: 20, artesMarciais: '1d12', movimento: '+31,5m', pontosDeKi: 40, caracteristicas: 'Auto Aperfeiçoamento, Ataque Extra (3), Talento' },
];

const caracteristicas = [
  {
    nivel: 1,
    titulo: 'Defesa sem Armadura',
    corpo: 'A partir do 1° nível, quando você não estiver vestindo nenhuma armadura nem empunhando um escudo, sua Classe de Armadura será 10 + seu modificador de <span class="dc-termo">Destreza</span> + seu modificador de <span class="dc-termo">Sabedoria</span>.',
  },
  {
    nivel: 1,
    titulo: 'Artes Marciais',
    corpo: `No 1° nível, sua prática nas artes marciais concede a você maestria nos estilos de combate que utilizam golpes desarmados e armas de monge, que são as espadas curtas e quaisquer armas simples corpo-a-corpo que não tenham a propriedade de duas mãos ou pesada.
Você ganha os seguintes benefícios enquanto estiver desarmado ou empunhando uma arma de monge e não estiver vestindo nenhuma armadura ou empunhando um escudo:
<ul><li>Você pode usar <span class="dc-termo">Destreza</span> ao invés de <span class="dc-termo">Força</span> para as jogadas de ataque e dano dos seus golpes desarmados e de suas armas de monge.</li><li>Você pode rolar um d4 no lugar do dano normal dos seus golpes desarmados e armas de monge. Esse dado muda à medida que você adquire níveis de monge, como mostrado na coluna Artes Marciais na tabela O Monge.</li><li>Quando você usa a <span class="dc-termo">ação de ataque</span> com um golpe desarmado ou uma arma de monge no seu turno, você pode realizar um golpe desarmado com uma <span class="dc-termo">ação bônus</span>.</li></ul>
Determinados monastérios usam formas especializadas de armas de monge. Por exemplo, você pode usar uma clava feita por dois pedaços de madeira conectados por uma pequena corrente (chamado de nunchaku) ou uma foice com uma estranha lâmina fina (chamada de kama). Qualquer que seja o nome que você use para uma arma de monge, você pode usar as estatísticas de jogo mostradas para as armas no capítulo 5.`,
  },
  {
    nivel: 2,
    titulo: 'Ki',
    corpo: `A partir do 2° nível, seu treinamento permitiu que você controlasse a energia mística do ki. Seu acesso a essa energia é representado por um número de pontos de ki. Seu nível de monge determina o número de pontos que você tem, como mostrado na coluna Pontos de Ki na tabela O Monge (2 vezes seu nível de monge).
Você pode gastar esses pontos para abastecer várias características de ki. Você começa conhecendo três dessas características: <span class="dc-termo">Rajada de Golpes</span>, <span class="dc-termo">Defesa Paciente</span> e <span class="dc-termo">Passo do Vento</span>. Você aprende mais características de ki à medida que adquire níveis nessa classe.
Quando você gasta um ponto de ki, ele se torna indisponível até você terminar um <span class="dc-termo">descanso curto</span> ou <span class="dc-termo">descanso longo</span>, no fim deste, todos os pontos de ki gastos voltam para você. Você deve gastar, pelo menos, 30 minutos do <span class="dc-termo">descanso curto</span> meditando para recuperar seus pontos de ki.
Algumas das características de ki requerem que seu alvo realize um teste de resistência para resistir ao efeito da característica. O CD do teste de resistência é calculado a seguir:
<strong>CD de resistência de Ki</strong> = 8 + bônus de proficiência + seu modificador de <span class="dc-termo">Destreza</span>`,
  },
  {
    nivel: 2,
    titulo: 'Rajada de Golpes',
    corpo: 'Imediatamente após você realizar a <span class="dc-termo">ação de ataque</span> no seu turno, você pode gastar 1 ponto de ki para realizar dois golpes desarmados com uma <span class="dc-termo">ação bônus</span>.',
  },
  {
    nivel: 2,
    titulo: 'Defesa Paciente',
    corpo: 'Você pode gastar 1 ponto de ki para realizar a <span class="dc-termo">ação</span> de Esquivar, com uma <span class="dc-termo">ação bônus</span>, no seu turno.',
  },
  {
    nivel: 2,
    titulo: 'Passo do Vento',
    corpo: 'Você pode gastar 1 ponto de ki para realizar a <span class="dc-termo">ação de Desengajar</span> ou <span class="dc-termo">ação de Disparada</span>, com uma <span class="dc-termo">ação bônus</span>, no seu turno, e sua distância de salto é dobrada nesse turno.',
  },
  {
    nivel: 2,
    titulo: 'Movimento sem Armadura',
    corpo: 'A partir do 2° nível, seu <span class="dc-termo">deslocamento</span> aumenta em 3 metros enquanto você não estiver usando armadura nem empunhando um escudo. Esse bônus aumenta quando você alcançar determinados níveis, como mostrado na tabela O Monge (1,5 metro por nível). No 9° nível, você ganha a habilidade de se mover através de superfícies verticais e sobre líquidos, no seu turno, sem cair durante o movimento.',
  },
  {
    nivel: 3,
    titulo: 'Defletir Ataques',
    corpo: `No 3° nível, você pode usar sua reação para desviar ou receber um golpe quando for atingido por um ataque. Quando você faz isso, qualquer dano de concussão, perfurante ou cortante que você sofrer no ataque é reduzido em 1d10 + seu modificador de <span class="dc-termo">Destreza</span> + seu nível de monge.
Se você reduzir o dano de concussão, perfurante ou cortante para 0, como parte da mesma reação você pode gastar 1 ponto de ki para fazer um ataque desarmado contra a criatura se ela estiver dentro do alcance.
Se o ataque foi um ataque de projétil à distância, você pode lançar o projétil de volta na criatura se o projétil for pequeno o suficiente para você segurá-lo com uma mão e você tiver pelo menos uma mão livre. Você pega um projétil dessa maneira, você pode gastar 1 ponto de ki para fazer um ataque à distância com alcance de 9/18 metros usando uma arma ou munição que acabou de pegar, como parte da mesma reação. Você faz este ataque com proficiência, independente de sua proficiência com armas, e o projétil conta como uma arma de monge para o ataque.`,
  },
  {
    nivel: 4,
    titulo: 'Descanso Sereno',
    corpo: 'A partir do 4° nível, o fluxo constante de ki por todo o corpo ajuda a repará-lo quando ferido. Quando você recupera pontos de vida de qualquer fonte, inclusive usando dados de vida, você recupera um número de pontos de vida adicionais igual ao seu modificador de <span class="dc-termo">Sabedoria</span>.',
  },
  {
    nivel: 4,
    titulo: 'Queda Lenta',
    corpo: 'Começando no 4° nível, você pode usar sua reação, quando você cai, para reduzir o dano de queda sofrido por um valor igual a dez vezes seu nível de monge.',
  },
  {
    nivel: 5,
    titulo: 'Ataque Extra',
    corpo: 'A partir do 5° nível, você pode atacar duas vezes, ao invés de uma, quando usar a <span class="dc-termo">ação de ataque</span> durante seu turno. O número de ataques aumenta para três quando alcançar o 11° nível de Monge e para quatro quando alcançar o 20° nível de Monge.',
  },
  {
    nivel: 5,
    titulo: 'Força Espiritual',
    corpo: 'A partir do 5° nível, você é capaz de enriquecer seu corpo com seu ki aumentando suas capacidades físicas. Você pode adicionar seu modificador de <span class="dc-termo">Sabedoria</span> a seus testes de Atletismo e Acrobacia se possuir pelo menos um ponto de ki.',
  },
  {
    nivel: 6,
    titulo: 'Golpes de Ki',
    corpo: 'A partir do 6° nível, enquanto você possuir pelo menos 1 ponto de Ki, seus golpes desarmados contam como armas mágicas com o propósito de ultrapassar a resistência ou imunidade a ataques e danos não-mágicos.\nAlém disso, você recebe um bônus em suas jogadas de acerto e dano com seus ataques desarmados igual a +1. Esse bônus aumenta para +2 no 9° nível, +3 no 12° nível, +4 no 15° nível e +5 no 18° nível.',
  },
  {
    nivel: 7,
    titulo: 'Evasão',
    corpo: 'A partir do 7° nível, você pode esquivar-se agilmente de certos efeitos em área, como o sopro elétrico de um dragão azul ou uma magia bola de fogo. Quando você for alvo de um efeito que exige um teste de resistência de <span class="dc-termo">Destreza</span> para sofrer metade do dano, você não sofre dano algum se passar, e somente metade do dano se falhar.\nAlém disso, você recebe um bônus em CA igual a +1. Esse bônus aumenta para +2 no 10° nível, +3 no 13° nível, +4 no 16° nível e +5 no 19° nível.',
  },
  {
    nivel: 9,
    titulo: 'Alma de Diamante',
    corpo: 'A partir do 9° nível, sua maestria do ki concede a você proficiência em todos os testes de resistência. Além disso, toda vez que realizar um teste de resistência e falhar, você pode gastar 1 ponto de ki para jogar novamente e ficar com o segundo resultado.',
  },
  {
    nivel: 10,
    titulo: 'Pureza Corporal',
    corpo: 'No 10° nível, sua maestria do ki flui através de você, tornando-o imune a doenças, dano de veneno e a condição Envenenado.',
  },
  {
    nivel: 12,
    titulo: 'Resiliência',
    corpo: 'No 12° nível, quando você rola a <span class="dc-termo">iniciativa</span>, você recupera 8 pontos de ki.',
  },
  {
    nivel: 13,
    titulo: 'Idiomas do Sol e da Lua',
    corpo: 'A partir do 13° nível, você aprende a tocar o ki de outras mentes fazendo com que você compreenda todos os idiomas falados. Além do mais, qualquer criatura que possa entender um idioma poderá entender o que você fala.',
  },
  {
    nivel: 13,
    titulo: 'Técnicas de Ki Aprimoradas',
    corpo: `A partir do 13° nível, suas técnicas básicas de Ki se tornam mais poderosas.
<strong>Rajada de Golpes.</strong> Agora pode desferir 3 ataques.
<strong>Defesa Paciente.</strong> Agora você pode utilizar a <span class="dc-termo">ação</span> de esquiva e desengajar.
<strong>Passo do Vento.</strong> Agora você pode dar a <span class="dc-termo">ação de Desengajar</span> e <span class="dc-termo">ação de Disparada</span> com um único uso.`,
  },
  {
    nivel: 14,
    titulo: 'Mente Tranquila',
    corpo: 'A partir do 14° nível, se você possuir pelo menos 1 ponto de Ki, você pode ler a vibração de todos os ki à sua volta, dando sempre conhecimento dos arredores. Você possui visão às cegas até 72 metros.',
  },
  {
    nivel: 15,
    titulo: 'Corpo Atemporal',
    corpo: 'No 15° nível, seu ki sustenta você tanto que você não sofre os efeitos da velhice e não pode envelhecer magicamente. Você ainda morrerá de velhice, no entanto seu tempo de vida ficará 10 vezes maior. Além disso, você não precisa mais de comida ou água.',
  },
  {
    nivel: 16,
    titulo: 'Ressonância de Ki',
    corpo: 'No 16° nível, seus ataques desarmados causam uma onda de ki que emenda o corpo de seu alvo fazendo com que seu ki vibre causando uma perturbação em seu espírito. Quando você atingir uma criatura com seu ataque desarmado e ela estiver se concentrando, ela deve ser bem sucedida em um teste de resistência de <span class="dc-termo">Constituição</span> contra o seu CD de ki ou perderá a concentração. Além disso, seus ataques ignoram pontos de vida temporários e habilidades ou magias que substituem os pontos de vida da criatura, como no efeito da magia metamorfose ou habilidade forma selvagem do druida.',
  },
  {
    nivel: 18,
    titulo: 'Corpo Vazio',
    corpo: 'A partir do 18° nível, você se torna imune a magias da escola de encantamento.\nAlém disso, você pode gastar 8 pontos de ki para conjurar a magia projeção astral, sem precisar de componentes materiais. Quando o fizer, você não pode levar qualquer outra criatura com você.',
  },
  {
    nivel: 19,
    titulo: 'Lendário',
    corpo: 'Ao atingir o 19°, você pode escolher um <span class="dc-termo">talento</span> épico.',
  },
  {
    nivel: 20,
    titulo: 'Auto Aperfeiçoamento',
    corpo: 'No 20° nível, seu domínio do ki permite que você execute técnicas básicas sem esforço. A <span class="dc-termo">Rajada de Golpes</span>, a <span class="dc-termo">Defesa Paciente</span> e o <span class="dc-termo">Passo do Vento</span> agora custam zero de ki para serem usados.\nAlém disso, seus valores de <span class="dc-termo">Destreza</span> e <span class="dc-termo">Sabedoria</span> aumentam em 4. Seu máximo para esses valores agora é 30.',
  },
];

const subclasses = [
  {
    nome: 'Caminho da Mão Aberta',
    icone: '🖐️',
    introTexto: 'Os monges do Caminho da Mão Aberta são os mestres supremos do combate das artes marciais, armados ou desarmados. Eles aprendem técnicas para empurrar e derrubar seus oponentes, manipular o ki para curar danos em seus corpos e praticar meditações avançadas que podem protegê-los de danos.',
    caracteristicas: [
      {
        nivel: 3,
        titulo: 'Técnica da Mão Aberta',
        corpo: `Começando quando você escolhe essa tradição no 3° nível, você pode manipular o ki do seu inimigo quando canaliza o seu próprio. Sempre que acertar uma criatura com um dos ataques concedidos pela sua <span class="dc-termo">Rajada de Golpes</span>, você pode impor um dos seguintes efeitos nesse alvo:
<ul><li>Ela deve ter sucesso em um teste de resistência de <span class="dc-termo">Destreza</span> ou ser derrubada.</li><li>Ela deve fazer um teste de resistência de <span class="dc-termo">Força</span>. Se falhar, você pode empurrá-la até 4,5 metros de distância de você.</li><li>Ela não pode realizar reações até o final do seu próximo turno.</li></ul>`,
      },
      {
        nivel: 6,
        titulo: 'Totalidade do Corpo',
        corpo: 'No 6° nível, você ganha a habilidade de se curar. Como uma <span class="dc-termo">ação bônus</span>, você pode recuperar pontos de vida iguais a três vezes o seu nível de monge. Você deve terminar um <span class="dc-termo">descanso longo</span> antes de poder usar esse recurso novamente.',
      },
      {
        nivel: 11,
        titulo: 'Tranquilidade',
        corpo: 'Começando no 11° nível, você pode entrar em uma meditação especial que o cerca com uma aura de paz. No final de um <span class="dc-termo">descanso longo</span>, você ganha o efeito de um feitiço Santuário que dura até o início do seu próximo <span class="dc-termo">descanso longo</span> (o feitiço pode terminar mais cedo como normalmente). O CD do teste de resistência para o feitiço é igual a 8 + o seu modificador de <span class="dc-termo">Sabedoria</span> + o seu bônus de proficiência.',
      },
      {
        nivel: 17,
        titulo: 'Palma Trêmula',
        corpo: `No 17° nível, você ganha a habilidade de gerar vibrações letais no corpo de alguém. Quando acertar uma criatura com um ataque desarmado, você pode gastar 3 pontos de ki para começar essas vibrações imperceptíveis, que duram um número de dias igual ao seu nível de monge. As vibrações são inofensivas a menos que você use sua <span class="dc-termo">ação</span> para encerrá-las. Para fazer isso, você e o alvo devem estar no mesmo plano de existência. Quando você usa essa <span class="dc-termo">ação</span>, a criatura deve fazer um teste de resistência de <span class="dc-termo">Constituição</span>. Se falhar, é reduzida a 0 pontos de vida. Se passar, sofre 10d10 de dano necrótico.
Você só pode ter uma criatura sob o efeito desse recurso por vez. Você pode optar por encerrar as vibrações inofensivamente sem usar uma <span class="dc-termo">ação</span>.`,
      },
    ],
  },
  {
    nome: 'Caminho do Kensei',
    icone: '🗡️',
    introTexto: 'Os monges do Caminho do Kensei treinam incansavelmente com suas armas, a ponto de a arma se tornar como uma extensão do próprio corpo. Fundada na maestria da luta com espadas, a tradição se expandiu para incluir muitas armas diferentes. Um kensei vê uma arma da mesma maneira que um calígrafo ou pintor vê uma caneta ou pincel. Independentemente da arma, o kensei a enxerga como uma ferramenta usada para expressar a beleza e a precisão das artes marciais. Que essa maestria faça de um kensei um guerreiro sem igual é apenas um efeito colateral de intensa devoção, prática e estudo.',
    magias: [
      { nivel: '3º', magia: 'Golpe de Zephyr' },
      { nivel: '5º', magia: 'Tornado de Lâminas de Irís' },
      { nivel: '9º', magia: 'Canção do Dragão de Tulipa' },
      { nivel: '13º', magia: 'Bradação Guerreira de Renan' },
      { nivel: '17º', magia: 'Ataque do Vento de Aço' },
    ],
    caracteristicas: [
      {
        nivel: 3,
        titulo: 'Caminho do Kensei',
        corpo: `Quando você escolhe esta tradição no 3° nível, seu treinamento especial de artes marciais o leva a dominar o uso de certas armas. Este caminho também inclui instrução nos traços habilidosos da caligrafia ou da pintura. Você ganha os seguintes benefícios:
<strong>Armas do Kensei.</strong> Escolha dois tipos de armas para serem suas armas do kensei. Cada uma dessas armas pode ser qualquer arma simples ou marcial que não tenha as propriedades pesada e especial. O arco longo também é uma escolha válida. Você ganha proficiência com essas armas se ainda não as tiver. As armas dos tipos escolhidos são armas do monge para você e recebem todos os benefícios que seus golpes desarmados possuem. Muitos dos recursos desta tradição funcionam apenas com suas armas do kensei. Quando alcançar o 6°, 11° e 17° nível nesta classe, você pode escolher outro tipo de arma — seja corpo a corpo ou de alcance — para ser uma arma de kensei para você, seguindo os critérios acima.
<strong>Defesa Kensei.</strong> Se você acertar um ataque contra uma criatura com sua arma kensei, você ganha um bônus igual a seu bônus de proficiência na sua CA até o início do seu próximo turno contra a criatura que você atingiu, enquanto uma arma estiver em sua mão e você não estiver incapacitado.
<strong>Golpe Certeiro.</strong> Criaturas que forem atingidas por 2 ataques, desde que pelo menos um dos ataques tenha sido feito pela sua arma kensei no mesmo turno, não podem realizar ações bônus ou reação até o começo do seu próximo turno.
<strong>Caminho do Pincel.</strong> Você ganha proficiência, à sua escolha, com suprimentos de caligrafia ou suprimentos de pintura.
<strong>Magias Kensei.</strong> Enquanto estiver com sua arma Kensei você pode conjurar feitiços. Você pode gastar um número de pontos de ki igual ao dobro do nível do feitiço para conjurar os feitiços nos níveis indicados na tabela acima. Criaturas atingidas por suas magias Kensei sofrem efeitos adicionais como se tivessem sido atingidas por um ataque com arma Kensei.`,
      },
      {
        nivel: 6,
        titulo: 'Potência Kensei',
        corpo: `No 6° nível, você estende seu ki para suas armas do kensei, concedendo os seguintes benefícios:
<strong>Armas do Kensei Mágicas.</strong> Seus ataques com suas armas do kensei contam como mágicos para superar resistência e imunidade a ataques e danos não mágicos.
<strong>Retribuição.</strong> Quando uma criatura sob o efeito de sua <span class="dc-termo">Defesa Kensei</span> errar um ataque contra você, você pode com sua reação realizar um ataque desarmado contra ela.
<strong>Ritmo Kensei.</strong> Quando acertar uma criatura com um ataque com sua arma Kensei você recebe um bônus em suas próximas jogadas de ataque contra a criatura igual a +1 até o começo do seu próximo turno.`,
      },
      {
        nivel: 11,
        titulo: 'Artista Kensei',
        corpo: 'No 11° nível, sua percepção de tempo e ritmo em combate se tornaram tão aprimoradas que nenhum movimento é desperdiçado. Quando você realizar a <span class="dc-termo">ação de ataque</span> você pode abdicar de 2 de seus ataques para conjurar uma magia Kensei.',
      },
      {
        nivel: 17,
        titulo: 'Zona Kensei',
        corpo: `No 17° nível, você pode gastar 5 pontos de Ki e entrar em um estado de foco absoluto. Durante 1 minuto todas as suas jogadas de dano com suas armas Kensei e magias Kensei causam dano maximizado. Você precisa se concentrar nessa habilidade como se estivesse se concentrando em uma magia.
Quando você realizar uma jogada de ataque com uma arma Kensei contra uma criatura e errar, você pode refazer a jogada de ataque. Você pode usar esse recurso uma vez por ataque.`,
      },
    ],
  },
  {
    nome: 'Caminho dos Punhos de Ferro',
    icone: '👊',
    introTexto: 'Monges que seguem o Caminho dos Punhos de Ferro aperfeiçoam a arte do combate corpo a corpo brutal, transformando seus punhos em armas devastadoras. Eles aprendem técnicas de boxeadores lendários, combinando jogo de pés excepcional com golpes demolidores.',
    caracteristicas: [
      {
        nivel: 3,
        titulo: 'Espírito de Lutador',
        corpo: 'No 3° nível você aprende a causar golpes devastadores em seus punhos ao mesmo tempo que adquire mais vigor na batalha quando os acerta. Com uma <span class="dc-termo">ação bônus</span> você pode gastar 3 pontos de ki para entrar em uma postura de combate que dura por um minuto. Durante esse tempo você causa um dano extra em seus ataques desarmados igual ao seu modificador de <span class="dc-termo">Sabedoria</span>.\nAlém disso, no final de cada um de seus turnos durante a postura você adquire pontos de vida temporários equivalente ao seu bônus de proficiência para cada golpe que você acertou.',
      },
      {
        nivel: 6,
        titulo: 'Jogo de Pés',
        corpo: `No 6° nível você pode realizar certas manobras com seus pés para melhorar sua postura e ajudar em seu engajamento no combate. Você só pode usar uma manobra por turno.
<strong>Peek-a-Boo.</strong> Você pode gastar metade do seu <span class="dc-termo">deslocamento</span> para realizar uma manobra de pés, confundindo seus inimigos e ajudando a se esquivar de ataques. Até o início do seu próximo turno você ganha um bônus na CA igual ao seu bônus de proficiência. Você pode gastar 2 pontos de Ki e aumentar a CA em 1, e mais 1 para cada 2 pontos de ki adicional.
<strong>Recuou.</strong> Você pode gastar metade do seu <span class="dc-termo">deslocamento</span> para que seu próximo movimento não cause ataques de oportunidade.
<strong>Upper.</strong> Você pode gastar metade do seu <span class="dc-termo">deslocamento</span> para realizar um impulso curto mas poderoso fazendo com que seu próximo ataque tenha um bônus na jogada de dano igual a 1 dado de golpe desarmado. Você pode gastar 2 pontos de ki para aumentar a quantidade de dados em 1, e mais 1 para cada 2 pontos de ki gasto.`,
      },
      {
        nivel: 11,
        titulo: 'Base Forte',
        corpo: 'Ao atingir o 11° nível quando você precisar realizar um teste de Resistência de <span class="dc-termo">Força</span> você pode, como uma reação (desde que você esteja sobre uma superfície que possa disponibilizar uma base sólida), gastar 2 pontos de ki para assumir uma postura de âncora. Você ganha um bônus nesse teste igual ao seu modificador de <span class="dc-termo">Sabedoria</span>.\nAlém disso, sempre que você atingir uma criatura que esteja a 1,5 metro de você sobre a condição atordoada, irá contar como um acerto crítico.',
      },
      {
        nivel: 17,
        titulo: 'Linha de Risco',
        corpo: 'Ao 17° nível você aprende a utilizar a força do adversário contra ele mesmo, arriscando sua própria segurança para realizar um contra-ataque devastador. Quando uma criatura realizar um ataque corpo-a-corpo contra você e errar, você pode com uma reação gastar 3 pontos de ki e ter resistência a todos os danos desse ataque e logo em seguida realizar um ataque contra a criatura que o atingiu. Esse ataque possui um bônus no dano igual a 5 vezes o modificador de <span class="dc-termo">Força</span> ou <span class="dc-termo">Destreza</span> (dependendo da natureza do atacante) da criatura que o atacou.',
      },
    ],
  },
  {
    nome: 'Caminho do Mestre Bêbado',
    icone: '🍶',
    introTexto: 'O Estilo do Mestre Bêbado ensina seus estudantes a se movimentarem com os movimentos bruscos e imprevisíveis de um bêbado. Um mestre bêbado balança, oscilando com pés instáveis, para parecer um combatente incompetente que se revela frustrante de engajar. As oscilações erráticas do mestre bêbado escondem uma dança cuidadosamente executada de bloqueios, paradas, avanços, ataques e recuos. Um mestre bêbado muitas vezes gosta de se fazer de tolo para trazer alegria aos desanimados ou para demonstrar humildade aos arrogantes, mas quando a batalha começa, o mestre bêbado pode ser um adversário enlouquecedor e habilidoso.',
    caracteristicas: [
      {
        nivel: 3,
        titulo: 'Bônus de Proficiência',
        corpo: 'Quando você escolhe essa tradição no 3° nível, você ganha proficiência na perícia de Atuação se ainda não a possuir. Sua técnica de artes marciais mistura treinamento de combate com a precisão de um dançarino e as palhaçadas de um bobo da corte. Você também ganha proficiência com suprimentos de cervejeiro se ainda não a possuir.',
      },
      {
        nivel: 3,
        titulo: 'Técnica Bêbada',
        corpo: 'No 3° nível, você aprende a girar e se movimentar rapidamente como parte do seu <span class="dc-termo">Torrente de Golpes</span>. Sempre que usar <span class="dc-termo">Torrente de Golpes</span>, você ganha o benefício da <span class="dc-termo">ação de Desengajar</span>, e seu <span class="dc-termo">deslocamento</span> de caminhada aumenta em 6 metros até o final do turno atual.',
      },
      {
        nivel: 6,
        titulo: 'Balanço Embriagado',
        corpo: `Começando no 6° nível, você pode se mover de maneira repentina e oscilante. Você ganha os seguintes benefícios:
<strong>Levantar Rapidamente.</strong> Quando estiver caído, você pode se levantar sem gastar nenhum <span class="dc-termo">deslocamento</span> extra.
<strong>Combatente Dorminhoco.</strong> Quando estiver caído, você não sofre <span class="dc-termo">desvantagem</span> para atacar criaturas e criaturas não possuem <span class="dc-termo">desvantagem</span> em atacar você.
<strong>Redirecionar Ataque.</strong> Quando uma criatura errar um ataque corpo a corpo contra você, você pode gastar 1 ponto de ki como reação para fazer esse ataque acertar uma criatura à sua escolha, que não seja o atacante, e que você possa ver dentro de 1,5 metro de você.`,
      },
      {
        nivel: 11,
        titulo: 'Sorte do Bêbado',
        corpo: 'A partir do 11° nível, você sempre parece ter um golpe de sorte no momento certo. Quando fizer um teste de habilidade, um teste de ataque ou um teste de resistência e tiver <span class="dc-termo">desvantagem</span>, você pode gastar 2 pontos de ki para cancelar a <span class="dc-termo">desvantagem</span> para esse teste.',
      },
      {
        nivel: 17,
        titulo: 'Frenesi Intoxicado',
        corpo: 'No 17° nível, você ganha a habilidade de realizar um número avassalador de ataques contra um grupo de inimigos. Quando usar o seu <span class="dc-termo">Torrente de Golpes</span>, você pode fazer até três ataques adicionais com ele (até um total de cinco ataques do <span class="dc-termo">Torrente de Golpes</span>), desde que cada ataque do <span class="dc-termo">Torrente de Golpes</span> atinja uma criatura diferente neste turno.',
      },
    ],
  },
];

// Escolha de subclasse — todo personagem escolhe uma subclasse em algum
// nível, independente da classe; por isso fica junto dos outros pontos
// fixos em Fundamentos da Classe, não na lista de características do
// Monge. As opções vêm do próprio array `subclasses`, pra não duplicar
// nome/ícone em dois lugares.
const subclasseEscolha = {
  titulo: 'Tradição Monástica',
  corpo: 'No 3° nível, você ingressa numa tradição monástica. Sua escolha lhe concede características no 3° nível e novamente no 6°, 11° e 17° nível.',
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

import { ref, reactive, computed, inject, provide } from 'vue';
import { useRoute, useRouter } from 'vue-router';
import personagemService from '../services/personagemService';
import { racaService } from '../services/racaService';
import classeService from '../services/classeService';
import talentoService from '../services/talentoService';

export const FICHA_KEY = Symbol('ficha-personagem');

// "name" é a chave persistida em ficha.pericias (não mexer, já tem fichas salvas com ela);
// "label" é só o texto exibido, com acentuação correta.
export const SKILLS = [
{ name: 'Acrobacia', label: 'Acrobacia', attr: 'destreza' },
{ name: 'Arcanismo', label: 'Arcanismo', attr: 'inteligencia' },
{ name: 'Atletismo', label: 'Atletismo', attr: 'forca' },
{ name: 'Atuacao', label: 'Atuação', attr: 'carisma' },
{ name: 'Blefar', label: 'Blefar', attr: 'carisma' },
{ name: 'Briga', label: 'Briga', attr: 'forca' },
{ name: 'Brutalidade', label: 'Brutalidade', attr: 'forca' },
{ name: 'Furtividade', label: 'Furtividade', attr: 'destreza' },
{ name: 'Historia', label: 'História', attr: 'inteligencia' },
{ name: 'Intimidacao', label: 'Intimidação', attr: 'carisma' },
{ name: 'Intuicao', label: 'Intuição', attr: 'sabedoria' },
{ name: 'Investigacao', label: 'Investigação', attr: 'inteligencia' },
{ name: 'Lidar com Animais', label: 'Lidar com Animais', attr: 'sabedoria' },
{ name: 'Medicina', label: 'Medicina', attr: 'sabedoria' },
{ name: 'Natureza', label: 'Natureza', attr: 'inteligencia' },
{ name: 'Percepcao', label: 'Percepção', attr: 'sabedoria' },
{ name: 'Persuasao', label: 'Persuasão', attr: 'carisma' },
{ name: 'Prestidigitacao', label: 'Prestidigitação', attr: 'destreza' },
{ name: 'Religiao', label: 'Religião', attr: 'inteligencia' },
{ name: 'Resiliencia', label: 'Resiliência', attr: 'constituicao' },
{ name: 'Sobrevivencia', label: 'Sobrevivência', attr: 'sabedoria' },
{ name: 'Vigor', label: 'Vigor', attr: 'constituicao' },
];

const TIPOS_HABILIDADE = { passiva: 'Passiva', uso_unico: 'Uso único', multiplos_usos: 'Múltiplos usos' };

export const ATRIBUTOS = [
{ chave: 'forca', sigla: 'FOR', nome: 'Força' },
{ chave: 'destreza', sigla: 'DES', nome: 'Destreza' },
{ chave: 'constituicao', sigla: 'CON', nome: 'Constituição' },
{ chave: 'inteligencia', sigla: 'INT', nome: 'Inteligência' },
{ chave: 'sabedoria', sigla: 'SAB', nome: 'Sabedoria' },
{ chave: 'carisma', sigla: 'CAR', nome: 'Carisma' },
];

export const TABS = [
{ id: 'acoes', label: 'Ações' },
{ id: 'caracteristicas', label: 'Características' },
{ id: 'habilidades', label: 'Habilidades' },
{ id: 'magias', label: 'Magias' },
{ id: 'mochila', label: 'Mochila' },
{ id: 'lore', label: 'Lore' },
];

export const MOEDAS = [
{ chave: 'PC', label: 'PC', campo: 'moedaPc', glifo: 'Ω' },
{ chave: 'PP', label: 'PP', campo: 'moedaPp', glifo: 'Σ' },
{ chave: 'PE', label: 'PE', campo: 'moedaPe', glifo: 'E' },
{ chave: 'PO', label: 'PO', campo: 'moedaPo', glifo: 'Λ' },
{ chave: 'PL', label: 'PL', campo: 'moedaPl', glifo: 'Λ' },
];

export const TIPOS_DADO = ['d4', 'd6', 'd8', 'd10', 'd12', 'd20'];

export const TIPOS_DANO = [
'Ácido', 'Concussão', 'Cortante', 'Eletricidade', 'Energia', 'Fogo', 'Frio',
'Necrótico', 'Perfurante', 'Psíquico', 'Radiante', 'Trovejante', 'Veneno',
];

/**
* Cria todo o estado + lógica da ficha e o disponibiliza via provide().
* Chamado UMA VEZ no componente raiz (views/FichaPersonagem.vue).
*/
export function criarFichaPersonagem() {
const route = useRoute();
const router = useRouter();

const ficha = ref(null);
const mostrarSalvo = ref(false);
const novaTag = ref('');
const ajustePv = ref(null);
let timerSalvar = null;

// Tesouro em blocos — persistido em ficha.tesouro.
const tesouro = computed(() => ficha.value?.tesouro || []);

// Salvaguardas (proficiência por atributo) — cada atributo tem seu próprio
// campo boolean direto em Personagem (salvaguardaForca, salvaguardaDestreza...).
const CAMPO_SALVAGUARDA = {
  forca: 'salvaguardaForca',
  destreza: 'salvaguardaDestreza',
  constituicao: 'salvaguardaConstituicao',
  inteligencia: 'salvaguardaInteligencia',
  sabedoria: 'salvaguardaSabedoria',
  carisma: 'salvaguardaCarisma',
};

// Raças, classes e talentos do compêndio real — carregados do backend em carregar().
const racasDisponiveis = ref([]);
const classesDisponiveis = ref([]);
const talentosDisponiveis = ref([]);
const talentoSelecionado = ref('');
const erroTalento = ref(null);

// Ficha completa da raça selecionada (com os atributos), pra somar o bônus
// racial no cálculo dos atributos — carregada em carregar() e toda vez que a
// raça muda.
const racaDetalhe = ref(null);

async function carregarRacaDetalhe() {
  if (!ficha.value.racaId) {
    racaDetalhe.value = null;
    return;
  }
  racaDetalhe.value = await racaService.buscarPorId(ficha.value.racaId);
}

async function selecionarRaca() {
  await carregarRacaDetalhe();
  agendarSalvar();
}

// Compara idade/altura/peso digitados na aba Lore com os valores de
// referência da raça escolhida (vindos do compêndio) e devolve uma
// mensagem interpretativa pro jogador. Altura do personagem é digitada em
// cm; a da raça vem em metros do compêndio, por isso a conversão *100.
function categoriaIdade(idade, idadeRaca) {
  const { idadeAdulta, expectativaVida } = idadeRaca;
  if (idade < idadeAdulta * 0.3) return 'uma criança';
  if (idade < idadeAdulta) return 'jovem';
  if (idade < expectativaVida * 0.75) return 'um(a) adulto(a)';
  return 'idoso(a)';
}

const mensagemIdade = computed(() => {
  const idade = Number(ficha.value?.detalheIdade);
  const idadeRaca = racaDetalhe.value?.idade;
  if (!idade || !idadeRaca) return '';
  return `Você é ${categoriaIdade(idade, idadeRaca)} para sua raça.`;
});

const mensagemAltura = computed(() => {
  const alturaCm = Number(ficha.value?.detalheAltura);
  const alturaRaca = racaDetalhe.value?.altura;
  if (!alturaCm || !alturaRaca) return '';
  if (alturaCm < alturaRaca.valorMenor * 100) return 'Você é baixo(a) para sua raça.';
  if (alturaCm > alturaRaca.valorMaior * 100) return 'Você é alto(a) para sua raça.';
  return 'Sua altura é típica para sua raça.';
});

const mensagemPeso = computed(() => {
  const peso = Number(ficha.value?.detalhePeso);
  const pesoRaca = racaDetalhe.value?.peso;
  if (!peso || !pesoRaca) return '';
  if (peso < pesoRaca.valorMenor) return 'Você é leve para sua raça.';
  if (peso > pesoRaca.valorMaior) return 'Você é pesado(a) para sua raça.';
  return 'Seu peso é típico para sua raça.';
});

// Habilidades especiais da raça selecionada — vêm direto do compêndio (via
// racaDetalhe), então trocam automaticamente sempre que a raça muda. Não são
// editáveis aqui: a fonte da verdade é o compêndio de raças.
const habilidadesRaca = computed(() => racaDetalhe.value?.habilidadesEspeciais || []);

function tipoHabilidadeLabel(codigo) {
  return TIPOS_HABILIDADE[codigo] || codigo;
}

async function adicionarTalentoNaFicha() {
  erroTalento.value = null;
  if (!talentoSelecionado.value) return;
  try {
    ficha.value = await personagemService.adicionarTalento(route.params.id, Number(talentoSelecionado.value));
    talentoSelecionado.value = '';
  } catch (e) {
    erroTalento.value = e.response?.data || 'Não foi possível adicionar o talento.';
  }
}

async function removerTalentoDaFicha(talentoId) {
  ficha.value = await personagemService.removerTalento(route.params.id, talentoId);
}

// ===== Bônus de atributo (raça + talento), aplicados matematicamente =====
// Escolha de atributo pra bônus "à escolha" (de raça ou de talento) —
// provisório, ainda só neste navegador (TODO backend: guardar a escolha de
// fato). "tipo" ('raca' ou 'talento') + "id" evitam colisão de chave entre
// os atributos de raça e os de cada talento.
const escolhasAtributo = reactive({});
const editandoEscolha = reactive({});

function chaveEscolha(tipo, id, atributoIndex, n) {
  return `${tipo}-${id}-${atributoIndex}-${n}`;
}

function atributosFixos(atributos) {
  return (atributos || []).filter((a) => a.atributo);
}

function atributosEscolha(atributos) {
  return (atributos || []).filter((a) => !a.atributo);
}

function atributoNome(chave) {
  return ATRIBUTOS.find((a) => a.chave === chave)?.nome || chave;
}

function opcoesParaSlot(tipo, id, atributoIndex, quantidadeEscolhas, nAtual) {
  const escolhidos = [];
  for (let n = 1; n <= quantidadeEscolhas; n++) {
    if (n === nAtual) continue;
    const v = escolhasAtributo[chaveEscolha(tipo, id, atributoIndex, n)];
    if (v) escolhidos.push(v);
  }
  return ATRIBUTOS.filter((attr) => !escolhidos.includes(attr.chave));
}

function slotsEscolhidos(tipo, id, atributoIndex, quantidadeEscolhas) {
  const out = [];
  for (let n = 1; n <= quantidadeEscolhas; n++) {
    const chave = chaveEscolha(tipo, id, atributoIndex, n);
    if (escolhasAtributo[chave] && !editandoEscolha[chave]) out.push(n);
  }
  return out;
}

function slotsPendentes(tipo, id, atributoIndex, quantidadeEscolhas) {
  const out = [];
  for (let n = 1; n <= quantidadeEscolhas; n++) {
    const chave = chaveEscolha(tipo, id, atributoIndex, n);
    if (!escolhasAtributo[chave] || editandoEscolha[chave]) out.push(n);
  }
  return out;
}

// Soma os bônus de uma lista de AtributoDto (fixo ou à escolha) que batem
// com o atributo pedido.
function somarBonusAtributos(lista, tipo, id, chaveAtributo) {
  let total = 0;
  (lista || []).forEach((a, ai) => {
    if (a.atributo === chaveAtributo) {
      total += a.valor;
    } else if (!a.atributo) {
      for (let n = 1; n <= a.quantidadeEscolhas; n++) {
        if (escolhasAtributo[chaveEscolha(tipo, id, ai, n)] === chaveAtributo) {
          total += a.valor;
        }
      }
    }
  });
  return total;
}

function bonusRacaAtributo(chaveAtributo) {
  if (!racaDetalhe.value) return 0;
  return somarBonusAtributos(racaDetalhe.value.atributos, 'raca', racaDetalhe.value.id, chaveAtributo);
}

function bonusTalentoAtributo(chaveAtributo) {
  if (!ficha.value?.talentos) return 0;
  return ficha.value.talentos.reduce(
      (total, t) => total + somarBonusAtributos(t.atributos, 'talento', t.talentoId, chaveAtributo),
      0
  );
}

// Valor final do atributo: base + bônus de raça + bônus de talento, nunca
// menor que 0.
function valorTotalAtributo(chaveAtributo) {
  const base = ficha.value[chaveAtributo] || 0;
  return Math.max(0, base + bonusRacaAtributo(chaveAtributo) + bonusTalentoAtributo(chaveAtributo));
}

// Sincronização de itens mágicos — "sincronizado" fica direto em cada item
// (PersonagemItemMagico/ItemMagicoDto); o limite é validado só no front.
const limiteSincronizados = computed({
  get: () => ficha.value?.limiteSincronizados ?? 3,
  set: (v) => {
    ficha.value.limiteSincronizados = v;
    agendarSalvar();
  },
});

// Slots de magia por nível — persistidos em ficha.slotsMagia (lista de
// {nivel, total, restantes}). Tempo de conjuração/descrição de cada magia
// ficam direto em cada PersonagemMagia (m.tempoConjuracao / m.descricao).
function slotDe(nivel) {
  let s = ficha.value.slotsMagia.find((x) => x.nivel === nivel);
  if (!s) {
    s = { nivel, total: 0, restantes: 0 };
    ficha.value.slotsMagia.push(s);
  }
  return s;
}

// Bônus de proficiência: persistido em ficha.bonusProficiencia.
const bonusProficiencia = computed({
  get: () => ficha.value?.bonusProficiencia ?? 2,
  set: (v) => {
    ficha.value.bonusProficiencia = v;
    agendarSalvar();
  },
});

// Peças de armadura (CA) e modificadores de iniciativa — listas persistidas
// em ficha.armaduraPecas / ficha.iniciativaModificadores; o que também
// persiste em ficha.ca / ficha.iniciativaBonus é o total somado (mantido
// sincronizado por sincronizarCa()/sincronizarIniciativa()).
const armaduraPecas = computed(() => ficha.value?.armaduraPecas || []);
const iniciativaModificadores = computed(() => ficha.value?.iniciativaModificadores || []);

const caTotal = computed(() =>
    armaduraPecas.value.reduce((soma, p) => soma + (Number(p.bonus) || 0), 0)
);

// Base da iniciativa é sempre a salvaguarda de Destreza (mesma lógica de
// proficiência/atributo já usada nos cards de atributo) — os modificadores da
// lista abaixo só somam em cima dela.
const iniciativaBase = computed(() => valorSalvaguarda({ chave: 'destreza' }));
const iniciativaTotal = computed(() =>
    iniciativaBase.value + iniciativaModificadores.value.reduce((soma, m) => soma + (Number(m.bonus) || 0), 0)
);

// Bônus de magia: sempre atributo + proficiência (conjuração é sempre
// proficiente, diferente do bônus de ataque comum), mais um extra manual
// (item mágico, talento etc.) que soma tanto no ataque quanto na CD.
const bonusMagiaBase = computed(() => {
  if (!ficha.value || !ficha.value.atributoMagia) return 0;
  return modificador(valorTotalAtributo(ficha.value.atributoMagia)) + bonusProficiencia.value;
});
const bonusMagiaTotal = computed(() => bonusMagiaBase.value + (Number(ficha.value?.bonusMagiaExtra) || 0));
const cdMagiaTotal = computed(() => 8 + bonusMagiaTotal.value);

function adicionarArmadura() {
  ficha.value.armaduraPecas.push({ nome: '', bonus: 0 });
  sincronizarCa();
}

function removerArmadura(indice) {
  ficha.value.armaduraPecas.splice(indice, 1);
  sincronizarCa();
}

function sincronizarCa() {
  ficha.value.ca = caTotal.value;
  agendarSalvar();
}

// Componentes de vida máxima (dado de vida, Constituição, talentos etc.) —
// lista persistida em ficha.pvMaximoComponentes; ficha.pvMaximo guarda o
// total somado, mantido em sincronizarPvMaximo().
const pvMaximoComponentes = computed(() => ficha.value?.pvMaximoComponentes || []);

const pvMaximoTotal = computed(() =>
    pvMaximoComponentes.value.reduce((soma, c) => soma + (Number(c.bonus) || 0), 0)
);

function adicionarComponentePv() {
  ficha.value.pvMaximoComponentes.push({ nome: '', bonus: 0 });
  sincronizarPvMaximo();
}

function removerComponentePv(indice) {
  ficha.value.pvMaximoComponentes.splice(indice, 1);
  sincronizarPvMaximo();
}

function sincronizarPvMaximo() {
  ficha.value.pvMaximo = pvMaximoTotal.value;
  agendarSalvar();
}

function adicionarModificadorIniciativa() {
  ficha.value.iniciativaModificadores.push({ nome: '', bonus: 0 });
  sincronizarIniciativa();
}

function removerModificadorIniciativa(indice) {
  ficha.value.iniciativaModificadores.splice(indice, 1);
  sincronizarIniciativa();
}

function sincronizarIniciativa() {
  ficha.value.iniciativaBonus = iniciativaTotal.value;
  agendarSalvar();
}

const pvPct = computed(() => {
if (!ficha.value || !ficha.value.pvMaximo) return 0;
return Math.max(0, Math.min(100, Math.round((ficha.value.pvAtual / ficha.value.pvMaximo) * 100)));
});

const somaTesouro = computed(() =>
tesouro.value.reduce((soma, b) => soma + b.quantidade * (b.valorUnitario || 0), 0)
);

function modificador(valorAtributo) {
return Math.floor((valorAtributo - 10) / 2);
}

function formatarMod(valor) {
return valor >= 0 ? `+${valor}` : `${valor}`;
}

function attrAbrev(attr) {
return ATRIBUTOS.find((a) => a.chave === attr)?.sigla || attr;
}

function salvaguardaDe(chave) {
const campo = CAMPO_SALVAGUARDA[chave];
return {
  atributo: chave,
  get proficiente() { return !!ficha.value[campo]; },
  set proficiente(v) { ficha.value[campo] = v; },
};
}

function valorSalvaguarda(attr) {
const s = salvaguardaDe(attr.chave);
const mod = modificador(valorTotalAtributo(attr.chave));
return s.proficiente ? mod + bonusProficiencia.value : mod;
}

function alternarSalvaguarda(chave, valor) {
ficha.value[CAMPO_SALVAGUARDA[chave]] = valor;
agendarSalvar();
}

function contarSincronizados() {
return (ficha.value?.itensMagicos || []).filter((i) => i.sincronizado).length;
}

function alternarSincronizado(indice) {
const item = ficha.value.itensMagicos[indice];
if (!item.sincronizado && contarSincronizados() >= limiteSincronizados.value) {
alert(`Limite de ${limiteSincronizados.value} itens sincronizados atingido.`);
return;
}
item.sincronizado = !item.sincronizado;
agendarSalvar();
}

function adicionarTesouro() {
ficha.value.tesouro.push({
quantidade: 1,
nome: '',
descricao: '',
valorUnitario: 0,
});
agendarSalvar();
}

function removerTesouro(indice) {
ficha.value.tesouro.splice(indice, 1);
agendarSalvar();
}

function periciaDe(nome) {
let p = ficha.value.pericias.find((x) => x.pericia === nome);
if (!p) {
p = { pericia: nome, proficiente: false, expertise: false };
ficha.value.pericias.push(p);
}
return p;
}

function valorPericia(skill) {
const p = periciaDe(skill.name);
const mod = modificador(valorTotalAtributo(skill.attr));
let bonus = 0;
if (p.expertise) bonus = bonusProficiencia.value * 2;
else if (p.proficiente) bonus = bonusProficiencia.value;
return mod + bonus;
}

function valorPericiaPorNome(nome) {
const skill = SKILLS.find((s) => s.name === nome);
return skill ? valorPericia(skill) : 0;
}

function estadoPericia(nome) {
const p = periciaDe(nome);
if (p.expertise) return 'fc-skill-toggle-exp';
if (p.proficiente) return 'fc-skill-toggle-prof';
return 'fc-skill-toggle-vazio';
}

// Toggle circular de 3 estados: sem proficiência → proficiente → especialista → sem proficiência...
function alternarEstadoPericia(nome) {
const p = periciaDe(nome);
if (!p.proficiente && !p.expertise) {
p.proficiente = true;
} else if (p.proficiente && !p.expertise) {
p.expertise = true;
} else {
p.proficiente = false;
p.expertise = false;
}
agendarSalvar();
}

function alterar(campo, delta, minimo = 0) {
ficha.value[campo] = Math.max(minimo, (ficha.value[campo] || 0) + delta);
agendarSalvar();
}

function alterarAtributo(chave, delta) {
ficha.value[chave] = Math.max(0, Math.min(30, ficha.value[chave] + delta));
agendarSalvar();
}

// Atributos não podem ficar negativos — usado no @input do número digitado
// à mão (o stepper já usa alterarAtributo, que aplica o mesmo piso).
function clamparAtributo(chave) {
ficha.value[chave] = Math.max(0, Math.min(30, ficha.value[chave] || 0));
agendarSalvar();
}

function aplicarDano() {
if (!ajustePv.value) return;
let dano = ajustePv.value;
if (ficha.value.pvTemporario > 0) {
const absorvido = Math.min(ficha.value.pvTemporario, dano);
ficha.value.pvTemporario -= absorvido;
dano -= absorvido;
}
if (dano > 0) {
ficha.value.pvAtual = Math.max(0, ficha.value.pvAtual - dano);
}
ajustePv.value = null;
agendarSalvar();
}

function aplicarVidaTemp() {
if (!ajustePv.value) return;
ficha.value.pvTemporario = Math.max(ficha.value.pvTemporario || 0, ajustePv.value);
ajustePv.value = null;
agendarSalvar();
}

function aplicarCura() {
if (!ajustePv.value) return;
ficha.value.pvAtual = Math.min(ficha.value.pvMaximo, ficha.value.pvAtual + ajustePv.value);
ajustePv.value = null;
agendarSalvar();
}

function alternarBooleano(campo) {
ficha.value[campo] = !ficha.value[campo];
agendarSalvar();
}

function removerItem(lista, indice) {
lista.splice(indice, 1);
agendarSalvar();
}

function adicionarAtaque() {
ficha.value.ataques.push({
nome: '', bonusAtributo: null, bonusProficiente: false, bonusExtra: 0,
danos: [{ quantidade: 1, dado: 'd6', bonus: 0, tipoDano: null }], descricao: '',
});
}

function acertoAtaqueTotal(a) {
let total = Number(a.bonusExtra) || 0;
if (a.bonusAtributo) total += modificador(valorTotalAtributo(a.bonusAtributo));
if (a.bonusProficiente) total += bonusProficiencia.value;
return total;
}

function danoTexto(d) {
const qtd = d.quantidade || 1;
const dado = d.dado || 'd6';
const bonus = Number(d.bonus) || 0;
if (!bonus) return `${qtd}${dado}`;
return `${qtd}${dado}${bonus > 0 ? '+' : ''}${bonus}`;
}

function danoAtaqueResumo(a) {
if (!a.danos || !a.danos.length) return '—';
return a.danos.map(danoTexto).join(' + ');
}

function adicionarDano(a) {
a.danos.push({ quantidade: 1, dado: 'd6', bonus: 0, tipoDano: null });
agendarSalvar();
}

function removerDano(a, indice) {
a.danos.splice(indice, 1);
agendarSalvar();
}

function adicionarInventario() {
ficha.value.inventario.push({ nome: '', quantidade: 1, peso: null, descricao: '' });
}

function adicionarItemMagico() {
ficha.value.itensMagicos.push({ nome: '', descricao: '', sincronizado: false });
agendarSalvar();
}

function removerItemMagico(indice) {
ficha.value.itensMagicos.splice(indice, 1);
agendarSalvar();
}

function adicionarHabilidade() {
ficha.value.habilidades.push({ nome: '', descricao: '' });
}

function adicionarUnidade() {
ficha.value.unidades.push({ nome: '', tipo: '', dadosExtraJson: null });
}

function adicionarTag(tipo) {
if (!novaTag.value.trim()) return;
ficha.value.tags.push({ tipo, texto: novaTag.value.trim() });
novaTag.value = '';
agendarSalvar();
}

function magiasPorNivel(nivel) {
return ficha.value.magias.filter((m) => m.nivel === nivel);
}

function adicionarMagia(nivel) {
ficha.value.magias.push({ nivel, nome: '', preparada: false, tempoConjuracao: '', descricao: '' });
agendarSalvar();
}

function removerMagia(magia) {
const idx = ficha.value.magias.indexOf(magia);
if (idx >= 0) removerItem(ficha.value.magias, idx);
}

function agendarSalvar() {
clearTimeout(timerSalvar);
timerSalvar = setTimeout(salvarAgora, 1200);
}

async function salvarAgora() {
const atualizado = await personagemService.atualizar(route.params.id, ficha.value);
ficha.value = atualizado;
mostrarSalvo.value = true;
setTimeout(() => (mostrarSalvo.value = false), 1500);
}

async function excluir() {
if (!confirm('Excluir esse personagem? Essa ação não pode ser desfeita.')) return;
await personagemService.remover(route.params.id);
router.push('/personagens');
}

async function selecionarImagem(evento) {
const arquivo = evento.target.files[0];
if (!arquivo) return;
if (arquivo.size > 2 * 1024 * 1024) {
alert('Imagem muito grande (máximo 2MB). Escolha uma imagem menor.');
evento.target.value = '';
return;
}
try {
const { url } = await personagemService.enviarImagem(route.params.id, arquivo);
ficha.value.imagemUrl = url;
} catch (e) {
alert(e.response?.data || 'Não foi possível enviar a imagem.');
} finally {
evento.target.value = '';
}
}

function removerImagem() {
ficha.value.imagemUrl = null;
agendarSalvar();
}

function exportarJSON() {
const conteudo = JSON.stringify(ficha.value, null, 2);
const blob = new Blob([conteudo], { type: 'application/json' });
const url = URL.createObjectURL(blob);
const a = document.createElement('a');
a.href = url;
a.download = `${ficha.value.nome || 'personagem'}.json`;
a.click();
URL.revokeObjectURL(url);
}

function importarJSON(evento) {
const arquivo = evento.target.files[0];
if (!arquivo) return;
const leitor = new FileReader();
leitor.onload = async () => {
try {
const dados = JSON.parse(leitor.result);
// Mantém o id/dono atuais — só substitui o conteúdo editável da ficha.
const { id, usuarioId, criadoEm, atualizadoEm, ...resto } = dados;
Object.assign(ficha.value, resto);
await salvarAgora();
alert('Ficha importada e salva com sucesso.');
} catch (e) {
alert('Arquivo JSON inválido.');
} finally {
evento.target.value = '';
}
};
leitor.readAsText(arquivo);
}

async function carregar() {
ficha.value = await personagemService.buscar(route.params.id);
racasDisponiveis.value = await racaService.listar();
classesDisponiveis.value = await classeService.listar();
talentosDisponiveis.value = await talentoService.listar();
await carregarRacaDetalhe();
// Realinha o total de iniciativa exibido/salvo com a base + modificadores
// carregados (não agenda salvar, só corrige um eventual total desatualizado).
ficha.value.iniciativaBonus = iniciativaTotal.value;
}

const contexto = {
// estado
ficha, mostrarSalvo, novaTag, ajustePv, bonusProficiencia,
tesouro, habilidadesRaca, limiteSincronizados,
racasDisponiveis, classesDisponiveis, talentosDisponiveis, talentoSelecionado, erroTalento,
racaDetalhe, escolhasAtributo, editandoEscolha,
armaduraPecas, iniciativaModificadores, pvMaximoComponentes,
// computed
pvPct, somaTesouro, caTotal, iniciativaTotal, iniciativaBase, pvMaximoTotal,
bonusMagiaBase, bonusMagiaTotal, cdMagiaTotal,
mensagemIdade, mensagemAltura, mensagemPeso,
// constantes
SKILLS, ATRIBUTOS, TABS, MOEDAS, TIPOS_DADO, TIPOS_DANO,
// funções
modificador, formatarMod, attrAbrev,
adicionarTalentoNaFicha, removerTalentoDaFicha, selecionarRaca,
atributosFixos, atributosEscolha, atributoNome, tipoHabilidadeLabel,
chaveEscolha, opcoesParaSlot, slotsEscolhidos, slotsPendentes,
bonusRacaAtributo, bonusTalentoAtributo, valorTotalAtributo,
adicionarArmadura, removerArmadura, sincronizarCa,
adicionarComponentePv, removerComponentePv, sincronizarPvMaximo,
adicionarModificadorIniciativa, removerModificadorIniciativa, sincronizarIniciativa,
salvaguardaDe, valorSalvaguarda, alternarSalvaguarda,
contarSincronizados, alternarSincronizado,
adicionarTesouro, removerTesouro,
periciaDe, valorPericia, valorPericiaPorNome, estadoPericia, alternarEstadoPericia,
alterar, alterarAtributo, clamparAtributo,
aplicarDano, aplicarVidaTemp, aplicarCura,
alternarBooleano, removerItem,
adicionarAtaque, acertoAtaqueTotal, danoTexto, danoAtaqueResumo, adicionarDano, removerDano, adicionarInventario,
adicionarItemMagico, removerItemMagico,
adicionarHabilidade, adicionarUnidade, adicionarTag,
magiasPorNivel, slotDe, adicionarMagia, removerMagia,
agendarSalvar, salvarAgora, excluir,
selecionarImagem, removerImagem,
exportarJSON, importarJSON,
carregar,
route, router,
};

provide(FICHA_KEY, contexto);
return contexto;
}

/**
* Usado dentro de cada componente de aba/sidebar para acessar o estado
* criado em criarFichaPersonagem().
*/
export function useFichaPersonagem() {
const contexto = inject(FICHA_KEY);
if (!contexto) {
throw new Error('useFichaPersonagem() precisa ser usado dentro de uma árvore onde criarFichaPersonagem() foi chamado.');
}
return contexto;
}
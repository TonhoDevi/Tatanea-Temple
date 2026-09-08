import { ref, computed, inject, provide } from 'vue';
import { useRoute, useRouter } from 'vue-router';
import personagemService from '../services/personagemService';

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

// Listas provisórias para os dropdowns de raça/classe (pode substituir por dados do backend/compêndio depois).
export const OPCOES_RACA = ['Anão', 'Draconato', 'Elfo', 'Gnomo', 'Halfling', 'Humano', 'Meio-Elfo', 'Meio-Orc', 'Tiefling'];
export const OPCOES_CLASSE = ['Bárbaro', 'Bardo', 'Bruxo', 'Clérigo', 'Druida', 'Feiticeiro', 'Guerreiro', 'Ladino', 'Mago', 'Monge', 'Paladino', 'Caçador'];

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

// Detalhes físicos e personalidade (aba Lore) — provisório, só no estado local.
// TODO backend: criar campos "idade"/"altura"/"peso"/"caracteristicasFisicas" e
// "tracos"/"ideais"/"vinculos"/"defeitos" em Personagem/PersonagemRequestDto/
// PersonagemDetalheDto pra essas duas seções deixarem de ser locais.
const detalhesFisicos = ref({ idade: '', altura: '', peso: '', caracteristicas: '' });
const personalidade = ref({ tracos: '', ideais: '', vinculos: '', defeitos: '' });

// Tesouro em blocos — provisório, só no estado local (ainda não existe no backend).
const tesouro = ref([]);
let proximoIdTesouro = 1;

// Salvaguardas (proficiência por atributo) — provisório, só no estado local.
// TODO backend: criar campo real (ex: lista de atributos proficientes em salvaguarda)
// em Personagem/PersonagemRequestDto/PersonagemDetalheDto pra isso deixar de ser local.
const salvaguardas = ref([]);

// Habilidades de raça e talentos — provisório, só no estado local (ainda não existe no backend).
// "Habilidades de classe" continua usando ficha.habilidades, que já é salvo hoje.
// TODO backend: criar listas próprias (ex: PersonagemHabilidadeRaca, PersonagemTalento) pra
// essas duas deixarem de ser locais.
const habilidadesRaca = ref([]);
const talentos = ref([]);

// Sincronização de itens mágicos — provisório, só no estado local (ainda não existe no
// backend). itemMagicoSync fica paralelo a ficha.itensMagicos (mesmo índice).
// TODO backend: criar campo "sincronizado" em PersonagemItemMagico/ItemMagicoDto e uma
// regra de limite (hoje só validada no front) pra isso deixar de ser local.
const itemMagicoSync = ref([]);
const limiteSincronizados = ref(3);

// Slots de magia por nível e dados extras de cada magia (tempo de conjuração,
// descrição) — provisório, só no estado local (ainda não existem no backend).
// TODO backend: criar campos "tempoConjuracao"/"descricao" em PersonagemMagia/
// MagiaDto e um registro de slots por nível pra isso deixar de ser local.
const slotsMagia = ref({});
const magiaExtras = ref([]);

// Bônus de proficiência: começa calculado a partir do nível, mas fica editável
// manualmente (deixa de acompanhar o nível assim que a pessoa mexer no número).
const bonusProficiencia = ref(2);

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
let s = salvaguardas.value.find((x) => x.atributo === chave);
if (!s) {
s = { atributo: chave, proficiente: false };
salvaguardas.value.push(s);
}
return s;
}

function valorSalvaguarda(attr) {
const s = salvaguardaDe(attr.chave);
const mod = modificador(ficha.value[attr.chave]);
return s.proficiente ? mod + bonusProficiencia.value : mod;
}

function alternarSalvaguarda(chave, valor) {
salvaguardaDe(chave).proficiente = valor;
}

function contarSincronizados() {
return itemMagicoSync.value.filter(Boolean).length;
}

function alternarSincronizado(indice) {
const estaSincronizado = itemMagicoSync.value[indice];
if (!estaSincronizado && contarSincronizados() >= limiteSincronizados.value) {
alert(`Limite de ${limiteSincronizados.value} itens sincronizados atingido.`);
return;
}
itemMagicoSync.value[indice] = !estaSincronizado;
}

function adicionarTesouro() {
tesouro.value.push({
id: proximoIdTesouro++,
quantidade: 1,
nome: '',
descricao: '',
valorUnitario: 0,
});
}

function removerTesouro(indice) {
tesouro.value.splice(indice, 1);
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
const mod = modificador(ficha.value[skill.attr]);
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
ficha.value[chave] = Math.max(1, Math.min(30, ficha.value[chave] + delta));
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
ficha.value.ataques.push({ nome: '', bonusAtaque: '', dano: '', tipoDano: '' });
}

function adicionarInventario() {
ficha.value.inventario.push({ nome: '', quantidade: 1, peso: null, descricao: '' });
}

function adicionarItemMagico() {
ficha.value.itensMagicos.push({ nome: '', descricao: '' });
itemMagicoSync.value.push(false);
}

function removerItemMagico(indice) {
ficha.value.itensMagicos.splice(indice, 1);
itemMagicoSync.value.splice(indice, 1);
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

function slotDe(nivel) {
if (!slotsMagia.value[nivel]) slotsMagia.value[nivel] = { total: 0, restantes: 0 };
return slotsMagia.value[nivel];
}

function extraDe(magia) {
const idx = ficha.value.magias.indexOf(magia);
if (!magiaExtras.value[idx]) magiaExtras.value[idx] = { tempoConjuracao: '', descricao: '' };
return magiaExtras.value[idx];
}

function adicionarMagia(nivel) {
ficha.value.magias.push({ nivel, nome: '', preparada: false });
magiaExtras.value.push({ tempoConjuracao: '', descricao: '' });
}

function removerMagia(magia) {
const idx = ficha.value.magias.indexOf(magia);
if (idx >= 0) {
removerItem(ficha.value.magias, idx);
magiaExtras.value.splice(idx, 1);
}
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
itemMagicoSync.value = ficha.value.itensMagicos.map(() => false);
magiaExtras.value = ficha.value.magias.map(() => ({ tempoConjuracao: '', descricao: '' }));
bonusProficiencia.value = Math.floor((ficha.value.nivel - 1) / 4) + 2;
}

const contexto = {
// estado
ficha, mostrarSalvo, novaTag, ajustePv, bonusProficiencia,
detalhesFisicos, personalidade, tesouro, salvaguardas,
habilidadesRaca, talentos, itemMagicoSync, limiteSincronizados,
slotsMagia, magiaExtras,
// computed
pvPct, somaTesouro,
// constantes
SKILLS, ATRIBUTOS, TABS, MOEDAS, OPCOES_RACA, OPCOES_CLASSE,
// funções
modificador, formatarMod, attrAbrev,
salvaguardaDe, valorSalvaguarda, alternarSalvaguarda,
contarSincronizados, alternarSincronizado,
adicionarTesouro, removerTesouro,
periciaDe, valorPericia, valorPericiaPorNome, estadoPericia, alternarEstadoPericia,
alterar, alterarAtributo,
aplicarDano, aplicarVidaTemp, aplicarCura,
alternarBooleano, removerItem,
adicionarAtaque, adicionarInventario,
adicionarItemMagico, removerItemMagico,
adicionarHabilidade, adicionarUnidade, adicionarTag,
magiasPorNivel, slotDe, extraDe, adicionarMagia, removerMagia,
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
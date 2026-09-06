<template>
  <div class="app-container" v-if="ficha">
    <div class="save-indicator" :class="{ show: mostrarSalvo }">✓ Salvo</div>

    <div class="tabs-container">
      <div class="tabs-header">
        <button class="tab-btn" :class="{ active: abaAtiva === 'tab1' }" @click="abaAtiva = 'tab1'">Principal</button>
        <button class="tab-btn" :class="{ active: abaAtiva === 'tab2' }" @click="abaAtiva = 'tab2'">Inventário</button>
        <button class="tab-btn" :class="{ active: abaAtiva === 'tab3' }" @click="abaAtiva = 'tab3'">Habilidades</button>
        <button class="tab-btn" :class="{ active: abaAtiva === 'tab4' }" @click="abaAtiva = 'tab4'">Descrição</button>
        <button class="tab-btn" :class="{ active: abaAtiva === 'tab5' }" @click="abaAtiva = 'tab5'">Config</button>
      </div>

      <!-- ABA 1 — PRINCIPAL -->
      <div class="tab-content" :class="{ active: abaAtiva === 'tab1' }" v-if="abaAtiva === 'tab1'">
        <div class="char-name-group">
          <input type="text" v-model="ficha.nome" placeholder="Nome do Personagem" @input="agendarSalvar" />
          <div class="char-meta">
            <input type="text" :value="`Nível ${ficha.nivel} — ${ficha.classeId || 'sem classe'}`" readonly />
            <input type="text" v-model="ficha.racaId" placeholder="ID da Raça (ex: anao-rochoso)" @input="agendarSalvar" />
            <input type="text" v-model="ficha.antecedente" placeholder="Antecedente" @input="agendarSalvar" />
            <input type="text" v-model="ficha.tendencia" placeholder="Tendência" @input="agendarSalvar" />
            <input type="text" v-model="ficha.nomeJogador" placeholder="Jogador" @input="agendarSalvar" />
          </div>
        </div>

        <div class="char-quick-stats">
          <div class="quick-stat-row">
            <span class="quick-stat-label">Nível</span>
            <div class="qty-spinner">
              <button class="qty-btn" @click="alterar('nivel', -1, 1)">−</button>
              <input type="number" class="bonus-value" v-model.number="ficha.nivel" @input="agendarSalvar" />
              <button class="qty-btn" @click="alterar('nivel', 1)">+</button>
            </div>
          </div>
          <div class="quick-stat-row">
            <span class="quick-stat-label">Bônus de Proficiência</span>
            <span class="bonus-value">+{{ bonusProficiencia }}</span>
          </div>
          <div class="quick-stat-row">
            <span class="quick-stat-label">Inspiração</span>
            <input type="checkbox" class="check-icon" v-model="ficha.inspiracao" @change="agendarSalvar" />
          </div>
          <div class="quick-stat-row">
            <span class="quick-stat-label">Ponto Heroico</span>
            <input type="checkbox" class="check-icon" v-model="ficha.pontoHeroico" @change="agendarSalvar" />
          </div>
        </div>

        <div class="sheet-main-grid">
          <!-- COMBATE -->
          <div>
            <div class="col-label">Combate</div>
            <div class="character-currency-grid">
              <div class="input-group">
                <label class="input-label">PV Atual</label>
                <input type="number" v-model.number="ficha.pvAtual" @input="agendarSalvar" />
              </div>
              <div class="input-group">
                <label class="input-label">PV Máximo</label>
                <input type="number" v-model.number="ficha.pvMaximo" @input="agendarSalvar" />
              </div>
              <div class="input-group">
                <label class="input-label">PV Temporário</label>
                <input type="number" v-model.number="ficha.pvTemporario" @input="agendarSalvar" />
              </div>
            </div>
            <div class="character-currency-grid" style="margin-top:8px;">
              <div class="input-group">
                <label class="input-label">CA</label>
                <input type="number" v-model.number="ficha.ca" @input="agendarSalvar" />
              </div>
              <div class="input-group">
                <label class="input-label">Iniciativa</label>
                <input type="number" v-model.number="ficha.iniciativaBonus" @input="agendarSalvar" />
              </div>
              <div class="input-group">
                <label class="input-label">Dados de Vida Gastos</label>
                <input type="number" v-model.number="ficha.dadosVidaGastos" @input="agendarSalvar" />
              </div>
            </div>

            <div class="col-label" style="margin-top:16px;">Deslocamento</div>
            <div class="character-currency-grid">
              <div class="input-group">
                <label class="input-label">Andar</label>
                <input type="text" v-model="ficha.deslocamento" @input="agendarSalvar" />
              </div>
              <div class="input-group">
                <label class="input-label">Nadar</label>
                <input type="text" v-model="ficha.deslocNadar" @input="agendarSalvar" />
              </div>
              <div class="input-group">
                <label class="input-label">Voar</label>
                <input type="text" v-model="ficha.deslocVoar" @input="agendarSalvar" />
              </div>
              <div class="input-group">
                <label class="input-label">Escalar</label>
                <input type="text" v-model="ficha.deslocEscalar" @input="agendarSalvar" />
              </div>
              <div class="input-group">
                <label class="input-label">Salto</label>
                <input type="text" v-model="ficha.salto" @input="agendarSalvar" />
              </div>
            </div>

            <div class="col-label" style="margin-top:16px;">Ataques</div>
            <div v-for="(a, i) in ficha.ataques" :key="i" class="lista-linha">
              <input type="text" v-model="a.nome" placeholder="Nome" @input="agendarSalvar" />
              <input type="text" v-model="a.bonusAtaque" placeholder="Bônus" @input="agendarSalvar" />
              <input type="text" v-model="a.dano" placeholder="Dano" @input="agendarSalvar" />
              <input type="text" v-model="a.tipoDano" placeholder="Tipo" @input="agendarSalvar" />
              <button class="btn-remover-linha" @click="removerItem(ficha.ataques, i)">×</button>
            </div>
            <button class="btn btn-secondary" @click="adicionarAtaque">+ Adicionar Ataque</button>

            <div class="col-label" style="margin-top:16px;">Resistências & Vulnerabilidades</div>
            <div class="add-badge-group">
              <input type="text" v-model="novaTag" placeholder="Dano, condição, etc..." />
              <button class="hp-btn heal-btn small-btn" @click="adicionarTag('resistencia')">+ Res</button>
              <button class="hp-btn damage-btn small-btn" @click="adicionarTag('vulnerabilidade')">+ Vul</button>
            </div>
            <div class="badge-container">
              <span v-for="(t, i) in ficha.tags" :key="i" class="badge" :class="t.tipo">
                {{ t.texto }}
                <button class="badge-remover" @click="removerItem(ficha.tags, i)">×</button>
              </span>
            </div>

            <div class="col-label" style="margin-top:16px;">Idiomas & Proficiências</div>
            <textarea v-model="ficha.idiomas" @input="agendarSalvar" style="min-height:72px;"></textarea>
          </div>

          <!-- ATRIBUTOS -->
          <div>
            <div class="col-label">Atributos</div>
            <div class="character-stats-grid">
              <div class="character-attribute-box" v-for="attr in atributos" :key="attr.chave">
                <div class="character-attribute-label">{{ attr.sigla }}</div>
                <div class="character-attribute-modifier">{{ formatarMod(modificador(ficha[attr.chave])) }}</div>
                <div class="qty-spinner attr-stepper">
                  <button class="qty-btn" @click="alterarAtributo(attr.chave, -1)">−</button>
                  <input type="number" class="character-attribute-input" v-model.number="ficha[attr.chave]" @input="agendarSalvar" />
                  <button class="qty-btn" @click="alterarAtributo(attr.chave, 1)">+</button>
                </div>
              </div>
            </div>
          </div>

          <!-- PERÍCIAS -->
          <div>
            <div class="col-label">Perícias</div>
            <div class="skills-legend">
              <span>Prof.</span>
              <span>Exp.</span>
            </div>
            <div class="character-skills-grid">
              <div v-for="s in SKILLS" :key="s.name" class="skill-row">
                <input
                    type="checkbox"
                    :checked="periciaDe(s.name).proficiente"
                    @change="alternarPericia(s.name, 'proficiente', $event.target.checked)"
                    title="Proficiente"
                />
                <input
                    type="checkbox"
                    :checked="periciaDe(s.name).expertise"
                    :disabled="!periciaDe(s.name).proficiente"
                    @change="alternarPericia(s.name, 'expertise', $event.target.checked)"
                    title="Expertise (dobra o bônus, exige proficiência)"
                />
                <span class="skill-nome">{{ s.name }}</span>
                <span class="skill-attr">({{ attrAbrev(s.attr) }})</span>
                <span class="skill-valor">{{ formatarMod(valorPericia(s)) }}</span>
              </div>
            </div>

            <div style="display:grid;grid-template-columns:1fr 1fr;gap:6px;margin-top:8px;">
              <div class="input-group">
                <label class="input-label">Percepção Passiva</label>
                <input type="text" :value="10 + valorPericiaPorNome('Percepcao')" readonly />
              </div>
              <div class="input-group">
                <label class="input-label">Intuição Passiva</label>
                <input type="text" :value="10 + valorPericiaPorNome('Intuicao')" readonly />
              </div>
            </div>
          </div>
        </div>
      </div>

      <!-- ABA 2 — INVENTÁRIO -->
      <div class="tab-content" :class="{ active: abaAtiva === 'tab2' }" v-if="abaAtiva === 'tab2'">
        <div class="section">
          <div class="section-title">Moedas</div>
          <div class="character-currency-grid">
            <div class="input-group">
              <label class="input-label">PC</label>
              <input type="number" v-model.number="ficha.moedaPc" @input="agendarSalvar" />
            </div>
            <div class="input-group">
              <label class="input-label">PP</label>
              <input type="number" v-model.number="ficha.moedaPp" @input="agendarSalvar" />
            </div>
            <div class="input-group">
              <label class="input-label">PO</label>
              <input type="number" v-model.number="ficha.moedaPo" @input="agendarSalvar" />
            </div>
            <div class="input-group">
              <label class="input-label">PE</label>
              <input type="number" v-model.number="ficha.moedaPe" @input="agendarSalvar" />
            </div>
            <div class="input-group">
              <label class="input-label">PL</label>
              <input type="number" v-model.number="ficha.moedaPl" @input="agendarSalvar" />
            </div>
          </div>
        </div>

        <div class="section">
          <div class="section-title">Itens</div>
          <div v-for="(item, i) in ficha.inventario" :key="i" class="lista-linha">
            <input type="text" v-model="item.nome" placeholder="Nome" @input="agendarSalvar" />
            <input type="number" v-model.number="item.quantidade" placeholder="Qtd" style="width:70px;" @input="agendarSalvar" />
            <input type="number" v-model.number="item.peso" placeholder="Peso" style="width:70px;" @input="agendarSalvar" />
            <input type="text" v-model="item.descricao" placeholder="Descrição" @input="agendarSalvar" />
            <button class="btn-remover-linha" @click="removerItem(ficha.inventario, i)">×</button>
          </div>
          <button class="btn btn-secondary" @click="adicionarInventario">+ Adicionar Item</button>
        </div>

        <div class="section">
          <div class="section-title">Itens Mágicos</div>
          <div v-for="(item, i) in ficha.itensMagicos" :key="i" class="lista-linha">
            <input type="text" v-model="item.nome" placeholder="Nome" @input="agendarSalvar" />
            <input type="text" v-model="item.descricao" placeholder="Descrição" @input="agendarSalvar" />
            <button class="btn-remover-linha" @click="removerItem(ficha.itensMagicos, i)">×</button>
          </div>
          <button class="btn btn-secondary" @click="adicionarItemMagico">+ Adicionar Item Mágico</button>
        </div>
      </div>

      <!-- ABA 3 — HABILIDADES -->
      <div class="tab-content" :class="{ active: abaAtiva === 'tab3' }" v-if="abaAtiva === 'tab3'">
        <div class="section">
          <div class="section-title">Habilidades</div>
          <div v-for="(h, i) in ficha.habilidades" :key="i" class="lista-linha-vertical">
            <input type="text" v-model="h.nome" placeholder="Nome da habilidade" @input="agendarSalvar" />
            <textarea v-model="h.descricao" placeholder="Descrição" @input="agendarSalvar"></textarea>
            <button class="btn-remover-linha" @click="removerItem(ficha.habilidades, i)">× Remover</button>
          </div>
          <button class="btn btn-secondary" @click="adicionarHabilidade">+ Adicionar Habilidade</button>
        </div>

        <div class="section">
          <div class="section-title">Magias</div>
          <div v-for="nivel in 10" :key="nivel - 1" class="character-spell-level">
            <div class="col-label">{{ nivel === 1 ? 'Truques' : `Nível ${nivel - 1}` }}</div>
            <div v-for="(m, i) in magiasPorNivel(nivel - 1)" :key="i" class="lista-linha">
              <input type="text" v-model="m.nome" placeholder="Nome da magia" @input="agendarSalvar" />
              <label class="checkbox-inline">
                <input type="checkbox" v-model="m.preparada" @change="agendarSalvar" /> Preparada
              </label>
              <button class="btn-remover-linha" @click="removerMagia(m)">×</button>
            </div>
            <button class="btn btn-secondary" @click="adicionarMagia(nivel - 1)">+ Adicionar</button>
          </div>
        </div>
      </div>

      <!-- ABA 4 — DESCRIÇÃO -->
      <div class="tab-content" :class="{ active: abaAtiva === 'tab4' }" v-if="abaAtiva === 'tab4'">
        <div class="sheet-grid-details">
          <div class="section">
            <div class="section-title">Retrato</div>
            <div class="input-group">
              <label class="input-label">URL da imagem (ou envie um arquivo abaixo)</label>
              <input type="text" v-model="ficha.imagemUrl" @input="agendarSalvar" placeholder="https://..." />
            </div>
            <input type="file" accept="image/*" @change="selecionarImagem" style="margin-bottom:0.5rem;" />
            <img v-if="ficha.imagemUrl" :src="ficha.imagemUrl" class="character-image-preview" />
            <button v-if="ficha.imagemUrl" class="btn btn-danger" style="margin-top:0.5rem;" @click="removerImagem">
              Remover Imagem
            </button>
          </div>

          <div>
            <div class="section">
              <div class="section-title">Conhecidos & Aliados</div>
              <div v-for="(u, i) in ficha.unidades" :key="i" class="lista-linha">
                <input type="text" v-model="u.nome" placeholder="Nome" @input="agendarSalvar" />
                <input type="text" v-model="u.tipo" placeholder="Tipo (familiar, montaria...)" @input="agendarSalvar" />
                <button class="btn-remover-linha" @click="removerItem(ficha.unidades, i)">×</button>
              </div>
              <button class="btn btn-secondary" @click="adicionarUnidade">+ Adicionar Conhecido</button>
            </div>

            <div class="section">
              <div class="section-title">História</div>
              <textarea v-model="ficha.historia" @input="agendarSalvar" style="min-height:200px;"
                        placeholder="A história do personagem..."></textarea>
            </div>

            <div class="section">
              <div class="section-title">Anotações de Sessão</div>
              <textarea v-model="ficha.anotacoes" @input="agendarSalvar" style="min-height:160px;"
                        placeholder="Notas, lembretes, missões..."></textarea>
            </div>
          </div>
        </div>
      </div>

      <!-- ABA 5 — CONFIG -->
      <div class="tab-content" :class="{ active: abaAtiva === 'tab5' }" v-if="abaAtiva === 'tab5'">
        <div class="section">
          <div class="section-title">Ações</div>
          <div style="display:flex;flex-direction:column;gap:8px;max-width:320px;">
            <button class="btn btn-primary" @click="salvarAgora">💾 Salvar Ficha</button>
            <button class="btn btn-secondary" @click="exportarJSON">📥 Exportar JSON</button>
            <button class="btn btn-secondary" @click="$refs.importInput.click()">📂 Importar JSON</button>
            <input ref="importInput" type="file" accept=".json" style="display:none" @change="importarJSON" />
            <RouterLink class="btn btn-secondary" to="/personagens">← Voltar para Meus Personagens</RouterLink>
            <button class="btn btn-danger" @click="excluir">🗑 Excluir Personagem</button>
          </div>
        </div>
      </div>
    </div>

    <button class="btn-dados-flutuante" @click="rolagemAberta = true" title="Rolador de Dados">🎲</button>
    <RoladorDados v-if="rolagemAberta" @fechar="rolagemAberta = false" />
  </div>

  <div v-else class="loading-state">Carregando ficha...</div>
</template>

<script setup>
import { ref, reactive, computed, onMounted } from 'vue';
import { useRoute, useRouter } from 'vue-router';
import personagemService from '../services/personagemService';
import RoladorDados from '../components/RoladorDados.vue';

const SKILLS = [
  { name: 'Acrobacia', attr: 'destreza' },
  { name: 'Arcanismo', attr: 'inteligencia' },
  { name: 'Atletismo', attr: 'forca' },
  { name: 'Atuacao', attr: 'carisma' },
  { name: 'Blefar', attr: 'carisma' },
  { name: 'Briga', attr: 'forca' },
  { name: 'Brutalidade', attr: 'forca' },
  { name: 'Furtividade', attr: 'destreza' },
  { name: 'Historia', attr: 'inteligencia' },
  { name: 'Intimidacao', attr: 'carisma' },
  { name: 'Intuicao', attr: 'sabedoria' },
  { name: 'Investigacao', attr: 'inteligencia' },
  { name: 'Lidar com Animais', attr: 'sabedoria' },
  { name: 'Medicina', attr: 'sabedoria' },
  { name: 'Natureza', attr: 'inteligencia' },
  { name: 'Percepcao', attr: 'sabedoria' },
  { name: 'Persuasao', attr: 'carisma' },
  { name: 'Prestidigitacao', attr: 'destreza' },
  { name: 'Religiao', attr: 'inteligencia' },
  { name: 'Resiliencia', attr: 'constituicao' },
  { name: 'Sobrevivencia', attr: 'sabedoria' },
  { name: 'Vigor', attr: 'constituicao' },
];

const atributos = [
  { chave: 'forca', sigla: 'FOR' },
  { chave: 'destreza', sigla: 'DES' },
  { chave: 'constituicao', sigla: 'CON' },
  { chave: 'inteligencia', sigla: 'INT' },
  { chave: 'sabedoria', sigla: 'SAB' },
  { chave: 'carisma', sigla: 'CAR' },
];

const route = useRoute();
const router = useRouter();

const ficha = ref(null);
const abaAtiva = ref('tab1');
const mostrarSalvo = ref(false);
const novaTag = ref('');
const rolagemAberta = ref(false);
let timerSalvar = null;

const bonusProficiencia = computed(() => {
  if (!ficha.value) return 2;
  return Math.floor((ficha.value.nivel - 1) / 4) + 2;
});

function modificador(valorAtributo) {
  return Math.floor((valorAtributo - 10) / 2);
}

function formatarMod(valor) {
  return valor >= 0 ? `+${valor}` : `${valor}`;
}

function attrAbrev(attr) {
  return atributos.find((a) => a.chave === attr)?.sigla || attr;
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

function alternarPericia(nome, campo, valor) {
  const p = periciaDe(nome);
  p[campo] = valor;
  if (campo === 'proficiente' && !valor) {
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
  ficha.value.magias.push({ nivel, nome: '', preparada: false });
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

const enviandoImagem = ref(false);

async function selecionarImagem(evento) {
  const arquivo = evento.target.files[0];
  if (!arquivo) return;
  if (arquivo.size > 2 * 1024 * 1024) {
    alert('Imagem muito grande (máximo 2MB). Escolha uma imagem menor.');
    evento.target.value = '';
    return;
  }
  enviandoImagem.value = true;
  try {
    const { url } = await personagemService.enviarImagem(route.params.id, arquivo);
    ficha.value.imagemUrl = url;
  } catch (e) {
    alert(e.response?.data || 'Não foi possível enviar a imagem.');
  } finally {
    enviandoImagem.value = false;
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

onMounted(async () => {
  ficha.value = await personagemService.buscar(route.params.id);
});
</script>

<style scoped>
.loading-state {
  text-align: center;
  padding: 3rem;
  color: #e8e0f5;
}

.lista-linha {
  display: flex;
  gap: 0.4rem;
  margin-bottom: 0.4rem;
  align-items: center;
}

.lista-linha input {
  flex: 1;
  min-width: 0;
}

.lista-linha-vertical {
  display: flex;
  flex-direction: column;
  gap: 0.4rem;
  margin-bottom: 1rem;
  padding-bottom: 1rem;
  border-bottom: 1px solid #4a3a6a;
}

.btn-remover-linha {
  background: none;
  border: 1px solid #e87070;
  color: #e87070;
  border-radius: 4px;
  width: 28px;
  height: 28px;
  cursor: pointer;
  flex-shrink: 0;
}

.badge {
  display: inline-flex;
  align-items: center;
  gap: 0.3rem;
  padding: 0.2rem 0.6rem;
  border-radius: 999px;
  font-size: 0.75rem;
  margin: 0.15rem;
}

.badge.resistencia {
  background: rgba(78, 203, 122, 0.2);
  color: #4ecb7a;
}

.badge.vulnerabilidade {
  background: rgba(232, 112, 64, 0.2);
  color: #e87040;
}

.badge-remover {
  background: none;
  border: none;
  color: inherit;
  cursor: pointer;
}

.skill-row {
  display: flex;
  align-items: center;
  gap: 0.5rem;
  padding: 0.25rem 0;
  font-size: 0.85rem;
}

.skill-nome {
  flex: 1;
}

.skill-attr {
  opacity: 0.6;
  font-size: 0.75rem;
}

.skill-valor {
  font-family: 'Cinzel', serif;
  min-width: 2.2rem;
  text-align: right;
}

.checkbox-inline {
  display: flex;
  align-items: center;
  gap: 0.3rem;
  font-size: 0.8rem;
  white-space: nowrap;
}

.character-image-preview {
  width: 100%;
  border-radius: 8px;
  margin-top: 0.5rem;
}

.character-spell-level {
  margin-bottom: 1.2rem;
}

.skills-legend {
  display: flex;
  gap: 1.55rem;
  padding-left: 0.1rem;
  margin-bottom: 0.2rem;
  font-size: 0.65rem;
  opacity: 0.6;
  text-transform: uppercase;
  letter-spacing: 0.05em;
}

.skills-legend span:first-child {
  margin-left: 0.05rem;
}

.btn-dados-flutuante {
  position: fixed;
  bottom: 1.5rem;
  right: 1.5rem;
  width: 56px;
  height: 56px;
  border-radius: 50%;
  background: #8a6ac0;
  border: none;
  font-size: 1.6rem;
  cursor: pointer;
  box-shadow: 0 4px 14px rgba(0, 0, 0, 0.4);
  z-index: 200;
}
</style>
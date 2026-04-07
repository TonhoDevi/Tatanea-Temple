// ============================================================
// COMPÊNDIO DE ALQUIMIA — LÓGICA
// Arquivo: js/compendium/compendium-alquimia.js
// Depende de: data-alquimia.js (POCOES_DATA)
// ============================================================

'use strict';

// ── Símbolos de Essência (6 originais + 2 novas) ─────────────


// ── Kit de Alquimia ───────────────────────────────────────────
// Bônus: começa em 0, aumenta +2 a cada nível
// Usos: começa em 5, dobra a cada nível
// Pessoas: 1 por nível
// Preço: começa em 5.000 PC, aumenta 1,5× a cada nível
const KITS = [
    { raridade: 'Comum', classe: 'rar-c', bonus: 0, usos: 5, workers: 1, preco: 5000 },
    { raridade: 'Incomum', classe: 'rar-i', bonus: 2, usos: 10, workers: 2, preco: 7500 },
    { raridade: 'Raro', classe: 'rar-r', bonus: 4, usos: 20, workers: 3, preco: 11250 },
    { raridade: 'Muito Raro', classe: 'rar-mr', bonus: 6, usos: 40, workers: 4, preco: 16875 },
    { raridade: 'Épico', classe: 'rar-e', bonus: 8, usos: 80, workers: 5, preco: 25313 },
];

// ── Estação Alquímica ─────────────────────────────────────────
// Bônus: começa em 3, aumenta +3 a cada nível
// Usos: 10× maior que kit equivalente
// Pessoas: 5× maior que kit equivalente
// Preço: começa em 12.500 PC, aumenta 1,5× a cada nível
const ESTACOES = [
    { raridade: 'Comum', classe: 'rar-c', bonus: 3, usos: 50, workers: 5, preco: 12500 },
    { raridade: 'Incomum', classe: 'rar-i', bonus: 6, usos: 100, workers: 10, preco: 18750 },
    { raridade: 'Raro', classe: 'rar-r', bonus: 9, usos: 200, workers: 15, preco: 28125 },
    { raridade: 'Muito Raro', classe: 'rar-mr', bonus: 12, usos: 400, workers: 20, preco: 42188 },
    { raridade: 'Épico', classe: 'rar-e', bonus: 15, usos: 800, workers: 25, preco: 63281 },
];

// ── ESTADO ───────────────────────────────────────────────────
const STATE = {
    search: '',
    raridade: '',
    essencia: '',
    potion: null,
};

// ── UTILITÁRIOS ───────────────────────────────────────────────
function parseFormula(formulaStr) {
    return formulaStr.trim().split(/\s+/);
}

function buildEssChips(formulaStr) {
    const syms = parseFormula(formulaStr);
    return syms.map(s => {
        const ess = ESSENCIAS[s];
        if (!ess) return '';
        return `<span class="ess-chip" data-ess="${s}" title="${ess.nome} (${s})">${s}</span>`;
    }).join('');
}

function rarityColor(r) {
    const map = {
        'Comum': 'var(--rar-comum)',
        'Incomum': 'var(--rar-incomum)',
        'Rara': 'var(--rar-rara)',
        'Muito Rara': 'var(--rar-muito-rara)',
        'Lendária': 'var(--rar-lendaria)',
    };
    return map[r] || '#fff';
}

function formatPreco(pc) {
    return pc.toLocaleString('pt-BR') + ' PC';
}

// ── FILTROS ───────────────────────────────────────────────────
function getFiltered() {
    let list = [...POCOES_DATA];
    const q = STATE.search.toLowerCase();

    if (q) {
        list = list.filter(p =>
            p.nome.toLowerCase().includes(q) ||
            p.descricao.toLowerCase().includes(q) ||
            p.formula.includes(q) ||
            (p.nucleo && p.nucleo.toLowerCase().includes(q)) ||
            (p.melhoria && p.melhoria.toLowerCase().includes(q)) ||
            (p.duracao && p.duracao.toLowerCase().includes(q))
        );
    }
    if (STATE.raridade) {
        list = list.filter(p => p.raridade === STATE.raridade);
    }
    if (STATE.essencia) {
        list = list.filter(p => parseFormula(p.formula).includes(STATE.essencia));
    }
    return list;
}

// ── RENDER GRID ───────────────────────────────────────────────
function render() {
    const grid = document.getElementById('potionsGrid');
    const count = document.getElementById('resultsCount');
    if (!grid) return;

    const lista = getFiltered();
    if (count) {
        count.innerHTML = `Mostrando <strong>${lista.length}</strong> de <strong>${POCOES_DATA.length}</strong> poções`;
    }

    grid.innerHTML = '';
    if (!lista.length) {
        grid.innerHTML = `<div class="alq-empty"><span class="alq-empty-icon">⚗️</span>Nenhuma poção encontrada.</div>`;
        return;
    }

    lista.forEach((p, i) => {
        const idx = POCOES_DATA.indexOf(p);
        const card = document.createElement('div');
        card.className = 'alq-card';
        card.dataset.rarity = p.raridade;
        card.style.animationDelay = `${Math.min(i * 0.035, 0.5)}s`;
        card.setAttribute('role', 'button');
        card.setAttribute('tabindex', '0');
        card.setAttribute('aria-label', `Ver detalhes de ${p.nome}`);

        const duracao = p.duracao || 'Instantânea';
        const duracaoIcon = duracao === 'Instantânea' ? '💥' : '⏱️';

        card.innerHTML = `
            <div class="card-header">
                <span class="card-icon">${p.icone}</span>
                <span class="card-rarity-badge" data-rarity="${p.raridade}">${p.raridade}</span>
            </div>
            <div class="card-body">
                <h3 class="card-name">${p.nome}</h3>
                <p class="card-desc">${p.descricao}</p>
                <div class="card-formula">${buildEssChips(p.formula)}</div>
                <div class="card-duration">${duracaoIcon} ${duracao}</div>
                <div class="card-footer">
                    <span class="card-nucleus-label">📦 Núcleo especial</span>
                    <button class="card-btn">Ver Detalhes →</button>
                </div>
            </div>`;

        card.addEventListener('click', () => openModal(idx));
        card.addEventListener('keydown', e => {
            if (e.key === 'Enter' || e.key === ' ') { e.preventDefault(); openModal(idx); }
        });
        grid.appendChild(card);
    });
}

// ── MODAL ─────────────────────────────────────────────────────
function openModal(idx) {
    STATE.potion = idx;
    const p = POCOES_DATA[idx];
    const overlay = document.getElementById('potionModal');

    document.getElementById('mIcon').textContent = p.icone;
    document.getElementById('mName').textContent = p.nome;

    const rarEl = document.getElementById('mRarity');
    rarEl.textContent = `Poção, ${p.raridade}`;
    rarEl.style.color = rarityColor(p.raridade);

    document.getElementById('mFormula').innerHTML = buildEssChips(p.formula);

    // Quick stats
    const syms = parseFormula(p.formula);
    const ndMap = { 'Comum': 0, 'Incomum': 2, 'Rara': 4, 'Muito Rara': 6, 'Lendária': 10 };
    const cd = 8 + (syms.length * 2) + (ndMap[p.raridade] ?? 0);

    document.getElementById('mQsComps').textContent = syms.length;
    document.getElementById('mQsCd').textContent = `CD ${cd}`;
    document.getElementById('mQsDesafio').textContent = ndMap[p.raridade] ?? 0;
    document.getElementById('mQsDuracao').textContent = p.duracao || 'Instantânea';

    // Aba descrição
    document.getElementById('mDesc').textContent = p.descricao;

    // Aba fabrico
    document.getElementById('mNucleo').textContent = p.nucleo || '—';
    const melhEl = document.getElementById('mMelhoria');
    if (p.melhoria) {
        melhEl.closest('.alq-melhoria').style.display = '';
        melhEl.textContent = p.melhoria;
    } else {
        melhEl.closest('.alq-melhoria').style.display = 'none';
    }

    // Aba essências detalhadas
    const essDetail = document.getElementById('mEssDetail');
    const unique = [...new Set(syms)];
    essDetail.innerHTML = unique.map(s => {
        const ess = ESSENCIAS[s];
        if (!ess) return '';
        const count = syms.filter(x => x === s).length;
        return `
            <div class="alq-detail-block" style="border-left-color:${ess.cor}">
                <div class="alq-detail-title" style="color:${ess.cor}">
                    <span class="ess-chip" data-ess="${s}" style="display:inline-flex;">${s}</span>
                    &nbsp;${ess.nome} — ${ess.elem}
                    &nbsp;<small style="font-weight:400;opacity:.7">${count}× usada</small>
                </div>
                <div class="alq-detail-text">
                    Essência de <strong>${ess.elem.toLowerCase()}</strong>.
                    Símbolo: <strong style="color:${ess.cor}">${s}</strong>
                    ${s === 'ξ' ? '<br><em style="opacity:.7;font-size:.9em">Nova essência: artificiosa e manufaturada.</em>' : ''}
                    ${s === 'δ' ? '<br><em style="opacity:.7;font-size:.9em">Nova essência: energia elétrica e descarga estática.</em>' : ''}
                </div>
            </div>`;
    }).join('');

    openModalTab('desc');
    overlay.classList.add('active');
    document.body.style.overflow = 'hidden';
}

function closeModal() {
    document.getElementById('potionModal').classList.remove('active');
    document.body.style.overflow = '';
}

function openModalTab(tabId) {
    document.querySelectorAll('.modal-tab').forEach(b =>
        b.classList.toggle('active', b.dataset.tab === tabId));
    document.querySelectorAll('.tab-pane').forEach(p =>
        p.classList.toggle('active', p.id === `pane-${tabId}`));
}

// ── NAVEGAÇÃO PRINCIPAL ───────────────────────────────────────
function switchPanel(panelId) {
    document.querySelectorAll('.alq-nav-tab').forEach(b =>
        b.classList.toggle('active', b.dataset.panel === panelId));
    document.querySelectorAll('.alq-panel').forEach(p =>
        p.classList.toggle('active', p.id === `panel-${panelId}`));
}

// ── CALCULADORA DE CD ─────────────────────────────────────────
function calcularCD() {
    const nComps = parseInt(document.getElementById('calcComps').value) || 0;
    const raridade = document.getElementById('calcRaridade').value;
    const ferramenta = document.getElementById('calcFerramenta').value;
    const estacao = document.getElementById('calcEstacao').value;
    const ajudantes = parseInt(document.getElementById('calcAjudantes').value) || 0;

    const rarDesafio = { 'Comum': 0, 'Incomum': 2, 'Rara': 4, 'Muito Rara': 6, 'Lendária': 10 };
    const bonusKit = { 'kit-c': 0, 'kit-i': 2, 'kit-r': 4, 'kit-mr': 6, 'kit-e': 8 };
    const bonusEst = { 'est-c': 3, 'est-i': 6, 'est-r': 9, 'est-mr': 12, 'est-e': 15, 'nenhum': 0 };

    const nd = rarDesafio[raridade] ?? 0;
    const cd = 8 + (nComps * 2) + nd;
    const bKit = bonusKit[ferramenta] ?? 0;
    const bEst = bonusEst[estacao] ?? 0;
    const bonusTotal = bKit + bEst + ajudantes;
    const tempo = nComps;
    const minDado = Math.max(1, cd - bonusTotal);

    const res = document.getElementById('calcResult');
    res.classList.add('show');

    document.getElementById('crCD').textContent = cd;
    document.getElementById('crBonus').textContent = `+${bonusTotal}`;
    document.getElementById('crTempo').textContent = `${tempo}h`;
    document.getElementById('crNote').textContent =
        `Você precisa tirar pelo menos ${minDado} no dado para ter sucesso. ` +
        `Os materiais são consumidos independente do resultado.`;
}

// ── PLANTAS / BIOMAS ──────────────────────────────────────────

function renderBiomePicker() {
    const btnContainer = document.getElementById('biomeButtons');
    const list = document.getElementById('biomeList');
    if (!btnContainer || !list) return;

    let selectedBiome = Object.keys(Essence_By_Biome)[0];

    const update = () => {
        // Render buttons
        btnContainer.innerHTML = Object.keys(Essence_By_Biome).map(b => {
            const isActive = b === selectedBiome;
            const bg = isActive ? 'rgba(78,203,122,.2)' : 'transparent';
            const border = isActive ? '#4ecb7a' : 'rgba(78,203,122,.3)';
            const color = isActive ? '#4ecb7a' : '#d0e8c8';
            return `<button type="button" style="border:1px solid ${border}; background:${bg}; color:${color}; padding:6px 12px; border-radius:4px; font-family:'Crimson Text',serif; font-size:1.05rem; cursor:pointer; transition:all 0.2s;" data-biome="${b}" onmouseover="this.style.background='rgba(78,203,122,.15)'" onmouseout="if('${b}' !== '${selectedBiome}') this.style.background='transparent'">${b}</button>`;
        }).join('');

        // Bind clicks
        btnContainer.querySelectorAll('button').forEach(btn => {
            btn.addEventListener('click', (e) => {
                selectedBiome = e.target.getAttribute('data-biome');
                update();
            });
        });

        const plants = Essence_By_Biome[selectedBiome] || [];
        list.innerHTML = plants.map(pl => {
            let rarClass = 'rar-c';
            if (pl.raridade === 'Incomum') rarClass = 'rar-i';
            else if (pl.raridade === 'Rara') rarClass = 'rar-r';
            else if (pl.raridade === 'Muito Rara') rarClass = 'rar-mr';
            else if (pl.raridade === 'Lendária') rarClass = 'rar-e';

            return `
            <li style="padding:10px 0;border-bottom:1px solid rgba(78,203,122,.07); display:flex; justify-content:space-between; align-items:center;">
                <div style="flex:1; display:flex; flex-direction:column; gap:4px;">
                    <strong style="font-family:'Crimson Text',serif;font-size:1.1rem;color:#d0e8c8;">🌿 ${pl.nome}</strong>
                    <div>
                        <span class="rar-chip ${rarClass}" style="transform: scale(0.85); transform-origin: left; display:inline-block;">${pl.raridade}</span>
                    </div>
                </div>
                
                <div style="flex:1; display:flex; justify-content:flex-start; align-items:center;">
                    <div class="card-formula" style="margin:0;">${buildEssChips(pl.essencia)}</div>
                </div>

                <div style="flex:1; display:flex; justify-content:flex-end; align-items:center;">
                    <span style="color:#e8b840; font-size:1.15rem;">${pl.d100_min} a ${pl.d100_max}</span>
                </div>
            </li>`
        }).join('');
    };

    update();
}

// ── CONTADORES DO HEADER ──────────────────────────────────────
function preencherContadores() {
    const counts = { Comum: 0, Incomum: 0, Rara: 0, 'Muito Rara': 0, Lendária: 0 };
    POCOES_DATA.forEach(p => { counts[p.raridade] = (counts[p.raridade] || 0) + 1; });

    const el = id => document.getElementById(id);
    if (el('statTotal')) el('statTotal').textContent = POCOES_DATA.length;
    if (el('statComum')) el('statComum').textContent = counts.Comum;
    if (el('statIncomum')) el('statIncomum').textContent = counts.Incomum;
    if (el('statRara')) el('statRara').textContent = counts.Rara;
    if (el('statMuitoRara')) el('statMuitoRara').textContent = counts['Muito Rara'];
    if (el('statLendaria')) el('statLendaria').textContent = counts.Lendária;
}

// ── RENDER KITS & ESTAÇÕES ────────────────────────────────────
function renderToolCards() {
    const kitsEl = document.getElementById('kitCards');
    const estEl = document.getElementById('estacaoCards');

    const buildCard = (item) => `
        <div class="tool-card">
            <div class="tool-card-name">
                <span class="rar-chip ${item.classe}">${item.raridade}</span>
            </div>
            <div class="tool-card-stat">
                <span class="tool-card-stat-label">Bônus</span>
                <span class="tool-card-stat-val stat-bonus">+${item.bonus}</span>
            </div>
            <div class="tool-card-stat">
                <span class="tool-card-stat-label">Usos</span>
                <span class="tool-card-stat-val stat-usos">${item.usos}</span>
            </div>
            <div class="tool-card-stat">
                <span class="tool-card-stat-label">Pessoas</span>
                <span class="tool-card-stat-val stat-workers">${item.workers}</span>
            </div>
            <div class="tool-card-stat">
                <span class="tool-card-stat-label">Preço</span>
                <span class="tool-card-stat-val stat-price">${formatPreco(item.preco)}</span>
            </div>
        </div>`;

    if (kitsEl) kitsEl.innerHTML = KITS.map(buildCard).join('');
    if (estEl) estEl.innerHTML = ESTACOES.map(buildCard).join('');
}

// ── BIND EVENTOS ──────────────────────────────────────────────
function bindEvents() {
    // Busca
    document.getElementById('searchInput')?.addEventListener('input', e => {
        STATE.search = e.target.value.trim();
        render();
    });

    // Raridade — botões pills na barra de estatísticas
    document.querySelectorAll('.alq-rar-btn').forEach(btn => {
        btn.addEventListener('click', () => {
            const val = btn.dataset.rar;
            // toggle: clicar na ativa volta para "todas"
            if (STATE.raridade === val && val !== '') {
                STATE.raridade = '';
                document.querySelectorAll('.alq-rar-btn').forEach(b => b.classList.remove('active'));
                document.querySelector('.alq-rar-btn[data-rar=""]').classList.add('active');
            } else {
                STATE.raridade = val;
                document.querySelectorAll('.alq-rar-btn').forEach(b => b.classList.remove('active'));
                btn.classList.add('active');
            }
            render();
        });
    });

    // Botões de essência (incluindo novos ξ e δ)
    document.querySelectorAll('.alq-ess-btn').forEach(btn => {
        btn.addEventListener('click', () => {
            const val = btn.dataset.ess;
            if (STATE.essencia === val) {
                STATE.essencia = '';
                btn.classList.remove('active');
            } else {
                document.querySelectorAll('.alq-ess-btn').forEach(b => b.classList.remove('active'));
                STATE.essencia = val;
                btn.classList.add('active');
            }
            render();
        });
    });

    // Navegação principal
    document.querySelectorAll('.alq-nav-tab').forEach(btn => {
        btn.addEventListener('click', () => switchPanel(btn.dataset.panel));
    });

    // Modal: abas
    document.querySelectorAll('.modal-tab').forEach(btn => {
        btn.addEventListener('click', () => openModalTab(btn.dataset.tab));
    });

    // Modal: fechar
    document.getElementById('modalClose')?.addEventListener('click', closeModal);
    document.getElementById('potionModal')?.addEventListener('click', e => {
        if (e.target === e.currentTarget) closeModal();
    });

    // ESC fecha modal
    document.addEventListener('keydown', e => {
        if (e.key === 'Escape') closeModal();
    });

    // Calculadora
    document.getElementById('calcBtn')?.addEventListener('click', calcularCD);

    // Limita ajudantes ao máximo do kit selecionado
    document.getElementById('calcFerramenta')?.addEventListener('change', () => {
        const fEl = document.getElementById('calcFerramenta');
        const aEl = document.getElementById('calcAjudantes');
        if (!fEl || !aEl) return;
        const limites = { 'kit-c': 1, 'kit-i': 2, 'kit-r': 3, 'kit-mr': 4, 'kit-e': 5 };
        const max = limites[fEl.value] ?? 5;
        aEl.max = max;
        if (parseInt(aEl.value) > max) aEl.value = max;
    });
}

// ── INIT ──────────────────────────────────────────────────────
document.addEventListener('DOMContentLoaded', () => {
    preencherContadores();
    render();
    bindEvents();
    renderBiomePicker();
    renderToolCards();
});
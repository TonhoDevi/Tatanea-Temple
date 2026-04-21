// ============================================
// PÁGINA DO HERÓI — SCRIPT
// Arquivo: js/heroes/hero-page.js
// ============================================

'use strict';

// ── Sistema de Tier ──────────────────────────
function getTierLabel(val) {
    if (val >= 99) return 'SS';
    if (val >= 97) return 'S+';
    if (val >= 89) return 'S';
    if (val >= 82) return 'S-';
    if (val >= 74) return 'A+';
    if (val >= 66) return 'A';
    if (val >= 59) return 'A-';
    if (val >= 52) return 'B+';
    if (val >= 45) return 'B';
    if (val >= 38) return 'B-';
    if (val >= 31) return 'C+';
    if (val >= 24) return 'C';
    if (val >= 17) return 'C-';
    if (val >= 10) return 'D+';
    if (val >= 5) return 'D';
    return 'F';

}

const TIER_COLORS = {
    'SS': '#fff200ff', 'S+': '#f5c842', 'S': '#e07a20',
    'A+': '#ff0000ff', 'A': '#c83030', 'A-': '#c02424ff',
    'B+': '#9e1bfcff', 'B': '#8840c8', 'B-': '#b060e8',
    'C+': '#40b0e8', 'C': '#2880c0', 'C-': '#3483aaff',
    'D+': '#40ea95ff', 'D': '#308060', 'D-': '#286860ff',
    'F': '#606060',
};

function getTierColor(tier) { return TIER_COLORS[tier] || '#808080'; }

// ── SVG helpers ──────────────────────────────
function makeSVG(tag, attrs = {}) {
    const el = document.createElementNS('http://www.w3.org/2000/svg', tag);
    Object.entries(attrs).forEach(([k, v]) => el.setAttribute(k, v));
    return el;
}

function svgText(attrs, text) {
    const el = makeSVG('text', attrs);
    el.textContent = text;
    return el;
}

// ── Radar Chart ──────────────────────────────
// viewBox 320×300, cx=160, cy=150, maxR=90
function drawRadar(svgId, dataPoints, opts = {}) {
    const svg = document.getElementById(svgId);
    if (!svg || !dataPoints || !dataPoints.length) return;

    const {
        strokeColor = '#e05555',
        fillColor = 'rgba(200,50,50,0.28)',
        glowColor = 'rgba(200,50,50,0.6)',
    } = opts;

    const cx = 160, cy = 150, maxR = 90, levels = 5;
    const n = dataPoints.length;
    const step = (2 * Math.PI) / n;
    const startA = -Math.PI / 2; // top

    svg.innerHTML = '';

    function pt(i, r) {
        const a = startA + i * step;
        return [cx + r * Math.cos(a), cy + r * Math.sin(a)];
    }

    function ptsStr(r) {
        return Array.from({ length: n }, (_, i) => pt(i, r).map(v => v.toFixed(2)).join(',')).join(' ');
    }

    // Defs: glow filter
    const defs = makeSVG('defs');
    const fid = `glow_${svgId}`;
    const flt = makeSVG('filter', { id: fid, x: '-50%', y: '-50%', width: '200%', height: '200%' });
    const fb = makeSVG('feGaussianBlur', { in: 'SourceGraphic', stdDeviation: '5', result: 'blur' });
    const fm = makeSVG('feMerge');
    fm.appendChild(makeSVG('feMergeNode', { in: 'blur' }));
    fm.appendChild(makeSVG('feMergeNode', { in: 'SourceGraphic' }));
    flt.appendChild(fb); flt.appendChild(fm);
    defs.appendChild(flt);
    svg.appendChild(defs);

    // Grid rings
    for (let l = 1; l <= levels; l++) {
        const r = (maxR / levels) * l;
        svg.appendChild(makeSVG('polygon', {
            points: ptsStr(r),
            fill: l % 2 === 0 ? 'rgba(255,255,255,0.04)' : 'none',
            stroke: 'rgba(255,255,255,0.1)',
            'stroke-width': '0.7',
        }));
    }

    // Axis lines
    for (let i = 0; i < n; i++) {
        const [x, y] = pt(i, maxR);
        svg.appendChild(makeSVG('line', {
            x1: cx, y1: cy,
            x2: x.toFixed(2), y2: y.toFixed(2),
            stroke: 'rgba(255,255,255,0.12)',
            'stroke-width': '1',
        }));
    }

    // Data polygon (glow shadow)
    const dataPtsArr = dataPoints.map((d, i) => pt(i, (Math.min(d.value, 100) / 100) * maxR).map(v => v.toFixed(2)).join(','));
    const dataPts = dataPtsArr.join(' ');

    svg.appendChild(makeSVG('polygon', {
        points: dataPts,
        fill: fillColor,
        stroke: strokeColor,
        'stroke-width': '2',
        'stroke-linejoin': 'round',
        filter: `url(#${fid})`,
    }));

    // Data dots
    dataPoints.forEach((d, i) => {
        const [x, y] = pt(i, (Math.min(d.value, 100) / 100) * maxR);
        svg.appendChild(makeSVG('circle', {
            cx: x.toFixed(2), cy: y.toFixed(2), r: '3.5',
            fill: strokeColor,
            stroke: 'rgba(255,255,255,0.5)',
            'stroke-width': '1.2',
        }));
    });

    // Labels (tier + stat name)
    const labelR = maxR + 30;
    dataPoints.forEach((d, i) => {
        const tier = getTierLabel(d.value);
        const tColor = getTierColor(tier);
        const [lx, ly] = pt(i, labelR);

        // Text anchor based on horizontal direction
        const cosA = Math.cos(startA + i * step);
        const anchor = cosA > 0.2 ? 'start' : cosA < -0.2 ? 'end' : 'middle';

        // Tier
        svg.appendChild(svgText({
            x: lx.toFixed(2), y: (ly - 9).toFixed(2),
            'text-anchor': anchor,
            'dominant-baseline': 'middle',
            fill: tColor,
            'font-size': '9',
            'font-family': 'Cinzel, serif',
            'font-weight': '700',
        }, tier));

        // Stat label
        svg.appendChild(svgText({
            x: lx.toFixed(2), y: (ly + 4).toFixed(2),
            'text-anchor': anchor,
            'dominant-baseline': 'middle',
            fill: 'rgba(220,200,170,0.9)',
            'font-size': '10.5',
            'font-family': 'Cinzel, serif',
            'font-weight': '600',
        }, d.label));
    });

    // Center dot
    svg.appendChild(makeSVG('circle', { cx, cy, r: '2.5', fill: 'rgba(255,255,255,0.3)' }));
}

// ── Hero Page State ───────────────────────────
let currentHero = null;
let currentVersion = null;

// ── Load ─────────────────────────────────────
function loadHeroPage() {
    const params = new URLSearchParams(window.location.search);
    const heroId = params.get('id');

    if (!heroId || typeof HEROES_DATA === 'undefined') { showHeroError('Herói não encontrado.'); return; }

    currentHero = HEROES_DATA.find(h => h.id === heroId);
    if (!currentHero) { showHeroError(`Herói "${heroId}" não encontrado.`); return; }

    document.title = `${currentHero.nome} — ${currentHero.alcunha} | D&D 5e Homebrew`;

    renderHeroBase(currentHero);
    renderVersionButtons(currentHero);

    const defaultVerId = currentHero.versaoAtual || currentHero.versoes[currentHero.versoes.length - 1].id;
    switchVersion(defaultVerId);
}

// ── Render base (static info) ─────────────────
function renderHeroBase(h) {
    // Photo / icon
    const photoEl = document.getElementById('heroPhoto');
    if (photoEl) {
        photoEl.innerHTML = h.imagem
            ? `<img src="${h.imagem}" alt="${h.nome}" onerror="this.parentElement.innerHTML='<span class=hero-page-fallback>${h.icone}</span>'">`
            : `<span class="hero-page-fallback">${h.icone}</span>`;
    }

    // Texts
    setHP('heroPageNome', h.nome);
    setHP('heroPageAlcunha', `"${h.alcunha}"`);

    // Category badge
    const cat = (typeof HERO_CATEGORIAS !== 'undefined' && HERO_CATEGORIAS[h.categoria]) || { label: h.categoria, cor: '#c9a96e', bg: 'rgba(180,130,40,.15)', borda: 'rgba(200,160,60,.3)' };
    const catEl = document.getElementById('heroPageCategoria');
    if (catEl) {
        catEl.textContent = cat.label;
        catEl.style.cssText = `color:${cat.cor};background:${cat.bg};border:1px solid ${cat.borda}`;
    }

    // Meta grid
    const metaEl = document.getElementById('heroPageMeta');
    if (metaEl) {
        metaEl.innerHTML = [
            { lbl: 'Nível', val: h.nivel },
            { lbl: 'Classe', val: h.classe },
            { lbl: 'Espécie', val: h.especie },
            { lbl: 'Plano de Origem', val: h.planoDeOrigem },
            { lbl: 'Tempo', val: h.tempo },
        ].map(m => `
            <div class="hmeta-item">
                <span class="hmeta-lbl">${m.lbl}</span>
                <span class="hmeta-val">${m.val}</span>
            </div>`).join('');
    }

    // História
    const histEl = document.getElementById('heroPageHistoria');
    if (histEl) {
        histEl.innerHTML = h.historia
            .split('\n\n')
            .filter(p => p.trim())
            .map(p => `<p>${p.trim()}</p>`)
            .join('');
    }
}

// ── Version buttons ───────────────────────────
function renderVersionButtons(h) {
    const container = document.getElementById('heroVersionBtns');
    if (!container) return;
    container.innerHTML = h.versoes.map(v => `
        <button class="ver-btn" data-ver="${v.id}" onclick="switchVersion('${v.id}')">
            <span class="ver-btn-icon">${v.icone}</span>
            <span class="ver-btn-nome">${v.nome}</span>
        </button>`).join('');
}

// ── Switch version (updates dynamic content) ──
function switchVersion(verId) {
    const h = currentHero;
    if (!h) return;

    const version = h.versoes.find(v => v.id === verId);
    if (!version) return;

    currentVersion = version;

    // Activate button
    document.querySelectorAll('.ver-btn').forEach(b => {
        b.classList.toggle('active', b.dataset.ver === verId);
    });

    // Version description
    setHP('heroVersionDesc', version.descricao || '');

    // Radar data
    const attrData = Object.entries(version.atributos).map(([label, value]) => ({ label, value }));
    const powData = Object.entries(version.poderesStat).map(([label, value]) => ({ label, value }));

    // Fade + draw
    fadeAndDraw('radarAtributos', attrData, { strokeColor: '#e05555', fillColor: 'rgba(200,50,50,0.28)' });
    fadeAndDraw('radarPoderes', powData, { strokeColor: '#5090e8', fillColor: 'rgba(50,100,220,0.28)' });

    // Powers
    renderPoderes(version.poderesMaiores);
}

function fadeAndDraw(svgId, data, opts) {
    const el = document.getElementById(svgId);
    if (!el) return;
    el.style.transition = 'opacity 0.2s ease';
    el.style.opacity = '0';
    setTimeout(() => {
        drawRadar(svgId, data, opts);
        el.style.opacity = '1';
    }, 200);
}

// ── Powers ────────────────────────────────────
let activePowerBtn = null;

function renderPoderes(poderes) {
    const container = document.getElementById('poderesMaioresArea');
    if (!container) return;

    activePowerBtn = null;
    container.innerHTML = '';

    if (!poderes || !poderes.length) {
        container.innerHTML = '<p class="poderes-empty">Nenhum poder registrado nesta versão.</p>';
        return;
    }

    // Button row
    const btnRow = document.createElement('div');
    btnRow.className = 'poderes-btn-row';
    poderes.forEach((p, i) => {
        const btn = document.createElement('button');
        btn.className = 'poder-btn';
        btn.innerHTML = `<span class="poder-btn-icon">${p.icone}</span><span class="poder-btn-nome">${p.nome}</span>`;
        btn.onclick = () => togglePoder(btn, p, contentArea);
        btnRow.appendChild(btn);
    });

    // Content area
    const contentArea = document.createElement('div');
    contentArea.className = 'poder-content';
    contentArea.id = 'poderContentArea';

    container.appendChild(btnRow);
    container.appendChild(contentArea);

    // Auto-open first
    setTimeout(() => btnRow.firstElementChild?.click(), 50);
}

function togglePoder(btn, poder, contentEl) {
    const isActive = btn.classList.contains('active');

    // Deactivate all
    document.querySelectorAll('.poder-btn').forEach(b => b.classList.remove('active'));

    if (isActive) {
        contentEl.innerHTML = '';
        contentEl.classList.remove('open');
        activePowerBtn = null;
        return;
    }

    activePowerBtn = btn;
    btn.classList.add('active');
    contentEl.classList.add('open');
    contentEl.innerHTML = `
        <div class="poder-detail">
            <div class="poder-detail-header">
                <span class="poder-detail-icon">${poder.icone}</span>
                <h3 class="poder-detail-nome">${poder.nome}</h3>
            </div>
            <p class="poder-detail-desc">${poder.descricao}</p>
        </div>`;
}

// ── Error ─────────────────────────────────────
function showHeroError(msg) {
    const main = document.getElementById('heroPageContent');
    if (main) main.innerHTML = `
        <div class="hero-page-error">
            <span>⚠️</span>
            <p>${msg}</p>
            <a href="html/compendium/compendium-heroes.html">← Voltar ao catálogo</a>
        </div>`;
}

// ── Utils ─────────────────────────────────────
function setHP(id, text) {
    const el = document.getElementById(id);
    if (el) el.textContent = text;
}

// ── Init ─────────────────────────────────────
document.addEventListener('DOMContentLoaded', loadHeroPage);
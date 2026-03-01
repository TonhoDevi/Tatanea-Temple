// Dice roller logic
function openDiceModal() {
    const modal = document.getElementById('diceModal');
    if (!modal) return;
    modal.setAttribute('aria-hidden', 'false');
}

function closeDiceModal() {
    const modal = document.getElementById('diceModal');
    if (!modal) return;
    modal.setAttribute('aria-hidden', 'true');
}

function rollDiceOnce(sides) {
    return Math.floor(Math.random() * sides) + 1;
}

function rollDice(count, sides) {
    const rolls = [];
    for (let i = 0; i < count; i++) rolls.push(rollDiceOnce(sides));
    return rolls;
}

function renderResults(rolls) {
    const list = document.getElementById('resultsList');
    const sumEl = document.getElementById('resultsSum');
    list.innerHTML = '';
    const sum = rolls.reduce((a,b)=>a+b,0);
    const activeTypeBtn = document.querySelector('.die-btn.active');
    const typeClass = activeTypeBtn ? activeTypeBtn.classList[1] : 'die-d20';
    rolls.forEach(r => {
        const el = document.createElement('button');
        el.className = `result-item ${typeClass}`;
        el.type = 'button';
        el.textContent = r;
        list.appendChild(el);
    });
    sumEl.textContent = `Total: ${sum}`;
}

function clearResults() {
    document.getElementById('resultsList').innerHTML = '';
    document.getElementById('resultsSum').textContent = '';
}

function initDiceRoller() {
    const openBtn = document.getElementById('openDiceBtn');
    const closeBtn = document.getElementById('closeDiceBtn');
    const rollBtn = document.getElementById('rollDiceBtn');
    const clearBtn = document.getElementById('clearDiceBtn');

    if (openBtn) openBtn.addEventListener('click', (e)=>{ e.preventDefault(); openDiceModal(); });
    if (closeBtn) closeBtn.addEventListener('click', closeDiceModal);
    if (rollBtn) rollBtn.addEventListener('click', ()=>{
        const qty = parseInt(document.getElementById('diceQty').textContent) || 1;
        const active = document.querySelector('.die-btn.active');
        const sides = active ? parseInt(active.dataset.sides,10) : 20;
        const rolls = rollDice(qty, sides);
        renderResults(rolls);
    });
    if (clearBtn) clearBtn.addEventListener('click', clearResults);

    // spinner buttons
    const qtyUp = document.getElementById('qtyUp');
    const qtyDown = document.getElementById('qtyDown');
    const qtyDisplay = document.getElementById('diceQty');
    if (qtyUp) qtyUp.addEventListener('click', ()=>{ qtyDisplay.textContent = Math.min(999, parseInt(qtyDisplay.textContent||'1')+1); });
    if (qtyDown) qtyDown.addEventListener('click', ()=>{ qtyDisplay.textContent = Math.max(1, parseInt(qtyDisplay.textContent||'1')-1); });

    // die type buttons
    const dieBtns = document.querySelectorAll('.die-btn');
    dieBtns.forEach(b=>{
        b.addEventListener('click', ()=>{
            dieBtns.forEach(x=>x.classList.remove('active'));
            b.classList.add('active');
        });
    });

    // close modal on overlay click
    const modal = document.getElementById('diceModal');
    if (modal) modal.addEventListener('click', (e)=>{
        if (e.target === modal) closeDiceModal();
    });

    // keyboard ESC to close
    document.addEventListener('keydown', (e)=>{
        if (e.key === 'Escape') closeDiceModal();
    });
}

window.addEventListener('DOMContentLoaded', initDiceRoller);

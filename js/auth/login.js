// ── PARTÍCULAS ───────────────────────────────────────────
(function spawnParticles() {
    const container = document.getElementById('particles');
    for (let i = 0; i < 18; i++) {
        const p = document.createElement('div');
        p.className = 'particle';
        p.style.cssText = `
            left: ${Math.random() * 100}%;
            width: ${1 + Math.random() * 2}px;
            height: ${1 + Math.random() * 2}px;
            animation-duration: ${6 + Math.random() * 10}s;
            animation-delay: ${Math.random() * 8}s;
            opacity: ${0.2 + Math.random() * 0.5};
        `;
        container.appendChild(p);
    }
})();

// ── TABS ─────────────────────────────────────────────────
window.switchAuthTab = function(tab) {
    document.querySelectorAll('.auth-tab').forEach((t, i) => {
        t.classList.toggle('active', (i === 0 && tab === 'login') || (i === 1 && tab === 'register'));
    });
    document.getElementById('pane-login').classList.toggle('active', tab === 'login');
    document.getElementById('pane-register').classList.toggle('active', tab === 'register');
    hideMessage();
}

// ── FEEDBACK ─────────────────────────────────────────────
function showMessage(text, type = 'error') {
    const el = document.getElementById('authMessage');
    el.textContent = text;
    el.className = `auth-message ${type}`;
}
function hideMessage() {
    document.getElementById('authMessage').className = 'auth-message';
}

// ── FORÇA DA SENHA ────────────────────────────────────────
window.checkPasswordStrength = function(val) {
    const bar = document.getElementById('strengthBar');
    bar.className = 'password-strength-bar';
    if (!val) return;
    if (val.length < 6) bar.classList.add('strength-weak');
    else if (val.length < 10 || !/[A-Z]/.test(val) || !/[0-9]/.test(val))
        bar.classList.add('strength-medium');
    else bar.classList.add('strength-strong');
}

// ── LOADING STATE ─────────────────────────────────────────
function setLoading(btnId, loading) {
    const btn = document.getElementById(btnId);
    btn.disabled = loading;
    btn.innerHTML = loading
        ? '<span class="btn-spinner"></span> Aguarde...'
        : (btnId === 'loginBtn' ? 'Adentrar o Templo' : 'Jurar ao Templo');
}

// ── LOGIN ────────────────────────────────────────────────
window.handleLogin = async function() {
    hideMessage();
    const email = document.getElementById('loginEmail').value.trim();
    const password = document.getElementById('loginPassword').value;

    if (!email || !password) {
        showMessage('Preencha e-mail e senha.');
        return;
    }

    setLoading('loginBtn', true);

    const { error } = await sb.auth.signInWithPassword({ email, password });

    setLoading('loginBtn', false);

    if (error) {
        const msgs = {
            'Invalid login credentials': 'E-mail ou senha incorretos.',
            'Email not confirmed': 'Confirme seu e-mail antes de entrar.',
        };
        showMessage(msgs[error.message] || error.message);
        return;
    }

    // Redireciona para o início
    const redirect = sessionStorage.getItem('redirectAfterLogin') || '/index.html';
    sessionStorage.removeItem('redirectAfterLogin');
    window.location.href = redirect;
}

// ── REGISTRO ──────────────────────────────────────────────
window.handleRegister = async function() {
    hideMessage();
    const email = document.getElementById('regEmail').value.trim();
    const password = document.getElementById('regPassword').value;
    const confirm = document.getElementById('regConfirm').value;

    if (!email || !password || !confirm) {
        showMessage('Preencha todos os campos.');
        return;
    }
    if (password.length < 6) {
        showMessage('A senha precisa ter pelo menos 6 caracteres.');
        return;
    }
    if (password !== confirm) {
        showMessage('As senhas não coincidem.');
        return;
    }

    setLoading('registerBtn', true);

    const { error } = await sb.auth.signUp({ email, password });

    setLoading('registerBtn', false);

    if (error) {
        const msgs = {
            'User already registered': 'Este e-mail já está cadastrado.',
        };
        showMessage(msgs[error.message] || error.message);
        return;
    }

    showMessage(
        '✅ Conta criada! Verifique seu e-mail para confirmar o cadastro.',
        'success'
    );
}

// ── ENTER KEY ─────────────────────────────────────────────
document.addEventListener('keydown', e => {
    if (e.key !== 'Enter') return;
    if (document.getElementById('pane-login').classList.contains('active')) handleLogin();
    else handleRegister();
});

// ── SE JÁ ESTIVER LOGADO, REDIRECIONA ────────────────────
(async () => {
    const user = await getUser();
    if (user) window.location.href = '/index.html';
})();

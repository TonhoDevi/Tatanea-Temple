// ═══════════════════════════════════════════════════════════════
//  cloud-save.js  —  Templo de Tatânea
//  Múltiplas fichas por usuário (máximo 5 no total)
//  Coloque em: js/shared/cloud-save.js
// ═══════════════════════════════════════════════════════════════

const LIMITE_FICHAS = 5;

// ── ID DA FICHA ATIVA ────────────────────────────────────────────
function getActiveSheetId(tipo)     { return sessionStorage.getItem('activeSheet_' + tipo) || null; }
function setActiveSheetId(tipo, id) { sessionStorage.setItem('activeSheet_' + tipo, id); }
function clearActiveSheetId(tipo)   { sessionStorage.removeItem('activeSheet_' + tipo); }

// ── SALVAR FICHA NA NUVEM ────────────────────────────────────────
async function cloudSave(tipo, dados, nome) {
    const user = await getUser();
    if (!user) return { error: 'Nao autenticado' };

    const nomeFinal = (nome || 'Sem nome').trim() || 'Sem nome';
    const activeId  = getActiveSheetId(tipo);

    if (activeId) {
        // UPDATE — ficha já existe, só atualiza
        const result = await sb.from('fichas')
            .update({ nome: nomeFinal, dados })
            .eq('id', activeId)
            .eq('user_id', user.id)
            .select().single();
        return result;
    }

    // NOVO COMPORTAMENTO: Não cria automaticamente. Retorna erro indicando que é necessária ação manual
    // showSaveIndicator('Para salvar uma ficha nova, use o menu "Salvar como Nova"', true);
    return { error: 'sem_id_ativo_use_menu' };
}

// ── SALVAR COMO NOVA FICHA (AÇÃO MANUAL) ─────────────────────────
async function cloudSaveNew(tipo, dados, nome) {
    const user = await getUser();
    if (!user) return { error: 'Nao autenticado' };

    const nomeFinal = (nome || 'Sem nome').trim() || 'Sem nome';

    // Verifica o limite antes de criar
    const { count } = await sb.from('fichas')
        .select('id', { count: 'exact', head: true })
        .eq('user_id', user.id);

    if (count >= LIMITE_FICHAS) {
        showSaveIndicator('Limite de ' + LIMITE_FICHAS + ' fichas atingido!', true);
        return { error: 'limite_atingido' };
    }

    // Cria nova ficha
    const result = await sb.from('fichas')
        .insert({ user_id: user.id, tipo, nome: nomeFinal, dados })
        .select().single();

    if (result.data && result.data.id) {
        setActiveSheetId(tipo, result.data.id);
        showSaveIndicator('Nova ficha criada: ' + nomeFinal);
    }
    return result;
}

// ── CARREGAR FICHA ESPECÍFICA ────────────────────────────────────
async function cloudLoad(tipo) {
    const user = await getUser();
    if (!user) return null;
    const activeId = getActiveSheetId(tipo);
    if (!activeId) return null;
    const { data, error } = await sb.from('fichas')
        .select('*').eq('id', activeId).eq('user_id', user.id).single();
    if (error || !data) return null;
    return data.dados;
}

// ── LISTAR TODAS AS FICHAS ───────────────────────────────────────
async function cloudListAll(tipo) {
    const user = await getUser();
    if (!user) return [];
    let query = sb.from('fichas')
        .select('id, tipo, nome, atualizado_em')
        .eq('user_id', user.id)
        .order('atualizado_em', { ascending: false });
    if (tipo) query = query.eq('tipo', tipo);
    const { data, error } = await query;
    if (error) return [];
    return data || [];
}

// ── CONTAR FICHAS DO USUÁRIO ─────────────────────────────────────
async function cloudCount() {
    const user = await getUser();
    if (!user) return 0;
    const { count } = await sb.from('fichas')
        .select('id', { count: 'exact', head: true })
        .eq('user_id', user.id);
    return count || 0;
}

// ── VERIFICAR SE PODE CRIAR NOVA ─────────────────────────────────
async function cloudPodeCriarNova() {
    const total = await cloudCount();
    return total < LIMITE_FICHAS;
}

// ── DELETAR FICHA ────────────────────────────────────────────────
async function cloudDelete(tipo, id) {
    const user = await getUser();
    if (!user) return;
    const targetId = id || getActiveSheetId(tipo);
    if (!targetId) return;
    await sb.from('fichas').delete().eq('id', targetId).eq('user_id', user.id);
    if (!id || id === getActiveSheetId(tipo)) clearActiveSheetId(tipo);
}

// ── NOVA FICHA / ABRIR FICHA ─────────────────────────────────────
async function cloudNewSheet(tipo) {
    const user = await getUser();
    if (!user) return false;

    const total = await cloudCount();
    if (total >= LIMITE_FICHAS) {
        alert('Voce ja tem ' + LIMITE_FICHAS + ' fichas salvas.\nExclua uma antes de criar outra.');
        return false;
    }

    // Criar ficha vazia na database
    const fichaVazia = {
        nomePersonagem: 'Nova Ficha',
        nomeJogador: '',
        classeNivel: '',
        raca: '',
        antecedente: '',
        tendencia: '',
        inspiracao: false,
        pontoHeroico: false,
        forca: 10, destreza: 10, constituicao: 10, inteligencia: 10, sabedoria: 10, carisma: 10,
        profForca: false, profDestreza: false, profConstituicao: false, profInteligencia: false, profSabedoria: false, profCarisma: false,
        bonusProficiencia: 1,
        ca: 10, iniciativa: 0,
        deslocAndar: '30', deslocNadar: '15', deslocVoar: '-', deslocEscalar: '15', salto: '0',
        pvTotais: 0, pvAtuais: 0, pvTemp: 0,
        pc: 0, pe: 0, pl: 0, po: 0, pp: 0,
        idiomas: '', tesouro: '',
        habilidadeMagia: '', extraBonusMagia: 0, cdMagia: 8, bonusMagia: '+0',
        slot1Current: 0, slot1Max: 0, slot2Current: 0, slot2Max: 0, slot3Current: 0, slot3Max: 0,
        slot4Current: 0, slot4Max: 0, slot5Current: 0, slot5Max: 0, slot6Current: 0, slot6Max: 0,
        slot7Current: 0, slot7Max: 0, slot8Current: 0, slot8Max: 0, slot9Current: 0, slot9Max: 0,
        idade: '', altura: '', peso: '',
        caracteristicas: '', personalidade: '', ideais: '', vinculos: '', defeitos: '',
        historia: '', anotacoes: '',
        skillProficiencies: {},
        attacks: [], abilities: [], inventoryItems: [], magicItems: [], individualsUnit: [],
        spells: { truques: [], nivel1: [], nivel2: [], nivel3: [], nivel4: [], nivel5: [], nivel6: [], nivel7: [], nivel8: [], nivel9: [] },
        characterImage: null,
        persistTags: "[]"
    };

    try {
        // Insere nova ficha na database
        const { data, error } = await sb.from('fichas').insert({
            user_id: user.id,
            tipo: tipo,
            nome: 'Nova Ficha',
            dados: fichaVazia
        }).select().single();

        // Verifica se houve erro na operacao
        if (error) {
            console.error('Erro ao criar nova ficha:', error);
            alert('Erro ao criar nova ficha: ' + (error.message || error));
            return false;
        }

        // Verifica se os dados foram retornados corretamente
        if (!data || !data.id) {
            console.error('Resposta inválida do servidor:', data);
            alert('Erro: Ficha criada mas ID nao foi retornado.');
            return false;
        }

        // Define o ID da ficha ativa (CRUCIAL para o carregamento)
        setActiveSheetId(tipo, data.id);
        console.log('Nova ficha criada com ID:', data.id);
        
        return true;

    } catch (err) {
        console.error('Excecao ao criar nova ficha:', err);
        alert('Erro ao criar nova ficha: ' + err.message);
        return false;
    }
}

function cloudOpenSheet(tipo, id) { setActiveSheetId(tipo, id); }

// ── INDICADOR VISUAL ─────────────────────────────────────────────
function showSaveIndicator(msg, isError) {
    msg = msg || 'Salvo na nuvem';
    const el = document.getElementById('saveIndicator');
    if (!el) return;
    el.textContent = msg;
    el.style.background = isError ? 'rgba(180,40,40,0.85)' : '';
    el.classList.add('show');
    clearTimeout(el._timeout);
    el._timeout = setTimeout(function() {
        el.classList.remove('show');
        el.textContent = 'Salvo automaticamente';
        el.style.background = '';
    }, 2500);
}
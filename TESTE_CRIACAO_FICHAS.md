# Teste: Novo Sistema de Criação de Fichas

## ✅ Mudanças Implementadas

### 1. **cloud-save.js**
- ❌ Removido o INSERT automático quando não há ID ativo
- ✅ Adicionada função `cloudSaveNew()` para criar ficha **manualmente**
- ✅ Função `cloudSave()` agora retorna erro `sem_id_ativo_use_menu` se tentar salvar sem ID

### 2. **ddt-character.js (D&D 5e)**
- ✅ Modificado `saveCharacter()` para **NÃO criar** automaticamente
- ✅ Adicionada função `saveAsNewCharacter()` para salvar manualmente como nova ficha
- ✅ `autoSave()` agora é silencioso se não houver ID ativo

### 3. **mm-character.js (M&M 3e)**
- ✅ Modificado `mmSave()` com mesma lógica
- ✅ Adicionada função `mmSaveAsNew()` para salvar manualmente

### 4. **Interfaces HTML**
- ✅ `ddt-character-sheet.html` - Novos botões na aba Configurações
- ✅ `mem-character-sheet.html` - Novos botões na aba Sistema

---

## 🧪 ROTEIRO DE TESTE

### **Teste 1: Criar Nova Ficha (D&D 5e)**

1. Vá para **Meus Personagens**
2. Clique em **"⚔️ Nova Ficha D&D"**
3. **ESPERADO**: Você entra em branco, nada é salvo ainda ✅
4. Preencha alguns campos (nome, classe, atributos)
5. Espere 1.5s (autoSave)
6. **ESPERADO**: Nada é salvo na nuvem automaticamente! ✅
7. Vá para a aba **⚙️ Configurações**
8. Clique em **"✨ Salvar como Nova Ficha"**
9. **ESPERADO**: Dialogo pedindo confirmação aparece ✅
10. Confirme
11. **ESPERADO**: Alert "Personagem salvo com sucesso!" ✅
12. Volta para **Meus Personagens**
13. **ESPERADO**: Sua nova ficha aparece na lista 1x (não duplicada) ✅

---

### **Teste 2: Editar Ficha Existente**

1. Vá para **Meus Personagens**
2. Abra uma ficha que você criou no Teste 1
3. Mude o nome do personagem
4. **ESPERADO**: Nada se salva automaticamente por 1.5s ✅
5. Espere 1.5s passarem
6. **ESPERADO**: "Salvo na nuvem" aparece ✅
7. Feche e reabra a página
8. **ESPERADO**: Suas alterações estão lá ✅

---

### **Teste 3: Duplicação NÃO Ocorre**

1. Vá para **Meus Personagens**
2. Conte quantas fichas você tem (ex: 3 fichas)
3. Clique em **"⚔️ Nova Ficha D&D"** (sem salvar)
4. Feche a aba
5. Volte para **Meus Personagens**
6. **ESPERADO**: Número de fichas **não mudou** (ainda 3) ✅
7. **NÃO há duplicatas** ✅

---

### **Teste 4: Fluxo M&M (Mutantes & Malfeitores)**

1. Vá para **Meus Personagens**
2. Clique em **"🦸 Nova Ficha M&M"**
3. Preencha o nome do herói e alguns dados
4. Espere 1.5s
5. **ESPERADO**: Nada é salvo automaticamente ✅
6. Vá para aba **⚙️ Sistema**
7. Clique em **"✨ Salvar como Nova Ficha"**
8. Confirme
9. **ESPERADO**: Herói criado com sucesso! ✅
10. Volta para **Meus Personagens**
11. **ESPERADO**: Seu novo herói aparece 1x (não duplicado) ✅

---

### **Teste 5: Limite de 5 Fichas**

1. Crie 5 fichas (combinando D&D + M&M)
2. Tente criar a 6ª
3. **ESPERADO**: Alert "Limite de 5 fichas atingido!" ✅
4. **ESPERADO**: Botão ➕ fica desabilitado ✅

---

## 🔍 Se Algo Não Funcionar

### Sintomas Esperados vs Reais:

| Sintoma | Esperado | Real |
|---------|----------|------|
| Ficha em branco após clicar "Nova Ficha" | Sim | [ ] |
| AutoSave é silencioso nos primeiros 1.5s | Sim | [ ] |
| Botão "Salvar como Nova" aparece | Sim | [ ] |
| Nova ficha NÃO duplica | Sim | [ ] |
| Ficha é salva após confirmação | Sim | [ ] |
| Reabrir ficha mantém dados | Sim | [ ] |

---

## 📝 Log do Console

Abra **F12 → Console** e procure por:

1. **Erro**: `cloudSave D&D: sem_id_ativo_use_menu` → OK, ficha sem ID ✅
2. **Sucesso**: `Salvo na nuvem` → Ficha atualizada ✅
3. **Sucesso**: `Nova ficha criada:` → Ficha criada manualmente ✅

---

## 🎉 Conclusão

Se todos os testes passarem, o problema de **duplicação automática foi resolvido**!

Agora a criação de fichas é **100% manual**:
- ✅ Botão "Nova Ficha" → Entra em branco
- ✅ Edita sem criar automaticamente
- ✅ Clica "Salvar como Nova" → Cria 1 ficha apenas
- ✅ Reabrir página → Carrega a ficha existente (sem duplicar)

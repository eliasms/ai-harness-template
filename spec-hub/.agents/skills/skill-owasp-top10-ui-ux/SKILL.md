---
name: skill-owasp-top10-ui-ux
description: Validação de Segurança em UI/UX e Design de Interfaces baseada no OWASP Clickjacking Defense Cheat Sheet, OWASP ASVS (Presentation Layer) e OWASP Top 10 Privacy Risks.
---

# Skill: Validação de Segurança em UI/UX e Interfaces OWASP (`skill-owasp-top10-ui-ux`)

## 1. Fonte Oficial e Fundamentação Teórica
Esta skill é fundamentada exclusivamente nos padrões e publicações do **OWASP (owasp.org)**:
- **OWASP Clickjacking Defense Cheat Sheet:** Defesa completa contra ataques de UI Redressing (Clickjacking) via cabeçalhos CSP e atributos de cookies.
- **OWASP Application Security Verification Standard (ASVS v4.0.3):** Requisitos de segurança para apresentação, formulários e sessões.
- **OWASP Top 10 Privacy Risks Project:** Riscos de privacidade em interfaces (P4 Consentimento Inapropriado, P5 Termos Não Transparentes, P10 Minimização de Dados).
- **OWASP HTML5 Security Cheat Sheet:** Segurança em elementos `<canvas>`, CORS e sanitização de dados gráficos.

---

## 2. Escopo do Agente UI/UX Engineer
O **Agente UI/UX Engineer** projeta e implementa as interfaces do {{PROJECT_NAME}} em Angular moderno (Signals, OnPush, Design Tokens, Canvas/visualizações de domínio, componentes acessíveis WCAG 2.1 AA).

---

## 3. Matriz de Controles OWASP para UI/UX

### 3.1. Prevenção Contra Clickjacking e UI Redressing (OWASP Clickjacking Defense)
- **Ameaça OWASP:** Um atacante renderiza o {{PROJECT_NAME}} dentro de um `<iframe>` transparente sobre uma página maliciosa, induzindo o usuário logado a clicar em botões como "Excluir Projeto", "Revogar Token" ou "Aprovar Tradução".
- **Diretrizes Obrigatórias de Design e Implementação:**
  1. **Cabeçalho CSP `frame-ancestors`:**
     - Garantir que o servidor web/Nginx envie:
       ```http
       Content-Security-Policy: frame-ancestors 'none';
       X-Frame-Options: DENY
       ```
  2. **Confirmação em Duas Etapas para Ações Destrutivas (Double-Confirmation Pattern):**
     - Ações com impacto crítico (excluir projeto, apagar coleções inteiras) exigem diálogo modal de confirmação acessível (`@angular/cdk/a11y` `FocusTrap`), com digitação explícita do nome do projeto ou botão de confirmação com atraso intencional (*button countdown*) de 500ms para evitar cliques acidentais rápidos.
  3. **Separação Visual Clara de Botões de Ação:**
     - Espaçamento mínimo de 12px entre botões destrutivos (*Danger*) e botões de ação primária (*Primary*), eliminando zonas ambíguas de clique.

### 3.2. Segurança e Isolamento do Elemento Canvas HTML5 (Tainted Canvas Prevention)
- **Ameaça OWASP / HTML5:** Ao desenhar imagens em `<canvas>` provenientes de origens cruzadas sem configuração de CORS segura, o Canvas torna-se *tainted* (contaminado). Isso pode permitir exfiltração de dados de imagem ou quebrar a capacidade de exportação `.toDataURL()` / `.toBlob()`.
- **Diretrizes Obrigatórias no Estúdio de Revisão:**
  - Todas as requisições de imagens no Canvas devem carregar a imagem com atributo `crossOrigin = 'anonymous'`:
  ```typescript
  const img = new Image();
  img.crossOrigin = 'anonymous';
  img.src = pageImageUrl;
  img.onload = () => {
    ctx.drawImage(img, 0, 0);
  };
  ```
  - As URLs de imagens devem vir estritamente da mesma origem (`/api/v1/...`) ou de domínio armazenamento de objetos/S3 explicitamente liberado no CORS do backend.

### 3.3. Mascaramento e Proteção Visual de Dados Sensíveis (ASVS Presentation Layer)
- **Ameaça OWASP:** Exposição inadvertida de segredos de MFA TOTP, chaves de API de provedores externos ou senhas visíveis para espectadores ou gravações de tela.
- **Diretrizes de UI Obrigatórias:**
  - **Setup de MFA TOTP:** O segredo Base32 deve ser exibido mascarado por padrão (`••••••••`), com botão de alternância explícito "Visualizar Segredo" e botão dedicado "Copiar".
  - **Códigos de Recuperação:** Exibidos dentro de um container protegido com aviso de segurança visual ("Copie e guarde em local seguro. Estes códigos não serão exibidos novamente").
  - **Inputs de Chave de API:** Configurados obrigatoriamente com `type="password"`, suporte a toggle de visibilidade e limpeza automática de clipboard após 60 segundos se o browser suportar.

### 3.4. Prevenção de Enumeração em Mensagens de Erro de Interface (ASVS V2 / V3)
- **Ameaça OWASP:** Interfaces exibindo mensagens detalhadas que permitam a um atacante mapear usuários existentes (ex: *"E-mail não cadastrado"* vs *"Senha incorreta"*).
- **Diretrizes de UI Obrigatórias:**
  - Telas de Login e Esqueci Minha Senha devem exibir mensagens genéricas e neutras:
    - *"E-mail ou credencial incorreta."*
    - *"Se o e-mail estiver cadastrado, as instruções serão processadas."*
  - Mensagens de erro em formulários devem ser acessíveis (`aria-live="polite"`, `role="alert"`), sem vazar exceções de banco de dados ou detalhes de infraestrutura.

### 3.5. Transparência, Consentimento e Minimização (OWASP Top 10 Privacy Risks - P4, P5, P10)
- **Ameaça OWASP:** Falta de clareza para o usuário sobre para onde os dados estão sendo enviados (IA em nuvem vs local).
- **Diretrizes de UI Obrigatórias:**
  - **Badge de Status de IA Transparente:**
    - Exibir claramente no cabeçalho ou barra de status o motor ativo:
      - 🟢 **Modo Local/Offline:** *"Privacidade Total: nenhum dado sai da sua máquina."*
      - 🟡 **Provedor Cloud Ativo:** *"Os dados são enviados para a API externa do provedor configurado."*
  - **Minimização de Coleta:** Formulários de cadastro contendo exclusivamente os campos indispensáveis (E-mail e Senha).

---

## 4. Checklist de UI/UX Seguro para o Agente
- [ ] O aplicativo é protegido contra Clickjacking (`frame-ancestors 'none'`).
- [ ] Ações destrutivas possuem confirmação modal com foco aprisionado (`FocusTrap`).
- [ ] Todo Canvas carrega imagens com `crossOrigin = 'anonymous'` sem tainting.
- [ ] Segredos de MFA e senhas possuem mascaramento visual e opção segura de revelação.
- [ ] Mensagens de login e recuperação não permitem enumeração de contas de usuário.
- [ ] O status de privacidade do motor de IA (Local vs Nuvem) é visível de forma transparente.

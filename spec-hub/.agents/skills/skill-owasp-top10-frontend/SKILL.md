---
name: skill-owasp-top10-frontend
description: Validação de Segurança Front-End (Angular 22 / SPA / Client-Side) baseada no OWASP Top 10:2021 e OWASP Top 10 Client-Side Security Risks.
---

# Skill: Validação de Segurança Front-End Angular 22 (`skill-owasp-top10-frontend`)

## 1. Fonte Oficial e Fundamentação Teórica
Esta skill é fundamentada exclusivamente nos padrões e publicações do **OWASP (owasp.org)**:
- **OWASP Top 10 Client-Side Security Risks:** Projeto dedicado aos riscos de execução no navegador (DOM-Based XSS, Broken Client-Side Access Control, Sensitive Data Leakage, Third-Party Supply Chain).
- **OWASP Top 10:2021:** A03:2021 (Injection / Cross-Site Scripting), A01:2021 (Broken Access Control), A05:2021 (Security Misconfiguration), A07:2021 (Identification & Auth Failures), A08:2021 (Software and Data Integrity Failures).
- **OWASP Cross-Site Scripting Prevention Cheat Sheet** e **OWASP HTML5 Security Cheat Sheet**.

---

## 2. Escopo do Agente Executor Angular 22
O **Agente Executor Angular 22** constrói o SPA no repositório `{{PROJECT_SLUG}}-frontend-angular` (Signals Zoneless, Standalone Components, componentes de domínio, tempo real (se previsto no contrato) e OnPush).

---

## 3. Matriz de Controles OWASP Client-Side no Angular 22

### 3.1. Eliminação Absoluta de DOM-Based XSS (OWASP A03:2021 / Client-Side Risks)
- **Risco:** Injeção de scripts maliciosos através do texto extraído de arquivos/OCR, campos de entrada de formulários ou mensagens de erro.
- **Implementação Obrigatória:**
  - **Uso Exclusivo da Interpolação Padrão:** Renderizar texto vindo de APIs, OCR ou IA via interpolação segura `{{ item.text }}` ou property binding `[textContent]="item.text"`.
  - **Proibição de `[innerHTML]` não sanitizado:** É estritamente proibido usar `[innerHTML]` para injetar strings vindas de OCR, APIs ou inputs de usuário. Se formatação rica for indispensável, deve-se usar sanitizador com whitelist de tags estritas.
  - **Proibição de `DomSanitizer.bypassSecurityTrust*`:** Proibido o uso de `bypassSecurityTrustHtml`, `bypassSecurityTrustScript` ou `bypassSecurityTrustUrl` em dados recebidos do backend ou do usuário.

### 3.2. Broken Client-Side Access Control (OWASP A01:2021 / Client-Side Risks)
- **Risco:** Confiar apenas em `CanActivateFn` e ocultação condicional (`@if (isAdmin())`) para restringir acesso a recursos protegidos.
- **Implementação Obrigatória:**
  - Reconhecer que o código no navegador do usuário pode ser inspecionado e modificado via DevTools. Os Guards do Angular servem para navegação e UX, **nunca como mecanismo de autorização final**.
  - Todo componente ou serviço que execute ações sensíveis (ex: aprovar item, exportar artefato gerado, excluir registros) deve tratar respostas HTTP `401 Unauthorized` e `403 Forbidden` do backend de forma resiliente, redirecionando o usuário para login ou estado de erro seguro.

### 3.3. Sensitive Data Leakage & Armazenamento Seguro de Tokens (OWASP A07:2021)
- **Risco:** Armazenar segredos de MFA TOTP (Base32), códigos de recuperação ou senhas em `localStorage` ou `sessionStorage`, onde scripts de terceiros podem acessá-los.
- **Implementação Obrigatória:**
  - Segredos temporários de onboarding de MFA e códigos de recuperação devem ser mantidos apenas em memória via Signals (`signal<string[] | null>(null)`) durante o fluxo de setup e imediatamente limpos após a confirmação.
  - Ao executar `logout()`, limpar explicitamente todos os Signals de estado, caches locais e desconectar instâncias ativas do SignalR (`hubConnection.stop()`).

### 3.4. Content Security Policy (CSP) e Configurações de Segurança (OWASP A05:2021)
- **Risco:** Carregamento de scripts ou fontes maliciosas de terceiros e vazamento de conexões WebSocket.
- **Implementação Obrigatória:**
  - O aplicativo distribuído via Nginx/estático deve implementar cabeçalho CSP estrito:
  ```http
  Content-Security-Policy: default-src 'self'; script-src 'self'; style-src 'self' 'unsafe-inline'; img-src 'self' data: blob:; connect-src 'self' ws: wss:; font-src 'self'; object-src 'none'; frame-ancestors 'none'; base-uri 'self';
  ```
  - Proibir inclusão de scripts de CDN sem verificação de hash Subresource Integrity (SRI) ou preferir empacotar todas as dependências localmente via `package.json`.

### 3.5. Gestão de Dependências e Integridade da Cadeia de Suprimentos (OWASP A08:2021)
- **Risco:** Dependências npm desatualizadas ou vulneráveis (supply chain attack).
- **Implementação Obrigatória:**
  - Build limpo com auditoria de segurança obrigatória (`npm audit --audit-level=high`).
  - Fixação de versões via `package-lock.json`. Proibir o uso de flags de instalação inseguras como `--force` ou `--legacy-peer-deps` sem justificativa formal.

### 3.6. Segurança de Conexão em Tempo Real (SignalR)
- **Risco:** Conectar sockets SignalR sem autenticação ou transmitindo tokens em URLs não seguras.
- **Implementação Obrigatória:**
  - O `HubConnectionBuilder` deve configurar o `accessTokenFactory` retornando o Bearer token JWT em memória:
  ```typescript
  this.hubConnection = new HubConnectionBuilder()
    .withUrl('/api/v1/hubs/translation-progress', {
      accessTokenFactory: () => this.authService.getAccessToken(),
      transport: HttpTransportType.WebSockets
    })
    .withAutomaticReconnect()
    .build();
  ```

---

## 4. Checklist de Validação para o Agente Angular 22
- [ ] Nenhum componente utiliza `DomSanitizer.bypassSecurityTrustHtml` em textos de balões ou inputs.
- [ ] Todo texto dinâmico (incluindo Canvas, se existir) e cards é renderizado sem interpolação HTML bruta.
- [ ] Segredos de MFA TOTP e códigos de backup são mantidos apenas em memória reativa e descartados após o setup.
- [ ] Logout limpa o estado da aplicação e encerra a conexão SignalR.
- [ ] O `npm audit` não acusa vulnerabilidades de severidade Alta ou Crítica.
- [ ] Guards de rotas tratam falhas de autorização do backend sem loop infinito de redirecionamento.

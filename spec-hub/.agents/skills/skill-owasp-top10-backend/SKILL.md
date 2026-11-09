---
name: skill-owasp-top10-backend
description: Validação de Segurança de Back-End (.NET 10 / C# 14 / Web API) baseada no OWASP Top 10:2021 e OWASP API Security Top 10:2023.
---

# Skill: Validação de Segurança de Back-End .NET 10 (`skill-owasp-top10-backend`)

## 1. Fonte Oficial e Fundamentação Teórica
Esta skill é fundamentada exclusivamente nos padrões e publicações do **OWASP (owasp.org)**:
- **OWASP API Security Top 10 (2023):** Padrão de segurança específico para APIs modernas REST/GraphQL.
- **OWASP Top 10:2021:** Categorias centrais de risco para aplicações web (A01: Broken Access Control, A02: Cryptographic Failures, A03: Injection, A07: Identification & Auth Failures, A10: SSRF).
- **OWASP Cheat Sheet Series:** *.NET Security Cheat Sheet*, *REST Security Cheat Sheet* e *Authorization Cheat Sheet*.

---

## 2. Escopo do Agente Executor .NET 10
O **Agente Executor .NET 10** é responsável por implementar a Solution `{{PROJECT_NAME}}.sln` com C# 14, Clean Architecture, EF Core 10, ASP.NET Core Web API e SignalR.

---

## 3. Mapeamento OWASP API Security Top 10 (2023) no Back-End

### API1:2023 — Broken Object Level Authorization (BOLA)
- **Risco:** Usuários manipularem IDs de rotas (ex: `/api/v1/projects/{id}`) para acessar ou modificar recursos (projetos, arquivos, registros) pertencentes a outros usuários ou tenants.
- **Implementação Obrigatória:**
  - Em todos os controllers e comandos MediatR/serviços de aplicação, validar se a entidade recuperada pertence ao usuário autenticado:
  ```csharp
  var project = await _dbContext.Projects
      .FirstOrDefaultAsync(p => p.Id == projectId && p.UserId == currentUserId, cancellationToken);
  if (project == null) return Result.Failure(Error.NotFound("Project.NotFound", "Projeto não encontrado ou acesso não autorizado."));
  ```

### API2:2023 — Broken Authentication / A07:2021 — Identification and Authentication Failures
- **Risco:** Tokens JWT fracos, falta de validação de assinatura, segredos de MFA TOTP previsíveis ou bypass de autenticação vazado em produção.
- **Implementação Obrigatória:**
  - Tokens JWT emitidos com chave simétrica forte ($\ge 256$ bits via `JwtBearer:Key`), validando rigorosamente `ValidateIssuer`, `ValidateAudience`, `ValidateLifetime` e `ClockSkew = TimeSpan.Zero`.
  - Segredos TOTP (RFC 6238) gerados com gerador criptograficamente seguro (`RandomNumberGenerator.GetBytes(20)`), salvos criptografados no banco.
  - O código de teste fixo `000000` **só pode ser aceito** quando:
  ```csharp
  if (code == "000000" && (_environment.IsEnvironment("Testing") || _configuration.GetValue<bool>("AUTH_BYPASS_MFA_FOR_TESTS")))
  {
      return true; // Bypass estrito para automação de testes
  }
  ```

### API3:2023 — Broken Object Property Level Authorization (Mass Assignment & Excessive Data Exposure)
- **Risco:** Clientes enviarem propriedades que não deveriam alterar (ex: `IsAdmin = true`, `MfaEnabled = false`) ou a API serializar propriedades internas do modelo de domínio (como hash de senha ou segredo TOTP Base32).
- **Implementação Obrigatória:**
  - **Zero Domain Model Binding:** Nenhum controller pode receber ou retornar diretamente entidades de `{{PROJECT_NAME}}.Domain`.
  - Usar exclusivamente DTOs de entrada (*Requests*) e DTOs de saída (*Responses*) contratuais, mapeados manualmente ou via mapeadores seguros.

### API4:2023 — Unrestricted Resource Consumption
- **Risco:** Requisitantes dispararem tarefas pesadas de IA/OCR ou uploads gigantes que saturem a CPU, a GPU dedicada ou a memória do servidor.
- **Implementação Obrigatória:**
  - Configurar `RateLimiter` nativo do .NET 10 (`AddFixedWindowLimiter` ou `AddSlidingWindowLimiter`) em `/api/v1/files/import` e `/api/v1/auth/*`.
  - Impor limites máximos em uploads (`[RequestSizeLimit(100 * 1024 * 1024)]` para arquivos arquivo real/artefato gerado).
  - Todas as consultas com listagens (`/api/v1/glossary`, `/api/v1/data/input`) devem exigir parâmetros obrigatórios de paginação (`pageNumber`, `pageSize`, com teto máximo ex: `pageSize <= 100`).

### API5:2023 — Broken Function Level Authorization
- **Risco:** Usuários autenticados acessarem funções administrativas (ex: `/api/v1/system/status`, gerenciamento global de usuários ou seeds de dados) sem a role apropriada.
- **Implementação Obrigatória:**
  - Aplicar `[Authorize(Roles = "Admin")]` ou `[Authorize(Policy = "RequireAdminRole")]` em todos os endpoints administrativos.
  - Proibir endpoints administrativos acessíveis sem atributo explícito de autorização.

### API6:2023 — Unrestricted Access to Sensitive Business Flows
- **Risco:** Bots automatizados realizarem força bruta em códigos TOTP de 6 dígitos ou sobrecarregarem o pipeline de tradução disparando importações consecutivas.
- **Implementação Obrigatória:**
  - Bloqueio temporário após 5 tentativas incorretas consecutivas de validação TOTP por usuário/IP.
  - Controle de concorrência no processamento de dados do usuário: rejeitar nova importação concorrente para o mesmo arquivo arquivo real se já estiver em processamento.

### API7:2023 / A10:2021 — Server-Side Request Forgery (SSRF)
- **Risco:** A API fazer chamadas HTTP para URLs fornecidas pelo usuário buscando recursos externos maliciosos na rede interna (ex: acessar a API do banco vetorial ou armazenamento de objetos internamente).
- **Implementação Obrigatória:**
  - Whitelist estrita de domínios ao chamar motores de IA externos (ex: o endpoint HTTPS oficial de cada provedor de IA configurado).
  - Proibição de redirecionamento ou chamadas para endereços IP privados (`127.0.0.1`, `10.0.0.0/8`, `172.16.0.0/12`, `192.168.0.0/16`, `localhost`) via inputs de usuário.

### API8:2023 / A05:2021 — Security Misconfiguration
- **Risco:** Exposição de stack traces detalhados em produção, cabeçalhos de servidor vazados (`Server: Kestrel`) ou políticas de CORS permissivas demais (`AllowAnyOrigin`).
- **Implementação Obrigatória:**
  - Middleware de exceção global (`ProblemDetails`) sem expor stack traces ou mensagens internas do EF Core em ambiente diferente de `Development`.
  - Cabeçalhos de segurança obrigatórios configurados via middleware (ex: `X-Content-Type-Options: nosniff`, `X-Frame-Options: DENY`, `Referrer-Policy: strict-origin-when-cross-origin`).
  - Política de CORS estrita apontando exclusivamente para a URL do frontend Angular (`WithOrigins(frontendUrl).AllowAnyMethod().AllowAnyHeader().AllowCredentials()`).

### A03:2021 — Injection (SQL, NoSQL, OS Command)
- **Risco:** SQL Injection via consultas raw no EF Core ou OS Command Injection ao chamar utilitários de sistema.
- **Implementação Obrigatória:**
  - Utilizar consultas LINQ parametrizadas no EF Core 10. Proibir concatenação de strings em `FromSqlRaw` ou `ExecuteSqlRaw` (usar `FromSqlInterpolated`).
  - Jamais invocar `System.Diagnostics.Process` com argumentos baseados em strings recebidas de usuários sem whitelist rigorosa.

---

## 4. Checklist de Validação para o Agente .NET 10
- [ ] Todo endpoint de escrita e leitura possui validação de autorização de objeto (`UserId == currentUserId`).
- [ ] DTOs específicos são usados para entrada e saída em 100% dos controllers.
- [ ] O bypass de MFA `000000` é condicionado estritamente a variáveis de teste.
- [ ] O Kestrel não expõe stack traces nem o cabeçalho `Server`.
- [ ] Rate limiting ativo em endpoints críticos de login, MFA e importação de dados do usuário.
- [ ] SignalR (`TranslationProgressHub`) exige autenticação via Bearer token na query string com validação de conexão segura.

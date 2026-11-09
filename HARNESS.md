# {{PROJECT_NAME}} — Matriz do Harness de Testes & Execução
> Arquitetura de Divulgação Progressiva ([Progressive Disclosure](PROGRESSIVE_DISCLOSURE.md))

Consolida o **Harness**: testes automatizados, auditoria visual, orquestração de containers e monitoramento. **Substitua os valores `<...>` pelos comandos reais do projeto** e mantenha a tabela de Camada 1 sempre atualizada — os agentes dependem dela.

---

## Camada 1: Matriz de Descoberta do Harness (Lightweight Index)

> **Custo de Contexto:** ~60 tokens por linha. Localize o comando da sua meta sem ler os scripts.

| Objetivo / Tarefa | Comando / Script Principal | Repositório / Alvo | Pré-requisitos | Custo / Tempo | Link L2/L3 |
| :--- | :--- | :--- | :--- | :--- | :--- |
| **Iniciar Studio/Aplicação** | `.\scripts\start.ps1` `<criar>` | Workspace Raiz | Portas `<API>`, `<WEB>` livres | `<~30s>` | [2.1](#21-inicialização) |
| **Validar sem abrir browser** | `.\scripts\start.ps1 -RunValidationOnly` | Workspace Raiz | Aplicação em execução | `<~5s>` | [2.1](#21-inicialização) |
| **Testes Back-End** | `dotnet test {{PROJECT_SLUG}}-backend-dotnet/{{PROJECT_NAME}}.sln` | `{{PROJECT_SLUG}}-backend-dotnet` | .NET 10 SDK | `<~15s>` | [2.2](#22-baterias-automatizadas) |
| **Build/Testes Front-End** | `npm run build` / `npm test -- --watch=false` | `{{PROJECT_SLUG}}-frontend-angular` | Node 20+ | `<~25s>` | [2.2](#22-baterias-automatizadas) |
| **Auditoria Visual Playwright MCP** | `node {{PROJECT_SLUG}}-frontend-angular/scripts/verify-ui-ux.mjs` `<criar>` | `{{PROJECT_SLUG}}-frontend-angular` | Front-end ativo | `<~10s>` | [2.3](#23-auditoria-visual-contínua) |
| **Subir Infraestrutura** | `docker compose up -d` | `{{PROJECT_SLUG}}-infra-containers` | Docker Desktop | `<~30s>` | [2.4](#24-infraestrutura) |
| **Validar contratos** | `<ex.: npx @redocly/cli lint spec-hub/contracts/openapi.yaml>` | `{{PROJECT_SLUG}}-spec-hub` | Node | `<~5s>` | [2.5](#25-contratos) |

---

## Camada 2: Fluxos de Execução, Parâmetros e Variáveis (Outline)

### 2.1 Inicialização
- Script sugerido: `scripts/start.ps1` (iniciar API + front em background, aguardar health).
- Parâmetros recomendados: `-SkipBrowser`, `-RunValidationOnly`, `-Restart`, `-NoWait`.
- Endpoints críticos: `<API>/api/v1/system/status`, `<WEB>`.

### 2.2 Baterias Automatizadas
- **Back-End:** `dotnet test <sln> --logger "console;verbosity=normal"`; automação com `ASPNETCORE_ENVIRONMENT=Testing` + `AUTH_BYPASS_MFA_FOR_TESTS=true` (código `000000`, **somente** em Testing).
- **Front-End:** `npm run build` (estrito) e `npm test -- --watch=false`.

### 2.3 Auditoria Visual Contínua
- **Mandato do `agente-validador-qa`:** toda alteração de tela é comprovada por screenshots via Playwright MCP, salvas em `{{PROJECT_SLUG}}-frontend-angular/playwright-audit/`.

### 2.4 Infraestrutura
- Orquestrador: `{{PROJECT_SLUG}}-infra-containers/docker-compose.yml` (versões fixas, healthchecks, `:ro` nos dados de entrada).

### 2.5 Contratos
- Linter/validador de OpenAPI e checagem de aderência controller↔contrato fazem parte do Quality Gate.

---

## Camada 3: Diagnóstico, Logs e Recuperação de Falhas (Deep Retrieval)

### Localização dos Logs
- `.logs/backend.log`, `.logs/backend-error.log`
- `.logs/frontend.log`, `.logs/frontend-error.log`

Leia somente as linhas de erro (`Select-String`/`tail`), nunca o arquivo inteiro.

### Protocolo de Auto-Cura (Self-Healing)
1. **Porta ocupada:** reinicie com `scripts/start.ps1 -Restart`.
2. **Falha de compilação/teste:** acione o executor responsável com o trecho do log (`maxRetries: 3`, `timeoutSeconds: 300` — ver `.antigravity/permissions.json`).
3. **Esgotadas as 3 tentativas:** pare e escale ao usuário com o resumo das tentativas.

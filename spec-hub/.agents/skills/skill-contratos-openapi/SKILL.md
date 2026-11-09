---
name: skill-contratos-openapi
description: Sincronização estrita Contract-First entre openapi.yaml v3.1, Controllers do back-end e Services do front-end.
---

# Skill: Contratos OpenAPI 3.1 e Eventos em Tempo Real (`skill-contratos-openapi`)

## Diretrizes Obrigatórias
1. **Fonte Única da Verdade:** Nenhuma rota REST ou evento em tempo real (SignalR/WebSocket/SSE) pode ser criado no back-end ou consumido no front-end sem estar previamente documentado em `{{PROJECT_SLUG}}-spec-hub/contracts/openapi.yaml` ou `{{PROJECT_SLUG}}-spec-hub/contracts/realtime-events.yaml`.
2. **Padronização de Rotas:** Todas as rotas REST utilizam o prefixo `/api/v1/` e retornam JSON em `camelCase`, com erros padronizados no formato RFC 7807 (`ProblemDetails`).
3. **Endpoints Base Recomendados:**
   - `GET /api/v1/system/status`: saúde da aplicação e dependências (banco, cache, armazenamento, provedores externos).
   - `POST /api/v1/auth/login` e `/api/v1/auth/mfa/*`: autenticação (ver `skill-mfa-totp-rfc6238`).
4. **Ciclo de Mudança:** alterar contrato → versionar no spec-hub → regenerar/atualizar Controllers e Services → rodar validação de aderência (`agente-validador-qa`).
5. **Compatibilidade:** mudanças que quebram consumidores exigem novo prefixo de versão (`/api/v2/`) e ADR registrado em `specs/`.
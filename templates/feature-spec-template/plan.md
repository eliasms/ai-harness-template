# Implementation Plan: {{FEATURE_NAME}}
> ID: `{{FEATURE_ID}}` | Status: `PROPOSED`

## 1. Arquitetura Proposta & ADRs
- Descreva a abordagem técnica escolhida.
- Registre decisões estruturantes referenciando ADRs em `templates/adr-template.md`.

## 2. Contratos & Interfaces
- **Endpoints REST:** Declarar novos paths em `spec-hub/contracts/openapi.yaml`.
- **Eventos:** Declarar tópicos em `spec-hub/contracts/realtime-events.yaml` (se houver).

## 3. Divisão de Trabalho por Repositório
- `{{PROJECT_SLUG}}-backend`: Casos de uso na camada Application, entidades no Domain e controllers na WebApi.
- `{{PROJECT_SLUG}}-frontend`: Services tipados a partir do contrato OpenAPI, componentes standalone com Signals e OnPush.
- `{{PROJECT_SLUG}}-infra`: Variáveis de ambiente e novos containers/serviços (se necessário).

## 4. Estratégia de Testes & Validação
- Testes unitários para regras de domínio (xUnit).
- Testes de integração para repositórios e endpoints.
- Auditoria visual Playwright MCP para fluxos de interface.

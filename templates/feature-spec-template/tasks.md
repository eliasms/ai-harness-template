# Execution Tasks: {{FEATURE_NAME}}
> ID: `{{FEATURE_ID}}` | Dependências ordenadas

## Fase 1: Contratos & Modelagem (Arquiteto)
- [ ] `T001` [contracts] Sincronizar endpoints em `spec-hub/contracts/openapi.yaml`
- [ ] `T002` [plan] Ratificar plano e ADRs na Constituição

## Fase 2: Implementação Back-End (Executor Back-End)
- [ ] `T003` [backend/domain] Criar entidades e value objects no Domain
- [ ] `T004` [backend/app] Implementar Use Cases e DTOs na Application
- [ ] `T005` [backend/infra] Implementar persistência EF Core e migrations
- [ ] `T006` [backend/api] Implementar Controller REST aderente ao OpenAPI

## Fase 3: Implementação Front-End (Executor Front-End / UI-UX)
- [ ] `T007` [frontend/service] Criar API Service tipado consumindo o contrato
- [ ] `T008` [frontend/ui] Criar componentes standalone com Signals e OnPush
- [ ] `T009` [frontend/a11y] Auditar acessibilidade WCAG 2.1 AA

## Fase 4: Validação & Quality Gates (Validador QA)
- [ ] `T010` [qa/tests] Rodar suíte completa de testes de regressão
- [ ] `T011` [qa/visual] Executar auditoria visual via Playwright MCP
- [ ] `T012` [qa/report] Emitir relatório de validação da feature

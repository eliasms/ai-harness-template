---
name: skill-clean-architecture-dotnet10
description: Padrões de arquitetura limpa, DDD, C# 14, Result Pattern e EF Core 10 no back-end .NET 10.
---

# Skill: Clean Architecture no .NET 10 (`skill-clean-architecture-dotnet10`)

## Estrutura de Camadas (Solution `{{PROJECT_NAME}}.sln`)
1. **`{{PROJECT_NAME}}.Domain`:**
   - Entidades ricas, Value Objects, eventos e interfaces de domínio. **Zero** dependências de infraestrutura ou frameworks web.
2. **`{{PROJECT_NAME}}.Application`:**
   - Casos de uso (CQRS), DTOs, interfaces de portas (`I<Servico>`), orquestradores. Retorno explícito via `Result<T>` — exceções nunca são fluxo de controle.
3. **`{{PROJECT_NAME}}.Infrastructure`:**
   - Persistência EF Core 10 (`{{PROJECT_NAME}}DbContext`), seeders, adaptadores para serviços externos (armazenamento, cache, mensageria, IA). Implementa as interfaces da Application.
4. **`{{PROJECT_NAME}}.WebApi`:**
   - Controllers finos (`/api/v1/*`), hubs SignalR (se previstos no contrato), autenticação JWT Bearer, CORS e OpenAPI. Delegam diretamente a serviços da Application.

## Regras
- Dependências apontam sempre para dentro: `WebApi → Application → Domain`; `Infrastructure → Application`.
- Todo endpoint deve existir previamente em `{{PROJECT_SLUG}}-spec-hub/contracts/openapi.yaml` (ver `skill-contratos-openapi`).
- Testes em `tests/{{PROJECT_NAME}}.Tests` (xUnit); toda regra de domínio nova nasce com teste.
# {{PROJECT_NAME}} — Back-End API (.NET 10)
> Arquitetura de Divulgação Progressiva ([Progressive Disclosure](PROGRESSIVE_DISCLOSURE.md))

Repositório da API Back-End construída em **.NET 10 (C# 14)**, seguindo os princípios de **Clean Architecture + DDD** e sincronizada de forma estrita com `{{PROJECT_SLUG}}-spec-hub/contracts/openapi.yaml`.

---

## Camada 1: Matriz de Execução Rápida (Lightweight Index)

| Tarefa | Comando | Pré-requisito | Tempo |
| :--- | :--- | :--- | :--- |
| **Compilar Solution** | `dotnet build --warnaserror` | .NET 10 SDK | ~5-10s |
| **Executar Testes Unitários/Integração** | `dotnet test` | .NET 10 SDK | ~10-15s |
| **Executar API Localmente** | `dotnet run --project src/{{PROJECT_NAME}}.WebApi` | Docker Postgres ativo | ~5s |

---

## Camada 2: Arquitetura & Camadas DDD (Outline)

- **`src/{{PROJECT_NAME}}.Domain`:** Entidades puras, Value Objects e eventos de domínio. Zero dependências externas de infraestrutura ou Web.
- **`src/{{PROJECT_NAME}}.Application`:** Casos de uso (CQRS), contratos de interfaces (`I<Service>`), DTOs e orquestradores. Retorno via `Result<T>`.
- **`src/{{PROJECT_NAME}}.Infrastructure`:** Implementações EF Core 10, adaptadores externos, cache e armazenamento.
- **`src/{{PROJECT_NAME}}.WebApi`:** Controllers REST finos mapeados para os endpoints declarados no OpenAPI.

---

## Camada 3: Detalhes & Configurações (Deep Retrieval)
- Consulte `AGENTS.md` deste repositório para verificar os agentes autorizados a alterar este código.

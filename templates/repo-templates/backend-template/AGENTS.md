# {{PROJECT_NAME}} Back-End — Agentes & Governança
> Arquitetura de Divulgação Progressiva ([Progressive Disclosure](../../PROGRESSIVE_DISCLOSURE.md))

## Agentes com Permissão de Atuação
| ID do Agente | Papel | Escopo neste Repositório | Skills Primárias |
| :--- | :--- | :--- | :--- |
| `agente-executor-dotnet` | Executor Principal | Implementação de Domain, Application, Infrastructure e WebApi | `skill-clean-architecture-dotnet10`, `skill-contratos-openapi`, `skill-owasp-top10-backend` |
| `agente-validador-qa` | Validador | Execução de suítes de teste xUnit e auditoria de cobertura | `skill-contratos-openapi`, `skill-owasp-top10-qa` |

## Regras de Atuação
1. **Contract-First:** Nenhum endpoint pode ser criado sem constar previamente em `{{PROJECT_SLUG}}-spec-hub/contracts/openapi.yaml`.
2. **File Read Gate:** Não leia classes de infraestrutura completas sem antes consultar a interface correspondente na camada `Application`.
3. **Auto-Cura:** Falhas de teste limitadas a 3 tentativas (`maxRetries: 3`).

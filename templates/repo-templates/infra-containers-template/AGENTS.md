# {{PROJECT_NAME}} Infraestrutura — Agentes & Governança
> Arquitetura de Divulgação Progressiva ([Progressive Disclosure](../../PROGRESSIVE_DISCLOSURE.md))

## Agentes com Permissão de Atuação
| ID do Agente | Papel | Escopo neste Repositório | Skills Primárias |
| :--- | :--- | :--- | :--- |
| `agente-executor-devops` | Executor Infra | Dockerfile, docker-compose.yml, scripts de inicialização | `skill-owasp-top10-devops` |
| `agente-validador-qa` | Validador | Validação de healthchecks e isolamento de redes | `skill-owasp-top10-qa` |

## Regras de Atuação
1. **Sem Segredos em Código:** Credenciais são injetadas estritamente via `.env` (não versionado); `.env.example` deve conter apenas placeholders.
2. **Volumes Seguros:** Montagem de dados de entrada como `:ro`.
3. **Auto-Cura:** Limite de 3 tentativas (`maxRetries: 3`) antes de escalar.

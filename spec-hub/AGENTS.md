# {{PROJECT_NAME}} Spec-Hub — Governança de Agentes & Spec-Kit
> Arquitetura de Divulgação Progressiva ([Progressive Disclosure](../../PROGRESSIVE_DISCLOSURE.md))

Este repositório funciona como **Single Source of Truth (Fonte Única da Verdade)** para arquitetura, contratos e diretrizes de desenvolvimento do ecossistema {{PROJECT_NAME}}.

---

## Camada 1: Matriz dos Agentes e Fases Spec-Kit (Lightweight Index)

| Agente | Fases Spec-Kit | Repositório Primário | Skills Principais |
| :--- | :--- | :--- | :--- |
| `agente-arquiteto-planejador` | `specify`, `plan`, `tasks` | `{{PROJECT_SLUG}}-spec-hub` | `skill-contratos-openapi`, `skill-owasp-top10-arquiteto` |
| `agente-executor-dotnet` | `execute` | `{{PROJECT_SLUG}}-backend-dotnet` | `skill-clean-architecture-dotnet10`, `skill-contratos-openapi`, `skill-owasp-top10-backend` |
| `agente-executor-angular` | `execute` | `{{PROJECT_SLUG}}-frontend-angular` | `angular-ui-patterns`, `skill-contratos-openapi`, `skill-owasp-top10-frontend` |
| `agente-executor-devops` | `execute` | `{{PROJECT_SLUG}}-infra-containers` | `skill-owasp-top10-devops` |
| `agente-validador-qa` | `validate` | Todos os repositórios | `skill-contratos-openapi`, `skill-owasp-top10-qa` |
| `ui-ux-engineer` | `execute`, `audit` | `{{PROJECT_SLUG}}-frontend-angular` | `ui-ux-pro-max`, `bencium-ux-designer`, `accesslint`, `skill-owasp-top10-ui-ux` |

---

## Camada 2: Diretrizes de Governança (Outline)
- Modificações em contratos (`contracts/`) só podem ser aprovadas ou lideradas pelo `agente-arquiteto-planejador`.
- Mudanças arquiteturais exigem ratificação em ADR antes de codificação.
- As especificações e skills em `.agents/` são a fonte mestre sincronizada com a raiz do workspace.

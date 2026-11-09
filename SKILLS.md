# {{PROJECT_NAME}} — Catálogo de Skills Técnicas
> Arquitetura de Divulgação Progressiva ([Progressive Disclosure](PROGRESSIVE_DISCLOSURE.md))

Organiza as 26 skills do harness em 3 camadas: Descoberta (Camada 1), Sumário Operacional (Camada 2) e Implementação Detalhada (Camada 3, em `spec-hub/.agents/skills/`).

---

## Camada 1: Matriz de Descoberta das Skills (Lightweight Index)

> **File Read Gate:** identifique a skill e a categoria abaixo. Não leia o `SKILL.md` até que a tarefa exija aquele domínio.

### 1.1 Arquitetura, Contratos e Back-End (3 skills)
| Skill | Agente Responsável | Gatilho / Quando Usar | Peso Token | Caminho (L3) |
| :--- | :--- | :--- | :--- | :--- |
| `skill-contratos-openapi` | `agente-arquiteto-planejador`, `executor-*`, `validador-qa` | Modelagem e consumo de endpoints REST/eventos em tempo real | Leve | [SKILL.md](spec-hub/.agents/skills/skill-contratos-openapi/SKILL.md) |
| `skill-clean-architecture-dotnet10` | `agente-executor-dotnet` | Estrutura Domain/Application/Infrastructure/WebApi | Leve | [SKILL.md](spec-hub/.agents/skills/skill-clean-architecture-dotnet10/SKILL.md) |
| `skill-mfa-totp-rfc6238` | `agente-executor-dotnet` | TOTP RFC 6238, QR Base32, bypass restrito a testes | Leve | [SKILL.md](spec-hub/.agents/skills/skill-mfa-totp-rfc6238/SKILL.md) |

### 1.2 Segurança OWASP Top 10 (7 skills)
| Skill | Agente Responsável | Foco OWASP | Peso Token | Caminho (L3) |
| :--- | :--- | :--- | :--- | :--- |
| `skill-owasp-top10-arquiteto` | `agente-arquiteto-planejador` | A04 Insecure Design, STRIDE, SAMM | Médio | [SKILL.md](spec-hub/.agents/skills/skill-owasp-top10-arquiteto/SKILL.md) |
| `skill-owasp-top10-backend` | `agente-executor-dotnet` | BOLA, rate limit, injeção, SSRF | Médio | [SKILL.md](spec-hub/.agents/skills/skill-owasp-top10-backend/SKILL.md) |
| `skill-owasp-top10-frontend` | `agente-executor-angular` | DOM XSS, CSP, tokens efêmeros | Médio | [SKILL.md](spec-hub/.agents/skills/skill-owasp-top10-frontend/SKILL.md) |
| `skill-owasp-top10-devops` | `agente-executor-devops` | Docker Top 10, rootless, redes | Médio | [SKILL.md](spec-hub/.agents/skills/skill-owasp-top10-devops/SKILL.md) |
| `skill-owasp-top10-qa` | `agente-validador-qa` | WSTG v4.2, testes de segurança | Médio | [SKILL.md](spec-hub/.agents/skills/skill-owasp-top10-qa/SKILL.md) |
| `skill-owasp-top10-pipeline-ia-dados` | `agente-executor-dotnet`, `validador-qa` | OWASP LLM Top 10, Zip Slip/Bomb | Médio | [SKILL.md](spec-hub/.agents/skills/skill-owasp-top10-pipeline-ia-dados/SKILL.md) |
| `skill-owasp-top10-ui-ux` | `ui-ux-engineer` | Clickjacking, canvas, privacidade | Médio | [SKILL.md](spec-hub/.agents/skills/skill-owasp-top10-ui-ux/SKILL.md) |

### 1.3 UI/UX e Acessibilidade (6 skills)
| Skill | Agente Responsável | Gatilho / Quando Usar | Peso Token | Caminho (L3) |
| :--- | :--- | :--- | :--- | :--- |
| `angular-ui-patterns` | `executor-angular`, `ui-ux-engineer` | Composição, OnPush, Signals, CDK | Médio | [SKILL.md](spec-hub/.agents/skills/angular-ui-patterns/SKILL.md) |
| `frontend-design` | `ui-ux-engineer` | Direção estética de novas UIs | Leve | [SKILL.md](spec-hub/.agents/skills/frontend-design/SKILL.md) |
| `web-design-guidelines` | `ui-ux-engineer` | Revisão de UI contra guidelines | Leve | [SKILL.md](spec-hub/.agents/skills/web-design-guidelines/SKILL.md) |
| `ui-ux-pro-max` | `ui-ux-engineer` | Design system via CLI (`scripts/search.py`) — **nunca ler CSVs** | Pesado (CLI) | [SKILL.md](spec-hub/.agents/skills/ui-ux-pro-max/SKILL.md) |
| `bencium-ux-designer` | `ui-ux-engineer` | Decisões de cor, tipografia, layout | Médio | [SKILL.md](spec-hub/.agents/skills/bencium-ux-designer/SKILL.md) |
| `accesslint` | `ui-ux-engineer`, `validador-qa` | Auditoria WCAG 2.1/2.2 AA | Médio | [SKILL.md](spec-hub/.agents/skills/accesslint/SKILL.md) |

### 1.4 Spec-Kit — Fluxo Spec-Driven (10 skills)
| Skill | Fase | Quando Usar |
| :--- | :--- | :--- |
| `speckit-constitution` | Governança | Criar/atualizar princípios do projeto |
| `speckit-specify` | `specify` | Nova feature a partir de linguagem natural |
| `speckit-clarify` | `specify` | Resolver ambiguidades (até 5 perguntas) |
| `speckit-plan` | `plan` | Plano técnico, pesquisa, modelo de dados |
| `speckit-tasks` | `tasks` | Gerar `tasks.md` ordenado por dependência |
| `speckit-analyze` | `tasks` | Consistência entre spec/plan/tasks |
| `speckit-checklist` | qualquer | Checklist de qualidade da feature |
| `speckit-implement` | `execute` | Executar as tarefas |
| `speckit-converge` | `validate` | Comparar código vs. spec e anexar tarefas pendentes |
| `speckit-taskstoissues` | pós-tasks | Converter tarefas em issues do GitHub |

Caminhos: `spec-hub/.agents/skills/<nome>/SKILL.md`.

---

## Camada 2: Como Criar e Evoluir Skills
1. Copie [`templates/skill-template.md`](templates/skill-template.md) para `spec-hub/.agents/skills/<skill-nome>/SKILL.md`.
2. Preencha frontmatter (`name`, `description`) — a descrição é o gatilho de descoberta; seja específica.
3. Mantenha o `SKILL.md` enxuto (Camada 3 sob demanda); dados volumosos ficam em `data/`, `references/` ou `scripts/` e são acessados por CLI.
4. Registre a skill na Camada 1 deste arquivo e vincule-a ao(s) agente(s) no frontmatter em `spec-hub/.agents/agents/`.
5. Skills de domínio do projeto (pipeline, regras de negócio) ficam no mesmo diretório e seguem o mesmo contrato — **não** as misture com skills genéricas do harness.

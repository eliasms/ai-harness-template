# Catálogo de Templates do Harness
> Localização: `templates/`

Este diretório contém os modelos reutilizáveis para estender e operacionalizar novos projetos criados a partir desta estrutura.

---

## Estrutura dos Templates

| Template | Finalidade | Quando Usar |
| :--- | :--- | :--- |
| [`agent-template.md`](agent-template.md) | Especificação de um novo agente autônomo (Camada 3) | Ao adicionar um agente especialista (ex.: IA de domínio, novo executor de linguagem/stack, auditor) |
| [`skill-template.md`](skill-template.md) | Estrutura de uma nova skill técnica modular | Ao encapsular um conhecimento técnico, checklist ou automação CLI reutilizável |
| [`adr-template.md`](adr-template.md) | Architecture Decision Record (ADR) | Ao tomar uma decisão técnica ou arquitetural estruturante |
| [`handoff-template.md`](handoff-template.md) | Protocolo de transição e passagem de bastão entre agentes | Na transferência de tarefas entre agentes autônomos (ex.: Arquiteto → Executor → Validador) |
| [`validation-report-template.md`](validation-report-template.md) | Relatório formal de auditoria e validação de QA | Ao final de cada ciclo de implementação de feature ou épico (`agente-validador-qa`) |
| [`openapi-template.yaml`](openapi-template.yaml) | Contrato inicial OpenAPI 3.1 com convenções REST | Ponto de partida para `contracts/openapi.yaml` |
| [`realtime-events-template.yaml`](realtime-events-template.yaml) | Contrato de eventos bidirecionais (SignalR / WebSocket) | Ao projetar notificações e pipelines em tempo real |
| [`feature-spec-template/`](feature-spec-template/) | Pacote completo Spec-Kit de nova feature (`spec`, `plan`, `tasks`, etc.) | Ao iniciar um novo ciclo de especificação funcional e técnica |
| [`repo-templates/`](repo-templates/) | Modelos de `README.md` e `AGENTS.md` para repositórios satélites | Ao instanciar novos submódulos (Backend, Frontend, Infra) |

---

## Como Utilizar

1. **Adicionar Agente:**
   - Copie `agent-template.md` para `spec-hub/.agents/agents/<nome-do-agente>.md`.
   - Preencha papéis, estágios e skills no frontmatter.
   - Registre na tabela de Camada 1 em `AGENTS.md`.

2. **Adicionar Skill:**
   - Copie `skill-template.md` para `spec-hub/.agents/skills/<nome-da-skill>/SKILL.md`.
   - Adicione scripts/dados auxiliares se necessário (respeitando o *File Read Gate*).
   - Registre na tabela de Camada 1 em `SKILLS.md`.

3. **Nova Feature:**
   - Crie a pasta `spec-hub/specs/<NNN-feature-name>/`.
   - Copie o conteúdo de `feature-spec-template/` e execute o ciclo Spec-Kit (`/speckit-specify` → `/speckit-plan` → `/speckit-tasks` → `/speckit-implement` → `/speckit-converge`).

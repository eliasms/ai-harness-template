# {{PROJECT_NAME}} — Spec-Hub (`{{PROJECT_SLUG}}-spec-hub`)
> Arquitetura de Divulgação Progressiva ([Progressive Disclosure](PROGRESSIVE_DISCLOSURE.md))

Repositório central de especificações (**Spec-Kit**), contratos **OpenAPI 3.1** (`contracts/openapi.yaml`), contratos de eventos em tempo real (`contracts/realtime-events.yaml`), **ADRs**, especificações de épicos/features (`specs/`) e catálogo mestre dos agentes autônomos (`.agents/`).

---

## Camada 1: Matriz de Recursos & Artefatos (Lightweight Index)

| Artefato / Recurso | Finalidade / Descrição | Formato | Caminho (L3) |
| :--- | :--- | :--- | :--- |
| **Contrato REST API** | Especificação OpenAPI 3.1.0 (Single Source of Truth) | YAML | [contracts/openapi.yaml](contracts/openapi.yaml) |
| **Contrato de Eventos** | Eventos em tempo real e canais bidirecionais | YAML | [contracts/realtime-events.yaml](contracts/realtime-events.yaml) |
| **Especificações de Features** | Casos de uso, requisitos e decomposição em tarefas | Markdown / Spec-Kit | [specs/](specs/) |
| **Constituição do Projeto** | Invariantes arquiteturais e regras imutáveis | Markdown | [.specify/memory/constitution.md](.specify/memory/constitution.md) |
| **Catálogo de Agentes** | Especificações profundas dos agentes autônomos | Markdown | [.agents/agents/](.agents/agents/) |
| **Catálogo de Skills** | Capacidades e checklists técnicos dos agentes | Markdown / Scripts | [.agents/skills/](.agents/skills/) |

---

## Camada 2: Metodologia Spec-Kit & Protocolo Contract-First (Outline)

### 1. Fluxo de Trabalho Spec-Driven
1. `/speckit-constitution`: Princípios imutáveis e governança.
2. `/speckit-specify`: Criação de especificações funcionais em `specs/<NNN-feature>/`.
3. `/speckit-clarify`: Resolução prévia de ambiguidades.
4. `/speckit-plan`: Planejamento técnico, arquitetura e ADRs.
5. `/speckit-tasks`: Quebra de tarefas estruturadas por dependência.
6. `/speckit-implement`: Execução paralela pelos agentes especialistas.
7. `/speckit-converge`: Verificação de conformidade entre o código e a especificação.

### 2. Contratos Imutáveis
Nenhum código no back-end ou front-end deve ser escrito sem que a rota e os tipos de dados estejam definidos em `contracts/openapi.yaml`.

---

## Camada 3: Diretrizes Operacionais (Deep Retrieval)
- Consulte `AGENTS.md` deste repositório para os gatilhos do `agente-arquiteto-planejador`.

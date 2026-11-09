# Especificações de Features & Épicos (`specs/`)

Este diretório armazena todas as especificações geradas pela metodologia Spec-Kit para o projeto {{PROJECT_NAME}}.

## Organização de Diretórios
Cada funcionalidade ou épico recebe uma pasta com numeração sequencial:
```
specs/
├── 001-nome-da-feature/
│   ├── spec.md         # Requisitos funcionais e critérios de aceite
│   ├── plan.md         # Arquitetura e decisões técnicas (ADRs)
│   ├── tasks.md        # Tarefas quebradas por agente e dependência
│   ├── research.md     # Spikes e alternativas analisadas
│   ├── data-model.md   # Modelagem de dados e diagramas
│   └── quickstart.md   # Guia de teste rápido da feature
```

## Como Iniciar uma Nova Feature
1. Copie o diretório `templates/feature-spec-template/` para `specs/<NNN-feature-name>/`.
2. Execute o comando `/speckit-specify` ou acione o `agente-arquiteto-planejador` para preencher os requisitos.

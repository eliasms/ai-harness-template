# Data Model: {{FEATURE_NAME}}

## Entidades & Agregados
```mermaid
erDiagram
    PROJECT ||--o{ RESOURCE : contains
    PROJECT {
        uuid id PK
        string name
        uuid userId FK
        datetime createdAt
    }
    RESOURCE {
        uuid id PK
        uuid projectId FK
        string status
        json metadata
    }
```

## Regras de Integridade
1. Todo recurso deve possuir vínculo obrigatório com um Tenant ou `UserId` para evitar falhas BOLA (OWASP API1:2023).
2. Índices de unicidade aplicados sobre campos chave de busca.

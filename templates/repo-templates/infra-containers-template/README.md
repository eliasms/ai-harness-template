# {{PROJECT_NAME}} — Infraestrutura & Containers
> Arquitetura de Divulgação Progressiva ([Progressive Disclosure](PROGRESSIVE_DISCLOSURE.md))

Orquestração de containers Docker Compose e automação de infraestrutura para o ecossistema {{PROJECT_NAME}}.

---

## Camada 1: Matriz de Operações Rápidas (Lightweight Index)

| Tarefa | Comando | Pré-requisito | Tempo |
| :--- | :--- | :--- | :--- |
| **Validar Configuração Compose** | `docker compose config` | Docker instalado | ~2s |
| **Subir Serviços em Background** | `docker compose up -d` | Docker ativo | ~15-30s |
| **Verificar Saúde dos Containers** | `docker compose ps` | Containers subindo | ~2s |
| **Derrubar Serviços Preservando Dados**| `docker compose down` | - | ~5s |

---

## Camada 2: Arquitetura de Serviços & Redes (Outline)

- **Imagens Estáveis:** Proibido o uso de `@latest`; todas as tags devem ser explícitas e imutáveis.
- **Princípio do Menor Privilégio:** Containers executando como usuário não-root (`USER appuser`, `no-new-privileges:true`).
- **Isolamento de Rede:** Portas de bancos de dados internas não devem ser expostas para o host externo.
- **Imutabilidade de Entrada:** Pastas montadas contendo dados brutos de entrada devem usar o modo leitura estrita (`:ro`).

---

## Camada 3: Detalhes & Configurações (Deep Retrieval)
- Consulte `AGENTS.md` deste repositório para permissões do `agente-executor-devops`.

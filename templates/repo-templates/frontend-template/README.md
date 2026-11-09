# {{PROJECT_NAME}} — Front-End Web (Angular)
> Arquitetura de Divulgação Progressiva ([Progressive Disclosure](PROGRESSIVE_DISCLOSURE.md))

Single Page Application construída em **Angular** moderno com foco em **Zoneless**, reatividade via **Signals**, **Standalone Components** e estratégia de renderização **OnPush**.

---

## Camada 1: Matriz de Execução Rápida (Lightweight Index)

| Tarefa | Comando | Pré-requisito | Tempo |
| :--- | :--- | :--- | :--- |
| **Build de Produção** | `npm run build` | Node 20+ | ~15-20s |
| **Executar Testes Unitários** | `npm test -- --watch=false` | Node 20+ | ~10s |
| **Auditoria Visual Playwright** | `node scripts/verify-ui-ux.mjs` | Servidor na porta 4200 | ~10s |
| **Servidor de Desenvolvimento** | `npm start` | Porta 4200 livre | ~5s |

---

## Camada 2: Arquitetura & Diretrizes de UI/UX (Outline)

- **Reatividade com Signals:** Uso mandatório de `signal()`, `computed()`, `input()`, `output()`.
- **Change Detection OnPush:** Todo componente de apresentação deve adotar `changeDetection: ChangeDetectionStrategy.OnPush`.
- **Acessibilidade:** WCAG 2.1 AA (contraste de cor 4.5:1, navegação por teclado e targets de clique >= 44px).
- **Segurança Client-Side:** Interpolação nativa segura `{{ }}`; proibição estrita de `[innerHTML]` não sanitizado.

---

## Camada 3: Detalhes & Configurações (Deep Retrieval)
- Consulte `AGENTS.md` deste repositório para os agentes de UI/UX autorizados.

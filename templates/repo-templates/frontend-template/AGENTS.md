# {{PROJECT_NAME}} Front-End — Agentes & Governança
> Arquitetura de Divulgação Progressiva ([Progressive Disclosure](../../PROGRESSIVE_DISCLOSURE.md))

## Agentes com Permissão de Atuação
| ID do Agente | Papel | Escopo neste Repositório | Skills Primárias |
| :--- | :--- | :--- | :--- |
| `agente-executor-angular` | Executor Front-End | Componentes, rotas, services e estado | `angular-ui-patterns`, `skill-contratos-openapi`, `skill-owasp-top10-frontend` |
| `ui-ux-engineer` | Engenheiro UI/UX | Design system, ergonomia, acessibilidade WCAG | `frontend-design`, `ui-ux-pro-max`, `accesslint`, `skill-owasp-top10-ui-ux` |
| `agente-validador-qa` | Validador | Auditoria visual Playwright MCP e testes | `skill-contratos-openapi`, `skill-owasp-top10-qa` |

## Regras de Atuação
1. **Contract-First:** Services gerados ou mantidos a partir de `{{PROJECT_SLUG}}-spec-hub/contracts/openapi.yaml`.
2. **Evidência Visual Mandatória:** Toda alteração de tela exige validação visual via Playwright MCP salva em `playwright-audit/`.
3. **Proteção contra Tainted Canvas:** Se houver Canvas, sempre carregar imagens com `crossOrigin = 'anonymous'`.

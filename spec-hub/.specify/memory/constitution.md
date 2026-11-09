# {{PROJECT_NAME}} Constitution

> Template de Constituição do harness. Mantenha os princípios que se aplicam, **remova** os que não se aplicam e acrescente os invariantes do seu domínio (use `/speckit-constitution`). Itens marcados `[OPCIONAL]` dependem da stack/domínio.

## Core Principles

### I. Contract-First & Single Source of Truth
`{{PROJECT_SLUG}}-spec-hub` é a única fonte da verdade do workspace. Todo endpoint REST e evento em tempo real deve estar declarado em `contracts/openapi.yaml` (v3.1) e `contracts/realtime-events.yaml` **antes** de ser implementado no back-end ou consumido no front-end. Desvios sem sincronização do contrato são proibidos.

### II. Spec-Driven Development
Nenhuma feature é codificada sem `spec.md` → `plan.md` → `tasks.md` em `specs/<NNN-feature>/`. Decisões arquiteturais relevantes são registradas como ADR no `plan.md` (ou em `templates/adr-template.md`).

### III. Imutabilidade dos Dados de Entrada `[OPCIONAL]`
A pasta `data/input` é montada somente leitura (`:ro`). Arquivos de origem nunca são modificados, sobrescritos ou removidos; todo artefato gerado vai exclusivamente para `data/output`.

### IV. Clean Architecture, DDD e Result Pattern
- `Domain`: modelos, value objects e eventos sem dependências de framework.
- `Application`: casos de uso, interfaces e DTOs com `Result<T>` (sem exceções como controle de fluxo).
- `Infrastructure`: persistência e adaptadores externos.
- `WebApi`: controllers finos, códigos HTTP aderentes ao contrato.

### V. Test-First & Quality Gates Determinísticos
- Regressão contínua (unitário/integração/E2E) antes de qualquer entrega.
- Bypass de autenticação para automação só existe com `ASPNETCORE_ENVIRONMENT=Testing` **e** flag explícita; deve falhar fora desse contexto.
- Toda mudança de interface exige auditoria visual (Playwright MCP) com evidências em `playwright-audit/`.

### VI. OWASP Top 10 for LLM — Guardrails de IA `[OPCIONAL: se usar IA/LLM]`
- **LLM01** Delimitar todo conteúdo não confiável com `<untrusted_content>`.
- **LLM02/LLM07** Nunca expor segredos, PII ou prompts de sistema em logs/artefatos.
- **LLM03** Dependências com versões fixadas (sem `@latest`).
- **LLM04** Persistência em memória/base de conhecimento só após validação humana ou determinística.
- **LLM05** Sanitizar toda saída de modelo antes de shell, HTML ou SQL.
- **LLM06** Menor privilégio: sem permissões coringa (`*`) para agentes/ferramentas.
- **LLM10** Loops de auto-cura limitados (`maxRetries: 3`, timeout 300s).

### VII. Governança de Segurança Full-Stack OWASP
Cada componente satisfaz as skills `skill-owasp-top10-*` correspondentes: arquitetura (A04/STRIDE), back-end (API Top 10 2023), front-end (XSS/CSP/client-side), containers (Docker Top 10), dados/arquivos (Zip Slip/Zip Bomb), UI/UX (clickjacking/privacidade) e QA (WSTG v4.2).

## Technical Constraints & Standards
> Preencha com a stack real do projeto.
- Back-end: <ex.: .NET 10 / C# 14 / EF Core 10 / PostgreSQL>
- Front-end: <ex.: Angular Zoneless + Signals + Standalone>
- Infra: <ex.: Docker Compose, healthchecks, redes segmentadas>
- IA/ML: <ex.: provedores, modelos locais, limites de recursos — ou "N/A">

## Quality Gates & Review Process
1. **Contract Gate:** mudança de schema/API refletida em `contracts/`.
2. **Integrity Gate:** dados de entrada intocados (hash verificado) `[OPCIONAL]`.
3. **Test Gate:** todos os testes automatizados passam antes do release.
4. **Visual Gate:** evidências Playwright para toda alteração de UI.
5. **Security Gate:** conformidade com os checklists `skill-owasp-top10-*`, zero vulnerabilidades críticas/altas.

## Governance
Esta Constituição prevalece sobre qualquer outra documentação. Mudanças arquiteturais exigem ADR e ratificação no repositório.

**Version**: 0.1.0 | **Ratified**: {{DATE}} | **Last Amended**: {{DATE}}

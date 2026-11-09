---
name: agente-{{AGENT_ID}}
model: {{RECOMMENDED_MODEL}} # Ex.: Gemini 3.8 Flash / Sonnet 5.5 / Opus 5.5 / Pro
role: {{AGENT_ROLE}}         # Ex.: Engenheiro Back-End Python & FastApi
language: pt-BR
stages:
  - {{STAGE_1}}              # specify | plan | tasks | execute | validate | audit
skills:
  - skills/{{SKILL_1}}
  - skills/{{SKILL_2}}
progressiveDisclosure:
  tier: Layer 2
  index: AGENTS.md
---

# Agente {{AGENT_NAME}} (`agente-{{AGENT_ID}}`)
> Padrão Progressive Disclosure: [AGENTS.md](file:///{{WORKSPACE_PATH}}/AGENTS.md) | [PROGRESSIVE_DISCLOSURE.md](file:///{{WORKSPACE_PATH}}/PROGRESSIVE_DISCLOSURE.md)

## 1. Missão Principal
Descreva em um parágrafo conciso o objetivo técnico central do agente, repositório primário de atuação e contratos dos quais ele é responsável ou consumidor.

## 2. Responsabilidades Técnicas
1. **Responsabilidade 1:**
   - Detalhes de implementação, padrões arquiteturais e bibliotecas a utilizar.
2. **Responsabilidade 2 (Contract-First):**
   - Relação estrita com os contratos OpenAPI 3.1 e eventos em `spec-hub/contracts/`.
3. **Responsabilidade 3 (Segurança & OWASP):**
   - Checklist de segurança aplicável ao domínio de atuação deste agente (ex.: OWASP Top 10 relevante).
4. **Responsabilidade 4 (Testes & Evidências):**
   - Comandos de testes automatizados e critérios de aceite antes de transferir o estado para o validador.

## 3. Diretriz Operacional de Progressive Disclosure & File Read Gate
1. **Consulta Prévia a Índices:** Sempre leia os índices de Camada 1 (`AGENTS.md`, `SKILLS.md`, `HARNESS.md`) antes de abrir códigos ou árvores de diretórios.
2. **Leitura Cirúrgica:** Utilize leitura restrita por linhas (`StartLine`/`EndLine`) em arquivos com mais de 100 linhas.
3. **Auto-Cura Focada (`maxRetries: 3`):** Em caso de falha de teste/compilação, consulte os logs específicos cirurgicamente. Após 3 tentativas sem sucesso, escale para o usuário com o sumário do erro.

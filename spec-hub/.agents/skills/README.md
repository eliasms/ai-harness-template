# Catálogo de Skills — Camada 1 & 2 (Progressive Disclosure)
> Consulte o catálogo mestre em [SKILLS.md](../../../SKILLS.md) e as diretrizes em [PROGRESSIVE_DISCLOSURE.md](../../../PROGRESSIVE_DISCLOSURE.md).

Este diretório contém as implementações completas (Camada 3) de todas as skills do projeto {{PROJECT_NAME}}.

## Regra do File Read Gate para Skills
1. **Identifique a necessidade via Camada 1:** Verifique em `SKILLS.md` se a skill realmente se aplica à tarefa atual.
2. **Leia apenas o `SKILL.md` específico:** Nunca faça listagens recursivas de arquivos internos de dados (`data/`, `fixtures/`).
3. **Uso de ferramentas CLI:** Para skills pesadas como `ui-ux-pro-max`, utilize os scripts em `scripts/` (ex.: `python search.py`) em vez de abrir arquivos `.csv` volumosos.
4. **Novas skills:** crie a partir de `templates/skill-template.md` e registre em `SKILLS.md`.
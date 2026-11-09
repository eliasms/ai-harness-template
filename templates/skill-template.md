---
name: skill-{{SKILL_ID}}
description: {{SHORT_DESCRIPTION_FOR_DISCOVERY}} # Descrição concisa (~1 linha) servindo como gatilho de descoberta na Camada 1
---

# Skill: {{SKILL_TITLE}} (`skill-{{SKILL_ID}}`)

## 1. Visão Geral & Escopo
Explique resumidamente qual domínio técnico ou procedimento padronizado esta skill abrange e quais agentes devem utilizá-la.

## 2. Padrões de Implementação & Regras Invariantes
1. **Regra 1:** Diretriz técnica mandatória.
2. **Regra 2:** Convenções de código, nomenclatura ou tipagem.
3. **Regra 3:** Tratamento de erros, exceções ou estados de borda.

## 3. Exemplos & Snippets Canônicos
```language
// Insira um exemplo mínimo canônico representativo do padrão
```

## 4. Diretriz de File Read Gate & Automações CLI (se houver)
> Se esta skill mantiver dados volumosos (ex.: datasets CSV, dicionários, catálogos), eles devem residir em `data/` e ser consultados estritamente via script CLI em `scripts/search.py` (ou equivalente). Nunca faça a leitura bruta de datasets no contexto.

## 5. Checklist de Verificação da Skill
- [ ] O padrão foi aplicado sem desvios de arquitetura.
- [ ] As diretrizes de segurança aplicáveis foram observadas.
- [ ] Testes automatizados cobrem os fluxos afetados.

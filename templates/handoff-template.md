# Protocolo de Handoff entre Agentes Autônomos

> Utilizado durante a transição formal de contexto entre agentes (ex.: Arquiteto → Executor, Executor → Validador, Validador → Auto-Cura).

## Metadados do Handoff
- **De:** `agente-{{ORIGIN}}`
- **Para:** `agente-{{DESTINATION}}`
- **Feature / Tarefa:** `specs/{{FEATURE_ID}}/tasks.md` - Tarefa `{{TASK_ID}}`
- **Data / Hora:** `{{TIMESTAMP}}`

---

## 1. Escopo Entregue / Estado Atual
- Resumo sucinto do que foi implementado, especificado ou auditado.
- Arquivos modificados ou adicionados (lista pontual com caminhos relativos).

---

## 2. Contratos & Schemas Afetados
- [ ] Houve alteração em `contracts/openapi.yaml`? Se sim, quais endpoints?
- [ ] Houve alteração em eventos de tempo real?
- [ ] Todas as alterações foram sincronizadas antes do código?

---

## 3. Comandos de Verificação Rápida
Comandos imediatos para o agente destinatário reproduzir e validar o estado:
```bash
# Build
{{BUILD_COMMAND}}

# Testes Focados
{{TEST_COMMAND}}
```

---

## 4. Pontos de Atenção & Restrições Conhecidas
- Riscos pendentes, limites de tokens ou pontos que necessitam de atenção especial na próxima etapa.
- Decisões registradas em ADR associado (se houver).

# Relatório de Validação & QA — Feature {{FEATURE_NAME}}
> Gerado pelo `agente-validador-qa` ao final do ciclo de implementação.

## Informações Gerais
- **Feature / Épico:** `specs/{{FEATURE_ID}}`
- **Data da Validação:** `{{DATE}}`
- **Status Geral:** `[ APROVADO | REPROVADO | REPROVADO COM RESSALVAS ]`

---

## 1. Quality Gate 1: Compilação Limpa & Análise Estática
| Repositório | Comando Executado | Resultado | Observações |
| :--- | :--- | :--- | :--- |
| Back-End | `dotnet build --warnaserror` (ou equivalente) | `[PASS/FAIL]` | Sem warnings ou erros |
| Front-End | `npm run build` | `[PASS/FAIL]` | Build de produção limpo |
| Infra / Lint | `docker compose config` | `[PASS/FAIL]` | Schemas válidos |

---

## 2. Quality Gate 2: Bateria de Testes Automatizados
- **Testes Unitários / Integração:**
  - Total executados: `{{TOTAL}}`
  - Passaram: `{{PASSED}}`
  - Falharam: `{{FAILED}}`
- **Comando utilizado:** `{{TEST_COMMAND}}`
- **Bypass de Teste (se aplicável):** Confirmado que bypass de autenticação só é aceito em ambiente de teste estrito (`Testing`).

---

## 3. Quality Gate 3: Validação de Contratos (Contract-First)
- [ ] 100% dos endpoints implementados constam em `contracts/openapi.yaml`.
- [ ] Nenhuma rota não documentada foi exposta.
- [ ] Formatos de erro aderentes ao padrão RFC 7807 (`ProblemDetails`).

---

## 4. Quality Gate 4: Auditoria Visual Contínua (Playwright MCP)
> Obrigatório para qualquer alteração que afete a interface gráfica do usuário.

| Cenário / Tela | Viewport | Acessibilidade (WCAG 2.1 AA) | Evidência (Screenshot) | Status |
| :--- | :--- | :--- | :--- | :--- |
| Tela Principal | 1280x800 | Contraste ≥ 4.5:1, Labels OK | `playwright-audit/screen-01.png` | `PASS` |
| Modo Responsivo | 375x812 | Alvos de toque ≥ 44px | `playwright-audit/screen-01-mobile.png` | `PASS` |

---

## 5. Quality Gate 5: Checklist OWASP Top 10
- [ ] **A01/BOLA:** Autorização de nível de objeto validada com identificador do usuário.
- [ ] **A03/Injeção:** Consultas parametrizadas e sanitização completa de inputs.
- [ ] **Client-Side:** Sem `[innerHTML]` ou bypass de sanitização com dados externos.
- [ ] **LLM/IA (se aplicável):** Prompts protegidos com `<untrusted_content>` e outputs validados.
- [ ] **Dados & Arquivos:** Prevenção estrita contra Zip Slip (caminhos canônicos) e Decompression Bombs.

---

## 6. Conclusão & Parecer do Agente Validador
Parecer final do agente validador autorizando a entrega ou solicitando auto-cura/remediação.

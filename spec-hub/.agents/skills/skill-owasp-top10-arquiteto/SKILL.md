---
name: skill-owasp-top10-arquiteto
description: Validação de Segurança Arquitetural, Modelagem de Ameaças e Design Seguro baseada no OWASP Top 10 (A04:2021 Insecure Design), OWASP SAMM e OWASP ASVS v4.0.
---

# Skill: Validação de Segurança Arquitetural e Design Seguro OWASP (`skill-owasp-top10-arquiteto`)

## 1. Fonte Oficial e Fundamentação Teórica
Esta skill é fundamentada exclusivamente nos padrões e publicações do **OWASP (owasp.org)**:
- **OWASP Top 10:2021 — A04:2021 (Insecure Design):** Foco em falhas de concepção, arquitetura e modelagem de ameaças antes da codificação.
- **OWASP Software Assurance Maturity Model (SAMM v2.0):** Funções de negócio *Design* (*Threat Assessment* e *Security Requirements*).
- **OWASP Application Security Verification Standard (ASVS v4.0.3):** Capítulo *V1 — Architecture, Design and Threat Modeling*.
- **OWASP Threat Modeling Project:** Metodologia STRIDE para fronteiras de confiança (*Trust Boundaries*).

---

## 2. Escopo do Agente Arquiteto Planejador
O **Agente Arquiteto Planejador** atua nas fases `specify`, `plan` e `tasks` do Spec-Kit, sendo responsável por garantir que as vulnerabilidades de design sejam mitigadas na prancheta arquitetural antes que qualquer linha de código seja gerada.

### 2.1. Princípio Fundamental de Design Seguro (OWASP A04:2021)
> *"Insecure design cannot be fixed by a perfect implementation; security controls must be designed into the architecture from the beginning."* (owasp.org)

1. **Separação de Camadas e Domínio Isolado (Clean Architecture / ASVS V1.1):**
   - O projeto `{{PROJECT_NAME}}.Domain` deve permanecer estritamente agnóstico a bancos de dados, frameworks web e bibliotecas de terceiros (zero referências externas).
   - Fronteiras de confiança estritas entre Domínio, Aplicação e Infraestrutura externa.

2. **Fronteiras de Confiança nos Fluxos de Dados do usuário (Trust Boundaries):**
   - **Fronteira 1 — Ingestão de Arquivos:** Arquivos compactados (RAR/ZIP) vindos da pasta `/data/input` ou de upload do usuário são tratados como **dados 100% não confiáveis**.
   - **Fronteira 2 — Extração e OCR:** Textos brutos extraídos por OCR local ou provedor externo são strings não higienizadas com potencial de injeção.
   - **Fronteira 3 — Tradução Externa / RAG:** Prompts enviados ao provedor externo de LLM ou LLM local devem conter delimitações estruturais imutáveis.
   - **Fronteira 4 — Armazenamento armazenamento de objetos / S3:** Preservação estrita da pasta `/data/input` como volume somente leitura (`:ro`), canalizando saídas exclusivamente para `/data/output`.

---

## 3. Matriz de Validação Arquitetural OWASP A04:2021

| ID OWASP | Componente / Fluxo Arquitetural | Risco Arquitetural | Controle Mandatório na Especificação (`plan.md` / ADR) |
| :--- | :--- | :--- | :--- |
| **A04.1** | Ingestão de Arquivos compactados (ZIP/RAR) | Zip Slip / Path Traversal / Decompression Bomb | Exigir validação de caminho canônico (`Path.GetFullPath`) e limitação de taxa de expansão/tamanho descompactado antes de gravar em disco. |
| **A04.2** | Autenticação e MFA TOTP | Bypass acidental em produção | Isolar o bypass de testes (`000000`) estritamente à condição `ASPNETCORE_ENVIRONMENT=Testing` ou `AUTH_BYPASS_MFA_FOR_TESTS=true`; proibir a existência dessas variáveis em qualquer spec de produção. |
| **A04.3** | Motor Híbrido de Tradução (RAG + LLM) | Prompt Injection & Information Disclosure | Modelar orçamentos de tokens (`MaxCharacterBudget`), tags delimitadoras de contexto não confiável (`<untrusted_content>`) e mascaramento de segredos em logs. |
| **A04.4** | Contratos de API (`openapi.yaml`) | Mass Assignment e Exposição de Atributos Internos | Proibir binding direto de entidades de Domínio nas rotas da API; exigir DTOs contratuais dedicados para cada requisição e resposta. |
| **A04.5** | Conexões em Tempo Real (SignalR) | Acesso anônimo a eventos de tradução | Exigir token JWT no handshake do `TranslationProgressHub` e isolamento de grupos por `ProjectId`. |

---

## 4. Checklist Arquitetural de Threat Modeling (ASVS V1)
Ao executar a etapa `plan` e criar novas especificações de features, o Arquiteto Planejador deve verificar:

- [ ] **Mapeamento de Ameaças STRIDE:** Spoofing, Tampering, Repudiation, Information Disclosure, Denial of Service e Elevation of Privilege foram avaliados para novos endpoints?
- [ ] **Princípio do Menor Privilégio:** Os componentes acessam apenas os recursos estritamente necessários (ex: banco de dados sem privilégios de superusuário, pasta de dados do usuário somente leitura)?
- [ ] **Defesa em Profundidade:** A segurança depende de camadas múltiplas (ex: validação no Angular + validação no Controller .NET + constraints no Domínio/Banco)?
- [ ] **Modo Fail-Secure:** Em caso de falha em qualquer motor de IA (ex: indisponibilidade da GPU dedicada ou falta de chave provedor externo de LLM), o sistema rebaixa ordenadamente para o modo seguro/offline sem crash ou vazamento de pilha de erro?
- [ ] **Contratos Imutáveis:** Os esquemas do `openapi.yaml` contêm tipos, formatos, `required`, enumerações e tamanhos máximos bem especificados para evitar consumo irrestrito?

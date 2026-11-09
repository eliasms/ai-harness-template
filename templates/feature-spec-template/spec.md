# Feature Specification: {{FEATURE_NAME}}
> ID: `{{FEATURE_ID}}` | Status: `DRAFT`

## 1. Visão Geral & Objetivos
Descreva o propósito da feature, o problema de negócio que resolve e os usuários impactados.

## 2. Histórias de Usuário & Critérios de Aceite
### US1: {{USER_STORY_TITLE}}
- **Como** {{USER_ROLE}}
- **Quero** {{GOAL}}
- **Para que** {{BENEFIT}}

#### Critérios de Aceite (Gherkin):
```gherkin
Cenário: Sucesso no fluxo principal
  Dado que o usuário está autenticado
  Quando ele submete uma requisição válida
  Então o sistema retorna status 200 e confirma a operação
```

## 3. Requisitos Não Funcionais
- **Desempenho:** Tempo de resposta p95 abaixo de {{THRESHOLD}}ms.
- **Segurança:** Acesso protegido por JWT, mitigação de OWASP A01 (BOLA) e inputs sanitizados.
- **Acessibilidade:** Componentes de interface aderentes a WCAG 2.1 AA.

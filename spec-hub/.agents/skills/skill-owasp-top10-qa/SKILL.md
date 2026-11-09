---
name: skill-owasp-top10-qa
description: Validação e Auditoria de Testes de Segurança baseada no OWASP Web Security Testing Guide (WSTG v4.2) e Verificação do OWASP Top 10.
---

# Skill: Validação e Auditoria de Testes de Segurança OWASP (`skill-owasp-top10-qa`)

## 1. Fonte Oficial e Fundamentação Teórica
Esta skill é fundamentada exclusivamente nos padrões e publicações do **OWASP (owasp.org)**:
- **OWASP Web Security Testing Guide (WSTG v4.2):** O guia de testes definitivo para avaliação de segurança dinâmica e testes de invasão orientados a desenvolvedores/QA.
- **OWASP Top 10:2021 Verification Standards.**
- **OWASP API Security Top 10 Verification Standards.**

---

## 2. Escopo do Agente Validador QA
O **Agente Validador QA** executa a etapa `validate` do Spec-Kit ao término de cada Épico/feature, auditando a aderência técnica às regras imutáveis, executando suítes de testes unitários, testes de integração e testes E2E com dados reais de amostra.

---

## 3. Matriz de Testes de Segurança WSTG v4.2 para Automação

### 3.1. Testes de Autenticação e MFA (WSTG-ATHN)
- **WSTG-ATHN-01 (Credenciais e Força Bruta):**
  - Implementar teste xUnit enviando 6 tentativas com senhas incorretas seguidas; comprovar bloqueio temporário (HTTP 429 Too Many Requests ou HTTP 401 com mensagem de bloqueio).
- **WSTG-ATHN-08 (MFA TOTP & Bypass Control):**
  - Comprovar que o bypass `000000` **falha obrigatoriamente com HTTP 401 Unauthorized** se o ambiente de execução for diferente de `Testing` e `AUTH_BYPASS_MFA_FOR_TESTS` for `false`.
  - Testar algoritmo RFC 6238 real calculando HMAC-SHA1 contra o segredo Base32 e validando o código temporário.
- **WSTG-ATHN-06 (Tokens e Sessão):**
  - Testar tokens JWT com assinatura inválida, expirados e com algoritmo `none` no cabeçalho; todos devem ser rejeitados imediatamente.

### 3.2. Testes de Autorização e BOLA/IDOR (WSTG-ATHZ)
- **WSTG-ATHZ-01 (Directory Traversal / File Inclusion):**
  - Testar endpoints `/api/v1/files/import` e `/api/v1/files/{id}/content` passando caminhos maliciosos como `../../../../etc/passwd` ou `..\..\Windows\win.ini`.
  - Comprovar que a API rejeita a requisição com HTTP 400 Bad Request ou erro de validação sem vazar arquivos fora do escopo.
- **WSTG-ATHZ-02 (Broken Object Level Authorization - BOLA):**
  - Criar dois usuários de teste (`User A` e `User B`). Autenticar como `User B` e tentar acessar, editar ou excluir um projeto pertencente a `User A`.
  - Comprovar que a resposta é `HTTP 404 Not Found` ou `HTTP 403 Forbidden`.
- **WSTG-ATHZ-03 (Broken Function Level Authorization - BFLA):**
  - Executar requisições a rotas administrativas (`/api/v1/system/ai-status`, `/api/v1/admin/*`) utilizando o token de um usuário comum sem privilégios administrativos.
  - Comprovar que a API retorna estritamente `HTTP 403 Forbidden`.

### 3.3. Testes de Validação de Entrada e Injeção (WSTG-INPV)
- **WSTG-INPV-01 & 02 (SQL Injection):**
  - Enviar payloads clássicos (`' OR '1'='1`, `'; DROP TABLE "Users";--`) nos filtros de busca da API (`/api/v1/<recurso>?search=...`).
  - Validar que o EF Core 10 executa a busca parametrizada sem executar comandos arbitrários e sem gerar exceções SQL não tratadas.
- **WSTG-INPV-11 (XSS / DOM XSS):**
  - Inserir strings contendo tags `<script>alert('XSS')</script>` e atributos maliciosos (`<img src=x onerror=alert(1)>`) nos campos de edição de texto da interface.
  - Comprovar via teste de renderização no Angular que os caracteres são encodados como texto puro (`&lt;script&gt;`) e nunca executados como código HTML ativo.

### 3.4. Testes de Tratamento de Erros e Vazamento de Informações (WSTG-ERRH / WSTG-INFO)
- **WSTG-ERRH-01 (Error Handling Analysis):**
  - Forçar exceções de banco de dados ou formato inválido na API.
  - Validar que a resposta segue o padrão RFC 7807 (`ProblemDetails`) e **não contém**:
    - Stack traces internos do .NET;
    - Nomes de tabelas ou consultas SQL do PostgreSQL;
    - Caminhos de diretórios internos da máquina ou do container.

### 3.5. Testes de Integridade de Arquivos e Formatos (WSTG-BUSL / WSTG-APIT)
- **Validação de Ingestão de Arquivos Reais:**
  - Executar teste de regressão E2E processando um arquivo real de amostra da pasta `/data/input`.
  - Comprovar que os arquivos originais permanecem com data de modificação e hash SHA256 inalterados (somente leitura respeitado).
  - Validar que o artefato gerado em `/data/output` é válido e preserva a integridade do original (ex.: mesma contagem de itens/páginas).

---

## 4. Checklist de Execução QA
- [ ] Suíte de testes automatizados xUnit rodando com 100% de aprovação (`dotnet test`).
- [ ] Teste de rejeição do bypass MFA `000000` em ambiente de produção validado.
- [ ] Testes de BOLA (tentativa de acesso cruzado a projetos entre usuários diferentes) com aprovação.
- [ ] Teste de Path Traversal nos métodos de importação e download de páginas com aprovação.
- [ ] Teste de carga e rate limiting nos endpoints de autenticação e importação.
- [ ] Auditoria de compilação sem avisos de segurança (`--warnaserror`).

---
name: skill-owasp-top10-devops
description: Validação de Segurança de Infraestrutura e Containers baseada no OWASP Docker Top 10 (D01-D10) e OWASP Container Security Cheat Sheet.
---

# Skill: Validação de Segurança DevOps e Docker OWASP (`skill-owasp-top10-devops`)

## 1. Fonte Oficial e Fundamentação Teórica
Esta skill é fundamentada exclusivamente nos padrões e publicações do **OWASP (owasp.org)**:
- **OWASP Docker Top 10 Project:** Os 10 controles de segurança essenciais para ambientes baseados em containers (D01 a D10).
- **OWASP Container Security Cheat Sheet** e **OWASP Docker Security Cheat Sheet**.
- **OWASP Top 10:2021 — A05:2021 (Security Misconfiguration)** e **A06:2021 (Vulnerable and Outdated Components)**.

---

## 2. Escopo do Agente Executor DevOps
O **Agente Executor DevOps** orquestra o repositório `{{PROJECT_SLUG}}-infra-containers`, sendo responsável por `docker-compose.yml`, Dockerfiles, volumes de dados, healthchecks, GPU passthrough (quando aplicável) e provisionamento de modelos/artefatos de IA.

---

## 3. Matriz de Controles OWASP Docker Top 10 (D01–D10)

### D01 — Secure User Mapping (Execução Sem Root)
- **Diretriz OWASP:** Processos dentro do container nunca devem rodar com usuário `root` padrão (UID 0) para mitigar riscos de escape de container (*container breakout*).
- **Implementação no Projeto:**
  - Nos Dockerfiles da API (.NET 10) e Frontend (Nginx), criar e utilizar um usuário sem privilégios (`appuser` / UID 10001):
  ```dockerfile
  RUN addgroup --system --gid 10001 appgroup && adduser --system --uid 10001 --ingroup appgroup appuser
  USER appuser
  ```
  - Em serviços do Compose, definir explicitamente `user: "10001:10001"`.

### D02 — Patch Management Strategy (Atualização e Vulnerabilidades)
- **Diretriz OWASP:** Manter imagens base, runtime e host atualizados para eliminar CVEs conhecidas.
- **Implementação no Projeto:**
  - Utilizar imagens oficiais com tags imutáveis e versões estáveis minimais (ex: `postgres:16-alpine`, `redis:7-alpine`, `mcr.microsoft.com/dotnet/aspnet:10.0-noble-chiseled` ou Alpine).
  - Executar verificação automatizada de vulnerabilidades nas imagens com ferramentas de scanning (ex: Trivy / Docker Scout).

### D03 — Network Segmentation and Firewalling (Segmentação de Rede)
- **Diretriz OWASP:** Separar a rede em zonas lógicas para impedir acesso lateral não autorizado entre containers.
- **Implementação no Projeto:**
  - Definir redes isoladas no `docker-compose.yml`:
    - `frontend-net`: Comunicação exclusiva entre Nginx (Frontend) e Backend API.
    - `backend-net`: Comunicação entre Backend API, PostgreSQL, Redis, armazenamento de objetos e banco vetorial.
  - Proibir a exposição pública de portas de infraestrutura interna:
    - **Portas fechadas para o host externo:** Postgres (`5432`), Redis (`6379`), armazenamento de objetos API interna (`9000`), banco vetorial interno (`6333`). Apenas o Backend API e o Frontend Web acessam essas redes.

### D04 — Secure Defaults and Hardening (Endurecimento de Containers)
- **Diretriz OWASP:** Desativar recursos não essenciais e restringir privilégios do kernel Linux.
- **Implementação no Projeto:**
  - Adicionar aos serviços do Compose:
  ```yaml
  security_opt:
    - no-new-privileges:true
  cap_drop:
    - ALL
  ```
  - Quando capacidades adicionais forem exigidas (ex: GPU NVIDIA GPU dedicada), habilitar estritamente via bloco `deploy.resources.reservations.devices`.

### D05 — Maintain Security Contexts (Isolamento de Ambientes)
- **Diretriz OWASP:** Impedir que configurações de teste ou desenvolvimento contaminem o ambiente de produção.
- **Implementação no Projeto:**
  - Variáveis perigosas como `AUTH_BYPASS_MFA_FOR_TESTS=true` e `ASPNETCORE_ENVIRONMENT=Testing` são **terminantemente proibidas** no `docker-compose.yml` base ou no arquivo `.env.example`.
  - Ambientes de teste automatizado devem rodar em compose temporário separado (`docker-compose.test.yml`).

### D06 — Protect Secrets (Proteção de Segredos)
- **Diretriz OWASP:** Nunca gravar senhas, chaves de API, certificados ou segredos em imagens Docker ou arquivos versionados no Git.
- **Implementação no Projeto:**
  - Utilizar `.env` local (incluso no `.gitignore`) ou Docker Secrets para:
    - `POSTGRES_PASSWORD`, `REDIS_PASSWORD`
    - `<STORAGE>_ROOT_PASSWORD` (armazenamento de objetos, se usado)
    - `JWT_SECRET_KEY`
    - `<PROVEDOR>_API_KEY` (ex.: chaves de provedores de IA)
    - `<VECTORDB>_API_KEY` (banco vetorial, se usado)
  - Validar que o `.env.example` contenha apenas chaves sem segredos reais (ex: `POSTGRES_PASSWORD=CHANGE_ME_IN_PRODUCTION`).

### D07 — Resource Protection (Limites de Recursos / Prevenção de DoS)
- **Diretriz OWASP:** Limitar o consumo de CPU, memória e I/O por container para que nenhum serviço cause saturação geral do host.
- **Implementação no Projeto:**
  - Configurar limites explícitos de recursos no `docker-compose.yml`:
  ```yaml
  deploy:
    resources:
      limits:
        cpus: '4.0'
        memory: 4096M
      reservations:
        cpus: '1.0'
        memory: 1024M
  ```

### D08 — Container Image Integrity and Origin (Integridade de Imagens e Modelos)
- **Diretriz OWASP:** Validar a autenticidade e proveniência das imagens de container e artefatos de IA.
- **Implementação no Projeto:**
  - Os scripts de inicialização de modelos (`init-models.ps1` / `init-models.sh`) devem validar o hash SHA256 dos arquivos de modelo/artefato baixados (ex.: `*.onnx`, `*.gguf`) antes de copiá-los para o volume compartilhado `/models`.

### D09 — Follow Immutable Paradigm & Proteção da Pasta de Entrada `/data/input`
- **Diretriz OWASP:** Tratar containers como efêmeros e imutáveis, usando sistemas de arquivos somente leitura onde aplicável.
- **Implementação no Projeto:**
  - **Regra Imutável de Dados de Entrada:** O volume dos dados originais deve ser montado obrigatoriamente como `read-only`:
  ```yaml
  volumes:
    - ../data/input:/app/seed-data:ro
    - ../data/output:/data/output:rw
  ```
  - Proibir qualquer montagem que conceda permissão de escrita sobre a pasta `/data/input` original.

### D10 — Centralized and Secure Logging
- **Diretriz OWASP:** Habilitar e auditar logs de containers prevenindo estouro de disco.
- **Implementação no Projeto:**
  - Configurar driver de log com rotação no Compose:
  ```yaml
  logging:
    driver: "json-file"
    options:
      max-size: "50m"
      max-file: "5"
  ```

---

## 4. Checklist de Validação para o Agente DevOps
- [ ] Nenhum container roda com usuário root desnecessário (`no-new-privileges:true` aplicado).
- [ ] Portas internas de banco, cache, storage e vector DB não estão expostas para a máquina hospedeira.
- [ ] Pasta `/data/input` original montada estritamente com a flag `:ro`.
- [ ] Modelos/artefatos de IA passam por verificação de integridade SHA256 antes da inicialização dos serviços.
- [ ] Limites de CPU e memória (`limits.memory`) configurados em todos os containers.
- [ ] Segredos de produção e chaves de API ausentes do código versionado e do Compose base.

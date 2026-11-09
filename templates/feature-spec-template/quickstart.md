# Quickstart: {{FEATURE_NAME}}

Instruções rápidas para desenvolvedores e agentes testarem localmente esta funcionalidade.

## 1. Pré-requisitos
- Serviços de infraestrutura em execução (`docker compose up -d`).
- Migrations aplicadas.

## 2. Passos de Execução
```bash
# 1. Executar Back-End
dotnet run --project {{PROJECT_SLUG}}-backend-dotnet/src/WebApi

# 2. Executar Front-End
cd {{PROJECT_SLUG}}-frontend-angular && npm start

# 3. Validar Endpoint
curl -X GET http://localhost:5000/api/v1/system/status
```

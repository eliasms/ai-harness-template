---
name: skill-mfa-totp-rfc6238
description: Implementação de autenticação multifator TOTP (RFC 6238) compatível com Google/Microsoft Authenticator e bypass restrito para testes automatizados.
---

# Skill: MFA TOTP RFC 6238 (`skill-mfa-totp-rfc6238`)

## Especificação Técnica
1. **Padrão RFC 6238 (HMAC-SHA1, 6 dígitos, janela de 30s):**
   - Segredo de 20 bytes (160 bits) codificado em **Base32** (RFC 4648 sem padding `=`).
   - URI de provisionamento QR Code:
     `otpauth://totp/{{PROJECT_NAME}}:{email}?secret={base32Secret}&issuer={{PROJECT_NAME}}&algorithm=SHA1&digits=6&period=30` (URL-encode o nome do projeto).
   - Geração de **10 códigos de recuperação** alfanuméricos de uso único (formato `XXXX-XXXX`), armazenados com hash.
2. **Onboarding Obrigatório no Primeiro Acesso:**
   - Usuários com `MfaEnabled = false` recebem no login a flag `requiresMfaSetup = true` e um token temporário de onboarding para chamar `/api/v1/auth/mfa/setup` e `/api/v1/auth/mfa/verify-setup`.
3. **Regra de Automação (Harness):**
   - Quando `ASPNETCORE_ENVIRONMENT=Testing` **e** `AUTH_BYPASS_MFA_FOR_TESTS=true`, o validador aceita o código fixo `000000` além do código RFC 6238 real. Fora de `Testing` o bypass **deve falhar** (verificado por `agente-validador-qa`).
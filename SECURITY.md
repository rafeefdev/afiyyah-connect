# Security Policy

- Please report vulnerabilities privately to: rafeef.dev03@gmail.com
- We acknowledge within 14 days and aim to remediate within 90 days.
- Do not open public issues for security reports.

## Scope
- App source code in this repo. Backend instances and deployments are managed by users.

## Data protection
- This software can process personal/health data when self-hosted. Operators are responsible for complying with local regulations and configuring access controls (RLS) correctly.

## Key guidance
- Never use Supabase service-role keys in the client app.
- Enable and test Row Level Security (RLS) on all tables before production.
- Limit logging in production and avoid storing PII in logs.


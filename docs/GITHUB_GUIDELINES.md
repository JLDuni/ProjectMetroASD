# Normas do GitHub, GitFlow e Rastreabilidade de IA

| Categoria | Regra obrigatória | Sintaxe / padrão | Objetivo | Exemplo |
|---|---|---|---|---|
| Branches (GitFlow) | Proibido commit direto na `main`. Um branch por task. | `main` (produção) · `develop` (integração) · `feature/M3-nome-tarefa` · `hotfix/descricao` | Estabilidade e deploy automático via CI/CD | `feature/M3-ticketing-idempotency` → `develop` |
| Commits (Conventional Commits) | Todas as mensagens têm `<tipo>(<âmbito>): <descrição>`. | `feat` · `fix` · `docs` · `style` · `refactor` · `test` · `chore` | Rastreabilidade e changelog automático | `feat(ticketing): implementa verificacao de idempotencia no endpoint de validacao` |
| Pull Requests | PR para `develop` exige ≥ 1 revisão humana + CI a passar. | Template: Descrição · Requisitos (FR/NFR) · Checklist de testes · Tabela de IA | Impedir código com bugs ou sem revisão | `PR #12: Feature Ticketing -> develop` (linters OK + 2 aprovações) |
| Issues & Requisitos | Commit gerado/auxiliado por IA termina com as tags de issue e requisito. | `Issue #XX: [FR-13] Implementar Validação de Bilhetes` | Rastreabilidade enunciado → issue → commit → teste → deploy | `Fixes #14` no commit · `Closes #14` no PR |

## Fluxo

| # | Passo | Comando / onde |
|---:|---|---|
| 1 | Criar issue com requisito | GitHub Issues: `[FR-13] Implementar Validação de Bilhetes` |
| 2 | Criar branch a partir de `develop` | `git switch develop && git pull && git switch -c feature/M3-<tarefa>` |
| 3 | Commits | ver modelo abaixo |
| 4 | Abrir PR para `develop` | template `.github/pull_request_template.md` |
| 5 | Revisão + CI verde | ≥ 1 aprovação humana |
| 6 | Merge em `develop` | — |
| 7 | Release | `develop` → `main` (deploy) |
| — | Correção urgente | `hotfix/<descricao>` a partir de `main`, merge em `main` e `develop` |

## Modelo de commit

```
<tipo>(<âmbito>): <descrição>

Issue #<n>: [<FR/NFR>] <título da tarefa>
Fixes #<n>
```

| Âmbitos | `core` · `ticketing` · `notifications` · `webapp` · `ci` · `infra` · `seed` · `docs` |
|---|---|

## Registo de IA

Todo o uso de IA é registado em `docs/excels/Guia_Reg_IA`:

| ID Registo | Data | Membro | Fase SDLC | Tarefa | Ferramenta IA | Prompt / contexto | Autonomia (%) | Tempo humano (min) | Resultado / erros | Commit SHA |
|---|---|---|---|---|---|---|---:|---:|---|---|
| LOG-XXX | AAAA-MM-DD | | | | | | | | | |

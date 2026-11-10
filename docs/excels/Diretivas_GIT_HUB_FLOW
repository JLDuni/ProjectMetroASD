

| Categoria / Norma | Regra Obrigatória | Sintaxe / Padrão Exigido | Objetivo / Rastreabilidade | Exemplo Concreto |
|---|---|---|---|---|
| **Estratégia de Branches (GitFlow)** | **Proibido fazer commit direto na `main`. Um branch para cada task** | `main` (produção) \| `develop` (integração) \| `feature/M3-nome-tarefa` \| `hotfix/descricao` | Garantir estabilidade e deploys automáticos via CI/CD. | `feature/M3-ticketing-idempotency` `develop` |
| **Convenção de Commits (Conventional Commits)** | **Todas as mensagens de commit devem ter uma <descrição>.** | `feat`, `fix`, `docs`, `style`, `refactor`, `test`, `chore` | Facilitar rastreabilidade e geração automática de changelogs. | `feat(ticketing): implementa verificacao de idempotencia no endpoint de validacao` |
| **Regras de Pull Request (PR)** | **Todo o PR para a branch `develop` requer revisão por pelo menos 1 membro humano da equipa e passagem obrigatória na CI Pipeline.** | Template de PR com: Descrição, Requisitos afetados (FR/NFR), Checklist de Testes e Tabela de IA. | Evitar que código com bugs ou gerado sem revisão entre no repositório principal. | `PR #12: Feature Ticketing -> develop (Passou linters + 2 aprovações humanas)` |
| **Mapeamento de Issues & Requisitos** | **Todo o commit gerado ou auxiliado por IA DEVE conter as tags de métricas no final da mensagem de commit.** | `Issue #XX: [FR-13] Implementar Validação de Bilhetes` | Traceability completa entre enunciado, issue, commit, teste e deploy. | `Fixes #14` no commit / `Closes #14` no PR |


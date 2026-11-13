# Seed Data — M3

| Ficheiro | Tarefa | Tabelas |
|---|---|---|
| [01-rede-paragens-linhas.md](01-rede-paragens-linhas.md) | #11 | stops, lines, line_stops |
| [02-horarios-calendario.md](02-horarios-calendario.md) | #12 | day_types, day_type_exceptions, trip_templates, trip_instances, stop_schedules |
| [03-tarifario.md](03-tarifario.md) | #13 | ticket_types, passenger_tickets |
| [04-ocupacao.md](04-ocupacao.md) | #14 | trip_occupancy |

Referências entre ficheiros por `code`/id curto; UUIDs gerados pelo seed.

## Por decidir

| # | Questão |
|---|---|
| 1 | Coordenadas GPS e distâncias das paragens (OSM) |
| 2 | Data da avaliação |
| 3 | Aceitar validação com viagem FULL? |
| 4 | Alterações ao Dados_Seed: TCK_1001 → EXPIRED, "Zapp" → "Pack 10 Viagens", preço em cêntimos |

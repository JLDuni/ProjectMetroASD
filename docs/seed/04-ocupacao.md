# 04 — Ocupação (FR15–FR17, AM-06, AM-07)

| Parâmetro | Valor |
|---|---|
| max_capacity (por veículo) | 80 |
| occupancy | `clamp(nº validações ACCEPTED + manual_adjustment, 0, max_capacity)` |
| remaining | `max_capacity − occupancy` |
| OCCUPANCY_MEDIUM_PCT | 50 |
| OCCUPANCY_FULL_PCT | 90 |

| status | regra | max = 80 |
|---|---|---|
| LOW | < 50 % | 0 – 39 |
| MEDIUM | 50 – 89 % | 40 – 71 |
| FULL | ≥ 90 % | 72 – 80 |

## trip_occupancy (dia D)

| line | direction | partida | manual_adjustment | occupancy | status |
|---|---|---|---:|---:|---|
| L1 | OUTBOUND | 08:00 | 25 | 25 | LOW |
| L1 | OUTBOUND | 08:30 | 55 | 55 | MEDIUM |
| L3 | INBOUND | 18:00 | 75 | 75 | FULL |
| restantes | | | 0 | 0 | LOW |

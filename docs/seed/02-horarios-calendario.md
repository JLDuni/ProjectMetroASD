# 02 — Horários e calendário (FR4, AM-01, AM-02)

## day_types

| code | description |
|---|---|
| WEEKDAY | Segunda a sexta |
| SATURDAY | Sábado |
| SUNDAY_HOLIDAY | Domingo e feriado |

## day_type_exceptions

| date | day_type | reason |
|---|---|---|
| 2026-12-01 | SUNDAY_HOLIDAY | Restauração da Independência |
| 2026-12-08 | SUNDAY_HOLIDAY | Imaculada Conceição |
| 2026-12-25 | SUNDAY_HOLIDAY | Natal |
| 2027-01-01 | SUNDAY_HOLIDAY | Ano Novo |

## trip_templates (frequências, por sentido)

| line | day_type | primeira | última | frequência | partidas/sentido |
|---|---|---|---|---|---:|
| L1 | WEEKDAY | 06:30 | 22:30 | 30 min | 33 |
| L1 | SATURDAY | 07:00 | 22:00 | 60 min | 16 |
| L1 | SUNDAY_HOLIDAY | 08:00 | 21:00 | 60 min | 14 |
| L2 | WEEKDAY | 07:00 | 21:00 | 30 min | 29 |
| L2 | SATURDAY | 08:00 | 20:00 | 60 min | 13 |
| L2 | SUNDAY_HOLIDAY | 08:00 | 20:00 | 60 min | 13 |
| L3 | WEEKDAY | 07:00 | 20:45 | 15 min | 56 |
| L3 | SATURDAY | 08:00 | 20:00 | 30 min | 25 |
| L3 | SUNDAY_HOLIDAY | 09:00 | 20:00 | 30 min | 23 |

`direction`: OUTBOUND / INBOUND, mesmos horários nos dois terminais. `max_capacity`: 80.

| Totais | |
|---|---:|
| trip_templates | 444 |
| trip_instances / dia útil | 236 |
| trip_instances / sábado | 108 |
| trip_instances / domingo ou feriado | 100 |

## trip_instances

| Parâmetro | Valor |
|---|---|
| Janela gerada | D−1 … D+7 (D = dia em que o seed corre) |
| Hora dos templates | local Europe/Lisbon |
| Hora guardada | UTC |
| Chave única | (trip_template_id, date) |

## Cenários de demo (dia D)

| line | direction | partida | status | delay_minutes | diverted_to |
|---|---|---|---|---:|---|
| L1 | OUTBOUND | 08:30 | DELAYED | 10 | |
| L2 | OUTBOUND | 09:00 | CANCELLED | | |
| L2 | OUTBOUND | 17:00 | DIVERTED | | L1 |
| L3 | INBOUND | 18:00 | NORMAL (FULL) | | |

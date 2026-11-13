# 03 — Tarifário (FR10–FR12, AM-03)

## ticket_types

| code | name | preço (€) | price_cents | validity_hours | max_journeys | line_restriction | conditions |
|---|---|---:|---:|---:|---|---|---|
| T1 | Bilhete Simples | 1,50 € | 150 | 2 | 1 | — | 1 viagem, 2 h após compra |
| T2 | Pack 10 Viagens | 10,00 € | 1000 | 720 | 10 | — | 10 viagens, 30 dias após compra |
| T3 | Passe Diário | 5,00 € | 500 | 24 | ilimitado (NULL) | — | 24 h após compra |
| T4 | Passe Mensal | 30,00 € | 3000 | 720 | ilimitado (NULL) | — | 30 dias após compra |

`valid_until = purchase + validity_hours` · EXPIRED quando `now ≥ valid_until` ou `remaining_journeys = 0`.

## passenger_tickets (passageiro de teste · T = momento do seed)

| type | preço pago (€) | purchase | valid_until | remaining_journeys | status |
|---|---:|---|---|---:|---|
| T1 | 1,50 € | T − 3 h | T − 1 h | 0 | EXPIRED |
| T2 | 10,00 € | T − 5 d | T + 25 d | 7 | ACTIVE |
| T1 | 1,50 € | T − 10 min | T + 110 min | 1 | ACTIVE |
| T4 | 30,00 € | T − 2 d | T + 28 d | NULL | ACTIVE |
| T3 | 5,00 € | T − 30 h | T − 6 h | NULL | EXPIRED |

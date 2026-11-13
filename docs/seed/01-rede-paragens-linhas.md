# 01 — Paragens e linhas (FR2, FR3)

Fonte: mapa da Rede Metrobus. Coordenadas e `distance_km`: **por preencher (OSM)**.

## lines

| code | name | color | is_active | percurso |
|---|---|---|---|---|
| L1 | Linha Azul | #1F5FAD | true | Coimbra-B ↔ Serpins |
| L2 | Linha Vermelha | #D7262E | true | República ↔ Serpins |
| L3 | Linha Verde | #6BB33F | true | Coimbra-B ↔ República |
| L4 | Linha do Hospital | #8C8C8C | false | República ↔ Pediátrico (futura) |

## stops + line_stops

`seq · min` = ordem na linha · minutos desde o terminal (sentido de ida).

| id | name | zone | ativa | lat | lon | L1 seq · min | L2 seq · min | L3 seq · min | L4 seq |
|---:|---|---|---|---|---|---|---|---|---|
| 1 | Coimbra-B | Z1 | sim | | | 1 · 0 |  | 1 · 0 |  |
| 2 | Casa do Sal | Z1 | sim | | | 2 · 2 |  | 2 · 2 |  |
| 3 | Açude | Z1 | sim | | | 3 · 4 |  | 3 · 4 |  |
| 4 | Arnado | Z1 | sim | | | 4 · 6 |  | 4 · 6 |  |
| 5 | Aeminium | Z1 | sim | | | 5 · 8 | 5 · 8 | 5 · 8 |  |
| 6 | Portagem | Z1 | sim | | | 6 · 10 | 6 · 10 |  |  |
| 7 | Parque | Z1 | sim | | | 7 · 12 | 7 · 12 |  |  |
| 8 | Colégios | Z1 | sim | | | 8 · 14 | 8 · 14 |  |  |
| 9 | Arregaça | Z1 | sim | | | 9 · 16 | 9 · 16 |  |  |
| 10 | Norton de Matos | Z1 | sim | | | 10 · 18 | 10 · 18 |  |  |
| 11 | São José | Z1 | sim | | | 11 · 20 | 11 · 20 |  |  |
| 12 | Solum | Z1 | sim | | | 12 · 22 | 12 · 22 |  |  |
| 13 | Fernando Namora | Z1 | sim | | | 13 · 24 | 13 · 24 |  |  |
| 14 | Casa Branca | Z1 | sim | | | 14 · 26 | 14 · 26 |  |  |
| 15 | Vale das Flores | Z1 | sim | | | 15 · 28 | 15 · 28 |  |  |
| 16 | Alto de São João | Z1 | não | | |  |  |  |  |
| 17 | Portela | Z1 | sim | | | 16 · 30 | 16 · 30 |  |  |
| 18 | Quinta da Ponte | Z1 | sim | | | 17 · 32 | 17 · 32 |  |  |
| 19 | Ceira | Z1 | sim | | | 18 · 35 | 18 · 35 |  |  |
| 20 | Sobral de Ceira | Z1 | sim | | | 19 · 38 | 19 · 38 |  |  |
| 21 | Vale de Açor | Z2 | sim | | | 20 · 41 | 20 · 41 |  |  |
| 22 | Trémoa | Z2 | sim | | | 21 · 44 | 21 · 44 |  |  |
| 23 | Moinhos | Z2 | sim | | | 22 · 47 | 22 · 47 |  |  |
| 24 | Lobazes | Z2 | sim | | | 23 · 50 | 23 · 50 |  |  |
| 25 | Miranda do Corvo | Z2 | sim | | | 24 · 53 | 24 · 53 |  |  |
| 26 | Corvo | Z2 | sim | | | 25 · 56 | 25 · 56 |  |  |
| 27 | Padrão | Z3 | sim | | | 26 · 59 | 26 · 59 |  |  |
| 28 | Meiral | Z3 | sim | | | 27 · 62 | 27 · 62 |  |  |
| 29 | Lousã - Parque de Exposições | Z3 | sim | | | 28 · 65 | 28 · 65 |  |  |
| 30 | Lousã - Estação | Z3 | sim | | | 29 · 68 | 29 · 68 |  |  |
| 31 | Casal do Espírito Santo | Z3 | sim | | | 30 · 71 | 30 · 71 |  |  |
| 32 | Casal de Santo António | Z3 | sim | | | 31 · 74 | 31 · 74 |  |  |
| 33 | Serpins | Z3 | sim | | | 32 · 77 | 32 · 77 |  |  |
| 34 | Loja do Cidadão | Z1 | sim | | |  | 4 · 6 | 6 · 10 |  |
| 35 | Câmara | Z1 | sim | | |  | 3 · 4 | 7 · 12 |  |
| 36 | Mercado | Z1 | sim | | |  | 2 · 2 | 8 · 14 |  |
| 37 | República | Z1 | sim | | |  | 1 · 0 | 9 · 16 | 1 |
| 38 | Sereia | Z1 | não | | |  |  |  | 2 |
| 39 | Celas | Z1 | não | | |  |  |  | 3 |
| 40 | Polo Ciências da Saúde | Z1 | não | | |  |  |  | 4 |
| 41 | Hospitais (HUC) | Z1 | não | | |  |  |  | 5 |
| 42 | Pediátrico | Z1 | não | | |  |  |  | 6 |

Tempos: 2 min entre paragens em Coimbra (até Quinta da Ponte), 3 min a partir de Ceira.
Sentido de volta = sequência invertida, `min_volta = min_total − min_ida`.

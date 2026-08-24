# Local SQLite schema (authoritative for the app)

All ids are client-generated UUID strings. Timestamps are UTC epoch milliseconds. Soft delete uses `deleted_at_ms`.

## customers

| Column | Type | Notes |
| --- | --- | --- |
| id | TEXT PK | Client UUID |
| display_name | TEXT | Original display value |
| name_search | TEXT | Normalized for LIKE search |
| phone | TEXT NULL | Display value |
| phone_search | TEXT NULL | Digits-only |
| email | TEXT NULL |
| address | TEXT NULL |
| photo_path | TEXT NULL | Managed local file, not a blob |
| created_at_ms | INTEGER |
| updated_at_ms | INTEGER |
| deleted_at_ms | INTEGER NULL | Tombstone |
| revision | INTEGER | Starts at 1; increment on each local edit |

Indexes: `name_search`, `phone_search`.

## garment_types

Seeded (validate labels in week 1): shirt, trousers, suit, traditional wear.

| Column | Type |
| --- | --- |
| id | TEXT PK |
| key | TEXT UNIQUE |
| label | TEXT |
| sort_order | INTEGER |

## measurement_fields

Labeled fields per garment (chest, waist, inseam, …). New garments add **rows**, not columns.

| Column | Type |
| --- | --- |
| id | TEXT PK |
| garment_type_id | TEXT FK |
| key | TEXT |
| label | TEXT |
| sort_order | INTEGER |

Unique `(garment_type_id, key)`.

## measurement_sets

One dated fitting per customer + garment.

| Column | Type |
| --- | --- |
| id | TEXT PK |
| customer_id | TEXT FK |
| garment_type_id | TEXT FK |
| taken_at_ms | INTEGER |
| notes | TEXT NULL |
| created_at_ms | INTEGER |
| updated_at_ms | INTEGER |
| deleted_at_ms | INTEGER NULL |
| revision | INTEGER |

Index: `(customer_id, taken_at_ms DESC)`.

## measurement_values

| Column | Type | Notes |
| --- | --- | --- |
| set_id | TEXT | PK part |
| field_id | TEXT | PK part |
| value_mm | INTEGER | Integer millimetres only |

## sync_outbox

| Column | Type | Notes |
| --- | --- | --- |
| id | TEXT PK |
| entity_type | TEXT | customer, measurement_set, … |
| entity_id | TEXT |
| operation | TEXT | upsert, delete |
| payload_json | TEXT |
| idempotency_key | TEXT UNIQUE |
| attempts | INTEGER |
| next_attempt_at_ms | INTEGER |
| created_at_ms | INTEGER |
| last_error | TEXT NULL | Redacted; never include PII |

## sync_state

Single-row table.

| Column | Type |
| --- | --- |
| id | INTEGER PK (always 1) |
| pull_cursor | TEXT NULL |
| last_success_at_ms | INTEGER NULL |
| last_error | TEXT NULL |
| pending_count | INTEGER |

# Server PostgreSQL schema (backend repo, if sync is approved)

Not implemented in this repository. Mirror of the local model plus:

- `shop_id` on every owned row
- `tombstones` for acknowledged deletes
- `idempotency_keys` for push dedupe
- Unique `(shop_id, id)` so client UUIDs stay stable

Suggested service: NestJS + PostgreSQL in `bitbirr/tailor-sync-api`.

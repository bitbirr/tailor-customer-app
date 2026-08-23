# Technical architecture

## Decision

This repo is a Flutter mobile application (iOS + Android). Riverpod provides dependency injection and state. Drift/SQLite is the authoritative on-device store. UI is organized feature-first. Domain repositories sit between presentation and data. Mutations write an outbox row in the same SQLite transaction as the domain change. A versioned HTTP contract lives at `docs/api/openapi.yaml`. The API server is **not** implemented here.

Suggested backend (after contract approval): `bitbirr/tailor-sync-api` — NestJS + PostgreSQL, hosted on Railway. It owns authentication, shop isolation, revisions, tombstones, and idempotency.

## How the pieces interact

```
Workshop UI  --streams-->  Domain repositories  --SQL-->  Drift / SQLite
       ^                           |
       |                           +-- same txn --> sync_outbox
       |                                              |
       +-- status only --  Sync engine  --HTTPS-->  tailor-sync-api
Export (CSV/PDF) reads local rows only, then OS share sheet (after PII warning).
```

1. Screens read **only** local Drift streams. Airplane mode still works.
2. Create / edit / delete writes the domain row **and** an outbox row in one transaction.
3. When online, the sync engine drains the outbox in order and pulls incremental deltas. It never blocks local work.
4. Export is generated from local data. There is no server export job in MVP.

## Revisions vs the Planner draft

Agreed with Flutter, Riverpod, Drift, feature-first layout, outbox sync, flexible garment definitions, file-based photos, and contract-before-HTTP-client.

Tightened after inspecting the empty repo:

1. **Do not block local MVP on backend.** Local CRUD is independently shippable.
2. **This repo stays mobile-only.** Do not implement the API server here.
3. **Photos stay device-local** on the first sync cut unless product requires multi-device photos.
4. **Single tailor / single shop** for MVP. Multi-staff RBAC is deferred.
5. **Store measurements as integer millimetres.** Convert to cm/in only in UI and export.
6. **Phone is searchable, not unique,** unless discovery proves otherwise.

## Major components

| Component | Responsibility |
| --- | --- |
| `lib/features/*` | Screens and feature providers |
| `lib/domain` | Entities and repository interfaces |
| `lib/data/local` | Drift tables, database, repository implementations |
| `lib/data/sync` | Outbox writer and sync state |
| `lib/data/remote` | Generated/hand-written API client **later**, from OpenAPI |
| `lib/core` | IDs, clock, redacting logger, search/unit helpers |
| `docs/api/openapi.yaml` | v1 contract for the future backend |

## MVP phases

| Phase | When | Outcome |
| --- | --- | --- |
| 0 | Week 1 | Human decision gate + ADR approval |
| 1 | Week 1 | `flutter create`, pub get, build_runner, CI green |
| 2 | Weeks 1–2 | Schema, migrations, transactional repos, photo file manager |
| 3 | Weeks 2–3 | Offline customer + measurement vertical slices |
| 4 | Weeks 2–4 | Backend contract + service (parallel, only if sync stays in MVP) |
| 5 | Weeks 3–4 | Outbox drain, pull, conflict/tombstone handling |
| 6 | Weeks 4–5 | CSV/PDF export, PII warning, temp-file cleanup |
| 7 | Weeks 5–6 | Device tests, tailor UAT, privacy review. No store deploy without approval.

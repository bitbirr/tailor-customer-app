# ADR 0002: Outbox sync and backend boundary

## Status

Proposed — needs human approval (week-1 gate).

## Context

MVP includes background sync when online, but no API contract or backend repository exists. Inventing endpoints in the mobile client would lock the wrong shape in.

## Decision

- Every local mutation writes a `sync_outbox` row in the **same SQLite transaction** as the domain change.
- Sync is ordered push + incremental pull. It never blocks local work.
- The HTTP contract lives in this repo at `docs/api/openapi.yaml`.
- Do **not** implement the API server in this repository.
- Suggested follow-up repo after approval: `bitbirr/tailor-sync-api` (NestJS + PostgreSQL).
- Tokens are stored in platform secure storage, never in SQLite.
- Profile photos stay device-local on the first sync cut.
- Soft deletes are tombstones (`deleted_at_ms`) until the server acknowledges them.

Conflict policy to approve in week 1: a client revision must not clobber a newer server revision (`409` + pull).

## Consequences

- Local MVP is unblocked if backend slips.
- Mobile HTTP clients are not written until the OpenAPI contract is reviewed.
- Multi-device conflict tests are required before calling sync “done”.

# ADR 0003: Units and identity

## Status

Proposed — needs human approval (week-1 gate).

## Context

Garment fields vary by tailor and region. Phone numbers are used for lookup, not as a natural primary key. Display units (cm vs inches) should not leak into storage.

## Decision

- Generate **client UUIDs** offline. The same id is sent to the server later.
- Store every measurement value as an **integer millimetre** (`value_mm`). Convert to cm/in only in UI and export.
- Represent garments and fields as **rows** (`garment_types`, `measurement_fields`), not as one column per measurement.
- Normalize name and phone for search without destroying display values.
- Phone is **searchable, not unique**, unless discovery proves otherwise.
- MVP identity is **one tailor / one shop**. Multi-staff RBAC is deferred.
- Timestamps are UTC epoch milliseconds.

## Consequences

- Unit conversion is centralized in `lib/core/units.dart`.
- New garments do not require schema migrations that add columns.
- Seeded templates must be validated with real tailors before Phase 3 UI hard-codes labels.

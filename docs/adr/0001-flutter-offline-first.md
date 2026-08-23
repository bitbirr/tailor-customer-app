# ADR 0001: Flutter, Riverpod, Drift — offline-first client

## Status

Proposed — needs human approval (week-1 gate).

## Context

The repository on `main` contained only a 21-byte README. There is no existing stack, CI, or convention to preserve. Tailors need to look up and write measurements during fittings, often without reliable connectivity.

## Decision

- Use **Flutter** for iOS and Android in this repository.
- Use **Riverpod** for dependency injection and state.
- Use **Drift / SQLite** as the on-device source of truth. The UI reads local streams only.
- Organize code **feature-first** (`lib/features/{customers,measurements,export,sync,settings}`).
- Keep domain repository interfaces between UI and persistence.

## Consequences

- Local customer/measurement CRUD can ship without a backend.
- `android/` and `ios/` must be generated with `flutter create` on a machine that has the Flutter SDK.
- Feature work must wait until this foundation, lint rules, and one vertical-slice convention are approved.

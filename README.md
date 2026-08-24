# Tailor Customer App

Mobile-first, offline-first app for tailors to register customers and store body measurements. This repository is **the Flutter client only**. Cloud sync is specified here (`docs/api/openapi.yaml`) and implemented later in a separate backend repository (`bitbirr/tailor-sync-api`, after approval).

**Repository:** `bitbirr/tailor-customer-app`

## Architecture decision

- Flutter (iOS + Android)
- Riverpod for DI and state
- Drift / SQLite as the on-device source of truth
- Feature-first folders
- Repository interfaces between UI and data
- Outbox-based sync (local CRUD never waits on the network)
- Measurements stored as integer millimetres
- Photos stay device-local on the first sync cut
- Single tailor / single shop for MVP

See [docs/ARCHITECTURE.md](docs/ARCHITECTURE.md) and the ADRs under [docs/adr/](docs/adr/).

## Prerequisites

- Flutter 3.24+ (stable)
- Dart SDK matching that Flutter

This environment did not generate `android/` or `ios/` (no Flutter SDK on the architect machine). On a machine with Flutter:

```bash
flutter create --project-name tailor_customer_app --org com.bitbirr --platforms=ios,android .
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter analyze
flutter test
```

## Local MVP (independently shippable)

Replacing paper notebooks is an offline problem. Customer and measurement CRUD ships without a backend. Sync stays in MVP *scope* but is not a gate for the first internally usable build.

## Privacy

Do not log names, phone numbers, emails, addresses, measurement values, photos, tokens, or export contents. Use `RedactingLogger` in `lib/core/logging.dart`. Tokens belong in platform secure storage, never SQLite.

## Week-1 human approval gate

Lock before feature branches split:

1. Required customer fields
2. Garment labels with real tailors
3. Display units (cm vs in)
4. Photo sync yes/no
5. Privacy jurisdiction
6. Conflict policy (client revision must not clobber a newer server revision)
7. Single-shop identity
8. Approve ADRs 0001–0003

Do not merge this foundation to `main` or deploy without human review.

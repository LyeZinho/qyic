# `mobile/` — Flutter client

The Qyic mobile app (Android / iOS / desktop): Flutter + SQLite, offline-first.

```bash
flutter pub get

# First run only: generate the platform folders (android/, ios/, …), then
# commit them — they are part of the repo from that point on.
flutter create . --platforms=android,ios

flutter run
flutter test
flutter analyze
```

## Layout

```text
lib/
├── main.dart            # entry point + app shell
├── core/                # cross-cutting: db, sync client, theme (M1+)
└── features/            # feature-first modules: study/, decks/, profile/ (M1+)
```

## Conventions

- **Offline-first:** no widget may block on the network; study state lives in
  SQLite ([`docs/adr/0006-offline-first-sync.md`](../docs/adr/0006-offline-first-sync.md)).
- `const` widgets, `flutter_lints`, feature-first folders.
- Cross-client payloads come from `shared/proto` — never a divergent JSON shape.

Repository-level setup, conventions, and the roadmap live in the
[root README](../README.md), [AGENTS.md](../AGENTS.md), and [docs/PLAN.md](../docs/PLAN.md).

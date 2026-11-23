# `mobile/` — Flutter client

The Qyic mobile app (Android / iOS / desktop): Flutter + SQLite, offline-first.

```bash
flutter pub get
flutter run            # -d linux works for quick desktop iteration
flutter test
flutter analyze

# After editing drift tables (lib/core/database/): bump schemaVersion, then
dart run drift_dev make-migrations   # snapshots drift_schemas/, step code, migration tests
dart run build_runner build          # regenerates *.g.dart

# After editing lib/l10n/*.arb:
flutter gen-l10n

# After editing shared/proto (from the repo root; needs protoc + protoc_plugin):
make proto-dart
```

Generated code (`*.g.dart`, `lib/l10n/app_localizations*.dart`,
`lib/generated/`) is committed so CI and fresh clones build without running
code generation.

## Layout

```text
lib/
├── main.dart              # opens the database, starts ProviderScope
├── app/                   # MaterialApp + first-launch bootstrap (starter deck)
├── core/
│   ├── database/          # drift tables and AppDatabase (schema + migrations)
│   ├── scheduling/        # FSRS-6 port (ADR-0007)
│   ├── theme/ widgets/    # design system from planning/mockups-wireframes
│   ├── formatting.dart    # locale-aware intervals, times, sizes, percentages
│   └── providers.dart     # database, clock, minute tick
├── generated/             # Dart classes from shared/proto (make proto-dart)
├── l10n/                  # ARB files, generated AppLocalizations, enum labels
└── features/
    ├── decks/             # domain models, validation, .qdeck import, library/deck/editor UI
    ├── study/             # grading, due queue, session controller, quiz views
    ├── exam/              # exam presets, timed sessions, results (docs/exam-mode.md)
    ├── reminders/         # weekly study reminders via local notifications
    ├── progress/          # XP / level / streak (docs/progression.md)
    ├── settings/          # key-value settings, device client id, Preferences UI
    ├── home/ profile/     # Home and Me screens
    └── shell/             # bottom bar, or a navigation rail on wide screens
```

Each feature splits into `domain/` (pure Dart), `data/` (repositories over
drift), `application/` (Riverpod controllers), and `presentation/` (widgets).

## Data model

- Timestamps are epoch milliseconds (`*_ms`), and enums are stored as their
  `shared/proto` integer values.
- Deleted decks and quizzes are tombstoned (`deleted_at_ms`) so that sync can
  propagate deletions later.
- Each review updates `card_states` and appends a `review_events` row in one
  transaction. Events carry `(client_id, client_seq)` for idempotent sync
  ([ADR-0006](../docs/adr/0006-offline-first-sync.md)).
- Schema changes bump `schemaVersion` and add a migration step; never edit a
  shipped one.

## Translations

UI strings live in `lib/l10n/app_<locale>.arb`; `app_en.arb` is the template
and declares placeholder types. Supported: English, Portuguese (Brazil, the
base `pt` file), Portuguese (Portugal, `pt_PT`), Spanish, Italian, German, and
Japanese. Widgets read strings through `context.l10n`; domain enums carry no
UI text and get labels from `lib/l10n/labels.dart`. Dates, times, and numbers
are formatted with `intl` for the active locale (`lib/core/formatting.dart`).
The language follows the system unless one is chosen in Preferences.

## Importing decks

Library → Import opens a `.qdeck` file (for example one from
[`../decks/dist/`](../decks/dist/)). The file is verified off the UI thread
(archive safety, manifest, SHA-256 checksum, content rules —
[deck-format.md](../docs/deck-format.md) §5) and a preview shows what will be
added, updated, or removed. Re-importing a newer version keeps progress for
quizzes that still exist. Quiz types from newer spec revisions are skipped.

## Reminders

Reminders are weekly local notifications (a time plus weekdays), scheduled
with `flutter_local_notifications` in the device time zone. They are
device-local and never synced. The OS schedule is rebuilt whenever reminders
or the UI language change. Supported on Android, iOS, and macOS; the app asks
for notification permission when a reminder is added or turned on.

## Conventions

- **Offline-first:** no widget may block on the network.
- State is managed with `flutter_riverpod`, and the UI reacts to drift
  `watch()` streams.
- `const` widgets, `flutter_lints`, feature-first folders.
- Cross-client payloads come from `shared/proto` — never a divergent shape.
- The FSRS golden test reads `../shared/fsrs/vectors.json`.

Repository-level setup, conventions, and the roadmap live in the
[root README](../README.md), [AGENTS.md](../AGENTS.md), and [docs/PLAN.md](../docs/PLAN.md).

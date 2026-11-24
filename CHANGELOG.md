# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Changed

- Deck format spec: document many items per deck, primary quiz modes (select option,
  true/false, flashcards), and per-deck statistics vs shareable `.qdeck` content.
- Deck format spec: content vs catalog vs progress planes, hub favorite/download
  model, and `ReviewEvent` as the common per-quiz sync record (§8–§9); clarify
  ADR-0006 progress-only delta sync.
- Add `QUIZ_TYPE_FLASHCARD` to `deck.proto` (front/back on `question` / `explanation`).
- Add `Option.prompt` to `deck.proto` (matching term; `text` holds its match) and
  specify per-type payloads for fill-in-the-blank, matching, and true/false in
  the deck format spec, plus shared validation and grading rules.
- Add an optional `Quiz.hint` to `deck.proto` and `ReviewEvent.mode`
  (`ReviewMode`: standard or exam) to `review.proto`; the server stores the
  mode in a new `review_events.mode` column.
- The repository root is a Cargo workspace (`server`, `tools/qdeck`,
  `tools/qdeck-cli`) with a single `Cargo.lock`; the API Docker image builds
  from the root context.
- Mobile local database schema v2 (reminders, exam presets and runs, review
  mode), migrated step by step from v1 with migration tests.
- Vocabulary decks now generate a true/false question per word, and questions
  come before the flashcard, so study starts on multiple choice, fill in the
  blank, true/false, and matching instead of memorization cards. The bundled
  Italian, Japanese, and German decks are version 2; import the new
  `.qdeck` to update an already installed copy.
- The deck page no longer lists every quiz. Cards are managed on their own
  page, and study starts from Mixed, Quizzes only, Flashcards only, or a
  deck exam whose length is random from 100 up to the deck size (half the
  deck, rounded up, when the deck has fewer than 100 quizzes).

### Fixed

- Opening a large deck no longer builds every quiz into one column, which
  overflowed the renderer and killed the window.
- Android Gradle Plugin 9.1.0 → 9.1.1, the minimum Flutter 3.50 accepts. The
  `android-v0.1.1` release workflow failed on CI because of it. CI now builds a
  debug APK on every push so the Android build is checked before tagging.

### Added

- Initial monorepo scaffold (`server/`, `web/`, `mobile/`, `shared/`, `docs/`).
- Rust API skeleton (Axum + SQLx): health endpoint, passwordless auth request/verify flow, PostgreSQL migrations.
- SvelteKit + TypeScript web client skeleton.
- Flutter mobile client skeleton (offline-first by design, SQLite planned for M1).
- Shared Protocol Buffers contracts for the `.qdeck` deck format and sync payloads.
- Docker Compose (PostgreSQL + API), Makefile shortcuts, and CI pipeline (fmt, lint, tests).
- Project documentation: plan (`docs/PLAN.md`), ADRs, deck-format spec, infrastructure guide.
- Repository governance files: `README.md`, `AGENTS.md`, `CONTRIBUTING.md`, `CHANGELOG.md`, `LICENSE`.
- Mobile study loop (M1): local SQLite store (drift) for decks, quizzes, card
  state, review events, and settings; deck and quiz authoring for all five quiz
  types; a bundled starter deck installed on first launch; study sessions with
  type-specific grading, FSRS ratings with interval previews, and a session
  summary; Home, Library, deck detail, and Me screens backed by live data.
- FSRS-6 scheduler in Dart, verified against golden vectors from `py-fsrs`
  6.3.2 (`shared/fsrs/`, [ADR-0007](docs/adr/0007-fsrs-scheduler.md)).
- Provisional XP, level, and streak rules derived from review events
  (`docs/progression.md`).
- `qdeck` CLI (`tools/`): scaffold, validate, and reproducibly pack TOML deck
  sources into `.qdeck` files, including a vocabulary generator for
  word-and-sentence decks (`docs/deck-source.md`, `make qdeck`, `make decks`).
- Bundled decks in `decks/`: the first 1000 words of Italian, Japanese, and
  German for English speakers, each word with an example sentence (3200
  quizzes per deck), packed into `decks/dist/`.
- Mobile `.qdeck` import with archive, manifest, checksum, and content checks
  and an add/update/remove preview; updates keep existing progress.
- Mobile exam mode: quick exams and editable presets (decks, selection,
  question count, time limits, quiz types, unseen cards, automatic rating,
  hints), timed sessions that update FSRS, and results with history
  (`docs/exam-mode.md`).
- Mobile study reminders: weekly local notifications at chosen times and
  weekdays.
- Mobile Preferences: language, display name, daily goal, new cards per day,
  desired retention, interval previews, haptics, reminders, import, storage
  use, and licenses.
- Mobile translations: English, Portuguese (Brazil and Portugal), Spanish,
  Italian, German, and Japanese, with locale-aware dates and numbers.
- Mobile UI polish: bundled Space Grotesk and JetBrains Mono fonts (OFL),
  refined component themes, quiz hints, and a navigation rail with capped
  content width on wide screens.

## [Android 0.1.1] - 2026-11-23

Android release 0.1.1 (`mobile` version `0.1.1+2`).

### Added

- Android release workflow: pushing an `android-v*` tag builds the APK and App
  Bundle and attaches them to the GitHub release
  (`.github/workflows/android-release.yml`).

### Fixed

- Android: the splash switched from the `InkSparkle` shader to `InkRipple`,
  suspected of causing grey, empty app bar and bottom bar areas in profile
  builds. Not yet confirmed on a device.
- Release builds without `android/key.properties` fall back to the debug key
  (sideload only) instead of failing.

## [Android 0.1.0] - 2026-11-23

First Android release (`mobile` version `0.1.0+1`, application id `com.qyic.app`).

### Added

- Android release readiness: release builds are signed with a key from
  `mobile/android/key.properties` and fail without one; see
  [docs/release-android.md](docs/release-android.md).
- Android launcher icon (adaptive, Qyic background and bolt) and matching splash.

### Changed

- Android application id is `com.qyic.app` (was the template `com.example.qyic`).
- Study reminders create their Android notification channel explicitly, so they
  show on Android 8+ even before the first notification.
- The bottom navigation bar clears the system gesture bar (edge-to-edge).
- Dependencies refreshed within their declared version ranges (`pub upgrade`).
- Mobile imports use `material_ui` and `cupertino_ui` instead of the deprecated
  `flutter/material.dart` and `flutter/cupertino.dart` entry points (Flutter 3.50 analyzer).
  The package requires Dart 3.13, so the app's SDK constraint is `^3.13.0`.

[Unreleased]: https://github.com/LyeZinho/qyic/compare/HEAD...HEAD

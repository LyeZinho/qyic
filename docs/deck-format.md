# `.qdeck` — Qyic Deck File Format

**Spec version:** 0.1 (draft)
**Status:** implemented as schema in [`shared/proto/qyic/v1/deck.proto`](../shared/proto/qyic/v1/deck.proto)

`.qdeck` is the portable unit for sharing Qyic decks between users and between
clients (mobile, web, server) — the role `.apkg` plays for Anki, but binary,
manifest-driven, and checksum-verified.

## 1. Container

A `.qdeck` file is a **ZIP archive** (deflate) with the extension `.qdeck`:

```text
my_deck.qdeck
├── deck.pb          # required — serialized qyic.v1.Deck (Protocol Buffers)
├── manifest.json    # required — metadata, see below
└── media/           # optional — assets referenced by quizzes
    ├── img_01.png
    └── audio_02.mp3
```

Rules:

- `manifest.json` and `deck.pb` live at the archive root.
- Media paths inside the protobuf payload are archive-relative
  (e.g. `media/img_01.png`) and must not escape the archive (`..` is rejected).
- Readers MUST reject archives containing absolute paths or path traversal.
- Total uncompressed size is capped (soft limit 256 MiB) to protect mobile clients.

## 2. `manifest.json`

```json
{
  "format": "qdeck",
  "spec_version": 1,
  "id": "9f0c2f6a-9c3d-4a8e-9c6b-2a5e5a9d1111",
  "title": "Japanese N5 Kanji",
  "author": "ana@example.com",
  "deck_version": 3,
  "created_at": "2026-10-27T12:00:00Z",
  "quiz_count": 420,
  "checksum": {
    "algorithm": "sha256",
    "value": "b1946ac92492d2347c6235b4d2611184b1946ac92492d2347c6235b4d2611184"
  }
}
```

- `checksum` is the SHA-256 of `deck.pb` (hex, lowercase).
- `spec_version` gates reader behavior; unknown **major** versions must be rejected,
  unknown minor fields ignored.

## 3. Payload (`deck.pb`)

Defined in `shared/proto/qyic/v1/deck.proto`:

- `Deck` — id, title, description, author, version, and a list of `Quiz`.
- `Quiz` — id, `QuizType`, question, explanation, options, and optional SRS
  fields (`difficulty`, `stability`) when the exporter includes study history.
- `Option` — id, text, media path, `is_correct`.

Supported quiz types: `MULTIPLE_CHOICE`, `FILL_IN_THE_BLANK`, `MATCHING`,
`TRUE_FALSE`.

### Why Protocol Buffers (not JSON or raw SQLite)

- **Speed:** parsed in milliseconds even for 100k quizzes; native support in
  Dart, Rust, and TypeScript.
- **Size:** roughly 70% smaller than equivalent pretty JSON, on top of ZIP.
- **Forward compatibility:** additive field evolution means old clients keep
  reading new decks.

## 4. Export Flow

1. Client serializes the deck row + quizzes from local SQLite into `deck.pb`.
2. Media files are copied into `media/`.
3. `manifest.json` is written with the SHA-256 of `deck.pb`.
4. Everything is zipped into `<slug>.qdeck`.

## 5. Import Flow

1. Open the ZIP; validate paths (no traversal, expected entries present).
2. Read `manifest.json`; check `format`, `spec_version`, and size caps.
3. Verify the SHA-256 checksum against `deck.pb`.
4. Parse `deck.pb`; validate quiz invariants (e.g. exactly one correct option
   for multiple choice, matching pairs have equal length, true/false has two options).
5. Insert into local SQLite inside a single transaction (idempotent by deck id).

## 6. Evolution Rules

- Protobuf fields are **append-only**: never renumber or reuse a tag.
- New quiz types are a **minor** bump; a container layout change is a **major**
  bump (`spec_version`).
- Every spec change updates this document and adds an ADR entry if it affects
  the ecosystem.

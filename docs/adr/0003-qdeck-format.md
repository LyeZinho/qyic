# 0003. `.qdeck`: ZIP + Protobuf deck file format

Date: 2026-10-27

## Status

Accepted

## Context

Users must be able to share decks as a single file — like Anki's `.apkg` — without
touching the server, over WhatsApp/e-mail/direct link. The format has to carry
text plus media, load fast on mobile and on the web, and survive schema evolution
as new quiz types appear. Candidate encodings: plain JSON, a raw SQLite database,
or a binary schema.

## Decision

We will ship decks as **`.qdeck`: a ZIP container** holding:

- `deck.pb` — the deck serialized with Protocol Buffers (`qyic.v1.Deck`)
- `manifest.json` — title, author, version, `spec_version`, and a SHA-256
  checksum of `deck.pb`
- `media/` — images/audio referenced by relative path

Readers must verify the checksum, reject path traversal, and validate quiz
invariants before importing in a single local transaction.

Spec: [`docs/deck-format.md`](../deck-format.md) ·
Schema: [`shared/proto/qyic/v1/deck.proto`](../../shared/proto/qyic/v1/deck.proto)

## Alternatives Considered

- **JSON (zip)** — human-readable, but 3–5× larger, slower to parse at 100k items,
  and weak typing invites schema drift between Dart and Rust.
- **Raw SQLite file (`.apkg` style)** — fast reads, but a rigid on-disk schema,
  no clean media story, and cross-platform file locking surprises (WAL files
  must travel together).
- **Custom single-file binary (custom container/0xFF headers)** — maximum control,
  but we would reimplement framing, skipping, and evolution rules that Protobuf
  already solved, and lose third-party tooling.
- **CBOR/MessagePack** — better than JSON, but no schema evolution guarantees and
  no single source-of-truth definition file.

## Consequences

- One `.proto` file feeds Dart, TypeScript, and Rust — contracts land first.
- Compatibility rules are strict: fields are append-only, field tags are never
  reused, container layout changes bump `spec_version` (major).
- Contributors need `protoc`/`buf` locally (documented in `shared/README.md`);
  CI lints with `buf`.
- An optional `.qdeck` integrity CLI (server-side) can be added later cheaply.

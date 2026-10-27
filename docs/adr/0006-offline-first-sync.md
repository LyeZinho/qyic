# 0006. Offline-first clients with delta sync

Date: 2026-10-27

## Status

Accepted

## Context

Study sessions happen everywhere: metro, plane, spotty café Wi-Fi. If a review
round-trip touches the network, the product fails on both latency and
availability. At the same time, progress must follow the user from phone to
laptop, which requires synchronization between two local stores (SQLite on
mobile, IndexedDB on web) and PostgreSQL.

## Decision

**Clients are the source of truth for their own study loop; the server is the
source of truth for the aggregate.**

- **Local store first.** Quiz rendering, FSRS scheduling, XP, and streaks are
  computed locally. Nothing in the study path awaits the network.
- **Append-only events.** Every review writes a `review_events` row locally with
  `(client_id, client_seq)` — a per-device monotonic counter. Events are
  immutable; corrections are new events.
- **Delta sync.** When online, the client pushes events it has not yet
  acknowledged (`WHERE client_id = … AND client_seq > last_acked`) and pulls the
  aggregate/decks changed since its last cursor. Payloads use Protobuf
  (`shared/proto/qyic/v1/review.proto`).
- **Tombstones for deletes.** Deleted decks/quizzes keep a `deleted_at` row so
  other devices learn about the deletion; tombstones are GC'd after a retention
  window.
- **Conflict policy:** events merge (union of reviews is always valid for SRS —
  two devices reviewing the same card is legitimate history); profile/deck
  metadata uses last-writer-wins on a server timestamp. Anything smarter is a
  future ADR.
- **Server-side processing** (bulk imports, deck publishing) goes through the
  Postgres job queue using `SKIP LOCKED` (ADR-0004).

## Alternatives Considered

- **Online-only (server computes SRS)** — simplest code, but unusable offline
  and slow; directly violates pillar #1.
- **CRDT full-state sync** — elegant, but heavy to implement in Dart/TS/Rust and
  unnecessary: review events are naturally append-only.
- **Last-writer-wins whole database** — destroys history (a losing device would
  erase reviews).
- **Background push of full SQLite file** — bandwidth-heavy and conflict-blind.

## Consequences

- `client_id` (device id) must be created at first launch and persisted.
- Sync must be **idempotent**: replaying the same events is a no-op
  (unique on `(client_id, client_seq)`).
- Ordering between event ingest and aggregate update must be transactional.
- Retention/compaction of `review_events` needs a scheduled job eventually.
- Golden test vectors for the FSRS scheduler are required so Dart, TS, and Rust
  agree (tracked in `docs/PLAN.md` M1).

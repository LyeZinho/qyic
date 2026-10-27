# AGENTS.md

Instructions for AI agents (and humans who want the fast tour) working on this repo.

## What Qyic Is

A gamified spaced-repetition learning app: quiz-style review (multiple choice,
fill-in-the-blank, matching, true/false) driven by an FSRS-like scheduler, with
offline-first clients and cross-device sync.

**Stack:** Flutter + SQLite (mobile), SvelteKit + TypeScript (web), Rust/Axum +
SQLx + PostgreSQL (server), Protocol Buffers (`shared/`) as the cross-client
contract, Docker Compose for infra.

## Repo Map

| Path       | What lives there | Notes |
| ---------- | ---------------- | ----- |
| `server/`  | Rust API, migrations (`server/migrations/`) | Axum handlers, SQLx runtime queries |
| `web/`     | SvelteKit client | `npm run check`, `npm run build` |
| `mobile/`  | Flutter client | Feature-first folders under `lib/` |
| `shared/`  | Protobuf contracts | Single source of truth for anything crossing a process boundary |
| `docs/`    | `PLAN.md`, `adr/`, `deck-format.md`, `infra.md` | Decisions live in ADRs |
| `.github/workflows/` | CI | fmt, lint, tests for every area |

## Commands

```bash
make help                       # all shortcuts
make dev-up / dev-down          # docker compose: postgres + api
make server-run                 # cargo run (runs migrations on boot)
make server-test                # cargo test
make web-install / web-dev      # npm install / npm run dev
make fmt                        # cargo fmt + dart format + prettier (if present)
make lint                       # clippy -D warnings + flutter analyze + svelte-check + buf lint
make test                       # everything testable
```

## Architectural Invariants (do not violate without an ADR)

1. **Offline-first.** Clients must be fully usable with no network. Study,
   scheduling, and gamification all run locally; the network only exchanges
   deltas. Never gate a study action on a network round-trip.
2. **PostgreSQL is the only stateful service.** No Redis, Kafka, or extra
   coordination layers. Use `SELECT ... FOR UPDATE SKIP LOCKED` for queues,
   ACID transactions for correctness, and short transactions to protect
   connection pools (the Shopify lesson — see ADR-0004).
3. **Passwordless auth only.** E-mail + magic link/OTP. Never introduce stored
   passwords or third-party OAuth without an ADR.
4. **Contracts first.** Any payload shared between clients and server is defined
   in `shared/proto/`. Never hand-roll a divergent JSON shape for the same data.
5. **`.qdeck` evolves additively.** Never renumber Protobuf field tags or break
   older files. Spec changes update `docs/deck-format.md` in the same PR.
6. **Small infra.** Everything must run on one modest VPS (see `docs/infra.md`).
   If a feature requires a new service, it needs an ADR with a cost justification.
7. **English everywhere.** Code, comments, docs, commit messages, issues.
8. **Append-only migrations.** Add a new migration; never edit a shipped one.

## Conventions

- **Commits:** Conventional Commits — `feat(server): ...`, `fix(web): ...`.
- **Rust:** thin handlers, `sqlx::query(...).bind(...)` (no compile-time macro
  checks that require a live DB), `cargo clippy -- -D warnings` clean.
- **Dart:** `const` widgets, `flutter_lints`, feature-first structure.
- **TypeScript:** strict, `svelte-check` clean, no `any` without a comment justifying it.
- **Protobuf:** package `qyic.v1`, files under `proto/qyic/v1/`, enums start with
  an `*_UNSPECIFIED` zero value, fields `lower_snake_case`.
- **New quiz type?** Touch, in one PR: `shared/proto/qyic/v1/deck.proto`,
  server validation, both clients, `docs/deck-format.md`, `CHANGELOG.md`.

## Definition of Done

- `make fmt`, `make lint`, `make test` pass.
- Behavior changes are documented (`docs/`, `CHANGELOG.md`).
- Cross-cutting decisions get an ADR in `docs/adr/`.
- No new runtime service, dependency, or credential without explicit sign-off.

# Qyic — Project Plan

> The living base plan for Qyic. Milestones are updated as work lands; notable
> decisions are recorded as ADRs in [`adr/`](adr/README.md).

**Status:** M0 (foundation) in progress.
**Last updated:** 2026-10-27.

---

## 1. Vision

Make long-term retention feel like a game without giving up the science.
Qyic keeps the FSRS-grade spaced-repetition engine under the hood and replaces
the passive "know / don't know" flashcard flow with fast, varied quizzes.

## 2. Product Pillars

1. **Quiz-first review** — multiple choice, fill-in-the-blank, matching, true/false;
   a timed "challenge" mode on top of the untimed "casual" mode.
2. **SRS that schedules for you** — fast, correct answers push the card's next
   review out; wrong/slow answers bring it back the same or next day.
3. **Gamification** — XP, levels, streaks, achievements, and cosmetic rewards
   earned by studying (never pay-to-win, never paywalled core study).
4. **Offline-first** — study in the metro, on a plane, anywhere. Sync is
   opportunistic and invisible.
5. **Shareable decks** — one `.qdeck` file (see [`deck-format.md`](deck-format.md))
   to hand a deck to a friend with zero server dependency.
6. **Passwordless** — e-mail magic link only. No passwords to leak, no
   password-reset support burden.

## 3. Tech Stack (locked for M0–M2)

| Layer    | Choice | Rationale |
| -------- | ------ | --------- |
| Mobile   | Flutter + SQLite | 60/120 FPS, no JS bridge, true offline store |
| Web      | SvelteKit + TS   | tiny bundles, SSR, no Virtual DOM |
| Server   | Rust (Axum + SQLx) + PostgreSQL | memory safety, low cost, one database for everything |
| Contracts| Protocol Buffers  | one schema for Dart, TS, and Rust |
| Auth     | Magic link via SMTP | "less is more" — no password storage |
| Infra    | Single VPS (IONOS) + Docker Compose | minimal cost and operational surface |

ADRs: [0001](adr/0001-monorepo.md) ·
[0002](adr/0002-tech-stack.md) ·
[0003](adr/0003-qdeck-format.md) ·
[0004](adr/0004-postgres-only-infrastructure.md) ·
[0005](adr/0005-passwordless-auth.md) ·
[0006](adr/0006-offline-first-sync.md)

## 4. Milestones

### M0 — Foundation (current)

- [x] Monorepo skeleton: `server/`, `web/`, `mobile/`, `shared/`, `docs/`
- [x] Governance docs: README, AGENTS, CONTRIBUTING, CHANGELOG, LICENSE
- [x] API skeleton with `/healthz` and the passwordless auth request/verify flow
- [x] Initial PostgreSQL schema (users, auth tokens, sessions, decks, quizzes,
      review state, review events)
- [x] `.qdeck` Protobuf schema + spec document
- [x] CI: fmt, lint, tests for every area
- [ ] First green end-to-end login on web **Done when:** magic link → session → authed request

### M1 — Study Loop (vertical slice)

- [ ] Deck authoring/import in mobile (SQLite schema, CRUD)
- [ ] Quiz rendering for all four question types (mobile + web)
- [ ] FSRS scheduler implemented in shared logic (Dart first, ported to Rust/TS)
- [ ] Review flow with ratings and due-queue
- **Done when:** a user can create a deck, study it, and see cards reschedule

### M2 — Sync Engine

- [ ] Delta upload/download of `review_events` with per-device sequence numbers
- [ ] Tombstones for deletions, last-writer-wins + event merge rules
- [ ] Conflict resolution documented in an ADR
- **Done when:** study offline on mobile → sync → web reflects the same state

### M3 — Gamification

- [ ] XP and levels, streaks, achievements/badges
- [ ] Daily/weekly challenge ("boss fight") timed mode
- [ ] Local-first calculation, server-side anti-cheat validation

### M4 — `.qdeck` Share & Community

- [ ] Export/import `.qdeck` on mobile and web (checksum validation, media)
- [ ] Deck hub (public decks listed via API; uploads deduplicated by hash)
- [ ] Optional AI quiz generation from text/PDF (behind a feature flag)

### M5 — Web Parity & Polish

- [ ] Web study loop feature-parity with mobile
- [ ] PWA install, IndexedDB persistence
- [ ] Accessibility pass, i18n scaffolding

### M6 — Launch

- [ ] Production VPS hardening (see [`infra.md`](infra.md)): Caddy TLS, backups,
      monitoring, log rotation
- [ ] Store submissions (Google Play / App Store) and web launch
- [ ] `v1.0.0` release, tagged with a full changelog

## 5. Workstreams

| Workstream | Owner areas | Depends on |
| ---------- | ----------- | ---------- |
| Contracts  | `shared/`   | — |
| Server     | `server/`   | Contracts |
| Web        | `web/`      | Contracts, Server |
| Mobile     | `mobile/`   | Contracts |
| SRS engine | all clients | Contracts |
| Sync       | Server + clients | SRS, Contracts |
| Infra/DevOps | `docker-compose.yml`, `.github/`, [`infra.md`](infra.md) | Server |

Rule of thumb: **contracts land first**, then server, then clients in parallel.

## 6. Quality Gates

Every PR must pass (enforced by CI):

- `cargo fmt --check`, `cargo clippy -- -D warnings`, `cargo test`
- `flutter analyze`, `flutter test` (run `dart format` before committing — `make fmt`)
- `svelte-check` and `npm run build`
- `buf lint` on `shared/`

## 7. Risks & Mitigations

| Risk | Impact | Mitigation |
| ---- | ------ | ---------- |
| Sync conflicts corrupt review history | High | Append-only events with per-device sequence; ADR before M2 |
| Single-VPS outage | High | Nightly `pg_dump` off-box, documented restore in `infra.md` |
| FSRS implementation drift across 3 languages | Medium | Golden test vectors shared in `shared/` |
| Deck format breaks older clients | Medium | Additive-only Protobuf evolution + checksummed manifest |
| Scope creep (AI generation, marketplace…) | Medium | Milestones gate features; nothing starts before M1 ships |
| SMTP deliverability (magic links → spam) | Medium | Own domain + IONOS SMTP, monitor bounce/spam signals early |

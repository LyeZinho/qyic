# Contributing to Qyic

Thanks for your interest in contributing! This document explains how to set up a
development environment and the conventions we follow.

## Table of Contents

- [Code of Conduct](#code-of-conduct)
- [Development Setup](#development-setup)
- [Repository Layout](#repository-layout)
- [Workflow](#workflow)
- [Commit Messages](#commit-messages)
- [Code Style](#code-style)
- [Tests](#tests)
- [Documentation and ADRs](#documentation-and-adrs)
- [Reporting Bugs](#reporting-bugs)

## Code of Conduct

Be respectful, constructive, and inclusive. Assume good intent, keep feedback
focused on the work, and help newcomers get started.

## Development Setup

Prerequisites: Git, Docker + Docker Compose, Rust/Cargo, Node.js ≥ 20, Flutter SDK.

```bash
git clone https://github.com/LyeZinho/qyic.git
cd qyic
cp .env.example .env

docker compose up -d postgres   # database
make server-run                 # API on :8080
make web-install && make web-dev  # web client on :5173
cd mobile && flutter pub get && flutter create . --platforms=android,ios && flutter run
```

Run `make help` to see every available shortcut.

## Repository Layout

| Path       | Contents                                             |
| ---------- | ---------------------------------------------------- |
| `server/`  | Rust API (Axum + SQLx), PostgreSQL migrations        |
| `web/`     | SvelteKit + TypeScript client                        |
| `mobile/`  | Flutter client (Android / iOS / desktop)             |
| `shared/`  | Protocol Buffers contracts shared by all clients     |
| `docs/`    | Plan, ADRs, deck-format spec, infrastructure guide   |

## Workflow

1. Fork and create a branch from `main`.
2. Branch naming: `type/short-description` — e.g. `feat/quiz-matching-mode`,
   `fix/sync-conflict-resolution`, `docs/adr-0007`.
3. Make your changes, keeping pull requests small and focused.
4. Ensure `make fmt`, `make lint`, and `make test` pass locally (CI runs them too).
5. Open a pull request using the template, describing **what** changed and **why**.
6. At least one review is required before merging.

## Commit Messages

We use [Conventional Commits](https://www.conventionalcommits.org/):

```text
feat(server): add magic-link verification endpoint
fix(web): prevent duplicate review submission on double click
docs(adr): record decision on sync conflict resolution
chore(ci): cache cargo registry between runs
```

Types: `feat`, `fix`, `docs`, `style`, `refactor`, `perf`, `test`, `build`,
`ci`, `chore`.

## Code Style

**Rust (`server/`)**

- `cargo fmt` and `cargo clippy -- -D warnings` must pass.
- Handlers stay thin; keep business logic in focused modules.
- Use `sqlx` runtime queries with bind parameters — never string-interpolate SQL.
- Migrations are **append-only**: never edit a migration that has shipped; add a new one.

**TypeScript (`web/`)**

- `svelte-check` must pass (`npm run check`).
- Prefer plain, typed code over clever abstractions; the whole point of Svelte is
  less runtime machinery.

**Dart (`mobile/`)**

- `dart format` and `flutter analyze` must pass.
- Widgets are `const` whenever possible; follow `flutter_lints`.

**Protobuf (`shared/`)**

- `npx @bufbuild/buf lint` must pass (run from `shared/`).
- Fields are append-only once released: never reuse or renumber field tags.
- Changing a contract requires updating every client **in the same PR**.

## Tests

| Area     | Command                                |
| -------- | -------------------------------------- |
| Server   | `cargo test --manifest-path server/Cargo.toml` |
| Web      | `npm run check` (in `web/`)            |
| Mobile   | `flutter test` (in `mobile/`)          |
| Contracts| `npx @bufbuild/buf lint` (in `shared/`) |

Bug fixes should include a regression test whenever feasible.

## Documentation and ADRs

- User-facing or behavior-changing work updates the relevant doc in `docs/`.
- Cross-cutting technical decisions require an **Architecture Decision Record**
  (see [`docs/adr/README.md`](docs/adr/README.md)). Copy the template, pick the
  next number, and reference it from your PR.
- Everything in this repository — code, docs, commits — is written in **English**.
- Keep [`CHANGELOG.md`](CHANGELOG.md) updated under `Unreleased` for notable changes.

## Reporting Bugs

Open a GitHub issue with:

- What you expected vs. what happened
- Steps to reproduce
- Environment (OS, app version, client: mobile/web)
- Logs or screenshots, if available

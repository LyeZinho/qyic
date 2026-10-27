# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added

- Initial monorepo scaffold (`server/`, `web/`, `mobile/`, `shared/`, `docs/`).
- Rust API skeleton (Axum + SQLx): health endpoint, passwordless auth request/verify flow, PostgreSQL migrations.
- SvelteKit + TypeScript web client skeleton.
- Flutter mobile client skeleton (offline-first by design, SQLite planned for M1).
- Shared Protocol Buffers contracts for the `.qdeck` deck format and sync payloads.
- Docker Compose (PostgreSQL + API), Makefile shortcuts, and CI pipeline (fmt, lint, tests).
- Project documentation: plan (`docs/PLAN.md`), ADRs, deck-format spec, infrastructure guide.
- Repository governance files: `README.md`, `AGENTS.md`, `CONTRIBUTING.md`, `CHANGELOG.md`, `LICENSE`.

[Unreleased]: https://github.com/LyeZinho/qyic/compare/HEAD...HEAD

# 🎯 Qyic

> **Qyic** is a learning and memorization app that combines the scientific efficiency of the **Spaced Repetition System (FSRS)** with the engagement of **gamified quizzes** — offline-first, on mobile and on the web.

[![CI](https://github.com/LyeZinho/qyic/actions/workflows/ci.yml/badge.svg)](https://github.com/LyeZinho/qyic/actions/workflows/ci.yml)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

---

## 📌 About the Project

Traditional flashcard applications revolutionized long-term knowledge retention, but passive review sessions can become monotonous over time. **Qyic** solves this pain point by transforming content review into a dynamic game with multiple quiz formats — all while preserving the scientific efficiency of spaced repetition under the hood.

### ✨ Key Features

- 🎮 **Dynamic Quiz Modes:** Multiple choice, fill-in-the-blank, matching pairs, and true/false.
- ⚡ **Offline-First:** Study anywhere, even without an internet connection. The client owns the review loop; the network is only used to sync.
- 🧠 **Modern SRS Algorithm:** FSRS-based scheduling for intelligent, per-card review intervals.
- 🏆 **Gamification Elements:** XP, levels, streaks, and achievements.
- 🔄 **Cross-Platform Sync:** Progress synchronized between mobile and web.
- 📦 **Shareable Decks (`.qdeck`):** A compact, portable binary deck file (Protobuf + media) that can be shared directly between users, with no server round-trip.
- 🔑 **Passwordless Auth:** Sign in with a magic link sent to your e-mail. No passwords are ever stored.

---

## 🛠️ Tech Stack

Engineering choices focused on **native performance**, **low resource consumption**, and a **smooth user experience**:

| Layer | Technology | Description / Motivation |
| :--- | :--- | :--- |
| **Mobile** | **Flutter** + **SQLite** | Up to 120 FPS without JS bridges, full offline support via a local database. |
| **Web Frontend** | **SvelteKit** + **TypeScript** | Compiles to lightweight imperative JS, no Virtual DOM, instant page loads. |
| **Backend API** | **Rust** (Axum + SQLx) + **PostgreSQL** | Memory safety, high concurrency, ultra-low CPU/RAM overhead. |
| **Contracts** | **Protocol Buffers** | One schema shared by Rust, Dart, and TypeScript clients. |
| **DevOps** | **Docker** + **Docker Compose** | Consistent containerization for development and production. |

> **Why not React Native?** Portability bought at the cost of performance. See [ADR-0002](docs/adr/0002-tech-stack.md).

---

## 🏗️ System Architecture

```text
       ┌──────────────────┐         ┌──────────────────┐
       │ Mobile App       │         │ Web App          │
       │ (Flutter/SQLite) │         │ (SvelteKit/IDB)  │
       └───────┬──────────┘         └───────┬──────────┘
               │   offline-first sync (REST + Protobuf deltas)
               └────────────┬───────────────┘
                            ▼
                   ┌─────────────────┐
                   │  Backend (Rust) │  Axum + SQLx
                   └────────┬────────┘
                            ▼
                   ┌─────────────────┐
                   │   PostgreSQL    │  single source of truth
                   └─────────────────┘   (queues, sessions, sync — no Redis)
```

**Design principles:**

1. **Offline-first.** All studying happens locally; sync is a background delta exchange.
2. **One database.** PostgreSQL is the only stateful service — job queues via `SKIP LOCKED`, sessions, sync state. No Redis/Kafka until a real, measured need exists. See [ADR-0004](docs/adr/0004-postgres-only-infrastructure.md).
3. **Small infra.** The whole production system fits on a single small VPS. See [docs/infra.md](docs/infra.md).
4. **Contracts first.** Anything crossing a process boundary is defined in [`shared/proto`](shared/proto).

---

## 📂 Repository Structure

```text
qyic/
├── docs/          # Product plan, ADRs, deck-format and infrastructure specs
├── mobile/        # Flutter app (Android / iOS / desktop) — offline-first, SQLite
├── server/        # Rust API (Axum + SQLx) and PostgreSQL migrations
├── shared/        # Cross-client contracts (Protocol Buffers)
├── web/           # SvelteKit + TypeScript web client
├── docker-compose.yml
├── Makefile
└── README.md
```

---

## 🚀 Getting Started Locally

### Prerequisites

- [Git](https://git-scm.com/)
- [Docker](https://www.docker.com/) & Docker Compose
- [Rust & Cargo](https://www.rust-lang.org/tools/install) (backend)
- [Node.js](https://nodejs.org/) ≥ 20 (web client)
- [Flutter SDK](https://docs.flutter.dev/get-started/install) (mobile client)

### 1. Clone the Repository

```bash
git clone https://github.com/LyeZinho/qyic.git
cd qyic
cp .env.example .env
```

### 2. Start PostgreSQL (Docker)

```bash
docker compose up -d postgres
```

### 3. Run the Backend (Rust)

```bash
make server-run
# or: cargo run --manifest-path server/Cargo.toml
```

The API will be available at `http://localhost:8080` (`GET /healthz`).

> Migrations run automatically on boot. Without SMTP configured, magic login links are printed to the server log instead of being e-mailed.

### 4. Run the Web Client (SvelteKit)

```bash
make web-install
make web-dev
# or: cd web && npm install && npm run dev
```

Open `http://localhost:5173`.

### 5. Run the Mobile Client (Flutter)

```bash
cd mobile
flutter pub get
flutter create . --platforms=android,ios   # generates platform folders (first run only)
flutter run
```

### Useful Commands

```bash
make help     # list all shortcuts
make fmt      # format Rust + Dart + TypeScript
make lint     # clippy, flutter analyze, svelte-check, buf lint
make test     # run all test suites
make dev-up   # start postgres + api via docker compose
```

---

## 📦 The `.qdeck` File Format

Decks are shared as a single portable file:

```text
my_deck.qdeck            (zip container)
├── deck.pb              # quizzes serialized with Protocol Buffers
├── manifest.json        # title, author, version, checksum (SHA-256)
└── media/               # images and audio referenced by the quizzes
```

Binary + compressed, fast to parse in both Dart and Rust, and backward compatible by design (additive Protobuf evolution). Full specification: [docs/deck-format.md](docs/deck-format.md).

---

## 🗺️ Project Plan

The roadmap, milestones, and workstreams live in [docs/PLAN.md](docs/PLAN.md).
Architecture decisions are recorded as ADRs in [docs/adr/](docs/adr/README.md).

---

## 🤝 Contributing

Contributions are welcome! Read [CONTRIBUTING.md](CONTRIBUTING.md) first.
If you are an AI agent, read [AGENTS.md](AGENTS.md) before touching the code.

---

## 📄 License

This project is licensed under the MIT License — see [LICENSE](LICENSE) for details.

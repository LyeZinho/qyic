# 0002. Flutter, SvelteKit, and Rust as the client/server stack

Date: 2026-10-27

## Status

Accepted

## Context

Qyic needs mobile apps (Android/iOS, possibly desktop), a web client, and an API.
The core experience is a fast, animated quiz loop over thousands of local rows —
frame drops and DB hiccups are felt immediately. The team also wants low hosting
cost and a small operational surface. React Native and JavaScript-heavy backends
were considered and rejected.

**Guiding quote:** *if we economize on portability, we always pay with performance.*

## Decision

We will use:

- **Mobile:** Flutter + SQLite — single codebase compiled to native ARM/x86,
  Skia/Impeller rendering for stable 60/120 FPS, and a fully local store so the
  study loop never blocks on a bridge or a network call.
- **Web:** SvelteKit + TypeScript — compiled, imperative output (no Virtual DOM),
  small bundles, SSR for SEO, and a smooth SPA experience.
- **Server:** Rust (Axum + SQLx) + PostgreSQL — memory safety, predictable low
  latency, tiny RSS footprint (a static binary idles around tens of MB), which
  keeps the single-VPS budget intact.

## Alternatives Considered

- **React Native** — a JS bridge (or JSI/Fabric) sits between UI and native code;
  heavy animations and intensive local DB work risk jank and memory spikes. Also
  drags a Node runtime into every developer environment. Rejected on performance.
- **Node.js/Go backend** — workable, but higher idle memory/CPU per request and
  less headroom on a small VPS; Rust also removes whole classes of data races
  from the sync engine.
- **Electron desktop** — heavy; Flutter already targets desktop from one codebase.
- **Native Android + native iOS** — best possible perf, but doubles maintenance
  for a solo/small team.

## Consequences

- Three languages in the repo — mitigated by Protobuf contracts in `shared/`
  and by keeping each area's conventions documented in `AGENTS.md`.
- Flutter's app size (~10–20 MB baseline) is accepted as the price of native rendering.
- The SRS scheduler logic must be implemented in more than one language; we keep
  golden test vectors shared to prevent drift (tracked in `docs/PLAN.md` M1).

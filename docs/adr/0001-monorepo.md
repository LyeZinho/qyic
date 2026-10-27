# 0001. Monorepo for all clients and the server

Date: 2026-10-27

## Status

Accepted

## Context

Qyic has three deployable targets (Flutter mobile, SvelteKit web, Rust API) plus
a shared contract layer (Protobuf) and infrastructure definitions. Decisions like
the deck format or the sync protocol touch all of them at once. Separate
repositories would require coordinated releases, version skew, and copy-pasted
schemas before the product even ships its first milestone.

## Decision

We will keep everything in a **single monorepo** with top-level areas:

```text
server/  web/  mobile/  shared/  docs/  .github/
```

- Contracts in `shared/` are versioned together with their consumers.
- One CI pipeline (`/.github/workflows/ci.yml`) gates every area on each PR.
- Shortcuts are centralized in a root `Makefile` so contributors never need to
  remember per-area command syntax.

## Alternatives Considered

- **Multi-repo per client** — parallel work early on, but constant version skew
  and cross-repo PRs for a single feature; too much ceremony for one product.
- **Polyrepo with git submodules** — worst of both worlds: merge friction and
  fragile checkouts.

## Consequences

- Atomic cross-cutting changes: a new quiz type lands in one PR.
- CI must stay fast (per-area jobs run in parallel; caches for Cargo/npm).
- The repo will grow — we keep it tidy with strict top-level boundaries and no
  dumping-ground directories.

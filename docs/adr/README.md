# Architecture Decision Records (ADR)

We record significant technical decisions here using the lightweight format
inspired by [Michael Nygard's ADRs](https://cognitect.com/blog/2011/11/15/documenting-architecture-decisions).

## When to write one

Write an ADR when a decision:

- changes an architectural invariant listed in [`AGENTS.md`](../../AGENTS.md)
  (adding a service, changing the sync model, breaking the deck format…),
- is expensive to reverse, or
- affects multiple workstreams/clients.

Small, easily reversible choices do not need an ADR — a PR description is enough.

## Template

Copy this into `NNNN-short-title.md` (next number in sequence):

```markdown
# NNNN. Title

Date: YYYY-MM-DD

## Status

Proposed | Accepted | Superseded by [NNNN](NNNN-link) | Deprecated

## Context

What is the force at play? What problem are we solving?

## Decision

What we chose, stated in the active voice ("We will …").

## Alternatives Considered

- Option A — why not
- Option B — why not

## Consequences

What becomes easier, harder, or needs follow-up.
```

## Index

| ADR | Title | Status |
| --- | ----- | ------ |
| [0001](0001-monorepo.md) | Monorepo for all clients and the server | Accepted |
| [0002](0002-tech-stack.md) | Flutter, SvelteKit, and Rust as the client/server stack | Accepted |
| [0003](0003-qdeck-format.md) | `.qdeck`: ZIP + Protobuf deck file format | Accepted |
| [0004](0004-postgres-only-infrastructure.md) | PostgreSQL-only infrastructure (no Redis) | Accepted |
| [0005](0005-passwordless-auth.md) | Passwordless e-mail authentication | Accepted |
| [0006](0006-offline-first-sync.md) | Offline-first clients with delta sync | Accepted |

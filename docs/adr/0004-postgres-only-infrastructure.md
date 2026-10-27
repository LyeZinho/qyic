# 0004. PostgreSQL-only infrastructure (no Redis)

Date: 2026-10-27

## Status

Accepted

## Context

Typical designs reach for Redis (or Kafka) the moment queues, rate limits, or
shared caches appear. That means a second stateful cluster to provision, monitor,
back up, and keep consistent with the primary database — a large operational and
cost burden for Qyic, which targets a single modest VPS.

Shopify's engineering write-up *"We replaced Redis with MySQL for inventory
reservations — and it scaled"* is the reference case: by using modern relational
features (`SKIP LOCKED`, composite primary keys, `READ COMMITTED`, disciplined
lock ordering), they removed Redis while keeping ACID correctness — and found
their real bottleneck was **connection hold time**, not CPU.

Qyic's concurrency needs (sync delta ingestion, background jobs, deck publishing,
rate limiting) are far below Shopify's, so the same playbook applies with slack
to spare.

## Decision

**PostgreSQL is the only stateful service.** Specifically:

- **Queues/jobs:** a `jobs` table consumed with
  `SELECT … FOR UPDATE SKIP LOCKED LIMIT n` in short transactions.
- **Rate limiting / one-time tokens:** counter and token tables in Postgres
  (auth tokens already live there with `expires_at` + atomic `used_at` claims).
- **Caching:** start with none. Add an in-process cache first; a materialized
  view or `UNLOGGED` table second. Redis only ever via a future ADR.
- **Connection discipline:** small pools (SQLx), strictly short transactions,
  and every SQL statement tagged per business process so connection hold time
  can be attributed (Shopify's `/* conn_tag:… */` trick).
- **Isolation:** default `READ COMMITTED`; escalate to explicit
  `SELECT … FOR UPDATE` only where a read-modify-write race is proven.
- **Lock ordering:** fixed table order per flow to prevent deadlocks.

## Alternatives Considered

- **Redis for queues/session cache** — removes ACID across the operation and its
  data store (Shopify's oversell/undersell failure modes), adds a whole cluster
  to operate, and buys nothing at Qyic's scale.
- **Kafka/NATS for sync events** — massive overkill; sync is a delta pull/push
  over REST, not a fan-out stream.
- **Separate cache service (Memcached, etc.)** — premature; measure first.

## Consequences

- One database to back up, patch, and reason about — documented in `docs/infra.md`.
- Correctness becomes simpler: sync, auth, and jobs share one transaction scope.
- We must be disciplined about **short transactions**; slow handlers holding
  connections become the bottleneck (per Shopify: instrument hold time early).
- If a future feature truly needs pub/sub fan-out at scale, it triggers an ADR
  with measurements attached.

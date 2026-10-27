# Infrastructure Guide

How Qyic runs in production with the **lowest possible cost and operational
surface**, while staying responsive and scalable.

Companion ADR: [0004 — Postgres-only infrastructure](adr/0004-postgres-only-infrastructure.md).

## 1. Principles

1. **One stateful service.** PostgreSQL holds application data, sessions, sync
   state, and background-job queues (`SKIP LOCKED`). No Redis, no Kafka.
2. **One compute box.** A single VPS runs the API and the database via Docker
   Compose. Rust keeps the footprint tiny.
3. **Stateless tiers are free/cheap.** The SvelteKit build goes to a static
   host (Cloudflare Pages / Vercel / IONOS hosted web) — CDN, TLS, and scaling
   handled by the platform.
4. **Boring, reversible operations.** Everything is a file in this repo:
   `docker-compose.yml`, `.env`, migrations. No clicking in cloud consoles.
5. **Backups before features.** Nightly off-box `pg_dump` with a documented,
   tested restore.

## 2. Topology

```text
                      ┌───────────────────────────────┐
 Users ──HTTPS──────► │ Static web (Cloudflare/Vercel)│  SvelteKit build
                      └───────────────┬───────────────┘
                                      │ HTTPS (api.qyic.com)
                      ┌───────────────▼───────────────┐
 Mobile app ─────────►│  IONOS VPS (Ubuntu/Debian)    │
                      │  ├─ Caddy (TLS, reverse proxy)│
                      │  ├─ qyic-server (Rust, :8080) │
                      │  └─ PostgreSQL 16 (internal)  │
                      └───────────────────────────────┘
```

- Only Caddy is exposed publicly (80/443). PostgreSQL binds to the Docker
  network (or `127.0.0.1`), never the public internet.
- Mobile and web both talk to the same REST API.

## 3. Sizing & Cost

| Item | Baseline | Notes |
| ---- | -------- | ----- |
| VPS   | 2 vCPU / 4 GB RAM / NVMe | Rust idle ~20–30 MB; Postgres is the main consumer |
| Web   | Free/cheap static tier | SvelteKit builds are tiny |
| SMTP  | IONOS mail (bundled with domain) | Own domain → good deliverability |
| Total | Very low fixed monthly cost | Scales vertically before anything else |

Scale-out order when (and only when) load demands it:

1. Vertical VPS resize.
2. Read replica for analytics/reporting queries.
3. Move the static tier's heavy dynamic parts to the existing VPS.
4. Split services — **requires an ADR**.

## 4. Environments

| Env | Database | Notes |
| --- | -------- | ----- |
| local | `docker compose` Postgres | `make dev-up` |
| staging | same VPS, separate compose project + DB | optional, cheap |
| production | same VPS, named volume + off-box backups | |

Configuration comes from `.env` (see `.env.example`) — never committed.

## 5. Security Baseline

- Caddy auto-renews Let's Encrypt certificates.
- API is stateless apart from Postgres; sessions are short-lived rows.
- Auth is passwordless (ADR-0005): raw tokens are never stored, only SHA-256 hashes.
- Magic-link/OTP endpoints need rate limiting (Postgres counter table — no Redis),
  to land before public launch.
- `docker compose` Postgres credentials are rotated per environment.
- Non-root containers; the Rust image ships only the release binary + CA certs.

## 6. Backups & Restore

Nightly (cron on the VPS):

```bash
pg_dump -Fc qyic > /var/backups/qyic-$(date +%F).dump
# then rsync/rclone to off-box object storage
```

Restore drill (document and rehearse before launch):

```bash
createdb qyic_restored
pg_restore -d qyic_restored /var/backups/qyic-YYYY-MM-DD.dump
```

Retention: 7 daily, 4 weekly, 3 monthly.

## 7. Observability (lightweight, no extra services)

- **Logs:** `docker compose logs` → journald with logrotate; structured `tracing`
  JSON in production.
- **Health:** `GET /healthz` (liveness, no DB) and `GET /api/v1/health/ready`
  (DB round-trip) — used by Caddy/Cron health pings.
- **Metrics (later):** connection hold-time and slow-query logging in Postgres
  first — remember the Shopify lesson: *the bottleneck was connection usage, not CPU*.

## 8. Deployment

```bash
git pull
docker compose build api
docker compose up -d
docker compose run --rm api qyic-server   # migrations run on boot
```

Rollback = redeploy the previous image tag. Database migrations are
append-only and written to be backward compatible with the previous release.

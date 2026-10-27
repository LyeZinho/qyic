# 0005. Passwordless e-mail authentication

Date: 2026-10-27

## Status

Accepted

## Context

Accounts must work across mobile and web and sync progress between them.
Conventional e-mail/password auth means storing password hashes, designing reset
flows, defending against credential stuffing, and providing password-support
support — all of which the product does not need. The owner also prefers
"less is more" and is willing to run an **own SMTP** (bundled with the IONOS
domain plan) for deliverability.

## Decision

We will implement **passwordless authentication via e-mail**:

1. User submits only their e-mail address (web or mobile).
2. Server upserts the user, generates a random token, stores **only its SHA-256
   hash** with a short `expires_at` (15 min) in `auth_tokens`.
3. A magic link is sent through the configured SMTP server
   (`lettre` in the Rust API). **In local/dev without SMTP, the link is logged**
   so the flow stays testable offline.
4. Visiting `/auth/verify?token=…` atomically claims the token
   (`UPDATE … WHERE used_at IS NULL`) and issues a long-lived session token
   (again stored hashed) returned as JSON — the web client mirrors it into an
   HTTP-only cookie; the mobile client stores it via secure storage.
5. Sessions are rows with `expires_at`/`revoked_at`; logout = revoke.

No passwords, no password reset, no OAuth — those require an ADR to introduce.

## Alternatives Considered

- **E-mail/password (bcrypt/argon2)** — the hash-leak and reset-flow burden with
  no product upside; rejected by the "less is more" principle.
- **Third-party OAuth (Google/Apple)** — better conversion eventually, but adds
  provider dependencies, redirect flows, and a second account model; possible
  later behind an ADR.
- **TOTP authenticator app (primary factor)** — friction for a study app; OTP
  codes remain a fallback input method for the same token flow.
- **Managed auth service (Auth0, Clerk…)** — recurring cost and vendor lock-in,
  against the low-cost-infrastructure principle.

## Consequences

- Deliverability becomes critical: own domain, IONOS SMTP, dedicated
  `no-reply@qyic.com` sender, SPF/DKIM configured at launch.
- Login endpoints need rate limiting (Postgres counters, ADR-0004) before public
  launch — otherwise the API becomes a mail-bombing vector.
- Tokens must always be compared as hashes; raw tokens only exist in transit.
- The verify endpoint must be a **GET for link click-through** plus a POST path
  for typed OTP codes.

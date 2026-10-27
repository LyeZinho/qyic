# `shared/` — cross-client contracts

Single source of truth for every payload that crosses a process boundary:
deck files (`.qdeck`), sync deltas, and auth messages.

| File | Purpose |
| ---- | ------- |
| `proto/qyic/v1/deck.proto` | Deck/quiz payload inside `.qdeck` (spec: [`docs/deck-format.md`](../docs/deck-format.md)) |
| `proto/qyic/v1/review.proto` | Review events and sync push/pull messages |
| `proto/qyic/v1/auth.proto` | Passwordless login/verify/session messages |

## Rules

- Package `qyic.v1`; files under `proto/qyic/v1/`.
- **Append-only**: never renumber or reuse field tags once released.
- Enum zero values are `*_UNSPECIFIED`.
- A contract change updates **every client in the same PR** plus the relevant doc.

## Lint

```bash
cd shared
npx --yes @bufbuild/buf lint
```

CI runs this on every pull request.

## Code generation

**TypeScript (web):**

```bash
cd shared
npx buf generate          # writes gen/ts (see buf.gen.yaml)
```

**Dart (mobile):**

```bash
dart pub global activate protoc_plugin
cd shared
protoc --dart_out=../mobile/lib/generated/protos \
  -I proto proto/qyic/v1/*.proto
```

**Rust (server):** generated at build time with [`prost-build`](https://docs.rs/prost-build)
(wired in milestone M1 — the server currently speaks proto3 canonical JSON for
the auth messages defined in `auth.proto`).

Generated output is always git-ignored (`gen/`); clients regenerate on demand.

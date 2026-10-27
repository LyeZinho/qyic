# `web/` — SvelteKit client

The Qyic web app: SvelteKit + TypeScript, built for small bundles and instant
loads. Scaffolded with [`sv`](https://github.com/sveltejs/cli).

```bash
npm install      # once (or: make web-install from the repo root)
npm run dev      # http://localhost:5173
npm run check    # svelte-check (type checking)
npm run lint     # prettier --check + eslint
npm run format   # prettier --write
npm run build    # production build (adapter-auto)
npm run preview  # preview the production build
```

## Conventions

- The web client is **offline-capable**: study state persists locally
  (IndexedDB) and syncs as deltas — see [`docs/adr/0006-offline-first-sync.md`](../docs/adr/0006-offline-first-sync.md).
- API payloads shared with the server are defined in [`shared/proto`](../shared/proto);
  do not hand-roll divergent JSON shapes.
- The default adapter is `adapter-auto` (deploys to Cloudflare/Vercel/Netlify);
  switch via `npx sv add sveltekit-adapter` if the target changes.

Repository-level setup, conventions, and the roadmap live in the
[root README](../README.md), [AGENTS.md](../AGENTS.md), and [docs/PLAN.md](../docs/PLAN.md).

# Qyic — Website Mockups as a Real SvelteKit Site

**Date:** 2026-10-29
**Status:** awaiting partner approval
**Supersedes:** `planning/mockups-wireframes/qyic_ui_design_system_prototype.html`

## Intent

The current mockup is a single 983-line HTML file that only shows the personal
study experience (dashboard, quiz, decks). Two problems: the single-file format
does not scale, and it misses half the product — Qyic is a *community* where
users publish decks for others (PLAN.md M4, "Deck hub").

This work replaces the file with clickable, polished website mockups built in
the real stack (`web/` — SvelteKit + TypeScript), covering both the public
website and the signed-in app. The result doubles as the visual foundation of
the actual product: mock data lives behind one swap point so it can later be
replaced by real API calls without restructuring routes or components.

Mobile (Flutter) mockups are explicitly out of scope; the existing static
phone-frame file stays untouched in `planning/mockups-wireframes/`.

## Goals

- Mockups that feel like a real website: multiple URL-addressable pages,
  working navigation, coherent sample data, finished-quality visuals.
- Cover the community side the current file misses: landing, public deck
  browsing, search, public deck detail, deck hub, publish flow.
- Keep every interaction the current prototype had: online/offline sync
  toggle, multiple-choice grading, FSRS rating bar, fill-in-the-blank checker,
  matching pairs, true/false, deck import modal.
- One design-token source shared by every page, ported from the existing
  prototype palette (slate/indigo/amber) so the identity does not drift.
- `npm run check`, `npm run build`, and `npm run lint` stay green (CI gate).

## Non-goals

- Real backend, API calls, real auth. All data is mocked.
- Server-side persistence. Mock state lives in memory for the length of a
  visit (see Decision 5); only the mock session survives a page reload.
- Mobile app mockups (out of scope by request).
- Light theme, i18n, production SEO beyond basic titles.
- Unit tests for mock pages beyond what the repo's CI gates require.

## Anti-goals

- A parallel throwaway prototype app that never merges with the product.
- Pages that only look right on one screen width.
- Generic lorem-ipsum data; sample content must read like real decks.

## Constraints

- Stack is fixed: SvelteKit 5 + Svelte runes, TypeScript strict, no `any`
  without a justifying comment (AGENTS.md).
- English everywhere.
- New dev dependency **Tailwind CSS v4** (via `@tailwindcss/vite`) plus
  `lucide-svelte` for icons — approved by this doc; no other new deps.
- Conventional Commits when this lands.

## Approaches considered

| Approach | Trade-off | Verdict |
| -------- | --------- | ------- |
| A. Organized static HTML (one file per screen, shared CSS) | Cheap and throwaway, but stays outside the product stack and drifts from it immediately | Rejected — user explicitly asked for "a real website" |
| B. Separate prototype SvelteKit app under `planning/` | Isolated from product code, but duplicates tooling and the prototype is still throwaway | Rejected |
| C. Real routes in `web/` with a mock-data layer | Mockups run with `npm run dev`, components evolve into the product, one swap point (`$lib/data`) for real APIs later | **Chosen** |

## Decisions

### 1. Route map

Route groups `(public)` and `(app)` keep layouts independent. Pages run under
normal SvelteKit dev/SSR — **no prerender requirement** (see Decision 6).

**Public (no account):**

- `/` — landing + discovery: hero with search, featured decks, trending decks,
  how-it-works strip, login CTA
- `/browse` — search results: filterable grid (text query, tags, category,
  sort by newest/popularity)
- `/decks/[id]` — public deck detail: title, author, description, card count,
  tags, sample card preview, "Sign in to add this deck"
- `/login` — magic-link request form, with a mocked "check your e-mail"
  confirmation state

**Signed-in (mock session):**

- `/app` — dashboard: daily-queue hero, active decks grid, stats sidebar
  (consistency heatmap, review forecast, achievements) — evolved from the
  current prototype's web view
- `/app/study` — quiz arena: multiple choice with grading, FSRS rating bar,
  and the fill-in-the-blank / matching / true-false formats reachable as
  question-type variants of the same session
- `/app/hub` — community deck hub: new releases, popular authors, category
  browsing
- `/app/library` — my decks: owned + imported decks with due counts, entry
  point to publish
- `/app/library/publish` — publish flow: upload `.qdeck`, metadata form
  (title, description, tags, visibility), mocked dedupe-by-hash feedback

Entering `/app/*` without the mock session redirects to `/login`; any e-mail
"signs in" (demo convenience).

### 2. Design system

- Palette, radii, and shadows ported from the current prototype's tokens
  (base `#0F172A`, surface `#1E293B`, primary `#6366F1`, xp `#F59E0B`, …).
- Tailwind v4 theme via CSS custom properties in `src/app.css`; no per-page
  token copies.
- Inter + JetBrains Mono, same as the prototype.
- Shared components in `$lib/components` (DeckCard, StatCard, QuizCard,
  FsrsRatingBar, TagBadge, SiteHeader, SiteFooter, AppSidebar, …) so pages
  cannot drift from each other.

### 3. Mock data layer

- `$lib/data/`: typed mock entities (Deck, UserProfile, ReviewStats,
  Achievement, DeckListItem) plus functions with repository signatures
  (`getDeck(id)`, `searchDecks({q, tags, sort})`, `getMyLibrary()`).
- Pages only call these functions — the single swap point for the future API.
- Content is coherent: the same ~10 sample decks, authors, and stats recur
  across landing, browse, detail, hub, and dashboard, matching the domain
  (Rust/Flutter/FSRS-themed decks from the prototype are kept).

### 4. Interaction & polish bar

- Every prototype interaction carried over, rewritten idiomatically in Svelte
  5 runes (no inline `alert()` stubs — in-page feedback instead).
- Hover/active/focus-visible states on all interactive elements; keyboard
  navigation works; icon-only buttons carry `aria-label`s.
- Desktop-first layout (matching the app's three-zone dashboard) that stays
  usable down to ~360 px.
- Micro-interactions: button press scale, selection highlight on quiz options,
  animated progress bars, smooth view transitions between quiz cards.

### 5. State model (call)

One client-side store module (`$lib/state.svelte.ts`, Svelte 5 runes) wraps
`$lib/data`. Pages read and mutate it, so actions stay coherent across pages
during a visit:

- rating cards in `/app/study` updates dashboard due counts, XP, and heatmap;
- import/publish adds the deck to `/app/library`;
- "Sign in to add this deck" lands it in the library after login;
- the offline toggle shows a delta-queue counter fed by study actions;
- study progress survives navigating away and back.

Only the mock session persists across reloads (localStorage — mirrors a real
cookie session). All other state resets on reload, honoring the non-goal.

### 6. How the mockups run and get reviewed (call)

- Local only: `npm run dev` (or `preview`) in `web/`. No hosting in this work —
  web launch is milestone M6.
- No prerender: with normal SSR/dev, the `(app)` session guard runs in
  `(app)/+layout` on the client, redirecting to `/login` when no mock session
  exists (an acceptable flash of gated content in a mockup).
- `/browse` filtering runs client-side over the mock fixtures.

### 7. Auth seam (call)

Mock session logic lives behind a small `$lib/auth` interface
(`getSession`, `signIn`, `signOut`), localStorage-backed today. M0's pending
"first green end-to-end login on web" later swaps in the real magic-link
session without touching any page — flagged here for coordination so the two
streams don't both own `/login` logic.

## What's left to the builder

Component breakdown, exact mock data content, per-page layout details, and the
implementation order — all decided in the implementation plan, not here.

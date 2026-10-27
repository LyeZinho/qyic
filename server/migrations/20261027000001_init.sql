-- Qyic initial schema (M0).
-- Append-only rule: never edit this file after it ships; add a new migration.

-- ---------------------------------------------------------------------------
-- Identity (passwordless, ADR-0005)
-- ---------------------------------------------------------------------------

CREATE TABLE users (
    id           uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    email        text NOT NULL UNIQUE,
    display_name text,
    created_at   timestamptz NOT NULL DEFAULT now(),
    updated_at   timestamptz NOT NULL DEFAULT now(),
    CONSTRAINT users_email_has_at CHECK (position('@' in email) > 1)
);

-- Raw tokens are never stored, only SHA-256 hashes.
CREATE TABLE auth_tokens (
    id         uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id    uuid NOT NULL REFERENCES users (id) ON DELETE CASCADE,
    token_hash text NOT NULL UNIQUE,
    kind       text NOT NULL DEFAULT 'magic_link'
               CHECK (kind IN ('magic_link', 'otp')),
    expires_at timestamptz NOT NULL,
    used_at    timestamptz,
    created_at timestamptz NOT NULL DEFAULT now()
);
CREATE INDEX auth_tokens_user_id_idx ON auth_tokens (user_id);
CREATE INDEX auth_tokens_expires_at_idx ON auth_tokens (expires_at);

CREATE TABLE sessions (
    id         uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id    uuid NOT NULL REFERENCES users (id) ON DELETE CASCADE,
    token_hash text NOT NULL UNIQUE,
    expires_at timestamptz NOT NULL,
    revoked_at timestamptz,
    created_at timestamptz NOT NULL DEFAULT now()
);
CREATE INDEX sessions_user_id_idx ON sessions (user_id);
CREATE INDEX sessions_expires_at_idx ON sessions (expires_at);

-- ---------------------------------------------------------------------------
-- Decks & quizzes
-- ---------------------------------------------------------------------------

CREATE TABLE decks (
    id           uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    owner_id     uuid REFERENCES users (id) ON DELETE SET NULL,
    title        text NOT NULL,
    description  text NOT NULL DEFAULT '',
    author       text NOT NULL DEFAULT '',
    locale       text NOT NULL DEFAULT 'en',
    deck_version integer NOT NULL DEFAULT 1,
    visibility   text NOT NULL DEFAULT 'private'
                 CHECK (visibility IN ('private', 'unlisted', 'public')),
    deleted_at   timestamptz, -- tombstone for sync (ADR-0006)
    created_at   timestamptz NOT NULL DEFAULT now(),
    updated_at   timestamptz NOT NULL DEFAULT now()
);
CREATE INDEX decks_owner_id_idx ON decks (owner_id);
CREATE INDEX decks_public_idx ON decks (updated_at DESC)
    WHERE visibility = 'public' AND deleted_at IS NULL;

CREATE TABLE quizzes (
    id          uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    deck_id     uuid NOT NULL REFERENCES decks (id) ON DELETE CASCADE,
    kind        text NOT NULL CHECK (kind IN (
                    'multiple_choice', 'fill_in_the_blank', 'matching', 'true_false')),
    position    integer NOT NULL DEFAULT 0,
    question    text NOT NULL,
    explanation text NOT NULL DEFAULT '',
    -- Kind-specific options/pairs/blanks (mirrors qyic.v1.Option in deck.proto).
    payload     jsonb NOT NULL DEFAULT '{}'::jsonb,
    deleted_at  timestamptz, -- tombstone for sync (ADR-0006)
    created_at  timestamptz NOT NULL DEFAULT now(),
    updated_at  timestamptz NOT NULL DEFAULT now()
);
CREATE UNIQUE INDEX quizzes_deck_position_idx ON quizzes (deck_id, position)
    WHERE deleted_at IS NULL;
CREATE INDEX quizzes_deck_id_idx ON quizzes (deck_id);

-- ---------------------------------------------------------------------------
-- Spaced repetition state (per user, per quiz)
-- ---------------------------------------------------------------------------

CREATE TABLE review_state (
    user_id          uuid NOT NULL REFERENCES users (id) ON DELETE CASCADE,
    quiz_id          uuid NOT NULL REFERENCES quizzes (id) ON DELETE CASCADE,
    due_at           timestamptz NOT NULL DEFAULT now(),
    stability        double precision NOT NULL DEFAULT 0, -- FSRS: days
    difficulty       double precision NOT NULL DEFAULT 0, -- FSRS: 1..10 scale
    reps             integer NOT NULL DEFAULT 0,
    lapses           integer NOT NULL DEFAULT 0,
    last_reviewed_at timestamptz,
    -- Scheduler-specific fields (FSRS memory state, etc.).
    state            jsonb NOT NULL DEFAULT '{}'::jsonb,
    updated_at       timestamptz NOT NULL DEFAULT now(),
    PRIMARY KEY (user_id, quiz_id)
);
CREATE INDEX review_state_due_at_idx ON review_state (due_at);

-- Append-only review history; the unit of delta sync (ADR-0006).
-- (client_id, client_seq) makes sync idempotent: replaying is a no-op.
CREATE TABLE review_events (
    id            uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id       uuid NOT NULL REFERENCES users (id) ON DELETE CASCADE,
    deck_id       uuid REFERENCES decks (id) ON DELETE SET NULL,
    -- Not a FK: events must outlive the quizzes they reference.
    quiz_id       uuid NOT NULL,
    client_id     text NOT NULL,
    client_seq    bigint NOT NULL,
    rating        smallint NOT NULL CHECK (rating BETWEEN 1 AND 4),
    reviewed_at   timestamptz NOT NULL,
    duration_ms   integer,
    created_at    timestamptz NOT NULL DEFAULT now(),
    UNIQUE (client_id, client_seq)
);
CREATE INDEX review_events_user_id_idx ON review_events (user_id, client_seq);

-- ---------------------------------------------------------------------------
-- Background jobs — Postgres-only queue via SKIP LOCKED (ADR-0004)
-- Worker loop: SELECT ... FOR UPDATE SKIP LOCKED WHERE locked_at IS NULL
--              AND run_at <= now() ORDER BY run_at LIMIT n;
-- ---------------------------------------------------------------------------

CREATE TABLE jobs (
    id         uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    kind       text NOT NULL,
    payload    jsonb NOT NULL DEFAULT '{}'::jsonb,
    run_at     timestamptz NOT NULL DEFAULT now(),
    attempts   integer NOT NULL DEFAULT 0,
    locked_at  timestamptz,
    last_error text,
    created_at timestamptz NOT NULL DEFAULT now()
);
CREATE INDEX jobs_ready_idx ON jobs (run_at) WHERE locked_at IS NULL;

"""Generate FSRS golden test vectors from the reference implementation.

Every Qyic scheduler port (Dart, TypeScript, Rust) must reproduce these
vectors exactly (intervals, due dates, phases) and within 1e-9 relative
tolerance for stability and difficulty.

Usage:
    python -m venv .venv && .venv/bin/pip install fsrs==6.3.2
    .venv/bin/python shared/fsrs/generate_vectors.py > shared/fsrs/vectors.json
"""

from __future__ import annotations

import json
import random
from datetime import datetime, timedelta, timezone
from importlib import metadata

from fsrs import Card, Rating, Scheduler

FSRS_VERSION = "6.3.2"
START = datetime(2026, 1, 1, 9, 0, tzinfo=timezone.utc)


def to_ms(moment: datetime) -> int:
    return int(moment.timestamp() * 1000)


def snapshot(card: Card) -> dict:
    return {
        "phase": int(card.state),
        "step": card.step,
        "stability": card.stability,
        "difficulty": card.difficulty,
        "due_ms": to_ms(card.due),
        "last_review_ms": to_ms(card.last_review),
    }


def run(name: str, desired_retention: float, plan: list[tuple[int, int]]) -> dict:
    """Replay `plan`, a list of (rating, seconds after the current due date)."""
    scheduler = Scheduler(desired_retention=desired_retention, enable_fuzzing=False)
    card = Card(due=START)
    reviews = []
    for rating, delay_seconds in plan:
        reviewed_at = card.due + timedelta(seconds=delay_seconds)
        if card.last_review is not None:
            reviewed_at = max(reviewed_at, card.last_review + timedelta(minutes=1))
        card, _ = scheduler.review_card(card, Rating(rating), reviewed_at)
        reviews.append(
            {
                "rating": rating,
                "reviewed_at_ms": to_ms(reviewed_at),
                "expected": snapshot(card),
            }
        )
    return {
        "name": name,
        "desired_retention": desired_retention,
        "created_at_ms": to_ms(START),
        "reviews": reviews,
    }


def random_plan(seed: int, length: int) -> list[tuple[int, int]]:
    rng = random.Random(seed)
    plan = []
    for _ in range(length):
        rating = rng.choices([1, 2, 3, 4], weights=[2, 2, 5, 1])[0]
        # Mix early, on-time, and late reviews (up to 3 days either way).
        delay = rng.choice([0, 0, rng.randint(-3 * 86400, 3 * 86400)])
        plan.append((rating, delay))
    return plan


def main() -> None:
    installed = metadata.version("fsrs")
    if installed != FSRS_VERSION:
        raise SystemExit(f"expected fsrs=={FSRS_VERSION}, found {installed}")
    day = 86400
    scenarios = [
        run("good_streak_on_time", 0.9, [(3, 0)] * 8),
        run("easy_from_new", 0.9, [(4, 0), (4, 0), (4, 0)]),
        run("hard_steps", 0.9, [(2, 0), (2, 0), (3, 0), (3, 0), (2, 0)]),
        run("again_in_learning", 0.9, [(1, 0), (1, 0), (3, 0), (3, 0), (3, 0)]),
        run("lapse_and_relearn", 0.9, [(3, 0), (3, 0), (3, 0), (1, 0), (3, 0), (3, 0)]),
        run("late_reviews", 0.9, [(3, 0), (3, 0), (3, 5 * day), (3, 20 * day), (2, 2 * day)]),
        run("early_reviews", 0.9, [(3, 0), (3, 0), (3, -2 * day), (3, -1 * day), (4, 0)]),
        run("same_day_review_phase", 0.9, [(4, 0), (3, -day + 60), (1, 0), (2, 0)]),
        run("retention_085", 0.85, [(3, 0), (3, 0), (3, 0), (2, 0), (4, 0)]),
        run("retention_095", 0.95, [(3, 0), (3, 0), (3, 0), (2, 0), (4, 0)]),
    ]
    scenarios += [
        run(f"random_{seed}", 0.9, random_plan(seed, 25)) for seed in range(12)
    ]
    print(
        json.dumps(
            {
                "reference": f"py-fsrs {FSRS_VERSION}",
                "fuzzing": False,
                "scenarios": scenarios,
            },
            indent=2,
        )
    )


if __name__ == "__main__":
    main()

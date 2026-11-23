/// FSRS-6 scheduler, ported from the reference implementation
/// [py-fsrs](https://github.com/open-spaced-repetition/py-fsrs) 6.3.2.
///
/// Interval fuzzing is intentionally not implemented: every client (Dart, TS,
/// Rust) must produce identical schedules when replaying the same review
/// events, which is verified against `shared/fsrs/vectors.json`.
library;

import 'dart:math' as math;

/// Learner grade. Values match `qyic.v1.ReviewRating`.
enum Rating {
  again(1),
  hard(2),
  good(3),
  easy(4);

  const Rating(this.value);

  final int value;

  static Rating fromValue(int value) =>
      Rating.values.firstWhere((rating) => rating.value == value);
}

/// Memory phase of a card. Values match the reference implementation.
enum CardPhase {
  learning(1),
  review(2),
  relearning(3);

  const CardPhase(this.value);

  final int value;

  static CardPhase fromValue(int value) =>
      CardPhase.values.firstWhere((phase) => phase.value == value);
}

/// Scheduling state of a single card. Immutable; [FsrsScheduler.review]
/// returns a new instance.
class SchedulingCard {
  const SchedulingCard({
    required this.phase,
    required this.step,
    required this.stability,
    required this.difficulty,
    required this.due,
    required this.lastReview,
  });

  /// A card that has never been reviewed, due immediately at [createdAt].
  SchedulingCard.fresh(DateTime createdAt)
    : phase = CardPhase.learning,
      step = 0,
      stability = null,
      difficulty = null,
      due = createdAt.toUtc(),
      lastReview = null;

  final CardPhase phase;

  /// Index into the learning or relearning steps; `null` in [CardPhase.review].
  final int? step;

  /// Days until retrievability drops to 90%; `null` before the first review.
  final double? stability;

  /// 1 (easiest) to 10 (hardest); `null` before the first review.
  final double? difficulty;

  final DateTime due;
  final DateTime? lastReview;

  bool get isNew => lastReview == null;

  @override
  String toString() =>
      'SchedulingCard(phase: $phase, step: $step, stability: $stability, '
      'difficulty: $difficulty, due: $due, lastReview: $lastReview)';
}

class FsrsParameters {
  const FsrsParameters({
    this.weights = defaultWeights,
    this.desiredRetention = 0.9,
    this.learningSteps = const [Duration(minutes: 1), Duration(minutes: 10)],
    this.relearningSteps = const [Duration(minutes: 10)],
    this.maximumIntervalDays = 36500,
  }) : assert(
         desiredRetention > 0 && desiredRetention < 1,
         'desiredRetention must be in (0, 1)',
       );

  static const defaultWeights = <double>[
    0.212,
    1.2931,
    2.3065,
    8.2956,
    6.4133,
    0.8334,
    3.0194,
    0.001,
    1.8722,
    0.1666,
    0.796,
    1.4835,
    0.0614,
    0.2629,
    1.6483,
    0.6014,
    1.8729,
    0.5425,
    0.0912,
    0.0658,
    0.1542,
  ];

  final List<double> weights;
  final double desiredRetention;
  final List<Duration> learningSteps;
  final List<Duration> relearningSteps;
  final int maximumIntervalDays;

  FsrsParameters copyWith({double? desiredRetention}) => FsrsParameters(
    weights: weights,
    desiredRetention: desiredRetention ?? this.desiredRetention,
    learningSteps: learningSteps,
    relearningSteps: relearningSteps,
    maximumIntervalDays: maximumIntervalDays,
  );
}

class FsrsScheduler {
  FsrsScheduler([this.parameters = const FsrsParameters()])
    : _decay = -parameters.weights[20],
      _factor = math.pow(0.9, 1 / -parameters.weights[20]) - 1 {
    if (parameters.weights.length != 21) {
      throw ArgumentError.value(
        parameters.weights.length,
        'parameters.weights.length',
        'FSRS-6 requires exactly 21 weights',
      );
    }
  }

  static const _minStability = 0.001;
  static const _minDifficulty = 1.0;
  static const _maxDifficulty = 10.0;

  final FsrsParameters parameters;
  final double _decay;
  final double _factor;

  List<double> get _w => parameters.weights;

  /// Probability of recalling [card] at [now]; 0 for unreviewed cards.
  double retrievability(SchedulingCard card, DateTime now) {
    final lastReview = card.lastReview;
    final stability = card.stability;
    if (lastReview == null || stability == null) return 0;

    final elapsedDays = math.max(0, _wholeDaysBetween(lastReview, now));
    return math.pow(1 + _factor * elapsedDays / stability, _decay).toDouble();
  }

  /// Applies [rating] given at [reviewedAt] and returns the next state.
  SchedulingCard review(
    SchedulingCard card,
    Rating rating,
    DateTime reviewedAt,
  ) {
    final now = reviewedAt.toUtc();
    final lastReview = card.lastReview;
    final daysSinceLastReview = lastReview == null
        ? null
        : _wholeDaysBetween(lastReview, now);
    final sameDay = daysSinceLastReview != null && daysSinceLastReview < 1;

    final double stability;
    final double difficulty;
    final previousStability = card.stability;
    final previousDifficulty = card.difficulty;

    if (previousStability == null || previousDifficulty == null) {
      stability = _initialStability(rating);
      difficulty = _clampDifficulty(_initialDifficulty(rating));
    } else {
      stability = sameDay
          ? _shortTermStability(previousStability, rating)
          : _nextStability(
              difficulty: previousDifficulty,
              stability: previousStability,
              retrievability: retrievability(card, now),
              rating: rating,
            );
      difficulty = _nextDifficulty(previousDifficulty, rating);
    }

    final (phase, step, interval) = switch (card.phase) {
      CardPhase.learning => _stepTransition(
        steps: parameters.learningSteps,
        step: card.step ?? 0,
        rating: rating,
        stability: stability,
        phase: CardPhase.learning,
      ),
      CardPhase.relearning => _stepTransition(
        steps: parameters.relearningSteps,
        step: card.step ?? 0,
        rating: rating,
        stability: stability,
        phase: CardPhase.relearning,
      ),
      CardPhase.review => _reviewTransition(rating, stability),
    };

    return SchedulingCard(
      phase: phase,
      step: step,
      stability: stability,
      difficulty: difficulty,
      due: now.add(interval),
      lastReview: now,
    );
  }

  /// Next state for every rating, used to label the rating buttons.
  Map<Rating, SchedulingCard> preview(SchedulingCard card, DateTime at) => {
    for (final rating in Rating.values) rating: review(card, rating, at),
  };

  (CardPhase, int?, Duration) _reviewTransition(
    Rating rating,
    double stability,
  ) {
    if (rating == Rating.again && parameters.relearningSteps.isNotEmpty) {
      return (CardPhase.relearning, 0, parameters.relearningSteps.first);
    }
    return (CardPhase.review, null, _reviewInterval(stability));
  }

  (CardPhase, int?, Duration) _stepTransition({
    required List<Duration> steps,
    required int step,
    required Rating rating,
    required double stability,
    required CardPhase phase,
  }) {
    final graduate = (CardPhase.review, null, _reviewInterval(stability));

    // Also covers cards scheduled under a configuration with more steps.
    if (steps.isEmpty || (step >= steps.length && rating != Rating.again)) {
      return graduate;
    }

    switch (rating) {
      case Rating.again:
        return (phase, 0, steps.first);
      case Rating.hard:
        final Duration interval;
        if (step == 0 && steps.length == 1) {
          interval = steps.first * 1.5;
        } else if (step == 0) {
          interval = (steps[0] + steps[1]) ~/ 2;
        } else {
          interval = steps[step];
        }
        return (phase, step, interval);
      case Rating.good:
        if (step + 1 == steps.length) return graduate;
        return (phase, step + 1, steps[step + 1]);
      case Rating.easy:
        return graduate;
    }
  }

  Duration _reviewInterval(double stability) {
    final raw =
        stability /
        _factor *
        (math.pow(parameters.desiredRetention, 1 / _decay) - 1);
    final days = _roundHalfToEven(raw).clamp(1, parameters.maximumIntervalDays);
    return Duration(days: days);
  }

  double _initialStability(Rating rating) =>
      math.max(_w[rating.value - 1], _minStability);

  double _initialDifficulty(Rating rating) =>
      _w[4] - math.exp(_w[5] * (rating.value - 1)) + 1;

  double _shortTermStability(double stability, Rating rating) {
    var increase =
        math.exp(_w[17] * (rating.value - 3 + _w[18])) *
        math.pow(stability, -_w[19]);
    if (rating != Rating.again) increase = math.max(increase, 1.0);
    return math.max(stability * increase, _minStability);
  }

  double _nextDifficulty(double difficulty, Rating rating) {
    final delta = -(_w[6] * (rating.value - 3));
    final damped = difficulty + (10.0 - difficulty) * delta / 9.0;
    final reverted =
        _w[7] * _initialDifficulty(Rating.easy) + (1 - _w[7]) * damped;
    return _clampDifficulty(reverted);
  }

  double _nextStability({
    required double difficulty,
    required double stability,
    required double retrievability,
    required Rating rating,
  }) {
    final next = rating == Rating.again
        ? _forgetStability(difficulty, stability, retrievability)
        : _recallStability(difficulty, stability, retrievability, rating);
    return math.max(next, _minStability);
  }

  double _forgetStability(
    double difficulty,
    double stability,
    double retrievability,
  ) {
    final longTerm =
        _w[11] *
        math.pow(difficulty, -_w[12]) *
        (math.pow(stability + 1, _w[13]) - 1) *
        math.exp((1 - retrievability) * _w[14]);
    final shortTerm = stability / math.exp(_w[17] * _w[18]);
    return math.min(longTerm, shortTerm);
  }

  double _recallStability(
    double difficulty,
    double stability,
    double retrievability,
    Rating rating,
  ) {
    final hardPenalty = rating == Rating.hard ? _w[15] : 1.0;
    final easyBonus = rating == Rating.easy ? _w[16] : 1.0;
    return stability *
        (1 +
            math.exp(_w[8]) *
                (11 - difficulty) *
                math.pow(stability, -_w[9]) *
                (math.exp((1 - retrievability) * _w[10]) - 1) *
                hardPenalty *
                easyBonus);
  }

  static double _clampDifficulty(double difficulty) =>
      difficulty.clamp(_minDifficulty, _maxDifficulty);

  /// Floor of the elapsed whole days, matching Python's `timedelta.days`.
  static int _wholeDaysBetween(DateTime from, DateTime to) {
    final micros = to.difference(from).inMicroseconds;
    return (micros / Duration.microsecondsPerDay).floor();
  }

  /// Python's `round()`: ties go to the even neighbour.
  static int _roundHalfToEven(double value) {
    final floor = value.floorToDouble();
    final diff = value - floor;
    if (diff < 0.5) return floor.toInt();
    if (diff > 0.5) return floor.toInt() + 1;
    return floor.toInt().isEven ? floor.toInt() : floor.toInt() + 1;
  }
}

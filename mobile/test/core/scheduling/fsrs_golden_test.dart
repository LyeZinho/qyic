import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:qyic/core/scheduling/fsrs.dart';

/// Replays the cross-client vectors generated from py-fsrs
/// (`shared/fsrs/generate_vectors.py`).
void main() {
  final file = File('../shared/fsrs/vectors.json');
  final vectors = jsonDecode(file.readAsStringSync()) as Map<String, dynamic>;
  final scenarios = (vectors['scenarios'] as List).cast<Map<String, dynamic>>();

  DateTime utc(int ms) => DateTime.fromMillisecondsSinceEpoch(ms, isUtc: true);

  Matcher closeToRelative(double expected) =>
      closeTo(expected, expected.abs() * 1e-9 + 1e-12);

  for (final scenario in scenarios) {
    test('FSRS vector: ${scenario['name']}', () {
      final scheduler = FsrsScheduler(
        FsrsParameters(
          desiredRetention: (scenario['desired_retention'] as num).toDouble(),
        ),
      );
      var card = SchedulingCard.fresh(utc(scenario['created_at_ms'] as int));

      final reviews = (scenario['reviews'] as List)
          .cast<Map<String, dynamic>>();
      for (final (index, review) in reviews.indexed) {
        card = scheduler.review(
          card,
          Rating.fromValue(review['rating'] as int),
          utc(review['reviewed_at_ms'] as int),
        );
        final expected = review['expected'] as Map<String, dynamic>;
        final reason = 'review #$index';

        expect(card.phase.value, expected['phase'], reason: reason);
        expect(card.step, expected['step'], reason: reason);
        expect(
          card.stability,
          closeToRelative((expected['stability'] as num).toDouble()),
          reason: reason,
        );
        expect(
          card.difficulty,
          closeToRelative((expected['difficulty'] as num).toDouble()),
          reason: reason,
        );
        expect(
          card.due.millisecondsSinceEpoch,
          expected['due_ms'],
          reason: reason,
        );
        expect(
          card.lastReview!.millisecondsSinceEpoch,
          expected['last_review_ms'],
          reason: reason,
        );
      }
    });
  }

  test('preview yields one next state per rating', () {
    final scheduler = FsrsScheduler();
    final now = DateTime.utc(2026, 1, 1);
    final preview = scheduler.preview(SchedulingCard.fresh(now), now);

    expect(preview.keys, Rating.values);
    expect(preview[Rating.again]!.due, now.add(const Duration(minutes: 1)));
    expect(preview[Rating.easy]!.phase, CardPhase.review);
  });
}

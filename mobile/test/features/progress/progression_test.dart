import 'package:flutter_test/flutter_test.dart';
import 'package:qyic/core/scheduling/fsrs.dart';
import 'package:qyic/features/progress/domain/progression.dart';

void main() {
  test('XP: recalls earn more than lapses', () {
    expect(
      Progression.xpFromCounts({
        Rating.again: 2,
        Rating.good: 3,
        Rating.easy: 1,
      }),
      2 * Progression.xpPerLapse + 4 * Progression.xpPerRecall,
    );
  });

  test('levels need 100 × level XP each', () {
    expect(Progression.levelFor(0).level, 1);
    expect(Progression.levelFor(99).level, 1);
    expect(Progression.levelFor(100).level, 2);
    final level3 = Progression.levelFor(350);
    expect(level3.level, 3);
    expect(level3.xpIntoLevel, 50);
    expect(level3.xpForLevel, 300);
  });

  group('streak', () {
    DateTime day(int d) => DateTime.utc(2026, 3, d);
    final today = DateTime(2026, 3, 10, 21);

    test('counts consecutive days ending today', () {
      expect(Progression.streak({day(8), day(9), day(10)}, today), 3);
    });

    test('stays alive until today is studied', () {
      expect(Progression.streak({day(8), day(9)}, today), 2);
    });

    test('breaks on a missed day', () {
      expect(Progression.streak({day(7), day(10)}, today), 1);
      expect(Progression.streak({day(7), day(8)}, today), 0);
    });

    test('crosses month boundaries', () {
      final march1 = DateTime(2026, 3, 1, 9);
      expect(
        Progression.streak({
          DateTime.utc(2026, 2, 28),
          DateTime.utc(2026, 3, 1),
        }, march1),
        2,
      );
    });
  });
}

import '../../../core/scheduling/fsrs.dart';

/// Gamification rules derived purely from review events. Provisional until
/// the M3 ADR; specified in `docs/progression.md`.
abstract final class Progression {
  static const xpPerRecall = 15;
  static const xpPerLapse = 5;

  static int xpFor(Rating rating) =>
      rating == Rating.again ? xpPerLapse : xpPerRecall;

  static int xpFromCounts(Map<Rating, int> reviewsByRating) => reviewsByRating
      .entries
      .fold(0, (total, entry) => total + xpFor(entry.key) * entry.value);

  /// XP needed to advance from [level] to the next one.
  static int xpToAdvance(int level) => 100 * level;

  static LevelProgress levelFor(int totalXp) {
    var level = 1;
    var remaining = totalXp;
    while (remaining >= xpToAdvance(level)) {
      remaining -= xpToAdvance(level);
      level++;
    }
    return LevelProgress(
      level: level,
      xpIntoLevel: remaining,
      xpForLevel: xpToAdvance(level),
    );
  }

  /// Consecutive local calendar days with at least one review, ending today,
  /// or yesterday when today has no review yet.
  static int streak(Set<DateTime> reviewDays, DateTime today) {
    var cursor = _day(today);
    if (!reviewDays.contains(cursor)) {
      cursor = _previousDay(cursor);
    }
    var streak = 0;
    while (reviewDays.contains(cursor)) {
      streak++;
      cursor = _previousDay(cursor);
    }
    return streak;
  }

  static DateTime _day(DateTime moment) =>
      DateTime.utc(moment.year, moment.month, moment.day);

  static DateTime _previousDay(DateTime day) =>
      DateTime.utc(day.year, day.month, day.day - 1);
}

class LevelProgress {
  const LevelProgress({
    required this.level,
    required this.xpIntoLevel,
    required this.xpForLevel,
  });

  final int level;
  final int xpIntoLevel;
  final int xpForLevel;

  double get fraction => xpIntoLevel / xpForLevel;
}

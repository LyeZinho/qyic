import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/app_database.dart';
import '../../../core/providers.dart';
import '../../../core/scheduling/fsrs.dart';
import '../domain/progression.dart';

class ProgressSnapshot {
  const ProgressSnapshot({
    required this.totalXp,
    required this.level,
    required this.streakDays,
    required this.reviewsToday,
    required this.totalReviews,
    required this.averageReviewDuration,
  });

  /// Recent reviews averaged for [averageReviewDuration].
  static const durationSampleSize = 200;

  final int totalXp;
  final LevelProgress level;
  final int streakDays;
  final int reviewsToday;

  /// Review events stored on this device.
  final int totalReviews;

  /// Mean time per review over the latest [durationSampleSize] reviews;
  /// null without history.
  final Duration? averageReviewDuration;
}

class ProgressRepository {
  ProgressRepository(this._db);

  final AppDatabase _db;

  /// [now] is local time; days are local calendar days.
  Stream<ProgressSnapshot> watch(DateTime now) => _db
      .customSelect(
        'SELECT COUNT(*) AS n FROM review_events',
        readsFrom: {_db.reviewEvents},
      )
      .watchSingle()
      .asyncMap((_) => load(now));

  Future<ProgressSnapshot> load(DateTime now) async {
    final byRating = await _db
        .customSelect(
          'SELECT rating, COUNT(*) AS n FROM review_events GROUP BY rating',
        )
        .get();
    final counts = {
      for (final row in byRating)
        Rating.fromValue(row.read<int>('rating')): row.read<int>('n'),
    };

    final days = await _db
        .customSelect(
          "SELECT DISTINCT date(reviewed_at_ms / 1000, 'unixepoch', "
          "'localtime') AS day FROM review_events",
        )
        .get();
    final reviewDays = {
      for (final row in days) _parseDay(row.read<String>('day')),
    };

    final startOfToday = DateTime(now.year, now.month, now.day);
    final today = await _db
        .customSelect(
          'SELECT COUNT(*) AS n FROM review_events WHERE reviewed_at_ms >= ?1',
          variables: [Variable.withInt(startOfToday.millisecondsSinceEpoch)],
        )
        .getSingle();

    final pace = await _db
        .customSelect(
          'SELECT AVG(duration_ms) AS avg FROM (SELECT duration_ms '
          'FROM review_events ORDER BY id DESC LIMIT ?1)',
          variables: [Variable.withInt(ProgressSnapshot.durationSampleSize)],
        )
        .getSingle();
    final averageMs = pace.readNullable<double>('avg');

    final totalXp = Progression.xpFromCounts(counts);
    return ProgressSnapshot(
      totalXp: totalXp,
      level: Progression.levelFor(totalXp),
      streakDays: Progression.streak(reviewDays, now),
      reviewsToday: today.read<int>('n'),
      totalReviews: counts.values.fold(0, (sum, n) => sum + n),
      averageReviewDuration: averageMs == null
          ? null
          : Duration(milliseconds: averageMs.round()),
    );
  }

  /// SQLite `date()` output (`YYYY-MM-DD`) as a date-only UTC key.
  static DateTime _parseDay(String value) {
    final [year, month, day] = value.split('-').map(int.parse).toList();
    return DateTime.utc(year, month, day);
  }
}

final progressRepositoryProvider = Provider<ProgressRepository>(
  (ref) => ProgressRepository(ref.watch(databaseProvider)),
);

final progressProvider = StreamProvider.autoDispose<ProgressSnapshot>(
  (ref) => ref.watch(progressRepositoryProvider).watch(watchNow(ref)),
);

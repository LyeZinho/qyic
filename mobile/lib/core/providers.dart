import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'database/app_database.dart';

typedef Clock = DateTime Function();

/// Overridden in `main` with the opened database and in tests with an
/// in-memory one.
final databaseProvider = Provider<AppDatabase>(
  (ref) => throw UnimplementedError('databaseProvider must be overridden'),
);

final clockProvider = Provider<Clock>((ref) => DateTime.now);

/// Emits once a minute so time-dependent views (due counts, "today") refresh
/// while the app stays open.
final minuteTickProvider = StreamProvider<DateTime>((ref) {
  final clock = ref.watch(clockProvider);
  return Stream.periodic(const Duration(minutes: 1), (_) => clock());
});

/// Current time for provider bodies; re-runs the caller every minute.
DateTime watchNow(Ref ref) =>
    ref.watch(minuteTickProvider).value ?? ref.read(clockProvider)();

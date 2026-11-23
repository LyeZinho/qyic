import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:path_provider/path_provider.dart';

import 'app_database.steps.dart';
import 'tables.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [
    Decks,
    Quizzes,
    QuizOptions,
    CardStates,
    ReviewEvents,
    Settings,
    Reminders,
    ExamPresets,
    ExamPresetDecks,
    ExamRuns,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase(super.executor);

  /// The on-device database, stored in the app-support directory (not the
  /// user-visible documents folder).
  factory AppDatabase.open() => AppDatabase(
    driftDatabase(
      name: 'qyic',
      native: const DriftNativeOptions(
        databaseDirectory: getApplicationSupportDirectory,
      ),
    ),
  );

  // Schema changes: bump this, run `dart run drift_dev make-migrations`, and
  // add the step below. Shipped steps are never edited (AGENTS.md invariant 8).
  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (migrator) => migrator.createAll(),
    onUpgrade: stepByStep(
      from1To2: (migrator, schema) async {
        await migrator.addColumn(schema.quizzes, schema.quizzes.hint);
        await migrator.addColumn(schema.reviewEvents, schema.reviewEvents.mode);
        await migrator.createTable(schema.reminders);
        await migrator.createTable(schema.examPresets);
        await migrator.createTable(schema.examPresetDecks);
        await migrator.createTable(schema.examRuns);
        await migrator.createIndex(schema.examRunsStartedIdx);
      },
    ),
    beforeOpen: (details) async {
      await customStatement('PRAGMA foreign_keys = ON');
    },
  );

  /// Bytes used by the database file (pages × page size).
  Future<int> sizeInBytes() async {
    final row = await customSelect(
      'SELECT page_count * page_size AS size '
      'FROM pragma_page_count(), pragma_page_size()',
    ).getSingle();
    return row.read<int>('size');
  }
}

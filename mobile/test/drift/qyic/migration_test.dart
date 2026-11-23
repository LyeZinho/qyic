// dart format width=80
// ignore_for_file: unused_local_variable, unused_import
import 'package:drift/drift.dart';
import 'package:drift_dev/api/migrations_native.dart';
import 'package:qyic/core/database/app_database.dart';
import 'package:flutter_test/flutter_test.dart';
import 'generated/schema.dart';

import 'generated/schema_v1.dart' as v1;
import 'generated/schema_v2.dart' as v2;

void main() {
  driftRuntimeOptions.dontWarnAboutMultipleDatabases = true;
  late SchemaVerifier verifier;

  setUpAll(() {
    verifier = SchemaVerifier(GeneratedHelper());
  });

  group('simple database migrations', () {
    // These simple tests verify all possible schema updates with a simple (no
    // data) migration. This is a quick way to ensure that written database
    // migrations properly alter the schema.
    const versions = GeneratedHelper.versions;
    for (final (i, fromVersion) in versions.indexed) {
      group('from $fromVersion', () {
        for (final toVersion in versions.skip(i + 1)) {
          test('to $toVersion', () async {
            final schema = await verifier.schemaAt(fromVersion);
            final db = AppDatabase(schema.newConnection());
            await verifier.migrateAndValidate(db, toVersion);
            await db.close();
          });
        }
      });
    }
  });

  test('migration from v1 to v2 keeps data and fills new defaults', () async {
    const deckId = 'd0000000-0000-4000-8000-000000000001';
    const quizId = 'q0000000-0000-4000-8000-000000000001';

    final oldDecksData = [
      const v1.DecksData(
        id: deckId,
        title: 'Deck',
        description: '',
        author: '',
        locale: 'en',
        version: 1,
        createdAtMs: 1,
        updatedAtMs: 1,
      ),
    ];
    final expectedNewDecksData = [
      const v2.DecksData(
        id: deckId,
        title: 'Deck',
        description: '',
        author: '',
        locale: 'en',
        version: 1,
        createdAtMs: 1,
        updatedAtMs: 1,
      ),
    ];

    final oldQuizzesData = [
      const v1.QuizzesData(
        id: quizId,
        deckId: deckId,
        type: 5,
        position: 0,
        question: 'Front',
        explanation: 'Back',
        createdAtMs: 1,
        updatedAtMs: 1,
      ),
    ];
    final expectedNewQuizzesData = [
      const v2.QuizzesData(
        id: quizId,
        deckId: deckId,
        type: 5,
        position: 0,
        question: 'Front',
        explanation: 'Back',
        hint: '',
        createdAtMs: 1,
        updatedAtMs: 1,
      ),
    ];

    final oldQuizOptionsData = <v1.QuizOptionsData>[];
    final expectedNewQuizOptionsData = <v2.QuizOptionsData>[];

    final oldCardStatesData = <v1.CardStatesData>[];
    final expectedNewCardStatesData = <v2.CardStatesData>[];

    final oldReviewEventsData = [
      const v1.ReviewEventsData(
        id: 1,
        clientId: 'client',
        clientSeq: 1,
        quizId: quizId,
        deckId: deckId,
        rating: 3,
        reviewedAtMs: 2,
        durationMs: 1000,
      ),
    ];
    final expectedNewReviewEventsData = [
      const v2.ReviewEventsData(
        id: 1,
        clientId: 'client',
        clientSeq: 1,
        quizId: quizId,
        deckId: deckId,
        rating: 3,
        reviewedAtMs: 2,
        durationMs: 1000,
        mode: 1,
      ),
    ];

    final oldSettingsData = [
      const v1.SettingsData(key: 'daily_goal', value: '40'),
    ];
    final expectedNewSettingsData = [
      const v2.SettingsData(key: 'daily_goal', value: '40'),
    ];

    await verifier.testWithDataIntegrity(
      oldVersion: 1,
      newVersion: 2,
      createOld: v1.DatabaseAtV1.new,
      createNew: v2.DatabaseAtV2.new,
      openTestedDatabase: AppDatabase.new,
      createItems: (batch, oldDb) {
        batch.insertAll(oldDb.decks, oldDecksData);
        batch.insertAll(oldDb.quizzes, oldQuizzesData);
        batch.insertAll(oldDb.quizOptions, oldQuizOptionsData);
        batch.insertAll(oldDb.cardStates, oldCardStatesData);
        batch.insertAll(oldDb.reviewEvents, oldReviewEventsData);
        batch.insertAll(oldDb.settings, oldSettingsData);
      },
      validateItems: (newDb) async {
        expect(expectedNewDecksData, await newDb.select(newDb.decks).get());
        expect(expectedNewQuizzesData, await newDb.select(newDb.quizzes).get());
        expect(
          expectedNewQuizOptionsData,
          await newDb.select(newDb.quizOptions).get(),
        );
        expect(
          expectedNewCardStatesData,
          await newDb.select(newDb.cardStates).get(),
        );
        expect(
          expectedNewReviewEventsData,
          await newDb.select(newDb.reviewEvents).get(),
        );
        expect(
          expectedNewSettingsData,
          await newDb.select(newDb.settings).get(),
        );
      },
    );
  });
}

import 'package:drift/drift.dart';

// Timestamps are UTC epoch milliseconds, matching `*_unix_ms` in the protos.
// Enum columns store protobuf / scheduler integer values, never Dart indexes.

/// Installed deck content. `deleted_at_ms` is a sync tombstone (ADR-0006).
@DataClassName('DeckRow')
class Decks extends Table {
  TextColumn get id => text()();
  TextColumn get title => text()();
  TextColumn get description => text().withDefault(const Constant(''))();
  TextColumn get author => text().withDefault(const Constant(''))();
  TextColumn get locale => text().withDefault(const Constant('en'))();
  IntColumn get version => integer().withDefault(const Constant(1))();
  IntColumn get createdAtMs => integer()();
  IntColumn get updatedAtMs => integer()();
  IntColumn get deletedAtMs => integer().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DataClassName('QuizRow')
@TableIndex(name: 'quizzes_deck_position_idx', columns: {#deckId, #position})
class Quizzes extends Table {
  TextColumn get id => text()();
  TextColumn get deckId => text().references(Decks, #id)();

  /// `qyic.v1.QuizType` value.
  IntColumn get type => integer()();
  IntColumn get position => integer()();
  TextColumn get question => text()();
  TextColumn get explanation => text().withDefault(const Constant(''))();

  /// Secondary context shown with the question (schema v2).
  TextColumn get hint => text().withDefault(const Constant(''))();
  IntColumn get createdAtMs => integer()();
  IntColumn get updatedAtMs => integer()();
  IntColumn get deletedAtMs => integer().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DataClassName('QuizOptionRow')
class QuizOptions extends Table {
  TextColumn get quizId =>
      text().references(Quizzes, #id, onDelete: KeyAction.cascade)();
  TextColumn get id => text()();
  IntColumn get position => integer()();
  TextColumn get body => text().named('text')();
  TextColumn get prompt => text().withDefault(const Constant(''))();
  TextColumn get mediaPath => text().withDefault(const Constant(''))();
  BoolColumn get isCorrect => boolean().withDefault(const Constant(false))();

  @override
  Set<Column<Object>> get primaryKey => {quizId, id};
}

/// Current FSRS state per quiz, derived from [ReviewEvents] and updated in the
/// same transaction that appends an event.
@DataClassName('CardStateRow')
@TableIndex(name: 'card_states_deck_due_idx', columns: {#deckId, #dueAtMs})
class CardStates extends Table {
  TextColumn get quizId =>
      text().references(Quizzes, #id, onDelete: KeyAction.cascade)();
  TextColumn get deckId => text().references(Decks, #id)();

  /// `CardPhase` value.
  IntColumn get phase => integer()();
  IntColumn get step => integer().nullable()();
  RealColumn get stability => real().nullable()();
  RealColumn get difficulty => real().nullable()();
  IntColumn get dueAtMs => integer()();
  IntColumn get lastReviewedAtMs => integer().nullable()();
  IntColumn get reps => integer().withDefault(const Constant(0))();
  IntColumn get lapses => integer().withDefault(const Constant(0))();

  @override
  Set<Column<Object>> get primaryKey => {quizId};
}

/// Append-only review history; rows mirror `qyic.v1.ReviewEvent`.
/// `quiz_id` / `deck_id` are deliberately not foreign keys: events outlive
/// the content they reference.
@DataClassName('ReviewEventRow')
@TableIndex(name: 'review_events_reviewed_at_idx', columns: {#reviewedAtMs})
@TableIndex(name: 'review_events_quiz_idx', columns: {#quizId, #reviewedAtMs})
class ReviewEvents extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get clientId => text()();
  IntColumn get clientSeq => integer()();
  TextColumn get quizId => text()();
  TextColumn get deckId => text()();

  /// `qyic.v1.ReviewRating` value.
  IntColumn get rating => integer()();
  IntColumn get reviewedAtMs => integer()();
  IntColumn get durationMs => integer()();

  /// `qyic.v1.ReviewMode` value (schema v2).
  IntColumn get mode => integer().withDefault(const Constant(1))();

  @override
  List<Set<Column<Object>>> get uniqueKeys => [
    {clientId, clientSeq},
  ];
}

/// Local study reminders. Device-specific, never synced.
@DataClassName('ReminderRow')
class Reminders extends Table {
  IntColumn get id => integer().autoIncrement()();

  /// Local wall-clock time, minutes after midnight.
  IntColumn get minuteOfDay => integer()();

  /// Bit `n` set = weekday `n + 1` (`DateTime.monday` … `DateTime.sunday`).
  IntColumn get weekdays => integer()();
  BoolColumn get enabled => boolean().withDefault(const Constant(true))();
}

/// Saved exam configurations.
@DataClassName('ExamPresetRow')
class ExamPresets extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();

  /// `ExamSelection` value.
  IntColumn get selection => integer()();
  IntColumn get questionCount => integer()();

  /// Whole-exam limit; 0 = untimed.
  IntColumn get timeLimitSeconds => integer()();

  /// Per-question limit; 0 = untimed.
  IntColumn get secondsPerQuestion => integer()();

  /// Bit `1 << QuizType.value` per included quiz type.
  IntColumn get quizTypes => integer()();
  BoolColumn get includeNew => boolean()();
  BoolColumn get autoRate => boolean()();
  BoolColumn get allowHints => boolean()();
  IntColumn get createdAtMs => integer()();
  IntColumn get updatedAtMs => integer()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

/// Decks an exam preset draws from; none = every deck.
@DataClassName('ExamPresetDeckRow')
class ExamPresetDecks extends Table {
  TextColumn get presetId =>
      text().references(ExamPresets, #id, onDelete: KeyAction.cascade)();
  TextColumn get deckId => text().references(Decks, #id)();

  @override
  Set<Column<Object>> get primaryKey => {presetId, deckId};
}

/// Finished exams. `preset_id` is not a foreign key: history outlives presets.
@DataClassName('ExamRunRow')
@TableIndex(name: 'exam_runs_started_idx', columns: {#startedAtMs})
class ExamRuns extends Table {
  TextColumn get id => text()();
  TextColumn get presetId => text().nullable()();
  TextColumn get name => text()();
  IntColumn get startedAtMs => integer()();
  IntColumn get finishedAtMs => integer()();
  IntColumn get questionCount => integer()();
  IntColumn get answeredCount => integer()();
  IntColumn get correctCount => integer()();

  /// `ExamEndReason` value.
  IntColumn get endReason => integer()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DataClassName('SettingRow')
class Settings extends Table {
  TextColumn get key => text()();
  TextColumn get value => text()();

  @override
  Set<Column<Object>> get primaryKey => {key};
}

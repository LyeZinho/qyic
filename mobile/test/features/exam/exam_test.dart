import 'dart:math' as math;

import 'package:flutter_test/flutter_test.dart';
import 'package:qyic/core/scheduling/fsrs.dart';
import 'package:qyic/features/decks/domain/deck.dart';
import 'package:qyic/features/exam/data/exam_repository.dart';
import 'package:qyic/features/exam/domain/exam.dart';
import 'package:qyic/features/study/domain/grading.dart';

void main() {
  group('autoRating', () {
    const limit = Duration(seconds: 30);

    test('wrong answers are Again regardless of speed', () {
      expect(
        autoRating(GradeOutcome.incorrect, Duration.zero, limit),
        Rating.again,
      );
    });

    test('correct answers within half the limit are Good, slower are Hard', () {
      expect(
        autoRating(GradeOutcome.correct, const Duration(seconds: 15), limit),
        Rating.good,
      );
      expect(
        autoRating(GradeOutcome.correct, const Duration(seconds: 16), limit),
        Rating.hard,
      );
    });

    test('untimed exams use the fluent answer time', () {
      expect(
        autoRating(GradeOutcome.correct, fluentAnswerTime, null),
        Rating.good,
      );
      expect(
        autoRating(
          GradeOutcome.correct,
          fluentAnswerTime + const Duration(milliseconds: 1),
          null,
        ),
        Rating.hard,
      );
    });

    test('self-graded answers are left to the learner', () {
      expect(autoRating(GradeOutcome.selfGraded, Duration.zero, limit), isNull);
    });
  });

  group('ExamPreset', () {
    test('is value-equal regardless of set order', () {
      const a = ExamPreset(
        name: 'Mock',
        deckIds: {'x', 'y'},
        quizTypes: {QuizType.matching, QuizType.trueFalse},
      );
      const b = ExamPreset(
        name: 'Mock',
        deckIds: {'y', 'x'},
        quizTypes: {QuizType.trueFalse, QuizType.matching},
      );
      expect(a, b);
      expect(a.hashCode, b.hashCode);
      expect(a.copyWith(includeNew: true), isNot(a));
    });

    test('copyWith can clear and set nullable durations', () {
      const preset = ExamPreset(name: 'Mock', timeLimit: Duration(minutes: 5));
      expect(preset.copyWith(timeLimit: () => null).timeLimit, isNull);
      expect(
        preset.copyWith(timePerQuestion: () => null).timePerQuestion,
        isNull,
      );
      expect(preset.copyWith(name: 'Other').timeLimit, preset.timeLimit);
    });

    test('validate reports every problem', () {
      expect(const ExamPreset(name: 'Mock').validate(), isEmpty);
      expect(
        const ExamPreset(name: ' ', questionCount: 2, quizTypes: {}).validate(),
        [
          ExamPresetIssue.emptyName,
          ExamPresetIssue.noQuizTypes,
          ExamPresetIssue.questionCount,
        ],
      );
      expect(const ExamPreset(name: 'Mock', questionCount: 201).validate(), [
        ExamPresetIssue.questionCount,
      ]);
    });
  });

  test('quiz type masks round-trip', () {
    for (final types in [
      <QuizType>{},
      ExamPreset.defaultQuizTypes,
      QuizType.values.toSet(),
      {QuizType.flashcard},
    ]) {
      expect(
        ExamRepository.quizTypesFromMask(ExamRepository.quizTypeMask(types)),
        types,
      );
    }
  });

  group('deckExamQuestionCount', () {
    test('draws at least 100 from a large deck, up to the whole deck', () {
      final random = math.Random(1);
      final counts = [
        for (var i = 0; i < 40; i++) deckExamQuestionCount(3200, random),
      ];
      expect(counts.every((n) => n >= 100 && n <= 3200), isTrue);
      expect(counts.toSet().length, greaterThan(1));
      expect(deckExamQuestionCount(100, random), 100);
    });

    test('asks half a small deck, rounded up', () {
      expect(deckExamQuestionCount(16, math.Random(0)), 8);
      expect(deckExamQuestionCount(15, math.Random(0)), 8);
      expect(deckExamQuestionCount(1, math.Random(0)), 1);
    });
  });

  test('ExamRun score counts unanswered questions as missed', () {
    final run = ExamRun(
      id: 'r',
      presetId: null,
      name: 'Quick exam',
      startedAt: DateTime.utc(2026),
      finishedAt: DateTime.utc(2026, 1, 1, 0, 5),
      questionCount: 10,
      answeredCount: 6,
      correctCount: 3,
      endReason: ExamEndReason.timeUp,
    );
    expect(run.score, 0.3);
    expect(run.duration, const Duration(minutes: 5));
  });
}

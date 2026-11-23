import 'package:flutter/foundation.dart';

import '../../decks/domain/deck.dart';

/// Which cards a normal study session draws. Exam length is separate.
enum StudyScope {
  /// Due and new cards of every type.
  mixed,

  /// Question types only. Flashcards stay out.
  quizzes,

  /// Flashcards only.
  flashcards;

  /// Null means every type.
  Set<QuizType>? get quizTypes => switch (this) {
    StudyScope.mixed => null,
    StudyScope.quizzes => {
      for (final type in QuizType.values)
        if (type != QuizType.flashcard) type,
    },
    StudyScope.flashcards => const {QuizType.flashcard},
  };
}

/// What one study session is about. Value-equal, so it can key providers.
@immutable
class StudyRequest {
  const StudyRequest({this.deckId, this.scope = StudyScope.mixed});

  /// Null studies every deck.
  final String? deckId;
  final StudyScope scope;

  @override
  bool operator ==(Object other) =>
      other is StudyRequest && other.deckId == deckId && other.scope == scope;

  @override
  int get hashCode => Object.hash(deckId, scope);
}

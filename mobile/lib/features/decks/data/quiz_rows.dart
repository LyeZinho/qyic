import '../../../core/database/app_database.dart';
import '../domain/deck.dart';

/// Maps a stored quiz and its options (in position order) to the domain model.
Quiz quizFromRows(QuizRow row, Iterable<QuizOptionRow> options) => Quiz(
  id: row.id,
  deckId: row.deckId,
  type: QuizType.fromValue(row.type),
  position: row.position,
  question: row.question,
  hint: row.hint,
  explanation: row.explanation,
  options: [
    for (final option in options)
      QuizOption(
        id: option.id,
        text: option.body,
        prompt: option.prompt,
        mediaPath: option.mediaPath,
        isCorrect: option.isCorrect,
      ),
  ],
);

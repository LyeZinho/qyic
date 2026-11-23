/// Deck content models. Field semantics mirror `qyic.v1.Deck`, `qyic.v1.Quiz`
/// and `qyic.v1.Option` in `shared/proto/qyic/v1/deck.proto`.
library;

/// Values match `qyic.v1.QuizType`. Display names live in `l10n/labels.dart`.
enum QuizType {
  multipleChoice(1),
  fillInTheBlank(2),
  matching(3),
  trueFalse(4),
  flashcard(5);

  const QuizType(this.value);

  final int value;

  static QuizType fromValue(int value) =>
      tryFromValue(value) ?? (throw ArgumentError.value(value, 'value'));

  /// Null for values this version does not know (e.g. from newer decks).
  static QuizType? tryFromValue(int value) {
    for (final type in values) {
      if (type.value == value) return type;
    }
    return null;
  }
}

class Deck {
  const Deck({
    required this.id,
    required this.title,
    required this.description,
    required this.author,
    required this.locale,
    required this.version,
    required this.createdAt,
    required this.updatedAt,
  });

  final String id;
  final String title;
  final String description;
  final String author;

  /// BCP-47 content language.
  final String locale;

  /// Content version, bumped by the author on export.
  final int version;
  final DateTime createdAt;
  final DateTime updatedAt;
}

class QuizOption {
  const QuizOption({
    required this.id,
    required this.text,
    this.prompt = '',
    this.mediaPath = '',
    this.isCorrect = false,
  });

  /// Stable id within the quiz.
  final String id;

  /// Answer text. For [QuizType.matching] this is the right-hand entry and
  /// for [QuizType.fillInTheBlank] an accepted answer.
  final String text;

  /// [QuizType.matching] only: the left-hand term paired with [text].
  final String prompt;

  /// Archive-relative media asset; empty when absent.
  final String mediaPath;
  final bool isCorrect;
}

/// The fields the deck screen lists. Full quizzes (options included) are
/// loaded only when one is opened.
class QuizSummary {
  const QuizSummary({
    required this.id,
    required this.type,
    required this.question,
  });

  final String id;
  final QuizType type;
  final String question;
}

class Quiz {
  const Quiz({
    required this.id,
    required this.deckId,
    required this.type,
    required this.position,
    required this.question,
    required this.explanation,
    required this.options,
    this.hint = '',
  });

  final String id;
  final String deckId;
  final QuizType type;

  /// Order within the deck.
  final int position;

  /// Prompt; the flashcard front.
  final String question;

  /// Secondary context shown with [question]; never reveals the answer.
  final String hint;

  /// Shown after answering; the flashcard back.
  final String explanation;
  final List<QuizOption> options;

  Quiz copyWith({int? position}) => Quiz(
    id: id,
    deckId: deckId,
    type: type,
    position: position ?? this.position,
    question: question,
    hint: hint,
    explanation: explanation,
    options: options,
  );
}

/// A deck together with all of its quizzes: the unit of installation.
class DeckContent {
  const DeckContent({required this.deck, required this.quizzes});

  final Deck deck;
  final List<Quiz> quizzes;
}

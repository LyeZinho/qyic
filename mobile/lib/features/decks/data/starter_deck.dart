import '../domain/deck.dart';

/// Deck installed on first launch so a fresh install can be studied
/// immediately. Ids are fixed: re-installing updates content in place and
/// review events from other devices resolve to the same quizzes.
DeckContent starterDeck(DateTime now) {
  const deckId = '6f1c2a4e-8b3d-4c5a-9e7f-0a1b2c3d4e5f';

  Quiz quiz(
    String id,
    QuizType type,
    String question, {
    String explanation = '',
    List<QuizOption> options = const [],
  }) => Quiz(
    id: id,
    deckId: deckId,
    type: type,
    position: 0,
    question: question,
    explanation: explanation,
    options: options,
  );

  List<QuizOption> trueFalse({required bool answer}) => [
    QuizOption(id: 'true', text: 'True', isCorrect: answer),
    QuizOption(id: 'false', text: 'False', isCorrect: !answer),
  ];

  return DeckContent(
    deck: Deck(
      id: deckId,
      title: 'Welcome to Qyic',
      description: 'A short tour of how Qyic schedules and syncs your study.',
      author: 'Qyic',
      locale: 'en',
      version: 1,
      createdAt: now,
      updatedAt: now,
    ),
    quizzes: [
      quiz(
        'a3f0e1d2-0001-4b6a-8c1e-5d2f3a4b6c01',
        QuizType.flashcard,
        'Spaced repetition',
        explanation:
            'Reviewing just before you would forget, at growing intervals, '
            'so each review strengthens memory the most.',
      ),
      quiz(
        'a3f0e1d2-0002-4b6a-8c1e-5d2f3a4b6c02',
        QuizType.multipleChoice,
        'What does Qyic use to decide when a card is due again?',
        explanation:
            'FSRS models stability and difficulty per card to predict when '
            'you are about to forget it.',
        options: const [
          QuizOption(id: 'opt_a', text: 'A fixed 1-3-7 day cycle'),
          QuizOption(id: 'opt_b', text: 'The FSRS scheduler', isCorrect: true),
          QuizOption(id: 'opt_c', text: 'Random selection'),
          QuizOption(id: 'opt_d', text: 'The order cards were added'),
        ],
      ),
      quiz(
        'a3f0e1d2-0003-4b6a-8c1e-5d2f3a4b6c03',
        QuizType.trueFalse,
        'You need an internet connection to study in Qyic.',
        explanation:
            'Study, scheduling, and progress all run on the device. Sync only '
            'exchanges review events when a connection is available.',
        options: trueFalse(answer: false),
      ),
      quiz(
        'a3f0e1d2-0004-4b6a-8c1e-5d2f3a4b6c04',
        QuizType.fillInTheBlank,
        'A .qdeck file stores quizzes serialized with ___ inside a ZIP.',
        explanation: 'deck.pb is a Protocol Buffers payload (qyic.v1.Deck).',
        options: const [
          QuizOption(id: 'ans_1', text: 'Protocol Buffers', isCorrect: true),
          QuizOption(id: 'ans_2', text: 'Protobuf', isCorrect: true),
        ],
      ),
      quiz(
        'a3f0e1d2-0005-4b6a-8c1e-5d2f3a4b6c05',
        QuizType.matching,
        'Match each layer to its technology',
        explanation: 'Qyic ships one codebase per layer, sharing Protobuf.',
        options: const [
          QuizOption(id: 'pair_1', prompt: 'Mobile', text: 'Flutter + SQLite'),
          QuizOption(id: 'pair_2', prompt: 'Backend', text: 'Rust + Axum'),
          QuizOption(id: 'pair_3', prompt: 'Web', text: 'SvelteKit'),
        ],
      ),
      quiz(
        'a3f0e1d2-0006-4b6a-8c1e-5d2f3a4b6c06',
        QuizType.multipleChoice,
        'Which rating should you pick when you recalled the answer, but only '
            'with real effort?',
        explanation:
            'Hard still counts as a recall but grows the interval less than '
            'Good. Again is for answers you could not recall.',
        options: const [
          QuizOption(id: 'opt_a', text: 'Again'),
          QuizOption(id: 'opt_b', text: 'Hard', isCorrect: true),
          QuizOption(id: 'opt_c', text: 'Good'),
          QuizOption(id: 'opt_d', text: 'Easy'),
        ],
      ),
      quiz(
        'a3f0e1d2-0007-4b6a-8c1e-5d2f3a4b6c07',
        QuizType.trueFalse,
        'Syncing re-uploads your whole deck every time you study.',
        explanation:
            'Only review events travel during sync. Deck content is installed '
            'once and never re-uploaded.',
        options: trueFalse(answer: false),
      ),
      quiz(
        'a3f0e1d2-0008-4b6a-8c1e-5d2f3a4b6c08',
        QuizType.flashcard,
        'Desired retention',
        explanation:
            'The recall probability Qyic aims for when scheduling. Higher '
            'means more frequent reviews; 90% is a good default.',
      ),
      quiz(
        'a3f0e1d2-0009-4b6a-8c1e-5d2f3a4b6c09',
        QuizType.fillInTheBlank,
        'A card that has been reviewed successfully for a long time is called '
            '___.',
        explanation:
            'Qyic counts cards with a stability of 21 days or more as mature.',
        options: const [
          QuizOption(id: 'ans_1', text: 'mature', isCorrect: true),
        ],
      ),
      quiz(
        'a3f0e1d2-0010-4b6a-8c1e-5d2f3a4b6c10',
        QuizType.matching,
        'Match each rating to when you would use it',
        explanation: 'Ratings feed FSRS directly. Be honest: the schedule adapts to you.',
        options: const [
          QuizOption(id: 'pair_1', prompt: 'Again', text: 'I forgot it'),
          QuizOption(id: 'pair_2', prompt: 'Good', text: 'Recalled normally'),
          QuizOption(id: 'pair_3', prompt: 'Easy', text: 'Instant recall'),
        ],
      ),
    ],
  );
}

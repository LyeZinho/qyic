import 'dart:convert';
import 'dart:typed_data';

import 'package:archive/archive.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:qyic/core/database/app_database.dart';
import 'package:qyic/features/decks/data/deck_importer.dart';
import 'package:qyic/features/decks/data/deck_repository.dart';
import 'package:qyic/features/decks/data/qdeck_reader.dart';
import 'package:qyic/features/decks/domain/deck.dart';
import 'package:qyic/generated/qyic/v1/deck.pb.dart' as pb;

import '../../helpers.dart';

const _deckId = '5e8e0333-bb11-4ac2-9875-1faaa5f3e7a3';
const _quizA = '0b1f2c3d-0000-4000-8000-00000000000a';
const _quizB = '0b1f2c3d-0000-4000-8000-00000000000b';

pb.Deck _deck({int version = 1, List<pb.Quiz>? quizzes}) => pb.Deck(
  id: _deckId,
  title: 'Italiano',
  author: 'Qyic',
  version: version,
  locale: 'en',
  quizzes:
      quizzes ??
      [
        pb.Quiz(
          id: _quizA,
          type: pb.QuizType.QUIZ_TYPE_MULTIPLE_CHOICE,
          question: 'ciao',
          options: [
            pb.Option(id: 'a', text: 'hello', isCorrect: true),
            pb.Option(id: 'b', text: 'water'),
          ],
        ),
        pb.Quiz(
          id: _quizB,
          type: pb.QuizType.QUIZ_TYPE_FILL_IN_THE_BLANK,
          question: 'Io ___ italiano.',
          hint: 'I speak Italian.',
          options: [pb.Option(id: 'a', text: 'parlo', isCorrect: true)],
        ),
      ],
);

Map<String, Object?> _manifestFor(pb.Deck deck, Uint8List payload) => {
  'format': 'qdeck',
  'spec_version': 1,
  'id': deck.id,
  'title': deck.title,
  'author': deck.author,
  'deck_version': deck.version,
  'created_at': '2026-10-31T00:00:00Z',
  'checksum': {
    'algorithm': 'sha256',
    'value': sha256.convert(payload).toString(),
  },
};

Uint8List _qdeck(
  pb.Deck deck, {
  Map<String, Object?> Function(Map<String, Object?> manifest)? editManifest,
  Map<String, List<int>> extra = const {},
}) {
  final payload = deck.writeToBuffer();
  var manifest = _manifestFor(deck, payload);
  if (editManifest != null) manifest = editManifest(manifest);
  final archive = Archive()
    ..add(ArchiveFile.string('manifest.json', jsonEncode(manifest)))
    ..add(ArchiveFile.bytes('deck.pb', payload));
  for (final MapEntry(:key, :value) in extra.entries) {
    archive.add(ArchiveFile.bytes(key, value));
  }
  return ZipEncoder().encodeBytes(archive);
}

Matcher _failsAt(QdeckCheck check) =>
    throwsA(isA<QdeckFormatException>().having((e) => e.check, 'check', check));

void main() {
  group('readQdeck', () {
    test('reads a valid deck, including hints', () {
      final package = readQdeck(_qdeck(_deck()));
      expect(package.manifest.deckId, _deckId);
      expect(package.content.deck.title, 'Italiano');
      expect(package.content.quizzes.map((q) => q.id), [_quizA, _quizB]);
      expect(package.content.quizzes.last.hint, 'I speak Italian.');
      expect(package.typeCounts, {
        QuizType.multipleChoice: 1,
        QuizType.fillInTheBlank: 1,
      });
      expect(package.skippedQuizzes, 0);
    });

    test('rejects bytes that are not a ZIP archive', () {
      expect(
        () => readQdeck(Uint8List.fromList(utf8.encode('not a zip'))),
        _failsAt(QdeckCheck.archive),
      );
    });

    test('rejects path traversal', () {
      expect(
        () => readQdeck(
          _qdeck(
            _deck(),
            extra: {
              '../evil.txt': [1],
            },
          ),
        ),
        _failsAt(QdeckCheck.archive),
      );
    });

    test('rejects newer spec versions with a clear message', () {
      expect(
        () => readQdeck(
          _qdeck(_deck(), editManifest: (m) => {...m, 'spec_version': 2}),
        ),
        throwsA(
          isA<QdeckFormatException>()
              .having((e) => e.check, 'check', QdeckCheck.manifest)
              .having((e) => e.message, 'message', contains('update Qyic')),
        ),
      );
    });

    test('rejects a tampered payload', () {
      expect(
        () => readQdeck(
          _qdeck(
            _deck(),
            editManifest: (m) => {
              ...m,
              'checksum': {'algorithm': 'sha256', 'value': '0' * 64},
            },
          ),
        ),
        _failsAt(QdeckCheck.checksum),
      );
    });

    test('rejects a manifest for another deck', () {
      expect(
        () => readQdeck(
          _qdeck(
            _deck(),
            editManifest: (m) => {
              ...m,
              'id': '00000000-0000-4000-8000-000000000000',
            },
          ),
        ),
        _failsAt(QdeckCheck.manifest),
      );
    });

    test('rejects quizzes that break the content rules', () {
      final broken = _deck(
        quizzes: [
          pb.Quiz(
            id: _quizA,
            type: pb.QuizType.QUIZ_TYPE_MULTIPLE_CHOICE,
            question: 'two correct',
            options: [
              pb.Option(id: 'a', text: 'x', isCorrect: true),
              pb.Option(id: 'b', text: 'y', isCorrect: true),
            ],
          ),
        ],
      );
      expect(() => readQdeck(_qdeck(broken)), _failsAt(QdeckCheck.quizRules));
    });

    test('skips quiz types from newer spec revisions', () {
      // An enum value this build does not know decodes as UNSPECIFIED.
      final deck = _deck()
        ..quizzes.add(
          pb.Quiz(
            id: '0b1f2c3d-0000-4000-8000-00000000000c',
            type: pb.QuizType.QUIZ_TYPE_UNSPECIFIED,
            question: 'future',
          ),
        );
      final package = readQdeck(_qdeck(deck));
      expect(package.content.quizzes, hasLength(2));
      expect(package.skippedQuizzes, 1);
    });
  });

  group('DeckImporter', () {
    late AppDatabase db;
    late DeckRepository decks;
    late DeckImporter importer;

    setUp(() {
      db = inMemoryDatabase();
      decks = DeckRepository(db, () => DateTime.utc(2026));
      importer = DeckImporter(decks);
    });
    tearDown(() => db.close());

    test('previews a new deck, then an update that keeps progress', () async {
      final first = await importer.preview(_qdeck(_deck()));
      expect(first.isUpdate, isFalse);
      expect(first.added, 2);
      await importer.install(first);

      final next = _deck(version: 2)
        ..quizzes.removeLast()
        ..quizzes.add(
          pb.Quiz(
            id: '0b1f2c3d-0000-4000-8000-00000000000d',
            type: pb.QuizType.QUIZ_TYPE_FLASHCARD,
            question: 'acqua',
            explanation: 'water',
          ),
        );
      final update = await importer.preview(_qdeck(next));
      expect(update.isUpdate, isTrue);
      expect(update.installedVersion, 1);
      expect((update.added, update.updated, update.removed), (1, 1, 1));

      await importer.install(update);
      final state = await decks.installedState(_deckId);
      expect(state.version, 2);
      expect(state.quizIds, {_quizA, '0b1f2c3d-0000-4000-8000-00000000000d'});
    });
  });
}

import 'dart:convert';
import 'dart:typed_data';

import 'package:archive/archive.dart';
import 'package:crypto/crypto.dart';

import '../../../generated/qyic/v1/deck.pb.dart' as pb;
import '../domain/deck.dart';
import '../domain/quiz_validation.dart';

/// Import checks, in the order they run (`docs/deck-format.md` §5).
enum QdeckCheck { archive, manifest, checksum, quizRules }

class QdeckFormatException implements Exception {
  const QdeckFormatException(this.check, this.message);

  /// The check that failed; every earlier check passed.
  final QdeckCheck check;
  final String message;

  @override
  String toString() => 'QdeckFormatException(${check.name}): $message';
}

class QdeckManifest {
  const QdeckManifest({
    required this.specVersion,
    required this.deckId,
    required this.title,
    required this.author,
    required this.deckVersion,
    required this.createdAt,
    required this.checksum,
  });

  final int specVersion;
  final String deckId;
  final String title;
  final String author;
  final int deckVersion;
  final DateTime createdAt;

  /// Lowercase hex SHA-256 of `deck.pb`.
  final String checksum;
}

/// A fully verified `.qdeck` file, ready to install.
class QdeckPackage {
  const QdeckPackage({
    required this.manifest,
    required this.content,
    required this.skippedQuizzes,
    required this.mediaFiles,
  });

  final QdeckManifest manifest;
  final DeckContent content;

  /// Quizzes of types this app version cannot present. Decks evolve
  /// additively, so newer types are skipped instead of failing the import.
  final int skippedQuizzes;

  /// Files under `media/`. Media rendering is not supported yet.
  final int mediaFiles;

  Map<QuizType, int> get typeCounts {
    final counts = <QuizType, int>{};
    for (final quiz in content.quizzes) {
      counts[quiz.type] = (counts[quiz.type] ?? 0) + 1;
    }
    return counts;
  }
}

const qdeckFormat = 'qdeck';
const qdeckSpecVersion = 1;

/// Soft cap on total uncompressed size (`docs/deck-format.md` §1).
const qdeckMaxBytes = 256 * 1024 * 1024;

const _manifestEntry = 'manifest.json';
const _deckEntry = 'deck.pb';

/// Parses and verifies a `.qdeck` archive. Pure and synchronous, so callers
/// can run it on a background isolate.
///
/// Throws [QdeckFormatException] naming the first failed check.
QdeckPackage readQdeck(Uint8List bytes) {
  const notAnArchive = QdeckFormatException(
    QdeckCheck.archive,
    'The file is not a valid .qdeck (ZIP) archive.',
  );
  final Archive archive;
  try {
    archive = ZipDecoder().decodeBytes(bytes);
  } on Object {
    throw notAnArchive;
  }
  // The decoder yields an empty archive, not an error, for non-ZIP input.
  if (archive.isEmpty) throw notAnArchive;

  var total = 0;
  for (final entry in archive) {
    if (!isArchiveRelative(entry.name.replaceFirst(RegExp(r'/$'), '')) ||
        entry.isSymbolicLink) {
      throw QdeckFormatException(
        QdeckCheck.archive,
        'Unsafe path in archive: ${entry.name}',
      );
    }
    total += entry.size;
    if (total > qdeckMaxBytes) {
      throw const QdeckFormatException(
        QdeckCheck.archive,
        'The archive is larger than 256 MiB once unpacked.',
      );
    }
  }

  final manifest = _parseManifest(_read(archive, _manifestEntry));
  final payload = _read(archive, _deckEntry);

  final actual = sha256.convert(payload).toString();
  if (actual != manifest.checksum) {
    throw const QdeckFormatException(
      QdeckCheck.checksum,
      'deck.pb does not match the checksum in manifest.json.',
    );
  }

  final pb.Deck deck;
  try {
    deck = pb.Deck.fromBuffer(payload);
  } on Object {
    throw const QdeckFormatException(
      QdeckCheck.checksum,
      'deck.pb is not a valid deck payload.',
    );
  }
  if (deck.id != manifest.deckId) {
    throw const QdeckFormatException(
      QdeckCheck.manifest,
      'manifest.json describes a different deck than deck.pb.',
    );
  }

  final (content, skipped) = _toContent(deck, manifest);
  return QdeckPackage(
    manifest: manifest,
    content: content,
    skippedQuizzes: skipped,
    mediaFiles: archive.files
        .where((file) => file.isFile && file.name.startsWith('media/'))
        .length,
  );
}

/// Empty, or a relative path without `..`, `.`, empty segments, absolute
/// roots, drive letters, or backslashes.
bool isArchiveRelative(String path) =>
    path.isEmpty ||
    (!path.startsWith('/') &&
        !path.contains(r'\') &&
        !path.contains(':') &&
        path
            .split('/')
            .every((part) => part.isNotEmpty && part != '..' && part != '.'));

Uint8List _read(Archive archive, String name) {
  final file = archive.findFile(name);
  if (file == null || !file.isFile) {
    throw QdeckFormatException(
      name == _manifestEntry ? QdeckCheck.manifest : QdeckCheck.checksum,
      'The archive has no $name.',
    );
  }
  final Uint8List? bytes;
  try {
    bytes = file.readBytes();
  } on Object {
    throw QdeckFormatException(QdeckCheck.archive, '$name is corrupted.');
  }
  if (bytes == null || bytes.length > qdeckMaxBytes) {
    throw QdeckFormatException(QdeckCheck.archive, '$name is corrupted.');
  }
  return bytes;
}

QdeckManifest _parseManifest(Uint8List bytes) {
  Never invalid(String message) =>
      throw QdeckFormatException(QdeckCheck.manifest, message);

  final Object? json;
  try {
    json = jsonDecode(utf8.decode(bytes));
  } on FormatException {
    invalid('manifest.json is not valid JSON.');
  }
  final manifest = json is Map<String, Object?>
      ? json
      : invalid('manifest.json must be an object.');

  T field<T>(String key) {
    final value = manifest[key];
    if (value is! T) invalid('manifest.json has no valid "$key".');
    return value;
  }

  if (field<String>('format') != qdeckFormat) {
    invalid('This is not a .qdeck manifest.');
  }
  final specVersion = field<int>('spec_version');
  if (specVersion != qdeckSpecVersion) {
    invalid(
      'This deck uses format version $specVersion; update Qyic to open it.',
    );
  }
  final checksum = field<Map<String, Object?>>('checksum');
  if (checksum['algorithm'] != 'sha256' || checksum['value'] is! String) {
    invalid('manifest.json has an unsupported checksum.');
  }
  final createdAt = DateTime.tryParse(field<String>('created_at'));
  if (createdAt == null) invalid('manifest.json has an invalid "created_at".');

  return QdeckManifest(
    specVersion: specVersion,
    deckId: field<String>('id'),
    title: field<String>('title'),
    author: field<String>('author'),
    deckVersion: field<int>('deck_version'),
    createdAt: createdAt.toUtc(),
    checksum: (checksum['value']! as String).toLowerCase(),
  );
}

final _uuid = RegExp(
  r'^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$',
  caseSensitive: false,
);

(DeckContent, int) _toContent(pb.Deck deck, QdeckManifest manifest) {
  Never invalid(String message) =>
      throw QdeckFormatException(QdeckCheck.quizRules, message);

  if (!_uuid.hasMatch(deck.id)) invalid('The deck id is not a UUID.');
  if (deck.title.trim().isEmpty) invalid('The deck has no title.');

  final ids = <String>{};
  final quizzes = <Quiz>[];
  var skipped = 0;
  for (final source in deck.quizzes) {
    final type = QuizType.tryFromValue(source.type.value);
    if (type == null) {
      skipped++;
      continue;
    }
    if (!_uuid.hasMatch(source.id) || !ids.add(source.id)) {
      invalid('Quiz ids must be unique UUIDs (${source.id}).');
    }
    final quiz = Quiz(
      id: source.id,
      deckId: deck.id,
      type: type,
      position: quizzes.length,
      question: source.question,
      hint: source.hint,
      explanation: source.explanation,
      options: [
        for (final option in source.options)
          QuizOption(
            id: option.id,
            text: option.text,
            prompt: option.prompt,
            mediaPath: option.mediaPath,
            isCorrect: option.isCorrect,
          ),
      ],
    );
    final issues = validateQuiz(quiz);
    if (issues.isNotEmpty) {
      invalid(
        'Quiz ${quizzes.length + skipped + 1}: ${issues.first.description}',
      );
    }
    if (quiz.options.any((option) => !isArchiveRelative(option.mediaPath))) {
      invalid('Quiz ${quizzes.length + skipped + 1} references unsafe media.');
    }
    quizzes.add(quiz);
  }
  if (quizzes.isEmpty) invalid('The deck has no quizzes this app can show.');

  return (
    DeckContent(
      deck: Deck(
        id: deck.id,
        title: deck.title.trim(),
        description: deck.description,
        author: deck.author,
        locale: deck.locale.isEmpty ? 'en' : deck.locale,
        version: deck.version,
        createdAt: manifest.createdAt,
        updatedAt: manifest.createdAt,
      ),
      quizzes: quizzes,
    ),
    skipped,
  );
}

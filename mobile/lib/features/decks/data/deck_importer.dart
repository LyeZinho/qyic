import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'deck_repository.dart';
import 'qdeck_reader.dart';

/// What installing a verified `.qdeck` would change.
class ImportPreview {
  const ImportPreview({
    required this.package,
    required this.installedVersion,
    required this.added,
    required this.updated,
    required this.removed,
  });

  final QdeckPackage package;

  /// Version currently installed; null when the deck is new on this device.
  final int? installedVersion;
  final int added;
  final int updated;
  final int removed;

  bool get isUpdate => installedVersion != null;
}

class DeckImporter {
  DeckImporter(this._decks);

  final DeckRepository _decks;

  /// Verifies [bytes] off the UI thread and compares the deck with what is
  /// installed. Throws [QdeckFormatException] for invalid files.
  Future<ImportPreview> preview(Uint8List bytes) async {
    if (bytes.length > qdeckMaxBytes) {
      throw const QdeckFormatException(
        QdeckCheck.archive,
        'The file is larger than 256 MiB.',
      );
    }
    final package = await compute(readQdeck, bytes);
    final installed = await _decks.installedState(package.content.deck.id);
    final incoming = {for (final quiz in package.content.quizzes) quiz.id};
    final kept = incoming.intersection(installed.quizIds).length;
    return ImportPreview(
      package: package,
      installedVersion: installed.version,
      added: incoming.length - kept,
      updated: kept,
      removed: installed.quizIds.difference(incoming).length,
    );
  }

  /// Installs the previewed content. Progress for existing quizzes is kept.
  Future<void> install(ImportPreview preview) =>
      _decks.installContent(preview.package.content);
}

final deckImporterProvider = Provider<DeckImporter>(
  (ref) => DeckImporter(ref.watch(deckRepositoryProvider)),
);

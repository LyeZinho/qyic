import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/providers.dart';
import '../features/decks/data/deck_repository.dart';
import '../features/decks/data/starter_deck.dart';
import '../features/settings/settings_repository.dart';

/// One-time local setup on launch: device id and the starter deck.
final appBootstrapProvider = FutureProvider<void>((ref) async {
  final db = ref.read(databaseProvider);
  final settings = ref.read(settingsRepositoryProvider);
  final decks = ref.read(deckRepositoryProvider);

  await settings.clientId();
  await db.transaction(() async {
    if (await settings.isStarterDeckInstalled()) return;
    await decks.installContent(starterDeck(ref.read(clockProvider)().toUtc()));
    await settings.markStarterDeckInstalled();
  });
});

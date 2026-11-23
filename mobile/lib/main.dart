import 'package:flutter/foundation.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app/qyic_app.dart';
import 'core/database/app_database.dart';
import 'core/providers.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  LicenseRegistry.addLicense(_bundledFontLicenses);
  runApp(
    ProviderScope(
      overrides: [databaseProvider.overrideWithValue(AppDatabase.open())],
      child: const QyicApp(),
    ),
  );
}

Stream<LicenseEntry> _bundledFontLicenses() async* {
  for (final (font, file) in [
    ('Space Grotesk', 'SpaceGrotesk-OFL.txt'),
    ('JetBrains Mono', 'JetBrainsMono-OFL.txt'),
  ]) {
    yield LicenseEntryWithLineBreaks([
      font,
    ], await rootBundle.loadString('assets/fonts/$file'));
  }
}

import 'package:flutter/widgets.dart';

import 'app_localizations.dart';

export 'app_localizations.dart';

/// UI languages offered in Preferences, keyed by the BCP-47 tag stored in
/// settings. Names are endonyms so every user can find their own language.
const appLanguages = <String, String>{
  'en': 'English',
  'pt-BR': 'Português (Brasil)',
  'pt-PT': 'Português (Portugal)',
  'es': 'Español',
  'it': 'Italiano',
  'de': 'Deutsch',
  'ja': '日本語',
};

/// Parses a stored language tag; null for unknown tags (follow the system).
Locale? localeFromTag(String? tag) {
  if (tag == null || !appLanguages.containsKey(tag)) return null;
  final parts = tag.split('-');
  return Locale(parts.first, parts.length > 1 ? parts[1] : null);
}

extension AppLocalizationsContext on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this);
}

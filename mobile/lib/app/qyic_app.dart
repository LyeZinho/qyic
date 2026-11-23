import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/theme/qyic_theme.dart';
import '../core/widgets/qyic_shared_widgets.dart';
import '../features/reminders/application/reminder_sync.dart';
import '../features/settings/settings_repository.dart';
import '../features/shell/app_shell.dart';
import '../l10n/l10n.dart';
import 'bootstrap.dart';

/// Root widget of the Qyic mobile client.
///
/// The app is offline-first by design (ADR-0006): the review loop, FSRS
/// scheduling, and progression all run against the local SQLite store; sync
/// is a background concern.
class QyicApp extends ConsumerWidget {
  const QyicApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bootstrap = ref.watch(appBootstrapProvider);
    final languageTag = ref.watch(
      settingsProvider.select((settings) => settings.value?.languageTag),
    );
    ref.listen(reminderSyncProvider, (_, next) {
      if (next case AsyncError(:final error, :final stackTrace)) {
        FlutterError.reportError(
          FlutterErrorDetails(
            exception: error,
            stack: stackTrace,
            library: 'reminders',
            context: ErrorDescription('while scheduling study reminders'),
          ),
        );
      }
    });

    return MaterialApp(
      onGenerateTitle: (context) => context.l10n.appTitle,
      debugShowCheckedModeBanner: false,
      theme: QyicTheme.dark(),
      locale: localeFromTag(languageTag),
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      home: Scaffold(
        body: QyicAsyncView(value: bootstrap, data: (_) => const AppShell()),
      ),
    );
  }
}

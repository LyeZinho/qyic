import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/qyic_colors.dart';
import '../../../core/theme/qyic_theme.dart';
import '../../../core/widgets/qyic_shared_widgets.dart';
import '../../../l10n/l10n.dart';
import '../../../l10n/labels.dart';
import '../data/deck_importer.dart';
import '../data/qdeck_reader.dart';
import '../domain/deck.dart';
import 'deck_detail_screen.dart';

const _qdeckTypes = [
  XTypeGroup(
    label: 'Qyic deck',
    extensions: ['qdeck'],
    // Android and iOS filter by MIME / UTI; .qdeck files are ZIP archives
    // that file managers usually report as one of these.
    mimeTypes: ['application/zip', 'application/octet-stream'],
    uniformTypeIdentifiers: ['public.zip-archive', 'public.data'],
  ),
];

/// Lets the user pick a `.qdeck` file, shows what it contains, and installs
/// it on confirmation. Opens the deck afterwards.
Future<void> importDeckFromFile(BuildContext context, WidgetRef ref) async {
  final file = await openFile(acceptedTypeGroups: _qdeckTypes);
  if (file == null || !context.mounted) return;

  final importer = ref.read(deckImporterProvider);
  final result = await showDialog<_ImportResult>(
    context: context,
    barrierDismissible: false,
    builder: (_) => _ImportDialog(
      importer: importer,
      load: () async {
        if (await file.length() > qdeckMaxBytes) {
          throw const QdeckFormatException(
            QdeckCheck.archive,
            'The file is larger than 256 MiB.',
          );
        }
        return importer.preview(await file.readAsBytes());
      },
    ),
  );
  if (result == null || !context.mounted) return;

  final l10n = context.l10n;
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        result.wasUpdate
            ? l10n.importUpdated(result.title)
            : l10n.importInstalled(result.title),
      ),
    ),
  );
  await Navigator.of(context).push(
    MaterialPageRoute<void>(
      builder: (_) => DeckDetailScreen(deckId: result.deckId),
    ),
  );
}

class _ImportResult {
  const _ImportResult(this.deckId, this.title, {required this.wasUpdate});

  final String deckId;
  final String title;
  final bool wasUpdate;
}

class _ImportDialog extends StatefulWidget {
  const _ImportDialog({required this.importer, required this.load});

  final DeckImporter importer;
  final Future<ImportPreview> Function() load;

  @override
  State<_ImportDialog> createState() => _ImportDialogState();
}

class _ImportDialogState extends State<_ImportDialog> {
  late final Future<ImportPreview> _preview = widget.load();
  bool _installing = false;
  Object? _installError;

  Future<void> _install(ImportPreview preview) async {
    setState(() {
      _installing = true;
      _installError = null;
    });
    try {
      await widget.importer.install(preview);
    } on Object catch (error) {
      if (mounted) {
        setState(() {
          _installing = false;
          _installError = error;
        });
      }
      return;
    }
    if (!mounted) return;
    final deck = preview.package.content.deck;
    Navigator.of(
      context,
    ).pop(_ImportResult(deck.id, deck.title, wasUpdate: preview.isUpdate));
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Dialog(
      insetPadding: const EdgeInsets.all(20),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 520),
        child: FutureBuilder<ImportPreview>(
          future: _preview,
          builder: (context, snapshot) {
            final Widget body;
            final List<Widget> actions;
            if (snapshot.connectionState != ConnectionState.done) {
              body = _Checking(label: l10n.importChecking);
              actions = const [];
            } else if (snapshot.error case final error?) {
              body = _FailedReport(
                error: error is QdeckFormatException
                    ? error
                    : QdeckFormatException(QdeckCheck.archive, '$error'),
              );
              actions = [
                FilledButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text(l10n.actionClose),
                ),
              ];
            } else {
              final preview = snapshot.requireData;
              body = _PreviewReport(preview: preview, error: _installError);
              actions = [
                TextButton(
                  onPressed: _installing
                      ? null
                      : () => Navigator.of(context).pop(),
                  child: Text(l10n.actionCancel),
                ),
                FilledButton(
                  onPressed: _installing ? null : () => _install(preview),
                  child: _installing
                      ? const SizedBox.square(
                          dimension: 18,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : Text(
                          preview.isUpdate
                              ? l10n.importUpdateAction
                              : l10n.importInstallAction,
                        ),
                ),
              ];
            }
            return Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Flexible(child: SingleChildScrollView(child: body)),
                  if (actions.isNotEmpty) ...[
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        for (final (index, action) in actions.indexed) ...[
                          if (index > 0) const SizedBox(width: 8),
                          action,
                        ],
                      ],
                    ),
                  ],
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class _Checking extends StatelessWidget {
  const _Checking({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Row(
        children: [
          const SizedBox.square(
            dimension: 22,
            child: CircularProgressIndicator(strokeWidth: 2.5),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(label, style: Theme.of(context).textTheme.titleMedium),
          ),
        ],
      ),
    );
  }
}

class _PreviewReport extends StatelessWidget {
  const _PreviewReport({required this.preview, required this.error});

  final ImportPreview preview;
  final Object? error;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final textTheme = Theme.of(context).textTheme;
    final package = preview.package;
    final manifest = package.manifest;
    final deck = package.content.deck;
    final counts = package.typeCounts;
    final total = package.content.quizzes.length;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: QyicSectionLabel(l10n.importTitle)),
            QyicPill(
              preview.isUpdate
                  ? l10n.importUpdateBadge(
                      preview.installedVersion!,
                      deck.version,
                    )
                  : l10n.importNewBadge,
              color: preview.isUpdate ? QyicColors.orange : QyicColors.lime,
            ),
          ],
        ),
        const SizedBox(height: 6),
        Text(deck.title, style: textTheme.headlineMedium),
        const SizedBox(height: 4),
        Text(
          [
            if (deck.author.isNotEmpty) deck.author,
            l10n.importSpecVersion(manifest.specVersion),
            l10n.importDeckVersion(deck.version),
          ].join(' · '),
          style: textTheme.bodyMedium,
        ),
        const SizedBox(height: 16),
        QyicPanel(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
          child: Column(
            children: [
              for (final check in QdeckCheck.values)
                _CheckRow(
                  label: check.label(l10n),
                  detail: switch (check) {
                    QdeckCheck.archive => l10n.importCheckArchiveDetail,
                    QdeckCheck.manifest => l10n.importSpecVersion(
                      manifest.specVersion,
                    ),
                    QdeckCheck.checksum =>
                      '${manifest.checksum.substring(0, 8)}…',
                    QdeckCheck.quizRules => '$total / $total',
                  },
                  state: _CheckState.passed,
                ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            for (final type in QuizType.values)
              if (counts[type] case final count?)
                _CountTile(count: count, label: type.label(l10n)),
          ],
        ),
        if (preview.isUpdate) ...[
          const SizedBox(height: 12),
          Text(
            l10n.importChanges(preview.added, preview.updated, preview.removed),
            style: textTheme.bodyMedium,
          ),
        ],
        if (package.skippedQuizzes > 0) ...[
          const SizedBox(height: 8),
          Text(
            l10n.importSkipped(package.skippedQuizzes),
            style: textTheme.bodyMedium?.copyWith(color: QyicColors.orange),
          ),
        ],
        if (package.mediaFiles > 0) ...[
          const SizedBox(height: 8),
          Text(
            l10n.importMediaUnsupported(package.mediaFiles),
            style: textTheme.bodyMedium,
          ),
        ],
        const SizedBox(height: 14),
        QyicPanel(
          color: QyicColors.successSurface,
          borderColor: QyicColors.success,
          child: Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: '${l10n.importProgressKeptTitle} ',
                  style: const TextStyle(
                    color: QyicColors.success,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                TextSpan(text: l10n.importProgressKeptBody),
              ],
            ),
            style: textTheme.bodyMedium,
          ),
        ),
        if (error != null) ...[
          const SizedBox(height: 12),
          Text(
            l10n.importInstallFailed('$error'),
            style: textTheme.bodyMedium?.copyWith(color: QyicColors.failure),
          ),
        ],
      ],
    );
  }
}

class _FailedReport extends StatelessWidget {
  const _FailedReport({required this.error});

  final QdeckFormatException error;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        QyicSectionLabel(l10n.importTitle),
        const SizedBox(height: 6),
        Text(l10n.importFailedTitle, style: textTheme.headlineMedium),
        const SizedBox(height: 16),
        QyicPanel(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
          child: Column(
            children: [
              for (final check in QdeckCheck.values)
                _CheckRow(
                  label: check.label(l10n),
                  detail: '',
                  state: check.index < error.check.index
                      ? _CheckState.passed
                      : check == error.check
                      ? _CheckState.failed
                      : _CheckState.skipped,
                ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Text(
          error.message,
          style: textTheme.bodyMedium?.copyWith(color: QyicColors.failure),
        ),
      ],
    );
  }
}

enum _CheckState { passed, failed, skipped }

class _CheckRow extends StatelessWidget {
  const _CheckRow({
    required this.label,
    required this.detail,
    required this.state,
  });

  final String label;
  final String detail;
  final _CheckState state;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final (icon, color) = switch (state) {
      _CheckState.passed => (Icons.check_rounded, QyicColors.success),
      _CheckState.failed => (Icons.close_rounded, QyicColors.failure),
      _CheckState.skipped => (Icons.remove_rounded, QyicColors.textMuted),
    };
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.16),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Icon(icon, size: 16, color: color),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              label,
              style: textTheme.bodyLarge?.copyWith(
                color: state == _CheckState.skipped
                    ? QyicColors.textMuted
                    : QyicColors.textPrimary,
              ),
            ),
          ),
          if (detail.isNotEmpty)
            Text(detail, style: QyicTextStyles.mono(context, size: 12)),
        ],
      ),
    );
  }
}

class _CountTile extends StatelessWidget {
  const _CountTile({required this.count, required this.label});

  final int count;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minWidth: 92),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: QyicColors.border, width: 1.5),
      ),
      child: Column(
        children: [
          Text(
            '$count',
            style: QyicTextStyles.mono(
              context,
              size: 18,
              color: QyicColors.textPrimary,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}

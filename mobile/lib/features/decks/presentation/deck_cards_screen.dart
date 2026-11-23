import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/qyic_colors.dart';
import '../../../core/widgets/qyic_shared_widgets.dart';
import '../../../l10n/l10n.dart';
import '../../../l10n/labels.dart';
import '../data/deck_repository.dart';
import '../domain/deck.dart';
import 'deck_providers.dart';
import 'quiz_editor_screen.dart';

/// Add, edit, and delete the quizzes of one deck. Kept off the deck page so
/// a deck of thousands of cards does not bury the study actions.
class DeckCardsScreen extends ConsumerWidget {
  const DeckCardsScreen({super.key, required this.deckId});

  final String deckId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final quizzes = ref.watch(deckQuizSummariesProvider(deckId));
    return Scaffold(
      appBar: AppBar(title: Text(l10n.deckManageCards)),
      body: QyicContentWidth(
        child: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(20, 4, 20, 8),
              sliver: SliverToBoxAdapter(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: TextButton.icon(
                    onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute<void>(
                        builder: (_) => QuizEditorScreen(deckId: deckId),
                      ),
                    ),
                    icon: const Icon(Icons.add_rounded, size: 18),
                    label: Text(l10n.deckAddQuiz),
                  ),
                ),
              ),
            ),
            ..._quizSlivers(context, deckId, quizzes, l10n),
            const SliverPadding(padding: EdgeInsets.only(bottom: 24)),
          ],
        ),
      ),
    );
  }
}

List<Widget> _quizSlivers(
  BuildContext context,
  String deckId,
  AsyncValue<List<QuizSummary>> quizzes,
  AppLocalizations l10n,
) {
  return quizzes.when(
    skipLoadingOnReload: true,
    loading: () => [
      const SliverToBoxAdapter(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Center(child: CircularProgressIndicator()),
        ),
      ),
    ],
    error: (error, _) => [
      SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Text(l10n.errorGeneric('$error'), textAlign: TextAlign.center),
        ),
      ),
    ],
    data: (items) => [
      if (items.isEmpty)
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          sliver: SliverToBoxAdapter(
            child: Text(
              l10n.deckNoQuizzes,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        )
      else
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          sliver: SliverList.builder(
            itemCount: items.length,
            itemBuilder: (context, index) =>
                _QuizTile(deckId: deckId, quiz: items[index]),
          ),
        ),
    ],
  );
}

class _QuizTile extends ConsumerWidget {
  const _QuizTile({required this.deckId, required this.quiz});

  final String deckId;
  final QuizSummary quiz;

  Future<void> _open(BuildContext context, WidgetRef ref) async {
    final loaded = await ref.read(deckRepositoryProvider).loadQuiz(quiz.id);
    if (loaded == null || !context.mounted) return;
    await Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => QuizEditorScreen(deckId: deckId, quiz: loaded),
      ),
    );
  }

  Future<void> _delete(BuildContext context, WidgetRef ref) async {
    final l10n = context.l10n;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(l10n.quizDeleteTitle),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: Text(l10n.actionCancel),
          ),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: QyicColors.coral),
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: Text(l10n.actionDelete),
          ),
        ],
      ),
    );
    if (confirmed == true) {
      await ref.read(deckRepositoryProvider).deleteQuiz(quiz.id);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: QyicPanel(
        padding: const EdgeInsets.fromLTRB(16, 12, 4, 12),
        onTap: () => _open(context, ref),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    quiz.type.label(context.l10n).toUpperCase(),
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    quiz.question,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
            ),
            IconButton(
              tooltip: context.l10n.quizDeleteTooltip,
              icon: const Icon(Icons.delete_outline_rounded),
              color: QyicColors.textMuted,
              onPressed: () => _delete(context, ref),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/qyic_colors.dart';
import '../../../core/widgets/qyic_shared_widgets.dart';
import '../../../l10n/l10n.dart';
import '../data/deck_repository.dart';
import 'deck_detail_screen.dart';
import 'deck_editor_dialog.dart';
import 'deck_providers.dart';
import 'import_deck_flow.dart';

enum _LibraryFilter { all, due }

class LibraryScreen extends ConsumerStatefulWidget {
  const LibraryScreen({super.key});

  @override
  ConsumerState<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends ConsumerState<LibraryScreen> {
  final _search = TextEditingController();
  _LibraryFilter _filter = _LibraryFilter.all;

  @override
  void initState() {
    super.initState();
    _search.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  Future<void> _createDeck() async {
    final fields = await showDeckEditorDialog(context);
    if (fields == null || !mounted) return;
    final deckId = await ref
        .read(deckRepositoryProvider)
        .createDeck(title: fields.title, description: fields.description);
    if (!mounted) return;
    await Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (_) => DeckDetailScreen(deckId: deckId)),
    );
  }

  List<DeckSummary> _visible(List<DeckSummary> decks) {
    final query = _search.text.trim().toLowerCase();
    return [
      for (final summary in decks)
        if ((query.isEmpty ||
                summary.deck.title.toLowerCase().contains(query)) &&
            (_filter == _LibraryFilter.all ||
                summary.dueCount + summary.newCount > 0))
          summary,
    ];
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final summaries = ref.watch(deckSummariesProvider);
    final buttonStyle = OutlinedButton.styleFrom(
      minimumSize: const Size.fromHeight(52),
    );
    return SafeArea(
      child: QyicContentWidth(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
              child: Text(
                l10n.navLibrary,
                style: Theme.of(context).textTheme.headlineLarge,
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                controller: _search,
                decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.search_rounded,
                    color: QyicColors.textMuted,
                  ),
                  hintText: l10n.librarySearch,
                ),
              ),
            ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Wrap(
                spacing: 8,
                children: [
                  for (final filter in _LibraryFilter.values)
                    ChoiceChip(
                      label: Text(switch (filter) {
                        _LibraryFilter.all => l10n.libraryFilterAll,
                        _LibraryFilter.due => l10n.libraryFilterDue,
                      }),
                      selected: _filter == filter,
                      onSelected: (_) => setState(() => _filter = filter),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: QyicAsyncView(
                value: summaries,
                data: (decks) {
                  final visible = _visible(decks);
                  if (visible.isEmpty) {
                    return Center(
                      child: Text(
                        decks.isEmpty ? l10n.libraryEmpty : l10n.libraryNoMatch,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    );
                  }
                  return ListView.separated(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
                    itemCount: visible.length,
                    separatorBuilder: (_, _) => const SizedBox(height: 10),
                    itemBuilder: (context, index) =>
                        _LibraryDeckCard(summary: visible[index]),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 8),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () => importDeckFromFile(context, ref),
                      icon: const Icon(Icons.file_open_outlined),
                      label: Text(l10n.importAction),
                      style: buttonStyle,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: _createDeck,
                      icon: const Icon(Icons.add_rounded),
                      label: Text(l10n.deckNew),
                      style: buttonStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LibraryDeckCard extends StatelessWidget {
  const _LibraryDeckCard({required this.summary});

  final DeckSummary summary;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final textTheme = Theme.of(context).textTheme;
    return QyicPanel(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute<void>(
          builder: (_) => DeckDetailScreen(deckId: summary.deck.id),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(summary.deck.title, style: textTheme.titleMedium),
                const SizedBox(height: 4),
                Text(
                  [
                    l10n.quizCount(summary.quizCount),
                    l10n.deckDueCount(summary.dueCount),
                    l10n.deckNewCount(summary.newCount),
                  ].join(' · '),
                  style: textTheme.bodyMedium,
                ),
              ],
            ),
          ),
          const Icon(Icons.chevron_right_rounded, color: QyicColors.textMuted),
        ],
      ),
    );
  }
}

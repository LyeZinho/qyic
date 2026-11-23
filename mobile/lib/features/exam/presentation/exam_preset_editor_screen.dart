import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/qyic_colors.dart';
import '../../../core/theme/qyic_theme.dart';
import '../../../core/widgets/qyic_primary_button.dart';
import '../../../core/widgets/qyic_shared_widgets.dart';
import '../../../l10n/l10n.dart';
import '../../../l10n/labels.dart';
import '../../decks/domain/deck.dart';
import '../../decks/presentation/deck_providers.dart';
import '../data/exam_repository.dart';
import '../domain/exam.dart';

/// Creates (`preset.id == null`) or edits an exam preset.
class ExamPresetEditorScreen extends ConsumerStatefulWidget {
  const ExamPresetEditorScreen({super.key, required this.preset});

  final ExamPreset preset;

  @override
  ConsumerState<ExamPresetEditorScreen> createState() =>
      _ExamPresetEditorScreenState();
}

class _ExamPresetEditorScreenState
    extends ConsumerState<ExamPresetEditorScreen> {
  late ExamPreset _draft = widget.preset;
  late final _name = TextEditingController(text: widget.preset.name);
  bool _saving = false;
  bool _submitted = false;

  bool get _isNew => widget.preset.id == null;

  @override
  void dispose() {
    _name.dispose();
    super.dispose();
  }

  void _update(ExamPreset Function(ExamPreset draft) change) =>
      setState(() => _draft = change(_draft));

  Future<void> _save() async {
    final preset = _draft.copyWith(name: _name.text);
    setState(() => _submitted = true);
    if (preset.validate().isNotEmpty) return;
    setState(() => _saving = true);
    try {
      await ref.read(examRepositoryProvider).savePreset(preset);
    } catch (error) {
      if (!mounted) return;
      setState(() => _saving = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(context.l10n.errorGeneric('$error'))),
      );
      return;
    }
    if (mounted) Navigator.of(context).pop();
  }

  Future<void> _delete() async {
    final l10n = context.l10n;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.examDeleteTitle),
        content: Text(l10n.examDeleteBody(widget.preset.name)),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(l10n.actionCancel),
          ),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: QyicColors.coral),
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(l10n.actionDelete),
          ),
        ],
      ),
    );
    if (confirmed != true || !mounted) return;
    await ref.read(examRepositoryProvider).deletePreset(widget.preset.id!);
    if (mounted) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final textTheme = Theme.of(context).textTheme;
    final decks = ref.watch(deckSummariesProvider).value ?? const [];
    final issues = _submitted
        ? _draft.copyWith(name: _name.text).validate()
        : const <ExamPresetIssue>[];

    return Scaffold(
      appBar: AppBar(
        title: Text(_isNew ? l10n.examNewPreset : l10n.examEditPreset),
        actions: [
          if (!_isNew)
            IconButton(
              tooltip: l10n.actionDelete,
              icon: const Icon(Icons.delete_outline_rounded),
              onPressed: _saving ? null : _delete,
            ),
        ],
      ),
      body: QyicContentWidth(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 4, 20, 24),
          children: [
            TextField(
              controller: _name,
              textCapitalization: TextCapitalization.sentences,
              decoration: InputDecoration(
                labelText: l10n.examFieldName.toUpperCase(),
                errorText: issues.contains(ExamPresetIssue.emptyName)
                    ? ExamPresetIssue.emptyName.label(l10n)
                    : null,
              ),
            ),
            _Section(
              title: l10n.examFieldDecks,
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  FilterChip(
                    label: Text(l10n.examAllDecks),
                    selected: _draft.deckIds.isEmpty,
                    onSelected: (_) =>
                        _update((d) => d.copyWith(deckIds: const {})),
                  ),
                  for (final summary in decks)
                    FilterChip(
                      label: Text(summary.deck.title),
                      selected: _draft.deckIds.contains(summary.deck.id),
                      onSelected: (selected) => _update(
                        (d) => d.copyWith(
                          deckIds: selected
                              ? {...d.deckIds, summary.deck.id}
                              : ({...d.deckIds}..remove(summary.deck.id)),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            _Section(
              title: l10n.examFieldSelection,
              child: RadioGroup<ExamSelection>(
                groupValue: _draft.selection,
                onChanged: (value) {
                  if (value != null) {
                    _update((d) => d.copyWith(selection: value));
                  }
                },
                child: QyicPanel(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Column(
                    children: [
                      for (final selection in ExamSelection.values)
                        RadioListTile<ExamSelection>(
                          value: selection,
                          title: Text(selection.label(l10n)),
                          subtitle: Text(
                            selection.description(l10n),
                            style: textTheme.bodySmall,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
            _Section(
              title: l10n.examFieldQuestions,
              trailing: Text(
                '${_draft.questionCount}',
                style: QyicTextStyles.mono(
                  context,
                  size: 16,
                  color: QyicColors.textPrimary,
                ),
              ),
              child: Slider(
                value: _draft.questionCount.toDouble(),
                min: ExamPreset.questionCountRange.min.toDouble(),
                max: ExamPreset.questionCountRange.max.toDouble(),
                divisions:
                    (ExamPreset.questionCountRange.max -
                        ExamPreset.questionCountRange.min) ~/
                    5,
                label: '${_draft.questionCount}',
                onChanged: (value) =>
                    _update((d) => d.copyWith(questionCount: value.round())),
              ),
            ),
            _Section(
              title: l10n.examFieldTimeLimit,
              child: _ChoiceChips<int?>(
                choices: ExamPreset.timeLimitChoices,
                selected: _draft.timeLimit?.inMinutes,
                label: (minutes) => minutes == null
                    ? l10n.examUntimed
                    : l10n.durationMinutes(minutes),
                onSelected: (minutes) => _update(
                  (d) => d.copyWith(
                    timeLimit: () =>
                        minutes == null ? null : Duration(minutes: minutes),
                  ),
                ),
              ),
            ),
            _Section(
              title: l10n.examFieldTimePerQuestion,
              child: _ChoiceChips<int?>(
                choices: ExamPreset.timePerQuestionChoices,
                selected: _draft.timePerQuestion?.inSeconds,
                label: (seconds) => seconds == null
                    ? l10n.examUntimed
                    : l10n.durationSeconds(seconds),
                onSelected: (seconds) => _update(
                  (d) => d.copyWith(
                    timePerQuestion: () =>
                        seconds == null ? null : Duration(seconds: seconds),
                  ),
                ),
              ),
            ),
            _Section(
              title: l10n.examFieldQuizTypes,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      for (final type in QuizType.values)
                        FilterChip(
                          label: Text(type.label(l10n)),
                          selected: _draft.quizTypes.contains(type),
                          onSelected: (selected) => _update(
                            (d) => d.copyWith(
                              quizTypes: selected
                                  ? {...d.quizTypes, type}
                                  : ({...d.quizTypes}..remove(type)),
                            ),
                          ),
                        ),
                    ],
                  ),
                  if (issues.contains(ExamPresetIssue.noQuizTypes)) ...[
                    const SizedBox(height: 8),
                    Text(
                      ExamPresetIssue.noQuizTypes.label(l10n),
                      style: textTheme.bodySmall?.copyWith(
                        color: QyicColors.failure,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(height: 20),
            QyicPanel(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Column(
                children: [
                  SwitchListTile(
                    value: _draft.includeNew,
                    onChanged: (value) =>
                        _update((d) => d.copyWith(includeNew: value)),
                    title: Text(l10n.examFieldIncludeNew),
                    subtitle: Text(
                      l10n.examFieldIncludeNewDetail,
                      style: textTheme.bodySmall,
                    ),
                  ),
                  const Divider(indent: 16, endIndent: 16),
                  SwitchListTile(
                    value: _draft.autoRate,
                    onChanged: (value) =>
                        _update((d) => d.copyWith(autoRate: value)),
                    title: Text(l10n.examFieldAutoRate),
                    subtitle: Text(
                      l10n.examFieldAutoRateDetail,
                      style: textTheme.bodySmall,
                    ),
                  ),
                  const Divider(indent: 16, endIndent: 16),
                  SwitchListTile(
                    value: _draft.allowHints,
                    onChanged: (value) =>
                        _update((d) => d.copyWith(allowHints: value)),
                    title: Text(l10n.examFieldAllowHints),
                    subtitle: Text(
                      l10n.examFieldAllowHintsDetail,
                      style: textTheme.bodySmall,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Text(l10n.examAffectsSchedule, style: textTheme.bodySmall),
            const SizedBox(height: 20),
            QyicPrimaryButton(
              label: l10n.actionSave,
              onPressed: _saving ? null : _save,
            ),
          ],
        ),
      ),
    );
  }
}

class _Section extends StatelessWidget {
  const _Section({required this.title, required this.child, this.trailing});

  final String title;
  final Widget child;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(child: QyicSectionLabel(title)),
              ?trailing,
            ],
          ),
          const SizedBox(height: 10),
          child,
        ],
      ),
    );
  }
}

class _ChoiceChips<T> extends StatelessWidget {
  const _ChoiceChips({
    required this.choices,
    required this.selected,
    required this.label,
    required this.onSelected,
  });

  final List<T> choices;
  final T selected;
  final String Function(T value) label;
  final ValueChanged<T> onSelected;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        for (final choice in choices)
          ChoiceChip(
            label: Text(label(choice)),
            selected: choice == selected,
            onSelected: (_) => onSelected(choice),
          ),
      ],
    );
  }
}

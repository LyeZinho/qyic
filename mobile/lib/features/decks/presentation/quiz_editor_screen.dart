import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/ids.dart';
import '../../../core/theme/qyic_colors.dart';
import '../../../core/widgets/qyic_primary_button.dart';
import '../../../core/widgets/qyic_shared_widgets.dart';
import '../../../l10n/l10n.dart';
import '../../../l10n/labels.dart';
import '../data/deck_repository.dart';
import '../domain/deck.dart';
import '../domain/quiz_validation.dart';

/// Creates a quiz in [deckId], or edits [quiz]. The type of an existing quiz
/// is fixed: a different type is different content with its own history.
class QuizEditorScreen extends ConsumerStatefulWidget {
  const QuizEditorScreen({super.key, required this.deckId, this.quiz});

  final String deckId;
  final Quiz? quiz;

  @override
  ConsumerState<QuizEditorScreen> createState() => _QuizEditorScreenState();
}

class _QuizEditorScreenState extends ConsumerState<QuizEditorScreen> {
  static const _maxOptions = 6;
  static const _maxPairs = 8;

  late QuizType _type;
  late final TextEditingController _question;
  late final TextEditingController _explanation;
  late final TextEditingController _hint;
  late final List<_OptionDraft> _choices;
  late final List<_OptionDraft> _answers;
  late final List<_OptionDraft> _pairs;
  bool _statementIsTrue = true;
  List<QuizIssue> _issues = const [];
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    final quiz = widget.quiz;
    _type = quiz?.type ?? QuizType.multipleChoice;
    _question = TextEditingController(text: quiz?.question);
    _explanation = TextEditingController(text: quiz?.explanation);
    _hint = TextEditingController(text: quiz?.hint);

    List<_OptionDraft> draftsFor(QuizType type, int blankCount) =>
        quiz?.type == type
        ? quiz!.options.map(_OptionDraft.from).toList()
        : List.generate(blankCount, (_) => _OptionDraft());

    _choices = draftsFor(QuizType.multipleChoice, 4);
    _answers = draftsFor(QuizType.fillInTheBlank, 1);
    _pairs = draftsFor(QuizType.matching, 3);
    if (quiz?.type == QuizType.trueFalse) {
      _statementIsTrue = quiz!.options.any(
        (option) => option.id == 'true' && option.isCorrect,
      );
    }
  }

  @override
  void dispose() {
    _question.dispose();
    _explanation.dispose();
    _hint.dispose();
    for (final draft in [..._choices, ..._answers, ..._pairs]) {
      draft.dispose();
    }
    super.dispose();
  }

  Quiz _buildQuiz() {
    final options = switch (_type) {
      QuizType.multipleChoice => [for (final d in _choices) d.toOption()],
      QuizType.trueFalse => [
        QuizOption(id: 'true', text: 'True', isCorrect: _statementIsTrue),
        QuizOption(id: 'false', text: 'False', isCorrect: !_statementIsTrue),
      ],
      QuizType.fillInTheBlank => [
        for (final d in _answers) d.toOption(isCorrect: true),
      ],
      QuizType.matching => [for (final d in _pairs) d.toOption()],
      QuizType.flashcard => const <QuizOption>[],
    };
    return Quiz(
      id: widget.quiz?.id ?? newUuid(),
      deckId: widget.deckId,
      type: _type,
      position: widget.quiz?.position ?? 0,
      question: _question.text,
      explanation: _explanation.text,
      hint: _hint.text.trim(),
      options: options,
    );
  }

  Future<void> _save() async {
    final quiz = _buildQuiz();
    final issues = validateQuiz(quiz);
    setState(() => _issues = issues);
    if (issues.isNotEmpty) return;

    setState(() => _saving = true);
    try {
      await ref.read(deckRepositoryProvider).saveQuiz(quiz);
      if (mounted) Navigator.of(context).pop();
    } on QuizValidationException catch (error) {
      if (mounted) setState(() => _issues = error.issues);
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  void _add(List<_OptionDraft> drafts) =>
      setState(() => drafts.add(_OptionDraft()));

  void _remove(List<_OptionDraft> drafts, _OptionDraft draft) {
    setState(() => drafts.remove(draft));
    draft.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final isNew = widget.quiz == null;
    return Scaffold(
      appBar: AppBar(
        title: Text(isNew ? l10n.quizEditorNew : l10n.quizEditorEdit),
      ),
      body: QyicContentWidth(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
          children: [
            if (isNew) ...[
              QyicSectionLabel(l10n.quizEditorType),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  for (final type in QuizType.values)
                    ChoiceChip(
                      label: Text(type.label(l10n)),
                      selected: _type == type,
                      onSelected: (_) => setState(() {
                        _type = type;
                        _issues = const [];
                      }),
                    ),
                ],
              ),
              const SizedBox(height: 20),
            ],
            _Field(
              label: switch (_type) {
                QuizType.multipleChoice => l10n.quizEditorQuestion,
                QuizType.trueFalse => l10n.quizEditorStatement,
                QuizType.flashcard => l10n.quizEditorFront,
                QuizType.fillInTheBlank => l10n.quizEditorSentence,
                QuizType.matching => l10n.quizEditorInstructions,
              },
              controller: _question,
              hint: switch (_type) {
                QuizType.fillInTheBlank => l10n.quizEditorSentenceHint,
                QuizType.matching => l10n.quizEditorInstructionsHint,
                _ => null,
              },
            ),
            const SizedBox(height: 20),
            _Field(
              label: l10n.quizEditorHint,
              controller: _hint,
              hint: l10n.quizEditorHintHint,
            ),
            const SizedBox(height: 20),
            ..._typeSpecificFields(),
            _Field(
              label: _type == QuizType.flashcard
                  ? l10n.quizEditorBack
                  : l10n.quizEditorExplanation,
              controller: _explanation,
            ),
            if (_issues.isNotEmpty) ...[
              const SizedBox(height: 16),
              QyicPanel(
                borderColor: QyicColors.failure,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (final issue in _issues)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2),
                        child: Text(
                          '• ${issue.label(l10n)}',
                          style: const TextStyle(color: QyicColors.failure),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
          child: QyicPrimaryButton(
            label: l10n.quizEditorSave,
            onPressed: _saving ? null : _save,
          ),
        ),
      ),
    );
  }

  List<Widget> _typeSpecificFields() {
    final l10n = context.l10n;
    switch (_type) {
      case QuizType.multipleChoice:
        return [
          QyicSectionLabel(l10n.quizEditorOptions),
          const SizedBox(height: 8),
          RadioGroup<_OptionDraft>(
            groupValue: _choices.where((d) => d.isCorrect).firstOrNull,
            onChanged: (selected) => setState(() {
              for (final draft in _choices) {
                draft.isCorrect = identical(draft, selected);
              }
            }),
            child: Column(
              children: [
                for (final (index, draft) in _choices.indexed)
                  _DraftRow(
                    key: ObjectKey(draft),
                    leading: Radio<_OptionDraft>(value: draft),
                    fields: [
                      _inlineField(
                        draft.text,
                        l10n.quizEditorOptionN(index + 1),
                      ),
                    ],
                    onRemove: _choices.length > 2
                        ? () => _remove(_choices, draft)
                        : null,
                  ),
              ],
            ),
          ),
          if (_choices.length < _maxOptions)
            _AddButton(
              label: l10n.quizEditorAddOption,
              onPressed: () => _add(_choices),
            ),
          const SizedBox(height: 20),
        ];
      case QuizType.trueFalse:
        return [
          QyicSectionLabel(l10n.quizEditorStatementIs),
          const SizedBox(height: 8),
          SegmentedButton<bool>(
            segments: [
              ButtonSegment(value: true, label: Text(l10n.trueFalseTrue)),
              ButtonSegment(value: false, label: Text(l10n.trueFalseFalse)),
            ],
            selected: {_statementIsTrue},
            onSelectionChanged: (value) =>
                setState(() => _statementIsTrue = value.single),
          ),
          const SizedBox(height: 20),
        ];
      case QuizType.fillInTheBlank:
        return [
          QyicSectionLabel(l10n.quizEditorAccepted),
          const SizedBox(height: 8),
          for (final (index, draft) in _answers.indexed)
            _DraftRow(
              key: ObjectKey(draft),
              fields: [
                _inlineField(draft.text, l10n.quizEditorAnswerN(index + 1)),
              ],
              onRemove: _answers.length > 1
                  ? () => _remove(_answers, draft)
                  : null,
            ),
          if (_answers.length < _maxOptions)
            _AddButton(
              label: l10n.quizEditorAddAnswer,
              onPressed: () => _add(_answers),
            ),
          const SizedBox(height: 20),
        ];
      case QuizType.matching:
        return [
          QyicSectionLabel(l10n.quizEditorPairs),
          const SizedBox(height: 8),
          for (final draft in _pairs)
            _DraftRow(
              key: ObjectKey(draft),
              fields: [
                _inlineField(draft.prompt, l10n.quizEditorTerm),
                _inlineField(draft.text, l10n.quizEditorMatch),
              ],
              onRemove: _pairs.length > 2 ? () => _remove(_pairs, draft) : null,
            ),
          if (_pairs.length < _maxPairs)
            _AddButton(
              label: l10n.quizEditorAddPair,
              onPressed: () => _add(_pairs),
            ),
          const SizedBox(height: 20),
        ];
      case QuizType.flashcard:
        return const [];
    }
  }

  Widget _inlineField(TextEditingController controller, String hint) =>
      TextField(
        controller: controller,
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(hintText: hint, isDense: true),
      );
}

/// Editable option; keeps its id so edits preserve option identity.
class _OptionDraft {
  _OptionDraft({String? id, String text = '', String prompt = ''})
    : id = id ?? newUuid(),
      text = TextEditingController(text: text),
      prompt = TextEditingController(text: prompt);

  factory _OptionDraft.from(QuizOption option) =>
      _OptionDraft(id: option.id, text: option.text, prompt: option.prompt)
        ..isCorrect = option.isCorrect;

  final String id;
  final TextEditingController text;
  final TextEditingController prompt;
  bool isCorrect = false;

  QuizOption toOption({bool? isCorrect}) => QuizOption(
    id: id,
    text: text.text,
    prompt: prompt.text,
    isCorrect: isCorrect ?? this.isCorrect,
  );

  void dispose() {
    text.dispose();
    prompt.dispose();
  }
}

class _Field extends StatelessWidget {
  const _Field({required this.label, required this.controller, this.hint});

  final String label;
  final TextEditingController controller;
  final String? hint;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        QyicSectionLabel(label),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          minLines: 1,
          maxLines: 5,
          textCapitalization: TextCapitalization.sentences,
          decoration: InputDecoration(hintText: hint),
        ),
      ],
    );
  }
}

class _DraftRow extends StatelessWidget {
  const _DraftRow({
    super.key,
    required this.fields,
    this.leading,
    this.onRemove,
  });

  final List<Widget> fields;
  final Widget? leading;
  final VoidCallback? onRemove;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          ?leading,
          for (final (index, field) in fields.indexed) ...[
            if (index > 0) const SizedBox(width: 8),
            Expanded(child: field),
          ],
          IconButton(
            tooltip: context.l10n.actionRemove,
            icon: const Icon(Icons.remove_circle_outline_rounded),
            color: QyicColors.textMuted,
            onPressed: onRemove,
          ),
        ],
      ),
    );
  }
}

class _AddButton extends StatelessWidget {
  const _AddButton({required this.label, required this.onPressed});

  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: TextButton.icon(
        onPressed: onPressed,
        icon: const Icon(Icons.add_rounded, size: 18),
        label: Text(label),
      ),
    );
  }
}

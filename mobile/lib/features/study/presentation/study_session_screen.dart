import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers.dart';
import '../../../core/scheduling/fsrs.dart';
import '../../../core/theme/qyic_colors.dart';
import '../../../core/theme/qyic_theme.dart';
import '../../../core/widgets/qyic_primary_button.dart';
import '../../../core/widgets/qyic_shared_widgets.dart';
import '../../../l10n/l10n.dart';
import '../../../l10n/labels.dart';
import '../../progress/domain/progression.dart';
import '../../settings/settings_repository.dart';
import '../application/study_session_controller.dart';
import '../data/study_repository.dart';
import '../domain/grading.dart';
import '../domain/study_scope.dart';
import 'quiz_views/quiz_view.dart';
import 'session_complete_view.dart';
import 'widgets/answer_haptics.dart';
import 'widgets/rating_bar.dart';

/// Study session for [request]. The default studies every deck.
class StudySessionScreen extends ConsumerWidget {
  const StudySessionScreen({super.key, this.request = const StudyRequest()});

  final StudyRequest request;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final session = ref.watch(studySessionProvider(request));
    return Scaffold(
      body: SafeArea(
        child: QyicContentWidth(
          child: QyicAsyncView(
            value: session,
            data: (state) {
              if (state.isFinished) {
                return state.total == 0
                    ? const _NothingDue()
                    : SessionCompleteView(session: state);
              }
              return _SessionBody(request: request, state: state);
            },
          ),
        ),
      ),
    );
  }
}

class _SessionBody extends StatelessWidget {
  const _SessionBody({required this.request, required this.state});

  final StudyRequest request;
  final StudySessionState state;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final item = state.current!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(8, 8, 20, 12),
          child: Row(
            children: [
              IconButton(
                tooltip: l10n.studyEnd,
                icon: const Icon(Icons.close_rounded),
                onPressed: () => Navigator.of(context).pop(),
              ),
              const SizedBox(width: 4),
              Expanded(
                child: QyicProgressBar(
                  value: state.completed / state.total,
                  height: 10,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                '${state.completed + 1}/${state.total}',
                style: QyicTextStyles.mono(context),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
          child: Row(
            children: [
              QyicPill(
                item.quiz.type.label(l10n).toUpperCase(),
                color: QyicColors.purple,
              ),
              const Spacer(),
              QyicPill(
                l10n.xpAmount(Progression.xpPerRecall),
                color: QyicColors.lime,
                icon: Icons.bolt_rounded,
              ),
            ],
          ),
        ),
        Expanded(
          child: _QuizStage(
            // A fresh stage per presentation, including re-queued cards.
            key: ValueKey('${item.quiz.id}#${state.completed}'),
            request: request,
            item: item,
            isSaving: state.isSaving,
          ),
        ),
      ],
    );
  }
}

class _QuizStage extends ConsumerStatefulWidget {
  const _QuizStage({
    super.key,
    required this.request,
    required this.item,
    required this.isSaving,
  });

  final StudyRequest request;
  final StudyItem item;
  final bool isSaving;

  @override
  ConsumerState<_QuizStage> createState() => _QuizStageState();
}

class _QuizStageState extends ConsumerState<_QuizStage> {
  GradeOutcome? _outcome;

  void _graded(GradeOutcome outcome) {
    AnswerHaptics.graded(ref, outcome);
    setState(() => _outcome = outcome);
  }

  Future<void> _rate(Rating rating) async {
    final outcome = _outcome;
    if (outcome == null) return;
    AnswerHaptics.rated(ref);
    try {
      await ref
          .read(studySessionProvider(widget.request).notifier)
          .rate(rating, outcome);
    } catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(context.l10n.studySaveFailed('$error'))),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final outcome = _outcome;
    final showIntervals =
        ref.watch(settingsProvider).value?.showIntervalPreviews ??
        const AppSettings().showIntervalPreviews;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: QuizView(quiz: widget.item.quiz, onGraded: _graded),
        ),
        if (outcome != null)
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
            child: RatingBar(
              allowed: outcome.allowedRatings,
              preview: ref
                  .read(studySessionProvider(widget.request).notifier)
                  .previewCurrent(),
              now: ref.read(clockProvider)(),
              enabled: !widget.isSaving,
              showIntervals: showIntervals,
              onRate: _rate,
            ),
          ),
      ],
    );
  }
}

class _NothingDue extends StatelessWidget {
  const _NothingDue();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Spacer(),
          QyicPill(l10n.studyAllCaughtUp, color: QyicColors.lime),
          const SizedBox(height: 16),
          Text(
            l10n.studyNothingDue,
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          const SizedBox(height: 8),
          Text(
            l10n.studyNothingDueBody,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const Spacer(flex: 2),
          QyicPrimaryButton(
            label: l10n.actionBack,
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }
}

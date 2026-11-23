import 'dart:async';

import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/formatting.dart';
import '../../../core/providers.dart';
import '../../../core/theme/qyic_colors.dart';
import '../../../core/theme/qyic_theme.dart';
import '../../../core/widgets/qyic_primary_button.dart';
import '../../../core/widgets/qyic_shared_widgets.dart';
import '../../../l10n/l10n.dart';
import '../../../l10n/labels.dart';
import '../../settings/settings_repository.dart';
import '../../study/presentation/quiz_views/quiz_view.dart';
import '../../study/presentation/widgets/answer_haptics.dart';
import '../../study/presentation/widgets/rating_bar.dart';
import '../application/exam_session_controller.dart';
import '../domain/exam.dart';
import 'exam_format.dart';

class ExamSessionScreen extends ConsumerWidget {
  const ExamSessionScreen({super.key, required this.preset});

  final ExamPreset preset;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final session = ref.watch(examSessionProvider(preset));
    final running = session.value?.isFinished == false;
    return PopScope(
      canPop: !running,
      onPopInvokedWithResult: (didPop, _) async {
        if (didPop) return;
        if (await _confirmStop(context) && context.mounted) {
          await ref
              .read(examSessionProvider(preset).notifier)
              .finish(ExamEndReason.stopped);
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: QyicContentWidth(
            child: QyicAsyncView(
              value: session,
              data: (state) => state.isFinished
                  ? _ExamResults(state: state)
                  : _ExamBody(state: state),
            ),
          ),
        ),
      ),
    );
  }
}

Future<bool> _confirmStop(BuildContext context) async {
  final l10n = context.l10n;
  final stop = await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(l10n.examStopTitle),
      content: Text(l10n.examStopBody),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text(l10n.examKeepGoing),
        ),
        FilledButton(
          style: FilledButton.styleFrom(backgroundColor: QyicColors.coral),
          onPressed: () => Navigator.of(context).pop(true),
          child: Text(l10n.examStop),
        ),
      ],
    ),
  );
  return stop ?? false;
}

class _ExamBody extends ConsumerWidget {
  const _ExamBody({required this.state});

  final ExamSessionState state;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final item = state.current!;
    final total = state.queue.length;
    final controller = ref.read(examSessionProvider(state.preset).notifier);
    final questionDeadline = state.questionDeadline;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(8, 8, 20, 8),
          child: Row(
            children: [
              IconButton(
                tooltip: l10n.examStop,
                icon: const Icon(Icons.close_rounded),
                onPressed: () => Navigator.of(context).maybePop(),
              ),
              const SizedBox(width: 4),
              Expanded(
                child: QyicProgressBar(
                  value: state.answers.length / total,
                  color: QyicColors.purple,
                  height: 10,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                '${state.index + 1}/$total',
                style: QyicTextStyles.mono(context),
              ),
              if (state.deadline case final deadline?) ...[
                const SizedBox(width: 12),
                _Countdown(deadline: deadline),
              ],
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
          child: Row(
            children: [
              QyicPill(l10n.examPill, color: QyicColors.coral),
              const SizedBox(width: 8),
              QyicPill(
                item.quiz.type.label(l10n).toUpperCase(),
                color: QyicColors.purple,
              ),
              const Spacer(),
              if (questionDeadline != null)
                _Countdown(deadline: questionDeadline, compact: true),
            ],
          ),
        ),
        if (questionDeadline != null && state.preset.timePerQuestion != null)
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 8),
            child: _QuestionTimerBar(
              key: ValueKey(state.questionStartedAt),
              limit: state.preset.timePerQuestion!,
              startedAt: state.questionStartedAt,
            ),
          ),
        Expanded(
          child: QuizView(
            key: ValueKey('${item.quiz.id}#${state.index}'),
            quiz: item.quiz,
            enabled: state.phase == ExamPhase.answering && !state.isSaving,
            allowLetterHint: state.preset.allowHints,
            onGraded: (outcome) {
              AnswerHaptics.graded(ref, outcome);
              unawaited(_guard(context, controller.answer(outcome)));
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
          child: switch (state.phase) {
            ExamPhase.answering => const SizedBox.shrink(),
            ExamPhase.rating => RatingBar(
              allowed: state.pendingOutcome!.allowedRatings,
              preview: controller.previewCurrent(),
              now: ref.read(clockProvider)(),
              enabled: !state.isSaving,
              showIntervals:
                  ref.watch(settingsProvider).value?.showIntervalPreviews ??
                  true,
              onRate: (rating) {
                AnswerHaptics.rated(ref);
                unawaited(_guard(context, controller.rate(rating)));
              },
            ),
            ExamPhase.feedback => _FeedbackFooter(
              answer: state.currentAnswer!,
              isLast: state.timeUp || state.answers.length == total,
              timeUp: state.timeUp,
              onNext: controller.next,
            ),
          },
        ),
      ],
    );
  }

  static Future<void> _guard(BuildContext context, Future<void> action) async {
    try {
      await action;
    } catch (error) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(context.l10n.studySaveFailed('$error'))),
      );
    }
  }
}

class _FeedbackFooter extends StatelessWidget {
  const _FeedbackFooter({
    required this.answer,
    required this.isLast,
    required this.timeUp,
    required this.onNext,
  });

  final ExamAnswer answer;
  final bool isLast;
  final bool timeUp;
  final VoidCallback onNext;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final textTheme = Theme.of(context).textTheme;
    final expected = answer.timedOut ? expectedAnswer(answer.item.quiz) : null;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (answer.timedOut)
          QyicPanel(
            borderColor: QyicColors.failure,
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: '${l10n.examQuestionTimeUp} ',
                    style: const TextStyle(
                      color: QyicColors.failure,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  if (expected != null && expected.isNotEmpty)
                    TextSpan(
                      text: l10n.choiceAnswer(expected),
                      style: const TextStyle(color: QyicColors.textPrimary),
                    ),
                ],
              ),
              style: textTheme.bodyMedium,
            ),
          ),
        if (timeUp) ...[
          const SizedBox(height: 8),
          Text(
            l10n.examTimeUpBanner,
            style: textTheme.bodyMedium?.copyWith(color: QyicColors.orange),
          ),
        ],
        const SizedBox(height: 10),
        Row(
          children: [
            QyicPill(
              l10n.examRatedAs(answer.rating.label(l10n)),
              color: QyicColors.forRating(answer.rating),
            ),
            const Spacer(),
          ],
        ),
        const SizedBox(height: 10),
        QyicPrimaryButton(
          label: isLast ? l10n.examSeeResults : l10n.examNextQuestion,
          icon: isLast ? Icons.flag_rounded : Icons.arrow_forward_rounded,
          onPressed: onNext,
        ),
      ],
    );
  }
}

/// Remaining time until [deadline], refreshed every second.
class _Countdown extends ConsumerStatefulWidget {
  const _Countdown({required this.deadline, this.compact = false});

  final DateTime deadline;
  final bool compact;

  @override
  ConsumerState<_Countdown> createState() => _CountdownState();
}

class _CountdownState extends ConsumerState<_Countdown> {
  late final Timer _ticker;

  @override
  void initState() {
    super.initState();
    _ticker = Timer.periodic(
      const Duration(seconds: 1),
      (_) => setState(() {}),
    );
  }

  @override
  void dispose() {
    _ticker.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final remaining = widget.deadline.difference(ref.read(clockProvider)());
    final urgent = remaining < const Duration(seconds: 10);
    final color = urgent ? QyicColors.coral : QyicColors.textPrimary;
    // Round up so the display reaches 0:00 exactly when time runs out.
    final shown = remaining.isNegative
        ? Duration.zero
        : Duration(seconds: (remaining.inMilliseconds / 1000).ceil());
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          widget.compact ? Icons.timer_outlined : Icons.hourglass_top_rounded,
          size: 16,
          color: color,
        ),
        const SizedBox(width: 4),
        Text(
          formatElapsed(shown),
          style: QyicTextStyles.mono(
            context,
            size: widget.compact ? 13 : 14,
            color: color,
            weight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}

/// Shrinking bar for the per-question limit.
class _QuestionTimerBar extends ConsumerWidget {
  const _QuestionTimerBar({
    super.key,
    required this.limit,
    required this.startedAt,
  });

  final Duration limit;
  final DateTime startedAt;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final elapsed = ref.read(clockProvider)().difference(startedAt);
    final remaining = limit - elapsed;
    final start = (remaining.inMilliseconds / limit.inMilliseconds).clamp(
      0.0,
      1.0,
    );
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: start, end: 0),
      duration: remaining.isNegative ? Duration.zero : remaining,
      builder: (context, value, _) => QyicProgressBar(
        value: value,
        height: 4,
        color: value < 0.25 ? QyicColors.coral : QyicColors.orange,
      ),
    );
  }
}

class _ExamResults extends ConsumerWidget {
  const _ExamResults({required this.state});

  final ExamSessionState state;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final textTheme = Theme.of(context).textTheme;
    if (state.queue.isEmpty) return _NoCards(preset: state.preset);

    final total = state.queue.length;
    final score = total == 0 ? 0.0 : state.correctCount / total;
    final missed = state.answers.where((a) => !a.isCorrect).toList();
    final unanswered = total - state.answers.length;
    final elapsed = state.finishedAt!.difference(state.startedAt);

    return ListView(
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
      children: [
        Align(
          alignment: AlignmentDirectional.centerStart,
          child: QyicPill(
            state.endReason!.label(l10n).toUpperCase(),
            color: state.endReason == ExamEndReason.completed
                ? QyicColors.lime
                : QyicColors.orange,
          ),
        ),
        const SizedBox(height: 16),
        Text(state.preset.name, style: textTheme.bodyMedium),
        const SizedBox(height: 4),
        Text(
          formatPercent(l10n, score),
          style: QyicTextStyles.mono(
            context,
            size: 64,
            color: scoreColor(score),
            weight: FontWeight.w700,
          ),
        ),
        Text(
          l10n.examCorrectOf(state.correctCount, total),
          style: textTheme.titleLarge,
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            _ResultStat(
              value: '${state.answers.length}',
              label: l10n.examAnswered,
            ),
            const SizedBox(width: 12),
            _ResultStat(value: '$unanswered', label: l10n.examUnanswered),
            const SizedBox(width: 12),
            _ResultStat(value: formatElapsed(elapsed), label: l10n.statTime),
          ],
        ),
        if (missed.isNotEmpty) ...[
          const SizedBox(height: 24),
          QyicSectionLabel(l10n.examMissed(missed.length)),
          const SizedBox(height: 8),
          QyicPanel(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Column(
              children: [
                for (final (index, answer) in missed.indexed) ...[
                  if (index > 0) const Divider(indent: 16),
                  ListTile(
                    dense: true,
                    title: Text(
                      answer.item.quiz.question,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    subtitle: Text(
                      expectedAnswer(answer.item.quiz),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: textTheme.bodySmall?.copyWith(
                        color: QyicColors.teal,
                      ),
                    ),
                    trailing: answer.timedOut
                        ? const Icon(
                            Icons.timer_off_outlined,
                            color: QyicColors.coral,
                            size: 18,
                          )
                        : null,
                  ),
                ],
              ],
            ),
          ),
        ],
        const SizedBox(height: 12),
        Text(
          l10n.examReviewsSaved(state.answers.length),
          style: textTheme.bodySmall,
        ),
        const SizedBox(height: 24),
        QyicPrimaryButton(
          label: l10n.examRetake,
          icon: Icons.replay_rounded,
          onPressed: () => ref.invalidate(examSessionProvider(state.preset)),
        ),
        const SizedBox(height: 10),
        OutlinedButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(l10n.actionDone),
        ),
      ],
    );
  }
}

class _ResultStat extends StatelessWidget {
  const _ResultStat({required this.value, required this.label});

  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: QyicPanel(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              value,
              style: QyicTextStyles.mono(
                context,
                size: 20,
                color: QyicColors.textPrimary,
                weight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 2),
            Text(label, style: Theme.of(context).textTheme.bodySmall),
          ],
        ),
      ),
    );
  }
}

class _NoCards extends StatelessWidget {
  const _NoCards({required this.preset});

  final ExamPreset preset;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Spacer(),
          Text(
            l10n.examNoCards,
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          const SizedBox(height: 8),
          Text(
            preset.includeNew ? l10n.examNoCardsBody : l10n.examNoCardsBodyNew,
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

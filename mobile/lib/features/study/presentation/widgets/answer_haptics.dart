import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../settings/settings_repository.dart';
import '../../domain/grading.dart';

/// Vibration on answers, honoring the Preferences switch.
abstract final class AnswerHaptics {
  static void graded(WidgetRef ref, GradeOutcome outcome) {
    if (!_enabled(ref)) return;
    switch (outcome) {
      case GradeOutcome.correct:
        HapticFeedback.lightImpact();
      case GradeOutcome.incorrect:
        HapticFeedback.heavyImpact();
      case GradeOutcome.selfGraded:
        HapticFeedback.selectionClick();
    }
  }

  static void rated(WidgetRef ref) {
    if (_enabled(ref)) HapticFeedback.selectionClick();
  }

  static bool _enabled(WidgetRef ref) =>
      ref.read(settingsProvider).value?.hapticFeedback ??
      const AppSettings().hapticFeedback;
}

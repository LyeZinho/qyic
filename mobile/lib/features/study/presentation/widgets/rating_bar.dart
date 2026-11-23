import 'package:flutter/material.dart';

import '../../../../core/formatting.dart';
import '../../../../core/scheduling/fsrs.dart';
import '../../../../core/theme/qyic_colors.dart';
import '../../../../core/theme/qyic_theme.dart';
import '../../../../core/widgets/qyic_shared_widgets.dart';
import '../../../../l10n/l10n.dart';
import '../../../../l10n/labels.dart';

/// FSRS rating buttons, optionally labelled with the interval each rating
/// would give. With a single allowed rating (a wrong answer) it collapses
/// into one "Continue" button.
class RatingBar extends StatelessWidget {
  const RatingBar({
    super.key,
    required this.allowed,
    required this.preview,
    required this.now,
    required this.onRate,
    this.enabled = true,
    this.showIntervals = true,
  });

  final List<Rating> allowed;
  final Map<Rating, SchedulingCard> preview;
  final DateTime now;
  final ValueChanged<Rating> onRate;
  final bool enabled;
  final bool showIntervals;

  String? _intervalOf(AppLocalizations l10n, Rating rating) {
    final next = preview[rating];
    if (!showIntervals || next == null) return null;
    return formatInterval(l10n, next.due.difference(now));
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    if (allowed.length == 1) {
      final rating = allowed.single;
      final interval = _intervalOf(l10n, rating);
      return _RatingButton(
        title: l10n.actionContinue,
        subtitle: interval == null ? null : l10n.ratingReviewAgainIn(interval),
        color: QyicColors.forRating(rating),
        onPressed: enabled ? () => onRate(rating) : null,
      );
    }
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        QyicSectionLabel(l10n.ratingQuestion),
        const SizedBox(height: 12),
        Row(
          children: [
            for (final (index, rating) in allowed.indexed) ...[
              if (index > 0) const SizedBox(width: 8),
              Expanded(
                child: _RatingButton(
                  title: rating.label(l10n),
                  subtitle: _intervalOf(l10n, rating),
                  color: QyicColors.forRating(rating),
                  onPressed: enabled ? () => onRate(rating) : null,
                ),
              ),
            ],
          ],
        ),
      ],
    );
  }
}

class _RatingButton extends StatelessWidget {
  const _RatingButton({
    required this.title,
    required this.subtitle,
    required this.color,
    required this.onPressed,
  });

  final String title;
  final String? subtitle;
  final Color color;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final subtitle = this.subtitle;
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        minimumSize: const Size.fromHeight(64),
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 10),
        backgroundColor: QyicColors.surface,
        side: BorderSide(color: color, width: 1.5),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: color, fontWeight: FontWeight.w700),
          ),
          if (subtitle != null) ...[
            const SizedBox(height: 2),
            Text(
              subtitle,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: color.withValues(alpha: 0.85),
                fontSize: 11,
                fontFamily: QyicFonts.mono,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

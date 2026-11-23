import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../l10n/l10n.dart';
import '../theme/qyic_colors.dart';

class QyicSectionLabel extends StatelessWidget {
  const QyicSectionLabel(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text.toUpperCase(),
      style: Theme.of(context).textTheme.labelSmall,
    );
  }
}

class QyicProgressBar extends StatelessWidget {
  const QyicProgressBar({
    super.key,
    required this.value,
    this.color = QyicColors.lime,
    this.trackColor = QyicColors.surfaceElevated,
    this.height = 8,
  });

  final double value;
  final Color color;
  final Color trackColor;
  final double height;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(height),
      child: LinearProgressIndicator(
        value: value.clamp(0, 1),
        minHeight: height,
        backgroundColor: trackColor,
        color: color,
      ),
    );
  }
}

/// Outlined label, e.g. "12 due" or "MULTIPLE CHOICE".
class QyicPill extends StatelessWidget {
  const QyicPill(this.label, {super.key, required this.color, this.icon});

  final String label;
  final Color color;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withValues(alpha: 0.7)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 14, color: color),
            const SizedBox(width: 4),
          ],
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 12,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.4,
            ),
          ),
        ],
      ),
    );
  }
}

/// Rounded, bordered surface used for cards throughout the app.
class QyicPanel extends StatelessWidget {
  const QyicPanel({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16),
    this.borderColor = QyicColors.border,
    this.color = QyicColors.surface,
    this.onTap,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final Color borderColor;
  final Color color;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final shape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
      side: BorderSide(color: borderColor, width: 1.5),
    );
    return Material(
      color: color,
      shape: shape,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(padding: padding, child: child),
      ),
    );
  }
}

/// Renders an [AsyncValue] with consistent loading and error states.
class QyicAsyncView<T> extends StatelessWidget {
  const QyicAsyncView({super.key, required this.value, required this.data});

  final AsyncValue<T> value;
  final Widget Function(T data) data;

  @override
  Widget build(BuildContext context) {
    // Keep showing the previous data while a dependency (e.g. the minute
    // tick) re-runs the provider.
    return value.when(
      skipLoadingOnReload: true,
      data: data,
      error: (error, _) => Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Text(
            context.l10n.errorGeneric('$error'),
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
      ),
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }
}

/// Centers [child] and caps its width so phone-first layouts stay readable
/// on tablets and desktop windows.
class QyicContentWidth extends StatelessWidget {
  const QyicContentWidth({super.key, required this.child, this.maxWidth = 640});

  final Widget child;
  final double maxWidth;

  @override
  Widget build(BuildContext context) => Align(
    alignment: Alignment.topCenter,
    child: ConstrainedBox(
      constraints: BoxConstraints(maxWidth: maxWidth),
      child: child,
    ),
  );
}

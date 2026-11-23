import 'package:material_ui/material_ui.dart';

import '../theme/qyic_colors.dart';

class QyicPrimaryButton extends StatelessWidget {
  const QyicPrimaryButton({
    super.key,
    required this.label,
    this.icon,
    this.onPressed,
    this.expanded = true,
  });

  final String label;
  final IconData? icon;
  final VoidCallback? onPressed;
  final bool expanded;

  @override
  Widget build(BuildContext context) {
    final style = FilledButton.styleFrom(
      backgroundColor: QyicColors.lime,
      disabledBackgroundColor: QyicColors.lime.withValues(alpha: 0.35),
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
    );

    final Widget button;
    if (icon != null) {
      button = FilledButton.icon(
        onPressed: onPressed,
        icon: Icon(icon, size: 20, color: QyicColors.limeDark),
        label: Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.w700,
            color: QyicColors.limeDark,
          ),
        ),
        style: style,
      );
    } else {
      button = FilledButton(
        onPressed: onPressed,
        style: style,
        child: Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.w700,
            color: QyicColors.limeDark,
          ),
        ),
      );
    }

    if (!expanded) return button;
    return SizedBox(width: double.infinity, child: button);
  }
}

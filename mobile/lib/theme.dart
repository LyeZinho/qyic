import 'package:flutter/material.dart';

/// Design tokens from `planning/mockups-wireframes/` (Design Spec v1.0).
abstract final class QyicColors {
  static const base = Color(0xFF0F172A);
  static const surface = Color(0xFF1E293B);
  static const border = Color(0xFF334155);
  static const primary = Color(0xFF6366F1);
  static const xp = Color(0xFFF59E0B);
  static const success = Color(0xFF10B981);
  static const warning = Color(0xFFF97316);
  static const error = Color(0xFFEF4444);
  static const text = Color(0xFFF8FAFC);
  static const muted = Color(0xFF94A3B8);
}

/// Dark Material 3 theme built from [QyicColors].
ThemeData buildQyicTheme() {
  final scheme = ColorScheme.fromSeed(
    seedColor: QyicColors.primary,
    brightness: Brightness.dark,
  ).copyWith(
    primary: QyicColors.primary,
    onPrimary: Colors.white,
    surface: QyicColors.surface,
    onSurface: QyicColors.text,
    onSurfaceVariant: QyicColors.muted,
    outline: QyicColors.border,
    error: QyicColors.error,
    tertiary: QyicColors.xp,
  );

  return ThemeData(
    useMaterial3: true,
    colorScheme: scheme,
    scaffoldBackgroundColor: QyicColors.base,
    cardTheme: CardThemeData(
      color: QyicColors.surface,
      elevation: 0,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: QyicColors.border),
      ),
    ),
    textTheme: Typography.whiteMountainView.apply(
      bodyColor: QyicColors.text,
      displayColor: QyicColors.text,
    ),
  );
}

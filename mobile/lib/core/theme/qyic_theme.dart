import 'package:cupertino_ui/cupertino_ui.dart';
import 'package:material_ui/material_ui.dart';

import 'qyic_colors.dart';

/// Bundled font families (SIL OFL 1.1, see `assets/fonts/`).
abstract final class QyicFonts {
  static const sans = 'SpaceGrotesk';
  static const mono = 'JetBrainsMono';
}

/// Monospace styles for counters, codes, and timers, as in the mockups.
abstract final class QyicTextStyles {
  static TextStyle mono(
    BuildContext context, {
    double size = 13,
    Color color = QyicColors.textSecondary,
    FontWeight weight = FontWeight.w500,
  }) => TextStyle(
    fontFamily: QyicFonts.mono,
    fontSize: size,
    color: color,
    fontWeight: weight,
    fontFeatures: const [FontFeature.tabularFigures()],
  );
}

abstract final class QyicTheme {
  static ThemeData dark() {
    const scheme = ColorScheme.dark(
      surface: QyicColors.background,
      onSurface: QyicColors.textPrimary,
      surfaceContainerHighest: QyicColors.surfaceElevated,
      primary: QyicColors.lime,
      onPrimary: QyicColors.limeDark,
      secondary: QyicColors.purple,
      onSecondary: QyicColors.textPrimary,
      error: QyicColors.failure,
      outline: QyicColors.border,
      outlineVariant: QyicColors.border,
    );
    final rounded14 = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(14),
    );
    const panelSide = BorderSide(color: QyicColors.border, width: 1.5);

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      fontFamily: QyicFonts.sans,
      colorScheme: scheme,
      scaffoldBackgroundColor: QyicColors.background,
      dividerColor: QyicColors.border,
      dividerTheme: const DividerThemeData(
        color: QyicColors.border,
        thickness: 1,
        space: 1,
      ),
      // Ripple rather than the InkSparkle fragment shader, which is suspected
      // of leaving grey, empty regions on Android (app bars, bottom bar).
      splashFactory: InkRipple.splashFactory,
      appBarTheme: const AppBarTheme(
        backgroundColor: QyicColors.background,
        foregroundColor: QyicColors.textPrimary,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        titleTextStyle: TextStyle(
          fontFamily: QyicFonts.sans,
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: QyicColors.textPrimary,
        ),
      ),
      cardTheme: CardThemeData(
        color: QyicColors.surface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: panelSide,
        ),
        margin: EdgeInsets.zero,
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: QyicColors.surface,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: panelSide,
        ),
        titleTextStyle: const TextStyle(
          fontFamily: QyicFonts.sans,
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: QyicColors.textPrimary,
        ),
      ),
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: QyicColors.surface,
        surfaceTintColor: Colors.transparent,
        showDragHandle: true,
        dragHandleColor: QyicColors.border,
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: QyicColors.surfaceElevated,
        contentTextStyle: const TextStyle(
          fontFamily: QyicFonts.sans,
          color: QyicColors.textPrimary,
          fontSize: 14,
        ),
        shape: rounded14,
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: QyicColors.lime,
          foregroundColor: QyicColors.limeDark,
          disabledBackgroundColor: QyicColors.surfaceElevated,
          disabledForegroundColor: QyicColors.textMuted,
          minimumSize: const Size(64, 44),
          shape: rounded14,
          textStyle: const TextStyle(
            fontFamily: QyicFonts.sans,
            fontWeight: FontWeight.w700,
            fontSize: 15,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: QyicColors.textPrimary,
          side: panelSide,
          minimumSize: const Size(64, 44),
          shape: rounded14,
          textStyle: const TextStyle(
            fontFamily: QyicFonts.sans,
            fontWeight: FontWeight.w600,
            fontSize: 15,
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: QyicColors.lime,
          textStyle: const TextStyle(
            fontFamily: QyicFonts.sans,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith(
          (states) => states.contains(WidgetState.selected)
              ? QyicColors.limeDark
              : QyicColors.textSecondary,
        ),
        trackColor: WidgetStateProperty.resolveWith(
          (states) => states.contains(WidgetState.selected)
              ? QyicColors.lime
              : QyicColors.surfaceElevated,
        ),
        trackOutlineColor: const WidgetStatePropertyAll(QyicColors.border),
      ),
      sliderTheme: const SliderThemeData(
        activeTrackColor: QyicColors.purple,
        inactiveTrackColor: QyicColors.surfaceElevated,
        thumbColor: QyicColors.purple,
        overlayColor: Color(0x338B7CF6),
        valueIndicatorColor: QyicColors.surfaceElevated,
        valueIndicatorTextStyle: TextStyle(
          fontFamily: QyicFonts.mono,
          color: QyicColors.textPrimary,
        ),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: QyicColors.surface,
        selectedColor: QyicColors.lime,
        side: panelSide,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        labelStyle: const TextStyle(
          fontFamily: QyicFonts.sans,
          fontWeight: FontWeight.w600,
          color: QyicColors.textPrimary,
        ),
        secondaryLabelStyle: const TextStyle(
          fontFamily: QyicFonts.sans,
          fontWeight: FontWeight.w700,
          color: QyicColors.limeDark,
        ),
        checkmarkColor: QyicColors.limeDark,
        showCheckmark: false,
      ),
      segmentedButtonTheme: SegmentedButtonThemeData(
        style: ButtonStyle(
          side: const WidgetStatePropertyAll(panelSide),
          shape: WidgetStatePropertyAll(rounded14),
          backgroundColor: WidgetStateProperty.resolveWith(
            (states) => states.contains(WidgetState.selected)
                ? QyicColors.lime
                : QyicColors.surface,
          ),
          foregroundColor: WidgetStateProperty.resolveWith(
            (states) => states.contains(WidgetState.selected)
                ? QyicColors.limeDark
                : QyicColors.textPrimary,
          ),
          textStyle: const WidgetStatePropertyAll(
            TextStyle(fontFamily: QyicFonts.sans, fontWeight: FontWeight.w600),
          ),
        ),
      ),
      radioTheme: RadioThemeData(
        fillColor: WidgetStateProperty.resolveWith(
          (states) => states.contains(WidgetState.selected)
              ? QyicColors.lime
              : QyicColors.textSecondary,
        ),
      ),
      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateProperty.resolveWith(
          (states) => states.contains(WidgetState.selected)
              ? QyicColors.lime
              : Colors.transparent,
        ),
        checkColor: const WidgetStatePropertyAll(QyicColors.limeDark),
        side: const BorderSide(color: QyicColors.textSecondary, width: 1.5),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      ),
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: QyicColors.lime,
      ),
      listTileTheme: const ListTileThemeData(
        iconColor: QyicColors.textSecondary,
        textColor: QyicColors.textPrimary,
      ),
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.android: FadeForwardsPageTransitionsBuilder(),
          TargetPlatform.linux: FadeForwardsPageTransitionsBuilder(),
          TargetPlatform.windows: FadeForwardsPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          TargetPlatform.macOS: CupertinoPageTransitionsBuilder(),
        },
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: QyicColors.surface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: panelSide,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: panelSide,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: QyicColors.lime, width: 1.5),
        ),
        hintStyle: const TextStyle(color: QyicColors.textMuted),
        labelStyle: const TextStyle(
          color: QyicColors.textSecondary,
          letterSpacing: 1.2,
          fontSize: 11,
        ),
      ),
      textTheme: const TextTheme(
        displaySmall: TextStyle(
          fontSize: 40,
          fontWeight: FontWeight.w700,
          color: QyicColors.textPrimary,
          height: 1.05,
          letterSpacing: -0.8,
        ),
        headlineLarge: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.w700,
          color: QyicColors.textPrimary,
          height: 1.15,
          letterSpacing: -0.4,
        ),
        headlineMedium: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w700,
          color: QyicColors.textPrimary,
          height: 1.2,
          letterSpacing: -0.2,
        ),
        titleLarge: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w700,
          color: QyicColors.textPrimary,
        ),
        titleMedium: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w700,
          color: QyicColors.textPrimary,
        ),
        bodyLarge: TextStyle(
          fontSize: 15,
          color: QyicColors.textPrimary,
          height: 1.4,
        ),
        bodyMedium: TextStyle(
          fontSize: 14,
          color: QyicColors.textSecondary,
          height: 1.4,
        ),
        bodySmall: TextStyle(
          fontSize: 12,
          color: QyicColors.textSecondary,
          height: 1.3,
        ),
        labelSmall: TextStyle(
          fontFamily: QyicFonts.mono,
          fontSize: 11,
          fontWeight: FontWeight.w500,
          letterSpacing: 1.4,
          color: QyicColors.textSecondary,
        ),
      ),
    );
  }
}

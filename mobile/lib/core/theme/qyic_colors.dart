import 'package:flutter/material.dart';

import '../scheduling/fsrs.dart';

/// Palette from `planning/mockups-wireframes/.../mobile/`.
abstract final class QyicColors {
  static const background = Color(0xFF15141F);
  static const surface = Color(0xFF1F1C2D);
  static const surfaceElevated = Color(0xFF2A2640);
  static const border = Color(0xFF332F48);

  static const lime = Color(0xFFC8F033);
  static const limeDark = Color(0xFF1A1F0A);

  static const purple = Color(0xFF8B7CF6);
  static const purpleMuted = Color(0xFF6B5AE0);

  static const orange = Color(0xFFF0A43A);
  static const teal = Color(0xFF3ECFA0);
  static const coral = Color(0xFFF0816F);

  static const textPrimary = Color(0xFFEDEBF5);
  static const textSecondary = Color(0xFF9A96AE);
  static const textMuted = Color(0xFF68647D);

  static const success = teal;
  static const successSurface = Color(0xFF173A30);
  static const failure = coral;
  static const failureSurface = Color(0xFF3A1F22);

  static Color forRating(Rating rating) => switch (rating) {
    Rating.again => coral,
    Rating.hard => orange,
    Rating.good => purple,
    Rating.easy => teal,
  };
}

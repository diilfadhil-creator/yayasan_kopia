import 'package:flutter/material.dart';

class AppColors {
  // Primary Palette
  static const Color primary = Color(0xFF00668A);
  static const Color primaryContainer = Color(0xFF29ABE2);
  static const Color onPrimary = Color(0xFFFFFFFF);
  static const Color onPrimaryContainer = Color(0xFF003B53);

  // Secondary Palette
  static const Color secondary = Color(0xFF4F6169);
  static const Color secondaryContainer = Color(0xFFD2E6EF);
  static const Color onSecondary = Color(0xFFFFFFFF);
  static const Color onSecondaryContainer = Color(0xFF55676F);

  // Tertiary / Accent Palette (Lime Accent)
  static const Color tertiary = Color(0xFF5B6300);
  static const Color tertiaryContainer = Color(0xFF9CA821);
  static const Color tertiaryFixed = Color(0xFFDFEC60);
  static const Color onTertiary = Color(0xFFFFFFFF);

  // Neutral & Background Surface
  static const Color background = Color(0xFFF7F9FB);
  static const Color surface = Color(0xFFF7F9FB);
  static const Color surfaceBright = Color(0xFFF7F9FB);
  static const Color surfaceContainerLowest = Color(0xFFFFFFFF);
  static const Color surfaceContainerLow = Color(0xFFF2F4F6);
  static const Color surfaceContainer = Color(0xFFECEEF0);
  static const Color surfaceContainerHigh = Color(0xFFE6E8EA);
  static const Color surfaceVariant = Color(0xFFE0E3E5);
  static const Color outline = Color(0xFF6E7880);
  static const Color outlineVariant = Color(0xFFBDC8D0);

  // Text & On-Surface
  static const Color onBackground = Color(0xFF191C1E);
  static const Color onSurface = Color(0xFF191C1E);
  static const Color onSurfaceVariant = Color(0xFF3E484F);

  // Status Colors
  static const Color error = Color(0xFFBA1A1A);
  static const Color errorContainer = Color(0xFFFFDAD6);

  // Gradient
  static const LinearGradient splashGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF00668A), Color(0xFF29ABE2)],
  );
}

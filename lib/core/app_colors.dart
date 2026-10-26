import 'package:flutter/material.dart';

/// Brand palette shared across light & dark themes.
class AppColors {
  AppColors._();

  static const Color accent = Color(0xFF6C5CE7); // violet
  static const Color accent2 = Color(0xFF00D2FF); // cyan
  static const Color accent3 = Color(0xFFFF6BCB); // pink (subtle highlights)

  static const LinearGradient brandGradient = LinearGradient(
    colors: [accent, accent2],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Dark theme
  static const Color darkBg = Color(0xFF0B0F1A);
  static const Color darkSurface = Color(0xFF131826);
  static const Color darkSurfaceAlt = Color(0xFF1A2032);
  static const Color darkText = Color(0xFFE8ECF5);
  static const Color darkMuted = Color(0xFF8A93A6);
  static const Color darkBorder = Color(0xFF222A3D);

  // Light theme
  static const Color lightBg = Color(0xFFF5F7FB);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightSurfaceAlt = Color(0xFFEEF1F8);
  static const Color lightText = Color(0xFF12182B);
  static const Color lightMuted = Color(0xFF5B6478);
  static const Color lightBorder = Color(0xFFE2E7F1);
}

/// Convenience accessors that resolve to the right color for the active theme.
extension ThemePalette on BuildContext {
  bool get isDark => Theme.of(this).brightness == Brightness.dark;

  Color get surface => isDark ? AppColors.darkSurface : AppColors.lightSurface;
  Color get surfaceAlt =>
      isDark ? AppColors.darkSurfaceAlt : AppColors.lightSurfaceAlt;
  Color get textColor => isDark ? AppColors.darkText : AppColors.lightText;
  Color get muted => isDark ? AppColors.darkMuted : AppColors.lightMuted;
  Color get border => isDark ? AppColors.darkBorder : AppColors.lightBorder;
}

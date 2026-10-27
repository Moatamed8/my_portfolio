import 'package:flutter/material.dart';

/// Brand palette shared across light & dark themes.
class AppColors {
  AppColors._();

  static const Color accent = Color(0xFFD4B483); // champagne gold
  static const Color accent2 = Color(0xFFA68445); // antique bronze
  static const Color accentDeep = Color(
    0xFF8A6428,
  ); // gold that stays readable on ivory
  static const Color onAccent = Color(0xFF1C140A); // ink on gold fills

  static const LinearGradient brandGradient = LinearGradient(
    colors: [Color(0xFFE7D3A1), accent2],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Dark theme — warm black, not blue-black
  static const Color darkBg = Color(0xFF0C0B0A);
  static const Color darkSurface = Color(0xFF161310);
  static const Color darkSurfaceAlt = Color(0xFF211C17);
  static const Color darkText = Color(0xFFF4EFE6);
  static const Color darkMuted = Color(0xFFA89B8C);
  static const Color darkBorder = Color(0xFF2C261F);

  // Light theme — warm paper
  static const Color lightBg = Color(0xFFF6F1E8);
  static const Color lightSurface = Color(0xFFFFFCF7);
  static const Color lightSurfaceAlt = Color(0xFFEFE6D8);
  static const Color lightText = Color(0xFF1A1612);
  static const Color lightMuted = Color(0xFF6E655C);
  static const Color lightBorder = Color(0xFFE4D9C8);
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

  /// Gold used for small text and icons sitting on the page background.
  Color get gold => isDark ? AppColors.accent : AppColors.accentDeep;
}

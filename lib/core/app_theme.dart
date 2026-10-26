import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTheme {
  AppTheme._();

  static const String _font = 'Poppins';

  static ThemeData get dark => _base(
    brightness: Brightness.dark,
    scaffold: AppColors.darkBg,
    surface: AppColors.darkSurface,
    text: AppColors.darkText,
    muted: AppColors.darkMuted,
  );

  static ThemeData get light => _base(
    brightness: Brightness.light,
    scaffold: AppColors.lightBg,
    surface: AppColors.lightSurface,
    text: AppColors.lightText,
    muted: AppColors.lightMuted,
  );

  static ThemeData _base({
    required Brightness brightness,
    required Color scaffold,
    required Color surface,
    required Color text,
    required Color muted,
  }) {
    final base = ThemeData(brightness: brightness, useMaterial3: true);
    return base.copyWith(
      scaffoldBackgroundColor: scaffold,
      canvasColor: scaffold,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.accent,
        brightness: brightness,
        primary: AppColors.accent,
        secondary: AppColors.accent2,
        surface: surface,
      ),
      textTheme: _textTheme(base.textTheme, text, muted),
      splashFactory: NoSplash.splashFactory,
      highlightColor: Colors.transparent,
    );
  }

  static TextTheme _textTheme(TextTheme base, Color text, Color muted) {
    TextStyle s(
      double size,
      FontWeight weight, {
      double? height,
      double? spacing,
      Color? color,
    }) => TextStyle(
      fontFamily: _font,
      fontSize: size,
      fontWeight: weight,
      height: height,
      letterSpacing: spacing,
      color: color ?? text,
    );

    return base
        .copyWith(
          displayLarge: s(64, FontWeight.w700, height: 1.05, spacing: -1),
          displayMedium: s(48, FontWeight.w700, height: 1.1, spacing: -0.5),
          displaySmall: s(36, FontWeight.w600, height: 1.15),
          headlineMedium: s(28, FontWeight.w600, height: 1.2),
          headlineSmall: s(22, FontWeight.w600),
          titleLarge: s(20, FontWeight.w600),
          titleMedium: s(16, FontWeight.w500),
          bodyLarge: s(17, FontWeight.w400, height: 1.6, color: muted),
          bodyMedium: s(15, FontWeight.w400, height: 1.6, color: muted),
          labelLarge: s(14, FontWeight.w500),
        )
        .apply(fontFamily: _font);
  }
}

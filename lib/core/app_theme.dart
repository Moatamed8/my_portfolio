import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTheme {
  AppTheme._();

  static const String display = 'Montserrat';
  static const String body = 'Poppins';

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
      String family,
      double size,
      FontWeight weight, {
      double? height,
      double? spacing,
      Color? color,
    }) => TextStyle(
      fontFamily: family,
      fontSize: size,
      fontWeight: weight,
      height: height,
      letterSpacing: spacing,
      color: color ?? text,
    );

    return base
        .apply(fontFamily: body)
        .copyWith(
          displayLarge: s(
            display,
            64,
            FontWeight.w700,
            height: 1.05,
            spacing: -1,
          ),
          displayMedium: s(
            display,
            48,
            FontWeight.w700,
            height: 1.1,
            spacing: -0.5,
          ),
          displaySmall: s(display, 36, FontWeight.w600, height: 1.15),
          headlineMedium: s(display, 28, FontWeight.w600, height: 1.2),
          headlineSmall: s(display, 22, FontWeight.w600),
          titleLarge: s(display, 20, FontWeight.w600),
          titleMedium: s(display, 16, FontWeight.w500),
          bodyLarge: s(body, 17, FontWeight.w400, height: 1.6, color: muted),
          bodyMedium: s(body, 15, FontWeight.w400, height: 1.6, color: muted),
          labelLarge: s(body, 14, FontWeight.w500),
        );
  }
}

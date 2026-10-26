import 'package:flutter/material.dart';

/// Exposes the current theme mode and a toggle callback to the widget tree.
class ThemeController extends InheritedWidget {
  final bool isDark;
  final VoidCallback toggle;

  const ThemeController({
    super.key,
    required this.isDark,
    required this.toggle,
    required super.child,
  });

  static ThemeController of(BuildContext context) {
    final controller = context
        .dependOnInheritedWidgetOfExactType<ThemeController>();
    assert(controller != null, 'No ThemeController found in context');
    return controller!;
  }

  @override
  bool updateShouldNotify(ThemeController oldWidget) =>
      oldWidget.isDark != isDark;
}

import 'package:flutter/material.dart';

import '../../../core/app_colors.dart';
import '../../../core/theme_controller.dart';

class ThemeToggle extends StatelessWidget {
  const ThemeToggle({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = ThemeController.of(context);
    return IconButton(
      onPressed: controller.toggle,
      tooltip: controller.isDark ? 'Light mode' : 'Dark mode',
      icon: AnimatedSwitcher(
        duration: const Duration(milliseconds: 250),
        transitionBuilder: (child, anim) =>
            RotationTransition(turns: anim, child: child),
        child: Icon(
          controller.isDark
              ? Icons.light_mode_rounded
              : Icons.dark_mode_rounded,
          key: ValueKey(controller.isDark),
          color: context.textColor,
          size: 21,
        ),
      ),
    );
  }
}

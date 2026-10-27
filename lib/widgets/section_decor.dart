import 'package:flutter/material.dart';

import '../core/app_colors.dart';

/// Night-sky photo behind the page in dark mode. Light mode uses the
/// plain scaffold color.
class BackgroundDecor extends StatelessWidget {
  const BackgroundDecor({super.key});

  static const asset = 'assets/images/background.jpg';

  @override
  Widget build(BuildContext context) {
    if (!context.isDark) return const SizedBox.shrink();

    return IgnorePointer(
      child: RepaintBoundary(
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              asset,
              fit: BoxFit.cover,
              alignment: Alignment.center,
              filterQuality: FilterQuality.medium,
            ),
            const DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [Color(0x6B0C0B0A), Color(0x1F0C0B0A)],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

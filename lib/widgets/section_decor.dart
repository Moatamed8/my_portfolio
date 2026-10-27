import 'package:flutter/material.dart';

import '../core/app_colors.dart';

/// Soft, fixed gradient glows behind the whole page. Cheap to paint (static)
/// and adapts to the active theme.
class BackgroundDecor extends StatelessWidget {
  const BackgroundDecor({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDark;
    return IgnorePointer(
      child: Stack(
        children: [
          Positioned(
            top: -180,
            right: -120,
            child: _Blob(
              color: AppColors.accent.withValues(alpha: isDark ? 0.14 : 0.18),
              size: 520,
            ),
          ),
        ],
      ),
    );
  }
}

class _Blob extends StatelessWidget {
  final Color color;
  final double size;
  const _Blob({required this.color, required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(colors: [color, Colors.transparent]),
      ),
    );
  }
}

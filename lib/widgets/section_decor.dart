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
            top: -120,
            right: -100,
            child: _Blob(
              color: AppColors.accent.withValues(alpha: isDark ? 0.22 : 0.16),
              size: 420,
            ),
          ),
          Positioned(
            top: 500,
            left: -140,
            child: _Blob(
              color: AppColors.accent2.withValues(alpha: isDark ? 0.16 : 0.12),
              size: 460,
            ),
          ),
          Positioned(
            bottom: -120,
            right: -80,
            child: _Blob(
              color: AppColors.accent3.withValues(alpha: isDark ? 0.12 : 0.10),
              size: 380,
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
        gradient: RadialGradient(
          colors: [color, Colors.transparent],
        ),
      ),
    );
  }
}

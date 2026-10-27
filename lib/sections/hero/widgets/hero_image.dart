import 'package:flutter/material.dart';

import '../../../core/app_colors.dart';
import '../../../core/responsive.dart';
import '../../../data/portfolio_data.dart';
import 'floating_badge.dart';

class HeroImage extends StatelessWidget {
  const HeroImage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = Responsive.value(context, mobile: 260.0, desktop: 380.0);
    return Center(
      child: SizedBox(
        width: size,
        height: size + 20,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: size,
              height: size,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    AppColors.accent.withValues(alpha: 0.35),
                    AppColors.accent2.withValues(alpha: 0.05),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
            Container(
              width: size * 0.82,
              height: size * 0.82,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: AppColors.brandGradient,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.accent.withValues(alpha: 0.22),
                    blurRadius: 28,
                  ),
                ],
              ),
              padding: const EdgeInsets.all(3),
              child: ClipOval(
                child: Image.asset(
                  PortfolioData.profileImage,
                  fit: BoxFit.cover,
                  errorBuilder: (_, _, _) => Container(
                    color: context.surfaceAlt,
                    alignment: Alignment.center,
                    child: const Text(
                      'MW',
                      style: TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const Positioned(
              top: 4,
              right: 20,
              child: FloatingBadge(label: 'Flutter', emoji: '💙'),
            ),
            const Positioned(
              bottom: 20,
              left: 0,
              child: FloatingBadge(label: '6+ yrs', emoji: '👨‍💻'),
            ),
          ],
        ),
      ),
    );
  }
}

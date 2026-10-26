import 'package:flutter/material.dart';

import '../../../core/app_colors.dart';
import '../../../core/app_theme.dart';
import '../../../data/portfolio_data.dart';

class StatCard extends StatelessWidget {
  final Highlight highlight;
  const StatCard({super.key, required this.highlight});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: context.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: context.border),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: ShaderMask(
              shaderCallback: (r) => AppColors.brandGradient.createShader(r),
              child: Text(
                highlight.value,
                style: const TextStyle(
                  fontFamily: AppTheme.display,
                  fontSize: 40,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  height: 1,
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            highlight.label,
            style: TextStyle(
              fontSize: 13.5,
              fontWeight: FontWeight.w500,
              height: 1.3,
              color: context.muted,
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../../../core/app_colors.dart';
import '../../../core/app_theme.dart';
import '../../../core/responsive.dart';
import '../../../data/portfolio_data.dart';
import 'skill_chip.dart';

class Bio extends StatelessWidget {
  const Bio({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          PortfolioData.aboutHeadline,
          style: TextStyle(
            fontFamily: AppTheme.display,
            fontSize: Responsive.value(context, mobile: 22.0, desktop: 26.0),
            fontWeight: FontWeight.w600,
            height: 1.3,
            color: context.textColor,
          ),
        ),
        const SizedBox(height: 18),
        Text(
          PortfolioData.aboutBody,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        const SizedBox(height: 26),
        Text(
          'Skills & Tools',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            letterSpacing: 1,
            color: context.muted,
          ),
        ),
        const SizedBox(height: 14),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: PortfolioData.skills
              .map((s) => SkillChip(label: s))
              .toList(),
        ),
      ],
    );
  }
}

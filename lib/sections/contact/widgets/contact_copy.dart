import 'package:flutter/material.dart';

import '../../../core/app_theme.dart';
import '../../../core/responsive.dart';
import '../../../data/portfolio_data.dart';

class ContactCopy extends StatelessWidget {
  const ContactCopy({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Let's work together!",
          style: TextStyle(
            color: Colors.white,
            fontFamily: AppTheme.display,
            fontWeight: FontWeight.w700,
            height: 1.2,
            fontSize: Responsive.value(context, mobile: 24.0, desktop: 30.0),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          "Let's work together to turn your idea into a useful, "
          'reliable, and polished product. '
          "Tap below and let's get started.",
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.9),
            fontSize: 15,
            height: 1.6,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.call_rounded, color: Colors.white, size: 18),
            const SizedBox(width: 8),
            Text(
              PortfolioData.phoneDisplay,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 15,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

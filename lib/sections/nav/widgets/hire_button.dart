import 'package:flutter/material.dart';

import '../../../core/app_colors.dart';
import '../../../core/utils.dart';
import '../../../data/portfolio_data.dart';

class HireButton extends StatefulWidget {
  const HireButton({super.key});

  @override
  State<HireButton> createState() => _HireButtonState();
}

class _HireButtonState extends State<HireButton> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: GestureDetector(
        onTap: () => openUrl(PortfolioData.whatsapp),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
          decoration: BoxDecoration(
            gradient: AppColors.brandGradient,
            borderRadius: BorderRadius.circular(11),
            boxShadow: _hover
                ? [
                    BoxShadow(
                      color: AppColors.accent.withValues(alpha: 0.4),
                      blurRadius: 18,
                      offset: const Offset(0, 6),
                    ),
                  ]
                : null,
          ),
          child: const Text(
            'Hire Me',
            style: TextStyle(
              color: AppColors.onAccent,
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }
}

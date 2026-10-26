import 'package:flutter/material.dart';

import '../../../core/app_colors.dart';
import '../../../core/app_theme.dart';
import '../../../data/portfolio_data.dart';

class Logo extends StatelessWidget {
  const Logo({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 38,
          height: 38,
          decoration: BoxDecoration(
            gradient: AppColors.brandGradient,
            borderRadius: BorderRadius.circular(11),
          ),
          alignment: Alignment.center,
          child: const Text(
            'MW',
            style: TextStyle(
              color: Colors.white,
              fontFamily: AppTheme.display,
              fontWeight: FontWeight.w700,
              fontSize: 15,
            ),
          ),
        ),
        const SizedBox(width: 10),
        Text(
          PortfolioData.firstName,
          style: TextStyle(
            fontFamily: AppTheme.display,
            fontWeight: FontWeight.w600,
            fontSize: 17,
            color: context.textColor,
          ),
        ),
      ],
    );
  }
}

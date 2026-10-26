import 'package:flutter/material.dart';

import '../../../core/app_colors.dart';
import '../../../core/app_theme.dart';
import '../../../core/responsive.dart';
import '../../../core/utils.dart';
import '../../../data/portfolio_data.dart';
import '../../../widgets/animated_role.dart';
import '../../../widgets/gradient_button.dart';
import 'social_dot.dart';

class HeroText extends StatelessWidget {
  final VoidCallback onContact;
  const HeroText({super.key, required this.onContact});

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final align = isMobile
        ? CrossAxisAlignment.center
        : CrossAxisAlignment.start;
    final textAlign = isMobile ? TextAlign.center : TextAlign.start;

    return Column(
      crossAxisAlignment: align,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
          decoration: BoxDecoration(
            color: context.surfaceAlt,
            borderRadius: BorderRadius.circular(999),
            border: Border.all(color: context.border),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('👋  ', style: TextStyle(fontSize: 14)),
              Flexible(
                child: Text(
                  PortfolioData.greeting,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: context.muted,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 22),
        Text(
          "I'm ${PortfolioData.name}",
          textAlign: textAlign,
          style: TextStyle(
            fontFamily: AppTheme.display,
            fontWeight: FontWeight.w700,
            height: 1.05,
            letterSpacing: -1,
            fontSize: Responsive.value(context, mobile: 38.0, desktop: 60.0),
            color: context.textColor,
          ),
        ),
        const SizedBox(height: 10),
        DefaultTextStyle(
          style: const TextStyle(),
          child: AnimatedRole(
            roles: PortfolioData.roles,
            style: TextStyle(
              fontFamily: AppTheme.display,
              fontWeight: FontWeight.w600,
              height: 1.1,
              fontSize: Responsive.value(context, mobile: 24.0, desktop: 34.0),
            ),
          ),
        ),
        const SizedBox(height: 22),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 520),
          child: Text(
            PortfolioData.heroTagline,
            textAlign: textAlign,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
        const SizedBox(height: 34),
        Wrap(
          spacing: 16,
          runSpacing: 14,
          alignment: isMobile ? WrapAlignment.center : WrapAlignment.start,
          children: [
            GradientButton(
              label: 'Download CV',
              icon: Icons.download_rounded,
              onTap: () => openUrl(PortfolioData.resume),
            ),
            OutlineButton(
              label: "Let's Talk",
              icon: Icons.arrow_outward_rounded,
              onTap: onContact,
            ),
          ],
        ),
        const SizedBox(height: 34),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: PortfolioData.socials
              .take(5)
              .map((s) => SocialDot(icon: s.icon, url: s.url, label: s.label))
              .toList(),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';

import '../../core/app_colors.dart';
import '../../core/responsive.dart';
import '../../data/portfolio_data.dart';
import '../../widgets/reveal_on_scroll.dart';
import '../../widgets/section_header.dart';
import 'widgets/contact_copy.dart';
import 'widgets/contact_icon.dart';
import 'widgets/start_button.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 22 : 0),
      child: Column(
        children: [
          const RevealOnScroll(
            child: SectionHeader(
              eyebrow: 'Contact',
              title: 'Let’s build something together',
              subtitle:
                  'Have a project, an idea, or an opportunity in mind? '
                  "I'd love to hear about it and discuss how I can help.",
            ),
          ),
          const SizedBox(height: 44),
          RevealOnScroll(
            delay: const Duration(milliseconds: 120),
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(isMobile ? 28 : 48),
              decoration: BoxDecoration(
                color: const Color(0xFF16130F),
                borderRadius: BorderRadius.circular(28),
                border: Border.all(
                  color: AppColors.accent.withValues(alpha: 0.45),
                ),
              ),
              child: Column(
                children: [
                  isMobile
                      ? const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ContactCopy(),
                            SizedBox(height: 24),
                            StartButton(),
                          ],
                        )
                      : const Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(child: ContactCopy()),
                            SizedBox(width: 24),
                            StartButton(),
                          ],
                        ),
                  const SizedBox(height: 32),
                  Divider(color: Colors.white.withValues(alpha: 0.25)),
                  const SizedBox(height: 24),
                  Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 14,
                    runSpacing: 14,
                    children: PortfolioData.socials
                        .map(
                          (s) => ContactIcon(
                            icon: s.icon,
                            url: s.url,
                            label: s.label,
                          ),
                        )
                        .toList(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

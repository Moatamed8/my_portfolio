import 'package:flutter/material.dart';

import '../core/app_colors.dart';
import '../core/responsive.dart';
import '../core/utils.dart';
import '../data/portfolio_data.dart';
import '../widgets/reveal_on_scroll.dart';
import '../widgets/section_header.dart';

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
              title: 'Get in touch',
              subtitle:
                  "Have a project in mind or just want to say hi? "
                  "I'm always open to discussing new ideas.",
            ),
          ),
          const SizedBox(height: 44),
          RevealOnScroll(
            delay: const Duration(milliseconds: 120),
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(isMobile ? 28 : 48),
              decoration: BoxDecoration(
                gradient: AppColors.brandGradient,
                borderRadius: BorderRadius.circular(28),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.accent.withValues(alpha: 0.35),
                    blurRadius: 50,
                    offset: const Offset(0, 24),
                  ),
                ],
              ),
              child: Column(
                children: [
                  isMobile
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const _ContactCopy(),
                            const SizedBox(height: 24),
                            _StartButton(),
                          ],
                        )
                      : Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Expanded(child: _ContactCopy()),
                            const SizedBox(width: 24),
                            _StartButton(),
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
                        .map((s) => _ContactIcon(
                            icon: s.icon, url: s.url, label: s.label))
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

class _ContactCopy extends StatelessWidget {
  const _ContactCopy();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Let's try my service now!",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            height: 1.2,
            fontSize: Responsive.value(context, mobile: 24.0, desktop: 30.0),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          "Let's work together and make everything super useful. "
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

class _StartButton extends StatefulWidget {
  @override
  State<_StartButton> createState() => _StartButtonState();
}

class _StartButtonState extends State<_StartButton> {
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
          transform: Matrix4.translationValues(0, _hover ? -3 : 0, 0),
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: _hover ? 0.25 : 0.12),
                blurRadius: 18,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.chat_rounded, color: AppColors.accent, size: 19),
              SizedBox(width: 9),
              Text(
                'Get Started',
                style: TextStyle(
                  color: AppColors.accent,
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ContactIcon extends StatefulWidget {
  final IconData icon;
  final String url;
  final String label;
  const _ContactIcon(
      {required this.icon, required this.url, required this.label});

  @override
  State<_ContactIcon> createState() => _ContactIconState();
}

class _ContactIconState extends State<_ContactIcon> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: widget.label,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) => setState(() => _hover = true),
        onExit: (_) => setState(() => _hover = false),
        child: GestureDetector(
          onTap: () => openUrl(widget.url),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: _hover ? 1 : 0.18),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              widget.icon,
              size: 20,
              color: _hover ? AppColors.accent : Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
